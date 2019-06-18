Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F9C01F462
	for <e@80x24.org>; Tue, 18 Jun 2019 20:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730513AbfFRUVa (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 16:21:30 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40581 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730176AbfFRUV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 16:21:29 -0400
Received: by mail-ed1-f65.google.com with SMTP id k8so23537325eds.7
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 13:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=atSijQi3FVtngp2h1ZnkD/2sS7g6YErf1F9ORWwoXOI=;
        b=eECwEuPy9zehnycQI0Ky8uu267p68H2O/ciCQaZTRnbn1ibdCSabmqM19lBtUAz23f
         EJzobZHi7hVvbmANriNmrx1DA3vM3Z8oGddc37Tvw8JhxIPz8rHmsEcy16A6BsJmS3kH
         Mjxe9m2dKE3qWk37c3NihAzsX1z3oz7ONAmqzhoFIKnfdz92LVKOaXEO/oo9rfgXeakN
         gGuiy6dii09HBmn8gB6/+jlpfhjdcQTYHXUlVU0djhtd3BO9OGwIiGE3jRaX2D7qA4Cm
         9mu8jOtzy5t76a7jNESfcYtcL4A3Phvn0Qp7P6ST+XZagjcXsek7eufq8/yiQhmQIjU6
         oEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=atSijQi3FVtngp2h1ZnkD/2sS7g6YErf1F9ORWwoXOI=;
        b=EmNygeiIlu6Vi5RZpJTQCUhtZhxNZ76N9m8M8H3pkmke5eNubb1kwmNv8jT0RQUn5G
         LGLDqZ2M7BcVyD1sYTz+UTWFUEBbpJFL051nCsCYng+QFsQROojtImk9JSRN6nl/jnHp
         JI9zp6RysTmj58z1Azf6AkOiyr0MS7BosASJz71/4mzuwmhN8hEi5AUe2DBnrl9B5dTp
         xA9HqIycy9WG4fjOVzziuHg0vV8pe6xrZy5bojivKY+6/BGIQBH4zBy79VwRDmOUx3wa
         l5IlhI9+gJuOx0Iu9Qd+ofDYSsd1UZPy9dvw9/+WtvPdImcaQ3T7iquL5lQM49elNGEL
         SnqA==
X-Gm-Message-State: APjAAAWFxsjCL9S64I1CTucz4UIum/En2PaLQwK9rfxEpbrHUDf+arzQ
        87yQGu5369rb59NtvKhjCiunXv6t
X-Google-Smtp-Source: APXvYqyJpl15xbbSLVJc9f+jiUQ9/DHZEI0msJrc5ktf+Ty81ZfXeImbZnDd/gHqDETSp+OuyZT0vg==
X-Received: by 2002:aa7:d4cf:: with SMTP id t15mr69301304edr.215.1560889287529;
        Tue, 18 Jun 2019 13:21:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v47sm14729edc.80.2019.06.18.13.21.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 13:21:27 -0700 (PDT)
Date:   Tue, 18 Jun 2019 13:21:27 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Jun 2019 20:21:22 GMT
Message-Id: <c1056545b617b89e881f5991beb2fe0d860de740.1560889284.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.272.git.gitgitgadget@gmail.com>
References: <pull.272.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/3] status: warn when a/b calculation takes too long
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     git@jeffhostetler, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

The ahead/behind calculation in 'git status' can be slow in some
cases. Users may not realize that there are ways to avoid this
computation, especially if they are not using the information.

Add a warning that appears if this calculation takes more than
two seconds. The warning can be disabled through the new config
setting advice.statusAheadBehind.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/advice.txt |  6 ++++++
 advice.c                        |  2 ++
 advice.h                        |  1 +
 wt-status.c                     | 17 +++++++++++++++++
 4 files changed, 26 insertions(+)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index ec4f6ae658..4bc5b4c742 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -37,6 +37,12 @@ advice.*::
 		we can still suggest that the user push to either
 		refs/heads/* or refs/tags/* based on the type of the
 		source object.
+	statusAheadBehind::
+		Shown when linkgit:git-status[1] computes the ahead/behind
+		counts for a local ref compared to its remote tracking ref,
+		and that calculation takes longer than expected. Will not
+		appear if `status.aheadBehind` is false or the option
+		`--no-ahead-behind` is given.
 	statusHints::
 		Show directions on how to proceed from the current
 		state in the output of linkgit:git-status[1], in
diff --git a/advice.c b/advice.c
index ce5f374ecd..54f8dea30c 100644
--- a/advice.c
+++ b/advice.c
@@ -12,6 +12,7 @@ int advice_push_needs_force = 1;
 int advice_push_unqualified_ref_name = 1;
 int advice_status_hints = 1;
 int advice_status_u_option = 1;
+int advice_status_ahead_behind_warning = 1;
 int advice_commit_before_merge = 1;
 int advice_reset_quiet_warning = 1;
 int advice_resolve_conflict = 1;
@@ -68,6 +69,7 @@ static struct {
 	{ "pushUnqualifiedRefName", &advice_push_unqualified_ref_name },
 	{ "statusHints", &advice_status_hints },
 	{ "statusUoption", &advice_status_u_option },
+	{ "statusAheadBehindWarning", &advice_status_ahead_behind_warning },
 	{ "commitBeforeMerge", &advice_commit_before_merge },
 	{ "resetQuiet", &advice_reset_quiet_warning },
 	{ "resolveConflict", &advice_resolve_conflict },
diff --git a/advice.h b/advice.h
index e50f02cdfe..c86de9b9b8 100644
--- a/advice.h
+++ b/advice.h
@@ -12,6 +12,7 @@ extern int advice_push_needs_force;
 extern int advice_push_unqualified_ref_name;
 extern int advice_status_hints;
 extern int advice_status_u_option;
+extern int advice_status_ahead_behind_warning;
 extern int advice_commit_before_merge;
 extern int advice_reset_quiet_warning;
 extern int advice_resolve_conflict;
diff --git a/wt-status.c b/wt-status.c
index d2a1bec226..c94d43879a 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -19,6 +19,8 @@
 #include "lockfile.h"
 #include "sequencer.h"
 
+#define AB_DELAY_WARNING_IN_MS (2 * 1000)
+
 static const char cut_line[] =
 "------------------------ >8 ------------------------\n";
 
@@ -1085,14 +1087,29 @@ static void wt_longstatus_print_tracking(struct wt_status *s)
 	struct branch *branch;
 	char comment_line_string[3];
 	int i;
+	uint64_t t_begin = 0;
 
 	assert(s->branch && !s->is_initial);
 	if (!skip_prefix(s->branch, "refs/heads/", &branch_name))
 		return;
 	branch = branch_get(branch_name);
+
+	t_begin = getnanotime();
+
 	if (!format_tracking_info(branch, &sb, s->ahead_behind_flags))
 		return;
 
+	if (advice_status_ahead_behind_warning &&
+	    s->ahead_behind_flags == AHEAD_BEHIND_FULL) {
+		uint64_t t_delta_in_ms = (getnanotime() - t_begin) / 1000000;
+		if (t_delta_in_ms > AB_DELAY_WARNING_IN_MS) {
+			strbuf_addf(&sb, _("\n"
+					   "It took %.2f seconds to compute the branch ahead/behind values.\n"
+					   "You can use '--no-ahead-behind' to avoid this.\n"),
+				    t_delta_in_ms / 1000.0);
+		}
+	}
+
 	i = 0;
 	if (s->display_comment_prefix) {
 		comment_line_string[i++] = comment_line_char;
-- 
gitgitgadget

