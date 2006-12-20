X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Change in git-svn dcommit semantics?
Date: Tue, 19 Dec 2006 17:17:17 -0800
Message-ID: <7v3b7bnz6q.fsf@assigned-by-dhcp.cox.net>
References: <m2mz5jegka.fsf@ziti.local>
	<94FF72E0-F8BD-4773-803E-F179754BF0ED@silverinsanity.com>
	<Pine.LNX.4.63.0612200053550.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<C2881A17-27F7-467C-B353-189BB7DBFD1E@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 01:17:26 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Seth Falcon <sethfalcon@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <C2881A17-27F7-467C-B353-189BB7DBFD1E@silverinsanity.com> (Brian
	Gernhardt's message of "Tue, 19 Dec 2006 19:38:58 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34884>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gwq5C-0000tR-L8 for gcvg-git@gmane.org; Wed, 20 Dec
 2006 02:17:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932815AbWLTBRU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 20:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932821AbWLTBRT
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 20:17:19 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:59605 "EHLO
 fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932815AbWLTBRT (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 20:17:19 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061220011718.FAIP15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>; Tue, 19
 Dec 2006 20:17:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id 0pGc1W00i1kojtg0000000; Tue, 19 Dec 2006
 20:16:37 -0500
To: Brian Gernhardt <benji@silverinsanity.com>
Sender: git-owner@vger.kernel.org

Brian Gernhardt <benji@silverinsanity.com> writes:

> And is there an easier way to find these things than "git rev-list
> HEAD | git diff-tree -r -s --stdin -SCOLLISION | xargs git show"?  I
> cobbled that together from poking around inside gitk (which mostly
> works in OS X, but has some issues that make me prefer the command
> line).

I typically do:

	git log --full-diff -p -SCOLLISION

The --full-diff option helps because it shows the diff for other
files (that do not have different number of substring COLLISION
in the pre and postimage) in the same commit as well.

