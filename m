Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D62322339
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 08:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774772899; cv=none; b=f9Rd/yIuOOYt+knvJ7uWMV1RYYYQAq63d8fdHVig2Zx635JyBg502Ely/wIYG1ql06ZHpkrTp9dFen6k8ZmTPhPij/bABvlO2S97oQz3OtA1fMtZsUnu2gT0cOlfEuMdcIZzVuk4uAamV6kZ8oVHwbrPsQt7ub60Qcf6ssxxPkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774772899; c=relaxed/simple;
	bh=fICm8AKPYof/g1FyNM8pHDFwDyLWHFAYds7f93Q2M2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VwnocN/X9AddfTNx0TC0pS15TFGVP8G7m4gflbuG4kjk5YHIenRBX9sEbnSVlVFYbKE/gbqVrTvr5kVeMuvAF6egNyGqnVW/ebU/oswYwJCqL3HutbKHSYhaEfovzBO0ZXKYM5Qpqf5NIocqmRMOHBgaHQ4z6iEdVUwOXdGIOz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJ8WQGTH; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJ8WQGTH"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8299f1ca894so1676569b3a.2
        for <git@vger.kernel.org>; Sun, 29 Mar 2026 01:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774772897; x=1775377697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nEY+4l0HoeqnfvHZIZfM5Ay5PKKBaeRfJuN3tAHmZBA=;
        b=eJ8WQGTHgCk3Xx8zFZTXtYI1Vq/Zuw05ihBDcUnlehFTPnmoTgobnjdNfeequndp9R
         oPw2yN2ebLx53tBaPydb/iAjVHVdpO/XrDn/StsNpniMrciOZ4Oz1i9XLnWQDUgXzmN/
         N9DnX5dwQ6Jkecr9me7VqTTIhzONKM2rt+HyXi6/1vIsi5si92WQWdKucT4PINzDhOup
         mQ2B1gF51b/Pm1rbNLj3KguhBtO0H4hhD10xdxT44/wmEYzAZaffAOdRAHSeXIrxtZ90
         EK06HJ+18rnDyDO7BmueGlwCGF5sboxNC/j3AnZglb4FyYPkfmFmZAvtaqGp2PNzoeXE
         AMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774772897; x=1775377697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nEY+4l0HoeqnfvHZIZfM5Ay5PKKBaeRfJuN3tAHmZBA=;
        b=PTNflHTJ6fibWC/WQ022Vy+s1RO8oQ1sjRo0sFgt4c69qHUSZtsLkYQvp89EMWViOp
         lYt1Qn3oqbo0RaIQwXtJ9ev7GK1HPcPUglcsdMxRWMrRpGnD6upR0vrwL/wEq+WSHab/
         nO1e4Bz2t5YKGQZhKJDJKw5oSwZEX2gPnh6W2I04yDhKXiH1a+Bd5F1XbaMpbXq0VieY
         2RlIG57hbTGsAVPp68KyJhdU+3Vbh6EJpGhfTxkbuO2Bya6P7C7i4H5kAt5OawnsgMNX
         SBfxaFvcYUrrJfpT0V+2Z0DI54j/CXtNOE0PrlA9NIySWaR/Be9oqqsMpKJM5LIdlG9Y
         ZDmQ==
X-Gm-Message-State: AOJu0YyOqNTocMPtxvo/BFSenpG6DJaNuGRh4kymNXIPnioz+hTT5DuH
	Gl29J2O/mHkpB1KooiHpAMZGdCpTZYGfhu9zJRTmBb8nW5kzNpxHHmqBAAhKRA==
