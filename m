Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926C03DD852
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 14:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783090300; cv=none; b=V0zjLsep3LUZofJ1CYM7XmRwTnCaUbK9CaP1y+JJfA0F3NiQs8UKk5DEMs/dSf4+GEyGyHaDC8DrrJfYGM9v4/mchxjNb2rq3m/HQnpIWjQRfzls5/TL5aydYqLuidOGZPGhpvAlyzea+JTOZ58DqWEq5MdVlfIEk1+WOGVa+Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783090300; c=relaxed/simple;
	bh=8kJHzBzmHbrK7L1e1LAANQg/hEBYJhSrEYDegwnxmsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qUMD7T62wvvls7O50VrpWhDpERjuFzNVzX4d3ki5lYc1DOG3QFmId2VmNcSZ1pxSIJtjQb3LVj2ktK0Z4ATOs+2z6Am7pbnTSeihQgDl850A28z0sNRTeo37mfIs3ukzS2U1KQ/nTSM5IApAgfpBrjPcQn2mELnM1jieEgd+/pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=5ouma.me; spf=pass smtp.mailfrom=5ouma.me; dkim=pass (2048-bit key) header.d=5ouma.me header.i=@5ouma.me header.b=eNb3Atry; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oit6bJiP; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=5ouma.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=5ouma.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=5ouma.me header.i=@5ouma.me header.b="eNb3Atry";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oit6bJiP"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 55745EC00DB;
	Fri,  3 Jul 2026 10:51:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 03 Jul 2026 10:51:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=5ouma.me; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1783090294; x=
	1783176694; bh=BF0xl/FJqXxg1vg9jsanc634QBVOFxahFWEv5zCX+Y8=; b=e
	Nb3AtryZgEDudn2Hbw0sgHy+d6oeEsnquk8BmZ32/6AaEPH1ioJM56pVF+7/0neC
	TwPgOBgfWGEMI0YtxrVnnN7063YV9jZEPwPvP8Vg3G1oCcRmBAPnLedJ4IXY90r3
	F5zNe6TKg1kZOrdX+IYxqiWl1H3k/IQlbbn0Z55deY9sVW4PJIM1ikQzIkB97cvw
	JCvzc9i94rvNICtvwDmDojZ0GXZoWJ4gTGeDP89BEhTCmGq0wLtl3atSMYq3vevH
	fP2YGO+4qcNyfQcHbYJQMhBfVAo71srHGp3g0xbiW+CvmjqM6Kalf13HQOu5v/jf
	KgqXSmbrhbAYwqURiVLVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783090294; x=1783176694; bh=B
	F0xl/FJqXxg1vg9jsanc634QBVOFxahFWEv5zCX+Y8=; b=oit6bJiPiQAw5HU5d
	tevoJ4RTPBPrVBOLM42B5fqVVt/uw6hcgIb1zzxl6WPFv4YAe1A2Vmx4+PQXwTdY
	U92dAukzVMjacbbBCGcp1WW8i0xmghzyqqmSm5dn3TnzbkqZgKW1du9n7SprD8HY
	CPMoNcr9W438GnUbY93yLjOLALDAKsxSVFyly9rouLKLXJ5cecih0VWZB4C93/mF
	2Dz1uU7+vAz13eicZ9HshuvthpRsnFrRognQxZlMoOhi6lmfqw4wfIx7CHvriB/2
	bxyQw4ECLRV+ofRQW6FmcUus0Nr0nDRvqqi76pdTByzxwLh5Pc0YtKcwYEoDw/BI
	baZ8g==
X-ME-Sender: <xms:dsxHahUSi4wq8_tnobu5tEtx2a1nNI2xc2BXXhLjmgxnwkIpzM-rFg>
    <xme:dsxHaolRAA68dEWZ8mSxPZ5Rje7F46FfT0pMKKUT7czrNF4enZqQoEIoC56hL9H0D
    IIgoWJzw7YgIU3JI2pWtktYUBUq_GYRfUJ4tdV65oucLNUGWEPEUw>
