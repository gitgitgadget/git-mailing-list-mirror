Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 993371F4B6
	for <e@80x24.org>; Sun, 30 Jun 2019 05:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfF3FSc (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jun 2019 01:18:32 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:43092 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfF3FSc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jun 2019 01:18:32 -0400
Received: by mail-ua1-f68.google.com with SMTP id o2so3771818uae.10
        for <git@vger.kernel.org>; Sat, 29 Jun 2019 22:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uvElFs4iyGdBupoIzq6OG/x9ugsKSe9NqwZDobEDJsI=;
        b=Zdy+nNzQXCP3U7R75McWYPGKw+CcRdSoHbRSlaAhBN6z5+F8OW5EXlq05koDXcLKoY
         zMTxVlf7oAQd9976F2ykx637kKsym7iaxo1C9ZGGaYN2kqu/uIkoLnhSF8Zg96qW/qx1
         QkiF4jIyOAlMA7CjrhjhAjUMTG97Z0tE/cfgSEz4f7Q9QP55XQvx5PgnSiVuXrP92Z2W
         UKiCGOhrJ1SSiM0ZCH3QwXb0YYTgsPKC6oKILZ2UxcJNfyH0z70tO3zgwD3okPShNhR1
         New7jDB5wSblIfcdJ4sC8Nvz0Dfv3HqOpLeRrJqSlhRTgfvJrNcJSouEUnihY6mpSPjy
         jTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uvElFs4iyGdBupoIzq6OG/x9ugsKSe9NqwZDobEDJsI=;
        b=TVJLAwbWyPKdyiFywkI1Yb0vP9rPkKRQV2ay+2daHJ1M3zdnR/qG+COGnD4BWdO2/h
         0HU8XVk5HOezEZB1bLssPib9BfwI84JNQHRFJB9QEvOpTpKBsHLRfoqjKQjF/KHrVpFD
         y1pRel+oIlUOf+0/QXFtrZzEAVZtyJ1//kPF1J5RpPxiSvCe8l1HYLapGuHPjb4PYiED
         0i2nHX7jbyeC8n4ppxRqLOGByHVSVCLGmhU8kzb3B9QyI/m05ZnZnw/z+xw+ZDp+xqOW
         Or7pWycfaenDhTTbTy7W7UIWrb5i/VaFlBP8IDaoyjLzQJJaa1Unv4uSPD7RMtNueagz
         I0EQ==
X-Gm-Message-State: APjAAAVoEHQSzH/gPZKwPuPFJBU0LAXXU467J+/r57Qn/W2S9G3On88g
        2aOfONQXCVFAekF/3c1I/P7/NiH1
X-Google-Smtp-Source: APXvYqz9JGe/nqQqCn/0/LrVNHBejphCLf+qEhIJUtvjMvlvlwvADv5sdmqcF4pFoT9e9SV3U9rv+Q==
X-Received: by 2002:a9f:248b:: with SMTP id 11mr10950427uar.9.1561871910881;
        Sat, 29 Jun 2019 22:18:30 -0700 (PDT)
Received: from linuxerio.localdomain ([186.32.195.224])
        by smtp.gmail.com with ESMTPSA id y71sm1416568vsc.19.2019.06.29.22.18.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 29 Jun 2019 22:18:30 -0700 (PDT)
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
To:     git@vger.kernel.org
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: [RFC/PATCH 2/2] rebuash - support for status
Date:   Sat, 29 Jun 2019 23:18:16 -0600
Message-Id: <20190630051816.8814-2-eantoranz@gmail.com>
X-Mailer: git-send-email 2.22.0.216.gf74291ffb7
In-Reply-To: <20190630051816.8814-1-eantoranz@gmail.com>
References: <20190630051816.8814-1-eantoranz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 wt-status.c | 49 +++++++++++++++++++++++++++++++++++++++++++------
 wt-status.h |  1 +
 2 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 0bccef542f..2a7627b331 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1118,11 +1118,24 @@ static void show_merge_in_progress(struct wt_status *s,
 	if (has_unmerged(s)) {
 		status_printf_ln(s, color, _("You have unmerged paths."));
 		if (s->hints) {
-			status_printf_ln(s, color,
-					 _("  (fix conflicts and run \"git commit\")"));
-			status_printf_ln(s, color,
-					 _("  (use \"git merge --abort\" to abort the merge)"));
+			if (s->state.rebuash_in_progress) {
+				status_printf_ln(s, color,
+						_("  (fix conflicts and run \"git rebuash --continue\")"));
+				status_printf_ln(s, color,
+						_("  (use \"git rebuash --abort\" to abort the operation)"));
+			} else {
+				status_printf_ln(s, color,
+						_("  (fix conflicts and run \"git commit\")"));
+				status_printf_ln(s, color,
+						_("  (use \"git merge --abort\" to abort the merge)"));
+			}
 		}
+	} else if (s->state.rebuash_in_progress) {
+		status_printf_ln(s, color,
+			_("All conflicts fixed but you are still rebuashing."));
+		if (s->hints)
+			status_printf_ln(s, color,
+				_("  (use \"git rebuash --continue\" to conclude rebuash)"));
 	} else {
 		status_printf_ln(s, color,
 			_("All conflicts fixed but you are still merging."));
@@ -1386,6 +1399,15 @@ static void show_rebase_in_progress(struct wt_status *s,
 	wt_longstatus_print_trailer(s);
 }
 
+static void show_rebuash_in_progress(struct wt_status *s,
+				    const char *color)
+{
+	if (&s->state.rebuash_in_progress)
+		status_printf_ln(s, color,
+			_("Rebuash currently in progress."));
+	wt_longstatus_print_trailer(s);
+}
+
 static void show_cherry_pick_in_progress(struct wt_status *s,
 					 const char *color)
 {
@@ -1583,6 +1605,18 @@ int wt_status_check_rebase(const struct worktree *wt,
 	return 1;
 }
 
+int wt_status_check_rebuash(const struct worktree *wt,
+			   struct wt_status_state *state)
+{
+	struct stat st;
+
+	if (!stat(worktree_git_path(wt, "REBUASH_STATE"), &st)) {
+		state->rebuash_in_progress = 1;
+	} else
+		return 0;
+	return 1;
+}
+
 int wt_status_check_bisect(const struct worktree *wt,
 			   struct wt_status_state *state)
 {
@@ -1614,6 +1648,7 @@ void wt_status_get_state(struct repository *r,
 		state->cherry_pick_in_progress = 1;
 		oidcpy(&state->cherry_pick_head_oid, &oid);
 	}
+	wt_status_check_rebuash(NULL, state);
 	wt_status_check_bisect(NULL, state);
 	if (!stat(git_path_revert_head(r), &st) &&
 	    !get_oid("REVERT_HEAD", &oid)) {
@@ -1643,6 +1678,8 @@ static void wt_longstatus_print_state(struct wt_status *s)
 			show_rebase_information(s, state_color);
 			fputs("\n", s->fp);
 		}
+		if (state->rebuash_in_progress)
+			show_rebuash_in_progress(s, state_color);
 		show_merge_in_progress(s, state_color);
 	} else if (state->am_in_progress)
 		show_am_in_progress(s, state_color);
@@ -1688,7 +1725,7 @@ static void wt_longstatus_print(struct wt_status *s)
 		status_printf(s, color(WT_STATUS_HEADER, s), "%s", "");
 		status_printf_more(s, branch_status_color, "%s", on_what);
 		status_printf_more(s, branch_color, "%s\n", branch_name);
-		if (!s->is_initial)
+		if (!(s->is_initial || s->state.rebuash_in_progress))
 			wt_longstatus_print_tracking(s);
 	}
 
@@ -1731,7 +1768,7 @@ static void wt_longstatus_print(struct wt_status *s)
 
 	if (s->verbose)
 		wt_longstatus_print_verbose(s);
-	if (!s->committable) {
+	if (!(s->committable || s->state.rebuash_in_progress)) {
 		if (s->amend)
 			status_printf_ln(s, GIT_COLOR_NORMAL, _("No changes"));
 		else if (s->nowarn)
diff --git a/wt-status.h b/wt-status.h
index 64f1ddc9fd..2995866327 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -72,6 +72,7 @@ struct wt_status_state {
 	int rebase_in_progress;
 	int rebase_interactive_in_progress;
 	int cherry_pick_in_progress;
+	int rebuash_in_progress;
 	int bisect_in_progress;
 	int revert_in_progress;
 	int detached_at;
-- 
2.20.1

