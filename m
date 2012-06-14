From: y@imag.fr
Subject: [PATCH 2/2] fixup! 38388c8 reword message when splitting a commit.
Date: Thu, 14 Jun 2012 10:20:14 +0200
Message-ID: <43585.3446987041$1339662031@news.gmane.org>
References: <7vk3zag6jg.fsf@alter.siamese.dyndns.org>
 <1339662014-30173-1-git-send-email-y>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jun 14 10:20:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sf5I5-0006VQ-LP
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 10:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755090Ab2FNIUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jun 2012 04:20:25 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36293 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754912Ab2FNIUW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2012 04:20:22 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5E8BGeY021444
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 14 Jun 2012 10:11:16 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Sf5Ht-0006XW-R6; Thu, 14 Jun 2012 10:20:17 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Sf5Ht-0007rM-P8; Thu, 14 Jun 2012 10:20:17 +0200
X-Mailer: git-send-email 1.7.11.rc0.57.g84a04c7
In-Reply-To: <1339662014-30173-1-git-send-email-y>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 14 Jun 2012 10:11:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5E8BGeY021444
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1340266276.86051@eyZGexNYU+8asfPNSxrdFw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199977>

From: Matthieu Moy <Matthieu.Moy@imag.fr>

The "splitting a commit" is a sub-case of the "rebase" case, hence,
mention rebase like this:

  # You are currently splitting a commit during a rebase.

This makes the message consistant with "editing a commit":

  # You are currently editing a commit during a rebase.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 t/t7512-status-help.sh | 8 ++++----
 wt-status.c            | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 3ce384a..b3f6eb9 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -210,7 +210,7 @@ test_expect_success 'status when splitting a commit' '
 	git reset HEAD^ &&
 	cat >expected <<-\EOF &&
 	# Not currently on any branch.
-	# You are currently splitting a commit.
+	# You are currently splitting a commit during a rebase.
 	#   (Once your working directory is clean, run "git rebase --continue")
 	#
 	# Changes not staged for commit:
@@ -290,7 +290,7 @@ test_expect_success 'status: (continue first edit) second edit and split' '
 	git reset HEAD^ &&
 	cat >expected <<-\EOF &&
 	# Not currently on any branch.
-	# You are currently splitting a commit.
+	# You are currently splitting a commit during a rebase.
 	#   (Once your working directory is clean, run "git rebase --continue")
 	#
 	# Changes not staged for commit:
@@ -359,7 +359,7 @@ test_expect_success 'status: (amend first edit) second edit and split' '
 	git reset HEAD^ &&
 	cat >expected <<-\EOF &&
 	# Not currently on any branch.
-	# You are currently splitting a commit.
+	# You are currently splitting a commit during a rebase.
 	#   (Once your working directory is clean, run "git rebase --continue")
 	#
 	# Changes not staged for commit:
@@ -433,7 +433,7 @@ test_expect_success 'status: (split first edit) second edit and split' '
 	git reset HEAD^ &&
 	cat >expected <<-\EOF &&
 	# Not currently on any branch.
-	# You are currently splitting a commit.
+	# You are currently splitting a commit during a rebase.
 	#   (Once your working directory is clean, run "git rebase --continue")
 	#
 	# Changes not staged for commit:
diff --git a/wt-status.c b/wt-status.c
index e65716d..c749267 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -886,7 +886,7 @@ static void show_rebase_in_progress(struct wt_status *s,
 			status_printf_ln(s, color,
 				_("  (all conflicts fixed: run \"git rebase --continue\")"));
 	} else if (split_commit_in_progress(s)) {
-		status_printf_ln(s, color, _("You are currently splitting a commit."));
+		status_printf_ln(s, color, _("You are currently splitting a commit during a rebase."));
 		if (advice_status_hints)
 			status_printf_ln(s, color,
 				_("  (Once your working directory is clean, run \"git rebase --continue\")"));
-- 
1.7.11.rc0.57.g84a04c7