X-Gm-Gg: ATEYQzz4JClY42eDyBbTIDOwEm8DhAN3TiT5gTiVY7AWrAamWWw2bJyj2qnXg7ubfQj
	bdNt8VQxntwgD2mOqFH70TdobyQfgbWsncaiFBLPSGvFN/GdiHpTFLx90LMjuFgocqJw1S0dUUZ
	jwONdT9jWtnfbcVDejUSmVB3hEsljJQwifXdaTEgkm6KWPR+l9ZvdZViqI2NsLt5uqM941tTIet
	w9DWDOcUSvhc/uF8zM4QCNkuozAw+/OBMUMbHsIJAzkiOt1Zz7i23sD1Xd1SM5Tg+im0toeUOOl
	il8VTL38DX1f1WUfnhw8fCc3ju9g5Mg4olPhGZj6hFIsZXNy8fw1LCtTv1/8qRmhrT8QwwUFbDz
	m12Xwp09bf4BiRfPuCjLv2DJh/C1HgxlcgBLeTw7zJVcBOkuQoqvhiv8GKPTnQPOA3o4+esoyT9
	jmkxcL22bVh8Fm16I+uoxRbPLzocOtfQ3lPup7chA0ZXcH7KeaeJvH5uegRBW9v7IX2cXc
X-Received: by 2002:a05:6a00:4c0e:b0:827:32dd:59d8 with SMTP id d2e1a72fcca58-82c95e9062amr8064427b3a.16.1774772897351;
        Sun, 29 Mar 2026 01:28:17 -0700 (PDT)
