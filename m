Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DDC3B774F
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775140408; cv=none; b=qo/sJiD5i30GtWr/2S2v99lRDkaupTUMeFpKArSEk1t0iUw+RmJ1huo3aCJXUTo0RdQXRwQUdkheqx0ug60Oa7/AvXqQa+Yd9SnsGOcB8bwTBQ7VlN1AEWwLSHF5GLTL7+yN7dzZSFqlzc+yM2XOH98usTEFLqZ3WmyhzWxgbak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775140408; c=relaxed/simple;
	bh=XG5Z8BKHOb1AuADzfLEaXraUEzPLeg9mKDLElANYm/w=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mUijHJVbCdFNSJFzYIOLGP+RN8n2si08lKrRdTshG6g+hr5Wy0YUjkIdLsWdQ81vVkb0talzoRBDsD+gIkr+vLkJBfvMJLPZUXzJpuikDJit4rHbNjesowqNHcy9oqdlsObtewPl01n8YupkEFBKoG6V/YicNRcxyRy2XyrzB8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qF5y2uWu; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qF5y2uWu"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-899a5db525cso7784976d6.3
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 07:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775140406; x=1775745206; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zsay0vdYZ078i+Fl2k2574Y2xiOimamD5CyBm2fi7+Y=;
        b=qF5y2uWur26dTH1AOAdKxSekggzbaafXD7Glv3+vSBPWG51XuZFrDXXz0Cc9miwr3D
         Ui9SAy4+Rdf1uoklUuiSi/ykZV/7cyuiKQtoYqiJKRUJGEJ5r4WDzdl5MxBQlAwkXPTd
         peL60FdlF5qYxsPGxZGN/AH59BvzJ9q6aOKSa497ADfp+9CMxL3z+2tPPNs4p2dsQyIm
         aa8nluX/BBU4u4EEbe7zsrZg+a6ae7FF6aB5UGq5V9vdudPbb5F9joVMRfGnbkTjuVuV
         VJh5oBkfqt3l7sn5kpd+KMAOEqMh8KEd01eWcU1C0+bvo4GCnQaLncCXGP2RbMdXK4OT
         yZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775140406; x=1775745206;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zsay0vdYZ078i+Fl2k2574Y2xiOimamD5CyBm2fi7+Y=;
        b=IB/MiKYvnNuSxdzOhxMSlyVYtHMNyfbW2pmCo4Y0WtEDxjkpaxwsWnzdVdqDd6FffE
         ChJ4v7whd9eCQh/s83cx26DjmXoWRuMTAF0s/NQa8VrTgUK//IA1l/rgFyRBGXNfzL5g
         J3LBgvlNt+NTbgDPTViPc79WQzs5/eeDcmOFP7F/BjXmYQjpPlwo3R3fc0wZtJYGVNTi
         xvf/90Jq1zt09mtKDShraoLKTMRrzgbSAnYbHVy5FBsUMs/IslvR53WkOlQqvI+iJRkr
         MhennsDOQT4ePyhsKxGIeF32yOj4MS+kZgBrLFj/csBNTZzqwRe1g8nRdFZ2iYW4FcOg
         zUOA==
X-Gm-Message-State: AOJu0Yx/aR6G+C0KT1+VppufU1jqP/+oD1N6s3TkYsfaztIn8jsGNm1M
	bMyHuiNRgkAOwDFhmyE9ld0xxFza/3xBB5i88GUjFPniRn/R3hLWJVjpV1+47Q==
X-Gm-Gg: AeBDieuQAgXWQZKXZ4xQ/QoFkrEUDAFvhRM3KY1I6ELW0NR4wxcD5EdArD39baaQCKU
	ll6OCCqs3fpdEjmtqmbCCbOn+a4qNf1uj5JGi2CQrRiULpCzgV6FxzFl+1Rm6X56sADoPqPwWRO
	DnivGo9bRmUSlIkReQxAGe/v0WzVPrX678sYr/s34MmzLBx2oL4fDFNlBSZkTggCRGn8kA3GOU8
	LMK+8VhuFGp8bFQd4kVUS+SjBLBA7Ve2aYqd18XWC+JBB5eO9FRKBBfXO70w9XiPwKYP50WbYww
	vkqgWo+IWalJ99SD9Ltajm8MBpXOevgn3rBAdPFYE59ecbFWzA/L6TI7SfeWRr6eUosJyEpZHvT
	Zs/tsVV+spTgUsvmCyFzR6e50zcwhycJXpgMP9yqna0bvmhvt+H8Hsy1rVLzTA+MJLqW+OjhpqS
	Q5VrQKQl/rWy+5G/S92xCNvVOKujg=
X-Received: by 2002:ad4:574f:0:b0:89f:2fa:a9b6 with SMTP id 6a1803df08f44-8a4392c1c5fmr122453796d6.37.1775140406137;
        Thu, 02 Apr 2026 07:33:26 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.177.114])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a596915986sm26687016d6.24.2026.04.02.07.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 07:33:25 -0700 (PDT)
Message-Id: <a1cdbd58f0af27be689230b7d8009d93bc34abca.1775140403.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
References: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 02 Apr 2026 14:33:07 +0000
Subject: [PATCH 01/17] t0001: allow implicit bare repo discovery for
 aliased-command test
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

8d1a7448206e (setup.c: create `safe.bareRepository`, 2022-07-14)
introduced a setting to restrict implicit bare repository discovery,
mitigating a social-engineering attack where an embedded bare repo's
hooks get executed unknowingly. To allow for that default to change at
some stage in the future, the tests need to be prepared.

This commit adjusts a test accordingly that runs `git aliasedinit`
from inside a bare repo to verify that aliased commands work there.
The test is about alias resolution, not bare repo discovery, so add
`test_config_global safe.bareRepository all` to opt in explicitly.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0001-init.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index e4d32bb4d2..6bd0a15dac 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -77,6 +77,7 @@ test_expect_success 'plain nested through aliased command' '
 '
 
 test_expect_success 'plain nested in bare through aliased command' '
+	test_config_global safe.bareRepository all &&
 	(
 		git init --bare bare-ancestor-aliased.git &&
 		cd bare-ancestor-aliased.git &&
-- 
gitgitgadget

