From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git log -S doesn't search stash WIPs
Date: Fri, 8 Feb 2008 12:18:30 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802081208580.11591@racer.site>
References: <57518fd10802080246p4a929b62tc6e260a16d3587@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 13:18:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNSC2-00061w-Nf
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 13:18:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756362AbYBHMSZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 07:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755172AbYBHMSZ
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 07:18:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:38483 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753814AbYBHMSY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 07:18:24 -0500
Received: (qmail invoked by alias); 08 Feb 2008 12:18:22 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp025) with SMTP; 08 Feb 2008 13:18:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19xHqxkRbxxRkVr/Cz47suKF+IX28l1frmp48SeoR
	nVdvuC8xHz0Zg3
X-X-Sender: gene099@racer.site
In-Reply-To: <57518fd10802080246p4a929b62tc6e260a16d3587@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73081>

Hi,

On Fri, 8 Feb 2008, Jonathan del Strother wrote:

> "git log --all -Sfoo" doesn't find strings introduced in stash WIP
> commits, only the stash index.

It is a little unfortunate that a stash will do this:

HEAD ------- stash
    \       /
      index

In other words, the index will be "committed" as a regular commit, but the 
working directory will actually be a "merge commit".

So you need to add "--cc" to see the commit.

Further, the stash is not just a branch.  The stash is actually a stack of 
reflogs.  So could you try again, with

	$ git log --cc -Sfoo --walk-reflogs stash

?

Hth,
Dscho
