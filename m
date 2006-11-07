X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] Convenient support of remote branches in git-checkout
Date: Mon, 06 Nov 2006 18:08:23 -0800
Message-ID: <7v7iy89ffs.fsf@assigned-by-dhcp.cox.net>
References: <200611070026.16425.Josef.Weidendorfer@gmx.de>
	<7vd580azbb.fsf@assigned-by-dhcp.cox.net>
	<200611070225.24956.Josef.Weidendorfer@gmx.de>
	<7vd5809fnh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 7 Nov 2006 02:08:34 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vd5809fnh.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 06 Nov 2006 18:03:46 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31039>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhGO5-0000oT-P9 for gcvg-git@gmane.org; Tue, 07 Nov
 2006 03:08:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753946AbWKGCIZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 21:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753947AbWKGCIZ
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 21:08:25 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:43139 "EHLO
 fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP id S1753946AbWKGCIZ
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 21:08:25 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061107020824.ERGU13992.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>; Mon, 6
 Nov 2006 21:08:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id je8V1V00T1kojtg0000000; Mon, 06 Nov 2006
 21:08:30 -0500
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:
>
>> What do you think about the setup of the default for "git-pull"?
>
> I personally feel that is loading "checkout" with too many
> different things.
>
> It might be easier to maintain in the long term to have a helper
> command 'git-fork' to handle the gory details of forking off
> from an existing branch (merge default setting, branch creation,
> what else will we have next month? ;-) and perhaps automatically
> call it from git-checkout as a short-hand.

Ah, one should never open one's mouth before thinking things
twice and then sleeping on it.

I do not think we want a _new_ command.  It may make sense to
enrich 'git-branch' for that.

If "git-checkout -b" does not use 'git-branch' to create a new
branch in the current code, maybe we should, regardless of the
usability enhancements under discussion.


