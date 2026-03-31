Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463903BC681
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 12:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774959084; cv=none; b=DGqtq+o69uRAMgIDXLV5cFcgp0picsSM0jxY1YRTmEJ6z26X8PfwV+fgC01nHa2dZ0ih8NfcQkQs+xxVwrhU4XzQjWCyPtHbPpWBSK4RkaoFtZDzyZDeCVVbihmDTYToXTbe4IDlGbeqchle8772VjQf5bKlpYP4AdH8JPi3lAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774959084; c=relaxed/simple;
	bh=urD4fI3k08NepDBr/wGinVuw7PC4WJ6GdRHOfbEBQzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oVGg5/lYk4z/A5uXHl6K2vegb6eaWT+wmc6oMDb6p/+04GDBthaQQGBZRiJxFnoXRvgCmjEfmztFQ6d9MaBlDt0DCmCpmsLIHVa7HCamJ3H+rSR24dy60U7sHT+T/J6ahecaz5vy7XiGOGYe7iwDeDWvB8xt7gBqzm8nR5icRdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMsJVSrW; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMsJVSrW"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35da1af3e10so2324632a91.3
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 05:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774959082; x=1775563882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xC8EL8VRTw5PitmRW/hW2fLP5EO/LHO8pIunwP5yEIk=;
        b=DMsJVSrWPtM7zQIldKP5yA7KDU0GU7hZq4bWI/p92sA+vDNn7Wu6Zt68qeJIvBghii
         pQR8xTeK2JJrtHTbe91kQMHS/2QU9VP0m3mg16CxQ+W/zak+Ju/IY/8MVf549Ft3V946
         z7QzuMffDKyl4jG7VL2KJUzLO1np4wAY40gu+5pNHjj6JW4LM99INzyCBzdAnjVuBCJm
         kh9Z1T7Vxi5zyM+SGCWIyFlnAexEEagBUmQmv+XXicqstXxaiwzfoQNxoAZdpNNW3miA
         fZ1rvWL3feZ0OwqB95EkEGBCzOCtUvwvaingnvNo3oDwHEWD185lDD44zbTyxL/w+Q9W
         YFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774959082; x=1775563882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xC8EL8VRTw5PitmRW/hW2fLP5EO/LHO8pIunwP5yEIk=;
        b=MMR3WhyhPprL3IOhEfxvkETwUSqfVUIOpr8UVh8MflBrZlAliXkcNSPe6rEA0dQjVI
         utQzgOKeHUZGgn0pL47R3K5ae2fV+T5Ql28z53oNTSbZRZq0njPR9IOkpn+BifLFXD0q
         hhAmNVHtYjHcZWyf7+Po/Rlo2dsGKtJuyjuBEg2HhLiquu8c16ZOCbKbUR1lqzSicqBZ
         kdfI1WNsS12YKJtsnV8Sq59IjcYfkT+xtrDGedJek3RZuvJRIaVQqTNKU1TIUHiEJXBF
         PT8hKHXIPHgGGhwm8chkXavcc7WC72h65rReWEf8sP2NVfNXChYv4WVW8wSFXPNAv8Q7
         4cxw==
X-Gm-Message-State: AOJu0YwlAn88rrwFOJAJ+euwtNlq8bcX61Wo6de1bHSyfixAO/Eccdf3
	SjGTLJrbOkxxyz26wHd2sMM+BunNiE3vcdauEEFPub/8YeOQqzPigVGJcjoEHg==
