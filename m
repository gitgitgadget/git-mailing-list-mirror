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
	by dcvr.yhbt.net (Postfix) with ESMTP id F3D901F462
	for <e@80x24.org>; Fri, 24 May 2019 09:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390100AbfEXJY5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 05:24:57 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40801 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389787AbfEXJY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 05:24:56 -0400
Received: by mail-pg1-f196.google.com with SMTP id d30so4740858pgm.7
        for <git@vger.kernel.org>; Fri, 24 May 2019 02:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d2wOxNCt+FPNfebWjxvOuoSawQQz8cpz65cxOkj61I0=;
        b=K40vTBethlrdvkffpMirpm5L54tKX4j+TKt1vf+btESFbm/vrk0dwY7okxpZI4XcFa
         GOFgD/x3701a120I389EuwgffY5m1f6si/ZzpJP77exIrIb6AFTI142xMZ5ut2KQ+zGU
         +UiNMUchXoMTAyTJkefpmwn1kedYFDyVfCQI9kR+ezODdiBvis6DD9T/9uYq/ZJB/KjS
         YTmKLJahxHU6LajXFI6VjtoyrF0/r2E432Gk91Rlv1gfDrG+acLMjbGr9WcK7P6CvLmd
         s1hS1LtTf6NP0DbuZG5W9Bt3QUq/w1G9B+RG5HJ3sn7Ub0OdV2QH8azNIB9uHqWCPnXz
         +cQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d2wOxNCt+FPNfebWjxvOuoSawQQz8cpz65cxOkj61I0=;
        b=hIdY+GDAHpWwY/TJaixRalGabSq53HsLkmUaNOCJwmyraycvfKwlV2jSf0OEu6Rq3w
         0YqH4mn4l4Y5gptaav8UFPi1XHd2mAUF3V4qKIi/Tmfk7NL3loBCMbr4V1mNw61fjj7+
         oKeq6jzAY9KA3CORGCg20KJJSGw/u6KJlGuvTyRcWNg0R+eViRMxfxGweC0GRP5i5avB
         n1NrbusXaA5XAaNalChD/WdSv3knMJRfwXYyczWoTQkAiyvRwmvA4ljyckTSVIa2TzDm
         nW6gw0p0XaXQSkOpu8JTPrW57L1Rb0DEX4SoEyAIfvBG+YCgSFg1OjnM07r1NvoqqdB1
         CQfw==
X-Gm-Message-State: APjAAAXQKyhMsVcL61ewAZi1a7QgrysTOZFk28+aoaL3k3HzrWPu3iKY
        yu/HE82DSZ9ae9T6h8Ga6KBpk2eO
X-Google-Smtp-Source: APXvYqyLtAjEQcOzq01iUT1PxI/0EqNRgp7Uv6EY2/s8UGAkPrUryjd0GpOlvJc+W4kKEmCpLDogdQ==
X-Received: by 2002:a17:90a:35c:: with SMTP id 28mr7366895pjf.110.1558689895406;
        Fri, 24 May 2019 02:24:55 -0700 (PDT)
Received: from ash ([115.72.28.243])
        by smtp.gmail.com with ESMTPSA id 4sm3072854pfj.111.2019.05.24.02.24.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 02:24:54 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 24 May 2019 16:24:50 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, bturner@atlassian.com, tmz@pobox.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/3] diff-parseopt: correct variable types that are used by parseopt
Date:   Fri, 24 May 2019 16:24:40 +0700
Message-Id: <20190524092442.701-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
In-Reply-To: <20190524092442.701-1-pclouds@gmail.com>
References: <20190524092442.701-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most number-related OPT_ macros store the value in an 'int'
variable. Many of the variables in 'struct diff_options' have a
different type, but during the conversion to using parse_options() I
failed to notice and correct.

