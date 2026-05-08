Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99522359A89
	for <git@vger.kernel.org>; Fri,  8 May 2026 08:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778228230; cv=none; b=gc6OtOAfcV3jvxtkvP3zmffc057jCCK6El7Fxtf2Rq25S/VS5NWsPkWaMZf2fHwSGvmc2oIfXS2hqSYZaxttRsiWHfB0C693QHgF7dc48WGon7N9OcM5BCZrfLC4jfjhYOQW0OGNXdYXuuF18zVsn5zxJtHHPomHeSN/0TCA2PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778228230; c=relaxed/simple;
	bh=PASS0jf5R1CaQT04dB4gmIEPEo0kdfIoVtivlB04D60=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XYGSc12XCAxuE4a079uHYZlPCyeSyFzTYYLpLzExdujc3jSL5gHVe/1NONidxLlZseS2Hl5KOoNwoQYmkR4rCUiiXspS1vRunzk0xkDCwQrnDoH8frGKisu7+YUxnNL43gI6WZERosi0y8NR89mh+cBtzrAYvPvCwX4Cu0X1f10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+D9PIHw; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+D9PIHw"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50faeb8317bso12543101cf.2
        for <git@vger.kernel.org>; Fri, 08 May 2026 01:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778228228; x=1778833028; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpTsmj91yrtrxUOUYDP3Ff5uPTzelI9FxAXV468jY8E=;
        b=H+D9PIHwOsGDxyEvgR5bJnAWNk7Qwchyo/5jJSi4Cdxk6rkdSvIaYNFfY7RG+B5dwv
         xo0iO98lkSFRAtcmpAkepSDqVgNyrJaSRlfzch2w9V6alelykvLGfQC0kBjXySCRU+iW
         PoR+pWsPsjSIEuYj6xa4O0Z7Gu1PVHx3y5ce6lxanUfqVT4FdZ7sKaH+6OdbhdJisYX+
         yx9eHqryei8TL4K10GVe1GF46mmVe3gsIu9IF2Vmk1Wh10S5f7yi00/gTySF2mopFsdw
         mA3n4fi27WMIBFlJM0tUaKuiqHwMMI4035mx9L1GmOaqJdCEgs38Ee4lnZ8vLjTCg37H
         EuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778228228; x=1778833028;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wpTsmj91yrtrxUOUYDP3Ff5uPTzelI9FxAXV468jY8E=;
        b=c7mDUPqSPVKs6jhpz9E+hn12TpqGDsIMO5p/5+fe7pZ1TNbQx7E5sFge1gvJMk2Y21
         1lM5jWCS6EqPf/qONImHPExmKzEc9OLO6i1VI6NKP2LL2K0HVRc15XKlwfzHxcH4X31r
         vCitYCaM0j4cx867WJAU7YsWOnHNI2PMgICIcuCTcq4wWpTARKJjUK2M29Cb5YUj+W3B
         A7RyUCbVGxinAlWocIW8lAprXhXXIU216c8n+AGa2tY3eCmTCghtL2V16m2UYrIEw/6X
         K82Tfm3nCZUrSfNzZOIXRfH1bpmVMPV3oy+LnbGHeCfdKBbF5ax15M78djGVS0hYf2Eb
         jbAw==
X-Gm-Message-State: AOJu0Yz9+5yRC9EuBZNzTuZMjj9Dy6+iYVsexgE7QhsVsfglP3HpzUtA
	7vHGguRhjLPCA/g+WI84Nvg+hE0p/PfRPoYz3xk5Wu/lTAFu7QDJJ02Y9LlOJg==
X-Gm-Gg: AeBDieuiIJLR2u7g1holNG8aO4hZBgPVmM3IqWRnjHd/hcDjunMPzfFYsnp1D/iCOaz
	I97CEFlB2zO1FATA/tOC0UUhmRo/kIOdLbrC9/ThRX9M6DkYB31rEVOHWDk+hetY5+xCytuz+t0
	rhDrg8iau8pS4TkhARgtMCtiDhZAYr6mf6ux0pWBbmelKExPYm2pub5HTI3CxVRihRmTEz2HuvR
	hYbAmZzWR5/K3opYQMtXqWGHYp6UaHUbx5ZXPdQxPi5x9Q+wNRepwQ7q3774FacgwhC6E0dGeHP
	ExqGyB2D1ElUiwlknpSf1aqP6GwmKcRCPDnfIC+He/OxKd9aB7c3eY28IBYa9vQONnuFA+sKJMK
	IHIStODN8182Oxj4WiiipEAedg5Slh9NP5YZNAq8HBJcReps+poBrl3UITQFGH2Uhm716Lc4LJf
	xMZ0JCKVMyOHFu0XfgupqEXNXlRQ==
X-Received: by 2002:ac8:5e50:0:b0:50d:8792:b6d1 with SMTP id d75a77b69052e-5148e950e36mr20424801cf.38.1778228228251;
        Fri, 08 May 2026 01:17:08 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.117.241])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53d83114fsm225424836d6.48.2026.05.08.01.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 01:17:07 -0700 (PDT)
Message-Id: <2159f6a271b06d156134392ce3c44fe957c83378.1778228209.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2102.v3.git.1778228209.gitgitgadget@gmail.com>
References: <pull.2102.v2.git.1777914508.gitgitgadget@gmail.com>
	<pull.2102.v3.git.1778228209.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 08 May 2026 08:16:49 +0000
Subject: [PATCH v3 11/11] ci: run expensive tests on push builds to
 integration branches
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Jeff King <peff@peff.net>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Derrick Stolee suggested [1] that expensive tests should be run at a
regular cadence rather than on every PR iteration. Gate GIT_TEST_LONG
on push builds to the integration branches (next, master, main, maint)
so that the EXPENSIVE prereq is satisfied there but not during PR
validation, where the extra minutes of wall-clock time do not justify
themselves.

[1] https://lore.kernel.org/git/e1e8837f-7374-4079-ba87-ab95dd156e33@gmail.com/

Helped-by: Derrick Stolee <derrickstolee@github.com>
Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/lib.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/ci/lib.sh b/ci/lib.sh
index 42a2b6a318..a671994bdf 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -314,6 +314,15 @@ export DEFAULT_TEST_TARGET=prove
 export GIT_TEST_CLONE_2GB=true
 export SKIP_DASHED_BUILT_INS=YesPlease
 
+# Enable expensive tests on push builds to integration branches, but
+# not on PR builds where the extra time is not justified for every
+# iteration.
+case "$GITHUB_EVENT_NAME,$CI_BRANCH" in
+push,*next*|push,*master*|push,*main*|push,*maint*)
+	export GIT_TEST_LONG=YesPlease
+	;;
+esac
+
 case "$distro" in
 ubuntu-*)
 	# Python 2 is end of life, and Ubuntu 23.04 and newer don't actually
-- 
gitgitgadget
