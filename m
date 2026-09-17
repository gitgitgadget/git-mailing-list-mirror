Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01E64E4C50
	for <git@vger.kernel.org>; Thu, 17 Sep 2026 17:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789667572; cv=none; b=vFWPIClSQ9aUQUHeVsGwCh3aER54I0qlcEQXuD1KaOl2QT5CQh4v4UrL1pcjA22cC3awg9QkY+ao2WzQfY2BEX606vhs0DEDT39rj47Zs7pZq/ARj2G0d2mkFTeakCw5kcY1F9l9qvTgKECBpEhQOt4jZgnWzf8JIKGjRDfiw3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789667572; c=relaxed/simple;
	bh=IjlqQnKT9q9IBZpIznfaSrEEAnjGJHkuGWzkhdM2zLI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DO9i/A5v6boVpQbdzDFzZwTJ9OR7ZksdlJoV74JnMt8F0u8AGKKJEXsPvXDPOWdSMRSxQcSjSCtYl4H3fE/bYpDaHfQgbr8AFslHKqVX3s8rKYP7qJqEPoijxd0QvLHomaXfTjg/MevoS1cR0GQHrpwJMn1WFA0JpvPUpNJ503k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HsWWTvrF; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsWWTvrF"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1ceb47d55so215082a12.1
        for <git@vger.kernel.org>; Thu, 17 Sep 2026 10:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789667570; x=1790272370; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=doKbbj6lnaGG4v7IJBFHmF1eAnuBlVQtWAlCMe/7l7A=;
        b=HsWWTvrFK72NUxiykuJqV3SwkL+54DZCN/0syXae/n9psTwOu3o7o6GDcVGN+o67Sj
         Xp8W9/BnxXAT9ZyZhpDVKuxPF0iAjt/SoXG7+hHy+ZSPY8gYRvlM19CNPLdw1g3hO2so
         YNU1jI1joove7L8S+fRqjqkEOeCUm3EKpgjlu2J1Z48Qt0zqip7eDRNkvrH7zHFsDe5h
         Wg3ir3UOVpbv5ODGa5PV2YA9OvYiB/tNRn2jjy/N4vsckNwA5UTKJ0Fwp3FuQWhFnNyc
         X7nYAqT6/5MPnQx3bxzmeCt5cUEZbsRMDaXPxTEI0o6O4NAY412BvwWssyr/cF2auJhN
         Qh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789667570; x=1790272370;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=doKbbj6lnaGG4v7IJBFHmF1eAnuBlVQtWAlCMe/7l7A=;
        b=i7OVmRGnEGOD3EVUlyKI/n3QSfYKz4VzmW74Ips4zTPbWyplyEeTPbB8NGAzAJlHS0
         a02enE+ybK8TXwhPnB1Bv4H4jkRniG0e6kkXW55lklvfaQDN6JLXpYwiwIqeuS+5rLnv
         6LwYyR7FLvOsVe7YDm6vL9BrmeELKBiGaxqkkMYVqlR36KvxEEHhQuCO8yUVcfaMTSj+
         PpacMt8DIifj8b3puSEc41qbr/bpWi/c804npsJcRRrF55WZ1k2s37kn51xFjMDXeE3u
         akHYeNYvsev4Ulpu53dBlX2njrtuqqr4klmDPt0xderMy/aKUa3yJVrjjr814iOKV8rf
         wwYA==
X-Gm-Message-State: AFuF++kT8GagxmaCaKujkrGww8Krml67GD23wPkKfDD4IJmP1lX9nYlX
	g+yRIhbK2eF007S2yqn9JHVkstaijL4oDUn9P2JXTgQFxjGGMCapdAOa4yYf0g==
