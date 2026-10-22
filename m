Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792666214;
	b=5WSTucImuZcj0MzcoyoJmr9RMZMKwPgJROUEbMLisPK5b+rzvEPSAwaVPaqST6d9R6aS
	 WsdME61FKs7znrBpYrUuQyG6etOLut7xZTVJNUnc9WbbdKgyOBflqJ3eeLdDigXpSHR4w
	 nthBsqgAmr0t+r90AE05cXhQY+4RSDNhLI65twkkkPBh7ACc/FPRMnLJg5hrL09jYbxRW
	 EWtjaU/4rCgw7M4yUClVh7xjER7Z1JMYs/+1JfwAI4/ARM2UHjWA3d1Xb5T0Mrs9xtolZ
	 NA3SysclkEp5uOjc+sHVWGg+H6ecjhvi/3j3LiRoBRNKynB8HXGj6MRhJzHDspzecpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792666214;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=E0cvP/R9LgajMzSQD9Mv1LoXL36v1LBc+RiguVaiv1Y=;
	b=DFP5NukbN/GQc/dm4gzqjxHprXx0NFixQPeJGVyT0M2LouD+/CRpsbEiM2isI+zUvC0c
	 GE5SYgN+4Q/3FrWgC3Jdy3bb3Q0W7HvFQvfLWRKM7K0tQzAHXgUi0rSrNaIxIw4Denn1C
	 241rNMqDmy5+vnnXOkQIeGVOGs+x8YxhEFC38BMQyulov0SUFD9dND6Yfjmwy36CcHGB3
	 oOJBEmcG6mxupiJe/YBITEt5w14UzFiDuh0zPdNMChlnhTA9EYDEJgOUjiojJUtLFwWje
	 r4Tp4hg0qhoEKdH1o29r3E4vPHEcXLxu6t77kZmUcIu6t+Hex4chCVeldSn3e/lK7Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="tAg/+yvq";
	arc=none smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB4A606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 10:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFB4A606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tAg/+yvq
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-53397554beaso18555681cf.3
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 03:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792666213; x=1793271013; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E0cvP/R9LgajMzSQD9Mv1LoXL36v1LBc+RiguVaiv1Y=;
        b=tAg/+yvqi12+8RXqfwXE0BK1vQGl0CqA33qk6mHxGhY1ZEygPfazI/pLiLk6I1Q51y
         Cc10pQazN4E+XmMwsUEr2UbHH9r0eV643ersH0KEeIAOqm81LIacVrcycJaNj9nwQ/sL
         DLCiYYP2aA6KxicrzlTypFS19vwXalnVGFT+Ahy7tEDVcGeqGf2XpNixQ9LE6rUlOdth
         Bck2dYtm1zedo1OVPkFyL/epQwlmUVMN+FBUJ4c383ksjgwczWZvM4ykwX++IVSl4BvF
         mADYqB0VpS2Ak1H6dEDt+Ns7R0c+PZvMTo9mIAenhk02rZjBKpTGHu7/oh06brm12L/f
         w6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792666213; x=1793271013;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E0cvP/R9LgajMzSQD9Mv1LoXL36v1LBc+RiguVaiv1Y=;
        b=BeW8SKwGSVOWz7+Eb3RLY2xiMn6hGoBoCIXmnTWmE0+2aDdqBrme9IoxI7fboBx7cV
         1AHsj7X6Wi++sY076u2MC74caHm0DtGrf7uQq/JaXYlbZmkxVvYLtsbJWoiAEleL4bkp
         lQIt/pF2JHatoSnbVnEhsHDrBlkXBjS/bciyz9lfotZWQ6bVy29624cNucEwCdO84rwu
         O7B097SG+5UC3bLB6Kz9Aqo2F2K6XQXUFFL28HIHQEJsMQrdGmcppcBl6mMF5rJ2WRDX
         vD5/TfyOxP8pWtcmIKNhFOpqH+nbNmGKcAj7kDRlbt+7Q+Hwc2sOJROvCygLIIztHbzU
         eATw==
