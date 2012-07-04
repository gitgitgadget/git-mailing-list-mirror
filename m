From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 0/3] git p4: notice Jobs: section in submit
Date: Wed,  4 Jul 2012 09:34:17 -0400
Message-ID: <1341408860-26965-1-git-send-email-pw@padd.com>
Cc: Michael Horowitz <mike@horowitz.name>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 04 15:34:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmPix-0003W2-PQ
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jul 2012 15:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525Ab2GDNe0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jul 2012 09:34:26 -0400
Received: from honk.padd.com ([74.3.171.149]:54378 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752140Ab2GDNe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2012 09:34:26 -0400
Received: from arf.padd.com (unknown [50.55.159.91])
	by honk.padd.com (Postfix) with ESMTPSA id 9DB2E1FED;
	Wed,  4 Jul 2012 06:34:24 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 5625D5A90B; Wed,  4 Jul 2012 09:34:20 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.125.g4a65fea
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201004>

Perforce has an idea of a "job" and can connect changes to jobs
in order to connect code fixes to an external bug-tracking system,
for instance.  The job can be specified in a change by adding
a section that looks like:

    Jobs:
	project-6032

For code committed from git p4, it would be nice to use a similar
notation in the commit message and have the jobs wind up in the
right section in the p4 change description.

This was discussed in
http://thread.gmane.org/gmane.comp.version-control.git/200445 .

These commits are on origin/next, as they depend on changes
in pw/git-p4-tests that was merged into next on Jul 3.

Pete Wyckoff (3):
  git p4: remove unused P4Submit interactive setting
  git p4 test: refactor marshal_dump
  git p4: notice Jobs lines in git commit messages

 git-p4.py                | 188 ++++++++++++++++++++++++++---------------------
 t/lib-git-p4.sh          |  14 ++++
 t/t9800-git-p4-basic.sh  |   5 --
 t/t9807-git-p4-submit.sh | 155 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 274 insertions(+), 88 deletions(-)

-- 
1.7.11.1.125.g4a65fea