X-Gm-Gg: ATEYQzx6yBf3utz2dGuM0JVoHgtDuswxxnaW+33BG/xxgQp/k6ZV4y59L7Fsb5u0OK8
	e6jTwQBfab9dNqb+5NjSFLB7nu4a+t+3B3+dqVumAG60fB06p7Hn8CvkmKCn5XeRicTlOa4Aefx
	yZt5zu/igV9sf8eOAFt2e3YooUS9cDc1GjBrEx0K/aOnAx9y8srOQioGy1hhDPNvtP1oK6yEqwg
	PnEHSf2HWZ9xpSVLyVC8mqyy0Z6hlKtv/Cgb2ratb831ibtcSagMMJIKlhVKcvWwxv5RH5AQL3K
	PslrB74qtdKa8HfMo95K9v4bwUHoOLPST22tSP5v44Aqv4vEBPlUTBKzMksut8M7IaEf2YF3vjF
	eHYsQ8atwBBr468z15xY1HujmpGbCgSAcw27HKpGBnatQ4cRs0b7UscKzaLsMLxUQBeig/CgHMv
	FS7mRIFcK9mRNWupyAvuDlxoVVdmnUijtN/k1UYA/AYyWjZMV/b3BKUtIYiQ==
X-Received: by 2002:a17:90b:1d92:b0:35d:9927:e023 with SMTP id 98e67ed59e1d1-35d9927e4c0mr10371845a91.8.1774959082310;
        Tue, 31 Mar 2026 05:11:22 -0700 (PDT)
Received: from localhost ([2409:40e3:30ab:6862:c5eb:1e90:2258:6d9b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe60bdf4sm1465120a91.1.2026.03.31.05.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 05:11:21 -0700 (PDT)
From: Siddharth Asthana <siddharthasthana31@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	christian.couder@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	toon@iotcl.com,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v3 1/1] cat-file: add mailmap subcommand to --batch-command
Date: Tue, 31 Mar 2026 17:41:11 +0530
Message-ID: <20260331121111.9614-2-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331121111.9614-1-siddharthasthana31@gmail.com>
References: <20260329082808.12609-1-siddharthasthana31@gmail.com>
 <20260331121111.9614-1-siddharthasthana31@gmail.com>
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
argument. The command now uses `git_parse_maybe_bool()` and supports all
standard Git boolean values. Mailmap data is loaded lazily and kept in
memory, while a helper centralizes the one-time load path used both at
startup and from the batch-command handler.

Extend tests to cover runtime toggling, startup option interactions
(`--mailmap`/`--no-mailmap`), accepted boolean forms, and invalid values.

Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
CI: https://gitlab.com/gitlab-org/git/-/pipelines/2419600519

 Documentation/git-cat-file.adoc |   7 +++
 builtin/cat-file.c              |  32 ++++++++--
 t/t4203-mailmap.sh              | 105 ++++++++++++++++++++++++++++++++
 3 files changed, 140 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
index c139f55a16..3db925e1de 100644
--- a/Documentation/git-cat-file.adoc
+++ b/Documentation/git-cat-file.adoc
@@ -174,6 +174,13 @@ flush::
 	since the beginning or since the last flush was issued. When `--buffer`
 	is used, no output will come until a `flush` is issued. When `--buffer`
 	is not used, commands are flushed each time without issuing `flush`.
+
+mailmap <bool>::
+	Enable or disable mailmap for subsequent commands.
++
+The `<bool>` argument accepts the same boolean values as
+linkgit:git-config[1]. When enabled, mailmap data is loaded on first
+use and kept in memory until the process exits.
 --
 +
 
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index b6f12f41d6..a3dab0b40c 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -57,6 +57,14 @@ static int use_mailmap;
 
 static char *replace_idents_using_mailmap(char *, size_t *);
 
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
@@ -692,6 +700,21 @@ static void parse_cmd_info(struct batch_options *opt,
 	batch_one_object(line, output, opt, data);
 }
 
+static void parse_cmd_mailmap(struct batch_options *opt UNUSED,
+			      const char *line,
+			      struct strbuf *output UNUSED,
+			      struct expand_data *data UNUSED)
+{
+	int value = git_parse_maybe_bool(line);
+
+	if (value < 0)
+		die(_("mailmap: invalid boolean '%s'"), line);
+
+	if (value > 0)
+		load_mailmap();
+	use_mailmap = value;
+}
+
 static void dispatch_calls(struct batch_options *opt,
 		struct strbuf *output,
 		struct expand_data *data,
@@ -725,9 +748,10 @@ static const struct parse_cmd {
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
@@ -1128,7 +1152,7 @@ int cmd_cat_file(int argc,
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

