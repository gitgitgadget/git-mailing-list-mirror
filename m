Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF6517A30A
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 03:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776310382; cv=none; b=E3ObXZ+w5nTdwx+/lNIb6hsqxsSA5ECYUZawjUmQpPEdz3zvGgSJDSLJpVowWem8zA+hdNIkJPB5gCqKR6rbrAIj1hdovzEQ70DZnRKeS4KQB2Eu098hvLBCHu6se7yz++BH+pcPhChLZ+K6P7pynYCrObUVCxV6ApOBN4ehbJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776310382; c=relaxed/simple;
	bh=iC8ple29A+iIQPXVdUAAXMmTBzx2B7MSvlI9WtuLpSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iLYYu2jnHiB2BLyDgTkn1HupvdhcBRs1uqXPW/G3fOUWXarW8Ak2iRG6WBWIsIvFIUgxyn93fd1sJJo1vwi9vAc6/aSAJsXJR6vdMbV2Z2CiD7mgAfUXE4RSttWHntT9G2nTpZsxJ8Y6Nyfq1ENjED91FimkxCx9ttXPkJpn/+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qLO3BBMj; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qLO3BBMj"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3591cc98871so3502255a91.3
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 20:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776310380; x=1776915180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+keWVT7dnjeU8pErQFzUGHxU26c33GZlVgxT9K44KQ=;
        b=qLO3BBMjWUmZbCMxazYlARA3Hko9aOQp32xwOk/HaPYgxfF6bnxdi7ayH6dwvcM97L
         6Laqv12khK4qSasmkQwvAdoYfV9WWdnvPFY2SSnqFs6H3faIDenJK5zY45JlD9XWah0+
         9j+bVjpsboItbih4vPl2nfsJ8x0kmZsJRdpRGs8jr/2EYhGfp1EV0T/sIeuBRJJH9Q0K
         PZI1QOvKQ8NoTmu+fHV2EwreRgt9pp2cWgbGCWVbznefjH3CKi9ooiuroo5EmSI4tFOx
         mD4ylsm34dw0p1VJMZ0tlmjQfN2m4KDOcX2aFjb+JTikYRNcTIdwYDiy0xLz7yGPqO90
         J/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776310380; x=1776915180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J+keWVT7dnjeU8pErQFzUGHxU26c33GZlVgxT9K44KQ=;
        b=pqr0qdZGurKnkT+iM6cMLQ+qZK1gZhv/8VPMbkb4wX5EicGmKEidchUyk89tBfBxMG
         FnqEPrsE4WOc26Cees2H63cW3RoDZD5yhBiANj8W+K3YK3cpDSAZ5gHZFzNUhPKzaQF0
         pmixfY7HLtGQG7n17gE+TMNM5YFa+N11dmYh0JoZqTa2nMm107D3KRvVDE9O/EW2F+sm
         DAHnroK9G0yT7+cAxUGSHEXdSmGJywYcg0ci1b6Y/tdoRMdZVjJigOUe/eUre8T0Fzuu
         3/MuG3K1PJIDfE6G2PXg5sQfANI/PknAShzea5SSaNlw9yIA6rMgQXjzEi5IiCsvf4XH
         LJcw==
X-Gm-Message-State: AOJu0YxCT0ji/d0BNKMIm5R4S4tERAZf1htKZrnzyilhuy5nO+SOXjXs
	2INc55ogiFje2DiP4G96ByTZqYSe8stwi9LX0yOaf3EdOKBraqFYKPj5wwI/sQ==
