From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] prune: --expire=time
Date: Sun, 21 Jan 2007 18:06:41 -0800
Message-ID: <7vwt3fx1am.fsf@assigned-by-dhcp.cox.net>
References: <7vy7o0klt1.fsf@assigned-by-dhcp.cox.net>
	<20070119034404.GA17521@spearce.org>
	<20070119104935.GA5189@moooo.ath.cx>
	<7vfya6hll3.fsf@assigned-by-dhcp.cox.net>
	<20070120111832.GA30368@moooo.ath.cx>
	<7vlkjw50nl.fsf@assigned-by-dhcp.cox.net>
	<20070121103724.GA23256@moooo.ath.cx>
	<7vejpo39zg.fsf@assigned-by-dhcp.cox.net>
	<20070121220114.GA24729@coredump.intra.peff.net>
	<45B415B1.30407@midwinter.com>
	<20070122015252.GA26934@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 03:06:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8oa5-0007Nc-U1
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 03:06:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbXAVCGn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 21:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751875AbXAVCGm
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 21:06:42 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:34213 "EHLO
	fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873AbXAVCGm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 21:06:42 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070122020641.UXHN18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Sun, 21 Jan 2007 21:06:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id E26z1W00V1kojtg0000000; Sun, 21 Jan 2007 21:06:59 -0500
To: Jeff King <peff@peff.net>
In-Reply-To: <20070122015252.GA26934@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 21 Jan 2007 20:52:52 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37385>

Jeff King <peff@peff.net> writes:

> I was a bit loose with my phrase 'commit operation'. What I really mean
> is:
>
> $ git add file   ;# (1)
> $ hack hack hack ;# (2)
> $ git commit     ;# (3)
>
> After step (1), you have a blob in your db. If you already had that
> blob, then you have the old blob. You don't get the updated tree and
> commit until step (3). Step (2) can be hours or days. Do you really want
> to lock the repository that long?

This case does not need any locking, as blobs reachable from
index are considered as "reachable" for the purpose of pruning.
