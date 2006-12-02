X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] move Git.pm build instructions into perl/Makefile
Date: Sat, 02 Dec 2006 15:46:20 -0800
Message-ID: <7vvektyi7n.fsf@assigned-by-dhcp.cox.net>
References: <20061121225911.GA24201@steel.home>
	<81b0412b0611300827h64722fa0i7e32808994a97a51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 2 Dec 2006 23:46:37 +0000 (UTC)
Cc: "Alex Riesen" <fork0@t-online.de>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <81b0412b0611300827h64722fa0i7e32808994a97a51@mail.gmail.com>
	(Alex Riesen's message of "Thu, 30 Nov 2006 17:27:34 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33067>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqeZ0-0008Nl-2F for gcvg-git@gmane.org; Sun, 03 Dec
 2006 00:46:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936593AbWLBXqZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 18:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936597AbWLBXqZ
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 18:46:25 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:16778 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S936593AbWLBXqY
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 18:46:24 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061202234621.NFKZ18207.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Sat, 2
 Dec 2006 18:46:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id tzmW1V00X1kojtg0000000; Sat, 02 Dec 2006
 18:46:31 -0500
To: "Alex Riesen" <raa.lkml@gmail.com>
Sender: git-owner@vger.kernel.org

"Alex Riesen" <raa.lkml@gmail.com> writes:

> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
>
> ---
>
> This is the first patch, just rebased upon current master.
> The ActiveState-related parts follow

Huh?

Ah, attachment that is not inline.

diff --git a/perl/.gitignore b/perl/.gitignore
index e990cae..98b2477 100644
--- a/perl/.gitignore
+++ b/perl/.gitignore
@@ -1,4 +1,5 @@
-Makefile
+perl.mak
+perl.mak.old
 blib
 blibdirs
 pm_to_blib

This, and perl/Makefile not cleaning perl.mak.old, are wrong.
"make && make clean" after a fresh checkout should leave the
working tree the same state is it were.
