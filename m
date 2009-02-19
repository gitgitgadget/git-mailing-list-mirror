From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 7/8] Test rev-list --parents/--children
Date: Thu, 19 Feb 2009 12:13:41 +0100
Message-ID: <5bfd6b118737769e006be12ebda28d198952305d.1235041345.git.trast@student.ethz.ch>
References: <cover.1235041345.git.trast@student.ethz.ch>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 12:16:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La6sy-0000Pm-V5
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 12:16:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753528AbZBSLOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 06:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753337AbZBSLOO
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 06:14:14 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:16533 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753150AbZBSLOK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 06:14:10 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 19 Feb 2009 12:13:53 +0100
Received: from localhost.localdomain ([129.132.153.233]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 19 Feb 2009 12:13:52 +0100
X-Mailer: git-send-email 1.6.2.rc1.266.gce6c4
In-Reply-To: <cover.1235041345.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 19 Feb 2009 11:13:52.0915 (UTC) FILETIME=[25CA3630:01C99283]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110679>

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Same as v1.

 t/t4013-diff-various.sh               |    3 +++
 t/t4013/diff.rev-list_--children_HEAD |    7 +++++++
 t/t4013/diff.rev-list_--parents_HEAD  |    7 +++++++
 3 files changed, 17 insertions(+), 0 deletions(-)
 create mode 100644 t/t4013/diff.rev-list_--children_HEAD
 create mode 100644 t/t4013/diff.rev-list_--parents_HEAD

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index ef16f69..9cd5a6e 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -209,6 +209,9 @@ log -SF master
 log -SF -p master
 log --decorate --all
 
+rev-list --parents HEAD
+rev-list --children HEAD
+
 whatchanged master
 whatchanged -p master
 whatchanged --root master
diff --git a/t/t4013/diff.rev-list_--children_HEAD b/t/t4013/diff.rev-list_--children_HEAD
new file mode 100644
index 0000000..e7f17d5
--- /dev/null
+++ b/t/t4013/diff.rev-list_--children_HEAD
@@ -0,0 +1,7 @@
+$ git rev-list --children HEAD
+59d314ad6f356dd08601a4cd5e530381da3e3c64
+c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a 59d314ad6f356dd08601a4cd5e530381da3e3c64
+9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0 59d314ad6f356dd08601a4cd5e530381da3e3c64
+1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
+444ac553ac7612cc88969031b02b3767fb8a353a 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
+$
diff --git a/t/t4013/diff.rev-list_--parents_HEAD b/t/t4013/diff.rev-list_--parents_HEAD
new file mode 100644
index 0000000..65d2a80
--- /dev/null
+++ b/t/t4013/diff.rev-list_--parents_HEAD
@@ -0,0 +1,7 @@
+$ git rev-list --parents HEAD
+59d314ad6f356dd08601a4cd5e530381da3e3c64 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0 c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
+c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a 444ac553ac7612cc88969031b02b3767fb8a353a
+9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44
+1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 444ac553ac7612cc88969031b02b3767fb8a353a
+444ac553ac7612cc88969031b02b3767fb8a353a
+$
-- 
1.6.2.rc1.266.gce6c4
