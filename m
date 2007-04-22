From: Junio C Hamano <junkio@cox.net>
Subject: Today's 'master' leaves .idx/.pack in 0400
Date: Sun, 22 Apr 2007 11:06:18 -0700
Message-ID: <7vmz10nv1h.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vhcrml4wx.fsf@assigned-by-dhcp.cox.net>
	<7v1widrl0o.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0704221019100.9964@woody.linux-foundation.org>
	<7vvefonvdz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Apr 22 20:06:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfgS8-0002F7-9Q
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 20:06:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754293AbXDVSGU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 14:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754299AbXDVSGU
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 14:06:20 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:36899 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754257AbXDVSGT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 14:06:19 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070422180619.MOIO1235.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sun, 22 Apr 2007 14:06:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id qJ6J1W00Z1kojtg0000000; Sun, 22 Apr 2007 14:06:19 -0400
In-Reply-To: <7vvefonvdz.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 22 Apr 2007 10:58:48 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45258>

With recent glibc, mkstemp() creates 0400 file.  Updated
pack-objects uses it in pack/idx writing without fixing this,
hence this problem.

Will have a fix hopefully shortly.
