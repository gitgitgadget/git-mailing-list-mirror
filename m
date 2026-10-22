Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792666928;
	b=dW7ae1/p6YQZhO16x0PkSZMNMsJGxzENdyYyEqLvkp1ho9GWUIiF2QkKcWeJhrJnPQwH
	 VGmeTM1ZbBfh3D0QuZFK378fp9fJXaecP/UDlW8eBoEm3w6UOtV2SfmVJCF3M1gKT0rYN
	 lcgzoF/0IB8vJsj0oDlwllT7C5BlKg2g4SrCYTe4jO7JXwf267AibjnygXkcVxLT0RdAW
	 Rd+DRJ924djIAv6rAYs0/37jhBNkMxGb98q0vrB2a2Dyz5awcvgwkQDHCggeOAhK4p/dF
	 mDeT5IcOquElTY4zOSpEUcgvQOLwGCo5+AhECnmyh/OR7Rk6SJP5vCNjOifRI6f3C8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792666928;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=EjF2ZkJ7x2jvfc1x8KPJL8XuA/pkMBLZL1w9YWMTqyM=;
	b=0zmZtz4LDJuXqH53KKGw9D/Uuo4IOu9hoL4gF8bNzyc9FaSVC7+9IajHYBzOg8EkvdQs
	 AJOee193vlIj/LsSwEAHcwJlmBj+qXfd46LbKg8sX+QN1NgfPjfqPnLQYemBbD+jiQ2Za
	 euuYqLrvkp+6UIpi5OHw/GI0p9lBoP2QvtVUKHaxOWfgLKSEpPid1Y0xH/W4tnSeQ96oP
	 YQKASH8liZhIPB3S+w/Rej+5n5WC8TGPmp5CTtFPflaDS1eLJLBSMib5ucw19adJVQFfU
	 1bZEtTl6i3wQ7dNQhwe+EXvB5VqDnLAHW4E3rX+mdkIKyRbytI6q3uCtkfk6GgnVbAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ABULZX+8;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184A7606A31F
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 11:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 184A7606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ABULZX+8
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-14fc585291cso309244c88.1
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 04:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792666927; x=1793271727; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EjF2ZkJ7x2jvfc1x8KPJL8XuA/pkMBLZL1w9YWMTqyM=;
        b=ABULZX+8e96J1z1NThxm+yotwukocULOg7govvjeUhba40MWZ2/ibZFVcdqerzdkVR
         Ws7pJw8moIa8ECbZVirL2OgyIBLN1CUVoUpVfj1MO3K6T29YlHzn1L4ObVE++w/W3H45
         tTugBFYQuFZJcbzFulWZ2uTT2365LN+8JkbH4lMO1RO6wiPFxXgpDXXbbNmGm98lvl2G
         f9Y0zP9nliE9VyaFWAibzrd7dHlZdnVvQM5+vsky/r5XUryd0yomofN20t7sBBbzmQCW
         Uxm9sJqexmvS/g9NOoTwhb60K/EoGlTCVOQLkDEEsrwXt67xa/HVfBqc54wEwU0S4WRb
         dETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792666927; x=1793271727;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EjF2ZkJ7x2jvfc1x8KPJL8XuA/pkMBLZL1w9YWMTqyM=;
        b=D/zeiIv4mWXVSwXuFFoQtFNRqen7WTh7lqEXHR/0a7ElkBpnr5Y++Sy1A2GBjeBXF8
         Qun7kcWOMMSwVKs4X25MEF6rpIG1UhhCpWDLYZ3Sw6y7CgJvYeA+B4bwSX1uPrbBntG9
         slLFLN2oS77PmLxT32Bxxf/wGYRM6CExmbpaoLFnDqz5vlMzj1Y9SNKhy/kPIhypztXW
         FN+uXCpGFgzwB5Ah3ymiN73l4czXjPOmIxNaD8rXTqczQYeg8Vy+85+4OPEjoIG2BTZL
         oDR9HfTKSjsNsnBrZCy3y2iLrdJ4pd7z6kedoQow0dvW1hELBWJikhvpR4VV2NXqY9Qa
         15+A==
