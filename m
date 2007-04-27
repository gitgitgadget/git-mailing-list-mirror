From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 0/2] Fixing up names in blame output.
Date: Fri, 27 Apr 2007 00:54:15 -0700
Message-ID: <11776604573799-git-send-email-junkio@cox.net>
Cc: Andrew Ruder <andy@aeruder.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 27 09:54:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhLHb-0008Ae-8r
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 09:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755459AbXD0HyT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 03:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755463AbXD0HyT
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 03:54:19 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:64001 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755459AbXD0HyS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 03:54:18 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070427075417.CTUM22040.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Fri, 27 Apr 2007 03:54:17 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id s7uJ1W0011kojtg0000000; Fri, 27 Apr 2007 03:54:18 -0400
X-Mailer: git-send-email 1.5.2.rc0.765.g34a89
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45696>

The first in the series moves existing functions from
builtin-blame.c to a new file, mailmap.c, and cleans its
interface up a little bit, to make it more usable by other
programs.  This does not depend on anything and can go directly
on top of 'master'.

The second one uses it to fix up the names in git-blame output.
I added a new option '-x' to disable mailmap mapping, but it
might not be worth it.  I also considered moving this logic to
pretty_print_commit, but decided against it.  I do not think it
is a good idea to have irreversible data munging at such a low
level in the system.

I'll park this in 'pu' tonight.  I think this is safe enough to
be fast-tracked to v1.5.2-rc1 if people wanted it, but on the
other hand, I do not think this is such an ungent feature
either.
