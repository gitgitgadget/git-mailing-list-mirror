Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1283126C4
	for <git@vger.kernel.org>; Mon,  4 May 2026 20:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777926086; cv=none; b=sogg9kzqK9lS4NnDTMBYHaRQ3Bql1hmbKbVQproxfs5jSSNIGqZY3DrLkeaW3ndFrHq9BYQUlSO0VzHo9xSJBmdgb5XYNmhQDJAnc8sGt4GoxjDVZuwb0YIENsYRP88mojxJE2CM9U6TMLuMAUWyuagons2PLC6wwT+ue2UF1LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777926086; c=relaxed/simple;
	bh=pGYI2yHB6iNbUDcWW3MmzhlbJt8qa57WgTQ86FQbRpw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fdzGx3bvDGeMOEfDXORFInaepZ6myN2Gm5BKcrTWx1RfCVluilSyyzkAHDfjL8gjlgm4w6qtXI/YaoZylCmEoD8lKsX68UN4xwkNRq+PR3ROvxHoYRLJNhE5Jnybp7UraN12QRTp4/UAFajDrxYH5bAeumElfBMQaNrAllqWxrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGPDA031; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGPDA031"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8acb3daf2aaso71823736d6.0
        for <git@vger.kernel.org>; Mon, 04 May 2026 13:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777926083; x=1778530883; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqL721R/3BLtbgB4nBtjFCukY9ELCHvXq56YlUTGhho=;
        b=XGPDA031NODeSxu+mT2GDswu3G00CBCw/OV/GvTT5nIKNc92VhXwvz8eWb+IMb6gb8
         N9lb/vJQr9YxafWKNrCrE4y1SuoULrAxkfOe0MlVpU5XXIK5zBXIOlux8TK7MWD1Tlh1
         x8X5vp2ixRwOTdmJfwDRJLWdXelNJl0IdA7uLcjTr38DIbKfXAMN173qlV62ajVKC0SP
         0jkBIPYIDqecA0xN1rUMYu5YBJ7fTXZmgU+wjIwNamJW6ZHuzDqO+QH3Db48IJrY+eFx
         d2jTG+W/K2EuaG7/sn+pqCD99z+UyC/1zKQaNCYT6a2+SNSGwnnzvg/ZEcEygv8KWw35
         QDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777926083; x=1778530883;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LqL721R/3BLtbgB4nBtjFCukY9ELCHvXq56YlUTGhho=;
        b=cDfav/Zs3ACeOwHLRscwNldNQf3SSEybkxsHMyuq6wdu9n+dFbnEuam81bu+dt9gWT
         QsiwHgorwwza+h/NkGtSleljr0XvNcIMv2zN2qZx1qhmZhlOV4i7fLwP2W8VBYU3pLkW
         67tGcq1VPAlttULD6+maerkI50amUoijcN+KddcACyXrrwu1keRnn7Tap2VDeKdU1Gg4
         f53jkWxLMgS6VimV7UQf9R9OWC0Vb5f/ejW8U/RCR7KKm4bdM02PDDWmsp8t5PeMASYY
         r1viUqPwVhycuJDztAFnFF1H/a8gHBK16q6zhLgMMrSDO3kCrc4GFcEVw1enoFYfhg15
         Rr2Q==
X-Gm-Message-State: AOJu0YxOpNOsMnMVuoqas4R6wSfI00PoauT7uP6Q7/0kM6lGqhlY2qs4
	Xc4xCTy6XbA4KOyKIu3Q0X7h/tL1xmWLfBztQWKbWePvqWv1mTYf60iB5AZ5MA==
X-Gm-Gg: AeBDiet5wSHV+DiZRRBks0KovZu1X4HVGEI8aq67Ae3aj3EYLpLooRwRpjEGqTcHPVk
	nJdkLN621ozDpsT111ftNie11IeSNZW4Nx9VHdX90mk2+ZM24/+JaPdWUXl8u8tuWq5IK3zxIua
	7Bw90lz3rAw1c7RbhebtyUJOtPy1WtFXadcWAEKKuZoMUIOxNO8M4nK8PyGQ0ZfvTMO/1qKzS3Q
	n9VqLo7ZjJcJMy2cpAEY6JAySK33awCLhtKDB2ayGR+R5waqTMDh/HEK3FVdaTvd1lj3YqSEnvr
	b9/6b4gXkHoveq9T+/O87XMLZJT/U7jSX+i4+9kYQancy0Vs2GMkVqodhjY76gTTtpV666nyjcX
	OSmZV2dYLAvu1f/l9zjG0jo4QSoWjsRfGwUXz6BDfOERNlWkFESo2RNSZ8fsIkhATH7RvAMB68I
	NoJMCuSi0Wc41TOFC57c/SsLMaoWJdCt6g88Va2q9O+30zrC8=
X-Received: by 2002:a05:6214:2a48:b0:8ac:a097:2810 with SMTP id 6a1803df08f44-8badc40e59bmr3165516d6.27.1777926082688;
        Mon, 04 May 2026 13:21:22 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.177.96])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b5391e344fsm142953256d6.12.2026.05.04.13.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 13:21:21 -0700 (PDT)
Message-Id: <b3616803382f6dedd12137a0cec9695e3d5474ea.1777926079.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
References: <pull.2101.git.1777731354.gitgitgadget@gmail.com>
	<pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 04 May 2026 20:21:10 +0000
Subject: [PATCH v2 01/10] pack-objects: pass --objects with --path-walk
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
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

When 'git pack-objects' has the --path-walk option enabled, it uses a
different set of revision walk parameters than normal. For once,
--objects was previously assumed by the path-walk API and was not needed
to be added. We also needed --boundary to allow discovering
UNINTERESTING objects to use as delta bases.

We will be updating the path-walk API soon to work with some filter
options. However, the revision machinery will trigger a fatal error:

  fatal: object filtering requires --objects

The fix is easy: add the --objects option as an argument. This has no
effect on the path-walk API but does simplify the revision option
parsing for the objects filter.

We can remove the comment about "removing" the options because they were
never removed and instead not added. We still need to disable using
bitmaps.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/pack-objects.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index dd2480a73d..4338962904 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -5190,10 +5190,7 @@ int cmd_pack_objects(int argc,
 	}
 	if (path_walk) {
 		strvec_push(&rp, "--boundary");
-		 /*
-		  * We must disable the bitmaps because we are removing
-		  * the --objects / --objects-edge[-aggressive] options.
-		  */
+		strvec_push(&rp, "--objects");
 		use_bitmap_index = 0;
 	} else if (thin) {
 		use_internal_rev_list = 1;
-- 
gitgitgadget

