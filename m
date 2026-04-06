Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13BA390CB7
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 17:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775498104; cv=none; b=IkeND3dtMlDT1uwYem5RuWKgdHN1vmDza2FrbDnvM4SDk4GewU2G0l335NuwhsUYz1jrXX673aAugUmv7kRl5spODEUT4rM4FEGAo3qetKe1X0ZHO8IRBQ9hOXZUSCO0bDcnpcuUVuKiWqpJaAJ1Y3S2N1MF1I97vDmHrAB28I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775498104; c=relaxed/simple;
	bh=yGPDGYA+aETZGTlz8YhNuSgwBMHP6+EAN6O7tnZN/9g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tEbHha4bVPVJHB1cxuPaG5eh3DAoDgT8/s9bkUqqvkejSxAplchhw96hs9zdFXDBOQcMDX1Nqhpik8a+8glOlOYhx+3XEbsIvceN9r/VEA4xKqkcSuF47v+ygXOq/axPCItpry5OcsnSutDoBu6Uxrnu3bb6ir+hnzFUlMwdqrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxArSVfr; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxArSVfr"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1279eced0b9so4702550c88.0
        for <git@vger.kernel.org>; Mon, 06 Apr 2026 10:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775498101; x=1776102901; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q1PhL24B8f/cr98SZ2Vz5OYarB1c60hf5Un3FDLfjnc=;
        b=GxArSVfrk8fWD7w4XDSPb5q06L8wCfIsJIeejwcWqd+Dg6kv3BL7TTkscC1anji+di
         6dbiRnYSzxhXGEDLoFlABlxT/5UIOUzlH3l/Md3g3I4O0WxcaNVAbvwS4YBivj7O1yj8
         GCJIT2w4THnrTYXOciNuipV2+mBEnjiq0j9hEpKpjKE6tYG0Qje19WIRQEMs5HEUN4Cv
         FMgBX9jY2Z3Ww3ZplOO7AWwcv7WzI0JRmSV0wxYXAs56sHzGbKJCoG3dAsU0V75F5o7y
         LS0E2EpCOTOzHOoUDSlhpjh75j1sc66jstElO3ZpLhAaXS0ga3e3oYxUK4/23pmIaJme
         AefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775498101; x=1776102901;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q1PhL24B8f/cr98SZ2Vz5OYarB1c60hf5Un3FDLfjnc=;
        b=mTXja7nnNrBC4Gs2ooda+NcyMPWo96pRPPTkTlQcvIxsjiIQrCXLiXJmPNvMMcgLoe
         lKA+p0tGK3kE9NNlTNbyi58xd7+ihGUjGchoAyLqNS/je5e+JfCqGBJ97GisE4dplYkb
         pN1JCi0fQu/fxGJAYPpITbLRuZr8JNOmas8i19usOsZ1N33WmqX+2TsC87cYRPHr+PJi
         j8wuZ1gXfsxi6rzup5U/EtVTQ034+k4ICFW54Nacj+t5c1JLKcxSKIRabF7ilQm0/d77
         8yzZHPCg5lGy8YqssST4vqBj6oyJbd2qfO5pwPmxrpDem8dB6sEQPOcKYaYkLEqPeJmr
         +TUQ==
X-Gm-Message-State: AOJu0Yy9zoQvckpD62proLaHE6c8dZ7v4WTWYyHpw7s6+bDGNFBK0/L9
	PZsNMhskmArjnujtdMIMl6Vr4tKLERp5Qex/x6n1RWlt3ldW5gIReHeLvwMU8A==
X-Gm-Gg: AeBDieuR4eVHLwitkm2/D3AypwAGa766n/U+r033agyvTDBtYJpJCTT8k2KtEu945KP
	Gug9AYHAJY+Ek2Mb7yagRfXhifAREUt8EffHghCAd1tOmbVtf554BoybBNN3i+U/9g/IaXnFebw
	/MpA82CsqbXod2xylUcALmITjP/UgehxM4M2Os/+aBxm7UhoQ0Xg/2wszuxRHGzcmofJprkH2pZ
	refxpOlOh+wl60+CJjkJc5LAmoBpt6ScIvHLBSBF3no5tONXwYyRCMIEzIYFcdDGz1X5r1bSMyA
	9lOXcRW0B3Sjb7Qy15jGgVOOj11TVts2jys/pc7mfgbOfflK60faAnONs81ZH/bUwuR8iTTc7KA
	icm8wVLeydkAeVkcwZcwFaO5I/YfUwGOeuC75fvEHb77PIDrl9Q8L/WWthnpJfYEIXaJYo4DUN1
	gWFAio/S3H9tg+4LwYntBEBrj6jnI=
X-Received: by 2002:a05:7022:90e:b0:12a:8ea4:252 with SMTP id a92af1059eb24-12bfb6e7a31mr5662335c88.4.1775498101113;
        Mon, 06 Apr 2026 10:55:01 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.242])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bf90973b6sm12661603c88.9.2026.04.06.10.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 10:55:00 -0700 (PDT)
Message-Id: <28c5aca413dc0966df62a3d04f8ed76bdd9a5bf1.1775498098.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v13.git.git.1775498098.gitgitgadget@gmail.com>
References: <pull.2147.v12.git.git.1774937958.gitgitgadget@gmail.com>
	<pull.2147.v13.git.git.1775498098.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Apr 2026 17:54:46 +0000
Subject: [PATCH v13 01/13] t9210: disable GIT_TEST_SPLIT_INDEX for scalar
 clone tests
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Paul Tarjan <paul@paultarjan.com>,
    Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

index.skipHash (Scalar default) and split-index are incompatible:
the shared index gets a null OID when skipHash skips computing the
hash, and the null OID causes the shared index to not be loaded on
re-read.  This triggers a BUG assertion in fsmonitor when the
fsmonitor_dirty bitmap references more entries than the (now empty)
index has.

Disable GIT_TEST_SPLIT_INDEX in the scalar clone tests that hit
this, matching the existing workaround in test 16.

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 t/t9210-scalar.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
index 009437a5f3..f2a6df77ce 100755
--- a/t/t9210-scalar.sh
+++ b/t/t9210-scalar.sh
@@ -152,6 +152,10 @@ test_expect_success 'set up repository to clone' '
 '
 
 test_expect_success 'scalar clone' '
+	# index.skipHash (Scalar default) and GIT_TEST_SPLIT_INDEX are
+	# incompatible: the shared index gets a null OID and fails to
+	# load on re-read.
+	sane_unset GIT_TEST_SPLIT_INDEX &&
 	second=$(git rev-parse --verify second:second.t) &&
 	scalar clone "file://$(pwd)" cloned --single-branch &&
 	(
@@ -182,6 +186,7 @@ test_expect_success 'scalar clone' '
 '
 
 test_expect_success 'scalar clone --no-... opts' '
+	sane_unset GIT_TEST_SPLIT_INDEX &&
 	# Note: redirect stderr always to avoid having a verbose test
 	# run result in a difference in the --[no-]progress option.
 	GIT_TRACE2_EVENT="$(pwd)/no-opt-trace" scalar clone \
@@ -307,6 +312,7 @@ test_expect_success '`scalar [...] <dir>` errors out when dir is missing' '
 
 SQ="'"
 test_expect_success UNZIP 'scalar diagnose' '
+	sane_unset GIT_TEST_SPLIT_INDEX &&
 	scalar clone "file://$(pwd)" cloned --single-branch &&
 	git repack &&
 	echo "$(pwd)/.git/objects/" >>cloned/src/.git/objects/info/alternates &&
-- 
gitgitgadget

