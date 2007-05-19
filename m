From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Teach "delta" attribute to pack-objects.
Date: Sat, 19 May 2007 13:03:47 -0700
Message-ID: <7v4pm8wpgc.fsf@assigned-by-dhcp.cox.net>
References: <11795608912129-git-send-email-junkio@cox.net>
	<11795608922961-git-send-email-junkio@cox.net>
	<56b7f5510705190910h7e5ed03bnbc5a1b9a1369fc9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Dana How" <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 19 22:03:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpV9g-0008Sn-Bi
	for gcvg-git@gmane.org; Sat, 19 May 2007 22:03:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757039AbXESUDt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 16:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759951AbXESUDt
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 16:03:49 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:33630 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757039AbXESUDs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 16:03:48 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070519200347.MCFS2758.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sat, 19 May 2007 16:03:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 183m1X00L1kojtg0000000; Sat, 19 May 2007 16:03:47 -0400
In-Reply-To: <56b7f5510705190910h7e5ed03bnbc5a1b9a1369fc9f@mail.gmail.com>
	(Dana How's message of "Sat, 19 May 2007 09:10:35 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47769>

"Dana How" <danahow@gmail.com> writes:

> ...  But such an attribute should be
> ignored when --stdout is in effect -- it only affects on-disk
> repacking, not packing for transfers, which is why it's named "repack".

Yes -- if we want to have an option to keep objects selectively
left out of packs in loose format, you would need 'repack' which
acts differently between the server-feeding-client case vs
packing-repository case.

Which is a bigger change that I did not want to show in the
quick-and-clean patch, but I would agree we would want both.
