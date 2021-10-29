Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E00C433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CE5960524
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbhJ2VSB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 17:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbhJ2VSA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 17:18:00 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245E3C061570
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 14:15:31 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id o14so18538690wra.12
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 14:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VLJYlvMMxJOwoBX6X+QhjOoCyRxaoUfcnxLfooxmZsc=;
        b=JUqn0Jai9KLnkI7OREB5hyL100N0a5X8aufq82oRhNmOYrzJwMjAFoePc+Eb8U/Nqd
         cW0UfddRILnBKxXCdRATCdAP8TaXOuuB9Y24krxTvq/8uq+K79iKey/NhQ4cp2AC9nTV
         64XRexG+i+PoI+vczF0Kgpc5wmiG2Z8Zgn4TY2aAxQ1HRnVrR/y44z4BgAxxoMKCTK3J
         OpJDSsKI69Ec6NVbMDDIcPPxHYi3VKErocxRK5druP3FIO7U90Seh0gh2RuUgjx/p/xI
         xxwOwQbhhEMgOuKxHr0HF3XXmK/8qKV4sYEEshdDPiJYBkwGkTpkECSau7djwQpqts3b
         0BWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VLJYlvMMxJOwoBX6X+QhjOoCyRxaoUfcnxLfooxmZsc=;
        b=FjgJ4zKEcJpGfBWRV/IyGere6mX2DhNavcLDjSTjeaVrn8PWErSmTQ9RLK5JAZsc1n
         sSygpYYas1iAMApwo4KBVErUrfIk9cKodocxaMbUSmS/h2DFgjJ7Maa65LmX+FefK/YS
         6BF8uqpGGXXhIlTxNBBGX5CePS0bUiywLMtOmgdgD+IccWar15UgAA7hIUgMiAhpvjWm
         LDyGoEHZ6ZtiQTj6ZPa6Zh8wUhnG247ANhHzTKI+dPHKfZQnLrC7NzDF9PDqdHHXqiGe
         i/mugj+a1veXSk37nvTb03XPQnfmU95TV5LU6jo1d46iJW9JebgthWLH/vxyHS3lObRw
         yC/w==
X-Gm-Message-State: AOAM533qqJjJayoMvfDgR2pWL5H7d93glGU/Wnrs3Fct5oLsmcQcX8Im
        LXUNIVjo4r5oh2UFld2Du29+tkKURQY1Vg==
X-Google-Smtp-Source: ABdhPJxS1hFJr9FwsrjdmQHz96CmS+dyOM4ngRwV5CCCZdCWvnqLhFydCf2O38PFeycQ9kyNlgZ4WA==
X-Received: by 2002:a05:600c:378f:: with SMTP id o15mr14339073wmr.63.1635542129609;
        Fri, 29 Oct 2021 14:15:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r1sm10870029wmr.36.2021.10.29.14.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 14:15:29 -0700 (PDT)
Message-Id: <c5e0eda3321043093abbf3a43af994a0222b3e4c.1635542128.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1065.git.1635542128.gitgitgadget@gmail.com>
References: <pull.1065.git.1635542128.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Oct 2021 21:15:24 +0000
Subject: [PATCH 1/4] oneline: parse --newlineafter flag
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

* revision.h: add newlineafter flag type
* builtin/log.c: parse newlineafter flag with callback

Signed-off-by: John Cai <johncai86@gmail.com>
---
 builtin/log.c | 25 +++++++++++++++++++++++++
 revision.h    |  4 ++++
 2 files changed, 29 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index f75d87e8d7f..3758c73760c 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -53,6 +53,7 @@ static int decoration_given;
 static int use_mailmap_config = 1;
 static const char *fmt_patch_subject_prefix = "PATCH";
 static int fmt_patch_name_max = FORMAT_PATCH_NAME_MAX_DEFAULT;
+static int newlineafter = NEWLINEAFTER_NONE;
 static const char *fmt_pretty;
 
 static const char * const builtin_log_usage[] = {
@@ -132,6 +133,27 @@ static int log_line_range_callback(const struct option *option, const char *arg,
 	return 0;
 }
 
+static int parse_newlineafter(const char *value)
+{
+	if (!strcmp(value, "decorations"))
+		return NEWLINEAFTER_DECORATIONS;
+
+	return NEWLINEAFTER_NONE;
+}
+
+static int option_parse_newlineafter(const struct option *opt,
+				   const char *arg, int unset)
+{
+	int *newlineafter = opt->value;
+
+	if (unset)
+		*newlineafter = NEWLINEAFTER_NONE;
+	else
+		*newlineafter = parse_newlineafter(arg);
+
+	return 0;
+}
+
 static void init_log_defaults(void)
 {
 	init_diff_ui_defaults();
@@ -156,6 +178,7 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 	rev->show_signature = default_show_signature;
 	rev->encode_email_headers = default_encode_email_headers;
 	rev->diffopt.flags.allow_textconv = 1;
+	rev->newlineafter = NEWLINEAFTER_NONE;
 
 	if (default_date_mode)
 		parse_date_format(default_date_mode, &rev->date_mode);
@@ -189,6 +212,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 		OPT_CALLBACK('L', NULL, &line_cb, "range:file",
 			     N_("trace the evolution of line range <start>,<end> or function :<funcname> in <file>"),
 			     log_line_range_callback),
+		OPT_CALLBACK(0, "newlineafter", &newlineafter, N_("field"), N_("new line after <field>"), option_parse_newlineafter),
 		OPT_END()
 	};
 
@@ -265,6 +289,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 		load_ref_decorations(&decoration_filter, decoration_style);
 	}
 
+	rev->newlineafter = newlineafter;
 	if (rev->line_level_traverse)
 		line_log_init(rev, line_cb.prefix, &line_cb.args);
 
diff --git a/revision.h b/revision.h
index 5578bb4720a..ff0b89c1f40 100644
--- a/revision.h
+++ b/revision.h
@@ -243,6 +243,10 @@ struct rev_info {
 	int		no_inline;
 	int		show_log_size;
 	struct string_list *mailmap;
+	enum {
+			NEWLINEAFTER_NONE,
+			NEWLINEAFTER_DECORATIONS
+		} newlineafter;
 
 	/* Filter by commit log message */
 	struct grep_opt	grep_filter;
-- 
gitgitgadget

