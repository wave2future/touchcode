#import <Foundation/Foundation.h>

#import "CTCPSocketListener.h"
#import "CHTTPServer.h"
#import "CHTTPConnection.h"
#import "CRoutingHTTPRequestHandler.h"
#import "CNATPMPManager.h"
#import "CBasicAuthHTTPRouter.h"

int main (int argc, const char * argv[])
{
#pragma unused (argc, argv)

NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

CHTTPServer *theHTTPServer = [[[CHTTPServer alloc] init] autorelease];
[theHTTPServer createDefaultSocketListener];

CBasicAuthHTTPRouter *theRequestRouter = [[[CBasicAuthHTTPRouter alloc] init] autorelease];

CRoutingHTTPRequestHandler *theRoutingRequestHandler = [[[CRoutingHTTPRequestHandler alloc] init] autorelease];
theRoutingRequestHandler.router = theRequestRouter;


[theHTTPServer.defaultRequestHandlers addObject:theRoutingRequestHandler];

[theHTTPServer.socketListener start:NULL];

NSURL *theURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%d", [[NSHost currentHost] name], theHTTPServer.socketListener.port]];
[[NSWorkspace sharedWorkspace] openURL:theURL];

[theHTTPServer.socketListener serveForever];

[pool drain];
return 0;
}
