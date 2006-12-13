X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-add --interactive (wip)
Date: Tue, 12 Dec 2006 21:34:33 -0800
Message-ID: <7v1wn4mk9i.fsf@assigned-by-dhcp.cox.net>
References: <360959.72234.qm@web31809.mail.mud.yahoo.com>
	<200612111147.44964.Josef.Weidendorfer@gmx.de>
	<7vwt4wpytm.fsf@assigned-by-dhcp.cox.net>
	<200612130415.59038.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 13 Dec 2006 05:35:07 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34182>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuMle-0007Md-6z for gcvg-git@gmane.org; Wed, 13 Dec
 2006 06:34:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964938AbWLMFez (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 00:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbWLMFez
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 00:34:55 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:53132 "EHLO
 fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S964938AbWLMFey (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006
 00:34:54 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061213053434.PAIA7494.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>; Wed, 13
 Dec 2006 00:34:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id y5Zv1V00S1kojtg0000000; Wed, 13 Dec 2006
 00:33:56 -0500
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> No. It currently is starting to get useful. With the ability
> to temporarily store away a dirty state of the working directory,
> it really could become very good.

Hmm, a way to easily stash away local changes and restoring
would lead to a system where you can easily stash and unstash
multiple snapshots and switch between them, and such a model
sounds vaguely familiar...

>> > Just as a sidenote: after deciding to not apply hunks, you
>> > lose them in this WIP, as you will find nothing in "unstaged" mode
>> > afterwards :-(
>> 
>> I do not understand this part.  You can 'revert' to match the
>> index to HEAD and run 'patch' to pick what you want again.
>
> I lost my changes in the working directory; there was nothing to
> pick again any more.

That's worrysome.  By design, "git add" should not touch working
tree at all (only read from there), so if you find cases that
violates it that should be fixed; please let me know.
