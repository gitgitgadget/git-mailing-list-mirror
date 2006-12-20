X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] index-pack usage of mmap() is unacceptably slower on many OSes other than Linux
Date: Tue, 19 Dec 2006 16:30:04 -0800
Message-ID: <7vzm9jo1df.fsf@assigned-by-dhcp.cox.net>
References: <86y7p57y05.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612181251020.3479@woody.osdl.org>
	<86r6uw9azn.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612181625140.18171@xanadu.home>
	<86hcvs984c.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612181414200.3479@woody.osdl.org>
	<8664c896xv.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612181511260.3479@woody.osdl.org>
	<Pine.LNX.4.64.0612181906450.18171@xanadu.home>
	<20061219051108.GA29405@thunk.org>
	<Pine.LNX.4.64.0612182234260.3479@woody.osdl.org>
	<Pine.LNX.4.63.0612190930460.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v1wmwtfmk.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0612191027270.18171@xanadu.home>
	<7vk60npv7x.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0612191409500.18171@xanadu.home>
	<Pine.LNX.4.64.0612191148270.3483@woody.osdl.org>
	<4588453A.3060904@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 00:30:22 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, Linus Torvalds <torvalds@osdl.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <4588453A.3060904@garzik.org> (Jeff Garzik's message of "Tue, 19
	Dec 2006 15:02:02 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34870>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwpLX-0002A6-QV for gcvg-git@gmane.org; Wed, 20 Dec
 2006 01:30:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752874AbWLTAaI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 19:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752963AbWLTAaI
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 19:30:08 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:55753 "EHLO
 fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1752874AbWLTAaG (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 19:30:06 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061220003005.VYIG29122.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>; Tue, 19
 Dec 2006 19:30:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id 0oVP1W00h1kojtg0000000; Tue, 19 Dec 2006
 19:29:24 -0500
To: Jeff Garzik <jeff@garzik.org>
Sender: git-owner@vger.kernel.org

Jeff Garzik <jeff@garzik.org> writes:

> If you are going to do this, you have to audit -every- file, to make
> sure git-compat-util.h is -always- the first header.

Will do.
