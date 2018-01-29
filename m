Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CB8C1FAE2
	for <e@80x24.org>; Mon, 29 Jan 2018 22:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752335AbeA2WjF (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:39:05 -0500
Received: from mail-ot0-f202.google.com ([74.125.82.202]:42361 "EHLO
        mail-ot0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751937AbeA2WjD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:39:03 -0500
Received: by mail-ot0-f202.google.com with SMTP id e19so6450222otj.9
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 14:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=p6HDXZ0roiEZ/PtueHFKwirpSiB5adwwB/6XOA4O74U=;
        b=EeqbU/eWnGa7fnNuHiCKTUqnzHLGDm/bqhlG17jnQcVe73OO5V0cvqRQF171wLmFmt
         pNWbb1rFk77JrZeKjXVEM9248N7tfRQaAOQJXjFIQNsKFgyvQc58CPBwqHNx8Qn36QGY
         inbwwuYijGZjHArUb4Qat4mJboBIwWn7idMiF3Rtv+QUKS+9C/18TDnz0UMNgBD1hp7E
         enQOe1Q+ZFfmUZEHK8IylOQwhDgVfQaJMyfo/Kf3sSPRzljSQKjzRBSh9Vt8bSIXuyIT
         sCH+6tuWVm4MR5l+K+RiYZ8gI6MFA6Y5EmmXXTaiMTwRUJhHSPTKCy10yBV5cJ6D6WOP
         jD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=p6HDXZ0roiEZ/PtueHFKwirpSiB5adwwB/6XOA4O74U=;
        b=g0x2lt5fD6NJYWM+zbwegCBbQbL0k7su0/8vLIS215/c67k6sL2sfWyLRv7hZvRw1g
         79EV9znQw+k3GLE5UanQejKxzxlfwTwvXhXYkL2Bl/wkXVMx/mGoKu+nCS4YqcV6HAzJ
         WKg5Sa3swDDU6d8lLIyz5alI0VuWXFdI8AC4+MGtvhvawtdFBeCs/gvsgEUNg/m4csvk
         VJrFLU97BFwApYMXZiUjKEmVn5RQmAgsaCcGAqWAL/3ZkuaUSk0cpGSNHjMZGnhabSC0
         6b/oLJ87p/ymOhZF2Xb9O/Upu93esMbrKlZxAyLaxitnFZU5jlVbqND4Ex0P5TWy60gS
         qGSA==
X-Gm-Message-State: AKwxytdgSYUzRZJWbqC/FHpfkQywqbHcHPoV3kjw9egT40pkcIWvBP1K
        GaQxfoInqZC+9YhEy0nxo8CCZxRAjQajU6C+YR2pSp1KVN+SBwJsrGYwy0pcxp7r02wCVndvDfT
        c/0Ip0K3Y+i+Cr460jrCXrKRy3Eq0aW6KykFuCk9JZrR1wpaeSgK8Vbjung==
X-Google-Smtp-Source: AH8x225S5Mu/vzTaKApBItMolivEI2nYA3XJxwlvKfkrhWF0y0/OcqiNX+kgP/jPE8KGVVjSNgHq0sReJpo=
MIME-Version: 1.0
X-Received: by 10.157.95.130 with SMTP id g2mr10158625oti.73.1517265542701;
 Mon, 29 Jan 2018 14:39:02 -0800 (PST)
Date:   Mon, 29 Jan 2018 14:37:26 -0800
In-Reply-To: <20180129223728.30569-1-bmwill@google.com>
Message-Id: <20180129223728.30569-36-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH 35/37] tempfile: rename 'template' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, avarab@gmail.com,
        Brandon Williams <bmwill@google.com>
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
2.16.0.rc1.238.g530d649a79-goog

