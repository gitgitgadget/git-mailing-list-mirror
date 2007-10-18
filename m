From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG] git remote add failure
Date: Thu, 18 Oct 2007 17:09:18 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710181708230.25221@racer.site>
References: <1192697719.31199.1216526739@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Guido Ostkamp <git@ostkamp.fastmail.fm>
X-From: git-owner@vger.kernel.org Thu Oct 18 18:09:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiXwM-0001Kl-UP
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 18:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755618AbXJRQJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 12:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756214AbXJRQJc
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 12:09:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:36887 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751538AbXJRQJb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 12:09:31 -0400
Received: (qmail invoked by alias); 18 Oct 2007 16:09:29 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp028) with SMTP; 18 Oct 2007 18:09:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Q4RorLDVQvfIZ4bsyFUNSO0UMSmjZTjggGjDeMV
	YJoWi5PHARMNK6
X-X-Sender: gene099@racer.site
In-Reply-To: <1192697719.31199.1216526739@webmail.messagingengine.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61540>

Hi,

On Thu, 18 Oct 2007, Guido Ostkamp wrote:

> I think I've found a bug in "git remote add". I tried the following:
> 
> $ git remote add -f spearce2 http://repo.or.cz/git/spearce.git
> Cannot get the repository state from http://repo.or.cz/git/spearce.git
> fetch spearce2: command returned error: 1
> 
> Obviously I used the wrong URI. Then I tried again:
> 
> $ git remote add -f spearce2 http://repo.or.cz/r/git/spearce.git
> remote spearce2 already exists.
> 
> I think Git should not store the bad info and block the name when the
> first call wasn't successfull.

The problem there is of course that the fetch could fail because you are 
offline.  In that case, you do not want git remote to throw the 
information away.

BTW you missed the trailing slash in the HTTP URL, I guess.

Ciao,
Dscho
