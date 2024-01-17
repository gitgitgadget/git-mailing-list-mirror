Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332022554F
	for <git@vger.kernel.org>; Wed, 17 Jan 2024 19:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705521169; cv=none; b=oPnloa3KtNHSHccWdYypSJuaYi5123W7tF8sJn+SvwZhlKfbeVUNajInsKf8sC3ew5/nKizrQrEtmzKHz0ScvtSsa/HQ4+HKnG4+gbMd2pt5ro9xTrP/o6lHwYTtL9ZX+By3uEAXcGWNULQkEwyStFsha4fO9k+FeOYkz6bCpks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705521169; c=relaxed/simple;
	bh=lYbOF+XQYbZ0gkhsGc1XFVu0O6FgMVM+GK4CJm8T4cM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:In-Reply-To:References:From:Date:Subject:Fcc:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:To:Cc; b=uktMCpqXC+2UOtAseJbcHw/3hviDHm5/FUOYR8AXB5dox3rIXFjaVmhQbnKHhEyKSlVSk4pRsxbPZpveWMq1oTUHgeoXJsz4c3aWJv/cjoiJcx1mLgsNkk5TKIMj6EZXgcp7YPD7OlZ9pZWXrKk0Xc6ys2kZeYVEHHhpK/OxIII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEIoI3WI; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEIoI3WI"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e86a9fbd9so17863775e9.1
        for <git@vger.kernel.org>; Wed, 17 Jan 2024 11:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705521166; x=1706125966; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yIbwUXZ7G89WTCGS+QskcTfeUNnIdBAGc/HhL+OpOug=;
        b=aEIoI3WI4rede6VyENoKPEVml5Lw/AtIsAS/5bajEojncl21SSyldTbVwKnJ7wgBEN
         EZ+3jZGsrEEZ50Fhdn3T1R+Le0AkUhfjcX3QgZIFGNzpCrdxk+KfuO0hsbwxPJMdqO1G
         ht4fvG8+zO1d5BhHHm08253B8HggfcRuEkfgbvcUduGwsiekdAXdAvPLKf0xCe/VJMrD
         MgSqdSU1pK+0Vk8rWiUsmKrZr1c1qovCXt3epYQgo44RyMDIWSSSQ3K+D0KSR16KKhU2
         4LkcAVxIeeAiOFho/6HBFTNLI1mPMeO8+H9RbpeTswJcl5f5qd8jZmnpf91whaBTEjHA
         fwCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705521166; x=1706125966;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yIbwUXZ7G89WTCGS+QskcTfeUNnIdBAGc/HhL+OpOug=;
        b=ebb6IlvzZ56VuSrBJFs8TbBicEbggwEbTDDlIYXCAorTwfNRDNAc6CPxVdvGV9ksSh
         sO+7j++pqicj4UmOo9zogMVUzZgyI4OJLxnNuVaBMmqxryoBJl4R9VHYVavtR8+QwqrD
         Ec+lvD8YU14YyyuWx2BO6+78bLzWoJ7qiazfkPCGVibWkFYheZDmBlkQRj/l5uwoQHI9
         V89iB9Cf95AjaLhThEocSs/9odSE887+FfVdPuKIan8vU0kzc+DWbIiGk7EOqYyiZ2Ri
         voJLbf5Ln5SvBIsB/GFWNwLTotM9Nw5YXgh1nK2t+vbWk3DPsjenuhpi02sq3OXIIgUX
         cnhA==
X-Gm-Message-State: AOJu0YzFlQLgLjtF3h4/XynhdCf9PrvMmZfDDXmT6CZGBRFxcG4AFBH6
	C3iepIq/Lu6Dk7vddrTwZPp5TYYtuAg=
X-Google-Smtp-Source: AGHT+IFjQ+2Co4uKUAcLM9wSTOCkRyIghQk8djAc4x/yCFV1kV72aVy2CzHcs4x15uPO940/Di+FKw==
X-Received: by 2002:a05:600c:4715:b0:40e:5759:bcbe with SMTP id v21-20020a05600c471500b0040e5759bcbemr5016891wmo.113.1705521166314;
        Wed, 17 Jan 2024 11:52:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h20-20020a05600c315400b0040e63226f6dsm5602226wmo.1.2024.01.17.11.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 11:52:46 -0800 (PST)
Message-ID: <316a20ed17950e4e45d7ea13d8f6e8d4e064821e.1705521155.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Jan 2024 19:52:35 +0000
Subject: [PATCH 12/12] t5312: move reffiles specific tests to t0600
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

Move a few tests into t0600 since they specifically test the packed-refs
file and thus are specific to the reffiles backend.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t0600-reffiles-backend.sh | 30 ++++++++++++++++++++++++++++++
 t/t5312-prune-corruption.sh | 26 --------------------------
 2 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
index c88576dfea5..190155f592d 100755
--- a/t/t0600-reffiles-backend.sh
+++ b/t/t0600-reffiles-backend.sh
@@ -571,4 +571,34 @@ test_expect_success 'log diagnoses bogus HEAD symref' '
 	test_grep broken stderr
 '
 
+# we do not want to count on running pack-refs to
+# actually pack it, as it is perfectly reasonable to
+# skip processing a broken ref
+test_expect_success 'create packed-refs file with broken ref' '
+	test_tick && git commit --allow-empty -m one &&
+	recoverable=$(git rev-parse HEAD) &&
+	test_tick && git commit --allow-empty -m two &&
+	missing=$(git rev-parse HEAD) &&
+	rm -f .git/refs/heads/main &&
+	cat >.git/packed-refs <<-EOF &&
+	$missing refs/heads/main
+	$recoverable refs/heads/other
+	EOF
+	echo $missing >expect &&
+	git rev-parse refs/heads/main >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'pack-refs does not silently delete broken packed ref' '
+	git pack-refs --all --prune &&
+	git rev-parse refs/heads/main >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success  'pack-refs does not drop broken refs during deletion' '
+	git update-ref -d refs/heads/other &&
+	git rev-parse refs/heads/main >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t5312-prune-corruption.sh b/t/t5312-prune-corruption.sh
index 230cb387122..d8d2e304687 100755
--- a/t/t5312-prune-corruption.sh
+++ b/t/t5312-prune-corruption.sh
@@ -111,30 +111,4 @@ test_expect_success 'pack-refs does not silently delete broken loose ref' '
 	test_cmp expect actual
 '
 
-# we do not want to count on running pack-refs to
-# actually pack it, as it is perfectly reasonable to
-# skip processing a broken ref
-test_expect_success REFFILES 'create packed-refs file with broken ref' '
-	rm -f .git/refs/heads/main &&
-	cat >.git/packed-refs <<-EOF &&
-	$missing refs/heads/main
-	$recoverable refs/heads/other
-	EOF
-	echo $missing >expect &&
-	git rev-parse refs/heads/main >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success REFFILES 'pack-refs does not silently delete broken packed ref' '
-	git pack-refs --all --prune &&
-	git rev-parse refs/heads/main >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success REFFILES  'pack-refs does not drop broken refs during deletion' '
-	git update-ref -d refs/heads/other &&
-	git rev-parse refs/heads/main >actual &&
-	test_cmp expect actual
-'
-
 test_done
-- 
gitgitgadget
