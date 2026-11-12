Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504868;
	b=wwEcU5JiXMZpXq98lr3J/0EDZrREspgLGeckoyHrUxyzTgXrwgP0EO9uIySa383yrOVn
	 6a6eHc2mTNL17dUZbltHqj/jD0KKhHnw9GhH+WFYmzMyD4Ce2bUuB57arBnkn70jYdOft
	 uucU9j/xnbDqihbxGbv2hWepSH9ZCQt2s6hsqitmwKHzhJfU5mYuFhRB4gMex+NZbXECV
	 8rTgzZTE77Xj9DImGpjhoRXofTTdJ5raqlKfAcZuMlJl0kRVponSGtxJaihVHw+4fSpk4
	 VeMyzj+Q+ZeUqLVUaBcqfW+Lh/o0GQH4+e4ptePKxz6cbxE28R9z4kg+ynHywf422iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504868;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=f7ywIx84LlltzGpuwCfrB/hPF/iRRiH3bcsUIaHoiwk=;
	b=fUP89GZ4SXRWp88eE+Dk9jleeTe0WvXmccNlXTM/e977jLWU+9yyQH3rMbYLyWm4VmZe
	 H8/ii4Yggm72nbmGmTBREMJMpzFGR91rW7PyJ/QiTPkobAsS4OSeG/PmetvniLHIZq3Gt
	 BYauoylmnwicqUYibK3TPZD2L4iCpCuBtEL5wOlV1gPrhHPL6UPEJmUL15JAntLvhDCvY
	 RjRIQsU+xWlbhrT3Lsck8ptvcK8WFhL0Jf1bN0kvqnX853lgOxy5riwLpxTmpwSmc9Esj
	 JvyRtlG298BzBvyZu/slkhh9Qr4+NObn6/dU3Zj5HOhnWN5VqGWbL9/LeJ3UdrmU7IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iusAVQ5Q;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693DB606A232
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 17:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 693DB606A232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iusAVQ5Q
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-49a92144733so11573f8f.0
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 09:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794504867; x=1795109667; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f7ywIx84LlltzGpuwCfrB/hPF/iRRiH3bcsUIaHoiwk=;
        b=iusAVQ5Qau+DjpE87t7L9+yTeNwusw/Y8t9H6hbkLlwbO4bMB6RvuGbkkEktq3424h
         y4/IpQWAcNKNQwFKJ/TME4hwdP2uIPxac7Ox+VVILYP9GKBmcDVFd5jaqAG/zj74Mqq1
         3iL3fOx7DdCKZR9roRG+7g1lweM9DvIXwqVCeRtuyVHKRDqPWXsIKQ0mOB8KJAoiMF7i
         /+jODbuNQncvAhNg8kZpJg5uYUAehzY092kn/mvnwhviJXC+gJ1IY/XUK3pS+GhKucts
         GNt7QZlBRYmXbAq/vbLFF3hjtX2UgKzxNAKl9hsUxORNW2M2C8q5RisGfqM9U9dsaBPR
         +JEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504867; x=1795109667;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f7ywIx84LlltzGpuwCfrB/hPF/iRRiH3bcsUIaHoiwk=;
        b=VX/0NI07TITDH17JcT/u8ON5DNhOTAXIOsKWxw7aX3kLwhqeaIrLtVv/LoHcCWLzJL
         zaR2nRh9rDL1Jf7e6tIODcszvzjqX/q/tIyuFchiQAALYv70ZNA37kZTHfejyhLPCqJl
         mAfLymJS52QRKN7PWlpyy4+dTLfpVo5bGLwR9UtRuD9kEGGqVPvk1PA5uaek3zZadVHo
         QYnxk4ZLSnfT1kgzx7XeUzbuFXkAcd2KH9TRKKO91f0aemsL3Vo3LZP5nDv50aAp4X25
         evJAO5BwPYDXXz+iLe070qNhk0sFdx3otKkSbPwQb8zyYP2xeMqnwSBXaFxDlUeeI7Wt
         0cFg==
