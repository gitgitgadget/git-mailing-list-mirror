X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Merging five months of Linux kernel history
Date: Mon, 30 Oct 2006 00:05:19 -0800
Message-ID: <7vk62ixm80.fsf@assigned-by-dhcp.cox.net>
References: <20061029193228.GR26271@lug-owl.de>
	<7vhcxm274i.fsf@assigned-by-dhcp.cox.net>
	<20061030075002.GT26271@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 30 Oct 2006 08:05:45 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061030075002.GT26271@lug-owl.de> (Jan-Benedict Glaw's message
	of "Mon, 30 Oct 2006 08:50:02 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30486>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeS99-0004nk-5c for gcvg-git@gmane.org; Mon, 30 Oct
 2006 09:05:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932435AbWJ3IFW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 03:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbWJ3IFW
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 03:05:22 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:52721 "EHLO
 fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP id S932435AbWJ3IFU
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 03:05:20 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061030080520.NLLD22409.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>; Mon, 30
 Oct 2006 03:05:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id gY501V0081kojtg0000000 Mon, 30 Oct 2006
 03:05:01 -0500
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Sender: git-owner@vger.kernel.org

Jan-Benedict Glaw <jbglaw@lug-owl.de> writes:

>>         git log ORIG_HEAD..
>
> That's the point--I don't really expect any conflicts, or only a very
> little number of them. Basically, only the Makefiles and the Kconfig
> files do have a chance to conflict.  It's no more than a new arch/
> directory and some drivers.
>
> The hard part will be to figure out all the needed changes in arch
> code, like the IRQ handling rework etc :)

Since you are maintaining your own arch/ and the other in-tree
architectures progressed as common core code did, you would want
to make matching changes to your arch to adjust to the core
changes.

[a big warning in red capital letters: I do not hack kernel]

I suspect you would want to see what _other_ architecture did to
adjust to the changes in the common core code that happened in
the meantime.  How about...

$ git log ORIG_HEAD.. -- arch/$somearch include/asm-$somearch

where $somearch is something that has difference from the
mainstream that is similar to vax, to figure out what other
architectures needed to adjust, perhaps?
