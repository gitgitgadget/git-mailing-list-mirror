Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311411;
	b=N5554VK04oA7Wi5QQkERWKy4bEo7NHVMHTCFDPLsQPRdVNEMQSkRX/4T+5EtyxFGqNZd
	 6fa6+MMsw521J1ysGBiutbrLqCdbLLj78H7mems3MQw169QuvMrhRZHJpkOERPhs1dgkl
	 q0kDNIcs0QMbBnwLmY3bpbQPTu9Fj7qOwAR6MKaXGythDYxiH2F5Ln+Ynl8i4HSqUWAq8
	 J7n9mEua5ERVAqSK7M8zLCFnod0X98HlCJzUUQPLeD197NsZ/h3QEXk7vbIOB74JicRF9
	 A3RGIWo6kG7RNtKQOzCndbs/a36/7sLk3iX+sqv/Q/QOL8bZLbFRsEDcMfhwS5yEevQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311411;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=1BTWRlgD6C0zvVZCKXZ22jQgvnKUzC3ywP+QYNKWUTI=;
	b=0mfsX8f2ZPhPTU5CWVwWFL0XMrTVZ9ZyJrFoVQEx6iNpjnpS2DbRPDKLNOHXkx6Er1dN
	 GZz6sQEn/xnCRq0d9MMlt6hL+FVYzOHwTpRx3RcqyJLhgdOBwMX3KAUAcMD1KUsXi3wgB
	 XPkiW7IeyuU+mNkN7nWe0Le3clKL9JQkyQzKCBbwvZb8iE7PEs85VGtElrlTbc6+Fovkt
	 veDYEV2FeRKfECBHP+1japCcD8njQFIFuCC186artSEnJSd1clZ+rLURAdkoECaNp1lON
	 3e3TknzQC933gNdxRIcYGrMl0P1QeNkCTsyZSK4iKghi3fV4hqpaNHgOao1+pgdKJMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gQar7ahe;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FF1606A9A1
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 11:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6FF1606A9A1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gQar7ahe
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a5036bbac7so12432045e9.3
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 03:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794311409; x=1794916209; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1BTWRlgD6C0zvVZCKXZ22jQgvnKUzC3ywP+QYNKWUTI=;
        b=gQar7aheiwLajzm5dyReXfGO0yhHTPGNeZtNiMiu09gvKk6puzQSLq4KFhK1K0SLfL
         5nulU2lY4rqlPkEyY0a0NQgD2PCvmzdLbz9PHmTm9soKaJ5kg2XRoahLjhmJIiKCvegc
         mYWZcEZZJzUi2XYyil0rnJ/AFNL8SjivATZ+SMc6OfE48Vh8oVgdoUMCpjKe6T8evTFf
         h0PHiWW4PVL2OvleAQTMzJ6ppb3wFDJQpwl0NrckUdGJKuxH5ZJ3U078C8mswp+yHq0S
         D/3TXR105pkWOVpxit964KKxoy27S3fWtGI8sLzM61hdszfF7buG0hdWprMjndC0PZYV
         /KeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794311409; x=1794916209;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1BTWRlgD6C0zvVZCKXZ22jQgvnKUzC3ywP+QYNKWUTI=;
        b=T+icraTA8MuvcljM+Ovyi75+m6Ktu6STefB+t5BuJCJaE4F7p+gC8hyAo8FtcCloiw
         1HjzUWnrQb7RFLecxuIUd+hN8XcPd1gbNosg/nf/PphOI6nc/0UOSzb2YhllUzbaeGjZ
         dlC3TtBrtqchZe7XlNW4NRTB4lwthF8zQ5ugVnKvuKJ2XMV/3pv2/1ArEfHRgxbhNWqJ
         giT/TGf2V6/8qZPLNgt99IQWa4ME2Pqra2iTUFhOE41WyUNFrPrzc8fNAM5Xb1LGNAIz
         kSUozfKaO0mKj/yRCnW1vELYQoFeLNLGAE6iMGHK5CaJTQj2XGaTcwn4sNRFBuX7zaKX
         fjHw==
