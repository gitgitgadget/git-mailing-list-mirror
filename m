Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792732391;
	b=yS9/QhG35m+dUAgzDiLuiQF5U0i608ITTc+6eHUkX4CzoxG/dmRC8oKluHVDYIzAfJyq
	 kKjOpEnp89N4ozPqZdqDB5ykqbXxBe6EAq8FjC9zvCcsqR7wG54nSqMIKjs+Tzyhn8LxP
	 2tbzGawg/e1PoCZUpUWGkXgNFst7g5H8ekhKag+EDplCqV2i8/+dqoq07IOcIRzcXtvWt
	 uTNkU+3ZH6qWoLBoAVZy2N/BECP8+QLrncO+AqzYmttpxBdCcJzqlPVgLJeo6UFdMJ03q
	 g/4KnpMRFtBUpm1eDP8ueWDn1F69omNI0fbnYbs5Cbo/7b62buxKBF8CBcHdiwKIOZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792732391;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=3rxJ6ryxqVP3WGDJJxXRtjRlCaVAhVrBLd2a6IcoHx8=;
	b=p21tZVr1mQCdQhGPmwn5B6Yq56SmQyxJZiq7KuzV47ssvzFbGejTUnzzQIjPZwLb0+TA
	 Rbhud+m/27UglD1XP/qeLD3zJLz5iyPAd5MqGllctHQPkmDBE07HRU9tIMf2rtZWGU7oa
	 o34ky2L4BhqWlepwiOLl2KVAWKFbkpiNLFJN8YDwK87osSYSJba+Ztscm0fOhbE1sw8Fb
	 zeKQlIfLGCHM8H+NaTuzoNlH7mvGVZJCrG1HbHh9tLrVtBnPugoRXleV2OFT0JHAUtdPG
	 u7y4bUMSpVQIsazjBwHu5HK8E433UIIKyVfFuRSzvcegUmaPRCtGwksWjPOQoTbNw5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gcKYSqbi;
	arc=none smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57B7606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 05:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C57B7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gcKYSqbi
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-53644ab1f7bso3671771cf.3
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 22:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792732390; x=1793337190; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3rxJ6ryxqVP3WGDJJxXRtjRlCaVAhVrBLd2a6IcoHx8=;
        b=gcKYSqbi+YrQjHn+3oK+Ns66hCRkRaT4HvQqcCFLwRDOPWfgKPQqVMz7Mm9E3eCe9y
         g/EKIXMW/8Nvqy6MwFV5lj+6s+B42QKDPzRO6wje+hi6UHivAlSsr9L0uNBwe9VCQZ1Z
         KGekGJyI7ut5thxtUKgnJ5Gkx6kTBbVVOTdcG6BUj8I3J8FPkAluBFY9WuH+B5ZYDYtE
         Ln8WRq1OwOZdQoW3iupVGgVRLrUwM2q9/LAmkfY5CSfofdrAbEcyWBacemAv0ft/AH94
         jA+wEksF7yq0N/q4ptVFJJHsxdIStwmBbz7/JspIyym16sRRhcWM1NTlPUF+JiTZO3b3
         iyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792732390; x=1793337190;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3rxJ6ryxqVP3WGDJJxXRtjRlCaVAhVrBLd2a6IcoHx8=;
        b=J3lM2mx+d4Dha9aZKsf95/PV3J/c9SuXps0bWxcMdNdi+77QckuNEGeIgHyxfkuTG3
         RW/xd7MTrWSxe1C8CGMyUjqRBGgHc9rrDgQQtI4QGJFHolTkMBnL9PbbmnQ8MwTpjdEL
         ygcZf47ZDF71jLy+yUBRehXCaHEXb9tvCSnw0cSWrAAhd4UlA9cDLFloGHIqbWHL6L4I
         qRpXJOziKDva7SIP0ECZK9gBQeH5KmStcN5ocpfYwbr6O+j42YlcF9Bd22c8W1RDTRkS
         1OUYAD2wgGRd2QIxZtEh2q9TNO5Mz3mvl9eokhLohHibu143rg+3KIzKc50tmamfuzY1
         k2jg==
X-Gm-Message-State: AFq9FYJ5kMbpAgcWKT6kxMXyyWOzW9cxvsN9pHzOWDtia4uCPHQLpC15
	iV2ckmuZmAQjhUJRhRC58UhJ5ccagNKr/aE53vc9pn+/nP/sDv0h5b65qrF8DGVH
