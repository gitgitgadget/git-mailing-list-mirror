Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9727A47A0DF
	for <git@vger.kernel.org>; Mon, 11 May 2026 18:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523196; cv=none; b=qsy7eVv0Rc53eohnxm4QzOjYobyIZpNLOLEe5TqmyRAizMvFZ+RYPsNITi0urXjVmTEYqUE1kocaoSOumeQwV9Hdn+vtcjAWaaCeMleYnuyyUJkVNJSHQ9inGwqk8ptuv9gr2IaVbNeqcTpJSCpJGo1NocQDD+VNsraV/UUZYIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523196; c=relaxed/simple;
	bh=pGYI2yHB6iNbUDcWW3MmzhlbJt8qa57WgTQ86FQbRpw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=H44BsOPhxPXDKmpbhBi9SVBb90+3WIiZSoDDlepVIk81oEx9RIf3tqbYlb9PD1Ma1o0fmvj0lvUzUfXIKcxUzBPIIu4UjrykNVyZpZmUthDMz7arTSmM/lYpfls/Lg0NBRdK6FpprjgVsXITtVhe1QT5chglYmqhEHUOFqBX9TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsIogV2r; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsIogV2r"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50d75bfb259so30676761cf.1
        for <git@vger.kernel.org>; Mon, 11 May 2026 11:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778523194; x=1779127994; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqL721R/3BLtbgB4nBtjFCukY9ELCHvXq56YlUTGhho=;
        b=SsIogV2rxtFcYOzq7WrbgDvJpFUviPjX7J9qByzIsXZvLCTV3KrYOJ1qjaGQMO6r3r
         UigOimMmesS2PhnfqdTnoxvHMbc41kB1Q0W6/55GUUAm/N6NWhMumEaCZWprIsTdl4Or
         +ZqIp2Eo5KwRRq8tGSw9fCwEiaYbqfAe4MwyCj24fVKv8mFVQ5JMstDcAc3pfReE7agE
         qbK6BIPxkw2kSdh5t4w1ELM+zVZ0JXAhPabyR54xRqkKWZNSgDeHOcnnzCLy3wR9y69+
         M0EkmokwO89u6mTOgcPDjj3WvRiVFaxQX5kE0YuGDGFm8eDGsSEEHjH8HtBst2HSpDPC
         /nfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778523194; x=1779127994;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LqL721R/3BLtbgB4nBtjFCukY9ELCHvXq56YlUTGhho=;
        b=I/3p2BVIM3hU68TZn1cOGqU2CUoB2yxoaymoE6Yc+gT0dxERpSQl4ij7MV8Iih7LYw
         7XPrkBCWn5PVM2krxiPxF+9LlTUXh0rGjprAGotiYu2KyFluHIqlduLmOZ620VrEo0es
         iheTPfGlfV9rDPaCv0J0DNaS4tSkcEqeduR3zA1KPYoGKAvQgFbt0fKLrzakMRTyrZYK
         j3pt+J4JdfTw7xZHxefDAgtN49C/dSLtDlwB81LZqE9xevRpTQXi79lCTknRd4D/xtQR
         5F8D+e3RrOTucpB3dGnYeg0TQ9oHrmtCPs0L17ZgIIQ0dt9PCB1LEnvAiSVrST8SS9Dt
         wtNg==
X-Gm-Message-State: AOJu0Yzz/j7dIIiWVdgrynS4JUMGGWi3NBX+GfimDX2L5Epje3cEjS+C
	ggEvLGPzdmIKp6VSUgnw5SiwymQA0t1i8YQ3HGd4Smi4wU4WdhqcdoMdSfS3Zg==
X-Gm-Gg: Acq92OGX+sIMkQBNSM24y6l4Ktyg0G5A4JVEINzwTHwC/QIQNnxHjkeGUA/2Xiia8Iv
	X7DkP9fF7EQ2wMSastLTV7xm6gzhYBmyMcC10lL/2p0w00vpNDbwEoQVXzcmPQYo7vFyS4TXfHg
	tYSy2mi3DbMdanCHg/gM1pNFBlxLxd8EeFZIKRsxiUj5bGEKhi0B8cHQVnYD6ki0j7XmkXVl6nk
	Vb6pqvNIAdYKSVVST8VxThJMO9Ax7HMO7X3WRCwXDK1FwDvUHXkZBVhdwit7zgNuk0mQl9wnt63
	/HlPWtN4t2FnRJq8bGUm+sldmSVc8c8u4RN+VJJrDNWSURUs62RDhjeTs2v/BGP7skKtrIruP61
	lVAD3OF/q3ewnhkOOb47SEHjuBz/b6OUcl5qDC/H/7llkClO7/7195enaaRGXd9RdekbVDKn2Nd
	xJH5ktysxtkM9vS2lgdD4pDlk9mw==
X-Received: by 2002:a05:622a:4ccc:b0:50d:97e8:939b with SMTP id d75a77b69052e-51461f9e47fmr363593091cf.36.1778523193798;
        Mon, 11 May 2026 11:13:13 -0700 (PDT)
Received: from [127.0.0.1] ([74.249.78.164])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53c6b8398sm350584386d6.37.2026.05.11.11.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 11:13:12 -0700 (PDT)
Message-Id: <5cc63833800d12b09ebce882ad3e25f61c9c1940.1778523189.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
References: <pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
	<pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 May 2026 18:12:59 +0000
Subject: [PATCH v3 02/12] pack-objects: pass --objects with --path-walk
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
    Taylor Blau <me@ttaylorr.com>,
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

