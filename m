X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] git-split: Split the history of a git repository by subdirectories and ranges
Date: Tue, 24 Oct 2006 19:13:57 -0700
Message-ID: <7viri9f8gq.fsf@assigned-by-dhcp.cox.net>
References: <451A30E4.50801@freedesktop.org>
	<7vlko5d3bx.fsf@assigned-by-dhcp.cox.net>
	<453C96C9.4010005@freedesktop.org>
	<Pine.LNX.4.64.0610230846420.3962@g5.osdl.org>
	<453D17B5.6070203@freedesktop.org>
	<7vu01tfe6u.fsf@assigned-by-dhcp.cox.net>
	<453EC505.7060807@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 25 Oct 2006 02:14:10 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <453EC505.7060807@freedesktop.org> (Josh Triplett's message of
	"Tue, 24 Oct 2006 18:59:33 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30025>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcYHK-0005AR-8q for gcvg-git@gmane.org; Wed, 25 Oct
 2006 04:14:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422872AbWJYCN7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 24 Oct 2006
 22:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422875AbWJYCN7
 (ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 22:13:59 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:41138 "EHLO
 fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP id S1422872AbWJYCN6
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 22:13:58 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061025021358.WAXV18985.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>; Tue, 24
 Oct 2006 22:13:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id eSDh1V00G1kojtg0000000 Tue, 24 Oct 2006
 22:13:41 -0400
To: Josh Triplett <josh@freedesktop.org>
Sender: git-owner@vger.kernel.org

Josh Triplett <josh@freedesktop.org> writes:

> Junio C Hamano wrote:
>
>> The only thing left for us to decide is if reporting the true
>> parenthood like the current --pretty=raw makes sense (if so we
>> need to keep it and introduce --pretty=rawfish).
>> 
>> The only in-tree user of --pretty=raw seems to be git-svn but it
>> only looks at path-unlimited log/rev-list from one given commit,
>> so the only difference between dumping what is recorded in the
>> commit object and listing what parents we _think_ the commit has
>> is what we read from grafts.  I think we are safe to just "fix"
>> the behaviour of --pretty=raw
>
> I actually think I want to look further into the idea of just using git
> --pretty=raw --parents -- $project, and see if I can find any corner cases
> where it generates a different history than what we want.

I do not mind _coding_ the --pretty=rawfish change if needed but
I do not think it is necessary, which is pretty good news.

After I wrote the message I realized that I probably do not have
to do anything, since --parents would give you the rewritten
parents already anyway.
