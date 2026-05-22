Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4504C372051
	for <git@vger.kernel.org>; Fri, 22 May 2026 18:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779474283; cv=none; b=TQxcZnOkcOMpIHacgOMs+i5DTv/8Q9xNnNO4Ly+QgxohwlSfkzEWmrEZCvXQXVOFot3ARAUMyli1aOSoZDot7jsjO9wdRQd0TFdAMrIqL2Wv6pq41OSbKRakzb6Hs0ctUkpdhZKxshNPswhbpqLAxeygNZbeE8cyqdlr1doJxek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779474283; c=relaxed/simple;
	bh=k2jn3vB5Xll/veRaFYtx8C4+E+Gj61KHTMo/G4UgHQ8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Ii0xUyuzdWJPtlzMWGYbKXfe+eW7nhwb0hw8tMg/Ox1F/Yv2onM6TyJqeNr6dm9bimoFktRRd5p/MToau3HceVN82Khahdr0rPTFq0twWzAL4tCLX2FKP1t4zbMMZnuJjKarx1oZE/WhfrY/N5SnWV1VCeeK0mYHgAncHre9ZTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ln/dmAAj; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ln/dmAAj"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-914c12b9458so23020385a.2
        for <git@vger.kernel.org>; Fri, 22 May 2026 11:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779474281; x=1780079081; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82S4mAKNn61wva6ccRQ9bbVnCM3dFkd7+cRosGlVjn0=;
        b=ln/dmAAjXHRr+SPXMc6F7bDmMG0SZSYYAPtXPfGjmKXCOMJdFwRPuQ2Dnob6PCekgc
         peqOYQvkjrA+tYxtXG5IJjFHcbrLtTtcW0HMUG5flsaRGcEhYpTLz8GJNLhG6t3Ob0rl
         3SNFHbKYIPL9qMU17LkYUnYMtvT+H5HAXAcuJc6hsFnp633saz6pGwt3AJ8lV0wDJsZz
         4jfTxNLv7Aw5KcGbpwgm/fNCH3gufMvSNzzVc0kGfCcDc1o89bUGtSVxfpRP4QOFPhdu
         7K8P6nMnOkqHF7wd5pwGxT5Sl0XMcUuCSiP6AcoLKLeNJ2tjBX1NGtkeQgN6aPMEfxIi
         /4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779474281; x=1780079081;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=82S4mAKNn61wva6ccRQ9bbVnCM3dFkd7+cRosGlVjn0=;
        b=DPHrvW9W2y7K21yAwzh8oMUm2FI/a3Kh2iPgIgYJJ/n/Y4mxZ8Udp43FaRYlOvC7Ip
         7mnjV/b7UZnusQu4zadLeRcm+qg3RSfWVFwkDRLgLZUVKGD4Qq6tKBmIDL9pmAvbg++s
         MmSEseUq569SY+bmyOTg3v6eqaL8Da6EeDKEvfpRLxBrNt2guarL333jqLgn3DFkxDuy
         kqBKxWMrvSJiD7cwP0Dm0NXZQI7dJaKjaQKf7hIMSV49W0jTLf0VR5RXJr2k3lkdyIde
         sDtvJgiaO4wMhPKtOEifX6js1SO52GGZAgZHDIifXSPj1xGjuQSXyfYk1UCQg8LAxMK5
         xmiA==
X-Gm-Message-State: AOJu0YweDftYvr0uH4EOhJbq1ZthkhoXtPf3fksROB0mqV60le3s7B12
	5CABVRighgGw8QIKjbLkjlMoamWMWZdmIzy06oDVhAvngSrENiwt7FNCXdRKNw==
X-Gm-Gg: Acq92OHbS4mLu79LbfzP1L17F3Kxid89Sga3j3Vu9vXFpL+R+AqpSNhob8OJrCPIHW8
	5N8ivmoXO+IRK66sYkXBvWFkQfmdFoMSTdYESozFWCdfrAxAJcvycuz3VdEWtv+Pj9kMJtcmfTi
	0u+tTAYuF3QOG6l+3vtZqkbSa6wzxcWZYy24NTZvtl+cql0Owwgvs7S2fjFUemtdj4qMs++4lDd
	FfgKcLz76V0zbHbhMjM7aVSCUsjztCn1u5QyFjgQKm3t17hQDiwYhPaRnLYcK3m6hvbgrhjazLd
	xECW02dyWXLNSKIFbaJPxR3shmIQFRsGRAXzoGgQBwHMqCNXxwyEtfb0rqu4vez1WdG5zhxKidb
	oJiRiI4o2EEQCfIEgXFevhFb7gulqLUQ+9hJXNscpGzJmnnFFQJ4/VtI6Jw2tDDh8FVMW2vXoI1
	j4sXOhJPKI6bY5VGKfa+DcxwSd5VI=
X-Received: by 2002:a05:620a:f15:b0:902:5778:d312 with SMTP id af79cd13be357-914b48d7093mr761343285a.12.1779474281204;
        Fri, 22 May 2026 11:24:41 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.123.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb9d694csm195825885a.31.2026.05.22.11.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 11:24:40 -0700 (PDT)
Message-Id: <d7c87545f38a2457031bb2e75a51b464a1525ed6.1779474277.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.v5.git.1779474277.gitgitgadget@gmail.com>
References: <pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
	<pull.2101.v5.git.1779474277.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 22 May 2026 18:24:26 +0000
Subject: [PATCH v5 02/13] pack-objects: pass --objects with --path-walk
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
different set of revision walk parameters than normal. For one,
--objects was previously assumed by the path-walk API and could be
omitted. We also needed --boundary to allow discovering UNINTERESTING
objects to use as delta bases.

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

