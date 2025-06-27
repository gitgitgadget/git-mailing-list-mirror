Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DA82264AC
	for <git@vger.kernel.org>; Fri, 27 Jun 2025 07:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751010621; cv=none; b=PrVOIRDds+epOQdQF8eRa1Ie2EK192PEUpmgnqBsfOYTRBv40knR5Aje1VFf74QcdZwxSpLe8pgzBmcDSQr0YzsaU4Ay15YJChV9Y5GF2ExAvscQclTcMCtr2jjw727gKHOSh/UpdiF7jKJXUiYJqfoamjt6EESUB2NvMO7UeCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751010621; c=relaxed/simple;
	bh=r3L9Moi7TayMlnCHXjeAr/aieB2wNM2erkqaqqCXnfo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YUQhFcJy7iiFqMBk9zCN2gTPr2Z48keZcmgMtn9zKxUqXKJVUYWXyGBDjjO/ZK9rCLICBom8GDI2cqvBGwpryCk/YIgzx5WtUGkGAGyb7DVhGSI19GIswdYtCf2f34mnGCx8YYTeqEgGBm2i/FCKuHgt9ZdAC6Fpv2o2hsT6Nv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/FDVxpD; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/FDVxpD"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3122a63201bso1513391a91.0
        for <git@vger.kernel.org>; Fri, 27 Jun 2025 00:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751010617; x=1751615417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bf/vkd0df0dN7O92+eqIqN1VcL9wjLLNCusifow8TeM=;
        b=O/FDVxpDWe9tWAv0nCDtvWfVaZf1vptb7GgXZ+OlZsRC++a221Lc7aaldl0V9pQyes
         XRgi4Rxtxs696KdddJOVJwafHv/n45QApDLhtTXfd3BpP1fibXAywDZyFbpn5OZR9+fj
         2lSdRwy4+mXzoL+iSVUhvubDEgRQ1tnXumvBVdeibubIXye9N5mxxVKlrIsUNM1mQNYG
         y4Z8AObGEdFvPlQpJXcTmTZ4g041Rls6aYzXZHLU+7ii/6LsoWDIUy9TmhiH4hmu9YNW
         1QaLKTZnBxGNHVcnlOnVGZEr5itOtGglGCitN59qrCC0hv2VMoVZjF3kk+GhdV7ZTcp7
         fOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751010617; x=1751615417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bf/vkd0df0dN7O92+eqIqN1VcL9wjLLNCusifow8TeM=;
        b=TzLPtmRn3smuz0xf01BKAVq0BTwSmpopd0sylXgM5bTbCF9qvDQOjq4LDLv7WwMY07
         7qam9vIezeEuwkLqPqHm5t9+U32rZh2coi0KZxrgN6MR1+24memmXlLMv5B6nZEVNtxU
         gpk1aIhCNZhMCMZozeLMFnVy0JqgjjYigHNS0th30Aq1V2NrUB1GfOmlt0BaRV1wtmxj
         xAJ9mVBLwqWPLRox+WC7iAMwELC5U+drYqWQaF5HWQt8zNlvjwNdsmOGVIKRVzJAykmz
         mrXMzDS3IIzdsWOZwGpjuSx8ZAbX+mHTHITjy6KHo29YNpwi/LkcM//uXfgHLqpV0z1r
         Sk6g==
X-Gm-Message-State: AOJu0YyjT2wOFJSYQQ4YuZMewZQzKc9CNeTDgzoKoKkCj3VlZ1I/vYmd
	Oj3S3y7BgmjA4Sr5+QhaebtmA9drm1GXuhzwFfQVF3Hd/QleLZp6e2NGOecrj28q
X-Gm-Gg: ASbGncvj6WEKZ7fXJXU0Uu6wlwEbN5bQ0kYg0vkSeerVMdD44SwtLTLujNWWwzB3ORR
	fgpoWYB04EBzjSyCOKmKmX/wP7n9C//wC3odmKTqrYZWvXSwnyKRri5aiASoC6lIARP8roZE9TA
	JaA6soNdMURzueIqvXGpX2v5HYX9l5XAMsa+FQ6+PbwtrS9ZJCUSuvUvyrhKWQd7LT7uRfBF3FK
	Y4CbH35hTR85qPgjrS2XzTBZjudCp8Opp1PfRJE7hps/RHgnAYuQsaYsdkl7czVZMKMeQkspaAO
	q40vKBeLs5mT6vqfwbILRKye21/2dfxPTnn/+aObjUSds7+LzZ079vi44Q==
X-Google-Smtp-Source: AGHT+IGnFaym8Io9/vsuPcTiAqMqr2g4rqBYeosDphV93cmKn8zV0WGrDGDnyZkrB8qvnCc2bF3c4w==
X-Received: by 2002:a17:90b:164a:b0:312:26d9:d5b4 with SMTP id 98e67ed59e1d1-318c92b7933mr3476274a91.17.1751010616455;
        Fri, 27 Jun 2025 00:50:16 -0700 (PDT)
