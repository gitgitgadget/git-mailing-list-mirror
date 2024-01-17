Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880D024B2F
	for <git@vger.kernel.org>; Wed, 17 Jan 2024 19:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705521164; cv=none; b=Np8ynrkPwhGXrDais/xObj4t/ItR/IC4J1F5D/kySMwNIfldF2g1ID/U8rABs2qaFTEQc8mnZ9h8wcPR7SPVjVUTtStoRwgXQa3zXo5jlrRqqrkwq6WBuMHBbCXGDXmkqNmDI0G/H75jQ2lpNLFqNEWKxcVnO8vjpENbKqYWZGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705521164; c=relaxed/simple;
	bh=tJRDbKp8I1ffYLNxQFy6BO/pFx+b2M7vKetBPub960U=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:In-Reply-To:References:From:Date:Subject:Fcc:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:To:Cc; b=pX2eNrOuH+5hm+JpcKR4DKdU13zdgeU27cHmf6bnSn/qEwbS1Jk9D97Os5pr8D8SBlEYTakqp0UUP5lcIEIgumIvRxh7/DhVpLwzdOpHq173cw1/mdmmimuwmPppkcbTDkAK6o1HGds8CEfVFUqV5zu8BmzAxabGhuZiPnreyQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwhiE+7S; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwhiE+7S"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e60e137aaso65497785e9.0
        for <git@vger.kernel.org>; Wed, 17 Jan 2024 11:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705521160; x=1706125960; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZ/83xS30W1Jg7QtE801kZwkX4lkJ4PyWhx7zuIeaWs=;
        b=cwhiE+7SZKDDhbcorYo+9lPNV2KqIsVomFcUtUq/BCPln5aiD1cM2qOQf0/1MgS5vd
         8hINa0oyzvBGYXj/soiXIDV/qQFnOPSvg8VF8ImNWYN588gaP4TXel28UCIci8AocpaW
         pfdQUkcmi7zoBtbQ9gQCU80h1wsey94oLIoYninE31EsevM/E6sZul9fj+aYcYUPmcsw
         kxOTnC3QHa73EoUwVhqJhNHHfWa5FfPMmfvfEGkpkT2cV3epn4QeN2ybH5HEQNykq0tu
         8fB6Q3TUnK+JWBtG0gM4Y7HHR+lqVsNnAheaL+/2WQ6RSiCnMww/eydG0nAex7961zkw
         /F4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705521160; x=1706125960;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZ/83xS30W1Jg7QtE801kZwkX4lkJ4PyWhx7zuIeaWs=;
        b=wqAhhWsgJ79XWKelM0idbom6NWMqvh2p5QzAwqjwdS823FRxk+M91X6Tj44iDRRGYN
         ZYQ/c0S86bNx2v1CpSpfHDfn56GFv3aEBeb8zvBqRMmFhw6WoOV6p4rte50njmSXKyoR
         i5a5RDncp9g6EJ4XwKtuGrefKmVuAfeSVHgHCfQzMcNFpM1x974fkhy4WO7bsUMvaK4a
         BhzCnbMDH7yMBRVS+Q9xKzzS60A8HRVCRTDDdVRFg9H7tFTxCduDcbL8aVZPQ6/3+Le4
         p4+vGQMWnXRRIRSlyIQl1Thf42Q4Qwvy4YOi65uB1+tsey7SodtmdU+qI0YacFTxb4F8
         7LaA==
X-Gm-Message-State: AOJu0YyZdoYXuMGCrQ6949sbNiorN1Bt6ipDVFtOjldFJ4xOG2FsU2lj
	DyzP1fZ0r4wPdXqsbEppnqz3oNZEIo4=
X-Google-Smtp-Source: AGHT+IFksD/Qi7K0W7gExvK1TPuOlHluseHm5oijSbp58PfksjIxQOem5hTLoAcUE1bp/XLv1k6nWA==
X-Received: by 2002:a05:600c:2112:b0:40e:7f2c:9dbd with SMTP id u18-20020a05600c211200b0040e7f2c9dbdmr2713994wml.13.1705521160380;
        Wed, 17 Jan 2024 11:52:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q20-20020a05600c46d400b0040e395cd20bsm27309141wmo.7.2024.01.17.11.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 11:52:40 -0800 (PST)
Message-ID: <c2af695f551bd70c5f8574239018857a0ab91b35.1705521155.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Jan 2024 19:52:28 +0000
Subject: [PATCH 05/12] t1405: move reffiles specific tests to t0600
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

Move this test to t0600 with other reffiles specific tests since it is
reffiles specific in that it looks into the loose refs directory for an
assertion.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t0600-reffiles-backend.sh | 8 ++++++++
 t/t1405-main-ref-store.sh   | 8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
index 332c8cbc004..53ac4b9b5b8 100755
--- a/t/t0600-reffiles-backend.sh
+++ b/t/t0600-reffiles-backend.sh
@@ -92,6 +92,14 @@ test_expect_success 'setup' '
 	E=$(git rev-parse HEAD)
 '
 
+test_expect_success 'pack_refs(PACK_REFS_ALL | PACK_REFS_PRUNE)' '
+	N=`find .git/refs -type f | wc -l` &&
+	test "$N" != 0 &&
+	test-tool ref-store main pack-refs PACK_REFS_PRUNE,PACK_REFS_ALL &&
+	N=`find .git/refs -type f` &&
+	test -z "$N"
+'
+
 test_expect_success 'empty directory should not fool rev-parse' '
 	prefix=refs/e-rev-parse &&
 	git update-ref $prefix/foo $C &&
diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index 62c1eadb190..976bd71efb5 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -15,14 +15,6 @@ test_expect_success 'setup' '
 	test_commit one
 '
 
-test_expect_success REFFILES 'pack_refs(PACK_REFS_ALL | PACK_REFS_PRUNE)' '
-	N=`find .git/refs -type f | wc -l` &&
-	test "$N" != 0 &&
-	$RUN pack-refs PACK_REFS_PRUNE,PACK_REFS_ALL &&
-	N=`find .git/refs -type f` &&
-	test -z "$N"
-'
-
 test_expect_success 'create_symref(FOO, refs/heads/main)' '
 	$RUN create-symref FOO refs/heads/main nothing &&
 	echo refs/heads/main >expected &&
-- 
gitgitgadget

