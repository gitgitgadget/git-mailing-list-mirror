From: Thomas Rast <trast@student.ethz.ch>
Subject: [TopGit PATCH] depend: don't check for tg branch
Date: Tue, 13 Jan 2009 12:05:16 +0100
Message-ID: <1231844716-10422-1-git-send-email-trast@student.ethz.ch>
Cc: "martin f. krafft" <madduck@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 13 12:08:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMh6R-0003hf-O3
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 12:06:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385AbZAMLFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 06:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752061AbZAMLFN
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 06:05:13 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:50018 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751571AbZAMLFM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 06:05:12 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 13 Jan 2009 12:05:11 +0100
Received: from localhost.localdomain ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 13 Jan 2009 12:05:10 +0100
X-Mailer: git-send-email 1.6.1.310.g1063e
X-OriginalArrivalTime: 13 Jan 2009 11:05:10.0276 (UTC) FILETIME=[CCFD1440:01C9756E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105484>

Remove the check in 'tg depend add <branch>' that <branch> is
topgit-tracked, as it seems inconsistent with the use of 'tg create
<branch> <dependencies>', where the <dependencies> can be arbitrary.
This is useful to, e.g., promote a git.git topic branch from
master-based to next-based.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>

---
 tg-depend.sh |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/tg-depend.sh b/tg-depend.sh
index ef5f94f..16b7751 100644
--- a/tg-depend.sh
+++ b/tg-depend.sh
@@ -37,8 +37,6 @@ done
 [ -n "$name" ] || die "no branch name specified"
 branchrev="$(git rev-parse --verify "$name" 2>/dev/null)" ||
 	die "invalid branch name: $name"
-baserev="$(git rev-parse --verify "refs/top-bases/$name" 2>/dev/null)" ||
-	die "not a TopGit topic branch: $name"
 
 
 ## Record new dependency
-- 
tg: (3c70506..) t/depend-no-base-check (depends on: master)
