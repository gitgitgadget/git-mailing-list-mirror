X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: WARNING: THIS PATCH CAN BREAK YOUR REPO, was Re: [PATCH 2/3] Only repack active packs by skipping over kept packs.
Date: Mon, 30 Oct 2006 13:59:03 -0800
Message-ID: <7v3b95wjmg.fsf@assigned-by-dhcp.cox.net>
References: <20061029093754.GD3847@spearce.org>
	<Pine.LNX.4.64.0610301332440.11384@xanadu.home>
	<20061030202611.GA5775@spearce.org>
	<20061030205200.GA20236@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 30 Oct 2006 22:05:00 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061030205200.GA20236@delft.aura.cs.cmu.edu> (Jan Harkes's
	message of "Mon, 30 Oct 2006 15:52:00 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30533>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gef9z-0002Vh-9W for gcvg-git@gmane.org; Mon, 30 Oct
 2006 22:59:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422674AbWJ3V7H (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 16:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422672AbWJ3V7G
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 16:59:06 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:42657 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S1422674AbWJ3V7F
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 16:59:05 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061030215904.JMVZ22977.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>; Mon, 30
 Oct 2006 16:59:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id glyk1V00L1kojtg0000000 Mon, 30 Oct 2006
 16:58:45 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Jan Harkes <jaharkes@cs.cmu.edu> writes:

> The following patch does fix the problem Nicolas reported, but for some
> reason I'm still getting only 102 objects (only tags and the commits
> they refer to?) with your test.

One potential downside of this is that this makes an obscure but
useful "gitk --unpacked" useless (robs performance).

http://thread.gmane.org/gmane.comp.version-control.git/19197/focus=19207

But other than that, I think it is an Ok change.  The original
semantics of --unpacked (with or without "pretend as if objects
in this pack are loose") were, eh, "strange".

