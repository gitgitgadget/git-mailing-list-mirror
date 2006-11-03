X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Allow hand-editing of patches before sending
Date: Fri, 03 Nov 2006 03:21:29 -0800
Message-ID: <7vslh0bwsm.fsf@assigned-by-dhcp.cox.net>
References: <20061101090046.1107.81105.stgit@localhost>
	<b0943d9e0611020232x1e343bbco9451c8183c84d68@mail.gmail.com>
	<20061102113631.GA30507@diana.vm.bytemark.co.uk>
	<b0943d9e0611030139i7be9569bh4a29596a768e82a3@mail.gmail.com>
	<20061103095859.GC16721@diana.vm.bytemark.co.uk>
	<20061103100142.GD16721@diana.vm.bytemark.co.uk>
	<20061103102119.GO20017@pasky.or.cz> <454B1BC3.1070203@op5.se>
	<20061103105349.GA18651@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 3 Nov 2006 11:22:08 +0000 (UTC)
Cc: Petr Baudis <pasky@suse.cz>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061103105349.GA18651@diana.vm.bytemark.co.uk> (Karl
	=?iso-8859-1?Q?Hasselstr=F6m's?= message of "Fri, 3 Nov 2006 11:53:49
 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30828>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfx79-0005rX-1j for gcvg-git@gmane.org; Fri, 03 Nov
 2006 12:21:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753227AbWKCLVc convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006 06:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753229AbWKCLVc
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 06:21:32 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:50611 "EHLO
 fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP id S1753227AbWKCLVb
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006
 06:21:31 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061103112130.RYXW22409.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>; Fri, 3
 Nov 2006 06:21:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id iBMa1V0091kojtg0000000 Fri, 03 Nov 2006
 06:21:35 -0500
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Sender: git-owner@vger.kernel.org

Karl Hasselstr=F6m <kha@treskal.com> writes:

> One thing is certain, though: When I sent 8bit-encoded patches from
> StGIT to this list, the vger mail server added headers saying that it
> didn't like 8bit, and had re-encoded the mail (to what, I don't recal=
l
> just now). It warned that in doing so, it had to make assumptions
> about the charset used. The assumption it had made was that the text
> was latin1, which is not so good when it is in fact utf8.
>
> This all just strengthens my belief that StGIT should go to great
> legths to avoid stepping on mail servers' toes.

I wonder if this can be solved by simply reusing the machinery
format-patch already has.  If calling it as a standalone script
does more unnecessary things than what StGIT wants, we should
certainly be able to separate the only necessary part out to
suit StGIT's needs.

