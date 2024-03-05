Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AE618EB0
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 20:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709670668; cv=none; b=U1a4RMeLi0Hxsl90aziOlToMUmv12k3975CZTdtIj1EnYOxM3A7IcI9djg9D+7OnMv0ALuwAde9wqXrRsWR4Mufu0WqLsScchoSXcgRHTJyYz23Vtkjy4UInMk4QwaSuHNE3oJX0tNxzbhIrCIus3i7e+1PM+jrHDZcI5ZFDz4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709670668; c=relaxed/simple;
	bh=W2NhHCd1tqUsbO4AGYGV35qXH3fJa2n/XvrRAh/1taQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c6r+Jt42Joxok3gMqhYVfOCBu2pZJlPRPGFJeNutbRje0cq63slyDYlvoB08mtWGOTaWNNEHajpahWeBJOYuo3SbM3PJFeLZ21dz4vBOFvrx13KKsG46XzGIRfcyMzRwXvl0thrTBo5K59wnHXCjjRfqX3baHfG2wwwrfkC+h9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=bJSrKDLG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VmycGahS; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="bJSrKDLG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VmycGahS"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 42DA811401BA;
	Tue,  5 Mar 2024 15:31:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 05 Mar 2024 15:31:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1709670665; x=1709757065; bh=iFIZNsfW3s5RrBSpyA2jYrK/ufx7DF7+
	FD5H6dUY8e8=; b=bJSrKDLGcUtd/G0+NGZfThfHhEi/4OmcmOLzZMXBTHfR0v00
	KVMgWijjeITGdaTFND6B7nnSlQxD5NMLwNvvYCxnvQ1ll3isASmGBzklxCTQD/dN
	lEqJFnOxJ3jIOzLsGiAga8L7iHADkq78/Hql7LqCoVlzSq+/QmLFNUsaNqhkX6tF
	/LfmAimi/sBvIenVhcQxytOt27XVSa9J7gb0pgVZT2535taizHBG12Dp0LfqUxIo
	hLGkjhGXwS/y5x3TbW98XV9weT+efcqRuiQ0w+tUizEoHzlNp5OWssVVmRusKACi
	Kr4c5MYa/m4NVyG0Slrg/kUzx6HsSL2aGlPhng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709670665; x=
	1709757065; bh=iFIZNsfW3s5RrBSpyA2jYrK/ufx7DF7+FD5H6dUY8e8=; b=V
	mycGahS+c4zFSijAlP6BbvogU1Ew2KONlR3g2bsNphes/9lRmz9VWbxHN2dzxIGN
	XbQrshUzuSFbW8Mh1t0c/VhRe6HsevdkIKUxywp/jVWu04mO97qbXXOsi/lRC6p+
	eOZZCa/kn9dEEd69Q65BHzsgK3Dz9X0/5EKfELgxIIuJtEt3OEC289F0XN/m2vsQ
	QlJknvixEek1gvnFq/Z8CPVHmmVq71fY1lOtfJDAlGaZRDAXlZ1FpUGjaw2g36FR
	jm1XKC2vrGfjxqrn/pz9CuYYYzDR5qPb6xD4ET39T0pDp4dTwFX/oTkTW4w/NBkW
	UUOkV0zcUL6AoqoKVoFCQ==
X-ME-Sender: <xms:CYHnZdSYpSnkyD9_fKqo5sejY5HIM1bjoW-hog9dqXZwRPPHE2M4Iq4>
    <xme:CYHnZWymNoYVwKZYjkeXocxFUnICcY66XF5Ij5x1U0FsGZT4Bz3mXo2gj2c3jBsWN
    I2tA9qTVvdgKp4n1g>
X-ME-Received: <xmr:CYHnZS08ukkGpJ6Kc--sNxymr25H5URo9KOfOB85jR8GzOGXQi-ux2wjL_kV5PglQFfYThjMUdyro8pH9bCiQMVoeNOzzqEsS6dn_sXRdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheelgddufeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkuceo
    tghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeevgf
    elveeikeegjeeikeeuvefhleeiuddvleegfeekjedtkeevtdetgfffveettdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrg
    hughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:CYHnZVB5u3qO9l9xJoCSnaucNFULAnF5rd737Lf-CIKW8X9COnOWbQ>
    <xmx:CYHnZWhL1CK5LR1etca1aMg4qrEol9CVnBvhJx9E7KphJknzXOBy8w>
    <xmx:CYHnZZon6sSmnHLWHyBJlmxb_t_QNyy1S_daTSp_nJZrBuBx-YZTIg>
    <xmx:CYHnZXsmshXcs6ryyql1F_m_19L-m8jvrdXXBxBCECTAmoTewEtV0g>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Mar 2024 15:31:04 -0500 (EST)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 1/5] t3200: improve test style
Date: Tue,  5 Mar 2024 21:29:39 +0100
Message-ID: <ad101c72a60295c6e008bccf9f5f56c4ca6fab75.1709670287.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.44.0.64.g52b67adbeb2
In-Reply-To: <cover.1709670287.git.code@khaugsbakk.name>
References: <cover.1709590037.git.code@khaugsbakk.name> <cover.1709670287.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: ad101c72a60295c6e008bccf9f5f56c4ca6fab75
X-Previous-Commits: e6a2628ce57668aa17101e73edaead0ef34d8a8c
Content-Transfer-Encoding: 8bit

Some tests use a preliminary heredoc for `expect` or have setup and
teardown commands before and after, respectively. It is however
preferred to keep all the logic in the test itself. Let’s move these
into the tests.

Also:

• Remove a now-irrelevant comment about test placement and switch back
  to `main` post-test
• Prefer indented literal heredocs (`-\EOF`) except for a block which
  says that this is intentional

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v4:
    • Drop `(setup)` change
    • Drop superflouos bullet point
    • Don’t use period to end bullet point

 t/t3200-branch.sh | 113 ++++++++++++++++++++++------------------------
 1 file changed, 55 insertions(+), 58 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index de7d3014e4f..060b27097e8 100755
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
 test_expect_success 'git branch -m s/s s should work when s/t is deleted' '
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

