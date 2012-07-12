From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 0/2] git p4: use "move" command for renames
Date: Thu, 12 Jul 2012 19:28:58 -0400
Message-ID: <1342135740-30290-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 13 01:29:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpSp8-0004dS-KQ
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jul 2012 01:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161928Ab2GLX3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jul 2012 19:29:23 -0400
Received: from honk.padd.com ([74.3.171.149]:43159 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161900Ab2GLX3E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2012 19:29:04 -0400
Received: from arf.padd.com (unknown [50.55.149.165])
	by honk.padd.com (Postfix) with ESMTPSA id 1AC6A20E5;
	Thu, 12 Jul 2012 16:29:03 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 6C07A31563; Thu, 12 Jul 2012 19:29:00 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.131.g9e48292
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201389>

Difference from v1:
    * Remove "tee" usage in t9814, just send output to a file
      and grep it directly.

Recent p4 supports a "move" command that records explicitly that
a file was moved from one place to another.  It can be changed a bit
during the move, too.  Use this feature, if it exists, when renames
are detected.

Gary sent these patches months ago, and I've been sitting on them
far too long.  Was hoping to move some other work out first, but it
was not ready.

These commits are on origin/next, as they depend on changes
in pw/git-p4-tests that was merged into next on Jul 3.  They
do not conflict with the other series in flight, "notice Jobs: ...".


Gary Gibbons (2):
  git p4: refactor diffOpts calculation
  git p4: add support for 'p4 move' in P4Submit

 Documentation/git-p4.txt | 10 +++---
 git-p4.py                | 86 ++++++++++++++++++++++++++++++++----------------
 t/t9814-git-p4-rename.sh | 16 ++++-----
 3 files changed, 72 insertions(+), 40 deletions(-)

-- 
1.7.11.1.72.g3344471