X-Gm-Message-State: APuU4Z/+2q4Bp6qd+pamWz4OKGb44rlZvpxnM+qL22cwT6O/5yN0xtDl
	p5ldy9LbcfoZkvI3ckX9iXIMakhpcL9xFc+JzI5dGJswaqoEkpBspRJbrqWVFQ==
X-Gm-Gg: AYBFou1R+qNpbcXfZ7lphmmGrP4IKGCFPwMGZDm2cj826f/rLCJm2m5vKdYeODyj6KU
	+zTuHEIhHBBXmKhaOawJc17u0mIf+uNet2kjA7OxIPZQygXC27xk18xy8S2DG9N3JGMpGZqoF+s
	meQS2F3HKUkbAu+4GapWgRpLckQ/brt9MbKzPwSAxGsD0MAlZUvS83R50UxNVIIGFhyM/zivviw
	5C+QXwxwYlhICf6CUwlvMcNBbldhQdtMDvVE1QyjE2q3lVRKTU1LP5LQvdQK9sYPOQW5XHuPNzv
	iLlNpCajk2ajpnhA11j4y6BNHJoKh2Efh1tmBgtmN2/mYWTsVE/DOtP5GR51knRROg2evLOib3j
	N0Sq5gwvKgZjwznDfV6nXpI+jeM2ffO0r8vE9eatHVhxa4ACPFE+dSzheXIXPfkbMciptNyKiEm
	NJtIOaJSBPS9y7njtVOvXhOnv4KJfpe3cESBdZCVJhUi7SzyfqVBWCVXU1UxeT2qauD9Uxv/GzR
	PsXlbzkJZ/QCQrjrJCER3miZC1yVlHF0uvIUenG96pNGMpcGIdZz7N+Z1dyFweAFcbIu08GT6XV
	kwZ8Nkv7VPLqqfg6ngMYNLLBPb7YjJYoOFb1XUbgs8S0BZ76ShT2oY9AC+9CM2VhAaLMsusGqgY
	jVtzlW91SBNvh
X-Received: by 2002:a05:600c:3e1a:b0:4a1:f90d:6f4c with SMTP id 5b1f17b1804b1-4ba0233999amr39482415e9.7.1794311408811;
        Tue, 10 Nov 2026 03:50:08 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1917:82b:d709:897d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02005762sm60715995e9.2.2026.11.10.03.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:50:08 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 10 Nov 2026 12:49:51 +0100
Subject: [PATCH 06/20] t9300: make the series Q tests self-contained
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-kn-fast-import-tests-1-v1-6-dbd9ee502aae@gmail.com>
References: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
In-Reply-To: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13284;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=yjDxfjG8CUO7MdQxzQ1NY1MSIRRhwFrXAimBAPlPpYA=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGrzBOZACxxu9VxzxR4J0OxOUMS6xgPH2Ol4U
 NzeDKIHusxvCYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq8wTmAAoJED7VnySO
 Rox/K2gL/AoZuRKA6qhx0uXDHW3sUwrjbu5kxxi+KP+eX+qJNiPCpsOji6JFg0aIDa1kTO1aR19
 rBvce7KbTVPFDTuw2pC7E1YY67rVVEHJsvqti4ITJP8OL3NbqWJKjblVdjdG/qL0C2v0OQoAwgD
 VNPDZsuKciBYXoA67dOhaCKqslY9+SAPO2Ue67C7x95k6jdRNhgldgdglstMfgdiCPana6u8Zr2
 pTCmUoo5j3r8h+AqqJjQMSWiflVH/GwrGMbv974eNiX6coJ09sLuj0qD1+TqrNXSM3n5dTNuHB8
 42eLPqfH0FzukebixQFzraaFH9zxGo7T0G7ibMaqFtrqPdD0+o8DDN8zo8evIv/cd8uVBEyjs1C
 iBLQyOltwLKhnkcw3p9CN+gZDA/zR/LQr3GIL+wwpB5BuSYys9FVCPWTSeniLwNavcvX40tF7TA
 Fo0heFk15uMYXwkHKFw3CF5k25K8LEH8vlVhANSKQdO5LDgjSod3V56JBU8zZrZp+zC15BCJpr8
 5w=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Similar to the previous commits, modify the tests in 'series Q' to make
