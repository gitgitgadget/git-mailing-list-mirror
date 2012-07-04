From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 0/2] git p4: use "move" command for renames
Date: Wed,  4 Jul 2012 09:40:18 -0400
Message-ID: <1341409220-27954-1-git-send-email-pw@padd.com>
Cc: Gary Gibbons <ggibbons@perforce.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 04 15:40:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmPot-00062b-9f
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jul 2012 15:40:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752947Ab2GDNkd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jul 2012 09:40:33 -0400
Received: from honk.padd.com ([74.3.171.149]:37564 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753118Ab2GDNka (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2012 09:40:30 -0400
Received: from arf.padd.com (unknown [50.55.159.91])
	by honk.padd.com (Postfix) with ESMTPSA id 73CA71FED;
	Wed,  4 Jul 2012 06:40:25 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id DCF2F313C0; Wed,  4 Jul 2012 09:40:20 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.125.g4a65fea
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201008>

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
1.7.11.1.125.g4a65fea
