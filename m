X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: VCS comparison table
Date: Thu, 26 Oct 2006 02:33:08 -0700
Message-ID: <7vu01ro20b.fsf@assigned-by-dhcp.cox.net>
References: <45357CC3.4040507@utoronto.ca>
	<20061021130111.GL75501@over-yonder.net> <453F2FF8.2080903@op5.se>
	<200610251146.06116.jnareb@gmail.com>
	<a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com>
	<87slhcz8zh.wl%cworth@cworth.org>
	<a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 26 Oct 2006 09:33:25 +0000 (UTC)
Cc: bazaar-ng@lists.canonical.com, "Carl Worth" <cworth@cworth.org>,
	"Matthew D. Fuller" <fullermd@over-yonder.net>,
	"Linus Torvalds" <torvalds@osdl.org>,
	"Andreas Ericsson" <ae@op5.se>, git@vger.kernel.org,
	"Jakub Narebski" <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com>
	(James Henstridge's message of "Thu, 26 Oct 2006 16:52:39 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30166>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd1bu-0002Yo-SP for gcvg-git@gmane.org; Thu, 26 Oct
 2006 11:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422954AbWJZJdL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 05:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422942AbWJZJdL
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 05:33:11 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:15002 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S1422958AbWJZJdK
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 05:33:10 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061026093309.WFZC6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>; Thu, 26
 Oct 2006 05:33:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id exYr1V00F1kojtg0000000 Thu, 26 Oct 2006
 05:32:52 -0400
To: "James Henstridge" <james@jamesh.id.au>
Sender: git-owner@vger.kernel.org

"James Henstridge" <james@jamesh.id.au> writes:

> Can you really just rely on equal revision IDs meaning you have the
> same code though?

If you two have the same commit that is a guarantee that you two
have identical trees.  The reverse is not true as logic 101
would teach ;-).

Doing fast-forward instead of doing a "useless" merges helps
somewhat but not in cases like two people merging the same
branches the same way or two people applying the same patch on
top of the same commit.  You need to compare tree object IDs for
that.

>> In bzr, the only answer I'm hearing is attempting a merge to see if it
>> introduces any changes. (I'm deliberately avoiding "pull" since we're
>> talking about distributed cases here).
>
> Or run "bzr missing".  If the sole missing revision is a merge (and
> not the revisions introduced by the merge), you could assume that you
> have the same tree state.

Is it "you could assume" or "it is guaranteed"?  If former, what
kind of corner cases could invalidate that assumption?

