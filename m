From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Update setup-git-server-over-http.txt based on my
 experience.
Date: Thu, 3 Apr 2008 22:28:29 +0200 (CEST)
Message-ID: <alpine.LSU.1.00.0804032218550.4008@racer.site>
References: <1207241902-4667-1-git-send-email-Matthieu.Moy@imag.fr> <alpine.LSU.1.00.0804031905410.4008@racer.site> <vpqtziimzcp.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Apr 03 23:29:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhWzt-0004Q3-22
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 23:29:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757826AbYDCV21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 17:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757397AbYDCV21
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 17:28:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:54714 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755546AbYDCV2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 17:28:24 -0400
Received: (qmail invoked by alias); 03 Apr 2008 21:28:22 -0000
Received: from host86-165-92-90.range86-165.btcentralplus.com (EHLO racer.home) [86.165.92.90]
  by mail.gmx.net (mp016) with SMTP; 03 Apr 2008 23:28:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ZWqNtzYRZwiJ8lCK5MLmUKHev93d1UNy1ak9Rkz
	QerjY+OgcYAKvu
X-X-Sender: gene099@racer.site
In-Reply-To: <vpqtziimzcp.fsf@bauges.imag.fr>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78783>

Hi,

On Thu, 3 Apr 2008, Matthieu Moy wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > I don't like the commit subject.  At all.
> 
> Well, I can't think of a better one. The patch introduces several minor 
> changes, and I don't think it deserves a real patch serie for each 
> unrelated change.
> 
> Suggestions welcome.

Since your changes are mostly about using WebDAV to copy an empty git 
repository to the server, you could allude to that.

> > On Thu, 3 Apr 2008, Matthieu Moy wrote:
> >
> >> -- have git installed at the server _and_ client
> >> +- have git installed on the client, and preferably on the server
> >
> > How do you want to initialise the repository on the server, then?  
> > (IOW you should mention here that you need a WebDAV client on the 
> > client if you do not have Git on the server, and that it is way more 
> > fiddly.)
> 
> What part of
> 
>  Another
>  option is to generate an empty repository at the client and copy it to
>  the server with a WebDAV client (which is the only option if Git is
>  not installed on the server).
> 
> is unclear ?

It is too long.

-- have git installed on the client

-- have git installed on the server (or if you cannot, get a WebDAV 
   client such as Konqueror, Internet Exploder, etc.)

> >> -In effect, this probably means you're going to be root.
> >> +In effect, this probably means you're going to be root, or that you're
> >> +using a preconfigured WebDAV server.
> >
> > Either you strike "probably" or you skip what you added.
> 
> Why?

Because you do not need to be "root" if WebDAV is preconfigured?

> >> @@ -169,7 +170,8 @@ On Debian:
> >>  
> >>     Most tests should pass.
> >>  
> >> -A command line tool to test WebDAV is cadaver.
> >> +A command line tool to test WebDAV is cadaver. If you prefer GUIs,
> >> +konqueror can open WebDAV URLs as "webdav://..." or "webdavs://...".
> >
> > What do you do if you have MacOSX, or Windows?
> 
> You read messages instead of truncating them if you're on windows.
> 
> I have no idea about MacOSX, but that's not the point of my patch.

Right, but the text you modify is not supposed to be Linux-specific.

> >> -Make sure that you have HTTP support, i.e. your git was built with curl.
> >> -The easiest way to check is to look for the executable 'git-http-push'.
> >> +Make sure that you have HTTP support, i.e. your git was built with
> >> +curl (and a recent enough version).
> >
> > Say what version.  Otherwise this comment will soon be very, very stale.
> >
> >> +The easiest way to check is to +look for the executable 
> >> 'git-http-push'. The command "git http-push" +with no argument should 
> >> display a usage message.
> >
> > My search revealed that http-push was in Git since tags/v0.99.9e^2~9^2~4.  
> > Which is not recent at all.
> 
> Before my patch, the explanation says that you just need to check
> whether you have git-http-push, which is insufficient. With my patch,
> it gives an accurate check. I believe this is an improvement.

Oh?  So a usage message qualifies for "recent enough"?  In that case, 
v0.99.9f is "recent enough".  I find that hardly helpful.

> >> +Also note that the URL should point to the git repository itself, that
> >> +is, to the '.git/' directory and not the working tree in case the
> >> +repository is non-bare.
> >
> > It makes no sense to describe the case of a non-bare repository.
> 
> Actually, it makes no real sense to have a non-bare repository. But I've 
> been bitten by this (I just typed "git init" without --bare, and 
> uploaded it). Since git-http-push gives _very_ bad error messages, it's 
> good to point the user to potential mistakes to help troubleshooting.

If it makes no real sense to have a non-bare repository, why do you even 
_suggest_ what to do in that case?  You should rather say that it makes no 
sense to have a non-bare repository.  And probably add "because a 
http-push will not update the working directory anyway".

> > >> +Using a proxy:
> >> +--------------
> >> +
> >> +If you have to access the WebDAV server from behind an HTTP(S) proxy,
> >> +set the variable 'all_proxy' to 'http://proxy-host.com:port', or
> >> +'http://login-on-proxy:passwd-on-proxy@proxy-host.com:port'. See 'man
> >> +curl' for details.
> >
> > You only need http_proxy.
> 
> What makes you think that?

I use it in msysgit.

(Okay, not for pushing, but for fetching, which technically uses the 
same protocol.)

> (hint: I've been bitten by this too).

The only way I see this could bite you is if curl does not heed http_proxy 
for https:// protocol.

There's another thing.  My curl manpage insists that ALL_PROXY is all 
capital.  Can you clarify?

Ciao,
Dscho