X-Gm-Gg: AeBDiesfTSlDP/smitujNngnUlaZrGuNtQAH0i30mDbKG7B3f6zVkz8NNJx+iBB08x4
	AWpIqukD1Tk6bgqeSREcI0/x/qtWT3xCX1UxbueqwSg7jFhXW+uS5P9VDcLW92xnZRn4rcGPObV
	PusI8AcyuykOc+UAkTy1tevEOLoEoSp4FpaoJZFmwQpdBy79zpZrdGizJDobQX2k56GJnCWRKVQ
	HM1HCCFoVLn5uA0+dhrVo5acuOCmzc3U4knp2LrgTN2kG3smWSzfwnpSG2Ms9RotF4G08qKhmgr
	ztFYnIy5YBN3BVRyIXWFoI9DMGmUrP2EKaDEY35nWF2mA2VbBP4pixrK4Q514cKWxsmjTZG9sd3
	IocPdmnfYZF0m6kORDqOOpZsU0J8hKLz7Gedh2gp+DcwGTtCneAt7HOVzkExNuwQ59JC6Msku0l
	upKpmnJFOm22bqP3V6ToqWhFq38auxGuB6OCA1pns+J09pt1SJm999kDLEDg==
X-Received: by 2002:a17:90b:4ac5:b0:359:fdc0:4621 with SMTP id 98e67ed59e1d1-35e42786883mr26887108a91.11.1776310379766;
        Wed, 15 Apr 2026 20:32:59 -0700 (PDT)