them independent of state from previous tests.

The 'Q: verify' tests inspect the commits and notes written by 'Q:
commit notes', and use shell variables set by the preceding tests.
Replace 'Q: commit notes' with a 'setup_notes_repo()' function, which
creates a new repository, runs the import and sets those variables, so
each test can invoke it. Run the import with 'fastimport.unpackLimit'
set to 0, so that a pack is written for 'Q: verify pack' to check.

Also stop using the 'verify_packs()' function, to make it easier to move
these tests to another file.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t9300-fast-import.sh | 344 +++++++++++++++++++++++++++++++------------------
 1 file changed, 220 insertions(+), 124 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 8124983409..9b1827bae2 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2023,7 +2023,17 @@ test_expect_success 'P: fail on blob mark in gitlink' '
 ### series Q (notes)
 ###
 
-test_expect_success 'Q: commit notes' '
+setup_notes_repo () {
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	file2_data="file2
+second line of EOF" &&
+	file4_data=abcd &&
+	file4_len=4 &&
+	file5_data="an inline file.
+  we should see it later." &&
+	file6_data="#!/bin/sh
+echo \"\$@\"" &&
 	note1_data="The first note for the first commit" &&
 	note2_data="The first note for the second commit" &&
 	note3_data="The first note for the third commit" &&
@@ -2032,7 +2042,7 @@ test_expect_success 'Q: commit notes' '
 	note2b_data="The second note for the second commit" &&
 
 	test_tick &&
-	cat >input <<-INPUT_END &&
+	cat >repo/input <<-INPUT_END &&
 	blob
 	mark :2
 	data <<EOF
@@ -2143,199 +2153,285 @@ test_expect_success 'Q: commit notes' '
 
 	INPUT_END
 
-	git fast-import <input &&
-	git log --raw notes-test
-'
+	git -C repo -c fastimport.unpackLimit=0 fast-import <repo/input &&
+	commit1=$(git -C repo rev-parse notes-test~2) &&
+	commit2=$(git -C repo rev-parse notes-test^) &&
+	commit3=$(git -C repo rev-parse notes-test)
+}
 
 test_expect_success 'Q: verify pack' '
