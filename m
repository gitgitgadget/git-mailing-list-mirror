From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/3] rebase -i: Enclose sed command substitution in quotes
Date: Fri, 22 Jan 2010 10:22:30 +0100
Message-ID: <45e8a3c5dc32a67e4a8ed82c8990e3ee85232581.1264151435.git.mhagger@alum.mit.edu>
References: <cover.1264151435.git.mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	tarmigan+git@gmail.com, j.sixt@viscovery.net,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 22 10:23:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYFk5-00038O-0Z
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 10:23:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753088Ab0AVJX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 04:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753084Ab0AVJX3
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 04:23:29 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:53983 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753066Ab0AVJX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 04:23:28 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from localhost.localdomain (p4FC1CC41.dip.t-dialin.net [79.193.204.65])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o0M9Mb4P014743;
	Fri, 22 Jan 2010 10:22:48 +0100
X-Mailer: git-send-email 1.6.6
In-Reply-To: <cover.1264151435.git.mhagger@alum.mit.edu>
In-Reply-To: <cover.1264151435.git.mhagger@alum.mit.edu>
References: <cover.1264151435.git.mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137753>

Reported by: Johannes Sixt <j.sixt@viscovery.net>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/lib-rebase.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 2d922ae..6aefe27 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -27,7 +27,7 @@ set_fake_editor () {
 case "$1" in
 */COMMIT_EDITMSG)
 	test -z "$EXPECT_HEADER_COUNT" ||
-		test "$EXPECT_HEADER_COUNT" = $(sed -n '1s/^# This is a combination of \(.*\) commits\./\1/p' < "$1") ||
+		test "$EXPECT_HEADER_COUNT" = "$(sed -n '1s/^# This is a combination of \(.*\) commits\./\1/p' < "$1")" ||
 		exit
 	test -z "$FAKE_COMMIT_MESSAGE" || echo "$FAKE_COMMIT_MESSAGE" > "$1"
 	test -z "$FAKE_COMMIT_AMEND" || echo "$FAKE_COMMIT_AMEND" >> "$1"
-- 
1.6.6
