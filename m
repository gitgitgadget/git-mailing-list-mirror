Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8083DDDB4
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776265797; cv=none; b=k7OrPoya1fsRxTB1YjP7nZZwz2V9/2ZhWwC86iIJ98+pZ74DBlxQqm9AG4Wd2I2yTDXi//blFTDGYq7IdaOjTAEtzzkkdSizeHu35BV0QCO70s6L7I+3X2rrufa7qsG0Crgc+58FgO1ee9nc/r744ob96v1w0E+AMdgaHhT6hsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776265797; c=relaxed/simple;
	bh=uFH5mxEc8C4tp17keE/5sn6+ItPsERFjTJ1t5joJim0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XRFF/I6fUgzje887mY6pB6YkkWg4FEJqBUJMq1AxQgj9zvatZTCuj5t55Yr1NZVn7Tv4gbO8mZcrkfo3xYICkumpeLe+ZZjipmLhL4UpdyWUl+OTb3LFHvChPmXJlGl6L9UqU3raK3Y94De5VXW2X4+PSU6s3jyBFzoh+joXrp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E20bUg51; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E20bUg51"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35fc2b18363so2888209a91.0
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 08:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776265795; x=1776870595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7kqOve3EeMVu+x5O5mtxAvs9HBzlIao/sbwPAlKNcU=;
        b=E20bUg51ilVzIQMlO8HyWexsERjvNOgLqUHg3yfsUr+iif2Hto5hS3ivXvq1+bNkBM
         A/eyo2ZippGurK7Yoh1AlUhUBj7BmrQ0fQfSafXGHVZV+Oa0asoK0fMLx3xiUESyGs2i
         2hQiF3a6PPP37WHWwQpzjLZYX0MDBg8iy95PSMajs9d7W/Z58aEa3HtGD246jLNbTJQm
         c+btQZzptvnqUql3+wzbQAlRGi5bPrRG3eYxaReod1heqwAs70VZlc7O3S6wPvp3y4/t
         NeQUxl1AHD6VulsX5Cp3Jk7gwFPY8agD6HkrXUHN2H0G79PgEam68bqrsVTkfMMFTJA8
         lEVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776265795; x=1776870595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e7kqOve3EeMVu+x5O5mtxAvs9HBzlIao/sbwPAlKNcU=;
        b=hNbJJhd0pralhQG8j/5KNueGioX+AGIM+XDB5z4GkJLF0ZI13Iz9WBl0EkeoGnzoMJ
         f4SAOKupgxHbLE3prX9Gjg+00NeNrz5M5Vz5dLHcXnGIfUIuZX5suVmPd9mx95GdnqTh
         Yg2vY7prkUwd+HlcsQlSEIg8schO5GTVZWAqJyeoj2N6E3hXYGgo+H3P7pw+t/xQq6ra
         H+KdCb5L/aHRHjB+e9OFUGI4c620CYXuoa7FD1Ss+oh6ZKTC8uATyrDyXh5QeqAgQsUd
         OOZgIRQsEFl4aDRR2bkKKoj1YDOQZKlw1jHVkhGYm2YKM3i691L1JzWBMJC6RpyuWv+e
         KAOA==
X-Gm-Message-State: AOJu0Yx4pkWkX9xo5fAAi1EfGevrNgeq/YRDIHKB5dT3b0AbR8Nbonli
	bspPrsH5zcJ2yl/+AgIzCU43P2gtx/Ie+uBi5rMOjqM+pGrTgo2stbnyBxjeRA==
X-Gm-Gg: AeBDieun1zQ5YbKZhWXqNwK3jtrXNPAoyPQkoiEPzQ3Pzw86h1BqlFjSRR4fJExqS6P
	aT5OLbcomUc5ASKnh7C4zVzFbfMcQlpcLfOtbFEzJpOJxAjqbe2qAL9ZVWJcjxJHUoLVzLUczYy
	dRGrp98VKdlpgwvzr3RjHBsZV2F7H3KN5EP/s7+qUfWTHAZQ8TubF8Vlzuq80t9SdYK/6F41ZUq
	3YPP+w5lCedVzMqFq0kBejytMNdutZ08ZBPuzb2rtZqCtEEjRjYl4PBlxsq70aOfnkaGTpyyxME
	rkZ+W4V72gnQIJWhrSaWkmVEtivvFmB+jTtIFbllvEGXAfJvRlHPSfzSaGHAaX3DfgVdCSJbunm
	mvxKbhyYWBmUYowLYupmQaaggQpkUZ+a6S2u+qktz8ZZ2eO+6xBnN3drcJ+oFvTC09tAiVUkyia
	RwH7yfV/ytKsmA6xqyH0EJaXZpke/Z1l5djeUrJLMwQr2Ft9jZPfGS1WBgsA==
X-Received: by 2002:a17:90b:4f41:b0:35f:b227:db86 with SMTP id 98e67ed59e1d1-35fb227dde7mr13220078a91.2.1776265794673;
        Wed, 15 Apr 2026 08:09:54 -0700 (PDT)
Received: from localhost ([2409:40e3:30ab:6862:31fb:732b:7e92:ae8c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fd081e2afsm1306372a91.5.2026.04.15.08.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 08:09:54 -0700 (PDT)
From: Siddharth Asthana <siddharthasthana31@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	christian.couder@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	toon@iotcl.com,
	jn.avila@free.fr,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v4 1/1] cat-file: add mailmap subcommand to --batch-command
Date: Wed, 15 Apr 2026 20:39:43 +0530
Message-ID: <20260415150943.40493-2-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415150943.40493-1-siddharthasthana31@gmail.com>
References: <20260331121111.9614-1-siddharthasthana31@gmail.com>
 <20260415150943.40493-1-siddharthasthana31@gmail.com>
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
CI: https://gitlab.com/gitlab-org/git/-/pipelines/2455043368

 Documentation/git-cat-file.adoc |  12 ++++
 builtin/cat-file.c              |  37 +++++++++--
 t/t4203-mailmap.sh              | 105 ++++++++++++++++++++++++++++++++
 3 files changed, 150 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
index c139f55a16..0f499c9d1b 100644
--- a/Documentation/git-cat-file.adoc
+++ b/Documentation/git-cat-file.adoc
@@ -174,6 +174,18 @@ flush::
 	since the beginning or since the last flush was issued. When `--buffer`
 	is used, no output will come until a `flush` is issued. When `--buffer`
 	is not used, commands are flushed each time without issuing `flush`.
+
+`mailmap (<bool>)`::
+	Enable or disable mailmap for subsequent commands. The `<bool>`
+	argument accepts the same boolean values as linkgit:git-config[1].
+	Possible effects are:
++
+`true`;;
+	Mailmap data is loaded on first use and kept in memory until the
+	process exits. Passing `true` again does not reload the data.
+`false`;;
+	Mailmap replacements are disabled for subsequent commands, but data
+	already loaded stays in memory.
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