X-Gm-Message-State: APuU4Z9gkXEAgHWrPQ/YQu/Rn/zA9WOnJ5wFrXBxOmnGGhr1yJfPova5
	5MGU/7YfJb0cOjVzl6vBGncynipJRHPlfCzulKnE0hOZDQQvC3FGm5WWXx64LQ==
X-Gm-Gg: AYBFou3z76dErU1Ovjny+kSHXGDARFDBGK3uPh6UhyHXY6yPndu/hUfjxd4RX8W1xvI
	5aN9cBE+IT3WGjaAKcwnSHY4nY2YVheet6BvUv0l/4+66YnaPqX8nk6kZoQH5Hx/alFBz8PdXFj
	2nYsLRdD3XUXGH5haeE8G2PoEbpYVkoQ1UVN0v9PPKbioh9ZBBFXZj+1+Mv1bI8dg030hFyXSdw
	jenUb23wPoz9oz7EKkku3wyPB99c63wPo7YRuA4+5Wq2/muYAST51GutNqlRS7vNT++z4aEr9ZO
	SjwlsQXugy8HOYHEWTvcJCCFI+dlyanfVij4iFx2UWfQzEdmE+tHveSvc9NhmDwMo2fdpiU594R
	9YAKCF50T/vvW3GI0zaDvIjk1puv6fl8tU2HMDKTtpucAjRQ/zHFgZki4pg/R/rTNN78zDtmWM8
	A3fCL9Yyu6AxwGuNHAPEX774UENCBLfuLXx5MRqtpvewyHKLu4/6SQRfzJtSWEjE30nrTEN948N
	APJdbqpJqP5FvxbeHV2GymFQXjcAK6EjmQO/5+MkmA1tqONdgYwFlPwVKnUVLtRMXepw728uCJm
	WhyKNyVt37yl/SJHzm18FFbjbBKRMP3U6lt2foDR4IT404SFX3COwc5C1f/3cIHSNg6rufvQoST
	oBQPay/9kiurwqg==
X-Received: by 2002:a05:6000:250b:b0:48e:5e20:1371 with SMTP id ffacd0b85a97d-49c6dc01593mr219918f8f.4.1794504866753;
        Thu, 12 Nov 2026 09:34:26 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:cb2b:22fd:d791:9595])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c604ee47dsm345988f8f.38.2026.11.12.09.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:34:25 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 12 Nov 2026 18:34:12 +0100
Subject: [PATCH v2 12/20] t9300: make the pack edges test self-contained
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
Message-Id: <20261112-kn-fast-import-tests-1-v2-12-b8c3a0ab27e8@gmail.com>
References: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
In-Reply-To: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4095; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=yyiZ/+LqHHPQ2RkhX6Z+JpOOx9T4hEQLQTrGdnJcLw0=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGr1+JLurCVpA7f8B61guz3M7at8PqdOqMttM
 NfnsX2AG7llE4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq9fiSAAoJED7VnySO
 Rox/bKkL/17RypA846FkgjZkiNfw3Yg5nO9Olibmqb8UdF+hXysYboebbEMSu05lVGeM8+Iu+Tz
 peR5Vl0pcZ1y5ccPMo2nSBFrW7VpyQ41H1sCw3b3zT9kIZxtuZBD5cXPCPHSqjgV+yZb4pknPzu
 eETeOhC44D32xxZirt86XEKCFg6Id/uTEPRFXsDVNHg2UpV1KG5Rt4UyZyEEL36kKyR4JoOePv5
 JJwo5U07EZpY92iKqegiSRuRFWRLPCio/aKFHG3KrQoy8bdzp/2t9ELrSvCVsMD77UH/GCi8bNp
 vVXJGhIiOLYJWsua99CT7YTf4hsOtIdTtWXqc2bfJ9MdtCU59qfbpiubtFAOLoRgtnMNAyEdFT2
 6dmfE4jwqVuZUSIs3/yZd37bovlFsciQDUnz9aQFrgWIFsi48h2xFRr6EgnluYmCle+PC74qIu8
 DZ+Wa70X1cYWgXXGt+gMLYub6ESWXHIKRn4Vb1UeiZdrerSCrNbZp2ts2tI2c3nnDwLiALUO3e7
 uw=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Similar to the previous commits, modify the pack-edges tests to make