X-Gm-Message-State: AFq9FYKniAc9fizPADb6rKoyqimY+nIAtdyTj82qOC8KiziMqQfvCbfI
	epMzGGnTlK+u+asDmAqUph1SFyG5jCo3B+mUcDUTu/OvRZvIU6TG8RblIzQvZg==
X-Gm-Gg: AYBFou3QPfYcFHsSkH3o7R2sg00Hx1nxoDJvt4A7ru/VXE2rXGUerU/ofF0tB31sDgF
	yOURHRKsU1Tc+SKJj73bXSf03Jt3m1qOWhu9RA9KshKSA3O+SkNbUdviLsVpy5u1uLjfH2NrFGk
	K5+3ndsNawOR+1SvVFOqF9eeu91rze+Q76n9q9rz9s7OP+n0GeS6fhX0Yi1yXIP5zkEPrRxwshb
	lPH3ABoDDAUASkxcheu08PcYtQGQgDk7muRAR7MTlduoGs+RT6pUiKmJQbsG5iz4kqUTNw5lVo7
	K9VZAV+81KxLSmQ8mMAeRqebgdozfM65O+I3r+EeCWKCl7C9kyMzFX0mOlyNPv74U4mwTAJNiBk
	3+NxQ7J0RWrFcDoyJFrlsvW2r0hSezEy3Sb3sM/rfCb7d9nfW+3wOLYsAamSR4vH584VE2QJpKm
	J1TLwsXw/am1aC77Ir1eU54Ern5xWvmcsB4vVOBUkzb0uBS2pU+ng0fW/I8PMkBzKttAAjUsU1y
	iiet2eeXm+lDbWiPdX2ebPjyrDIHEkg4RsLdalaGjb6V7edRa6LoomOUQwqeMTUgMMIWc4qfnVQ
	7RQUEg==
X-Received: by 2002:ac8:5f4b:0:b0:536:5a10:5c4c with SMTP id d75a77b69052e-5369b617a83mr75883521cf.13.1792666212718;
        Thu, 22 Oct 2026 03:50:12 -0700 (PDT)
Received: from [127.0.0.1] ([20.106.231.249])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10b736adsm46475806d6.7.2026.10.22.03.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 03:50:12 -0700 (PDT)
Message-Id: <pull.2260.v2.git.1792666211685.gitgitgadget@gmail.com>
In-Reply-To: <pull.2260.git.1792299301663.gitgitgadget@gmail.com>
References: <pull.2260.git.1792299301663.gitgitgadget@gmail.com>
From: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 22 Oct 2026 10:50:11 +0000
Subject: [PATCH v2] [Outreachy PATCH] t0001: avoid pipes in test scripts
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2260%2Fpoojarysrujith%2Fmicroproject-init-pipe-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2260/poojarysrujith/microproject-init-pipe-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2260

Range-diff vs v1:

 1:  92ecaec2cd ! 1:  7d118290ce [Outreachy PATCH] t0001: avoid pipes in test scripts
     @@ t/t0001-init.sh: test_expect_success 'default ref format' '
       		git init refformat
       	) &&
      -	git version --build-options | sed -ne "s/^default-ref-storage-format: //p" >expect &&
     -+	git version --build-options >build-options && sed -ne "s/^default-ref-storage-format: //p" build-options >expect &&
     ++	git version --build-options >build-options &&
     ++		sed -ne "s/^default-ref-storage-format: //p" build-options >expect &&
       	git -C refformat rev-parse --show-ref-storage-format >actual &&
       	test_cmp expect actual
       '


 t/t0001-init.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index f1d227f271..02217a9bf8 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -678,7 +678,8 @@ test_expect_success 'default ref format' '
 		sane_unset GIT_DEFAULT_REF_STORAGE_FORMAT &&
 		git init refformat
 	) &&
-	git version --build-options | sed -ne "s/^default-ref-storage-format: //p" >expect &&
+	git version --build-options >build-options &&
+		sed -ne "s/^default-ref-storage-format: //p" build-options >expect &&
 	git -C refformat rev-parse --show-ref-storage-format >actual &&
 	test_cmp expect actual
 '

base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
-- 
gitgitgadget