X-ME-Received: <xmr:dsxHaibbmaXHECAsIX8CiX1GeRzDjKWO27uthErOuqUjclK8qQXJFwhruexEQZ8BgWVIbzoEoLRf7Bi_wPQV3651uegBQwtBw1yFKAFdXAoiog>
X-ME-Proxy-Cause: dmFkZTEnMdiB5L/yDgEg3QgNJKU40V/jj29gzcv4oGwXfdhGKqhWrDXQmIP3rPg99Mznpc
    xI2gtOpgQWI1ugPrTJhllVLKJUCkMqNtkVjTYf45BxIocYRGSzj7HwIqvmaxVHIvJwe+ur
    8zw9dwHo9L++aqakF0bdnNzeEvL8AFSSmPFNp6rZ8AoplrP7lkkTmqWW8NH7QuksZReLEa
    br9Oo0fLtHVdBUM4p2EWzfW4mTomJ6Q5aYwF71HbJ1qZYiq8OuxBDIpKrZczfcB+rJbfkE
    AbEg7M2XZNdJMTd6X9AqfjRjADzhcn0SHa1nvacwEcbEe/i59VhaSPbHLodd5q6v3M/xMf
    pHR3Er9JiQDoeMZV0UYVJOXjtcKyGoVoqqMIVGNRGMZtrv/WZaq/X/VRPDK38p2TiTdqSI
    KTr6qylq/wEYHR+41xhm3unCnFkxAfNq/PFDjbf0yCgUnmYzmhHYRM7cbXBFTMMSnANvCO
    FL3WdDjkr6CN6l1oAhv3CUyZvEq1U8klAqYzJ6cvpjmf/ieoxEYRUxByawKxD9/BoJ/3gl
    qjERgVUft5DC8lONF5+0LzdZr37mxPnLg07+JNDSnNnT5llHz2zLRxlwBDOQ6kTfEDv3so
    be4TnFTFYiMRM5P3pdZn3xtkjYw/jymVQfrp08T8fns9GoWRQRktnSrbhN5Q
X-ME-Proxy: <xmx:dsxHajOBjpF3zvUYW-SQNWcaLnFGXM_UgNX0Ye0lO8w6gmaaNpcQ-w>
    <xmx:dsxHanYKBgTkbMYDCFrsURj-hy5tiGQpqIEBmWV6itjv8Rv58eraEQ>
    <xmx:dsxHah3GVms7cvN_iB2zO_yp4wB8Vzx1pdos1cAgSvG3beYy_XSoLA>
    <xmx:dsxHatd7l_pPgLB-eOMc1zZNPOBoKvr4LG-THaAoXrg8CROCvYquLg>
    <xmx:dsxHapDasfPzTQXtRmmxVXQh4wXzO1MqTQnTNi4RXfh7vvs6UD4U7iEN>
Feedback-ID: i4b264863:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 10:51:33 -0400 (EDT)
From: Souma <git@5ouma.me>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	Souma <git@5ouma.me>
Subject: [PATCH 3/3] t345x: cover signed history rewrites
Date: Fri,  3 Jul 2026 23:50:37 +0900
Message-ID: <20260703145037.69832-4-git@5ouma.me>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260703145037.69832-1-git@5ouma.me>
References: <20260703145037.69832-1-git@5ouma.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

History signing needs regression coverage because these commands bypass the
usual commit machinery and create replacement commits through lower-level
APIs.

Add GPG-gated tests for config-driven signing, command-line signing,
--no-gpg-sign precedence, and signing of replayed descendants after fixup,
reword, and split.

Signed-off-by: Souma <git@5ouma.me>
---
 t/t3451-history-reword.sh | 39 ++++++++++++++++++++++++++++++++++
 t/t3452-history-split.sh  | 44 +++++++++++++++++++++++++++++++++++++++
 t/t3453-history-fixup.sh  | 39 ++++++++++++++++++++++++++++++++++
 3 files changed, 122 insertions(+)

diff --git a/t/t3451-history-reword.sh b/t/t3451-history-reword.sh
index de7b357685..5b41fb6489 100755
--- a/t/t3451-history-reword.sh
+++ b/t/t3451-history-reword.sh
@@ -4,6 +4,7 @@ test_description='tests for git-history reword subcommand'
 
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-log-graph.sh"
+. "$TEST_DIRECTORY/lib-gpg.sh"
 
 reword_with_message () {
 	cat >message &&
@@ -26,6 +27,37 @@ expect_log () {
 	test_cmp expect actual
 }
 
+test_reword_gpg_sign () {
+	must_fail= will=will
+	if test "x$1" = "x!"
+	then
+		must_fail=test_must_fail
+		will="will not"
+		shift
+	fi
+	conf=$1
+	shift
+
+	test_expect_success GPG "reword $* with commit.gpgsign=$conf $will sign rewritten history" "
+		test_when_finished 'rm -rf repo' &&
+		git init repo &&
+		(
+			cd repo &&
+			test_commit first &&
+			test_commit second &&
+			test_commit third &&
+
+			git config commit.gpgsign $conf &&
+			reword_with_message $* HEAD~ <<-EOF &&
+			second reworded
+			EOF
+
+			$must_fail git verify-commit HEAD~ &&
+			$must_fail git verify-commit HEAD
+		)
+	"
+}
+
 test_expect_success 'can reword tip of a branch' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
@@ -77,6 +109,13 @@ test_expect_success 'can reword commit in the middle' '
 	)
 '
 
