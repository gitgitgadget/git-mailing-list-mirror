Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793126192;
	b=BrS6UnBW1VazHfDcV5iTzn0/JV9IFHYAkQ0NIobULawvryQvX2K6izn9rp/jCNfg/LAD
	 I2xoSa+0z0JLakknAPj0FSCzIo0lCNHioXnshhpNMR+B/T3b1sk+ZTXkJhIYcWOreAVyt
	 DQ5A8n8LZ2pDpcOJcwAxLJJdgRRAIzpPfV+uuEdOg65GbE32tnmRRBADoVc9qAbKPSH26
	 OhhKOrc2b4yHqzmj/c9aVK2iglLW8eP+BVTSRo91qUZ8eEjzVW00biCeZoXtOoI4iFgNm
	 YcPU8ogH0QtJ5p+Hu/9AsoUWfZgBVRfpI9btgiEpvhh4GP4Y/+ITnlLaZUiCAgBo1xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793126192;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WEUwtX4ZVt6wuKB9+T2sbkHWTvk2qOa3WXHUaKlqScc=;
	b=ikkH4CpltdaJDQYzPeP1WY+wKDox4EgCvnCk+ueL2hIuDqHeawmcTmQXaEyN7Go2SWEi
	 ycgi7wwr+jY+VpJP6FdpDTA9bIgo1/TeNjQMXZP7XaPoAy0l48OBdy7Iv+7xSwbZCUJi+
	 OTsKdHse6T87BNlMcd5fR3sedU4Ltglx2NIj6gEbiIYAJqHJdb+A5TVWT5fBqE19hac4K
	 OU0LwMHsG99JRv/pugdHJvPyb6gEg1h0ZisPsmBuj9B3OnZ5fbHdPXfrANsOJc7DPvk7Z
	 +Zz4XN5+A590fkfORU8Nmr1nYBOd576Y7QmUaBxKJNpplrh2/aAO2YgAxojcY/rxueg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Za/b9uR6";
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E15C606A31D
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 18:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E15C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Za/b9uR6
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so1603905e9.2
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 11:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793126190; x=1793730990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WEUwtX4ZVt6wuKB9+T2sbkHWTvk2qOa3WXHUaKlqScc=;
        b=Za/b9uR6PGbNl3XP/HiagbmdAJBYySsjTPVxCUqpQAKhMTTafrMrrhFE1xf0xd5jFS
         7E0w0A8Tcs3x9GNAfXYNGsQVXMNtUhHZxSdosZ5RapjvjkSSo+3srf9qrpKTHdcg0tFM
         iZnnDCi9bJ/GL6/WavGAIyrZ95aMIaJtglAe464yIC3bp6xYnQL97rhCXQuc6ja199QH
         j4NiEwzVAhSotGcGwDJwt6DCaW1WL2x65b2132c6PKLOxxNWtsd7HsB0pwWUXyn6kHVj
         rhag8TT6SLiZ3g5guEblQlq+CEAPrPh9NLSzVxekkz+Bo+x+DqOkNTgREix/VNu6kDYH
         eh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793126190; x=1793730990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WEUwtX4ZVt6wuKB9+T2sbkHWTvk2qOa3WXHUaKlqScc=;
        b=20gc38DKMwD8rV91R5XGXtVNsOPm5J6+aWIB/YrUQ8vLM8or2/qtcyXT/f8x5SZUrJ
         z+pUU3FYq2QranmE36l3Hgh+j5+GpImIdxgK+CuWsE+0yggxyXTCGbwIf4/sNdwYAkBp
         qEYVd+CM5b1dxZEJJTUGT6NGOi0ni7bA+67r733shTz2kO/hU2q6NSXknqG5ylCc9Uf9
         RG8f/vTlL5VRpbv2l8jhXtObEnWcOFHEEturJ6YGa9QYW7srMv4vAN2aLxKIuB+G3J+c
         IGrbW4pnAhmG70vtlW+PP69SFDBBLet4HDk9WdACDIxISiuqjl2RMZDpBy57WE4CWa8d
         KNlA==
X-Gm-Message-State: AFq9FYLNak4EejdtyKzworqEhdz/1CAAfuPABLLWVxzSjLTxJvqunFaw
	Dqfyiz2WcP8/ZVlA4kGO92I5CDk4DjLczB+YLEylWOiO68KnaUI063+o5Z6S6Tq7
