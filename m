Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CFDE1F424
	for <e@80x24.org>; Tue, 26 Dec 2017 09:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750924AbdLZJKj (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Dec 2017 04:10:39 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33587 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750708AbdLZJKi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Dec 2017 04:10:38 -0500
Received: by mail-pf0-f193.google.com with SMTP id y89so18542412pfk.0
        for <git@vger.kernel.org>; Tue, 26 Dec 2017 01:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wdymww85crXP0T4eotBC8IJ/J5QmEEKaV5MiHe92lnk=;
        b=dBL5PDnbyy682KVNbWVIywygozrERS9RMzOnt/SXNSsZAwazd7bMTAPdRPMJK9Zfmy
         LARkXQovjf8arUrpVbDVMMAbqrBrA09y+KEj8yOqj/IIK59b90uoSN7mFXIuUWIrQEvs
         OIAa19O96HEyEHyvJuZycQYJT00/utzPhdKbOixjMd6Ymvh7IsT1Z+GKZ90xKZz8kwqn
         8zvOZuyfOAN/CMRCfm4ude+QDyaObnktbcXjjLyRZuGA4rA9jqrLkPSy/5IeM2gObcN9
         GNrfNOHWogJK1nCSmKQ12THcvNoSm0Ta57EksAB7lF/vwV/yU90CrX5VgKVTFhTsXJ7L
         /yjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wdymww85crXP0T4eotBC8IJ/J5QmEEKaV5MiHe92lnk=;
        b=a37jBAiRt6POuGszJ8cx4adP1FmHmzvrU8WexBxlKWaOmv5bAFn62WQrnNIPQHObw1
         XyL3ipLuZtaLyCXzP6nxFKdRyLTR+ovfEmb4rq4HfhqZ7+XeTYOi87py6dPnkmwJM4au
         iYZqQ0Sh0s/YlhS1tmTi9CJNZIHVm5AC+WMQXxKMqtcWVq00cueUwWqx/5cgjebJcD9k
         wYYqAyvhKcLgtJ2yqJQ6P6llQhnZ7TINwlCMnBY3wqPauH6n+oN32jtuRp6tFfBZPk5u
         Ch2OFKBfwzPWNjSydZk2iWGTsq9yFR1JfMr+mQ+kBVeKvAS3qkDDGWB/UP88QTZsSNQ9
         cvIQ==
X-Gm-Message-State: AKGB3mLzVHn34FYrG6bNczet91xpnkk+vHPSZ4w5T7g6n16YzCVCYHLa
        WwvTB3aC3Onl5hLT7/n8Yn9OOg==
X-Google-Smtp-Source: ACJfBouLxVaxH6QbYWbzVN654+VlP0vZFrKcEf2RE0EsDKoQvrOONxCobOCjLKadQmi6sC7sz963ag==
X-Received: by 10.98.112.3 with SMTP id l3mr10860510pfc.11.1514279437883;
        Tue, 26 Dec 2017 01:10:37 -0800 (PST)
Received: from ash ([116.106.0.190])
        by smtp.gmail.com with ESMTPSA id f80sm25988566pfk.142.2017.12.26.01.10.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Dec 2017 01:10:37 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 26 Dec 2017 16:10:32 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     alexmv@dropbox.com, igor.d.djordjevic@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 2/7] Use DIFF_DETECT_RENAME for detect_rename assignments
Date:   Tue, 26 Dec 2017 16:10:07 +0700
Message-Id: <20171226091012.24315-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.0.320.g0453912d77
In-Reply-To: <20171226091012.24315-1-pclouds@gmail.com>
References: <20171225103718.24443-1-pclouds@gmail.com>
 <20171226091012.24315-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This field can have two values (2 for copy). Use this name instead for
clarity. Many places have already used this constant.

Note, the detect_rename assignments in merge-recursive.c remain
unchanged because it's actually a boolean there.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/commit.c | 2 +-
 diff.c           | 2 +-
 wt-status.c      | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 8a87701414..1f11e3992d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1507,7 +1507,7 @@ static void print_summary(const char *prefix, const struct object_id *oid,
 	rev.show_root_diff = 1;
 	get_commit_format(format.buf, &rev);
 	rev.always_show_header = 0;
-	rev.diffopt.detect_rename = 1;
+	rev.diffopt.detect_rename = DIFF_DETECT_RENAME;
 	rev.diffopt.break_opt = 0;
 	diff_setup_done(&rev.diffopt);
 
diff --git a/diff.c b/diff.c
index 3fb445a54d..51fe31c7aa 100644
--- a/diff.c
+++ b/diff.c
@@ -246,7 +246,7 @@ static int parse_ws_error_highlight(const char *arg)
  */
 void init_diff_ui_defaults(void)
 {
-	diff_detect_rename_default = 1;
+	diff_detect_rename_default = DIFF_DETECT_RENAME;
 }
 
 int git_diff_heuristic_config(const char *var, const char *value, void *cb)
diff --git a/wt-status.c b/wt-status.c
index ef26f07446..59338adb8b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -602,7 +602,7 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = wt_status_collect_updated_cb;
 	rev.diffopt.format_callback_data = s;
-	rev.diffopt.detect_rename = 1;
+	rev.diffopt.detect_rename = DIFF_DETECT_RENAME;
 	rev.diffopt.rename_limit = 200;
 	rev.diffopt.break_opt = 0;
 	copy_pathspec(&rev.prune_data, &s->pathspec);
@@ -962,7 +962,7 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
 	setup_revisions(0, NULL, &rev, &opt);
 
 	rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
-	rev.diffopt.detect_rename = 1;
+	rev.diffopt.detect_rename = DIFF_DETECT_RENAME;
 	rev.diffopt.file = s->fp;
 	rev.diffopt.close_file = 0;
 	/*
-- 
2.15.0.320.g0453912d77

