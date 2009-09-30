From: Matthias Andree <matthias.andree@gmx.de>
Subject: Re: Deciding between Git/Mercurial
Date: Wed, 30 Sep 2009 13:09:10 +0200
Message-ID: <4AC33C56.8060202@gmx.de>
References: <h9nlhj$heq$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: newsgroups@catchall.shelter13.net
X-From: git-owner@vger.kernel.org Wed Sep 30 13:09:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Msx3g-0001aM-36
	for gcvg-git-2@lo.gmane.org; Wed, 30 Sep 2009 13:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753424AbZI3LJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2009 07:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbZI3LJJ
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Sep 2009 07:09:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:41637 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751136AbZI3LJI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2009 07:09:08 -0400
Received: (qmail invoked by alias); 30 Sep 2009 11:09:11 -0000
Received: from balu.cs.uni-paderborn.de (EHLO balu.cs.uni-paderborn.de) [131.234.21.37]
  by mail.gmx.net (mp048) with SMTP; 30 Sep 2009 13:09:11 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX1/YKdU8YrXY2d6VH87s89muZ9n0Orx562VLREJ7cz
	2nc08QbvceiquE
Received: from localhost ([127.0.0.1])
	by balu.cs.uni-paderborn.de with esmtp (Exim 4.69)
	(envelope-from <matthias.andree@gmx.de>)
	id KQS6ZA-0003HK-C9; Wed, 30 Sep 2009 13:09:10 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
In-Reply-To: <h9nlhj$heq$1@ger.gmane.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129337>

Anteru schrieb:

> First of all, what's the matter with git and Windows, is there some
> long-term commitment to make git work on Windows as well as on Linux?
> I'm using msysgit on Windows, and personally I'm happy with it, but my
> co-workers constantly nag that Mercurial has superior portability ...

That tale is told all over, but that doesn't make it truer. I've never had
issues getting a Cygwin version of git to work properly (haven't tried the
msysgit or jgit variants, never felt the need), and integration went smooth.

With Mercurial, getting it integrated with a Windows-native Emacs (Cygwin emacs
doesn't work for me but hangs on startup) was somewhat of an undertaking even
with Cygwin's bash (rather than cmdproxy) underneath Emacs. It boiled down to
building Mercurial with py2exe and create an installer and use the compiled
hg.exe which I find starts rather slowly.

> So far, my key arguments are that git is more robust (more projects
> using it, larger developer base), of course git's excellent performance
> and the much better support for SVN, which is important for us as we can
> slowly migrate from SVN->Git, while hgmercurial is still in the making
> (and Python's SVN->Hg switch is for instance waiting for it).

Yes, but beware of git-svn under Cygwin 1.5 - that works for svn+ssh:// URLs,
but https:// or file:// don't work well because the underdocumented gazillion of
dependencies piece of sh.. called apr does stupid things WRT temporary files
since the Cygwin Subversion 1.6 days. Cygwin's Subversion 1.5 fared better.

I'm not sure about msysgit or jgit projects, but for Cygwin you'll definitely
want to take the plunge and go for Cygwin 1.7 which is still in Beta (because
that allows you to remove a file and create a file with the same name, which
doesn't work with Cygwin 1.5).
