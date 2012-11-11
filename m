From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: RE: Failure using webdav basic auth by git client
Date: Sun, 11 Nov 2012 13:09:02 -0500
Organization: PD Inc
Message-ID: <121F1C4AA6A845229D3DF5808B4F0F9E@black>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "'Pyeron, Jason J CTR \(US\)'" <jason.j.pyeron.ctr@mail.mil>,
	<git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 11 19:09:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXbyF-0000o6-8C
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 19:09:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753298Ab2KKSJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 13:09:08 -0500
Received: from projects.pdinc.us ([67.90.184.26]:45485 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753156Ab2KKSJH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 13:09:07 -0500
Received: from black ([192.168.4.12])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id qABI8tYc028665;
	Sun, 11 Nov 2012 13:08:55 -0500
X-Mailer: Microsoft Office Outlook 11
Thread-Index: Ac296iMSx8P3KgNKTEKEZKDTlBEqXAAnqXiQ
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209431>

I had to munge the body so the list would post it.

See: http://vger.kernel.org/majordomo-taboos.txt



> -----Original Message-----
> From: Pyeron, Jason J CTR (US)
> Sent: Thursday, November 08, 2012 2:49 PM
> To: git@vger.kernel.org
> Subject: Failure using webdav basic auth by git client
> 
> My google fu has failed me on this issue. I am trying to setup http(s)
> repositories for git. If I require authenticated users then git asks
> for a username and password for the first volley of communications, but
> then does not include the Authorization header on subsequent requests.
> 
> Below is the log if I enable username and password BASIC auth in
> Apache.
> 
> user@host /tmp/foo/test
> $ git push origin master
> trace: built-in: git 'push' 'origin' 'master'
> trace: run_command: 'git-remote-http' 'origin'
> 'http://server/git/test/'
> * Couldn't find host server in the .netrc file; using defaults
> * About to connect() to server port 80 (#0)
> *   Trying server...
> * 0x800766e8 is at send pipe head!
> * STATE: CONNECT => WAITCONNECT handle 0x8007f040; (connection #0)
> * Connected to server (server) port 80 (#0)
> * Connected to server (server) port 80 (#0)
> * STATE: WAITCONNECT => DO handle 0x8007f040; (connection #0)
> > GET /git/test/info/refs?service=git-receive-pack HTTP/1.1
> User-Agent: git/1.7.9
> Host: server
> Accept: */*
> Pragma: no-cache
> 
> * STATE: DO => DO_DONE handle 0x8007f040; (connection #0)
> * STATE: DO_DONE => WAITPERFORM handle 0x8007f040; (connection #0)
> * STATE: WAITPERFORM => PERFORM handle 0x8007f040; (connection #0)
> * additional stuff not fine /usr/src/ports/curl/curl-7.27.0-1/src/curl-
> 7.27.0/lib/transfer.c:1037: 0 0
> * The requested URL returned error: 401 Authorization Required
> * Closing connection #0
> Username for 'http://server':
> Password for 'http://test@server':
> * Couldn't find host server in the .netrc file; using defaults
> * About to connect() to server port 80 (#0)
> *   Trying server...
> * 0x800766e8 is at send pipe head!
> * STATE: CONNECT => WAITCONNECT handle 0x8007f9c0; (connection #0)
> * Connected to server (server) port 80 (#0)
> * Connected to server (server) port 80 (#0)
> * STATE: WAITCONNECT => DO handle 0x8007f9c0; (connection #0)
> > GET /git/test/info/refs?service=git-receive-pack HTTP/1.1
> User-Agent: git/1.7.9
> Host: server
> Accept: */*
> Pragma: no-cache
> 
> * STATE: DO => DO_DONE handle 0x8007f9c0; (connection #0)
> * STATE: DO_DONE => WAITPERFORM handle 0x8007f9c0; (connection #0)
> * STATE: WAITPERFORM => PERFORM handle 0x8007f9c0; (connection #0)
> * additional stuff not fine /usr/src/ports/curl/curl-7.27.0-1/src/curl-
> 7.27.0/lib/transfer.c:1037: 0 0
> * HTTP 1.1 or later with persistent connection, pipelining supported
> < HTTP/1.1 401 Authorization Required
> < Date: Fri, 02 Nov 2012 03:11:53 GMT
> < Server: Apache/2.0.52 (CentOS)
> < WWW-Authenticate: Basic realm="Git"
> < Content-Length: 479
> < Connection: close
> < C-o-n-t-e-n-t---T-y-p-e-:- -t-e-x-t-/-h-t-m-l-;-
-c-h-a-r-s-e-t-=-i-s-o---8-8-5-9---1-
> <
> * Closing connection #0
> * Issue another request to this URL:
> 'http://server/git/test/info/refs?service=git-receive-pack'
> * Couldn't find host server in the .netrc file; using defaults
> * About to connect() to server port 80 (#0)
> *   Trying server...
> * 0x800766e8 is at send pipe head!
> * STATE: CONNECT => WAITCONNECT handle 0x8007f9c0; (connection #0)
> * Connected to server (server) port 80 (#0)
> * Connected to server (server) port 80 (#0)
> * STATE: WAITCONNECT => DO handle 0x8007f9c0; (connection #0)
> * Server auth using Basic with user 'test'
> > GET /git/test/info/refs?service=git-receive-pack HTTP/1.1
> Authorization: Basic dGVzdDpwYXNzd29yZA==
> User-Agent: git/1.7.9
> Host: server
> Accept: */*
> Pragma: no-cache
> 
> * STATE: DO => DO_DONE handle 0x8007f9c0; (connection #0)
> * STATE: DO_DONE => WAITPERFORM handle 0x8007f9c0; (connection #0)
> * STATE: WAITPERFORM => PERFORM handle 0x8007f9c0; (connection #0)
> * additional stuff not fine /usr/src/ports/curl/curl-7.27.0-1/src/curl-
> 7.27.0/lib/transfer.c:1037: 0 0
> * HTTP 1.1 or later with persistent connection, pipelining supported
> < HTTP/1.1 200 OK
> < Date: Fri, 02 Nov 2012 03:11:53 GMT
> < Server: Apache/2.0.52 (CentOS)
> < Last-Modified: Thu, 01 Nov 2012 01:32:28 GMT
> < ETag: "714064-0-fdf5a300"
> < Accept-Ranges: bytes
> < Content-Length: 0
> < Connection: close
> < Content-Type: text/plain; charset=UTF-8
> <
> * STATE: PERFORM => DONE handle 0x8007f9c0; (connection #0)
> * Closing connection #0
> * Couldn't find host server in the .netrc file; using defaults
> * About to connect() to server port 80 (#0)
> *   Trying server...
> * 0x800766e8 is at send pipe head!
> * STATE: CONNECT => WAITCONNECT handle 0x80076678; (connection #0)
> * Connected to server (server) port 80 (#0)
> * Connected to server (server) port 80 (#0)
> * STATE: WAITCONNECT => DO handle 0x80076678; (connection #0)
> * Server auth using Basic with user 'test'
> > GET /git/test/HEAD HTTP/1.1
> Authorization: Basic dGVzdDpwYXNzd29yZA==
> User-Agent: git/1.7.9
> Host: server
> Accept: */*
> Pragma: no-cache
> 
> * STATE: DO => DO_DONE handle 0x80076678; (connection #0)
> * STATE: DO_DONE => WAITPERFORM handle 0x80076678; (connection #0)
> * STATE: WAITPERFORM => PERFORM handle 0x80076678; (connection #0)
> * additional stuff not fine /usr/src/ports/curl/curl-7.27.0-1/src/curl-
> 7.27.0/lib/transfer.c:1037: 0 0
> * additional stuff not fine /usr/src/ports/curl/curl-7.27.0-1/src/curl-
> 7.27.0/lib/transfer.c:1037: 0 0
> * HTTP 1.1 or later with persistent connection, pipelining supported
> < HTTP/1.1 200 OK
> < Date: Fri, 02 Nov 2012 03:11:53 GMT
> < Server: Apache/2.0.52 (CentOS)
> < Last-Modified: Thu, 01 Nov 2012 01:23:43 GMT
> < ETag: "704053-17-deaac5c0"
> < Accept-Ranges: bytes
> < Content-Length: 23
> < Connection: close
> < Content-Type: text/plain; charset=UTF-8
> <
> * STATE: PERFORM => DONE handle 0x80076678; (connection #0)
> * Closing connection #0
> trace: run_command: 'http-push' '--helper-status'
> 'http://server/git/test/' 'refs/heads/master:refs/heads/master'
> trace: exec: 'git' 'http-push' '--helper-status'
> 'http://server/git/test/' 'refs/heads/master:refs/heads/master'
> trace: exec: 'git-http-push' '--helper-status'
> 'http://server/git/test/' 'refs/heads/master:refs/heads/master'
> trace: run_command: 'git-http-push' '--helper-status'
> 'http://server/git/test/' 'refs/heads/master:refs/heads/master'
> * Couldn't find host server in the .netrc file; using defaults
> * About to connect() to server port 80 (#0)
> *   Trying server...
> * 0x8006f558 is at send pipe head!
> * STATE: CONNECT => WAITCONNECT handle 0x80077e58; (connection #0)
> * Connected to server (server) port 80 (#0)
> * Connected to server (server) port 80 (#0)
> * STATE: WAITCONNECT => DO handle 0x80077e58; (connection #0)
> > PROPFIND /git/test/ HTTP/1.1
> User-Agent: git/1.7.9
> Host: server
> Accept: */*
> Depth: 0
> Content-Type: text/xml
> Content-Length: 159
> Expect: 100-continue
> 
> * STATE: DO => DO_DONE handle 0x80077e58; (connection #0)
> * STATE: DO_DONE => WAITPERFORM handle 0x80077e58; (connection #0)
> * STATE: WAITPERFORM => PERFORM handle 0x80077e58; (connection #0)
> * additional stuff not fine /usr/src/ports/curl/curl-7.27.0-1/src/curl-
> 7.27.0/lib/transfer.c:1037: 0 0
> * HTTP 1.1 or later with persistent connection, pipelining supported
> < HTTP/1.1 100 Continue
> * additional stuff not fine /usr/src/ports/curl/curl-7.27.0-1/src/curl-
> 7.27.0/lib/transfer.c:1037: 0 0
> * We are completely uploaded and fine
> * The requested URL returned error: 401 Authorization Required
> * Closing connection #0
> * Expire cleared
> error: Cannot access URL http://server/git/test/, return code 22
> fatal: git-http-push failed
> 
> 
> Disabling the auth requirement gives in the apache config, I have the
> full trace (quite long) available for the below upon request:
> 
> user@host /tmp/foo/test
> $ git push origin master
> To http://server/git/test/
>  * [new branch]      master -> master
