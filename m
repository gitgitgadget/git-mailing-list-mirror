From: Henrik Hautakoski <henrik@fiktivkod.org>
Subject: [PATCH] wt-status.c: Increase readability.
Date: Tue, 26 Apr 2011 09:08:33 +0200
Message-ID: <1303801713-22639-1-git-send-email-henrik@fiktivkod.org>
Cc: Henrik Hautakoski <henrik@fiktivkod.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 09:09:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEcOY-0003eD-BQ
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 09:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757507Ab1DZHJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 03:09:07 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:46535 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757264Ab1DZHJG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 03:09:06 -0400
Received: by ewy4 with SMTP id 4so92541ewy.19
        for <git@vger.kernel.org>; Tue, 26 Apr 2011 00:09:04 -0700 (PDT)
Received: by 10.213.27.14 with SMTP id g14mr195968ebc.63.1303801743128;
        Tue, 26 Apr 2011 00:09:03 -0700 (PDT)
Received: from localhost.localdomain (h-76-221.A259.priv.bahnhof.se [94.254.76.221])
        by mx.google.com with ESMTPS id k57sm2819478eei.17.2011.04.26.00.09.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Apr 2011 00:09:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172072>

Add braces to if/else statements to make the code more readable.

Signed-off-by: Henrik Hautakoski <henrik@fiktivkod.org>
---
 wt-status.c |   26 ++++++++++++++------------
 1 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 9f4e0ba..9d8a0ea 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -448,9 +448,9 @@ static void wt_status_collect_changes_initial(struct wt_status *s)
 		if (ce_stage(ce)) {
 			d->index_status = DIFF_STATUS_UNMERGED;
 			d->stagemask |= (1 << (ce_stage(ce) - 1));
-		}
-		else
+		} else {
 			d->index_status = DIFF_STATUS_ADDED;
+		}
 	}
 	free_pathspec(&pathspec);
 }
@@ -745,35 +745,37 @@ void wt_status_print(struct wt_status *s)
 		wt_status_print_other(s, &s->untracked, _("Untracked"), "add");
 		if (s->show_ignored_files)
 			wt_status_print_other(s, &s->ignored, _("Ignored"), "add -f");
-	} else if (s->commitable)
+	} else if (s->commitable) {
 		status_printf_ln(s, GIT_COLOR_NORMAL, _("Untracked files not listed%s"),
 			advice_status_hints
 			? _(" (use -u option to show untracked files)") : "");
+    }
 
 	if (s->verbose)
 		wt_status_print_verbose(s);
 	if (!s->commitable) {
-		if (s->amend)
+		if (s->amend) {
 			status_printf_ln(s, GIT_COLOR_NORMAL, _("No changes"));
-		else if (s->nowarn)
+		} else if (s->nowarn) {
 			; /* nothing */
-		else if (s->workdir_dirty)
+		} else if (s->workdir_dirty) {
 			printf(_("no changes added to commit%s\n"),
 				advice_status_hints
 				? _(" (use \"git add\" and/or \"git commit -a\")") : "");
-		else if (s->untracked.nr)
+		} else if (s->untracked.nr) {
 			printf(_("nothing added to commit but untracked files present%s\n"),
 				advice_status_hints
 				? _(" (use \"git add\" to track)") : "");
-		else if (s->is_initial)
+		} else if (s->is_initial) {
 			printf(_("nothing to commit%s\n"), advice_status_hints
 				? _(" (create/copy files and use \"git add\" to track)") : "");
-		else if (!s->show_untracked_files)
+		} else if (!s->show_untracked_files) {
 			printf(_("nothing to commit%s\n"), advice_status_hints
 				? _(" (use -u to show untracked files)") : "");
-		else
+		} else {
 			printf(_("nothing to commit%s\n"), advice_status_hints
 				? _(" (working directory clean)") : "");
+		}
 	}
 }
 
@@ -878,9 +880,9 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 		return;
 	branch_name = s->branch;
 
-	if (!prefixcmp(branch_name, "refs/heads/"))
+	if (!prefixcmp(branch_name, "refs/heads/")) {
 		branch_name += 11;
-	else if (!strcmp(branch_name, "HEAD")) {
+	} else if (!strcmp(branch_name, "HEAD")) {
 		branch_name = _("HEAD (no branch)");
 		branch_color_local = color(WT_STATUS_NOBRANCH, s);
 	}
-- 
1.7.3.4
