Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C24B823DD
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 00:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775435125; cv=none; b=JF3fe4UwMtS5eyd/Hsq/daVACMcmA0Bnmg+Xi2x8ITaaQWrznLNr7u5tIDD0PGMiu6Nonilxu29A5c0IVgkU6wIQAX2uL80B0hk8J7zMFx0xV6MvYIff4gq+k7qPEEP9J3TBIMkRZra05xzQ9OcMNoFLnH0WYieZgA+9A60t4FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775435125; c=relaxed/simple;
	bh=re6m+rXQISYijsgyaIxEHUvPjrUcszI7rVhgi62k14o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4Vpnia2phGevf3HvVNSratwwNQSJ+oWfyG5RgyquCXAfMEJLEbeIghEYxUGesXggjAlR2tJTKwjhUiRKmUAYEpnfxitLZv3fAsKRKM1bMLNimvNLseY1jVQD2Q3whJvWfHHr+JvF6G97dbxL02MJUHmhP9Jxa4Y0PvVQI9NMug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+IqPhwt; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+IqPhwt"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d02a71526so2010685f8f.3
        for <git@vger.kernel.org>; Sun, 05 Apr 2026 17:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775435122; x=1776039922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a+XC24Yj4agLNJq3PWfwGat85r2AIivXFUhENTxvQsg=;
        b=Y+IqPhwt7OCOKQhH7qFG47tUuw+1+0IR9ebS0BHFfrG3O2blGc6tYCGOUHUBfnXH8z
         Om+e3oo5ovlYt8NKyQGDLQkzxCRZe8ZXL0LH6nYmVJiSX2wcvasUoQxvhj3Y2q5HoPj4
         M9tLMb0c7IA92fXZIAerWaxYGXdV8RF+9d/oXARQrYBvK9S+hXKWI1DOvN6zWeZINib8
         01IeCi3G8fuc2MwRVH7mZH8vfvAyj/n8IRkUSrF8if93i9hTW/CSflwJJ6z4kdssSFjz
         ztOQ4gtzTsuNZXvfuTTHa6pkzTobPo08lKWesPLg9e9zcUorBm/A969AZRAW2+RgU126
         GL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775435122; x=1776039922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+XC24Yj4agLNJq3PWfwGat85r2AIivXFUhENTxvQsg=;
        b=mixbnNEkv1V5VbsxjyvdiQohy0bLm8QlwFY9HundTrZ6IwVZLXPC2Qd9cBzNfOA7mN
         dZZreHUGaCiXTIm2Dk8E1xO6vENmS3aSuDJeDeWQxq3HwkHk8h/OIX2zGMgpqYjsydYK
         VqdfEPOrNx8ux3zYGwg1ZR1Nkln2WlauzEbxQCyV5qlYAPjU6UntCpu0MEA8AWUz8tgq
         alFaqd7magOYjEP/5UDiciy+R/FYYDB0dup13FquytlF+83nIvOQSWoz5VQRxcmeuU7m
         0Q7gZCvIIbYy9ubzMogmPEFZU1pGDnrnxydBjfRrZjwdGkLPZet/sIWTYy7iUsQe9mkl
         TA8g==
X-Gm-Message-State: AOJu0YwXrO1z/yg0YMl9bgWRyaL6R3fZGmZrqoROQmq/FlJ08Twmee0y
	meUm8oQ5twe5r9NGR1LpL++JN16tGt3gB00G8P36hiidB44mruTreK26bLzAkPpuuZQ=
X-Gm-Gg: AeBDieuSmEcaWzVkkyFtsLc+O/kRDPesyM+sPc77ADrzbfU/hyfFkQwaEeSzRl/mKrh
	VhYrq+msefoDzAeH/TysnHmlw0OxwxQCIlFeU9x0CWs0Yi9/dt1TFspAiZ3qq/LvCQHbvPeA45I
	kF7Q6ymVPvgUolSulRdpWycoqZlyyCcEsm2RDh92Hum3/Xw/ccJo1rwripr31NoUsjbwgbz5drV
	0lLNv2xsbqEBpdizjF0iM5PKmhxjd2EAAFGLMumeQZyxmX6jpbJ06QzTiTZIKi29cBV5CxxBwTD
	45pbYl1fO7S0pns+ckMmIFpHUPAT9Uea4ew4K3TV4NxG5XFJK6VF5cUMK5A5KvbDQ6ToDqsjA3a
	hegYFdl8XzukfzguG/tiNt/EkWPWBfushcJOPE9Lf07wGoLoe9iLfbqZH2mmF/nBvOt7dPhWfPL
	XylFrIgojdM3aMZFwbZwdcmJI+6Brki8GD
