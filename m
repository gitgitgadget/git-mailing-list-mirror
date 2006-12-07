X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: cygwin, 44k files: how to commit only index?
Date: Thu, 07 Dec 2006 14:29:54 -0800
Message-ID: <7vr6vbqqzh.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0612070627r3ff0b394s124d95fbf8084f16@mail.gmail.com>
	<7vd56vtt2g.fsf@assigned-by-dhcp.cox.net>
	<20061207221503.GA4990@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 22:30:11 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061207221503.GA4990@steel.home> (Alex Riesen's message of
	"Thu, 7 Dec 2006 23:15:03 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33641>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsRkc-0007YW-Uu for gcvg-git@gmane.org; Thu, 07 Dec
 2006 23:29:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1163530AbWLGW34 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 17:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163532AbWLGW34
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 17:29:56 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:33226 "EHLO
 fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1163530AbWLGW3z (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 17:29:55 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061207222955.XLUV7494.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>; Thu, 7
 Dec 2006 17:29:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id vyW51V00H1kojtg0000000; Thu, 07 Dec 2006
 17:30:05 -0500
To: Alex Riesen <raa.lkml@gmail.com>
Sender: git-owner@vger.kernel.org

fork0@t-online.de (Alex Riesen) writes:

> But aside from me trying ignoreState, can anyone help me with that
> question regarding checking if the index is any different from HEAD?

Comparing index and HEAD should be cheap on a system with slow
lstat(), I think, as "git-diff-index --cached HEAD" should just
ignore the working tree altogether.  Is that what you want?
