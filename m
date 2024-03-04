Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA487C0B0
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 22:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709590112; cv=none; b=Aib0rAol64W5WC3Ss4XkMA6ZrTagkDtFEkB+PO7BTZangSf66oNSQ+RzgnvkrowPF4OyZFr7I9kjS7tS4mSXLe2P0Wyq7+08HKrY88fHZbo6W2kNC0FZTTDXkd2GhdW96IVsafYSq4IQ/PgClsEo4VArUC/WhZzDDCbmvqg6dqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709590112; c=relaxed/simple;
	bh=wzPw/I6sGyRC+OMyPtxLXx0NCWSg6ZQzYJY3enUxDs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pdbVCg55eKlWQNXg1TLv487rjkZ0fQesGVVdoK50xKhI2Ec3T7Uuf67if/jovFoxJbtPRJtYTQPyUXBl2gqrIRRzmwDGx+ykIZRXqum5BvDmlQRO5AtvTOVsGnQcoLm7jmkqlAu0Gr5LaReWC0bBS1gNf7lWbD200PnwEeuRaYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=OpSLdezo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gnQEeEi/; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="OpSLdezo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gnQEeEi/"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 6746F5C008B;
	Mon,  4 Mar 2024 17:08:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 04 Mar 2024 17:08:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1709590109; x=1709676509; bh=y5ycGiW57wBjFT056vXcMZJ7xbNUMqXU
	VTzE40JYqxY=; b=OpSLdezotcUU//7P158H7rCZWxvMX59Y6zCn60cdulpZtz4h
	Kdm7oB1wKkeHuWrX3L0u041i7KXusIA0KaDLi7kPmIhQf3pGrDoZ/FeL9xRy0qfJ
	qP9BE28CbJGXlqM86M8VZ3Fv7oQD0muaRJr4FI6thxlSm519e9IUyPJImYXtBGXJ
	AIW2dZ3VCQECOUqtDe1K8p2/o3PHFsXzejlOS3g4gX/eJB7nXvdcdNiLQSy2YHyt
	KqS5BocWQJ9C0L9dvFyb0ABSP3C/gTkd9WqDrIMMhpiGNOHSb45Cb4OUFCm5T1Ja
	aXrECZn7ufkfqAsfoAP+Ba1lfwCXPj30nNFRvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709590109; x=
	1709676509; bh=y5ycGiW57wBjFT056vXcMZJ7xbNUMqXUVTzE40JYqxY=; b=g
	nQEeEi/FftAtiiTiI2Pt7RZil8PJK3D2wzifuoOFBDOCwc81ZKD+G78cDMzPMEg2
	BXYDqkQid3tv+wyoxOr8tYxsAWJpbnBaEmd+wxqZXf4112nrrIfD7yD+hteMZZmS
	KLkic6ZHoI7gcHj9Wml9QBFkuiMCLxSxsgZNSvYiobeom8VWTApYZNt1KcI6dejZ
	wJipI4C9RdDI8B7y90NkC8pgIo5eQ5Ru6zqZPF/Co77vzLoDE+o4adgqM27jLHn/
	kDVLO8yewpPwWyW7ypgQZc/icJWqIRW2fyyy4YhfUWjCkzkjHvXUg2/K26ENQboj
	ibHNQS6T5R62bb9b58k6A==
X-ME-Sender: <xms:XUbmZULRU4OEbUU_DaH3_oYoO_xN6jAOJRVPYL7Rid26s2MfJ-2rCNE>
    <xme:XUbmZUKBf6VvcSJgG0RyEaMqf7-Pd1Yg-wn0qfLCAGsznrVBO1VFsFnbpPdtrlAhw
    GM92aQqPKQfRBIWug>
