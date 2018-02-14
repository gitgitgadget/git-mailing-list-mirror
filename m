Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 940201F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162594AbeBNTCW (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:02:22 -0500
Received: from mail-ot0-f202.google.com ([74.125.82.202]:43589 "EHLO
        mail-ot0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162588AbeBNTCR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:02:17 -0500
Received: by mail-ot0-f202.google.com with SMTP id l12so3689404oth.10
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=R5i85Zo6PmdES08RaDN9oVSoWl8LqiZnQWFJEieibZ4=;
        b=tmOZ+IGiB62tBnXszgsatdsSNwF0kGD7ZqRFCX9CEQuKbeJTRw99sl3TJS4OnjUBJP
         /6Lzlg9qw03DO0mhsw2agXhF3Ddmg3IlHQ2FGAHUapv1xTlpcOfCmNK2E3tKs+d30OFO
         TJ3Asd1Y1Umy8NLfvhaKuSBSBFCAtkh3uDqMXEd6E0bblc+/w6R9egy7zHTmyXxaWww2
         RGvpzAC2B6Z6x1XoGYG+7tgbPiHpm72VXiDETAVt+ZHvwU3JzIF2Q+q9+mBEVrlbLtvb
         aw02EhsPsOGnHiM3teXml1P4bA8NG886Tcn6w/VvZ9YnmGRcEd4vKuRqMw1x2o7ThXJt
         HBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=R5i85Zo6PmdES08RaDN9oVSoWl8LqiZnQWFJEieibZ4=;
        b=WxmEg1SJy5w3Ur3PkIyNviSbYiS9/JL9wASDomLJTuBN49mjSQrHAV0rfl6Smkebhy
         E5svvoPwzRxCsnxP6dAgegxw8YoXz6siherlkc5IdlP8fgeA8QfcHttSrcyJqfK0WECq
         bOSKLiICY7H7beZXLOyc2cUfjf46+cCC04NF3j0KPGndspURS5HGav7AaAbCSsp7ikC7
         UP7F2N5qzi1ts1dkZvZMztWT/AE3c9nl909/9G5QF97jVXa9QHROhJsAe0l08ABd4A+o
         SUOEDSLrE9xgClKCQkyezg/SQ8WlAP34OITYMPhHIjrbipnMeLFIgTJVYBaRsL+ulSPO
         +uwA==
X-Gm-Message-State: APf1xPBTPGXN1pGj63ei3bm55Gflt1KLHmEl5W9/J5LhG7ihs9Pw5L6L
        VdnRU7FkpyZlhrjesKyQAB3DY+UXQJvuFEbHFKVD6bxziN7+eEl8GMAaaDIqVhDzPWvbSXD+BF3
        57MiyH2Ghx0R+UyY215xPjOEZlIOpXnX1BKuCx3I2mNM+u4Q3WWhDlbldtg==
X-Google-Smtp-Source: AH8x225JXDvoMo77+N7sNBouVjiAcDKs96nhVwtTo3T5Qc/Lq0S5x0f1ZtWYjGpDAIQQEF5zlp4ZUh1XVjM=
MIME-Version: 1.0
X-Received: by 10.202.218.195 with SMTP id r186mr38740oig.15.1518634936390;
 Wed, 14 Feb 2018 11:02:16 -0800 (PST)
Date:   Wed, 14 Feb 2018 10:59:57 -0800
In-Reply-To: <20180214185959.221906-1-bmwill@google.com>
Message-Id: <20180214185959.221906-36-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com> <20180214185959.221906-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.109.g93438bbb9.dirty
Subject: [PATCH v2 35/37] tempfile: rename 'template' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, sbeller@google.com, avarab@gmail.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 tempfile.c | 12 ++++++------
 tempfile.h | 34 +++++++++++++++++-----------------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/tempfile.c b/tempfile.c
index 5fdafdd2d..139ecd97f 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -165,11 +165,11 @@ struct tempfile *register_tempfile(const char *path)
 	return tempfile;
 }
 
-struct tempfile *mks_tempfile_sm(const char *template, int suffixlen, int mode)
+struct tempfile *mks_tempfile_sm(const char *filename_template, int suffixlen, int mode)
 {
 	struct tempfile *tempfile = new_tempfile();
 
-	strbuf_add_absolute_path(&tempfile->filename, template);
+	strbuf_add_absolute_path(&tempfile->filename, filename_template);
 	tempfile->fd = git_mkstemps_mode(tempfile->filename.buf, suffixlen, mode);
 	if (tempfile->fd < 0) {
 		deactivate_tempfile(tempfile);
@@ -179,7 +179,7 @@ struct tempfile *mks_tempfile_sm(const char *template, int suffixlen, int mode)
 	return tempfile;
 }
 
-struct tempfile *mks_tempfile_tsm(const char *template, int suffixlen, int mode)
+struct tempfile *mks_tempfile_tsm(const char *filename_template, int suffixlen, int mode)
 {
 	struct tempfile *tempfile = new_tempfile();
 	const char *tmpdir;
@@ -188,7 +188,7 @@ struct tempfile *mks_tempfile_tsm(const char *template, int suffixlen, int mode)
 	if (!tmpdir)
 		tmpdir = "/tmp";
 
-	strbuf_addf(&tempfile->filename, "%s/%s", tmpdir, template);
+	strbuf_addf(&tempfile->filename, "%s/%s", tmpdir, filename_template);
 	tempfile->fd = git_mkstemps_mode(tempfile->filename.buf, suffixlen, mode);
 	if (tempfile->fd < 0) {
 		deactivate_tempfile(tempfile);
@@ -198,12 +198,12 @@ struct tempfile *mks_tempfile_tsm(const char *template, int suffixlen, int mode)
 	return tempfile;
 }
 
-struct tempfile *xmks_tempfile_m(const char *template, int mode)
+struct tempfile *xmks_tempfile_m(const char *filename_template, int mode)
 {
 	struct tempfile *tempfile;
 	struct strbuf full_template = STRBUF_INIT;
 
-	strbuf_add_absolute_path(&full_template, template);
+	strbuf_add_absolute_path(&full_template, filename_template);
 	tempfile = mks_tempfile_m(full_template.buf, mode);
 	if (!tempfile)
 		die_errno("Unable to create temporary file '%s'",
diff --git a/tempfile.h b/tempfile.h
index 450908b2e..8959c5f1b 100644
--- a/tempfile.h
+++ b/tempfile.h
@@ -135,58 +135,58 @@ extern struct tempfile *register_tempfile(const char *path);
  */
 
 /* See "mks_tempfile functions" above. */
-extern struct tempfile *mks_tempfile_sm(const char *template,
+extern struct tempfile *mks_tempfile_sm(const char *filename_template,
 					int suffixlen, int mode);
 
 /* See "mks_tempfile functions" above. */
-static inline struct tempfile *mks_tempfile_s(const char *template,
+static inline struct tempfile *mks_tempfile_s(const char *filename_template,
 					      int suffixlen)
 {
-	return mks_tempfile_sm(template, suffixlen, 0600);
+	return mks_tempfile_sm(filename_template, suffixlen, 0600);
 }
 
 /* See "mks_tempfile functions" above. */
-static inline struct tempfile *mks_tempfile_m(const char *template, int mode)
+static inline struct tempfile *mks_tempfile_m(const char *filename_template, int mode)
 {
-	return mks_tempfile_sm(template, 0, mode);
+	return mks_tempfile_sm(filename_template, 0, mode);
 }
 
 /* See "mks_tempfile functions" above. */
-static inline struct tempfile *mks_tempfile(const char *template)
+static inline struct tempfile *mks_tempfile(const char *filename_template)
 {
-	return mks_tempfile_sm(template, 0, 0600);
+	return mks_tempfile_sm(filename_template, 0, 0600);
 }
 
 /* See "mks_tempfile functions" above. */
-extern struct tempfile *mks_tempfile_tsm(const char *template,
+extern struct tempfile *mks_tempfile_tsm(const char *filename_template,
 					 int suffixlen, int mode);
 
 /* See "mks_tempfile functions" above. */
-static inline struct tempfile *mks_tempfile_ts(const char *template,
+static inline struct tempfile *mks_tempfile_ts(const char *filename_template,
 					       int suffixlen)
 {
-	return mks_tempfile_tsm(template, suffixlen, 0600);
+	return mks_tempfile_tsm(filename_template, suffixlen, 0600);
 }
 
 /* See "mks_tempfile functions" above. */
-static inline struct tempfile *mks_tempfile_tm(const char *template, int mode)
+static inline struct tempfile *mks_tempfile_tm(const char *filename_template, int mode)
 {
-	return mks_tempfile_tsm(template, 0, mode);
+	return mks_tempfile_tsm(filename_template, 0, mode);
 }
 
 /* See "mks_tempfile functions" above. */
-static inline struct tempfile *mks_tempfile_t(const char *template)
+static inline struct tempfile *mks_tempfile_t(const char *filename_template)
 {
-	return mks_tempfile_tsm(template, 0, 0600);
+	return mks_tempfile_tsm(filename_template, 0, 0600);
 }
 
 /* See "mks_tempfile functions" above. */
-extern struct tempfile *xmks_tempfile_m(const char *template, int mode);
+extern struct tempfile *xmks_tempfile_m(const char *filename_template, int mode);
 
 /* See "mks_tempfile functions" above. */
-static inline struct tempfile *xmks_tempfile(const char *template)
+static inline struct tempfile *xmks_tempfile(const char *filename_template)
 {
-	return xmks_tempfile_m(template, 0600);
+	return xmks_tempfile_m(filename_template, 0600);
 }
 
 /*
-- 
2.16.1.291.g4437f3f132-goog

