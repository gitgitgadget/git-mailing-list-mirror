X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] (experimental) per-topic shortlog.
Date: Sun, 26 Nov 2006 17:38:31 -0800
Message-ID: <7vejrpr7mw.fsf@assigned-by-dhcp.cox.net>
References: <7v8xhxsopp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611261652520.30076@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 27 Nov 2006 01:38:58 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611261652520.30076@woody.osdl.org> (Linus
	Torvalds's message of "Sun, 26 Nov 2006 17:06:08 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32378>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoVSO-0002TH-5f for gcvg-git@gmane.org; Mon, 27 Nov
 2006 02:38:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755786AbWK0Bid (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 20:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755823AbWK0Bid
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 20:38:33 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:42136 "EHLO
 fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP id S1755786AbWK0Bid
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 20:38:33 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061127013832.INXW296.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>; Sun, 26
 Nov 2006 20:38:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id rdeg1V0161kojtg0000000; Sun, 26 Nov 2006
 20:38:41 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 26 Nov 2006, Junio C Hamano wrote:
>>
>> This implements an experimental "git log-fpc" command that shows
>> short-log style output sorted by topics.
>> 
>> A "topic" is identified by going through the first-parent
>> chains; this ignores the fast-forward case, but for a top-level
>> integrator it often is good enough.
>
> Umm. May I suggest that you try this with the kernel repo too..

Have you?

I've compared 

	gitk HEAD~40..HEAD

and 

	git-log-fpc --no-merges HEAD~40..HEAD

Admittedly, the first group ("from the tip of the master") tends
to be seriously mixed up without a fixed theme (well the theme
appears to be "fix trivial warnings and compilation breakages
not limited to any particular subsystem"), but I find the other
groups quite a sane representation of what actually happened.

My copy of your tree is a bit old (HEAD is at 1abbfb412), but I
see:

 - a two-commit series on MIPS via Ralf Baechle,
 - a four-commit series on ARM via Russel King,
 - a three-commit series on POWERPC via Paul Mackerras,
 - a seventeen-commit series in net/ area via Dave Miller,
 - a three-commit series on x86_64 via Andi Kleen.
 ...

As you said, committer would be a good addition to break a
fast-forward case to make it even better.
