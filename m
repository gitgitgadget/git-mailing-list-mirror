X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] config option core.showroot to enable showing the diff of the root commit
Date: Thu, 23 Nov 2006 16:18:45 -0800
Message-ID: <7vejrthf2y.fsf@assigned-by-dhcp.cox.net>
References: <200611211341.48862.andyparkins@gmail.com>
	<8aa486160611210609h1c2d229ekf0b5e8aeb4f21f11@mail.gmail.com>
	<slrnem694k.4lm.Peter.B.Baumann@xp.machine.xx>
	<Pine.LNX.4.64.0611210820100.3338@woody.osdl.org>
	<20061121180643.GC7201@pasky.or.cz> <ejvfng$cj6$1@sea.gmane.org>
	<20061121182135.GD7201@pasky.or.cz>
	<7v64d8y4tu.fsf@assigned-by-dhcp.cox.net>
	<slrnemaqt1.esn.Peter.B.Baumann@xp.machine.xx>
	<7virh5khrc.fsf@assigned-by-dhcp.cox.net>
	<slrnemcc0b.ncc.Peter.B.Baumann@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 24 Nov 2006 00:18:55 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32182>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnOmH-0002Wq-Vu for gcvg-git@gmane.org; Fri, 24 Nov
 2006 01:18:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757509AbWKXASr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 19:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757510AbWKXASr
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 19:18:47 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:45717 "EHLO
 fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP id S1757509AbWKXASq
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 19:18:46 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061124001845.LTRL5575.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>; Thu, 23
 Nov 2006 19:18:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id qQJt1V00P1kojtg0000000; Thu, 23 Nov 2006
 19:18:53 -0500
To: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
Sender: git-owner@vger.kernel.org

Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
writes:

>>> I'm not sure if making core.showroot acting on git-diff-tree is the
>>> right thing to do. Please check first bevore applying.
>>
>> I agree that this "use --root by default" belongs to Porcelain
>> layer, not the plumbing.  We would probably want to do this in
>> the same way as we do the color in diff.c::git_diff_ui_config().
>>
> Sorry, but I don't understand. The color handling doesn't look any different
> to me than the handling of the other config entrys. Did I miss something?

"git-diff-tree --color HEAD" (with explicit command line
instruction to color it) still colours its output, but "[diff]
color = auto" in ~/.gitconfig would not affect the coloring.
Hence, "git-diff-tree HEAD" with the configuration entry gives
monochrome.

"git diff HEAD" on the other hand looks at '[diff] color = auto"
and will color its output without being told on the command
line.



