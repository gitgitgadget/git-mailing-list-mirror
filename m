From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git cherry-pick before archive
Date: Fri, 11 Jul 2008 16:51:03 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807111649290.8950@racer>
References: <6dbd4d000807110846m2921ddb9r88eb3986762b8f81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Denis Bueno <dbueno@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 17:52:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHKuj-0004X0-RK
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 17:52:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752964AbYGKPvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 11:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbYGKPvH
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 11:51:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:45923 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751482AbYGKPvG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 11:51:06 -0400
Received: (qmail invoked by alias); 11 Jul 2008 15:51:03 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp014) with SMTP; 11 Jul 2008 17:51:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/VmZcPsknVVQzdJOm1IBxVqSJwKhzFJDNg52tBE7
	p6XpwVcMAZxKyH
X-X-Sender: gene099@racer
In-Reply-To: <6dbd4d000807110846m2921ddb9r88eb3986762b8f81@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88133>

Hi,

On Fri, 11 Jul 2008, Denis Bueno wrote:

> I'm trying to use git archive to create a kind of "release" tarball of
> my source.  I've got a patch (a commit) that I'd like to apply to the
> tree before I call git archive on HEAD.  Currently my command is:
> 
>     git archive --format=tar --prefix=pfx/ HEAD | gzip > prj.tgz
> 
> If I were to actually modify my tree & history, I'd change the command to:
> 
>     git cherry-pick 97a1235ce674f7cf4df3129cd0ab1ae0793db392
>     git archive --format=tar --prefix=pfx/ HEAD | gzip > prj.tgz
>     git reset --hard HEAD^
> 
> But I'd rather not modify my history, if it's possible.  (This will
> create a bunch of dangling commit objects over time, no?)

$ git cherry-pick -n <bla>
$ git archive --format=tar --prefix=pfx/ $(git write-tree) | gzip > prj.tgz
$ git reset

Hth,
Dscho
