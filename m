From: Junio C Hamano <junkio@cox.net>
Subject: git-mailinfo munges the patch?
Date: Thu, 29 Mar 2007 13:18:51 -0700
Message-ID: <7v1wj74xck.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Don Zickus <dzickus@redhat.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 22:18:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HX15E-0008FB-Fj
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 22:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030657AbXC2USx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 16:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030667AbXC2USx
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 16:18:53 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:36235 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030657AbXC2USw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 16:18:52 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070329201852.BQXD28126.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Thu, 29 Mar 2007 16:18:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id gkJr1W00T1kojtg0000000; Thu, 29 Mar 2007 16:18:52 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43466>

I noticed that the new mailinfo when splitting a message into
cover letter and the patch text seems to munge the patch text,
applying the same "if content-type is not there then assume
latin-1 and recode to utf-8" logic that is applied to the commit
log message.  That munging should not be done to the patch text,
and it appears the current code botches it.

I am a bit too busy with day job today and haven't had a chance
to look into this problem fully, but 1.5.0.3 does not seem to
have this problem but post 87ab7992 mailinfo is problematic.
