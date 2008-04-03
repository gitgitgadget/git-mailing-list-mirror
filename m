From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Update setup-git-server-over-http.txt based on my
 experience.
Date: Thu, 3 Apr 2008 19:12:46 +0200 (CEST)
Message-ID: <alpine.LSU.1.00.0804031905410.4008@racer.site>
References: <1207241902-4667-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Apr 03 20:13:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhTw7-0003Rt-Ga
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 20:13:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755215AbYDCSMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 14:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755481AbYDCSMh
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 14:12:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:37762 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755215AbYDCSMg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 14:12:36 -0400
Received: (qmail invoked by alias); 03 Apr 2008 18:12:34 -0000
Received: from host86-165-92-90.range86-165.btcentralplus.com (EHLO racer.home) [86.165.92.90]
  by mail.gmx.net (mp026) with SMTP; 03 Apr 2008 20:12:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18xgDtnmaIxOKRj6Jy8TPmYW7k+n0wJc/5JuX7OH5
	aDGS6qw/JtuZWF
X-X-Sender: gene099@racer.site
In-Reply-To: <1207241902-4667-1-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78766>

Hi,

I don't like the commit subject.  At all.

On Thu, 3 Apr 2008, Matthieu Moy wrote:

> -- have git installed at the server _and_ client
> +- have git installed on the client, and preferably on the server

How do you want to initialise the repository on the server, then?  (IOW 
you should mention here that you need a WebDAV client on the client if you 
do not have Git on the server, and that it is way more fiddly.)

> -In effect, this probably means you're going to be root.
> +In effect, this probably means you're going to be root, or that you're
> +using a preconfigured WebDAV server.

Either you strike "probably" or you skip what you added.

> @@ -169,7 +170,8 @@ On Debian:
>  
>     Most tests should pass.
>  
> -A command line tool to test WebDAV is cadaver.
> +A command line tool to test WebDAV is cadaver. If you prefer GUIs,
> +konqueror can open WebDAV URLs as "webdav://..." or "webdavs://...".

What do you do if you have MacOSX, or Windows?

> @@ -179,8 +181,10 @@ http://<servername>/my-new-repo.git [x] Open as webfolder -> login .
>  Step 3: setup the client
>  ------------------------
>  
> -Make sure that you have HTTP support, i.e. your git was built with curl.
> -The easiest way to check is to look for the executable 'git-http-push'.
> +Make sure that you have HTTP support, i.e. your git was built with
> +curl (and a recent enough version).

Say what version.  Otherwise this comment will soon be very, very stale.

> +The easiest way to check is to +look for the executable 
> 'git-http-push'. The command "git http-push" +with no argument should 
> display a usage message.

My search revealed that http-push was in Git since tags/v0.99.9e^2~9^2~4.  
Which is not recent at all.

> @@ -212,6 +216,10 @@ It is important to put the last '/'; Without it, the server will send
>  a redirect which git-http-push does not (yet) understand, and git-http-push
>  will repeat the request infinitely.
>  
> +Also note that the URL should point to the git repository itself, that
> +is, to the '.git/' directory and not the working tree in case the
> +repository is non-bare.

It makes no sense to describe the case of a non-bare repository.

Especially with those many threads on the list these days, describing the 
mess people got into by pushing into non-bare repositories!

> @@ -224,6 +232,13 @@ This pushes branch 'master' (which is assumed to be the branch you
>  want to export) to repository called 'upload', which we previously
>  defined with git-config.
>  
> +Using a proxy:
> +--------------
> +
> +If you have to access the WebDAV server from behind an HTTP(S) proxy,
> +set the variable 'all_proxy' to 'http://proxy-host.com:port', or
> +'http://login-on-proxy:passwd-on-proxy@proxy-host.com:port'. See 'man
> +curl' for details.

You only need http_proxy.

Ciao,
Dscho