X-Gm-Gg: AYBFou2CImTHhzz2L3D+3ojCKN1gj/lz1XHs/4LW4kghlh8uJILhE4OzA3EpzIApxUL
	ZY+Gk2EG8udYcwFMbrsBVUyk4sRc8+i89FypPTHfObTYLp1puRAx21EXWFdEGF9g6EuWkcTa9/T
	+Hkax8Q08ppy8t1GRTMVaATX2HkNcOrpu4qt6h6sHatzT4TlPSgnf7QqH/6Pdn3+39uBHBLBmDA
	65d8q3Q4AjSzohVnki4mlm8lZr7rBrzk3MTzBre6DO1kDr8mYC+JypLU5XdjcFlxufyD2sOqzmH
	MRXEW/JeJFhPRsULokjR/OO71kdPvpLL8PgTM3qelhyLH5TYmnxWLWAKSetqDhv8972Qbn0ZrpZ
	tzC2cui8S7c/ukP6low8Qaa46bmYpis5YFUOgBEDXnt51k87k8ag5i2S16phVw2mk7xFdeuiK7e
	vCWVYHL12KlCm8VsPVDjrdCItiQI9ROcsrYGwF6tFD32FBTDEQ1+5ifsqXyXxN/0yOcyW1z+Yk
X-Received: by 2002:a17:90b:3881:b0:395:8124:ac53 with SMTP id 98e67ed59e1d1-39e35f71c5bmr4855749a91.6.1789667569908;
        Thu, 17 Sep 2026 10:52:49 -0700 (PDT)
Received: from [127.0.0.1] ([52.157.33.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e3c06423esm5188125a91.15.2026.09.17.10.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 10:52:48 -0700 (PDT)
Message-Id: <de28e72d5f5e3fe59666919510242daf82845337.1789667556.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2231.git.1789667556.gitgitgadget@gmail.com>
References: <pull.2231.git.1789667556.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 17 Sep 2026 17:52:35 +0000
Subject: [PATCH 6/7] oss-fuzz: handle reftable iterator initialization
 failures
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The reftable fuzzer introduced by adf45165e65b (oss-fuzz: add fuzzer for
parsing reftables, 2026-07-03) ignored failures from
`reftable_table_init_ref_iterator()` and
`reftable_table_init_log_iterator()`. Coverity reported that under
allocation failure, either constructor can return
`REFTABLE_OUT_OF_MEMORY_ERROR` without installing an ops table, allowing
a subsequent seek to dereference NULL.

Treat iterator initialization failure as a reason to skip the
corresponding seek and iteration while retaining safe destruction for an
uninitialized iterator.

Assisted-by: GPT-5.6 Luna
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 oss-fuzz/fuzz-reftable.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/oss-fuzz/fuzz-reftable.c b/oss-fuzz/fuzz-reftable.c
index c46eac2c6b..75b8ad0c3d 100644
--- a/oss-fuzz/fuzz-reftable.c
+++ b/oss-fuzz/fuzz-reftable.c
@@ -33,10 +33,11 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 		struct reftable_ref_record ref = { 0 };
 		struct reftable_iterator it = { 0 };
 
-		reftable_table_init_ref_iterator(table, &it);
-		if (!reftable_iterator_seek_ref(&it, ""))
-			while (!reftable_iterator_next_ref(&it, &ref))
-				;
+		if (!reftable_table_init_ref_iterator(table, &it)) {
+			if (!reftable_iterator_seek_ref(&it, ""))
+				while (!reftable_iterator_next_ref(&it, &ref))
+					;
+		}
 
 		reftable_ref_record_release(&ref);
 		reftable_iterator_destroy(&it);
@@ -46,10 +47,11 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 		struct reftable_log_record log = { 0 };
 		struct reftable_iterator it = { 0 };
 
-		reftable_table_init_log_iterator(table, &it);
-		if (!reftable_iterator_seek_log(&it, ""))
-			while (!reftable_iterator_next_log(&it, &log))
-				;
+		if (!reftable_table_init_log_iterator(table, &it)) {
+			if (!reftable_iterator_seek_log(&it, ""))
+				while (!reftable_iterator_next_log(&it, &log))
+					;
+		}
 
 		reftable_log_record_release(&log);
 		reftable_iterator_destroy(&it);
-- 
gitgitgadget