X-ME-Received: <xmr:XUbmZUuto2FH--xpbnRpOaWBAaHxYpAvOo-a9C7RfMsB0m9hMxw-jj9KRUzVG6cuRf4mqDmVG7dUEg8xeOWzXpLf195TeJPCO1FgQu6MAZLtoOH87GLq4mAOIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgdduheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkuceo
    tghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeevgf
    elveeikeegjeeikeeuvefhleeiuddvleegfeekjedtkeevtdetgfffveettdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrg
    hughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:XUbmZRaXabC_azNeF8WU9SagyqeX10m3bOqB-nN-S7vJZQQecpDC1A>
    <xmx:XUbmZbbcPpPnqjY6HEeg5tA0GtYO_xGZQXhatzrtxIjMw093Rs6xUQ>
    <xmx:XUbmZdAZvvir-OhpmL6MBZ49gRdBMtxE3-UQZAcCREYMhnA3R8Xylw>
    <xmx:XUbmZamKSLOuWLu0l1b09HjMb1hV9XThd14BBua7HN2J1dEr0oL5ig>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 17:08:28 -0500 (EST)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/5] t3200: improve test style
Date: Mon,  4 Mar 2024 23:07:26 +0100
Message-ID: <e6a2628ce57668aa17101e73edaead0ef34d8a8c.1709590037.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.44.0.64.g52b67adbeb2
In-Reply-To: <cover.1709590037.git.code@khaugsbakk.name>
References: <4ad5d4190649dcb5f26c73a6f15ab731891b9dfd.1709491818.git.code@khaugsbakk.name> <cover.1709590037.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: e6a2628ce57668aa17101e73edaead0ef34d8a8c
Content-Transfer-Encoding: 8bit

Some tests use a preliminary heredoc for `expect` or have setup and
teardown commands before and after, respectively. It is however
preferred to keep all the logic in the test itself. Let’s move these
into the tests.

Also:

• Remove a now-irrelevant comment about test placement and switch back
  to `main` post-test.
• Prefer indented literal heredocs (`-\EOF`) except for a block which
  says that this is intentional
• Move a `git config` command into the test and mark it as `setup` since
  the next test depends on it

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 t/t3200-branch.sh | 115 ++++++++++++++++++++++------------------------
 1 file changed, 56 insertions(+), 59 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index de7d3014e4f..273a57a72d8 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -75,13 +75,13 @@ test_expect_success 'git branch HEAD should fail' '
 	test_must_fail git branch HEAD
 '
 
-cat >expect <<EOF
-$HEAD refs/heads/d/e/f@{0}: branch: Created from main
-EOF
 test_expect_success 'git branch --create-reflog d/e/f should create a branch and a log' '
 	GIT_COMMITTER_DATE="2005-05-26 23:30" \
 	git -c core.logallrefupdates=false branch --create-reflog d/e/f &&
 	test_ref_exists refs/heads/d/e/f &&
+	cat >expect <<-EOF &&
+	$HEAD refs/heads/d/e/f@{0}: branch: Created from main
+	EOF
 	git reflog show --no-abbrev-commit refs/heads/d/e/f >actual &&
 	test_cmp expect actual
 '
@@ -440,10 +440,10 @@ test_expect_success 'git branch --list -v with --abbrev' '
 
 test_expect_success 'git branch --column' '
 	COLUMNS=81 git branch --column=column >actual &&
-	cat >expect <<\EOF &&
-  a/b/c   bam     foo     l     * main    n       o/p     r
-  abc     bar     j/k     m/m     mb      o/o     q       topic
-EOF
+	cat >expect <<-\EOF &&
+	  a/b/c   bam     foo     l     * main    n       o/p     r
+	  abc     bar     j/k     m/m     mb      o/o     q       topic
+	EOF
 	test_cmp expect actual
 '
 
@@ -453,25 +453,25 @@ test_expect_success 'git branch --column with an extremely long branch name' '
 	test_when_finished "git branch -d $long" &&
 	git branch $long &&
 	COLUMNS=80 git branch --column=column >actual &&