X-Gm-Gg: AYBFou1rMcXRlx5sXs7TGedrr1OrMzBk87WV5S83I3aRsg70Ln3uTR1rkebmUR61iIw
	nE5TTl5753qsHZjwYBJ1oXrqp7gaFMz4sVH2AAnyVnf06dKK9MoPFVI60bamZyEaRTVEmgaEn05
	XUcGsprGW4z+EF64uPzp42pEJZVDpkjyBmtefhFAtcURBvshAo5m5RC2fPjEK6ULrU+gSZAT01z
	J26ogeYCEKrBS+LhacVy4AsMYZeaOM8yG/s0MIpUMwewuY4pXcWEuFnhZmMCMf884iqd3RoXBw2
	qdVB/WMG/uvf2eg41k5su8SkL/RGH2JQt3ixDuTT4vMHzBfFTBHsO9MPWnT/baUpVNOEkEqVWK8
	k1XD4M/yl/NqQD+FhAfAdyWrTj2Gij0N31kXDnzI1O3VpYQoR73gAMRgQHL2rop4NWa73BpTXcZ
	QmAhGQuBREfVf75cKu9BwrhuDHe5mrjrlew8CPGgzKiVasq1hftjZQVPUbNhH6ZGE3Kl6SzQhWo
	MOF/n7TQCaSFNRwL/iOu1tcMq3CHl2lb3V0yBqo6ghPQnM6gps67hW7BiaUMP0YGpBybfQeMwgG
	K/di
X-Received: by 2002:a05:600c:4f8f:b0:4a1:e225:b122 with SMTP id 5b1f17b1804b1-4a35ac98b1fmr211107665e9.14.1793126190236;
        Tue, 27 Oct 2026 11:36:30 -0700 (PDT)
Received: from debian ([102.89.75.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a94e3c638csm455905e9.8.2026.10.27.11.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 11:36:29 -0700 (PDT)
From: Ogundipe Sola Taiwo <ogundipesolataiwo12@gmail.com>
To: git@vger.kernel.org
Cc: Ogundipe Sola Taiwo <ogundipesolataiwo12@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>
Subject: [PATCH v2] t5300: modernize test path checks in t5300
Date: Tue, 27 Oct 2026 14:36:20 -0400
Message-ID: <20261027183623.3600-1-ogundipesolataiwo12@gmail.com>
X-Mailer: git-send-email 2.56.0.116.g6de20f6092.dirty
In-Reply-To: <20261023154851.7876-1-ogundipesolataiwo12@gmail.com>
References: <20261023154851.7876-1-ogundipesolataiwo12@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improves test t5300-pack-object by converting old-style
path checks to use the `test_path_is_file` helper function.

Signed-off-by: Ogundipe Sola Taiwo <ogundipesolataiwo12@gmail.com>
---
Changes in v2:
- Rephrase patch summary to remove redundant wording

 t/t5300-pack-object.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index aac139e6a0..e5ce478484 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -283,11 +283,11 @@ test_expect_success 'survive missing objects/pack directory' '
 		GOP=.git/objects/pack &&
 		rm -fr $GOP &&
 		git index-pack --stdin --keep=test <../test-3-${packname_3}.pack &&
-		test -f $GOP/pack-${packname_3}.pack &&
+		test_path_is_file $GOP/pack-${packname_3}.pack &&
 		cmp $GOP/pack-${packname_3}.pack ../test-3-${packname_3}.pack &&
-		test -f $GOP/pack-${packname_3}.idx &&
+		test_path_is_file $GOP/pack-${packname_3}.idx &&
 		cmp $GOP/pack-${packname_3}.idx ../test-3-${packname_3}.idx &&
-		test -f $GOP/pack-${packname_3}.keep
+		test_path_is_file $GOP/pack-${packname_3}.keep
 	)
 '

@@ -376,7 +376,7 @@ test_expect_success 'build pack index for an existing pack' '
 	rm -f test-4.keep &&
 	git index-pack --keep=why test-4.pack &&
 	cmp test-1-${packname_1}.idx test-4.idx &&
-	test -f test-4.keep &&
+	test_path_is_file test-4.keep &&

 	:
 '
@@ -616,7 +616,7 @@ test_expect_success 'setup: fake a SHA1 hash collision' '
 		cd corrupt &&
 		long_a=$(git hash-object -w ../a | sed -e "s!^..!&/!") &&
 		long_b=$(git hash-object -w ../b | sed -e "s!^..!&/!") &&
-		test -f	.git/objects/$long_b &&
+		test_path_is_file .git/objects/$long_b &&
 		cp -f	.git/objects/$long_a \
 			.git/objects/$long_b
 	)

Range-diff against v1:
1:  ca6cd5870e = 1:  ca6cd5870e t5300: modernize test path checks in t5300
--
2.56.0.116.g6de20f6092.dirty

