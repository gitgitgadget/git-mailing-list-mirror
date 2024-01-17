Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8E325542
	for <git@vger.kernel.org>; Wed, 17 Jan 2024 19:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705521169; cv=none; b=i0pUzx2wi0RJ+kezrKVtCHGIMTBxb3j0ZfTSgwY7cyNI6HJj/dNwX9ZdBM6N3zkaDe9GWP9ZYb65YGmyPIF66vZJmNTwdhQd+lmx7H20DILc2hHMjhUixwEq0xJoMrdQmloHcOvI2a0znoMwebWgzr18SOAdQnfn2kihW7Xsr2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705521169; c=relaxed/simple;
	bh=8o6c5kDp3IFlRDQTeaCJWSQLMR/7sacTRvvCdfh2+2s=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:In-Reply-To:References:From:Date:Subject:Fcc:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:To:Cc; b=FBjwpb6c3S6rE+lY5o++jFnn1lA8kbfJciJ60YkP0SCR4+Aib6GPzTIaWoYJ5N+W+pM2yphghMmpXaM7CIHtMq7Vqp/kkkvU+UnMzys6+MJYKNcI54wDYlWSInAU1skG8vT9ld1h+DYlVHKyWwFYn8QBrcBZfRWeNyM4u7hVv1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcHry+vi; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcHry+vi"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-337c62b5f11so610098f8f.3
        for <git@vger.kernel.org>; Wed, 17 Jan 2024 11:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705521166; x=1706125966; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7tqBQDP5QKxdWXO3TjkanPjtuLJiHEPrFW6EKmv97g=;
        b=OcHry+vi/vbVdFU+gFDO0m/feDGN+wj1wNCOkDtSFXH6dTVA5RIcxANcSGWq900hkN
         sc7XXEBIoaaCMU+0H1ELF13DV8WsRWk212nR5K3j+CJbx2APqQ85gvNLaQQdBnNNAPvu
         xSOPclA2bk0+l00ONPVQB6+BKQx6iRmfvWFh2BKjbB+cPGRsW5Mhqtp2tRkNqacAHhrl
         jxQTHnAV7P104hWTB2WwLnoDul0USxBjmJE3KodpnsmG5avEaRDqykm5QeNABl1tvO+Q
         wPYExN8/zfBi5hYBFVD3vjfNe94vm4W41mVWZNslX6nWDH6PH4suhu1lYMcUY8RLwNsk
         1Vmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705521166; x=1706125966;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7tqBQDP5QKxdWXO3TjkanPjtuLJiHEPrFW6EKmv97g=;
        b=Qj6m4fw0kdGTRbaDBtMWCXpLNOVQBzqBA5yoqYizvP6hHCxCkt64EJUFfZQwZxhzPQ
         ffXzaQyRJ+JlMuZbW1FXwwxyzsd4f1ibJB+CyJ6kwBAJb4bK9CcLlHNn0T0bN/sos7U/
         4bRyzt9h3I2OT8x5rFDaEsNPF2fW3SPOmwscXPr2O5+tidIl8rWymFlxEPBXGmFGXUPx
         GeEi6VuAI4NPmBFW5ywnGcO3yT1SG3yTRy4wGVXJk9a2mmtOQ7kHtWZtYNAsxviTjB67
         CV6FtfsdSFLJ3cZf066t90LpjiykpIKxFvbglB8rH5PUj4NN/06y6RXLyOT2LDc5yIQU
         7pdA==
X-Gm-Message-State: AOJu0YwfF3bWlk148UCptv4ReYXv9COpIoE7ACFA2RD6gr7OF6+AzYha
	Xn4X3duOwnGePZJR+BGNQL2ydNaqrys=
X-Google-Smtp-Source: AGHT+IF7k1hGZvaXAZF8+8lw3G3PwL42FqaQHkvr6We0FDiziwpM14TqIv8zJIYkiOxibsfRm5RMfg==
X-Received: by 2002:adf:b1de:0:b0:337:b479:8177 with SMTP id r30-20020adfb1de000000b00337b4798177mr1692995wra.123.1705521165761;
        Wed, 17 Jan 2024 11:52:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n18-20020a5d4012000000b00337c485f1d2sm1976800wrp.82.2024.01.17.11.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 11:52:45 -0800 (PST)
Message-ID: <39e69fde3d70220e03e3e103f46bc7c089cf2136.1705521155.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Jan 2024 19:52:34 +0000
Subject: [PATCH 11/12] t4202: move reffiles specific tests to t0600
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

Move two tests into t0600 since they write loose reflog refs manually
and thus are specific to the reffiles backend.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t0600-reffiles-backend.sh | 17 +++++++++++++++++
 t/t4202-log.sh              | 17 -----------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
index bee61b2d19d..c88576dfea5 100755
--- a/t/t0600-reffiles-backend.sh
+++ b/t/t0600-reffiles-backend.sh
@@ -554,4 +554,21 @@ test_expect_success 'drop stash reflog updates refs/stash with rewrite' '
 	test_cmp expect actual
 '
 
+test_expect_success 'log diagnoses bogus HEAD hash' '
+	git init empty &&
+	test_when_finished "rm -rf empty" &&
+	echo 1234abcd >empty/.git/refs/heads/main &&
+	test_must_fail git -C empty log 2>stderr &&
+	test_grep broken stderr
+'
+
+test_expect_success 'log diagnoses bogus HEAD symref' '
+	git init empty &&
+	test-tool -C empty ref-store main create-symref HEAD refs/heads/invalid.lock &&
+	test_must_fail git -C empty log 2>stderr &&
+	test_grep broken stderr &&
+	test_must_fail git -C empty log --default totally-bogus 2>stderr &&
+	test_grep broken stderr
+'
+
 test_done
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index ddd205f98ab..60fe60d7610 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -2255,23 +2255,6 @@ test_expect_success 'log on empty repo fails' '
 	test_grep does.not.have.any.commits stderr
 '
 
-test_expect_success REFFILES 'log diagnoses bogus HEAD hash' '
-	git init empty &&
-	test_when_finished "rm -rf empty" &&
-	echo 1234abcd >empty/.git/refs/heads/main &&
-	test_must_fail git -C empty log 2>stderr &&
-	test_grep broken stderr
-'
-
-test_expect_success REFFILES 'log diagnoses bogus HEAD symref' '
-	git init empty &&
-	test-tool -C empty ref-store main create-symref HEAD refs/heads/invalid.lock &&
-	test_must_fail git -C empty log 2>stderr &&
-	test_grep broken stderr &&
-	test_must_fail git -C empty log --default totally-bogus 2>stderr &&
-	test_grep broken stderr
-'
-
 test_expect_success 'log does not default to HEAD when rev input is given' '
 	git log --branches=does-not-exist >actual &&
 	test_must_be_empty actual
-- 
gitgitgadget

