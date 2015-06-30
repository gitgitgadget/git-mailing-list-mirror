From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 3/3] fixup! git rebase -i: warn about removed commits
Date: Tue, 30 Jun 2015 11:19:21 +0200
Message-ID: <1435655961-31263-4-git-send-email-Matthieu.Moy@imag.fr>
References: <1435609232-14232-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
 <1435655961-31263-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	antoine.delaite@ensimag.grenoble-inp.fr, sunshine@sunshineco.com,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jun 30 11:29:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9rqn-00058x-NM
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 11:29:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752408AbbF3J3D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 05:29:03 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35171 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752108AbbF3J26 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 05:28:58 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5U9Sp9i023822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 30 Jun 2015 11:28:51 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5U9SqLh018311;
	Tue, 30 Jun 2015 11:28:52 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Z9rqW-0000Vd-He; Tue, 30 Jun 2015 11:28:52 +0200
X-Mailer: git-send-email 2.5.0.rc0.10.g7792c2a
In-Reply-To: <1435655961-31263-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 30 Jun 2015 11:28:51 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5U9Sp9i023822
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1436261331.9971@P6v4YeMqIfVEv85hfPEwZg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273039>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 git-rebase--interactive.sh    | 2 +-
 t/t3404-rebase-interactive.sh | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 0117791..8090d80 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -985,7 +985,7 @@ check_todo_list () {
 			warn "To avoid this message, use \"drop\" to" \
 				"explicitly remove a commit."
 			warn
-			warn "Use 'git --config rebase.missingCommitsCheck' to change" \
+			warn "Use 'git config rebase.missingCommitsCheck' to change" \
 				"the level of warnings."
 			warn "The possible behaviours are: ignore, warn, error."
 			warn
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 9b2c51c..ebdab4b 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1140,7 +1140,7 @@ Dropped commits (newer to older):
  - $(git rev-list --pretty=oneline --abbrev-commit -1 master)
 To avoid this message, use "drop" to explicitly remove a commit.
 
-Use 'git --config rebase.missingCommitsCheck' to change the level of warnings.
+Use 'git config rebase.missingCommitsCheck' to change the level of warnings.
 The possible behaviours are: ignore, warn, error.
 
 Successfully rebased and updated refs/heads/missing-commit.
@@ -1163,7 +1163,7 @@ Dropped commits (newer to older):
  - $(git rev-list --pretty=oneline --abbrev-commit -1 master~2)
 To avoid this message, use "drop" to explicitly remove a commit.
 
-Use 'git --config rebase.missingCommitsCheck' to change the level of warnings.
+Use 'git config rebase.missingCommitsCheck' to change the level of warnings.
 The possible behaviours are: ignore, warn, error.
 
 You can fix this with 'git rebase --edit-todo'.
-- 
2.5.0.rc0.10.g7792c2a
