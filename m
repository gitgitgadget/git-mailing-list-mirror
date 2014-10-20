From: Olivier Croquette <ocroquette@free.fr>
Subject: [PATCH] Copy mergetool "bc3" as "bc4"
Date: Mon, 20 Oct 2014 13:03:37 +0200
Message-ID: <1413803017-30489-1-git-send-email-ocroquette@free.fr>
Cc: ocroquette@free.fr
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 20 13:48:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgBRT-0002qI-5T
	for gcvg-git-2@plane.gmane.org; Mon, 20 Oct 2014 13:48:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbaJTLr6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2014 07:47:58 -0400
Received: from ocroquette.fr ([78.46.91.4]:42473 "EHLO ocroquette.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750996AbaJTLr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2014 07:47:58 -0400
X-Greylist: delayed 2658 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Oct 2014 07:47:58 EDT
Received: from olivier by ocroquette.fr with local (Exim 4.72)
	(envelope-from <ocroquette@free.fr>)
	id 1XgAkU-0007wH-2L; Mon, 20 Oct 2014 13:03:38 +0200
X-Mailer: git-send-email 1.7.2.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Beyond compare 4 is out since september 2014. The CLI interface doesn't seem to have changed compared to the version 3.

Signed-off-by: Olivier Croquette <ocroquette@free.fr>
---
 mergetools/bc4 |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)
 create mode 100644 mergetools/bc4

diff --git a/mergetools/bc4 b/mergetools/bc4
new file mode 100644
index 0000000..b6319d2
--- /dev/null
+++ b/mergetools/bc4
@@ -0,0 +1,25 @@
+diff_cmd () {
+	"$merge_tool_path" "$LOCAL" "$REMOTE"
+}
+
+merge_cmd () {
+	touch "$BACKUP"
+	if $base_present
+	then
+		"$merge_tool_path" "$LOCAL" "$REMOTE" "$BASE" \
+			-mergeoutput="$MERGED"
+	else
+		"$merge_tool_path" "$LOCAL" "$REMOTE" \
+			-mergeoutput="$MERGED"
+	fi
+	check_unchanged
+}
+
+translate_merge_tool_path() {
+	if type bcomp >/dev/null 2>/dev/null
+	then
+		echo bcomp
+	else
+		echo bcompare
+	fi
+}
-- 
1.7.2.5