Received: from meet.. ([43.250.165.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-318c14e23aesm1673437a91.31.2025.06.27.00.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 00:50:15 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	karthik.188@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>,
	Jeff King <peff@peff.net>,
	Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	Kousik Sanagavarapu <five231003@gmail.com>
Subject: [GSoC][RFC PATCH 2/2] t: add test for git refs list subcommand
Date: Fri, 27 Jun 2025 13:19:34 +0530
Message-Id: <20250627074934.1761897-3-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250627074934.1761897-1-meetsoni3017@gmail.com>
References: <20250627074934.1761897-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adapt `t/t6300-for-each-ref.sh` to invoke ${GIT_REFS_LIST_CMD},
defaulting to `for-each-ref` if the variable is unset.

Add `t/t1461-refs-list.sh` to test git refs list by setting
`GIT_REFS_LIST_CMD` to `refs list` and sourcing
`t/t6300-for-each-ref.sh`

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 t/meson.build           |   1 +
 t/t1461-refs-list.sh    |   8 +
 t/t6300-for-each-ref.sh | 333 ++++++++++++++++++++--------------------
 3 files changed, 179 insertions(+), 163 deletions(-)
 create mode 100755 t/t1461-refs-list.sh

diff --git a/t/meson.build b/t/meson.build
index 50e89e764a..c959c039d0 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -224,6 +224,7 @@ integration_tests = [
   't1450-fsck.sh',
   't1451-fsck-buffer.sh',
   't1460-refs-migrate.sh',
+  't1461-refs-list.sh',
   't1500-rev-parse.sh',
   't1501-work-tree.sh',
   't1502-rev-parse-parseopt.sh',
diff --git a/t/t1461-refs-list.sh b/t/t1461-refs-list.sh
new file mode 100755
index 0000000000..9def7b2e5b
--- /dev/null
+++ b/t/t1461-refs-list.sh
@@ -0,0 +1,8 @@
+#!/bin/sh
+
+test_description='git refs list tests'
+
+. ./test-lib.sh
+
+GIT_REFS_LIST_CMD='refs list'
+. "$TEST_DIRECTORY"/t6300-for-each-ref.sh
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index ce9af79ab1..74a030371c 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -5,7 +5,9 @@
 
 test_description='for-each-ref test'
 
-. ./test-lib.sh
+. "${TEST_DIRECTORY:-.}/test-lib.sh"
+
+GIT_REFS_LIST_CMD=${GIT_REFS_LIST_CMD:-for-each-ref}
 GNUPGHOME_NOT_USED=$GNUPGHOME
 . "$TEST_DIRECTORY"/lib-gpg.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
@@ -61,7 +63,7 @@ test_atom () {
 
 	printf '%s\n' "$3" >expected
 	$test_do $PREREQ "basic atom: $ref $format" '
-		git for-each-ref --format="%($format)" "$ref" >actual &&
+		git ${GIT_REFS_LIST_CMD} --format="%($format)" "$ref" >actual &&
 		sanitize_pgp <actual >actual.clean &&
 		test_cmp expected actual.clean
 	'
@@ -88,7 +90,7 @@ test_atom () {
 			esac &&
 			# Leave $expect unquoted to lose possible leading whitespaces
 			echo $expect >expected &&
-			git for-each-ref --format="%(contents:size)" "$ref" >actual &&
+			git ${GIT_REFS_LIST_CMD} --format="%(contents:size)" "$ref" >actual &&
 			test_cmp expected actual
 		'
 	fi
@@ -281,7 +283,7 @@ test_atom tag HEAD ' '
 
 test_expect_success 'basic atom: refs/tags/testtag *raw' '
 	git cat-file commit refs/tags/testtag^{} >expected &&
-	git for-each-ref --format="%(*raw)" refs/tags/testtag >actual &&
+	git ${GIT_REFS_LIST_CMD} --format="%(*raw)" refs/tags/testtag >actual &&
 	sanitize_pgp <expected >expected.clean &&
 	echo >>expected.clean &&
 	sanitize_pgp <actual >actual.clean &&
@@ -289,40 +291,45 @@ test_expect_success 'basic atom: refs/tags/testtag *raw' '
 '
 
 test_expect_success 'Check invalid atoms names are errors' '
-	test_must_fail git for-each-ref --format="%(INVALID)" refs/heads
-'
-
-test_expect_success 'for-each-ref does not crash with -h' '
-	test_expect_code 129 git for-each-ref -h >usage &&
-	test_grep "[Uu]sage: git for-each-ref " usage &&
-	test_expect_code 129 nongit git for-each-ref -h >usage &&
-	test_grep "[Uu]sage: git for-each-ref " usage
-'
+	test_must_fail git ${GIT_REFS_LIST_CMD} --format="%(INVALID)" refs/heads
+'
+
+if test "$GIT_REFS_LIST_CMD" = "refs list"
+then
+	say "Skipping -h crash test for git refs list"
+else
+	test_expect_success "${GIT_REFS_LIST_CMD} does not crash with -h" '
+		test_expect_code 129 git ${GIT_REFS_LIST_CMD} -h >usage &&
+		test_grep "[Uu]sage: git for-each-ref " usage &&
+		test_expect_code 129 nongit git ${GIT_REFS_LIST_CMD} -h >usage &&
+		test_grep "[Uu]sage: git for-each-ref " usage
+	'
+fi
 
 test_expect_success 'Check format specifiers are ignored in naming date atoms' '
-	git for-each-ref --format="%(authordate)" refs/heads &&
-	git for-each-ref --format="%(authordate:default) %(authordate)" refs/heads &&
-	git for-each-ref --format="%(authordate) %(authordate:default)" refs/heads &&
-	git for-each-ref --format="%(authordate:default) %(authordate:default)" refs/heads
+	git ${GIT_REFS_LIST_CMD} --format="%(authordate)" refs/heads &&
+	git ${GIT_REFS_LIST_CMD} --format="%(authordate:default) %(authordate)" refs/heads &&
+	git ${GIT_REFS_LIST_CMD} --format="%(authordate) %(authordate:default)" refs/heads &&
+	git ${GIT_REFS_LIST_CMD} --format="%(authordate:default) %(authordate:default)" refs/heads
 '
 
 test_expect_success 'Check valid format specifiers for date fields' '
-	git for-each-ref --format="%(authordate:default)" refs/heads &&
-	git for-each-ref --format="%(authordate:relative)" refs/heads &&
-	git for-each-ref --format="%(authordate:short)" refs/heads &&
-	git for-each-ref --format="%(authordate:local)" refs/heads &&
-	git for-each-ref --format="%(authordate:iso8601)" refs/heads &&
-	git for-each-ref --format="%(authordate:rfc2822)" refs/heads
+	git ${GIT_REFS_LIST_CMD} --format="%(authordate:default)" refs/heads &&
+	git ${GIT_REFS_LIST_CMD} --format="%(authordate:relative)" refs/heads &&
+	git ${GIT_REFS_LIST_CMD} --format="%(authordate:short)" refs/heads &&
+	git ${GIT_REFS_LIST_CMD} --format="%(authordate:local)" refs/heads &&
+	git ${GIT_REFS_LIST_CMD} --format="%(authordate:iso8601)" refs/heads &&
+	git ${GIT_REFS_LIST_CMD} --format="%(authordate:rfc2822)" refs/heads
 '
 
 test_expect_success 'Check invalid format specifiers are errors' '
-	test_must_fail git for-each-ref --format="%(authordate:INVALID)" refs/heads
+	test_must_fail git ${GIT_REFS_LIST_CMD} --format="%(authordate:INVALID)" refs/heads
 '
 
 test_expect_success 'arguments to %(objectname:short=) must be positive integers' '
-	test_must_fail git for-each-ref --format="%(objectname:short=0)" &&
-	test_must_fail git for-each-ref --format="%(objectname:short=-1)" &&
-	test_must_fail git for-each-ref --format="%(objectname:short=foo)"
+	test_must_fail git ${GIT_REFS_LIST_CMD} --format="%(objectname:short=0)" &&
+	test_must_fail git ${GIT_REFS_LIST_CMD} --format="%(objectname:short=-1)" &&
+	test_must_fail git ${GIT_REFS_LIST_CMD} --format="%(objectname:short=foo)"
 '
 
 test_bad_atom () {
@@ -337,7 +344,7 @@ test_bad_atom () {
 
 	printf '%s\n' "$3" >expect
 	$test_do $PREREQ "err basic atom: $ref $format" '
-		test_must_fail git for-each-ref \
+		test_must_fail git ${GIT_REFS_LIST_CMD} \
 			--format="%($format)" "$ref" 2>error &&
 		test_cmp expect error
 	'
@@ -395,10 +402,10 @@ test_date () {
 	'refs/tags/testtag' '$tagger_date'
 	EOF
 	(
-		git for-each-ref --shell \
+		git ${GIT_REFS_LIST_CMD} --shell \
 			--format="%(refname) %(committerdate${f:+:$f}) %(authordate${f:+:$f})" \
 			refs/heads &&
-		git for-each-ref --shell \
+		git ${GIT_REFS_LIST_CMD} --shell \
 			--format="%(refname) %(taggerdate${f:+:$f})" \
 			refs/tags
 	) >actual &&
@@ -429,16 +436,16 @@ test_expect_success 'Check format "default-local" date fields output' '
 # doesn't exit in error
 test_expect_success 'Check format "relative" date fields output' '
 	f=relative &&
-	(git for-each-ref --shell --format="%(refname) %(committerdate:$f) %(authordate:$f)" refs/heads &&
-	git for-each-ref --shell --format="%(refname) %(taggerdate:$f)" refs/tags) >actual
+	(git ${GIT_REFS_LIST_CMD} --shell --format="%(refname) %(committerdate:$f) %(authordate:$f)" refs/heads &&
+	git ${GIT_REFS_LIST_CMD} --shell --format="%(refname) %(taggerdate:$f)" refs/tags) >actual
 '
 
 # We just check that this is the same as "relative" for now.
 test_expect_success 'Check format "relative-local" date fields output' '
 	test_date relative-local \
-		"$(git for-each-ref --format="%(committerdate:relative)" refs/heads)" \
-		"$(git for-each-ref --format="%(authordate:relative)" refs/heads)" \
-		"$(git for-each-ref --format="%(taggerdate:relative)" refs/tags)"
+		"$(git ${GIT_REFS_LIST_CMD} --format="%(committerdate:relative)" refs/heads)" \
+		"$(git ${GIT_REFS_LIST_CMD} --format="%(authordate:relative)" refs/heads)" \
+		"$(git ${GIT_REFS_LIST_CMD} --format="%(taggerdate:relative)" refs/tags)"
 '
 
 test_expect_success 'Check format "short" date fields output' '
@@ -488,7 +495,7 @@ test_expect_success 'Check format "raw-local" date fields output' '
 
 test_expect_success 'Check format of strftime date fields' '
 	echo "my date is 2006-07-04" >expected &&
-	git for-each-ref \
+	git ${GIT_REFS_LIST_CMD} \
 	  --format="%(authordate:format:my date is %Y-%m-%d)" \
 	  refs/heads >actual &&
 	test_cmp expected actual
@@ -496,7 +503,7 @@ test_expect_success 'Check format of strftime date fields' '
 
 test_expect_success 'Check format of strftime-local date fields' '
 	echo "my date is 2006-07-03" >expected &&
-	git for-each-ref \
+	git ${GIT_REFS_LIST_CMD} \
 	  --format="%(authordate:format-local:my date is %Y-%m-%d)" \
 	  refs/heads >actual &&
 	test_cmp expected actual
@@ -504,11 +511,11 @@ test_expect_success 'Check format of strftime-local date fields' '
 
 test_expect_success 'exercise strftime with odd fields' '
 	echo >expected &&
-	git for-each-ref --format="%(authordate:format:)" refs/heads >actual &&
+	git ${GIT_REFS_LIST_CMD} --format="%(authordate:format:)" refs/heads >actual &&
 	test_cmp expected actual &&
 	long="long format -- $ZERO_OID$ZERO_OID$ZERO_OID$ZERO_OID$ZERO_OID$ZERO_OID$ZERO_OID" &&
 	echo $long >expected &&
-	git for-each-ref --format="%(authordate:format:$long)" refs/heads >actual &&
+	git ${GIT_REFS_LIST_CMD} --format="%(authordate:format:$long)" refs/heads >actual &&
 	test_cmp expected actual
 '
 
@@ -519,7 +526,7 @@ refs/tags/testtag
 EOF
 
 test_expect_success 'Verify ascending sort' '
-	git for-each-ref --format="%(refname)" --sort=refname >actual &&
+	git ${GIT_REFS_LIST_CMD} --format="%(refname)" --sort=refname >actual &&
 	test_cmp expected actual
 '
 
@@ -531,13 +538,13 @@ refs/heads/main
 EOF
 
 test_expect_success 'Verify descending sort' '
-	git for-each-ref --format="%(refname)" --sort=-refname >actual &&
+	git ${GIT_REFS_LIST_CMD} --format="%(refname)" --sort=-refname >actual &&
 	test_cmp expected actual
 '
 
 test_expect_success 'Give help even with invalid sort atoms' '
-	test_expect_code 129 git for-each-ref --sort=bogus -h >actual 2>&1 &&
-	grep "^usage: git for-each-ref" actual
+	test_expect_code 129 git ${GIT_REFS_LIST_CMD} --sort=bogus -h >actual 2>&1 &&
+	grep "^usage: git ${GIT_REFS_LIST_CMD}" actual
 '
 
 cat >expected <<\EOF
@@ -548,7 +555,7 @@ EOF
 test_expect_success 'exercise patterns with prefixes' '
 	git tag testtag-2 &&
 	test_when_finished "git tag -d testtag-2" &&
-	git for-each-ref --format="%(refname)" \
+	git ${GIT_REFS_LIST_CMD} --format="%(refname)" \
 		refs/tags/testtag refs/tags/testtag-2 >actual &&
 	test_cmp expected actual
 '
@@ -561,7 +568,7 @@ EOF
 test_expect_success 'exercise glob patterns with prefixes' '
 	git tag testtag-2 &&
 	test_when_finished "git tag -d testtag-2" &&
-	git for-each-ref --format="%(refname)" \
+	git ${GIT_REFS_LIST_CMD} --format="%(refname)" \
 		refs/tags/testtag "refs/tags/testtag-*" >actual &&
 	test_cmp expected actual
 '
@@ -578,7 +585,7 @@ test_expect_success 'exercise patterns with prefix exclusions' '
 		git tag "$tag" || return 1
 	done &&
 	test_when_finished "git tag -d foo/one foo/two foo/three bar baz" &&
-	git for-each-ref --format="%(refname)" \
+	git ${GIT_REFS_LIST_CMD} --format="%(refname)" \
 		refs/tags/ --exclude=refs/tags/foo >actual &&
 	test_cmp expected actual
 '
@@ -596,7 +603,7 @@ test_expect_success 'exercise patterns with pattern exclusions' '
 		git tag "$tag" || return 1
 	done &&
 	test_when_finished "git tag -d foo/one foo/two foo/three bar baz" &&
-	git for-each-ref --format="%(refname)" \
+	git ${GIT_REFS_LIST_CMD} --format="%(refname)" \
 		refs/tags/ --exclude="refs/tags/foo/t*" >actual &&
 	test_cmp expected actual
 '
@@ -608,17 +615,17 @@ cat >expected <<\EOF
 EOF
 
 test_expect_success 'Quoting style: shell' '
-	git for-each-ref --shell --format="%(refname)" >actual &&
+	git ${GIT_REFS_LIST_CMD} --shell --format="%(refname)" >actual &&
 	test_cmp expected actual
 '
 
 test_expect_success 'Quoting style: perl' '
-	git for-each-ref --perl --format="%(refname)" >actual &&
+	git ${GIT_REFS_LIST_CMD} --perl --format="%(refname)" >actual &&
 	test_cmp expected actual
 '
 
 test_expect_success 'Quoting style: python' '
-	git for-each-ref --python --format="%(refname)" >actual &&
+	git ${GIT_REFS_LIST_CMD} --python --format="%(refname)" >actual &&
 	test_cmp expected actual
 '
 
@@ -629,13 +636,13 @@ cat >expected <<\EOF
 EOF
 
 test_expect_success 'Quoting style: tcl' '
-	git for-each-ref --tcl --format="%(refname)" >actual &&
+	git ${GIT_REFS_LIST_CMD} --tcl --format="%(refname)" >actual &&
 	test_cmp expected actual
 '
 
 for i in "--perl --shell" "-s --python" "--python --tcl" "--tcl --perl"; do
 	test_expect_success "more than one quoting style: $i" "
-		test_must_fail git for-each-ref $i 2>err &&
+		test_must_fail git ${GIT_REFS_LIST_CMD} $i 2>err &&
 		grep '^error: more than one quoting style' err
 	"
 done
@@ -659,8 +666,8 @@ test_atom head push:track '[behind 1]'
 test_atom head push:trackshort '<'
 
 test_expect_success 'Check that :track[short] cannot be used with other atoms' '
-	test_must_fail git for-each-ref --format="%(refname:track)" 2>/dev/null &&
-	test_must_fail git for-each-ref --format="%(refname:trackshort)" 2>/dev/null
+	test_must_fail git ${GIT_REFS_LIST_CMD} --format="%(refname:track)" 2>/dev/null &&
+	test_must_fail git ${GIT_REFS_LIST_CMD} --format="%(refname:trackshort)" 2>/dev/null
 '
 
 test_expect_success 'Check that :track[short] works when upstream is invalid' '
@@ -670,14 +677,14 @@ test_expect_success 'Check that :track[short] works when upstream is invalid' '
 	EOF
 	test_when_finished "git config branch.main.merge refs/heads/main" &&
 	git config branch.main.merge refs/heads/does-not-exist &&
-	git for-each-ref \
+	git ${GIT_REFS_LIST_CMD} \
 		--format="%(upstream:track)$LF%(upstream:trackshort)" \
 		refs/heads >actual &&
 	test_cmp expected actual
 '
 
 test_expect_success 'Check for invalid refname format' '
-	test_must_fail git for-each-ref --format="%(refname:INVALID)"
+	test_must_fail git ${GIT_REFS_LIST_CMD} --format="%(refname:INVALID)"
 '
 
 test_expect_success 'set up color tests' '
@@ -694,24 +701,24 @@ test_expect_success 'set up color tests' '
 '
 
 test_expect_success TTY '%(color) shows color with a tty' '
-	test_terminal git for-each-ref --format="$color_format" >actual.raw &&
+	test_terminal git ${GIT_REFS_LIST_CMD} --format="$color_format" >actual.raw &&
 	test_decode_color <actual.raw >actual &&
 	test_cmp expected.color actual
 '
 
 test_expect_success '%(color) does not show color without tty' '
-	TERM=vt100 git for-each-ref --format="$color_format" >actual &&
+	TERM=vt100 git ${GIT_REFS_LIST_CMD} --format="$color_format" >actual &&
 	test_cmp expected.bare actual
 '
 
 test_expect_success '--color can override tty check' '
-	git for-each-ref --color --format="$color_format" >actual.raw &&
+	git ${GIT_REFS_LIST_CMD} --color --format="$color_format" >actual.raw &&
 	test_decode_color <actual.raw >actual &&
 	test_cmp expected.color actual
 '
 
 test_expect_success 'color.ui=always does not override tty check' '
-	git -c color.ui=always for-each-ref --format="$color_format" >actual &&
+	git -c color.ui=always ${GIT_REFS_LIST_CMD} --format="$color_format" >actual &&
 	test_cmp expected.bare actual
 '
 
@@ -732,7 +739,7 @@ test_expect_success 'describe atom vs git describe' '
 	(
 		cd describe-repo &&
 
-		git for-each-ref --format="%(objectname)" \
+		git ${GIT_REFS_LIST_CMD} --format="%(objectname)" \
 			refs/tags/ >obj &&
 		while read hash
 		do
@@ -747,7 +754,7 @@ test_expect_success 'describe atom vs git describe' '
 		test_path_exists expect-contains-good &&
 		test_path_exists expect-contains-bad &&
 
-		git for-each-ref --format="%(objectname) %(describe)" \
+		git ${GIT_REFS_LIST_CMD} --format="%(objectname) %(describe)" \
 			refs/tags/ >actual 2>err &&
 		test_cmp expect actual &&
 		test_must_be_empty err
@@ -758,7 +765,7 @@ test_expect_success 'describe:tags vs describe --tags' '
 	(
 		cd describe-repo &&
 		git describe --tags >expect &&
-		git for-each-ref --format="%(describe:tags)" \
+		git ${GIT_REFS_LIST_CMD} --format="%(describe:tags)" \
 				refs/heads/master >actual &&
 		test_cmp expect actual
 	)
@@ -772,7 +779,7 @@ test_expect_success 'describe:abbrev=... vs describe --abbrev=...' '
 		#	  recent tag reachable from it
 		test_commit --no-tag file &&
 		git describe --abbrev=14 >expect &&
-		git for-each-ref --format="%(describe:abbrev=14)" \
+		git ${GIT_REFS_LIST_CMD} --format="%(describe:abbrev=14)" \
 			refs/heads/master >actual &&
 		test_cmp expect actual &&
 
@@ -784,7 +791,7 @@ test_expect_success 'describe:abbrev=... vs describe --abbrev=...' '
 		#	  the name of the tag
 		git tag -a -m tagged tagname &&
 		git describe --abbrev=14 >expect &&
-		git for-each-ref --format="%(describe:abbrev=14)" \
+		git ${GIT_REFS_LIST_CMD} --format="%(describe:abbrev=14)" \
 			refs/heads/master >actual &&
 		test_cmp expect actual &&
 		test tagname = $(cat actual)
@@ -796,7 +803,7 @@ test_expect_success 'describe:match=... vs describe --match ...' '
 		cd describe-repo &&
 		git tag -a -m "tag foo" tag-foo &&
 		git describe --match "*-foo" >expect &&
-		git for-each-ref --format="%(describe:match="*-foo")" \
+		git ${GIT_REFS_LIST_CMD} --format="%(describe:match="*-foo")" \
 			refs/heads/master >actual &&
 		test_cmp expect actual
 	)
@@ -807,7 +814,7 @@ test_expect_success 'describe:exclude:... vs describe --exclude ...' '
 		cd describe-repo &&
 		git tag -a -m "tag bar" tag-bar &&
 		git describe --exclude "*-bar" >expect &&
-		git for-each-ref --format="%(describe:exclude="*-bar")" \
+		git ${GIT_REFS_LIST_CMD} --format="%(describe:exclude="*-bar")" \
 			refs/heads/master >actual &&
 		test_cmp expect actual
 	)
@@ -824,7 +831,7 @@ test_expect_success 'deref with describe atom' '
 
 		tagtwo
 		EOF
-		git for-each-ref --format="%(*describe)" >actual &&
+		git ${GIT_REFS_LIST_CMD} --format="%(*describe)" >actual &&
 		test_cmp expect actual
 	)
 '
@@ -837,7 +844,7 @@ test_expect_success 'err on bad describe atom arg' '
 		cat >expect <<-\EOF &&
 		fatal: unrecognized %(describe) argument: baz
 		EOF
-		test_must_fail git for-each-ref --format="%(describe:baz)" \
+		test_must_fail git ${GIT_REFS_LIST_CMD} --format="%(describe:baz)" \
 			refs/heads/master 2>actual &&
 		test_cmp expect actual &&
 
@@ -846,7 +853,7 @@ test_expect_success 'err on bad describe atom arg' '
 		cat >expect <<-\EOF &&
 		fatal: unrecognized %(describe) argument: qux=1,abbrev=14
 		EOF
-		test_must_fail git for-each-ref \
+		test_must_fail git ${GIT_REFS_LIST_CMD} \
 			--format="%(describe:tags,qux=1,abbrev=14)" \
 			ref/heads/master 2>actual &&
 		test_cmp expect actual
@@ -866,7 +873,7 @@ test_expect_success 'Check ambiguous head and tag refs (strict)' '
 	git commit -m "Branch" &&
 	setdate_and_increment &&
 	git tag -m "Tagging at $datestamp" main &&
-	git for-each-ref --format "%(refname:short)" refs/heads/main refs/tags/main >actual &&
+	git ${GIT_REFS_LIST_CMD} --format "%(refname:short)" refs/heads/main refs/tags/main >actual &&
 	test_cmp expected actual
 '
 
@@ -877,7 +884,7 @@ EOF
 
 test_expect_success 'Check ambiguous head and tag refs (loose)' '
 	git config --bool core.warnambiguousrefs false &&
-	git for-each-ref --format "%(refname:short)" refs/heads/main refs/tags/main >actual &&
+	git ${GIT_REFS_LIST_CMD} --format "%(refname:short)" refs/heads/main refs/tags/main >actual &&
 	test_cmp expected actual
 '
 
@@ -890,7 +897,7 @@ test_expect_success 'Check ambiguous head and tag refs II (loose)' '
 	git checkout main &&
 	git tag ambiguous testtag^0 &&
 	git branch ambiguous testtag^0 &&
-	git for-each-ref --format "%(refname:short)" refs/heads/ambiguous refs/tags/ambiguous >actual &&
+	git ${GIT_REFS_LIST_CMD} --format "%(refname:short)" refs/heads/ambiguous refs/tags/ambiguous >actual &&
 	test_cmp expected actual
 '
 
@@ -923,7 +930,7 @@ test_expect_success 'an unusual tag with an incomplete line' '
 	bogo=$(git cat-file tag bogo) &&
 	bogo=$(printf "%s" "$bogo" | git mktag) &&
 	git tag -f bogo "$bogo" &&
-	git for-each-ref --format "%(body)" refs/tags/bogo
+	git ${GIT_REFS_LIST_CMD} --format "%(body)" refs/tags/bogo
 
 '
 
@@ -1000,7 +1007,7 @@ test_atom refs/tags/signed-empty contents "$sig"
 
 test_expect_success GPG 'basic atom: refs/tags/signed-empty raw' '
 	git cat-file tag refs/tags/signed-empty >expected &&
-	git for-each-ref --format="%(raw)" refs/tags/signed-empty >actual &&
+	git ${GIT_REFS_LIST_CMD} --format="%(raw)" refs/tags/signed-empty >actual &&
 	sanitize_pgp <expected >expected.clean &&
 	echo >>expected.clean &&
 	sanitize_pgp <actual >actual.clean &&
@@ -1018,7 +1025,7 @@ $sig"
 
 test_expect_success GPG 'basic atom: refs/tags/signed-short raw' '
 	git cat-file tag refs/tags/signed-short >expected &&
-	git for-each-ref --format="%(raw)" refs/tags/signed-short >actual &&
+	git ${GIT_REFS_LIST_CMD} --format="%(raw)" refs/tags/signed-short >actual &&
 	sanitize_pgp <expected >expected.clean &&
 	echo >>expected.clean &&
 	sanitize_pgp <actual >actual.clean &&
@@ -1040,7 +1047,7 @@ $sig"
 
 test_expect_success GPG 'basic atom: refs/tags/signed-long raw' '
 	git cat-file tag refs/tags/signed-long >expected &&
-	git for-each-ref --format="%(raw)" refs/tags/signed-long >actual &&
+	git ${GIT_REFS_LIST_CMD} --format="%(raw)" refs/tags/signed-long >actual &&
 	sanitize_pgp <expected >expected.clean &&
 	echo >>expected.clean &&
 	sanitize_pgp <actual >actual.clean &&
@@ -1062,10 +1069,10 @@ test_atom refs/mytrees/first contents ""
 test_expect_success 'basic atom: refs/mytrees/first raw' '
 	git cat-file tree refs/mytrees/first >expected &&
 	echo >>expected &&
-	git for-each-ref --format="%(raw)" refs/mytrees/first >actual &&
+	git ${GIT_REFS_LIST_CMD} --format="%(raw)" refs/mytrees/first >actual &&
 	test_cmp expected actual &&
 	git cat-file -s refs/mytrees/first >expected &&
-	git for-each-ref --format="%(raw:size)" refs/mytrees/first >actual &&
+	git ${GIT_REFS_LIST_CMD} --format="%(raw:size)" refs/mytrees/first >actual &&
 	test_cmp expected actual
 '
 
@@ -1079,10 +1086,10 @@ test_atom refs/myblobs/first contents ""
 test_expect_success 'basic atom: refs/myblobs/first raw' '
 	git cat-file blob refs/myblobs/first >expected &&
 	echo >>expected &&
-	git for-each-ref --format="%(raw)" refs/myblobs/first >actual &&
+	git ${GIT_REFS_LIST_CMD} --format="%(raw)" refs/myblobs/first >actual &&
 	test_cmp expected actual &&
 	git cat-file -s refs/myblobs/first >expected &&
-	git for-each-ref --format="%(raw:size)" refs/myblobs/first >actual &&
+	git ${GIT_REFS_LIST_CMD} --format="%(raw:size)" refs/myblobs/first >actual &&
 	test_cmp expected actual
 '
 
@@ -1127,7 +1134,7 @@ test_expect_success 'Verify sorts with raw' '
 	refs/myblobs/blob4
 	refs/heads/main
 	EOF
-	git for-each-ref --format="%(refname)" --sort=raw \
+	git ${GIT_REFS_LIST_CMD} --format="%(refname)" --sort=raw \
 		refs/heads/main refs/myblobs/ refs/mytrees/first >actual &&
 	test_cmp expected actual
 '
@@ -1146,7 +1153,7 @@ test_expect_success 'Verify sorts with raw:size' '
 	refs/mytrees/first
 	refs/heads/main
 	EOF
-	git for-each-ref --format="%(refname)" --sort=raw:size \
+	git ${GIT_REFS_LIST_CMD} --format="%(refname)" --sort=raw:size \
 		refs/heads/main refs/myblobs/ refs/mytrees/first >actual &&
 	test_cmp expected actual
 '
@@ -1166,7 +1173,7 @@ test_expect_success 'validate raw atom with %(if:equals)' '
 	not equals
 	not equals
 	EOF
-	git for-each-ref --format="%(if:equals=abc)%(raw)%(then)%(refname)%(else)not equals%(end)" \
+	git ${GIT_REFS_LIST_CMD} --format="%(if:equals=abc)%(raw)%(then)%(refname)%(else)not equals%(end)" \
 		refs/myblobs/ refs/heads/ >actual &&
 	test_cmp expected actual
 '
@@ -1186,7 +1193,7 @@ test_expect_success 'validate raw atom with %(if:notequals)' '
 	refs/myblobs/blob8
 	refs/myblobs/first
 	EOF
-	git for-each-ref --format="%(if:notequals=abc)%(raw)%(then)%(refname)%(else)equals%(end)" \
+	git ${GIT_REFS_LIST_CMD} --format="%(if:notequals=abc)%(raw)%(then)%(refname)%(else)equals%(end)" \
 		refs/myblobs/ refs/heads/ >actual &&
 	test_cmp expected actual
 '
@@ -1203,55 +1210,55 @@ test_expect_success 'empty raw refs with %(if)' '
 	refs/myblobs/blob8 empty
 	refs/myblobs/first not empty
 	EOF
-	git for-each-ref --format="%(refname) %(if)%(raw)%(then)not empty%(else)empty%(end)" \
+	git ${GIT_REFS_LIST_CMD} --format="%(refname) %(if)%(raw)%(then)not empty%(else)empty%(end)" \
 		refs/myblobs/ >actual &&
 	test_cmp expected actual
 '
 
 test_expect_success '%(raw) with --python must fail' '
-	test_must_fail git for-each-ref --format="%(raw)" --python
+	test_must_fail git ${GIT_REFS_LIST_CMD} --format="%(raw)" --python
 '
 
 test_expect_success '%(raw) with --tcl must fail' '
-	test_must_fail git for-each-ref --format="%(raw)" --tcl
+	test_must_fail git ${GIT_REFS_LIST_CMD} --format="%(raw)" --tcl
 '
 
 test_expect_success PERL_TEST_HELPERS '%(raw) with --perl' '
-	git for-each-ref --format="\$name= %(raw);
+	git ${GIT_REFS_LIST_CMD} --format="\$name= %(raw);
 print \"\$name\"" refs/myblobs/blob1 --perl | perl >actual &&
 	cmp blob1 actual &&
-	git for-each-ref --format="\$name= %(raw);
+	git ${GIT_REFS_LIST_CMD} --format="\$name= %(raw);
 print \"\$name\"" refs/myblobs/blob3 --perl | perl >actual &&
 	cmp blob3 actual &&
-	git for-each-ref --format="\$name= %(raw);
+	git ${GIT_REFS_LIST_CMD} --format="\$name= %(raw);
 print \"\$name\"" refs/myblobs/blob8 --perl | perl >actual &&
 	cmp blob8 actual &&
-	git for-each-ref --format="\$name= %(raw);
+	git ${GIT_REFS_LIST_CMD} --format="\$name= %(raw);
 print \"\$name\"" refs/myblobs/first --perl | perl >actual &&
 	cmp one actual &&
 	git cat-file tree refs/mytrees/first > expected &&
-	git for-each-ref --format="\$name= %(raw);
+	git ${GIT_REFS_LIST_CMD} --format="\$name= %(raw);
 print \"\$name\"" refs/mytrees/first --perl | perl >actual &&
 	cmp expected actual
 '
 
 test_expect_success '%(raw) with --shell must fail' '
-	test_must_fail git for-each-ref --format="%(raw)" --shell
+	test_must_fail git ${GIT_REFS_LIST_CMD} --format="%(raw)" --shell
 '
 
 test_expect_success '%(raw) with --shell and --sort=raw must fail' '
-	test_must_fail git for-each-ref --format="%(raw)" --sort=raw --shell
+	test_must_fail git ${GIT_REFS_LIST_CMD} --format="%(raw)" --sort=raw --shell
 '
 
 test_expect_success '%(raw:size) with --shell' '
-	git for-each-ref --format="%(raw:size)" | sed "s/^/$SQ/;s/$/$SQ/" >expect &&
-	git for-each-ref --format="%(raw:size)" --shell >actual &&
+	git ${GIT_REFS_LIST_CMD} --format="%(raw:size)" | sed "s/^/$SQ/;s/$/$SQ/" >expect &&
+	git ${GIT_REFS_LIST_CMD} --format="%(raw:size)" --shell >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success 'for-each-ref --format compare with cat-file --batch' '
+test_expect_success "${GIT_REFS_LIST_CMD} --format compare with cat-file --batch" '
 	git rev-parse refs/mytrees/first | git cat-file --batch >expected &&
-	git for-each-ref --format="%(objectname) %(objecttype) %(objectsize)
+	git ${GIT_REFS_LIST_CMD} --format="%(objectname) %(objecttype) %(objectsize)
 %(raw)" refs/mytrees/first >actual &&
 	test_cmp expected actual
 '
@@ -1262,7 +1269,7 @@ test_expect_success 'verify sorts with contents:size' '
 	refs/heads/newtag
 	refs/heads/ambiguous
 	EOF
-	git for-each-ref --format="%(refname)" \
+	git ${GIT_REFS_LIST_CMD} --format="%(refname)" \
 		--sort=contents:size refs/heads/ >actual &&
 	test_cmp expect actual
 '
@@ -1294,7 +1301,7 @@ test_expect_success 'Verify sort with multiple keys' '
 	200000 <user2@example.com> refs/tags/multi-ref2-200000-user2
 	200000 <user2@example.com> refs/tags/multi-ref1-200000-user2
 	EOF
-	git for-each-ref \
+	git ${GIT_REFS_LIST_CMD} \
 		--format="%(taggerdate:unix) %(taggeremail) %(refname)" \
 		--sort=-refname \
 		--sort=taggeremail \
@@ -1314,7 +1321,7 @@ test_expect_success 'equivalent sorts fall back on refname' '
 	200000 <user1@example.com> refs/tags/multi-ref2-200000-user1
 	200000 <user2@example.com> refs/tags/multi-ref2-200000-user2
 	EOF
-	git for-each-ref \
+	git ${GIT_REFS_LIST_CMD} \
 		--format="%(taggerdate:unix) %(taggeremail) %(refname)" \
 		--sort=taggerdate \
 		"refs/tags/multi-*" >actual &&
@@ -1332,7 +1339,7 @@ test_expect_success '--no-sort cancels the previous sort keys' '
 	200000 <user1@example.com> refs/tags/multi-ref2-200000-user1
 	200000 <user2@example.com> refs/tags/multi-ref2-200000-user2
 	EOF
-	git for-each-ref \
+	git ${GIT_REFS_LIST_CMD} \
 		--format="%(taggerdate:unix) %(taggeremail) %(refname)" \
 		--sort=-refname \
 		--sort=taggeremail \
@@ -1356,7 +1363,7 @@ test_expect_success '--no-sort without subsequent --sort prints expected refs' '
 
 	# Sort the results with `sort` for a consistent comparison against
 	# expected
-	git for-each-ref \
+	git ${GIT_REFS_LIST_CMD} \
 		--format="%(refname)" \
 		--no-sort \
 		"refs/tags/multi-*" | sort >actual &&
@@ -1387,7 +1394,7 @@ test_expect_success 'sort by date defaults to full timestamp' '
 	1707341660 refs/tags/custom-dates-1
 	EOF
 
-	git for-each-ref \
+	git ${GIT_REFS_LIST_CMD} \
 		--format="%(creatordate:unix) %(refname)" \
 		--sort=creatordate \
 		"refs/tags/custom-dates-*" >actual &&
@@ -1402,7 +1409,7 @@ test_expect_success 'sort by custom date format' '
 	21:34:20 refs/tags/custom-dates-1
 	EOF
 
-	git for-each-ref \
+	git ${GIT_REFS_LIST_CMD} \
 		--format="%(creatordate:format:%H:%M:%S) %(refname)" \
 		--sort="creatordate:format:%H:%M:%S" \
 		"refs/tags/custom-dates-*" >actual &&
@@ -1411,10 +1418,10 @@ test_expect_success 'sort by custom date format' '
 
 test_expect_success 'do not dereference NULL upon %(HEAD) on unborn branch' '
 	test_when_finished "git checkout main" &&
-	git for-each-ref --format="%(HEAD) %(refname:short)" refs/heads/ >actual &&
+	git ${GIT_REFS_LIST_CMD} --format="%(HEAD) %(refname:short)" refs/heads/ >actual &&
 	sed -e "s/^\* /  /" actual >expect &&
 	git checkout --orphan orphaned-branch &&
-	git for-each-ref --format="%(HEAD) %(refname:short)" refs/heads/ >actual &&
+	git ${GIT_REFS_LIST_CMD} --format="%(HEAD) %(refname:short)" refs/heads/ >actual &&
 	test_cmp expect actual
 '
 
@@ -1451,9 +1458,9 @@ test_trailer_option () {
 	title=$1 option=$2
 	cat >expect
 	test_expect_success $prereq "$title" '
-		git for-each-ref --format="%($option)" refs/heads/main >actual &&
+		git ${GIT_REFS_LIST_CMD} --format="%($option)" refs/heads/main >actual &&
 		test_cmp expect actual &&
-		git for-each-ref --format="%(contents:$option)" refs/heads/main >actual &&
+		git ${GIT_REFS_LIST_CMD} --format="%(contents:$option)" refs/heads/main >actual &&
 		test_cmp expect actual
 	'
 }
@@ -1583,7 +1590,7 @@ test_expect_success 'multiple %(trailers) use their own options' '
 	EOF
 	t1="%(trailers:key=one,key_value_separator=W,separator=X)" &&
 	t2="%(trailers:key=two,key_value_separator=Y,separator=Z)" &&
-	git for-each-ref --format="$t1%0a$t2" refs/tags/tag-with-trailers >actual &&
+	git ${GIT_REFS_LIST_CMD} --format="$t1%0a$t2" refs/tags/tag-with-trailers >actual &&
 	cat >expect <<-\EOF &&
 	oneWfooXoneWbar
 	twoYbazZtwoYqux
@@ -1596,9 +1603,9 @@ test_failing_trailer_option () {
 	cat >expect
 	test_expect_success "$title" '
 		# error message cannot be checked under i18n
-		test_must_fail git for-each-ref --format="%($option)" refs/heads/main 2>actual &&
+		test_must_fail git ${GIT_REFS_LIST_CMD} --format="%($option)" refs/heads/main 2>actual &&
 		test_cmp expect actual &&
-		test_must_fail git for-each-ref --format="%(contents:$option)" refs/heads/main 2>actual &&
+		test_must_fail git ${GIT_REFS_LIST_CMD} --format="%(contents:$option)" refs/heads/main 2>actual &&
 		test_cmp expect actual
 	'
 }
@@ -1617,14 +1624,14 @@ test_expect_success 'if arguments, %(contents:trailers) shows error if colon is
 	cat >expect <<-EOF &&
 	fatal: unrecognized %(contents) argument: trailersonly
 	EOF
-	test_must_fail git for-each-ref --format="%(contents:trailersonly)" 2>actual &&
+	test_must_fail git ${GIT_REFS_LIST_CMD} --format="%(contents:trailersonly)" 2>actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'basic atom: head contents:trailers' '
-	git for-each-ref --format="%(contents:trailers)" refs/heads/main >actual &&
+	git ${GIT_REFS_LIST_CMD} --format="%(contents:trailers)" refs/heads/main >actual &&
 	sanitize_pgp <actual >actual.clean &&
-	# git for-each-ref ends with a blank line
+	# git ${GIT_REFS_LIST_CMD} ends with a blank line
 	cat >expect <<-EOF &&
 	$(cat trailers)
 
@@ -1633,23 +1640,23 @@ test_expect_success 'basic atom: head contents:trailers' '
 '
 
 test_expect_success 'basic atom: rest must fail' '
-	test_must_fail git for-each-ref --format="%(rest)" refs/heads/main
+	test_must_fail git ${GIT_REFS_LIST_CMD} --format="%(rest)" refs/heads/main
 '
 
 test_expect_success 'HEAD atom does not take arguments' '
-	test_must_fail git for-each-ref --format="%(HEAD:foo)" 2>err &&
+	test_must_fail git ${GIT_REFS_LIST_CMD} --format="%(HEAD:foo)" 2>err &&
 	echo "fatal: %(HEAD) does not take arguments" >expect &&
 	test_cmp expect err
 '
 
 test_expect_success 'subject atom rejects unknown arguments' '
-	test_must_fail git for-each-ref --format="%(subject:foo)" 2>err &&
+	test_must_fail git ${GIT_REFS_LIST_CMD} --format="%(subject:foo)" 2>err &&
 	echo "fatal: unrecognized %(subject) argument: foo" >expect &&
 	test_cmp expect err
 '
 
 test_expect_success 'refname atom rejects unknown arguments' '
-	test_must_fail git for-each-ref --format="%(refname:foo)" 2>err &&
+	test_must_fail git ${GIT_REFS_LIST_CMD} --format="%(refname:foo)" 2>err &&
 	echo "fatal: unrecognized %(refname) argument: foo" >expect &&
 	test_cmp expect err
 '
@@ -1673,7 +1680,7 @@ test_expect_success 'trailer parsing not fooled by --- line' '
 		echo "trailer: right" &&
 		echo
 	} >expect &&
-	git for-each-ref --format="%(trailers)" refs/heads/main >actual &&
+	git ${GIT_REFS_LIST_CMD} --format="%(trailers)" refs/heads/main >actual &&
 	test_cmp expect actual
 '
 
@@ -1686,7 +1693,7 @@ refs/heads/main
 EOF
 
 test_expect_success 'Verify usage of %(symref) atom' '
-	git for-each-ref --format="%(symref)" refs/heads/sym >actual &&
+	git ${GIT_REFS_LIST_CMD} --format="%(symref)" refs/heads/sym >actual &&
 	test_cmp expected actual
 '
 
@@ -1695,7 +1702,7 @@ heads/main
 EOF
 
 test_expect_success 'Verify usage of %(symref:short) atom' '
-	git for-each-ref --format="%(symref:short)" refs/heads/sym >actual &&
+	git ${GIT_REFS_LIST_CMD} --format="%(symref:short)" refs/heads/sym >actual &&
 	test_cmp expected actual
 '
 
@@ -1705,12 +1712,12 @@ heads/main
 EOF
 
 test_expect_success 'Verify usage of %(symref:lstrip) atom' '
-	git for-each-ref --format="%(symref:lstrip=2)" refs/heads/sym > actual &&
-	git for-each-ref --format="%(symref:lstrip=-2)" refs/heads/sym >> actual &&
+	git ${GIT_REFS_LIST_CMD} --format="%(symref:lstrip=2)" refs/heads/sym > actual &&
+	git ${GIT_REFS_LIST_CMD} --format="%(symref:lstrip=-2)" refs/heads/sym >> actual &&
 	test_cmp expected actual &&
 
-	git for-each-ref --format="%(symref:strip=2)" refs/heads/sym > actual &&
-	git for-each-ref --format="%(symref:strip=-2)" refs/heads/sym >> actual &&
+	git ${GIT_REFS_LIST_CMD} --format="%(symref:strip=2)" refs/heads/sym > actual &&
+	git ${GIT_REFS_LIST_CMD} --format="%(symref:strip=-2)" refs/heads/sym >> actual &&
 	test_cmp expected actual
 '
 
@@ -1720,8 +1727,8 @@ refs/heads
 EOF
 
 test_expect_success 'Verify usage of %(symref:rstrip) atom' '
-	git for-each-ref --format="%(symref:rstrip=2)" refs/heads/sym > actual &&
-	git for-each-ref --format="%(symref:rstrip=-2)" refs/heads/sym >> actual &&
+	git ${GIT_REFS_LIST_CMD} --format="%(symref:rstrip=2)" refs/heads/sym > actual &&
+	git ${GIT_REFS_LIST_CMD} --format="%(symref:rstrip=-2)" refs/heads/sym >> actual &&
 	test_cmp expected actual
 '
 
@@ -1745,38 +1752,38 @@ test_expect_success ':remotename and :remoteref' '
 			"%(push:remoteref)=refs/heads/pushed/main"
 		do
 			echo "${pair#*=}" >expect &&
-			git for-each-ref --format="${pair%=*}" \
+			git ${GIT_REFS_LIST_CMD} --format="${pair%=*}" \
 				refs/heads/main >actual &&
 			test_cmp expect actual || exit 1
 		done &&
 		git branch push-simple &&
 		git config branch.push-simple.pushRemote from &&
-		actual="$(git for-each-ref \
+		actual="$(git ${GIT_REFS_LIST_CMD} \
 			--format="%(push:remotename),%(push:remoteref)" \
 			refs/heads/push-simple)" &&
 		test from, = "$actual"
 	)
 '
 
-test_expect_success 'for-each-ref --ignore-case ignores case' '
-	git for-each-ref --format="%(refname)" refs/heads/MAIN >actual &&
+test_expect_success "${GIT_REFS_LIST_CMD} --ignore-case ignores case" '
+	git ${GIT_REFS_LIST_CMD} --format="%(refname)" refs/heads/MAIN >actual &&
 	test_must_be_empty actual &&
 
 	echo refs/heads/main >expect &&
-	git for-each-ref --format="%(refname)" --ignore-case \
+	git ${GIT_REFS_LIST_CMD} --format="%(refname)" --ignore-case \
 		refs/heads/MAIN >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success 'for-each-ref --omit-empty works' '
-	git for-each-ref --format="%(refname)" >actual &&
+test_expect_success "${GIT_REFS_LIST_CMD} --omit-empty works" '
+	git ${GIT_REFS_LIST_CMD} --format="%(refname)" >actual &&
 	test_line_count -gt 1 actual &&
-	git for-each-ref --format="%(if:equals=refs/heads/main)%(refname)%(then)%(refname)%(end)" --omit-empty >actual &&
+	git ${GIT_REFS_LIST_CMD} --format="%(if:equals=refs/heads/main)%(refname)%(then)%(refname)%(end)" --omit-empty >actual &&
 	echo refs/heads/main >expect &&
 	test_cmp expect actual
 '
 
-test_expect_success 'for-each-ref --ignore-case works on multiple sort keys' '
+test_expect_success "${GIT_REFS_LIST_CMD} --ignore-case works on multiple sort keys" '
 	# name refs numerically to avoid case-insensitive filesystem conflicts
 	nr=0 &&
 	for email in a A b B
@@ -1789,7 +1796,7 @@ test_expect_success 'for-each-ref --ignore-case works on multiple sort keys' '
 			return 1
 		done
 	done &&
-	git for-each-ref --ignore-case \
+	git ${GIT_REFS_LIST_CMD} --ignore-case \
 		--format="%(taggeremail) %(subject) %(refname)" \
 		--sort=refname \
 		--sort=subject \
@@ -1816,13 +1823,13 @@ test_expect_success 'for-each-ref --ignore-case works on multiple sort keys' '
 	test_cmp expect actual
 '
 
-test_expect_success 'for-each-ref reports broken tags' '
+test_expect_success "${GIT_REFS_LIST_CMD} reports broken tags" '
 	git tag -m "good tag" broken-tag-good HEAD &&
 	git cat-file tag broken-tag-good >good &&
 	sed s/commit/blob/ <good >bad &&
 	bad=$(git hash-object -w -t tag bad) &&
 	git update-ref refs/tags/broken-tag-bad $bad &&
-	test_must_fail git for-each-ref --format="%(*objectname)" \
+	test_must_fail git ${GIT_REFS_LIST_CMD} --format="%(*objectname)" \
 		refs/tags/broken-tag-*
 '
 
@@ -1884,21 +1891,21 @@ test_expect_success 'set up tag with signature and trailers' '
 # use "separator=" here to suppress the terminating newline
 test_atom refs/tags/fake-sig-trailer trailers:separator= 'My-Trailer: foo'
 
-test_expect_success 'git for-each-ref --stdin: empty' '
+test_expect_success "git ${GIT_REFS_LIST_CMD} --stdin: empty" '
 	>in &&
-	git for-each-ref --format="%(refname)" --stdin <in >actual &&
-	git for-each-ref --format="%(refname)" >expect &&
+	git ${GIT_REFS_LIST_CMD} --format="%(refname)" --stdin <in >actual &&
+	git ${GIT_REFS_LIST_CMD} --format="%(refname)" >expect &&
 	test_cmp expect actual
 '
 
-test_expect_success 'git for-each-ref --stdin: fails if extra args' '
+test_expect_success "git ${GIT_REFS_LIST_CMD} --stdin: fails if extra args" '
 	>in &&
-	test_must_fail git for-each-ref --format="%(refname)" \
+	test_must_fail git ${GIT_REFS_LIST_CMD} --format="%(refname)" \
 		--stdin refs/heads/extra <in 2>err &&
 	grep "unknown arguments supplied with --stdin" err
 '
 
-test_expect_success 'git for-each-ref --stdin: matches' '
+test_expect_success "git ${GIT_REFS_LIST_CMD} --stdin: matches" '
 	cat >in <<-EOF &&
 	refs/tags/multi*
 	refs/heads/amb*
@@ -1917,24 +1924,24 @@ test_expect_success 'git for-each-ref --stdin: matches' '
 	refs/tags/multiline
 	EOF
 
-	git for-each-ref --format="%(refname)" --stdin <in >actual &&
+	git ${GIT_REFS_LIST_CMD} --format="%(refname)" --stdin <in >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success 'git for-each-ref with non-existing refs' '
+test_expect_success "git ${GIT_REFS_LIST_CMD} with non-existing refs" '
 	cat >in <<-EOF &&
 	refs/heads/this-ref-does-not-exist
 	refs/tags/bogus
 	EOF
 
-	git for-each-ref --format="%(refname)" --stdin <in >actual &&
+	git ${GIT_REFS_LIST_CMD} --format="%(refname)" --stdin <in >actual &&
 	test_must_be_empty actual &&
 
-	xargs git for-each-ref --format="%(refname)" <in >actual &&
+	xargs git ${GIT_REFS_LIST_CMD} --format="%(refname)" <in >actual &&
 	test_must_be_empty actual
 '
 
-test_expect_success 'git for-each-ref with nested tags' '
+test_expect_success "git ${GIT_REFS_LIST_CMD} with nested tags" '
 	git tag -am "Normal tag" nested/base HEAD &&
 	git tag -am "Nested tag" nested/nest1 refs/tags/nested/base &&
 	git tag -am "Double nested tag" nested/nest2 refs/tags/nested/nest1 &&
@@ -1950,14 +1957,14 @@ test_expect_success 'git for-each-ref with nested tags' '
 	refs/tags/nested/nest2 $nest2_tag_oid tag $head_oid commit
 	EOF
 
-	git for-each-ref \
+	git ${GIT_REFS_LIST_CMD} \
 		--format="%(refname) %(objectname) %(objecttype) %(*objectname) %(*objecttype)" \
 		refs/tags/nested/ >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'is-base atom with non-commits' '
-	git for-each-ref --format="%(is-base:HEAD) %(refname)" >out 2>err &&
+	git ${GIT_REFS_LIST_CMD} --format="%(is-base:HEAD) %(refname)" >out 2>err &&
 	grep "(HEAD) refs/heads/main" out &&
 
 	test_line_count = 2 err &&
@@ -2034,7 +2041,7 @@ test_expect_success GPGSSH 'setup for signature atom using ssh' '
 test_expect_success GPG2 'bare signature atom' '
 	git verify-commit first-signed 2>expect &&
 	echo  >>expect &&
-	git for-each-ref refs/tags/first-signed \
+	git ${GIT_REFS_LIST_CMD} refs/tags/first-signed \
 		--format="%(signature)" >actual &&
 	test_cmp expect actual
 '
@@ -2048,7 +2055,7 @@ test_expect_success GPG 'show good signature with custom format' '
 	73D758744BE721698EC54E8713B6F51ECDDE430D
 	73D758744BE721698EC54E8713B6F51ECDDE430D
 	EOF
-	git for-each-ref refs/tags/first-signed \
+	git ${GIT_REFS_LIST_CMD} refs/tags/first-signed \
 		--format="$GRADE_FORMAT" >actual &&
 	test_cmp expect actual
 '
@@ -2063,7 +2070,7 @@ test_expect_success GPGSSH 'show good signature with custom format with ssh' '
 
 	EOF
 	sed "s|FINGERPRINT|$FINGERPRINT|g" expect.tmpl >expect &&
-	git for-each-ref refs/tags/eighth-signed-ssh \
+	git ${GIT_REFS_LIST_CMD} refs/tags/eighth-signed-ssh \
 		--format="$GRADE_FORMAT" >actual &&
 	test_cmp expect actual
 '
@@ -2082,7 +2089,7 @@ test_expect_success GPG 'signature atom with grade option and bad signature' '
 
 
 	EOF
-	git for-each-ref refs/tags/third-signed \
+	git ${GIT_REFS_LIST_CMD} refs/tags/third-signed \
 		--format="$GRADE_FORMAT" >actual &&
 	test_cmp expect actual
 '
@@ -2095,7 +2102,7 @@ test_expect_success GPG 'show untrusted signature with custom format' '
 	F8364A59E07FFE9F4D63005A65A0EEA02E30CAD7
 	D4BE22311AD3131E5EDA29A461092E85B7227189
 	EOF
-	git for-each-ref refs/tags/fourth-signed \
+	git ${GIT_REFS_LIST_CMD} refs/tags/fourth-signed \
 		--format="$GRADE_FORMAT" >actual &&
 	test_cmp expect actual
 '
@@ -2108,7 +2115,7 @@ test_expect_success GPG 'show untrusted signature with undefined trust level' '
 	F8364A59E07FFE9F4D63005A65A0EEA02E30CAD7
 	D4BE22311AD3131E5EDA29A461092E85B7227189
 	EOF
-	git for-each-ref refs/tags/fourth-signed \
+	git ${GIT_REFS_LIST_CMD} refs/tags/fourth-signed \
 		--format="$TRUSTLEVEL_FORMAT" >actual &&
 	test_cmp expect actual
 '
@@ -2121,7 +2128,7 @@ test_expect_success GPG 'show untrusted signature with ultimate trust level' '
 	73D758744BE721698EC54E8713B6F51ECDDE430D
 	73D758744BE721698EC54E8713B6F51ECDDE430D
 	EOF
-	git for-each-ref refs/tags/sixth-signed \
+	git ${GIT_REFS_LIST_CMD} refs/tags/sixth-signed \
 		--format="$TRUSTLEVEL_FORMAT" >actual &&
 	test_cmp expect actual
 '
@@ -2134,7 +2141,7 @@ test_expect_success GPG 'show unknown signature with custom format' '
 
 
 	EOF
-	GNUPGHOME="$GNUPGHOME_NOT_USED" git for-each-ref \
+	GNUPGHOME="$GNUPGHOME_NOT_USED" git ${GIT_REFS_LIST_CMD} \
 		refs/tags/sixth-signed --format="$GRADE_FORMAT" >actual &&
 	test_cmp expect actual
 '
@@ -2147,7 +2154,7 @@ test_expect_success GPG 'show lack of signature with custom format' '
 
 
 	EOF
-	git for-each-ref refs/tags/seventh-unsigned \
+	git ${GIT_REFS_LIST_CMD} refs/tags/seventh-unsigned \
 		--format="$GRADE_FORMAT" >actual &&
 	test_cmp expect actual
 '
-- 
2.34.1

