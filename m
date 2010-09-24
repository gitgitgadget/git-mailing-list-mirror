From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Improvements to `git checkout -h`
Date: Fri, 24 Sep 2010 18:21:59 +0200
Message-ID: <1285345319-6109-1-git-send-email-Matthieu.Moy@imag.fr>
References: <AANLkTinBoofjS=+ropQnHARn+qtzJWh2Nx6n87cud5Di@mail.gmail.com>
Cc: Daniel Knittl-Frank <knittl89+git@googlemail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Sep 24 18:25:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzB5v-0004uP-R2
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 18:25:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429Ab0IXQZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 12:25:51 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42356 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753818Ab0IXQZu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 12:25:50 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o8OGHGSg009411
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 24 Sep 2010 18:17:16 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OzB29-0000R3-Dx; Fri, 24 Sep 2010 18:22:01 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OzB29-0001b7-8e; Fri, 24 Sep 2010 18:22:01 +0200
X-Mailer: git-send-email 1.7.3.2.g257b5f
In-Reply-To: <AANLkTinBoofjS=+ropQnHARn+qtzJWh2Nx6n87cud5Di@mail.gmail.com>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 24 Sep 2010 18:17:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o8OGHGSg009411
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1285949836.70939@xou0WhcwwXoTTTgXBWbsmQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157018>

From: Daniel Knittl-Frank <knittl89+git@googlemail.com>

be a little more verbose about what each option does

Signed-off-by: Daniel Knittl-Frank <knittl89+git@googlemail.com>
---
Daniel seems to have difficulty to send the patch through gmail, here
it is again, taken from repo.or.cz.

That seems OK for inclusion to me.

 builtin/checkout.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 560eae1..a54583b 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -691,16 +691,16 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			   "create and checkout a new branch"),
 		OPT_STRING('B', NULL, &opts.new_branch_force, "branch",
 			   "create/reset and checkout a branch"),
-		OPT_BOOLEAN('l', NULL, &opts.new_branch_log, "log for new branch"),
-		OPT_SET_INT('t', "track",  &opts.track, "track",
+		OPT_BOOLEAN('l', NULL, &opts.new_branch_log, "create reflog for new branch"),
+		OPT_SET_INT('t', "track",  &opts.track, "set upstream info for new branch",
 			BRANCH_TRACK_EXPLICIT),
 		OPT_STRING(0, "orphan", &opts.new_orphan_branch, "new branch", "new unparented branch"),
-		OPT_SET_INT('2', "ours", &opts.writeout_stage, "stage",
+		OPT_SET_INT('2', "ours", &opts.writeout_stage, "checkout our version for unmerged files",
 			    2),
-		OPT_SET_INT('3', "theirs", &opts.writeout_stage, "stage",
+		OPT_SET_INT('3', "theirs", &opts.writeout_stage, "checkout their version for unmerged files",
 			    3),
-		OPT_BOOLEAN('f', "force", &opts.force, "force"),
-		OPT_BOOLEAN('m', "merge", &opts.merge, "merge"),
+		OPT_BOOLEAN('f', "force", &opts.force, "force checkout (throw away local modifications)"),
+		OPT_BOOLEAN('m', "merge", &opts.merge, "perform a 3-way merge with the new branch"),
 		OPT_STRING(0, "conflict", &conflict_style, "style",
 			   "conflict style (merge or diff3)"),
 		OPT_BOOLEAN('p', "patch", &patch_mode, "select hunks interactively"),
-- 
1.7.3.2.g257b5f