-	verify_packs
+	setup_notes_repo &&
+	(
+		cd repo &&
+		for p in .git/objects/pack/*.pack
+		do
+			git verify-pack "$p" || return 1
+		done
+	)
 '
 
 test_expect_success 'Q: verify first commit' '
-	commit1=$(git rev-parse notes-test~2) &&
-	commit2=$(git rev-parse notes-test^) &&
-	commit3=$(git rev-parse notes-test) &&
+	setup_notes_repo &&
+	(
+		cd repo &&
+		cat >expect <<-EOF &&
+		author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
-	cat >expect <<-EOF &&
-	author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-
-	first (:3)
-	EOF
-	git cat-file commit notes-test~2 | sed 1d >actual &&
-	test_cmp expect actual
+		first (:3)
+		EOF
+		git cat-file commit notes-test~2 | sed 1d >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'Q: verify second commit' '
-	cat >expect <<-EOF &&
-	parent $commit1
-	author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	setup_notes_repo &&
+	(
+		cd repo &&
+		cat >expect <<-EOF &&
+		parent $commit1
+		author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
-	second (:5)
-	EOF
-	git cat-file commit notes-test^ | sed 1d >actual &&
-	test_cmp expect actual
+		second (:5)
+		EOF
+		git cat-file commit notes-test^ | sed 1d >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'Q: verify third commit' '
-	cat >expect <<-EOF &&
-	parent $commit2
-	author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	setup_notes_repo &&
+	(
+		cd repo &&
+		cat >expect <<-EOF &&
+		parent $commit2
+		author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
-	third (:6)
-	EOF
-	git cat-file commit notes-test | sed 1d >actual &&
-	test_cmp expect actual
+		third (:6)
+		EOF
+		git cat-file commit notes-test | sed 1d >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'Q: verify first notes commit' '
-	cat >expect <<-EOF &&
-	author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	setup_notes_repo &&
+	(
+		cd repo &&
+		cat >expect <<-EOF &&
+		author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
-	notes (:9)
-	EOF
-	git cat-file commit refs/notes/foobar~2 | sed 1d >actual &&
-	test_cmp expect actual
+		notes (:9)
+		EOF
+		git cat-file commit refs/notes/foobar~2 | sed 1d >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'Q: verify first notes tree' '
-	sort >expect <<-EOF &&
-	100644 blob $commit1
-	100644 blob $commit2
-	100644 blob $commit3
-	EOF
-	git cat-file -p refs/notes/foobar~2^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
-	test_cmp expect actual
+	setup_notes_repo &&
+	(
+		cd repo &&
+		sort >expect <<-EOF &&
+		100644 blob $commit1
+		100644 blob $commit2
+		100644 blob $commit3
+		EOF
+		git cat-file -p refs/notes/foobar~2^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'Q: verify first note for first commit' '
-	echo "$note1_data" >expect &&
-	git cat-file blob refs/notes/foobar~2:$commit1 >actual &&
-	test_cmp expect actual
+	setup_notes_repo &&
+	(
+		cd repo &&
+		echo "$note1_data" >expect &&
+		git cat-file blob refs/notes/foobar~2:$commit1 >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'Q: verify first note for second commit' '
-	echo "$note2_data" >expect &&
-	git cat-file blob refs/notes/foobar~2:$commit2 >actual &&
-	test_cmp expect actual
+	setup_notes_repo &&
+	(
+		cd repo &&
+		echo "$note2_data" >expect &&
+		git cat-file blob refs/notes/foobar~2:$commit2 >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'Q: verify first note for third commit' '
-	echo "$note3_data" >expect &&
-	git cat-file blob refs/notes/foobar~2:$commit3 >actual &&
-	test_cmp expect actual
+	setup_notes_repo &&
+	(
+		cd repo &&
+		echo "$note3_data" >expect &&
+		git cat-file blob refs/notes/foobar~2:$commit3 >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'Q: verify second notes commit' '
-	cat >expect <<-EOF &&
-	parent $(git rev-parse --verify refs/notes/foobar~2)
-	author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	setup_notes_repo &&
+	(
+		cd repo &&
+		cat >expect <<-EOF &&
+		parent $(git rev-parse --verify refs/notes/foobar~2)
+		author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
-	notes (:10)
-	EOF
-	git cat-file commit refs/notes/foobar^ | sed 1d >actual &&
-	test_cmp expect actual
+		notes (:10)
+		EOF
+		git cat-file commit refs/notes/foobar^ | sed 1d >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'Q: verify second notes tree' '
-	sort >expect <<-EOF &&
-	100644 blob $commit1
-	100644 blob $commit2
-	100644 blob $commit3
-	EOF
-	git cat-file -p refs/notes/foobar^^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
-	test_cmp expect actual
+	setup_notes_repo &&
+	(
+		cd repo &&
+		sort >expect <<-EOF &&
+		100644 blob $commit1
+		100644 blob $commit2
+		100644 blob $commit3
+		EOF
+		git cat-file -p refs/notes/foobar^^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'Q: verify second note for first commit' '
-	echo "$note1b_data" >expect &&
-	git cat-file blob refs/notes/foobar^:$commit1 >actual &&
-	test_cmp expect actual
+	setup_notes_repo &&
+	(
+		cd repo &&
+		echo "$note1b_data" >expect &&
+		git cat-file blob refs/notes/foobar^:$commit1 >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'Q: verify first note for second commit' '
-	echo "$note2_data" >expect &&
-	git cat-file blob refs/notes/foobar^:$commit2 >actual &&
-	test_cmp expect actual
+	setup_notes_repo &&
+	(
+		cd repo &&
+		echo "$note2_data" >expect &&
+		git cat-file blob refs/notes/foobar^:$commit2 >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'Q: verify first note for third commit' '
-	echo "$note3_data" >expect &&
-	git cat-file blob refs/notes/foobar^:$commit3 >actual &&
-	test_cmp expect actual
+	setup_notes_repo &&
+	(
+		cd repo &&
+		echo "$note3_data" >expect &&
+		git cat-file blob refs/notes/foobar^:$commit3 >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'Q: verify third notes commit' '
-	cat >expect <<-EOF &&
-	author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	setup_notes_repo &&
+	(
+		cd repo &&
+		cat >expect <<-EOF &&
+		author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
-	notes (:11)
-	EOF
-	git cat-file commit refs/notes/foobar2 | sed 1d >actual &&
-	test_cmp expect actual
+		notes (:11)
+		EOF
+		git cat-file commit refs/notes/foobar2 | sed 1d >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'Q: verify third notes tree' '
-	sort >expect <<-EOF &&
-	100644 blob $commit1
-	EOF
-	git cat-file -p refs/notes/foobar2^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
-	test_cmp expect actual
+	setup_notes_repo &&
+	(
+		cd repo &&
+		sort >expect <<-EOF &&
+		100644 blob $commit1
+		EOF
+		git cat-file -p refs/notes/foobar2^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'Q: verify third note for first commit' '
-	echo "$note1c_data" >expect &&
-	git cat-file blob refs/notes/foobar2:$commit1 >actual &&
-	test_cmp expect actual
+	setup_notes_repo &&
+	(
+		cd repo &&
+		echo "$note1c_data" >expect &&
+		git cat-file blob refs/notes/foobar2:$commit1 >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'Q: verify fourth notes commit' '
-	cat >expect <<-EOF &&
-	parent $(git rev-parse --verify refs/notes/foobar^)
-	author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	setup_notes_repo &&
+	(
+		cd repo &&
+		cat >expect <<-EOF &&
+		parent $(git rev-parse --verify refs/notes/foobar^)
+		author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
-	notes (:12)
-	EOF
-	git cat-file commit refs/notes/foobar | sed 1d >actual &&
-	test_cmp expect actual
+		notes (:12)
+		EOF
+		git cat-file commit refs/notes/foobar | sed 1d >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'Q: verify fourth notes tree' '
-	sort >expect <<-EOF &&
-	100644 blob $commit2
-	EOF
-	git cat-file -p refs/notes/foobar^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
-	test_cmp expect actual
+	setup_notes_repo &&
+	(
+		cd repo &&
+		sort >expect <<-EOF &&
+		100644 blob $commit2
+		EOF
+		git cat-file -p refs/notes/foobar^{tree} | sed "s/ [0-9a-f]*	/ /" >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'Q: verify second note for second commit' '
-	echo "$note2b_data" >expect &&
-	git cat-file blob refs/notes/foobar:$commit2 >actual &&
-	test_cmp expect actual
+	setup_notes_repo &&
+	(
+		cd repo &&
+		echo "$note2b_data" >expect &&
+		git cat-file blob refs/notes/foobar:$commit2 >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'Q: deny note on empty branch' '
-	cat >input <<-EOF &&
-	reset refs/heads/Q0
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		cat >input <<-EOF &&
+		reset refs/heads/Q0
 
-	commit refs/heads/note-Q0
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	Note for an empty branch.
-	COMMIT
+		commit refs/heads/note-Q0
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		Note for an empty branch.
+		COMMIT
 
-	N inline refs/heads/Q0
-	data <<NOTE
-	some note
-	NOTE
-	EOF
-	test_must_fail git fast-import <input
+		N inline refs/heads/Q0
+		data <<NOTE
+		some note
+		NOTE
+		EOF
+		test_must_fail git fast-import <input
+	)
 '
 
 ###

-- 
2.56.GIT

