From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 1/2] [RFC] Use --find- instead of --detect- as prefix for long forms of -M and -C.
Date: Wed, 10 Nov 2010 21:27:12 +0100
Message-ID: <1289420833-20602-2-git-send-email-ydirson@altern.org>
References: <1289420833-20602-1-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 10 21:27:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGHGV-0001jm-FA
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 21:27:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756508Ab0KJU10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 15:27:26 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:50250 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756404Ab0KJU1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 15:27:24 -0500
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 695B1D48158;
	Wed, 10 Nov 2010 21:27:18 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PGHGH-0005N3-8Y; Wed, 10 Nov 2010 21:27:17 +0100
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1289420833-20602-1-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161181>

Rationale: this is both shorter to spell and consistent with
--find-copies-harder.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---
 Documentation/diff-options.txt |    4 ++--
 diff.c                         |    8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index bfd0b57..ed9c44e 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -230,7 +230,7 @@ eligible for being picked up as a possible source of a rename to
 another file.
 
 -M[<n>]::
---detect-renames[=<n>]::
+--find-renames[=<n>]::
 ifndef::git-log[]
 	Detect renames.
 endif::git-log[]
@@ -246,7 +246,7 @@ endif::git-log[]
 	hasn't changed.
 
 -C[<n>]::
---detect-copies[=<n>]::
+--find-copies[=<n>]::
 	Detect copies as well as renames.  See also `--find-copies-harder`.
 	If `n` is specified, it has the same meaning as for `-M<n>`.
 
diff --git a/diff.c b/diff.c
index d1c6b91..3837ffd 100644
--- a/diff.c
+++ b/diff.c
@@ -3145,14 +3145,14 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		if ((options->break_opt = diff_scoreopt_parse(arg)) == -1)
 			return -1;
 	}
-	else if (!prefixcmp(arg, "-M") || !prefixcmp(arg, "--detect-renames=") ||
-		 !strcmp(arg, "--detect-renames")) {
+	else if (!prefixcmp(arg, "-M") || !prefixcmp(arg, "--find-renames=") ||
+		 !strcmp(arg, "--find-renames")) {
 		if ((options->rename_score = diff_scoreopt_parse(arg)) == -1)
 			return -1;
 		options->detect_rename = DIFF_DETECT_RENAME;
 	}
-	else if (!prefixcmp(arg, "-C") || !prefixcmp(arg, "--detect-copies=") ||
-		 !strcmp(arg, "--detect-copies")) {
+	else if (!prefixcmp(arg, "-C") || !prefixcmp(arg, "--find-copies=") ||
+		 !strcmp(arg, "--find-copies")) {
 		if (options->detect_rename == DIFF_DETECT_COPY)
 			DIFF_OPT_SET(options, FIND_COPIES_HARDER);
 		if ((options->rename_score = diff_scoreopt_parse(arg)) == -1)
-- 
1.7.2.3
