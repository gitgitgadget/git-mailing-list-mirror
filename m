Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CB329A9DA
	for <git@vger.kernel.org>; Thu, 15 May 2025 13:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314716; cv=none; b=aJeTrKfglKBmabW+5BwioZw1vZfOHIQ6+7gr4qZyDhCRa+qe4901onqCzvqni2AuKBx8yPd7s3/Q4jOLb1RJBTguRDHyg422ySi+//WeH/7bPDDxiXEnJBNcqRkD3jAcgW6ill0WkBROk9y8TX2y1wHYeXc2kyNWd3FpXtAlnBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314716; c=relaxed/simple;
	bh=6Axb6UE+pbKgUeiB2BX1gFGhEb7JtTmVwHj8XFlyd5I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ReF7MQOxF7ERjy/I4vzaQOUuQH/+h+Mpk2BNRVzr5Z0r15C/FFQ9DIN6sjyxXHEhJjbcGwXNWexbzVCDWCTXksc5NR0XN+1qjwrIs7PO6KFrUPRDn/0zaAD0U1cDuOP+fSdDWvHU/eh+dB/fuz0LiEhM6V1/QnK6tGOL1GBDuNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afTxSOi8; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afTxSOi8"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a0b6773f8dso662664f8f.1
        for <git@vger.kernel.org>; Thu, 15 May 2025 06:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314713; x=1747919513; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53wPPaOPWAGjh3GGccz31Imnm3crjTRQqGf6t18lbKE=;
        b=afTxSOi8E44DC68zFB7cBrurDZMImc3TvNET17mRYUBTkURlp8aRZwll2/BQgxwVfx
         Knp6XvxZbMywCCRkzmV14EkuWu1ueBayCUOvKjOhOaWAPQUHoEfQGVi3cdRlR0V9MgRl
         jne6TjTBeaQGiAjCU6n6oo3tNH1W6RhZ8+Zj4GAKbGjlJQUrt2wMG2/3rTV5JWK97wK5
         OHYMlWup8LmfYPakcUEIPXBgSPF7KwVgJ8wpZ+jgT4Kt9CHON8bv1cQAACwXT1/ZgyfP
         KC7mvh9w0XcApeABxWRr4e49Tv1wc+64wGu5o4Gjqag7dm5FqfJ0RAiuq1EI/8bTcJ25
         tAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314713; x=1747919513;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=53wPPaOPWAGjh3GGccz31Imnm3crjTRQqGf6t18lbKE=;
        b=n72eM+4cPvBjTuVFXHqEdeJbBkfb7eGyjQewpWDFtqmQOHQG91AMYZWySh4Ilwl9ws
         SqA7kgo25EeuxJpxeu2vZKI+fiDtOWVDLmU2HAoE66YX2VDmox3AQn44CTeTaOtPrgBO
         ANSf5NDTtgANf3GcSMgkOYZVraORhXHNvGrswq7xxFDwYO7oqZJrW35M1z1KPIOks8SJ
         n4JQjJ69UyWrFq+9T3HRCNOk+8IaVmPpy7ViIy8+wg+ht1XWls5SDwjrARYk6G/3hWA5
         T085VptmeLBnWvRg/sI/C9RpbZubrN3fJ4Zo8JyWSE3dBIVy8ONAf3qcVjFhIddUkYuF
         UAjg==
X-Gm-Message-State: AOJu0Yyo/999slzPxgMuDkjhuMQA0lJOBUhzmn6BaCWhu4OVo8NzJIha
	R7trIcmfBxeg9YuOubjgW3+MW5JNYit3PTQp70ilJdkwkY3l+lZOmQfC8w==
X-Gm-Gg: ASbGnctFBO8bDqHs5YaZ9HCSG5xO6ygeiMwCUazm9lOXrJZWwC0MqQLMgY59+Hsw0wG
	ogFUHc+YZBVID6uFbwI9D2HSQkd+7YBCPbM/Jae5+woBXyzPkOX2QRo4UsWoQ4aayPTcIp4Omne
	rlmZdgNgqdlMVAUbyfRq3qmNEs/DGjQDKSxpDfV015kfp/hfepXNrJ7hOtMpmZpDwmBCFh+r0hY
	Pj2JGbuxCsf/S5ZnnD8W6CC16ihX+2IbqVIDj0mJUxhzRyL53mRtpgxHFPCG4BEMP8myv2p86sO
	pUPqT1rHCHkuSlxbB8nrwVi3g7RlWvH7lTCicEh0wDBW04BTheWW
X-Google-Smtp-Source: AGHT+IHXnhWbOouibXvmlbtDs6yodsKDqtnUKwqcChoXaM4zMbUiVNNLl61RAxB4mjwNgU3dtcXIiw==
X-Received: by 2002:a5d:5263:0:b0:3a0:bdeb:c489 with SMTP id ffacd0b85a97d-3a3496c27dcmr5570326f8f.33.1747314712719;
        Thu, 15 May 2025 06:11:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a2d2bdsm22864972f8f.74.2025.05.15.06.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:11:52 -0700 (PDT)
Message-Id: <c66eaee64ad5484120f1905ce5501fd8b75b2266.1747314709.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1891.git.1747314709.gitgitgadget@gmail.com>
References: <pull.1891.git.1747314709.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 May 2025 13:11:40 +0000
Subject: [PATCH 02/11] fetch: carefully clear local variable's address after
 use
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

As pointed out by CodeQL, it is a potentially dangerous practice to
store local variables' addresses in non-local structs. Yet this is
exactly what happens with the `acked_commits` attribute that is used in
`cmd_fetch()`: The pointer to a local variable is assigned to it.

Now, it is Git's convention that `cmd_*()` functions are essentially
only returning just before exiting the process, therefore there is
little danger that this attribute is used after the code flow returns
from that function.

However, code in `cmd_*()` function is often so useful that it gets
lifted into a library function, at which point this issue could become a
real problem.

Let's make sure to clear the `acked_commits` attribute out after it was
used, and before the function returns (at which point the address would
go stale).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/fetch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index cda6eaf1fd6e..c1a1434c7096 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2560,6 +2560,7 @@ int cmd_fetch(int argc,
 		if (server_options.nr)
 			gtransport->server_options = &server_options;
 		result = transport_fetch_refs(gtransport, NULL);
+		gtransport->smart_options->acked_commits = NULL;
 
 		oidset_iter_init(&acked_commits, &iter);
 		while ((oid = oidset_iter_next(&iter)))
-- 
gitgitgadget

