From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/4] Add 'filter' attribute and external filter driver  definition.
Date: Sun, 22 Apr 2007 10:42:00 -0700
Message-ID: <7v4pn8paqf.fsf@assigned-by-dhcp.cox.net>
References: <11771520591529-git-send-email-junkio@cox.net> <11771520591703-gi
	t-send-email-junkio@cox.net>
	<Pine.LNX.4.63.0704211821560.5655@qynat.qvtvafv gr.pbz>
	<7v4pn8rk8t.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0704220202550.5946@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Lang <david.lang@digitalinsight.com>
X-From: git-owner@vger.kernel.org Sun Apr 22 19:42:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hfg4g-0000d4-Va
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 19:42:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753170AbXDVRmH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 13:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753188AbXDVRmG
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 13:42:06 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:53270 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753170AbXDVRmF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 13:42:05 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070422174200.KBUY1271.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sun, 22 Apr 2007 13:42:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id qHi01W00V1kojtg0000000; Sun, 22 Apr 2007 13:42:01 -0400
In-Reply-To: <Pine.LNX.4.63.0704220202550.5946@qynat.qvtvafvgr.pbz> (David
	Lang's message of "Sun, 22 Apr 2007 02:09:54 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45253>

David Lang <david.lang@digitalinsight.com> writes:

>> The conversion is not about overriding the mode bits recorded in
>> tree objects, nor making git as a replacement for build procedure.
>
> what build procedures?
>
> I'm talking about doing things like managing files in /etc

That's exactly what "build procedure" is about.  Nobody sane
should be managing /etc files *directly* under any SCM.  A saner
practice is to have a separate source area with Makefile to
regenerate /etc files, so that (1) "make" manages the target
host specific customizations, (2) "make diff" can be used to
compare and sanity check the result of "make" against what is
currently installed under /etc, and (3) "make install" manages
the permission bits.  The same applies to dotfiles under $HOME/.