X-Gm-Gg: AYBFou3jYYRG31e4sTqxm0S5ZPd4Eoiism5HktRYS3ooNTqfPMIiKxEmH6EtSj6qxoQ
	un0a0Wzfmdh2336TBYmxk1JJiEMPcdwo4IzcGFACTC5L4SChrgGJpHM2SlIN4RQERO8BwDY8smk
	MvqjuEuzS+8AzzsiaKwLDgEk6nPU+Ibd9p6aReg74syG6TG+Y9LeFO6mBGcZRFlKogL/Jm9sXlb
	Tkqfu3AnGwt/i3FVbyCxTrDp5no1pCP7jcnKN96Gm12uYBG0CpPbsNyeOhI77YI90F4+22DzXlj
	KlHq2oVxJ+4d9eBxQA592tx801QKGAfI3+dduOZwdnhIOWpKHVjI3H3X3srGK6+x50ipldiToEg
	dK1aE1Xkv9/nF39xvcSDGjEz80+T+N0OxG4WPi39moQWZvvjb8RdtvkD6ZwbCC46gxhs+uGIowG
	Epysb35rnR+KswvaMl80LogeWzFcxgbFJhAdaX6ig5/6/bTtTwKBVTGL36OtnQoJSuR1IBww1QT
	wPIaakB50Y0g/wskJ0d9nvfc/SWzMIy7eYBi7+IsFWREgiwsrwzdjyePDLoEQ==
X-Received: by 2002:a05:622a:a58c:b0:536:51d2:1e44 with SMTP id d75a77b69052e-536c2805090mr15157721cf.22.1792732389698;
        Thu, 22 Oct 2026 22:13:09 -0700 (PDT)
Received: from [127.0.0.1] ([145.132.102.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536c167dc29sm9399341cf.3.2026.10.22.22.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 22:13:09 -0700 (PDT)
Message-Id: <pull.2260.v3.git.1792732388827.gitgitgadget@gmail.com>
In-Reply-To: <pull.2260.git.1792299301663.gitgitgadget@gmail.com>
References: <pull.2260.git.1792299301663.gitgitgadget@gmail.com>
From: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Oct 2026 05:13:08 +0000
Subject: [PATCH v3] [Outreachy PATCH] t0001: avoid pipes in test scripts
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Srujith A Poojary <poojarysrujith@gmail.com>,
    Srujith Poojary <poojarysrujith@gmail.com>

From: Srujith Poojary <poojarysrujith@gmail.com>

Avoid piping output from git version directly into sed to ensure

that any command failure is properly caught by test scripts.

Signed-off-by: Srujith Poojary <poojarysrujith@gmail.com>
---
    [Outreachy PATCH] t0001: avoid pipes in test scripts

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2260%2Fpoojarysrujith%2Fmicroproject-init-pipe-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2260/poojarysrujith/microproject-init-pipe-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2260

Range-diff vs v2:

 1:  7d118290ce ! 1:  a70ccdf49e [Outreachy PATCH] t0001: avoid pipes in test scripts
     @@ t/t0001-init.sh: test_expect_success 'default ref format' '
       	) &&
      -	git version --build-options | sed -ne "s/^default-ref-storage-format: //p" >expect &&
      +	git version --build-options >build-options &&
     -+		sed -ne "s/^default-ref-storage-format: //p" build-options >expect &&
     ++	sed -ne "s/^default-ref-storage-format: //p" build-options >expect &&
       	git -C refformat rev-parse --show-ref-storage-format >actual &&
       	test_cmp expect actual
       '


 t/t0001-init.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index f1d227f271..c8c74f681b 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -678,7 +678,8 @@ test_expect_success 'default ref format' '
 		sane_unset GIT_DEFAULT_REF_STORAGE_FORMAT &&
 		git init refformat
 	) &&
-	git version --build-options | sed -ne "s/^default-ref-storage-format: //p" >expect &&
+	git version --build-options >build-options &&
+	sed -ne "s/^default-ref-storage-format: //p" build-options >expect &&
 	git -C refformat rev-parse --show-ref-storage-format >actual &&
 	test_cmp expect actual
 '

base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
-- 
gitgitgadget