X-Gm-Message-State: AFq9FYKo/EiL9hGHzDFCRKlUb98/S/B5OMJRROaZkf3x76iiVkI58YdT
	iuW1Aji4elmAPqxvA93TZj2Xr3OQLQqyTWWvAFHQ8P8x4p+nn8vI2xhDwcDtKQ==
X-Gm-Gg: AYBFou2/81hR97lvjjt7V3OtMo/UmE2A8rogC6CODb0uTH1l3t0ZS9O+6hQY3ctaMzr
	t3ARU2Ts6GgTix9R8R7WC6dqwf4xMNqpmq8NLjYatQJi9JYfzRkhvAI2LOlobNxdV07KHTAkH7J
	0dg4BBYzGAV7b8v4V/PigzLG406N2CrLP9hadgitz9If38DszERvaS7dKhsYi3NFWLcdOQ7N6f7
	w2JKoihUy9t7iELsa/NGMnULr0xNYEomXy7/OvJzZVRtzBC/DzqGyLTljXufrmVeTlIzXsZ1rGg
	l1DrISAcc/ktptyaMfOlvdhtwsoEeOICtTiH8t3EwMJnFEtyeDAk8xh4tarMOr7G/jmuTiCeZj5
	5Qpwp4gAWdd+wUhQo7yOyaSURcZwyn72WFycclBLTPmYHxV4JQGOVfH2R0lih1hPawtVI7cFojD
	3YwXy9Cv4t0sxvEK7gnxVvx5hikCDGGhOVgGEuqPLbdKwZCo/pAOd5D4h4voqx4qH7qBh5a11ps
	gUGbygv5gEcq9BOYFoFOS7OqOHJAwFwRnVA141p2gyOs5XR6icLcWO0NMwF7yBb
X-Received: by 2002:a05:701b:2405:b0:174:7d98:fe9b with SMTP id a92af1059eb24-190a50ef6a2mr5922518c88.22.1792666926888;
        Thu, 22 Oct 2026 04:02:06 -0700 (PDT)
Received: from [127.0.1.1] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-368ca914bb8sm6277428eec.5.2026.10.22.04.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 04:02:06 -0700 (PDT)
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Date: Thu, 22 Oct 2026 16:31:58 +0530
Subject: [PATCH 2/2] unit-tests: ignore --long-tests
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-ks-unit-tests-ignore-long-tests-v1-2-554a590d418b@gmail.com>
References: <20261022-ks-unit-tests-ignore-long-tests-v1-0-554a590d418b@gmail.com>
In-Reply-To: <20261022-ks-unit-tests-ignore-long-tests-v1-0-554a590d418b@gmail.com>
To: Git mailing list <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>
X-Mailer: b4 0.13.0

In the same spirit as 9faf3963b6 (t: introduce compatibility options to
clar-based tests, 2024-12-13), we should ignore -l / --long-tests passed
to our clar tests. It may be passed along while manually running tests
via a command as follows:

  $ meson test -v --test-args='-ilx'

So, ignore -l / --long-tests in our clar tests.

This does not show up as a problem while running our CI as we enable
the expensive prerequiiste via the GIT_TEST_LONG env variable.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 t/unit-tests/unit-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/unit-tests/unit-test.c b/t/unit-tests/unit-test.c
index d066c8a4c8..06ffd0f5bb 100644
--- a/t/unit-tests/unit-test.c
+++ b/t/unit-tests/unit-test.c
@@ -28,6 +28,7 @@ int cmd_main(int argc, const char **argv)
 		 */
 		OPT_NOOP_NOARG('d', "debug"),
 		OPT_NOOP_NOARG(0, "github-workflow-markup"),
+		OPT_NOOP_NOARG('l', "long-tests"),
 		OPT_NOOP_NOARG(0, "no-bin-wrappers"),
 		OPT_NOOP_ARG(0, "no-chain-lint"),
 		OPT_NOOP_ARG(0, "root"),

-- 
2.56.0.99.g5a7d1e8045.dirty

