Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311417;
	b=ePb/nSkUMbxvH175bH3YKmlrimBmBpV6KvfSAukAIw+nJ7IjQZJVgyFFxxKAr7KR//yu
	 k8ua7FZieDT5Iy4r7Pewn16HicXww1W7QI29kZTExb7idawWnUCCnszhoFoz9t3tDDRtP
	 OR3l8lIVGZHOg6V4OHb2uIps05mQpdTGEKDXwj91BvpiO99FNPzCtk7YMaqX50W2nVWQT
	 BhQoffUztpdICGtD015A5YQt2uJBw7XReWNGK6Tn7ywIT2rfusVi8vG+85yG5q3KOnEVy
	 0r6gruwc+TJAk3cm9DcniMyADzb1BNK0aMl4Y51RMnVyz2A0+0g08BmTqQy4mPjy5Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311417;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=JN7zBTApwxJd9+5r/y3joz9pMpS1q+sTbBOhVaZpscU=;
	b=PDTvajE3mms/CO9RckeVsmZCFTEq7O7V0YCirQeqwkZE+OvJDW0IrfeXs4lrAWOgBjDK
	 3B3lfLMICAddgOdNzAKB1Cg+fMLb+WDCaVqwlJepW13UfONC8hH4LxA08xjp4OJW9b+8X
	 bSaHF6hSb69w376F0bDapX6bE/kC2IZ9SQcV/6L88xNiiQl/hPAPfYXNZbxaUPZILUyP+
	 Rqv2XhwchZC+tyL9lRLOu3JS5hYBQBk1T/DU0/yZAce+TH5shim9ELVHSndOf2SLtxnfq
	 Xrz428HpGlDSZFgkEU7ZuAPeU1SmTMNa9ELIuxVfdbGsCmHCp8Tf+q63ro0q4GnLBGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PwIiaUFH;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3551606C606
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 11:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3551606C606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PwIiaUFH
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso19510425e9.1
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 03:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794311415; x=1794916215; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JN7zBTApwxJd9+5r/y3joz9pMpS1q+sTbBOhVaZpscU=;
        b=PwIiaUFH/dEa3R0onMcerOnYv7CCRSoFYGs1YtzNE18Kvi9Sq0PprwUVh8xdSSm8Nj
         9FdTrqRYHBMD58oYZYuwQPVU4dWYst0KXmeLx0600drVMORWhmPYuGrQbohdy/Jh+30a
         vzUsgT2tk900ZhDqgxWxF00GhvSYw/lhk+2Rfl0z0dvxVHgiP6k7i6wiXqFroxYUI5Ri
         8Sg4h1sdlsCU9Fcu3LEpCLV9gYBVTpgjipkEZ6KqdVPoIqRe0MHr7zjeHPRM4s6MDkBp
         Ip1e14WUcauzIMqeP82n3mJL1JFfvNx5Nt4ToKVbsFCyAv3j9xZq45Zn6hFIey/zVD/l
         wsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794311415; x=1794916215;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JN7zBTApwxJd9+5r/y3joz9pMpS1q+sTbBOhVaZpscU=;
        b=EQZUZ85KTCtPZEQhauKIICfAzf/tb4PTE4WRgZpToZNqB/9HM3QSCm7MYakw090biC
         2H9PCU0yK5vr7bHO14G0baz8ocLZwihBDg57tuK1X3QYJXBBBr1O5V5xPJMJSHAsVxab
         pvqlj7QF299nXNHutkfDivqJwyoUvzwUSafBE7Z9xto1jN3aWkP+rLSvMhvoEFQa0zPd
         u5NpPXGpQZ16r9WcTRv1QwODx83schzfEKCT2nrRp0iFZ0A/QFtj/+ioj3qSZx/FUUdI
         bkACxWQi9UtEFLIv+xjLahi0HtfqT9vr6ENburzUrPBdrxu2h1w6vGPV5jm2+z8Ti6U3
         CyMw==
X-Gm-Message-State: APuU4Z8rp1Ak7TGZOMkNuByMC4f/r5De9zhyiDmekHiSpydF3YHJeLxV
	gpdB5FPTdQrZ7iVDJN7KWy9+OCWq/CMGZZOAphKPkjbEVafQJfY8BfB4uCZsDw==
