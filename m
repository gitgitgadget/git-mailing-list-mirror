From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Windows support
Date: Thu, 26 Jul 2007 16:43:01 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707261638100.14781@racer.site>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com> 
 <7v6447bxc1.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.64.0707260614500.14781@racer.site>
  <46A8378A.6050201@xs4all.nl>  <Pine.LNX.4.64.0707260737170.14781@racer.site>
  <f329bf540707260002p117937tc9bc70050ef87838@mail.gmail.com> 
 <fcaeb9bf0707260429l327f446bq73a8a0a13cd77cf1@mail.gmail.com> 
 <46d6db660707260521u15c2bd85j806d48e0f51a3b9@mail.gmail.com> 
 <fcaeb9bf0707260537y4233abaamadf4cb6190ea0eeb@mail.gmail.com> 
 <Pine.LNX.4.64.0707261534550.14781@racer.site>
 <fcaeb9bf0707260807u476719e3rec2dcf5f780013c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 17:43:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE5Um-0001SZ-L4
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 17:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757329AbXGZPnK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 11:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756955AbXGZPnJ
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 11:43:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:56627 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756259AbXGZPnI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 11:43:08 -0400
Received: (qmail invoked by alias); 26 Jul 2007 15:43:04 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp051) with SMTP; 26 Jul 2007 17:43:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/+CqlNh4L+ym4QQ/NL/cEte9IzJgvpTT0wEVShqo
	LF+qV+JTkOKcVC
X-X-Sender: gene099@racer.site
In-Reply-To: <fcaeb9bf0707260807u476719e3rec2dcf5f780013c0@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53840>

Hi,

On Thu, 26 Jul 2007, Nguyen Thai Ngoc Duy wrote:

> I make MinGW busybox part of git for some reasons:
> 
> - Making a full MinGW busybox would take lots of time. I don't need
> busybox for Windows. What I need is a shell and enough POSIX utilities
> to run git shell scripts without any dependencies. Windows users
> (including myself when I have to use Windows) hate dependencies.

I think that if you succeed to compile ash on MinGW, the rest is easy.

> - I don't want MinGW busybox to be used outside of git (if it is
> installed separated from git), there are cygwin and msys already. I
> don't want to compete them. And I don't like conflicts (not sure
> though) because you have multiple UNIX emulations on the same system.

But you'd be my hero.

Installing Cygwin is often overkill if all I need is just a tiny shell 
with just enough POSIX tools to run my scripts.

Installing MinGW is painful.  Not because of MinGW, but because there is 
no single installer for all I want.  You need to install MinGW, MSYS, MSYS 
DTK, iconv, bash (because the default is to old), etc. etc.

With busybox it would be busybox.exe.

> - Making ash part of git has an advantage that you could tune the
> shell to fit git. Earlier you had to replace find/sort with
> /usr/bin/find and /usr/bin/sort in git scripts to avoid Windows
> alternatives. I don't like that. If you have control over the shell,
> you could make it ignore whatever program out there and use your own
> ones. This one is not a strong point though.

I doubt that this is useful.  We do want to support the other systems as 
well, so we have to kinda stick with the available workarounds.

> - MinGW busybox (or gitbox as I call it now) utilizes compat/mingw.c
> and other stuff like run-command.c... Making it separate (as source
> code) duplicates code for nothing.

It is not duplication.  It is forking.  Which is a good thing.

> - If you meant separating from git.exe binary, not from source code,
> then it's ok.

Yes.  Although I see your point in making it a builtin "git-ash" that can 
be called without an extra fork(), using beginthread instead.

Ciao,
Dscho
