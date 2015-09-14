From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2] doc: show usage of branch description
Date: Mon, 14 Sep 2015 15:10:53 +0100
Message-ID: <1442239853-4856-1-git-send-email-philipoakley@iee.org>
References: <1442098288-3316-1-git-send-email-philipoakley@iee.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 14 16:10:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbUSV-0005Sx-AY
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 16:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752997AbbINOKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 10:10:10 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:31796 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751302AbbINOKJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Sep 2015 10:10:09 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CICwCi1PZVPDopFlxdGQEBAYI1UoE9glyDfb5fBAICgTVNAQEBAQEBBwEBAQFAAT+EJAEBBFYjEAhJOQoUBhOIMsohAQEBByKGc4knEQFRB4QsBYcyjiWOSpB9hEmDbIRlPTOJPoE/AQEB
X-IPAS-Result: A2CICwCi1PZVPDopFlxdGQEBAYI1UoE9glyDfb5fBAICgTVNAQEBAQEBBwEBAQFAAT+EJAEBBFYjEAhJOQoUBhOIMsohAQEBByKGc4knEQFRB4QsBYcyjiWOSpB9hEmDbIRlPTOJPoE/AQEB
X-IronPort-AV: E=Sophos;i="5.17,528,1437433200"; 
   d="scan'208";a="618985811"
Received: from host-92-22-41-58.as13285.net (HELO localhost) ([92.22.41.58])
  by out1.ip05ir2.opaltelecom.net with ESMTP; 14 Sep 2015 15:10:07 +0100
X-Mailer: git-send-email 1.9.5
In-Reply-To: <1442098288-3316-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277829>

The branch description will be included in 'git format-patch
--cover-letter' and in 'git pull-request' emails. It can also
be used in the automatic merge message. Tell the reader.

While here, clarify that the description may be a multi-line
explanation of the purpose of the branch's patch series.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
fc0aa39 (Documentation: include 'merge.branchdesc' for merge
and config as well, 2015-05-27) recently added details of the
low level config flag.

Changes since V1: discovered that git merge can also include
the branch description if enabled, so added a minimal mention to
flag it to the reader. 
---
 Documentation/git-branch.txt       | 4 +++-
 Documentation/git-format-patch.txt | 2 +-
 Documentation/git-merge.txt        | 2 +-
 Documentation/git-request-pull.txt | 3 ++-
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index a67138a..bbbade4 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -197,7 +197,9 @@ start-point is either a local or remote-tracking branch.
 
 --edit-description::
 	Open an editor and edit the text to explain what the branch is
-	for, to be used by various other commands (e.g. `request-pull`).
+	for, to be used by various other commands (e.g. `format-patch`,
+	`request-pull`, and `merge` (if enabled)). Multi-line explanations
+	may be used.
 
 --contains [<commit>]::
 	Only list branches which contain the specified commit (HEAD
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 0dac4e9..4035649 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -213,7 +213,7 @@ feeding the result to `git send-email`.
 
 --[no-]cover-letter::
 	In addition to the patches, generate a cover letter file
-	containing the shortlog and the overall diffstat.  You can
+	containing the branch description, shortlog and the overall diffstat.  You can
 	fill in a description in the file before sending it out.
 
 --notes[=<ref>]::
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 273a100..a62d672 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -78,7 +78,7 @@ will be appended to the specified message.
 +
 The 'git fmt-merge-msg' command can be
 used to give a good default for automated 'git merge'
-invocations.
+invocations. The automated message can include the branch description.
 
 --[no-]rerere-autoupdate::
 	Allow the rerere mechanism to update the index with the
diff --git a/Documentation/git-request-pull.txt b/Documentation/git-request-pull.txt
index 283577b..c32cb0b 100644
--- a/Documentation/git-request-pull.txt
+++ b/Documentation/git-request-pull.txt
@@ -14,7 +14,8 @@ DESCRIPTION
 -----------
 
 Generate a request asking your upstream project to pull changes into
-their tree.  The request, printed to the standard output, summarizes
+their tree.  The request, printed to the standard output,
+begins with the branch description, summarizes
 the changes and indicates from where they can be pulled.
 
 The upstream project is expected to have the commit named by
-- 
2.4.2.windows.1.5.gd32afb6
