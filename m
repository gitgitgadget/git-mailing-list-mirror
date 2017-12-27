Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BDB01F406
	for <e@80x24.org>; Wed, 27 Dec 2017 10:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbdL0KUF (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 05:20:05 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42934 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751877AbdL0KUE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 05:20:04 -0500
Received: by mail-pf0-f195.google.com with SMTP id d23so19631875pfe.9
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 02:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wdymww85crXP0T4eotBC8IJ/J5QmEEKaV5MiHe92lnk=;
        b=n6V9fg8nhR1LKBoT/42ZyaJSBR1P2OmHpB3l5t8MtDwVaFnfcPUmzSv+qNZ7dpiFkz
         c7WoFcYodsizuQE5FCKctY+zSgaTwErziIoVg74mSzRN+GUL6NEvRNrs75k75TtbjeQh
         2krac4AGIZmhW1q34k67hFjRiNCABRrYCyPNaQnMWJHdwbxB8Bp9JlOSnp5iIWDU+88o
         X1NZ++kYTRD5zjOgctuSZuVL8Wb4DP0F8P8IoAVRl+t1jXYbVgo5HYRk+5iPHHQB7dCC
         6pyBglNd7a0f1w2ouaAThjFYceygvV2opRxBoZf6Z5UZGfDH42lchkDb58a3HQBFuFLj
         Omxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wdymww85crXP0T4eotBC8IJ/J5QmEEKaV5MiHe92lnk=;
        b=XQWeUF5izMoIDAphTSvqVq6RqyrYXJb5WWyxxY06JOODKREWvOxP1VfEV5SlOD8xak
         t7x8jikKLjRm5V+Klb4gIEg8a7+L2Fr+2kjxSI4q3uPdjF2I51bzg9fVu3Efg0SjbWuy
         f+eLU3smqkx2+AoVEP9o2dCLk3S1u/9ph6GjXbRz4VDDc+8gwevBrrf6D6Zt2O372doN
         sI7W7cXvDwPK3U/TBFXT/aeIN21O6fhbfI8hArwbdfl2FSfUV2gIPSExbnCp/Nu/+CYR
         VXtadDeIPJ9m6hnlYtcBny7++dAnw7SipFVrrmhdM9Wd1HUbwRj+8mkofb5bke1owRgq
         k75g==
X-Gm-Message-State: AKGB3mIUQ2u10WkVE3vOH+Bx6eH6ibk5IhKLMp7d4coowFu3i9ljlCyU
        m32gUYlLOhHKWI9iaBMMPlAxrA==
X-Google-Smtp-Source: ACJfBosk3ZoW5vaDyjN7g2QCMGp2i6xg37NpGRTrvOvQ684MpYJxtuYm5+TJmfVKApiJ3G6howt8cg==
X-Received: by 10.101.101.144 with SMTP id u16mr10769400pgv.158.1514370004100;
        Wed, 27 Dec 2017 02:20:04 -0800 (PST)
Received: from ash ([116.106.0.190])
        by smtp.gmail.com with ESMTPSA id t75sm66490004pfi.146.2017.12.27.02.20.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Dec 2017 02:20:03 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 27 Dec 2017 17:19:59 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     alexmv@dropbox.com, igor.d.djordjevic@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 2/6] Use DIFF_DETECT_RENAME for detect_rename assignments
Date:   Wed, 27 Dec 2017 17:18:35 +0700
Message-Id: <20171227101839.26427-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.0.320.g0453912d77
In-Reply-To: <20171227101839.26427-1-pclouds@gmail.com>
References: <20171226091012.24315-1-pclouds@gmail.com>
 <20171227101839.26427-1-pclouds@gmail.com>
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