X-Gm-Gg: AYBFou3i10R3y9gWG7td2tTBx8tzeDiwYDyOX21VJewgP5glGBr+FTtl0v00DPyj1V/
	hz3rtc6NIYj+q5nZD1UXfy7tl9OdY+KqAe4JdGYNkP11YyHydcs+4bkb5AOBVUT4FqIZpXMRhc3
	t72PzfQjTv6Hjjalfe8wgjArynoVZQX1nukavNF8wVcdojUCCTpN2r1wZ3Kcqs9jhM5y0gc75O6
	Tjv1YSDuiSsgzLkOS/Gsak8iU/Ao5+Lk2fZ5RikTCXbBP2QWp3PolqHoTqZ49mxoIMKq2Vwlnya
	+HmrX30PnLIUmToVCj3SIcEhsMEDtEA9lOMsGsezHd3y6K2MHXngCEeGXzeTSuShnTan0AFfr7q
	ezxG92MDHEicVnxbwSyKY4NCWck5qtSSiFbQGOIbTpHLODdU9XMTt5b8l/3zyokRJjTioO8xGX7
	Z7LT4Hsb2TybbeosePi5RpHsHDbmq9WFIMyloVUe2MlK9FaOaUQgmzm57UNegXvdbE//aQvKVyb
	mb99Ebu2WKDQfod9DaR006IGJsOlvNBYPxqGfyvDaa4TbSYwEKaq3X7NRPUckGJk6FJZqi3kWaQ
	qcmRahHAewv7ROxwVBk6ZdJ4GYsLv2SD1GqvMn7lg+wD+lOtRJgtfvw9Ft4bUkmw6a8=
X-Received: by 2002:a05:600c:350a:b0:4a6:42cc:bf66 with SMTP id 5b1f17b1804b1-4ba0233d8b3mr37018435e9.11.1794311415179;
        Tue, 10 Nov 2026 03:50:15 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1917:82b:d709:897d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02005762sm60715995e9.2.2026.11.10.03.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:50:14 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 10 Nov 2026 12:50:00 +0100
Subject: [PATCH 15/20] t9300: make the cat-blob tests self-contained
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
Message-Id: <20261110-kn-fast-import-tests-1-v1-15-dbd9ee502aae@gmail.com>
References: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
In-Reply-To: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11628;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=CqgDvPHZa6iyFXERGoC5F8c1G1AjhT3TDxLw3KHPzgw=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGrzBOm0DGxQ9T1gsHza1zo0OMP3HnnbpCBuk
 Lh2qRR/LbjKMokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq8wTpAAoJED7VnySO
 Rox/5boMAJOCgDyKJ2lt2C93LdJEwjGf4Mz+zAQcLeOKEUi17ElEXbpbcKnZ18cp5STx3b7GMUY
 h5Jvft78XgmWj/dQPYzLAnuc2r4HD8LkHLsRl0AoqQk1zOF25krgrN1vqXvcdwT5pRKletJTou+
 7mIi1yRnB7UDdaxM1iejtmTZ+tG5d4YhF19tP+UZ38uHd2ERs2ZR9ljj976+u+ZD7d/NI0M3y4/
 sgy9SmI4Pm3chMdAz14uNk+rk3AyULa5oeY0ihmYkwqBX6r9eWknx59I7G7hunJpZzuF5//h/7e
 gYvWcg2TWfGaDvWeTXDJslvpv27Q6nAas9iHR6TrxDQbj6XxAP/WOPPuppvnYdhw4iGsLOxpvm9
 058ijzJ6rVah0yyrijVcxPQxjdiQySovH1FXSfjCF1PGFvCgHWQJ8d8dWhgrm0TS9EmGLNn3TLP
 DFlTu2lCtO3b74/YGhzEY7ntQBbFVY/Qwpo9oi/h5WtiIOdwDdh2uoWWhY52HwRDdMP2NdtNe+8
 rQ=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The 'R: print' tests and 'R: copy using cat-file' write blobs into the
repository of the trash directory, which all other tests share. 'R:
print two blobs to stdout' and 'R: copy using cat-file' also read the
'big' file written by the preceding 'setup: big file' test, so they
can't run on their own.

