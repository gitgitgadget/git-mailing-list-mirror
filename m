From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Sanitize for_each_reflog_ent()
Date: Sun, 07 Jan 2007 17:46:11 -0800
Message-ID: <7vr6u6z3x8.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0701080158500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Jan 08 02:46:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3jaa-0007Aw-RW
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 02:46:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030428AbXAHBqO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 20:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030430AbXAHBqO
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 20:46:14 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:58755 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030428AbXAHBqN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 20:46:13 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070108014612.GTCC19398.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Sun, 7 Jan 2007 20:46:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 8RlN1W00G1kojtg0000000; Sun, 07 Jan 2007 20:45:23 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701080158500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Mon, 8 Jan 2007 01:59:54 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36217>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> It used to ignore the return value of the helper function; now, it
> expects it to return 0, and stops iteration upon non-zero return
> values; this value is then passed on as the return value of
> for_each_reflog_ent().

Good idea.

> Further, it makes no sense to force the parsing upon the helper
> functions; for_each_reflog_ent() now calls the helper function with
> old and new sha1, the email, the timestamp & timezone, and the message.

Perhaps.  I did it that way deliberately because all existing
users did not have to pay overhead of parsing.

Thanks.  Will queue in 'pu' initially as I do not have much time
to look at it tonight.