The problem was reported on s360x which is a big-endian
architechture. The variable to store '-w' option in this case is
xdl_opts, 'long' type, 8 bytes. But since parse_options() assumes
'int' (4 bytes), it will store bits in the wrong part of xdl_opts. The
problem was found on little-endian platforms because parse_options()
will accidentally store at the right part of xdl_opts.

There aren't much to say about the type change (except that 'int' for
xdl_opts should still be big enough, since Windows' long is the same
size as 'int' and nobody has complained so far). Some safety checks may
be implemented in the future to prevent class of bugs.

Reported-by: Todd Zullinger <tmz@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.h | 70 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/diff.h b/diff.h
index b20cbcc091..4527daf6b7 100644
--- a/diff.h
+++ b/diff.h
@@ -65,39 +65,39 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 
 #define DIFF_FLAGS_INIT { 0 }
 struct diff_flags {
-	unsigned recursive;
-	unsigned tree_in_recursive;
-	unsigned binary;
-	unsigned text;
-	unsigned full_index;
-	unsigned silent_on_remove;
-	unsigned find_copies_harder;
-	unsigned follow_renames;
-	unsigned rename_empty;
-	unsigned has_changes;
-	unsigned quick;
-	unsigned no_index;
-	unsigned allow_external;
-	unsigned exit_with_status;
-	unsigned reverse_diff;
-	unsigned check_failed;
-	unsigned relative_name;
-	unsigned ignore_submodules;
-	unsigned dirstat_cumulative;
-	unsigned dirstat_by_file;
-	unsigned allow_textconv;
-	unsigned textconv_set_via_cmdline;
-	unsigned diff_from_contents;
-	unsigned dirty_submodules;
-	unsigned ignore_untracked_in_submodules;
-	unsigned ignore_dirty_submodules;
-	unsigned override_submodule_config;
-	unsigned dirstat_by_line;
-	unsigned funccontext;
-	unsigned default_follow_renames;
-	unsigned stat_with_summary;
-	unsigned suppress_diff_headers;
-	unsigned dual_color_diffed_diffs;
+	unsigned int recursive;
+	unsigned int tree_in_recursive;
+	unsigned int binary;
+	unsigned int text;
+	unsigned int full_index;
+	unsigned int silent_on_remove;
+	unsigned int find_copies_harder;
+	unsigned int follow_renames;
+	unsigned int rename_empty;
+	unsigned int has_changes;
+	unsigned int quick;
+	unsigned int no_index;
+	unsigned int allow_external;
+	unsigned int exit_with_status;
+	unsigned int reverse_diff;
+	unsigned int check_failed;
+	unsigned int relative_name;
+	unsigned int ignore_submodules;
+	unsigned int dirstat_cumulative;
+	unsigned int dirstat_by_file;
+	unsigned int allow_textconv;
+	unsigned int textconv_set_via_cmdline;
+	unsigned int diff_from_contents;
+	unsigned int dirty_submodules;
+	unsigned int ignore_untracked_in_submodules;
+	unsigned int ignore_dirty_submodules;
+	unsigned int override_submodule_config;
+	unsigned int dirstat_by_line;
+	unsigned int funccontext;
+	unsigned int default_follow_renames;
+	unsigned int stat_with_summary;
+	unsigned int suppress_diff_headers;
+	unsigned int dual_color_diffed_diffs;
 };
 
 static inline void diff_flags_or(struct diff_flags *a,
@@ -151,7 +151,7 @@ struct diff_options {
 	int skip_stat_unmatch;
 	int line_termination;
 	int output_format;
-	unsigned pickaxe_opts;
+	unsigned int pickaxe_opts;
 	int rename_score;
 	int rename_limit;
 	int needed_rename_limit;
@@ -169,7 +169,7 @@ struct diff_options {
 	const char *prefix;
 	int prefix_length;
 	const char *stat_sep;
-	long xdl_opts;
+	int xdl_opts;
 
 	/* see Documentation/diff-options.txt */
 	char **anchors;
-- 
2.22.0.rc0.322.g2b0371e29a