Run each of these tests in a new repository. Convert the setup test to a
'setup_big_file()' function, which writes the file in the repository of
the calling test, and invoke it from both tests.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t9300-fast-import.sh | 428 ++++++++++++++++++++++++++++---------------------
 1 file changed, 242 insertions(+), 186 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 04c3bfe0c1..3f0e7b8b1f 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2983,87 +2983,117 @@ test_expect_success 'R: cat-blob-fd must be a nonnegative integer' '
 '
 
 test_expect_success !MINGW 'R: print old blob' '
-	blob=$(echo "yes it can" | git hash-object -w --stdin) &&
-	cat >expect <<-EOF &&
-	${blob} blob 11
-	yes it can
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
 
-	EOF
-	echo "cat-blob $blob" |
-	git fast-import --cat-blob-fd=6 6>actual &&
-	test_cmp expect actual
+		blob=$(echo "yes it can" | git hash-object -w --stdin) &&
+		cat >expect <<-EOF &&
+		${blob} blob 11
+		yes it can
+
+		EOF
+		echo "cat-blob $blob" |
+		git fast-import --cat-blob-fd=6 6>actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success !MINGW 'R: in-stream cat-blob-fd not respected' '
-	echo hello >greeting &&
-	blob=$(git hash-object -w greeting) &&
-	cat >expect <<-EOF &&
-	${blob} blob 6
-	hello
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
 
-	EOF
-	git fast-import --cat-blob-fd=3 3>actual.3 >actual.1 <<-EOF &&
-	cat-blob $blob
-	EOF
-	test_cmp expect actual.3 &&
-	test_must_be_empty actual.1 &&
-	git fast-import 3>actual.3 >actual.1 <<-EOF &&
-	option cat-blob-fd=3
-	cat-blob $blob
-	EOF
-	test_must_be_empty actual.3 &&
-	test_cmp expect actual.1
+		echo hello >greeting &&
+		blob=$(git hash-object -w greeting) &&
+		cat >expect <<-EOF &&
+		${blob} blob 6
+		hello
+
+		EOF
+		git fast-import --cat-blob-fd=3 3>actual.3 >actual.1 <<-EOF &&
+		cat-blob $blob
+		EOF
+		test_cmp expect actual.3 &&
+		test_must_be_empty actual.1 &&
+		git fast-import 3>actual.3 >actual.1 <<-EOF &&
+		option cat-blob-fd=3
+		cat-blob $blob
+		EOF
+		test_must_be_empty actual.3 &&
+		test_cmp expect actual.1
+	)
 '
 
 test_expect_success !MINGW 'R: print mark for new blob' '
-	echo "effluentish" | git hash-object --stdin >expect &&
-	git fast-import --cat-blob-fd=6 6>actual <<-\EOF &&
-	blob
-	mark :1
-	data <<BLOB_END
-	effluentish
-	BLOB_END
-	get-mark :1
-	EOF
-	test_cmp expect actual
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		echo "effluentish" | git hash-object --stdin >expect &&
+		git fast-import --cat-blob-fd=6 6>actual <<-\EOF &&
+		blob
+		mark :1
+		data <<BLOB_END
+		effluentish
+		BLOB_END
+		get-mark :1
+		EOF
+		test_cmp expect actual
+	)
 '
 
 test_expect_success !MINGW 'R: print new blob' '
-	blob=$(echo "yep yep yep" | git hash-object --stdin) &&
-	cat >expect <<-EOF &&
-	${blob} blob 12
-	yep yep yep
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
 
-	EOF
-	git fast-import --cat-blob-fd=6 6>actual <<-\EOF &&
-	blob
-	mark :1
-	data <<BLOB_END
-	yep yep yep
-	BLOB_END
-	cat-blob :1
-	EOF
-	test_cmp expect actual
+		blob=$(echo "yep yep yep" | git hash-object --stdin) &&
+		cat >expect <<-EOF &&
+		${blob} blob 12
+		yep yep yep
+
+		EOF
+		git fast-import --cat-blob-fd=6 6>actual <<-\EOF &&
+		blob
+		mark :1
+		data <<BLOB_END
+		yep yep yep
+		BLOB_END
+		cat-blob :1
+		EOF
+		test_cmp expect actual
+	)
 '
 
 test_expect_success !MINGW 'R: print new blob by sha1' '
-	blob=$(echo "a new blob named by sha1" | git hash-object --stdin) &&
-	cat >expect <<-EOF &&
-	${blob} blob 25
-	a new blob named by sha1
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
 
