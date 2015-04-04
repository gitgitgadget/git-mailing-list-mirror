From: Koosha Khajehmoogahi <koosha@posteo.de>
Subject: [PATCH v2 3/5] Documentation: add git-log --merges= option and log.merges config. var
Date: Sat,  4 Apr 2015 03:21:59 +0200
Message-ID: <1428110521-31028-3-git-send-email-koosha@posteo.de>
References: <266077>
 <1428110521-31028-1-git-send-email-koosha@posteo.de>
Cc: sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 04 03:23:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeCnv-0008AK-4a
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 03:23:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752465AbbDDBXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 21:23:05 -0400
Received: from mx02.posteo.de ([89.146.194.165]:60063 "EHLO mx02.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752228AbbDDBXD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2015 21:23:03 -0400
Received: from dovecot03.posteo.de (unknown [185.67.36.28])
	by mx02.posteo.de (Postfix) with ESMTPS id B9FCE25AF529;
	Sat,  4 Apr 2015 03:23:00 +0200 (CEST)
Received: from mail.posteo.de (localhost [127.0.0.1])
	by dovecot03.posteo.de (Postfix) with ESMTPSA id 3lJgP040nWz5vN8;
	Sat,  4 Apr 2015 03:23:00 +0200 (CEST)
X-Mailer: git-send-email 2.3.3.263.g095251d.dirty
In-Reply-To: <1428110521-31028-1-git-send-email-koosha@posteo.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266755>

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Koosha Khajehmoogahi <koosha@posteo.de>
---
 Documentation/git-log.txt          |  3 +++
 Documentation/rev-list-options.txt | 18 +++++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 18bc716..e16f0f8 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -190,6 +190,9 @@ log.showRoot::
 	`git log -p` output would be shown without a diff attached.
 	The default is `true`.
 
+log.merges::
+    Default for `--merges=` option. Defaults to `show`.
+
 mailmap.*::
 	See linkgit:git-shortlog[1].
 
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index f620ee4..0bb2390 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -96,12 +96,24 @@ if it is part of the log message.
 --remove-empty::
 	Stop when a given path disappears from the tree.
 
+--merges={show|hide|only}::
++
+--
+`show`: show both merge and non-merge commits
+
+`hide`: only show non-merge commits; same as `--max-parents=1`
+
+`only`: only show merge commits; same as `--min-parents=2`
+
+If `--merges=` is not specified, default value is `show`.
+--
++
+
 --merges::
-	Print only merge commits. This is exactly the same as `--min-parents=2`.
+	Shorthand for `--merges=only`.
 
 --no-merges::
-	Do not print commits with more than one parent. This is
-	exactly the same as `--max-parents=1`.
+	Shorthand for `--merges=hide`.
 
 --min-parents=<number>::
 --max-parents=<number>::
-- 
2.3.3.263.g095251d.dirty
