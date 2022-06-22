Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA75CCA481
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 17:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377073AbiFVRIs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 13:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377227AbiFVRIS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 13:08:18 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6569241F97
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 10:07:16 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id i10so20558144wrc.0
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 10:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=r84uSxyS9NFE40qDPHWXRaofWcK47No3z+vJMkna9PE=;
        b=CR1XPNudzuHsD8stc478dLq2l8rMMt+kk6pUv+f9rHH9rM+8BPNfiQ6yh9ZSGc2xGH
         f/l09TC4rZHecqXqRgXxDPUTwHze5wpvJYDfuM0AkTd2TqpKFkcLmPZc55bM1Q5alC4/
         LAaFwo5nv+Uu4sojxNB0XIxp3C/0uLr4x2eQIKz88MHz/hDZfbzdnc0ujx64iYytqRvm
         NaJX+/F4DjcJLrmtq6CNe8T+g+4x9ik/6zxNcIF9gxeDhSpRJOCZVrrZd7+z0/KEgZv0
         VwQ612eePQYCRtZ0EbZtd4VYkWFF1h3ufmDYWy+b21npA1ubCkFef8p6K+uirgd1HsHG
         bzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=r84uSxyS9NFE40qDPHWXRaofWcK47No3z+vJMkna9PE=;
        b=sSP2gkh/ZcrTgUsIRgVqVpVLtANzGHU9PCQUBMsDdWNZ+WuvYWCHmshQ/dZpKb4kCU
         HdtyW3jOkVwB0v1cMF1pDNdJccOb0yYd7Ae1sihOGbzWNmeHkuUwGKX7aW+ZBw6MO9/9
         dlQ+Nr/CzuqjXU/9cse3CnZSCiPpa3A8oelGLIIgygHx/gxk+p9uR4DCrT7DP6M8Ta9S
         cNLRLq8wbNW4JlzcrOP7lUso/EmklXmZnlOxo/2qOFcwJI64Q3h1vRaCF4vFy1EnRKsI
         CMUA9mhEWZKHB7M8tZuCDNtLGqNRBqlhMlA/bXBvRBDIAR6dNaMJAZZMq+qQ9XqHypCZ
         3wDg==
X-Gm-Message-State: AJIora+rcf22i7RFRGJIeUHeD736DrJ1CySw5c59VpbTpjtV1KMzjBBi
        OOUzJ18EbnG285kA1IhYSMekuQ3XBOjTkg==
X-Google-Smtp-Source: AGRyM1v2/KuHQNxstyc7O037P4W8NvmMFvKdn7bWxTHUjsRQpUF3cMA29fQgTQAW4+NhtA5pel3VRw==
X-Received: by 2002:a5d:5888:0:b0:218:733:4cd9 with SMTP id n8-20020a5d5888000000b0021807334cd9mr4589940wrf.619.1655917631159;
        Wed, 22 Jun 2022 10:07:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d3-20020adffbc3000000b0020e6ce4dabdsm19806494wrs.103.2022.06.22.10.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 10:07:10 -0700 (PDT)
Message-Id: <5bf7244437e30ae0810e323016de892b82365b12.1655917628.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1278.v3.git.git.1655917628.gitgitgadget@gmail.com>
References: <pull.1278.v2.git.git.1655789777023.gitgitgadget@gmail.com>
        <pull.1278.v3.git.git.1655917628.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Carlos=20L=C3=B3pez?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 22 Jun 2022 17:07:07 +0000
Subject: [PATCH v3 1/2] grep: add --max-count command line option
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     "Martin =?UTF-8?Q?=C3=85gren?= [ ]" <martin.agren@gmail.com>,
        "Paul Eggert [ ]" <eggert@cs.ucla.edu>,
        "Carlos L." <00xc@protonmail.com>,
        =?UTF-8?q?Carlos=20L=C3=B3pez?= <00xc@protonmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Carlos=20L=C3=B3pez?= <00xc@protonmail.com>