-	EOF
-	git fast-import --cat-blob-fd=6 6>actual <<-EOF &&
-	blob
-	data <<BLOB_END
-	a new blob named by sha1
-	BLOB_END
-	cat-blob $blob
-	EOF
-	test_cmp expect actual
+		blob=$(echo "a new blob named by sha1" | git hash-object --stdin) &&
+		cat >expect <<-EOF &&
+		${blob} blob 25
+		a new blob named by sha1
+
+		EOF
+		git fast-import --cat-blob-fd=6 6>actual <<-EOF &&
+		blob
+		data <<BLOB_END
+		a new blob named by sha1
+		BLOB_END
+		cat-blob $blob
+		EOF
+		test_cmp expect actual
+	)
 '
 
-test_expect_success 'setup: big file' '
+setup_big_file () {
 	(
 		echo "the quick brown fox jumps over the lazy dog" >big &&
 		for i in 1 2 3
@@ -3073,153 +3103,179 @@ test_expect_success 'setup: big file' '
 			exit
 		done
 	)
-'
+}
 
 test_expect_success 'R: print two blobs to stdout' '
-	blob1=$(git hash-object big) &&
-	blob1_len=$(wc -c <big) &&
-	blob2=$(echo hello | git hash-object --stdin) &&
-	{
-		echo ${blob1} blob $blob1_len &&
-		cat big &&
-		cat <<-EOF
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
 
-		${blob2} blob 6
-		hello
+		setup_big_file &&
+		blob1=$(git hash-object big) &&
+		blob1_len=$(wc -c <big) &&
+		blob2=$(echo hello | git hash-object --stdin) &&
+		{
+			echo ${blob1} blob $blob1_len &&
+			cat big &&
+			cat <<-EOF
 
-		EOF
-	} >expect &&
-	{
-		cat <<-\END_PART1 &&
-			blob
-			mark :1
-			data <<data_end
-		END_PART1
-		cat big &&
-		cat <<-\EOF
-			data_end
-			blob
-			mark :2
-			data <<data_end
+			${blob2} blob 6
 			hello
-			data_end
-			cat-blob :1
-			cat-blob :2
-		EOF
-	} |
-	git fast-import >actual &&
-	test_cmp expect actual
+
+			EOF
+		} >expect &&
+		{
+			cat <<-\END_PART1 &&
+				blob
+				mark :1
+				data <<data_end
+			END_PART1
+			cat big &&
+			cat <<-\EOF
+				data_end
+				blob
+				mark :2
+				data <<data_end
+				hello
+				data_end
+				cat-blob :1
+				cat-blob :2
+			EOF
+		} |
+		git fast-import >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success PIPE 'R: copy using cat-file' '
-	expect_id=$(git hash-object big) &&
-	expect_len=$(wc -c <big) &&
-	echo $expect_id blob $expect_len >expect.response &&
-
-	rm -f blobs &&
-
-	mkfifo blobs &&
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
 	(
-		export GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL GIT_COMMITTER_DATE &&
-		cat <<-\EOF &&
-		feature cat-blob
-		blob
-		mark :1
-		data <<BLOB
-		EOF
-		cat big &&
-		cat <<-\EOF &&
-		BLOB
-		cat-blob :1
-		EOF
+		cd repo &&
 
-		read blob_id type size <&3 &&
-		echo "$blob_id $type $size" >response &&
-		test_copy_bytes $size >blob <&3 &&
-		read newline <&3 &&
+		setup_big_file &&
+		expect_id=$(git hash-object big) &&
+		expect_len=$(wc -c <big) &&
+		echo $expect_id blob $expect_len >expect.response &&
 
-		cat <<-EOF &&
-		commit refs/heads/copied
-		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-		data <<COMMIT
-		copy big file as file3
-		COMMIT
-		M 644 inline file3
-		data <<BLOB
-		EOF
-		cat blob &&
-		echo BLOB
-	) 3<blobs |
-	git fast-import --cat-blob-fd=3 3>blobs &&
-	git show copied:file3 >actual &&
-	test_cmp expect.response response &&
-	test_cmp big actual
+		rm -f blobs &&
+
+		mkfifo blobs &&
+		(
+			export GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL GIT_COMMITTER_DATE &&
+			cat <<-\EOF &&
+			feature cat-blob
+			blob
+			mark :1
+			data <<BLOB
+			EOF
+			cat big &&
+			cat <<-\EOF &&
+			BLOB
+			cat-blob :1
+			EOF
+
+			read blob_id type size <&3 &&
+			echo "$blob_id $type $size" >response &&
+			test_copy_bytes $size >blob <&3 &&
+			read newline <&3 &&
+
+			cat <<-EOF &&
+			commit refs/heads/copied
+			committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+			data <<COMMIT
+			copy big file as file3
+			COMMIT
+			M 644 inline file3
+			data <<BLOB
+			EOF
+			cat blob &&
+			echo BLOB
+		) 3<blobs |
+		git fast-import --cat-blob-fd=3 3>blobs &&
+		git show copied:file3 >actual &&
+		test_cmp expect.response response &&
+		test_cmp big actual
+	)
 '
 
 test_expect_success PIPE 'R: print blob mid-commit' '