Received: from localhost ([2409:40e3:30ab:6862:6400:e3b3:3e97:389e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782c17e4sm39262935ad.77.2026.04.15.20.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 20:32:59 -0700 (PDT)
From: Siddharth Asthana <siddharthasthana31@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	christian.couder@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	toon@iotcl.com,
	jn.avila@free.fr,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v5 1/1] cat-file: add mailmap subcommand to --batch-command
Date: Thu, 16 Apr 2026 09:02:50 +0530
Message-ID: <20260416033250.4327-2-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416033250.4327-1-siddharthasthana31@gmail.com>
References: <20260415150943.40493-1-siddharthasthana31@gmail.com>
 <20260416033250.4327-1-siddharthasthana31@gmail.com>
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

At GitLab, Gitaly keeps interacting with a long-lived git-cat-file
process and it would be useful if --batch-command supported toggling
mailmap dynamically on an existing process.

Add a `mailmap` subcommand to --batch-command that takes a boolean
argument (usual ways you can specify a boolean value like 'yes', 'true',
etc., are supported). Mailmap data is loaded lazily and kept in memory,
while a helper centralizes the one-time load path used both at startup
and from the batch-command handler.

Extend tests to cover runtime toggling, startup option interactions
(`--mailmap`/`--no-mailmap`), accepted boolean forms, and invalid values.

Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
CI: https://gitlab.com/gitlab-org/git/-/pipelines/2456596910

 Documentation/git-cat-file.adoc |   5 ++
 builtin/cat-file.c              |  37 +++++++++--
 t/t4203-mailmap.sh              | 105 ++++++++++++++++++++++++++++++++
 3 files changed, 143 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
index c139f55a16..86b9181599 100644
--- a/Documentation/git-cat-file.adoc
+++ b/Documentation/git-cat-file.adoc
@@ -174,6 +174,11 @@ flush::
 	since the beginning or since the last flush was issued. When `--buffer`
 	is used, no output will come until a `flush` is issued. When `--buffer`
 	is not used, commands are flushed each time without issuing `flush`.
+
+`mailmap (<bool>)`::
+	Enable or disable mailmap for subsequent commands. The `<bool>`
+	argument accepts the same boolean values as linkgit:git-config[1].
+	The mailmap data is read upon the first use and only once.
 --
 +
 
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index d9fbad5358..fa45f774d7 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -57,6 +57,20 @@ static int use_mailmap;
 
 static char *replace_idents_using_mailmap(char *, size_t *);
 
+/*
+ * The mailmap is initialized with .strdup_strings set to 0,
+ * but read_mailmap() sets the bit to 1 (this is true even when
+ * not a single mailmap entry is read), so it can be used for
+ * lazy loading.
+ */
+static void load_mailmap(void)
+{
+	if (mailmap.strdup_strings)
+		return;
+
+	read_mailmap(the_repository, &mailmap);
+}
+
 static char *replace_idents_using_mailmap(char *object_buf, size_t *size)
 {
 	struct strbuf sb = STRBUF_INIT;
@@ -692,6 +706,20 @@ static void parse_cmd_info(struct batch_options *opt,
 	batch_one_object(line, output, opt, data);
 }
 
+static void parse_cmd_mailmap(struct batch_options *opt UNUSED,
+			      const char *line,
+			      struct strbuf *output UNUSED,
+			      struct expand_data *data UNUSED)
+{
+	use_mailmap = git_parse_maybe_bool(line);
+
+	if (use_mailmap < 0)
+		die(_("mailmap: invalid boolean '%s'"), line);
+
+	if (use_mailmap)
+		load_mailmap();
+}
+
 static void dispatch_calls(struct batch_options *opt,
 		struct strbuf *output,
 		struct expand_data *data,
@@ -725,9 +753,10 @@ static const struct parse_cmd {
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
@@ -1131,7 +1160,7 @@ int cmd_cat_file(int argc,
 	opt_epts = (opt == 'e' || opt == 'p' || opt == 't' || opt == 's');
 
 	if (use_mailmap)
-		read_mailmap(the_repository, &mailmap);
+		load_mailmap();
 
 	switch (batch.objects_filter.choice) {
 	case LOFC_DISABLED:
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 74b7ddccb2..249548eb9b 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -1133,6 +1133,111 @@ test_expect_success 'git cat-file --batch-command returns correct size with --us
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
+test_expect_success 'git cat-file --batch-command mailmap no overrides startup --mailmap' '
+	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-\EOF &&
+	C O Mitter <committer@example.com> Orig <orig@example.com>
+	EOF
+	commit_sha=$(git rev-parse HEAD) &&
+	git cat-file --use-mailmap commit HEAD >commit_mailmap.out &&
+	size_mailmap=$(wc -c <commit_mailmap.out) &&
+	git cat-file commit HEAD >commit_no_mailmap.out &&
+	size_no_mailmap=$(wc -c <commit_no_mailmap.out) &&
+	printf "info HEAD\nmailmap no\ninfo HEAD\n" | \
+		git cat-file --mailmap --batch-command >actual &&
+	echo $commit_sha commit $size_mailmap >expect &&
+	echo $commit_sha commit $size_no_mailmap >>expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git cat-file --batch-command mailmap yes overrides startup --no-mailmap' '
+	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-\EOF &&
+	C O Mitter <committer@example.com> Orig <orig@example.com>
+	EOF
+	commit_sha=$(git rev-parse HEAD) &&
+	git cat-file commit HEAD >commit_no_mailmap.out &&
+	size_no_mailmap=$(wc -c <commit_no_mailmap.out) &&
+	git cat-file --use-mailmap commit HEAD >commit_mailmap.out &&
+	size_mailmap=$(wc -c <commit_mailmap.out) &&
+	printf "info HEAD\nmailmap yes\ninfo HEAD\n" | \
+		git cat-file --no-mailmap --batch-command >actual &&
+	echo $commit_sha commit $size_no_mailmap >expect &&
+	echo $commit_sha commit $size_mailmap >>expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git cat-file --batch-command mailmap accepts true/false' '
+	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-\EOF &&
+	C O Mitter <committer@example.com> Orig <orig@example.com>
+	EOF
+	commit_sha=$(git rev-parse HEAD) &&
+	git cat-file commit HEAD >commit_no_mailmap.out &&
+	size_no_mailmap=$(wc -c <commit_no_mailmap.out) &&
+	git cat-file --use-mailmap commit HEAD >commit_mailmap.out &&
+	size_mailmap=$(wc -c <commit_mailmap.out) &&
+	printf "mailmap true\ninfo HEAD\nmailmap false\ninfo HEAD\n" | \
+		git cat-file --batch-command >actual &&
+	echo $commit_sha commit $size_mailmap >expect &&
+	echo $commit_sha commit $size_no_mailmap >>expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git cat-file --batch-command mailmap rejects invalid boolean' '
+	echo "mailmap maybe" >in &&
+	test_must_fail git cat-file --batch-command <in 2>err &&
+	test_grep "mailmap: invalid boolean .*maybe" err
+'
+
 test_expect_success 'git cat-file --mailmap works with different author and committer' '
 	test_when_finished "rm .mailmap" &&
 	cat >.mailmap <<-\EOF &&
-- 
2.53.0

