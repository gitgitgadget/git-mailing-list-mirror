From: Koosha Khajehmoogahi <koosha@posteo.de>
Subject: [PATCH v3 3/5] Documentation: add git-log --merges= option and log.merges config. var
Date: Mon, 13 Apr 2015 17:29:26 +0200
Message-ID: <1428938968-19013-3-git-send-email-koosha@posteo.de>
References: <1428938968-19013-1-git-send-email-koosha@posteo.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 13 17:30:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhgJq-0002Fc-EN
	for gcvg-git-2@plane.gmane.org; Mon, 13 Apr 2015 17:30:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbbDMPab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2015 11:30:31 -0400
Received: from mx02.posteo.de ([89.146.194.165]:49908 "EHLO mx02.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932289AbbDMPa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2015 11:30:29 -0400
Received: from dovecot03.posteo.de (unknown [185.67.36.28])
	by mx02.posteo.de (Postfix) with ESMTPS id 6AB9A25A3DC7
	for <git@vger.kernel.org>; Mon, 13 Apr 2015 17:30:28 +0200 (CEST)
Received: from mail.posteo.de (localhost [127.0.0.1])
	by dovecot03.posteo.de (Postfix) with ESMTPSA id 3lQYmh24rcz5vMp
	for <git@vger.kernel.org>; Mon, 13 Apr 2015 17:30:28 +0200 (CEST)
X-Mailer: git-send-email 2.3.3.263.g095251d.dirty
In-Reply-To: <1428938968-19013-1-git-send-email-koosha@posteo.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267088>

From: Junio C Hamano <gitster@pobox.com>

[kk: added documentation in git-log.txt]

Signed-off-by: Koosha Khajehmoogahi <koosha@posteo.de>
---
 Documentation/git-log.txt          |  3 +++
 Documentation/rev-list-options.txt | 17 +++++++++++++++++
 2 files changed, 20 insertions(+)

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
index f620ee4..88f152f 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -96,6 +96,23 @@ if it is part of the log message.
 --remove-empty::
 	Stop when a given path disappears from the tree.
 
+--merges={show|hide|only}::
+
+	Limit the output by type of commits.
+
+	`hide`;;
+		Hide merge commits from the output.
+
+	`only`;;
+		Hide non-merge commits from the output (i.e showing
+		only merge commits).
+
+	`show`;;
+		Do not hide either merge or non-merge commits. This
+		is primarily useful when the user has non-standard
+		setting of `log.merges` configuration variable that
+		needs to be overriden from the command line.
+
 --merges::
 	Print only merge commits. This is exactly the same as `--min-parents=2`.
 
-- 
2.3.3.263.g095251d.dirty