-	rm -f blobs &&
-	echo "A blob from _before_ the commit." >expect &&
-	mkfifo blobs &&
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
 	(
-		exec 3<blobs &&
-		cat <<-EOF &&
-		feature cat-blob
-		blob
-		mark :1
-		data <<BLOB
-		A blob from _before_ the commit.
-		BLOB
-		commit refs/heads/temporary
-		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-		data <<COMMIT
-		Empty commit
-		COMMIT
-		cat-blob :1
-		EOF
+		cd repo &&
 
-		read blob_id type size <&3 &&
-		test_copy_bytes $size >actual <&3 &&
-		read newline <&3 &&
+		rm -f blobs &&
+		echo "A blob from _before_ the commit." >expect &&
+		mkfifo blobs &&
+		(
+			exec 3<blobs &&
+			cat <<-EOF &&
+			feature cat-blob
+			blob
+			mark :1
+			data <<BLOB
+			A blob from _before_ the commit.
+			BLOB
+			commit refs/heads/temporary
+			committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+			data <<COMMIT
+			Empty commit
+			COMMIT
+			cat-blob :1
+			EOF
 
-		echo
-	) |
-	git fast-import --cat-blob-fd=3 3>blobs &&
-	test_cmp expect actual
+			read blob_id type size <&3 &&
+			test_copy_bytes $size >actual <&3 &&
+			read newline <&3 &&
+
+			echo
+		) |
+		git fast-import --cat-blob-fd=3 3>blobs &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success PIPE 'R: print staged blob within commit' '
-	rm -f blobs &&
-	echo "A blob from _within_ the commit." >expect &&
-	mkfifo blobs &&
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
 	(
-		exec 3<blobs &&
-		cat <<-EOF &&
-		feature cat-blob
-		commit refs/heads/within
-		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-		data <<COMMIT
-		Empty commit
-		COMMIT
-		M 644 inline within
-		data <<BLOB
-		A blob from _within_ the commit.
-		BLOB
-		EOF
+		cd repo &&
 
-		to_get=$(
-			echo "A blob from _within_ the commit." |
-			git hash-object --stdin
-		) &&
-		echo "cat-blob $to_get" &&
+		rm -f blobs &&
+		echo "A blob from _within_ the commit." >expect &&
+		mkfifo blobs &&
+		(
+			exec 3<blobs &&
+			cat <<-EOF &&
+			feature cat-blob
+			commit refs/heads/within
+			committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+			data <<COMMIT
+			Empty commit
+			COMMIT
+			M 644 inline within
+			data <<BLOB
+			A blob from _within_ the commit.
+			BLOB
+			EOF
 
-		read blob_id type size <&3 &&
-		test_copy_bytes $size >actual <&3 &&
-		read newline <&3 &&
+			to_get=$(
+				echo "A blob from _within_ the commit." |
+				git hash-object --stdin
+			) &&
+			echo "cat-blob $to_get" &&
 
-		echo deleteall
-	) |
-	git fast-import --cat-blob-fd=3 3>blobs &&
-	test_cmp expect actual
+			read blob_id type size <&3 &&
+			test_copy_bytes $size >actual <&3 &&
+			read newline <&3 &&
+
+			echo deleteall
+		) |
+		git fast-import --cat-blob-fd=3 3>blobs &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'R: quiet option results in no stats being output' '

-- 
2.56.GIT