Received: from localhost ([2409:40e3:30ab:6862:e924:4f3e:5a3a:f1f1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca8467824sm3967576b3a.17.2026.03.29.01.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 01:28:16 -0700 (PDT)
From: Siddharth Asthana <siddharthasthana31@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	christian.couder@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	toon@iotcl.com,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v2 1/1] cat-file: add mailmap subcommand to --batch-command
Date: Sun, 29 Mar 2026 13:58:08 +0530
Message-ID: <20260329082808.12609-2-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260329082808.12609-1-siddharthasthana31@gmail.com>
References: <20260328203615.60402-1-siddharthasthana31@gmail.com>
 <20260329082808.12609-1-siddharthasthana31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

git-cat-file(1)'s --batch-command works with the --use-mailmap option,
but this option needs to be set when the process is created. This means
we cannot change this option mid-operation.

At GitLab, Gitaly caches git-cat-file processes and it would be useful
if --batch-command supported toggling mailmap dynamically with existing
processes.

Add a `mailmap` subcommand to --batch-command that takes a single
argument: `yes` to enable mailmap and `no` to disable it. When enabled,
mailmap data is loaded from disk on first use and kept in memory so that
toggling back on does not require reloading.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
CI: https://gitlab.com/gitlab-org/git/-/pipelines/2416081861

 Documentation/git-cat-file.adoc |  7 +++++
 builtin/cat-file.c              | 30 ++++++++++++++++++---
 t/t4203-mailmap.sh              | 48 +++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
index c139f55a16..af32e929a8 100644
--- a/Documentation/git-cat-file.adoc
+++ b/Documentation/git-cat-file.adoc
@@ -174,6 +174,13 @@ flush::
 	since the beginning or since the last flush was issued. When `--buffer`
 	is used, no output will come until a `flush` is issued. When `--buffer`
 	is not used, commands are flushed each time without issuing `flush`.
+
+mailmap <yes|no>::
+	Enable or disable mailmap for subsequent `contents` and `info`
+	commands. When `yes` is given, mailmap data is loaded from disk on
+	first use and kept in memory; passing `yes` again does not reload it.
+	When `no` is given, mailmap is disabled but the data stays in memory
+	so that a later `mailmap yes` does not need to reload it from disk.
 --
 +
 
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index b6f12f41d6..a53926d2bb 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -54,6 +54,7 @@ static const char *force_path;
 
 static struct string_list mailmap = STRING_LIST_INIT_NODUP;
 static int use_mailmap;
+static int mailmap_loaded;
 
 static char *replace_idents_using_mailmap(char *, size_t *);
 
@@ -692,6 +693,24 @@ static void parse_cmd_info(struct batch_options *opt,
 	batch_one_object(line, output, opt, data);
 }
 
+static void parse_cmd_mailmap(struct batch_options *opt UNUSED,
+			      const char *line,
+			      struct strbuf *output UNUSED,
+			      struct expand_data *data UNUSED)
+{
+	if (!strcmp(line, "yes")) {
+		if (!mailmap_loaded) {
+			read_mailmap(the_repository, &mailmap);
+			mailmap_loaded = 1;
+		}
+		use_mailmap = 1;
+	} else if (!strcmp(line, "no")) {
+		use_mailmap = 0;
+	} else {
+		die(_("mailmap: unknown argument '%s', expected 'yes' or 'no'"), line);
+	}
+}
+
 static void dispatch_calls(struct batch_options *opt,
 		struct strbuf *output,
 		struct expand_data *data,
@@ -725,9 +744,10 @@ static const struct parse_cmd {
 	parse_cmd_fn_t fn;
 	unsigned takes_args;
 } commands[] = {
-	{ "contents", parse_cmd_contents, 1},
-	{ "info", parse_cmd_info, 1},
-	{ "flush", NULL, 0},
+	{ "contents", parse_cmd_contents, 1 },
+	{ "info", parse_cmd_info, 1 },
+	{ "flush", NULL, 0 },
+	{ "mailmap", parse_cmd_mailmap, 1 },
 };
 
 static void batch_objects_command(struct batch_options *opt,
@@ -1127,8 +1147,10 @@ int cmd_cat_file(int argc,
 	opt_cw = (opt == 'c' || opt == 'w');
 	opt_epts = (opt == 'e' || opt == 'p' || opt == 't' || opt == 's');
 
-	if (use_mailmap)
+	if (use_mailmap) {
 		read_mailmap(the_repository, &mailmap);
+		mailmap_loaded = 1;
+	}
 
 	switch (batch.objects_filter.choice) {
 	case LOFC_DISABLED:
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 74b7ddccb2..f66637cd86 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -1133,6 +1133,54 @@ test_expect_success 'git cat-file --batch-command returns correct size with --us
 	test_cmp expect actual
 '
 
+test_expect_success 'git cat-file --batch-command mailmap yes enables mailmap mid-stream' '
+	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-\EOF &&
+	C O Mitter <committer@example.com> Orig <orig@example.com>
+	EOF
+	commit_sha=$(git rev-parse HEAD) &&
+	git cat-file commit HEAD >commit_no_mailmap.out &&
+	git cat-file --use-mailmap commit HEAD >commit_mailmap.out &&
+	size_no_mailmap=$(wc -c <commit_no_mailmap.out) &&
+	size_mailmap=$(wc -c <commit_mailmap.out) &&
+	printf "info HEAD\nmailmap yes\ninfo HEAD\n" | git cat-file --batch-command >actual &&
+	echo $commit_sha commit $size_no_mailmap >expect &&
+	echo $commit_sha commit $size_mailmap >>expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git cat-file --batch-command mailmap no disables mailmap mid-stream' '
+	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-\EOF &&
+	C O Mitter <committer@example.com> Orig <orig@example.com>
+	EOF
+	commit_sha=$(git rev-parse HEAD) &&
+	git cat-file commit HEAD >commit_no_mailmap.out &&
+	git cat-file --use-mailmap commit HEAD >commit_mailmap.out &&
+	size_no_mailmap=$(wc -c <commit_no_mailmap.out) &&
+	size_mailmap=$(wc -c <commit_mailmap.out) &&
+	printf "mailmap yes\ninfo HEAD\nmailmap no\ninfo HEAD\n" | git cat-file --batch-command >actual &&
+	echo $commit_sha commit $size_mailmap >expect &&
+	echo $commit_sha commit $size_no_mailmap >>expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git cat-file --batch-command mailmap works in --buffer mode' '
+	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-\EOF &&
+	C O Mitter <committer@example.com> Orig <orig@example.com>
+	EOF
+	commit_sha=$(git rev-parse HEAD) &&
+	git cat-file commit HEAD >commit_no_mailmap.out &&
+	git cat-file --use-mailmap commit HEAD >commit_mailmap.out &&
+	size_no_mailmap=$(wc -c <commit_no_mailmap.out) &&
+	size_mailmap=$(wc -c <commit_mailmap.out) &&
+	printf "mailmap yes\ninfo HEAD\nmailmap no\ninfo HEAD\nflush\n" | git cat-file --batch-command --buffer >actual &&
+	echo $commit_sha commit $size_mailmap >expect &&
+	echo $commit_sha commit $size_no_mailmap >>expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git cat-file --mailmap works with different author and committer' '
 	test_when_finished "rm .mailmap" &&
 	cat >.mailmap <<-\EOF &&
-- 
2.51.0