them independent of state from previous tests.

Pack edges are only recorded for packs which are kept, so set
'fastimport.unpackLimit' to 0 for the import.

Create the repository with 'git init -b main', as the import builds on
'main' and t9302, where this test ends up, doesn't set
'GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME'.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t9300-fast-import.sh | 90 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 56 insertions(+), 34 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 54394c892b..5b8550584e 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1030,50 +1030,72 @@ test_expect_success 'H: verify file' '
 ###
 
 test_expect_success 'I: export-pack-edges option forbidden by default' '
-	echo "option git export-pack-edges=edges.list" >input &&
-	test_must_fail git fast-import <input 2>err &&
-	test_grep "option ${SQ}export-pack-edges${SQ} forbidden in input without --allow-unsafe-features" err
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		echo "option git export-pack-edges=edges.list" >input &&
+		test_must_fail git fast-import <input 2>err &&
+		test_grep "option ${SQ}export-pack-edges${SQ} forbidden in input without --allow-unsafe-features" err
+	)
 '
 
 test_expect_success 'I: export-pack-edges' '
-	test_when_finished "rm edges.list" &&
-	cat >input <<-INPUT_END &&
-	commit refs/heads/export-boundary
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	we have a border.  its only 40 characters wide.
-	COMMIT
+	test_when_finished "rm -rf repo" &&
+	git init -b main repo &&
+	(
+		cd repo &&
+		test_commit one &&
 
-	from refs/heads/branch
+		cat >input <<-INPUT_END &&
+		commit refs/heads/export-boundary
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		we have a border.  its only 40 characters wide.
+		COMMIT
 
-	INPUT_END
-	git fast-import --export-pack-edges=edges.list <input &&
-	cat >expect <<-EOF &&
-	.git/objects/pack/pack-.pack: $(git rev-parse --verify export-boundary)
-	EOF
-	sed -e s/pack-.*pack/pack-.pack/ edges.list >actual &&
-	test_cmp expect actual
+		from refs/heads/main
+
+		INPUT_END
+		git -c fastimport.unpackLimit=0 fast-import \
+			--export-pack-edges=edges.list <input &&
+
+		# verify edge list
+		cat >expect <<-EOF &&
+		.git/objects/pack/pack-.pack: $(git rev-parse --verify export-boundary)
+		EOF
+		sed -e s/pack-.*pack/pack-.pack/ edges.list >actual &&
+		test_cmp expect actual
+	)
 '
 
 test_expect_success 'I: export-pack-edges via stdin' '
-	test_when_finished "rm edges.list" &&
-	cat >input <<-INPUT_END &&
-	option git export-pack-edges=edges.list
-	commit refs/heads/export-boundary-2
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	one more similar commit
-	COMMIT
+	test_when_finished "rm -rf repo" &&
+	git init -b main repo &&
+	(
+		cd repo &&
+		test_commit one &&
 
-	from refs/heads/branch
+		cat >input <<-INPUT_END &&
+		option git export-pack-edges=edges.list
+		commit refs/heads/export-boundary
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		one more similar commit
+		COMMIT
 
-	INPUT_END
-	git fast-import --allow-unsafe-features <input &&
-	cat >expect <<-EOF &&
-	.git/objects/pack/pack-.pack: $(git rev-parse --verify export-boundary-2)
-	EOF
-	sed -e s/pack-.*pack/pack-.pack/ edges.list >actual &&
-	test_cmp expect actual
+		from refs/heads/main
+
+		INPUT_END
+
+		git -c fastimport.unpackLimit=0 fast-import \
+			--allow-unsafe-features <input &&
+		cat >expect <<-EOF &&
+		.git/objects/pack/pack-.pack: $(git rev-parse --verify export-boundary)
+		EOF
+		sed -e s/pack-.*pack/pack-.pack/ edges.list >actual &&
+		test_cmp expect actual
+	)
 '
 
 ###

-- 
2.56.GIT