This patch adds a command line option analogous to that of GNU
grep(1)'s -m / --max-count, which users might already be used to.
This makes it possible to limit the amount of matches shown in the
output while keeping the functionality of other options such as -C
(show code context) or -p (show containing function), which would be
difficult to do with a shell pipeline (e.g. head(1)).

Signed-off-by: Carlos López 00xc@protonmail.com
---
 Documentation/git-grep.txt | 9 +++++++++
 builtin/grep.c             | 9 +++++++++
 grep.c                     | 2 +-
 grep.h                     | 2 ++
 4 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 3d393fbac1b..58d944bd578 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -23,6 +23,7 @@ SYNOPSIS
 	   [--break] [--heading] [-p | --show-function]
 	   [-A <post-context>] [-B <pre-context>] [-C <context>]
 	   [-W | --function-context]
+	   [(-m | --max-count) <num>]
 	   [--threads <num>]
 	   [-f <file>] [-e] <pattern>
 	   [--and|--or|--not|(|)|-e <pattern>...]
@@ -238,6 +239,14 @@ providing this option will cause it to die.
 	`git diff` works out patch hunk headers (see 'Defining a
 	custom hunk-header' in linkgit:gitattributes[5]).
 
+-m <num>::
+--max-count <num>::
+	Limit the amount of matches per file. When using the `-v` or
+	`--invert-match` option, the search stops after the specified
+	number of non-matches. A value of -1 will return unlimited
+	results (the default). A value of 0 will exit immediately with
+	a non-zero status.
+
 --threads <num>::
 	Number of grep worker threads to use.
 	See `grep.threads` in 'CONFIGURATION' for more information.
diff --git a/builtin/grep.c b/builtin/grep.c
index bcb07ea7f75..e6bcdf860cc 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -961,6 +961,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_BOOL_F(0, "ext-grep", &external_grep_allowed__ignored,
 			   N_("allow calling of grep(1) (ignored by this build)"),
 			   PARSE_OPT_NOCOMPLETE),
+		OPT_INTEGER('m', "max-count", &opt.max_count,
+			N_("maximum number of results per file")),
 		OPT_END()
 	};
 	grep_prefix = prefix;
@@ -1101,6 +1103,13 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	if (recurse_submodules && untracked)
 		die(_("--untracked not supported with --recurse-submodules"));
 
+	/*
+	 * Optimize out the case where the amount of matches is limited to zero.
+	 * We do this to keep results consistent with GNU grep(1).
+	 */
+	if (opt.max_count == 0)
+		return 1;
+
 	if (show_in_pager) {
 		if (num_threads > 1)
 			warning(_("invalid option combination, ignoring --threads"));
diff --git a/grep.c b/grep.c
index 82eb7da1022..52a894c9890 100644
--- a/grep.c
+++ b/grep.c
@@ -1615,7 +1615,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 				return 0;
 			goto next_line;
 		}
-		if (hit) {
+		if (hit && (opt->max_count < 0 || count < opt->max_count)) {
 			count++;
 			if (opt->status_only)
 				return 1;
diff --git a/grep.h b/grep.h
index c722d25ed9d..bdcadce61b8 100644
--- a/grep.h
+++ b/grep.h
@@ -171,6 +171,7 @@ struct grep_opt {
 	int show_hunk_mark;
 	int file_break;
 	int heading;
+	int max_count;
 	void *priv;
 
 	void (*output)(struct grep_opt *opt, const void *data, size_t size);
@@ -181,6 +182,7 @@ struct grep_opt {
 	.relative = 1, \
 	.pathname = 1, \
 	.max_depth = -1, \
+	.max_count = -1, \
 	.pattern_type_option = GREP_PATTERN_TYPE_UNSPECIFIED, \
 	.colors = { \
 		[GREP_COLOR_CONTEXT] = "", \
-- 
gitgitgadget

