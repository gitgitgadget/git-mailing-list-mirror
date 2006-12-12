X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Colourise git-branch output
Date: Mon, 11 Dec 2006 21:07:21 -0800
Message-ID: <7vejr5zoqe.fsf@assigned-by-dhcp.cox.net>
References: <200612112210.08327.andyparkins@gmail.com>
	<BAYC1-PASMTP114CF00792AB16B95C1597AED70@CEZ.ICE>
	<7v7iwx2a0z.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP092A9E80667F373BF69AA6AED70@CEZ.ICE>
	<Pine.LNX.4.64.0612111936240.6452@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 12 Dec 2006 05:07:34 +0000 (UTC)
Cc: Sean <seanlkml@sympatico.ca>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0612111936240.6452@woody.osdl.org> (Linus
	Torvalds's message of "Mon, 11 Dec 2006 19:39:58 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34061>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtzrW-00021o-0h for gcvg-git@gmane.org; Tue, 12 Dec
 2006 06:07:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751155AbWLLFHY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 00:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWLLFHY
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 00:07:24 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:33261 "EHLO
 fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751155AbWLLFHX (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006
 00:07:23 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061212050722.ECLU29122.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>; Tue, 12
 Dec 2006 00:07:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id xh7Z1V00H1kojtg0000000; Tue, 12 Dec 2006
 00:07:34 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Mon, 11 Dec 2006, Sean wrote:
>> 
>> Technically it is workable.. but why even start down the road of having
>> anything but branch names after a "branch."?   There has to be a better
>> spot for this variable, and it makes it more future proof, as you
>> highlighted.
>
> I do agree with Sean, both for the stability reason, but perhaps even more 
> because I personally think it would just be better to have a separate 
> "[color]" subsection.
>
> In fact, I'd almost prefer to see
>
> 	[color]
> 		diff = auto
>
> over
>
> 	[diff]
> 		color = auto
>
> exactly because once we have different things that take colorization 
> arguments, it's just nicer to have them all together (and we already have 
> "status", and now we're getting "branch" too.

I tend to agree.  We probably should start deprecating
diff.color and diff.color.<stuff> and swap them around,
like this:

	[color]
        	diff = auto
                branch = auto
                # it begs "* = auto" entry perhaps...
	[color.diff]
        	old = red
                new = green
	[color.branch]
        	remote = purple

