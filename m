Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 068591F576
	for <e@80x24.org>; Mon, 12 Feb 2018 09:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933397AbeBLJuc (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 04:50:32 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:34657 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933377AbeBLJu2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 04:50:28 -0500
Received: by mail-ot0-f194.google.com with SMTP id l10so13482562oth.1
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 01:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tpCuAc3Rkr9W0J8i49fjhhHZBD1iCVzjNAap4liINL4=;
        b=uGfErgZlcfwK77CsLMA+AQa6uPsL/l5/GhgOzBbU7itd11lNLJQ1rdFyYKOjK9Do5R
         bYMr+DL4x2knfWczxNpxmWwkFJ4oywqlqEJ8Jj8rUPRznUaosMIOPI/q66TbWFh/+YS+
         QoJt0zewnFDZb2fUh7cS5SbcIqGn53rmLWGPXu3nOwzA64w8YfZWAlcSKWkyiJhqmiaE
         1Cgdd4NVv4wSaQJKa4JzbkTVHF0hZgzO/Q3FqeIDeyLrOT8kwV9NQY0zm1jwahoDIfoc
         FuiSUiPM8WK434uNs6RgVS9GzWDdKkCgHKYe00x7L0WiKNJ1pbOPYt9WhF645eDTOq3d
         JDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tpCuAc3Rkr9W0J8i49fjhhHZBD1iCVzjNAap4liINL4=;
        b=ejxDBoWo4vAy4K6NLo26N4J8SAl2xPDxDKF6m4xf3wKvjFBcG3UAdHSIQrkW5NQuuf
         NDf3pKdYhA7gPNjfw3DL78Nd21QFcNWQ0jtv8p5kqcQKaHGpy92fCrIWTsRxjm0HQ5Tk
         nBcaVcRPopqORFiUHG20Db7UfohYqx9gi0zbjWjYNZk4JA5EVDMyLjYfxTW9rJZg7Cet
         X6JG9aodrUMZR1eZJEzqgofJgdbp4vP4U8NQFa9E2qEjHT+Ata2UgTG/7d0ARt0rEERK
         auABxFiahBsEbS+Y87kVrL9G62T/wlC8Z91+wb3mRML2t01MYmHbwbCSo/WXwElInFgL
         xKVg==
X-Gm-Message-State: APf1xPBiu8cIOPZKRaJmOagSz+Z1tWgP4/PTDTDUrUxV/gmOD/NHbIog
        mpZDQ8lJuaArQzV0qspqZmrJ1g==
X-Google-Smtp-Source: AH8x226tm/HoYVRVSdl8j3clR3CkqKvoGMGg+1MBr05a4EpmDuc3JPTnLORGl5YT8JWhSinaZp8svQ==
X-Received: by 10.157.54.241 with SMTP id s46mr7963612otd.261.1518429027436;
        Mon, 12 Feb 2018 01:50:27 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id r185sm3990903oie.34.2018.02.12.01.50.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Feb 2018 01:50:26 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 12 Feb 2018 16:50:21 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        kaartic.sivaraam@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 4/7] worktree move: accept destination as directory
Date:   Mon, 12 Feb 2018 16:49:37 +0700
Message-Id: <20180212094940.23834-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.399.g632f88eed1
In-Reply-To: <20180212094940.23834-1-pclouds@gmail.com>
References: <20180124095357.19645-1-pclouds@gmail.com>
 <20180212094940.23834-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to "mv a b/", which is actually "mv a b/a", we extract basename
of source worktree and create a directory of the same name at
destination if dst path is a directory.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/worktree.c       | 11 ++++++++++-
 strbuf.c                 |  8 ++++++++
 strbuf.h                 |  3 +++
 t/t2028-worktree-move.sh | 11 +++++++++++
 4 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 8b9482d1e5..6fe41313c9 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -631,8 +631,17 @@ static int move_worktree(int ac, const char **av, const char *prefix)
 		die(_("'%s' is not a working tree"), av[0]);
 	if (is_main_worktree(wt))
 		die(_("'%s' is a main working tree"), av[0]);
+	if (is_directory(dst.buf)) {
+		const char *sep = find_last_dir_sep(wt->path);
+
+		if (!sep)
+			die(_("could not figure out destination name from '%s'"),
+			    wt->path);
+		strbuf_trim_trailing_dir_sep(&dst);
+		strbuf_addstr(&dst, sep);
+	}
 	if (file_exists(dst.buf))
-		die(_("target '%s' already exists"), av[1]);
+		die(_("target '%s' already exists"), dst.buf);
 
 	reason = is_worktree_locked(wt);
 	if (reason) {
diff --git a/strbuf.c b/strbuf.c
index 1df674e919..46930ad027 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -95,6 +95,7 @@ void strbuf_trim(struct strbuf *sb)
 	strbuf_rtrim(sb);
 	strbuf_ltrim(sb);
 }
+
 void strbuf_rtrim(struct strbuf *sb)
 {
 	while (sb->len > 0 && isspace((unsigned char)sb->buf[sb->len - 1]))
@@ -102,6 +103,13 @@ void strbuf_rtrim(struct strbuf *sb)
 	sb->buf[sb->len] = '\0';
 }
 
+void strbuf_trim_trailing_dir_sep(struct strbuf *sb)
+{
+	while (sb->len > 0 && is_dir_sep((unsigned char)sb->buf[sb->len - 1]))
+		sb->len--;
+	sb->buf[sb->len] = '\0';
+}
+
 void strbuf_ltrim(struct strbuf *sb)
 {
 	char *b = sb->buf;
diff --git a/strbuf.h b/strbuf.h
index 14c8c10d66..e6cae5f439 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -179,6 +179,9 @@ extern void strbuf_trim(struct strbuf *);
 extern void strbuf_rtrim(struct strbuf *);
 extern void strbuf_ltrim(struct strbuf *);
 
+/* Strip trailing directory separators */
+extern void strbuf_trim_trailing_dir_sep(struct strbuf *);
+
 /**
  * Replace the contents of the strbuf with a reencoded form.  Returns -1
  * on error, 0 on success.
diff --git a/t/t2028-worktree-move.sh b/t/t2028-worktree-move.sh
index 0f8abc0854..deb486cd8e 100755
--- a/t/t2028-worktree-move.sh
+++ b/t/t2028-worktree-move.sh
@@ -85,4 +85,15 @@ test_expect_success 'move main worktree' '
 	test_must_fail git worktree move . def
 '
 
+test_expect_success 'move worktree to another dir' '
+	toplevel="$(pwd)" &&
+	mkdir some-dir &&
+	git worktree move destination some-dir &&
+	test_path_is_missing source &&
+	git worktree list --porcelain | grep "^worktree.*/some-dir/destination" &&
+	git -C some-dir/destination log --format=%s >actual2 &&
+	echo init >expected2 &&
+	test_cmp expected2 actual2
+'
+
 test_done
-- 
2.16.1.399.g632f88eed1

