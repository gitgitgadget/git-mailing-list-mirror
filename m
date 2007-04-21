From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 0/4] External 'filter' attributes and drivers
Date: Sat, 21 Apr 2007 03:40:55 -0700
Message-ID: <11771520591529-git-send-email-junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 21 12:41:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfD1j-0004KC-Fy
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 12:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030653AbXDUKlD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 06:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030664AbXDUKlB
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 06:41:01 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:62112 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030653AbXDUKlA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 06:41:00 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070421104100.TMIN1268.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>
          for <git@vger.kernel.org>; Sat, 21 Apr 2007 06:41:00 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id pmgz1W00A1kojtg0000000; Sat, 21 Apr 2007 06:40:59 -0400
X-Mailer: git-send-email 1.5.1.1.948.g9f6f
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45164>

I know this is controversial, but here is a small four patch
series to let you insert arbitrary external filter in checkin
and checkout codepath.

[PATCH 1/4] Simplify calling of CR/LF conversion routines
[PATCH 2/4] convert.c: restructure the attribute checking part.
[PATCH 3/4] lockfile: record the primary process.
[PATCH 4/4] Add 'filter' attribute and external filter driver definition.


[1/4] is Alex's earlier patch, rebased on top of 'next'.

[3/4] is necessary for the series because otherwise 'git add'
would not work with any external filter, but the change is
applicable to 'master'.

[4/4] is the body of the change.  I wanted to like run-command.h
process spawning infrastructure, but I suspect I did not use it
optimally.  People who were more involved in its evolution
hopefully have suggestions for better use of it.
