From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] apply: fix memory leak in prefix_one()
Date: Mon, 19 Feb 2007 18:39:47 -0800
Message-ID: <7vbqjp3630.fsf@assigned-by-dhcp.cox.net>
References: <7vlkiwsepm.fsf@assigned-by-dhcp.cox.net>
	<7v8xewsd2j.fsf@assigned-by-dhcp.cox.net>
	<20070217232603.GB30839@coredump.intra.peff.net>
	<7vmz3cqs3d.fsf@assigned-by-dhcp.cox.net>
	<20070217233203.GA6014@coredump.intra.peff.net>
	<Pine.LNX.4.64.0702191450580.20368@woody.linux-foundation.org>
	<7vodnp68p8.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702191527320.20368@woody.linux-foundation.org>
	<7vwt2d4s6c.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702191601300.20368@woody.linux-foundation.org>
	<7vps854qf8.fsf@assigned-by-dhcp.cox.net>
	<7vr6sl381i.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702200332090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 20 03:40:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJKvD-0002iR-Pj
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 03:40:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbXBTCjt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 21:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932815AbXBTCjt
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 21:39:49 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:40679 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932812AbXBTCjs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 21:39:48 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070220023949.WGWI21668.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Mon, 19 Feb 2007 21:39:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Refn1W0041kojtg0000000; Mon, 19 Feb 2007 21:39:47 -0500
In-Reply-To: <Pine.LNX.4.63.0702200332090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 20 Feb 2007 03:33:09 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40201>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	This is on top of them.

I am not sure if this is correct.  Don't we do some point
new_name = old_name = blah?
