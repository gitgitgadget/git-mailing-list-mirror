From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-filter-branch.sh: Allow running in bare
 repositories
Date: Wed, 23 Jul 2008 00:27:07 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807230025050.8986@racer>
References: <20080722223710.29084.61373.stgit@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Jul 23 01:28:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLRHB-0001hF-3c
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 01:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758192AbYGVX1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 19:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755077AbYGVX1K
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 19:27:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:56609 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758112AbYGVX1I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 19:27:08 -0400
Received: (qmail invoked by alias); 22 Jul 2008 23:27:06 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp022) with SMTP; 23 Jul 2008 01:27:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+VEOFJsWqVxMBsq5OvZy8JYLowYfDu+unP8JaiQk
	Hd9k7HWcZOeIc4
X-X-Sender: gene099@racer
In-Reply-To: <20080722223710.29084.61373.stgit@localhost>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89564>

Hi,

On Wed, 23 Jul 2008, Petr Baudis wrote:

> Commit 46eb449c restricted git-filter-branch to non-bare repositories
> unnecessarily; git-filter-branch can work on bare repositories just
> fine.

I think this is fine.

> This also fixes suspicious shell boolean expression during a check
> for dirty working tree.

If you are talking about X && Y || Z, it is well established (and should 
not be suspicious to a shell hacker like the creator of Cogito) that Z is 
executed if either X fails, or X succeeds and Y fails.

> +test_expect_success 'rewrite bare repository identically' '
> +	(git config core.bare true && cd .git && git-filter-branch branch)
> +'
> +git config core.bare false

Any reason why this is done outside the test?

Ciao,
Dscho