X-Received: by 2002:a05:6000:1a8d:b0:43c:f793:f1b0 with SMTP id ffacd0b85a97d-43d292ff470mr15167747f8f.40.1775435122497;
        Sun, 05 Apr 2026 17:25:22 -0700 (PDT)
Received: from lorenzo-VM ([84.33.160.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e1fe0b0sm36474414f8f.0.2026.04.05.17.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 17:25:22 -0700 (PDT)
Date: Mon, 6 Apr 2026 02:25:19 +0200
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC PATCH v3 4/5] t7700: test for promisor file content after
 repack
Message-ID: <8e58c1263d15fb8dba8ce1d2866d369e938bf2b6.1775431990.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1774205661.git.lorenzo.pegorari2002@gmail.com>
 <cover.1775431990.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1775431990.git.lorenzo.pegorari2002@gmail.com>

Add tests that checks if the content of ".promisor" files are correctly
copied inside the ".promisor" files created by a repack.

Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 t/t7700-repack.sh | 63 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 63ef63fc50..89a2116641 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -904,4 +904,67 @@ test_expect_success 'pending objects are repacked appropriately' '
 	)
 '
 
+test_expect_success 'check one .promisor file content after repack' '
+	test_when_finished rm -rf prom_test &&
+	git init prom_test &&
+	path=prom_test/.git/objects/pack &&
+
+	(
+		test_commit_bulk -C prom_test --start=1 1 &&
+		
+		# Simulate .promisor file by creating it manually
+		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&
+		oid=$(git -C prom_test rev-parse HEAD) &&
+		echo "$oid ref" >$prom &&
+
+		# Save the current .promisor content, repack, and check if correct
+		prom_before_repack=$(cat $prom) &&
+		git -C prom_test repack -a -d &&
+		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&
+		# $prom should contain "$prom_before_repack <date>"
+		test_grep "$prom_before_repack " $prom &&
+
+		# Save the current .promisor content, repack, and check if correct
+		cat $prom >prom_before_repack &&
+		git -C prom_test repack -a -d &&
+		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&
+		# $prom should be exactly the same as prom_before_repack
+		test_cmp prom_before_repack $prom
+	)
+'
+
+test_expect_success 'check multiple .promisor file content after repack' '
+	test_when_finished rm -rf prom_test &&
+	git init prom_test &&
+	path=prom_test/.git/objects/pack &&
+
+	(
+		# Create 2 packs and simulate .promisor files by creating them manually
+		test_commit_bulk -C prom_test --start=1 1 &&
+		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&
+		oid=$(git -C prom_test rev-parse HEAD) &&
+		echo "$oid ref" >$prom &&
+		prom_before_repack1=$(cat $prom) &&
+		test_commit_bulk -C prom_test --start=1 1 &&
+		prom=$(ls -t $path/*.pack | head -n 1 | sed "s/\.pack/.promisor/") &&
+		oid=$(git -C prom_test rev-parse HEAD) &&
+		echo "$oid ref" >$prom &&
+		prom_before_repack2=$(cat $prom) &&
+
+		# Repack, and check if correct compared to previous saved .promisor content
+		git -C prom_test repack -a -d &&
+		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&
+		# $prom should contain "$prom_before_repack1 <date>" & "$prom_before_repack2 <date>"
+		test_grep "$prom_before_repack1 " $prom &&
+		test_grep "$prom_before_repack2 " $prom &&
+
+		# Save the current .promisor content, repack, and check if correct
+		cat $prom >prom_before_repack &&
+		git -C prom_test repack -a -d &&
+		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&
+		# $prom should be exactly the same as prom_before_repack
+		test_cmp prom_before_repack $prom
+	)
+'
+
 test_done
-- 
2.53.0.585.g1533fa96a8