-	cat >expect <<EOF &&
-  a/b/c
-  abc
-  bam
-  bar
-  foo
-  j/k
-  l
-  m/m
-* main
-  mb
-  n
-  o/o
-  o/p
-  q
-  r
-  topic
-  $long
-EOF
+	cat >expect <<-EOF &&
+	  a/b/c
+	  abc
+	  bam
+	  bar
+	  foo
+	  j/k
+	  l
+	  m/m
+	* main
+	  mb
+	  n
+	  o/o
+	  o/p
+	  q
+	  r
+	  topic
+	  $long
+	EOF
 	test_cmp expect actual
 '
 
@@ -481,10 +481,10 @@ test_expect_success 'git branch with column.*' '
 	COLUMNS=80 git branch >actual &&
 	git config --unset column.branch &&
 	git config --unset column.ui &&
-	cat >expect <<\EOF &&
-  a/b/c   bam   foo   l   * main   n     o/p   r
-  abc     bar   j/k   m/m   mb     o/o   q     topic
-EOF
+	cat >expect <<-\EOF &&
+	  a/b/c   bam   foo   l   * main   n     o/p   r
+	  abc     bar   j/k   m/m   mb     o/o   q     topic
+	EOF
 	test_cmp expect actual
 '
 
@@ -496,39 +496,36 @@ test_expect_success 'git branch -v with column.ui ignored' '
 	git config column.ui column &&
 	COLUMNS=80 git branch -v | cut -c -8 | sed "s/ *$//" >actual &&
 	git config --unset column.ui &&
-	cat >expect <<\EOF &&
-  a/b/c
-  abc
-  bam
-  bar
-  foo
-  j/k
-  l
-  m/m
-* main
-  mb
-  n
-  o/o
-  o/p
-  q
-  r
-  topic
-EOF
+	cat >expect <<-\EOF &&
+	  a/b/c
+	  abc
+	  bam
+	  bar
+	  foo
+	  j/k
+	  l
+	  m/m
+	* main
+	  mb
+	  n
+	  o/o
+	  o/p
+	  q
+	  r
+	  topic
+	EOF
 	test_cmp expect actual
 '
 
-mv .git/config .git/config-saved
-
 test_expect_success DEFAULT_REPO_FORMAT 'git branch -m q q2 without config should succeed' '
+	test_when_finished mv .git/config-saved .git/config &&
+	mv .git/config .git/config-saved &&
 	git branch -m q q2 &&
 	git branch -m q2 q
 '
 
-mv .git/config-saved .git/config
-
-git config branch.s/s.dummy Hello
-
-test_expect_success 'git branch -m s/s s should work when s/t is deleted' '
+test_expect_success '(setup) git branch -m s/s s should work when s/t is deleted' '
+	git config branch.s/s.dummy Hello &&
 	git branch --create-reflog s/s &&
 	git reflog exists refs/heads/s/s &&
 	git branch --create-reflog s/t &&
@@ -1141,14 +1138,14 @@ test_expect_success '--set-upstream-to notices an error to set branch as own ups
 	test_cmp expect actual
 "
 
-# Keep this test last, as it changes the current branch
-cat >expect <<EOF
-$HEAD refs/heads/g/h/i@{0}: branch: Created from main
-EOF
 test_expect_success 'git checkout -b g/h/i -l should create a branch and a log' '
+	test_when_finished git checkout main &&
 	GIT_COMMITTER_DATE="2005-05-26 23:30" \
 	git checkout -b g/h/i -l main &&
 	test_ref_exists refs/heads/g/h/i &&
+	cat >expect <<-EOF &&
+	$HEAD refs/heads/g/h/i@{0}: branch: Created from main
+	EOF
 	git reflog show --no-abbrev-commit refs/heads/g/h/i >actual &&
 	test_cmp expect actual
 '
-- 
2.44.0.64.g52b67adbeb2