+test_reword_gpg_sign ! false
+test_reword_gpg_sign   true
+test_reword_gpg_sign   false --gpg-sign
+test_reword_gpg_sign ! true  --no-gpg-sign
+test_reword_gpg_sign ! true  --gpg-sign --no-gpg-sign
+test_reword_gpg_sign   false --no-gpg-sign --gpg-sign
+
 test_expect_success 'can reword commit in the middle even on detached head' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
diff --git a/t/t3452-history-split.sh b/t/t3452-history-split.sh
index 8ed0cebb50..e96f492cc6 100755
--- a/t/t3452-history-split.sh
+++ b/t/t3452-history-split.sh
@@ -4,6 +4,7 @@ test_description='tests for git-history split subcommand'
 
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-log-graph.sh"
+. "$TEST_DIRECTORY/lib-gpg.sh"
 
 # The fake editor takes multiple arguments, each of which represents a commit
 # message. Subsequent invocations of the editor will then yield those messages
@@ -36,6 +37,42 @@ expect_tree_entries () {
 	test_cmp expect actual
 }
 
+test_split_gpg_sign () {
+	must_fail= will=will
+	if test "x$1" = "x!"
+	then
+		must_fail=test_must_fail
+		will="will not"
+		shift
+	fi
+	conf=$1
+	shift
+
+	test_expect_success GPG "split $* with commit.gpgsign=$conf $will sign rewritten history" "
+		test_when_finished 'rm -rf repo' &&
+		git init repo &&
+		(
+			cd repo &&
+			test_commit initial &&
+			touch bar foo &&
+			git add . &&
+			git commit -m split-me &&
+			test_commit tip &&
+
+			git config commit.gpgsign $conf &&
+			set_fake_editor 'first' 'second' &&
+			git history split $* HEAD~ <<-EOF &&
+			y
+			n
+			EOF
+
+			$must_fail git verify-commit HEAD~2 &&
+			$must_fail git verify-commit HEAD~ &&
+			$must_fail git verify-commit HEAD
+		)
+	"
+}
+
 test_expect_success 'refuses to work with merge commits' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
@@ -141,6 +178,13 @@ test_expect_success 'can split up tip commit' '
 	)
 '
 
+test_split_gpg_sign ! false
+test_split_gpg_sign   true
+test_split_gpg_sign   false --gpg-sign
+test_split_gpg_sign ! true  --no-gpg-sign
+test_split_gpg_sign ! true  --gpg-sign --no-gpg-sign
+test_split_gpg_sign   false --no-gpg-sign --gpg-sign
+
 test_expect_success 'can split up root commit' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
diff --git a/t/t3453-history-fixup.sh b/t/t3453-history-fixup.sh
index 868298e248..cd20a23115 100755
--- a/t/t3453-history-fixup.sh
+++ b/t/t3453-history-fixup.sh
@@ -3,6 +3,7 @@
 test_description='tests for git-history fixup subcommand'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY/lib-gpg.sh"
 
 fixup_with_message () {
 	cat >message &&
@@ -21,6 +22,37 @@ expect_changes () {
 	test_cmp expect actual
 }
 
+test_fixup_gpg_sign () {
+	must_fail= will=will
+	if test "x$1" = "x!"
+	then
+		must_fail=test_must_fail
+		will="will not"
+		shift
+	fi
+	conf=$1
+	shift
+
+	test_expect_success GPG "fixup $* with commit.gpgsign=$conf $will sign rewritten history" "
+		test_when_finished 'rm -rf repo' &&
+		git init repo &&
+		(
+			cd repo &&
+			test_commit first &&
+			test_commit second &&
+			test_commit third &&
+
+			git config commit.gpgsign $conf &&
+			echo fix >>second.t &&
+			git add second.t &&
+			git history fixup $* HEAD~ &&
+
+			$must_fail git verify-commit HEAD~ &&
+			$must_fail git verify-commit HEAD
+		)
+	"
+}
+
 test_expect_success 'errors on missing commit argument' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
@@ -229,6 +261,13 @@ test_expect_success 'preserves commit message and authorship' '
 	)
 '
 
+test_fixup_gpg_sign ! false
+test_fixup_gpg_sign   true
+test_fixup_gpg_sign   false --gpg-sign
+test_fixup_gpg_sign ! true  --no-gpg-sign
+test_fixup_gpg_sign ! true  --gpg-sign --no-gpg-sign
+test_fixup_gpg_sign   false --no-gpg-sign --gpg-sign
+
 test_expect_success 'updates all descendant branches by default' '
 	test_when_finished "rm -rf repo" &&
 	git init repo --initial-branch=main &&
-- 
2.55.0

