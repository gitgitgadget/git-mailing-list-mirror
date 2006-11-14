X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Rework cvsexportcommit to handle binary files for all cases.
Date: Mon, 13 Nov 2006 22:56:57 -0800
Message-ID: <7vmz6u3492.fsf@assigned-by-dhcp.cox.net>
References: <200611121629.43104.robin.rosenberg@dewire.com>
	<200611132139.25342.robin.rosenberg@dewire.com>
	<7vveli4zxc.fsf@assigned-by-dhcp.cox.net>
	<200611140749.05023.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 14 Nov 2006 06:57:24 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611140749.05023.robin.rosenberg@dewire.com> (Robin
	Rosenberg's message of "Tue, 14 Nov 2006 07:49:04 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31335>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjsET-0005DY-Ub for gcvg-git@gmane.org; Tue, 14 Nov
 2006 07:57:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755445AbWKNG47 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 01:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755447AbWKNG47
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 01:56:59 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:8339 "EHLO
 fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP id S1755445AbWKNG46
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 01:56:58 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061114065657.FHPN18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>; Tue, 14
 Nov 2006 01:56:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id mWx31V00F1kojtg0000000; Tue, 14 Nov 2006
 01:57:04 -0500
To: Robin Rosenberg <robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> tisdag 14 november 2006 01:47 skrev Junio C Hamano:
>>Robin Rosenberg wrote:
>>> I sent a patch earlier, which was not applied, due to imperfections that I 
>>> cannot solve fully. One issue was that patch 2.5.9 was required and hacking 
>>> it to handle binary diffs with spaces would require and even worse kludge,
>>
>>I suspect that we should not be using patch, but instead be
>>using git-apply perhaps with -C option if people want fuzz.
>
> Does git-apply work without a git repo? We're applying patches onto a CVS 
> repo.

I do it during my day job so I know it works.  I have a git
repository that is updated via cvsimport from the central CVS,
with patches of mine managed by StGIT and git.  I export what's
applicable with format-patch, go to a CVS working tree next door
and run git-apply there, and then manually commit the result
into CVS.  In other words, I am doing what cvsexportcommit ought
to be doing by hand.

>> I know this script originally came from southern hemisphere, but
>> I was talking about _western_ hemisphere.  The comment refers to
>> the part of the code the attached patch fixes, which I will
>> apply along with your updated patch.
> Western/nothern, both apply to where I live.

Yes, I noticed that you are east of Greenwich, and NZ is too.

