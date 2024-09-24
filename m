Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A271A3AA6
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 13:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727185370; cv=none; b=ukm+WHvzJ6aiq+XoJho1CT8kqAl5W7zmWB6tZ7+aO5kQsKPv2pAxJZPclJMucPUqSqMChaCsaaOdYNe97EbY05kDGlNGb3cpD9qNN9oISjxa5ewWUUXpBTTAlqVlwQCyUQJrHmKayNoCuZ20exh1fO1ggAmNWBaHR8CafvXi0E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727185370; c=relaxed/simple;
	bh=WDNtl9Uc4luOTJVYrzOZ6qJ9Wyqp5VTsrALyoiodHoA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uMN7w/fuVVzCsLMQMW0+JHsk4OKLFvbw7C7B3zxY/1uM0Om5wqTibNDKf4WWHtwLfwJM1nptGFpKP9Ye8hryEA4hvJF1R24Oc3vvqFiUNkqgI8o47JVFurO55K5oaA4boh4kzRRXWKjrS372jROdTtQ99FCQ+kCkiLgoZXouRMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2dbE4L6; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2dbE4L6"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8d2daa2262so721294066b.1
        for <git@vger.kernel.org>; Tue, 24 Sep 2024 06:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727185367; x=1727790167; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/uME0+c3yoQSeYNdrGoWOQQALteKo5322Un6DrNnXg=;
        b=N2dbE4L6KkNJpAHtUmmm+hSoIvnBpeh6FHwbV2MsanNfJHlBkIMyAA1lVsDCQv7FqZ
         YOYY+FgRYWU1K3YIK/lXSRfcGQdBy7DBBax7d1Ij3wtq8QWYjZL1/5QcoH4/snn3sk40
         Hd9oMOvAv/LeOyQFjFYd7TvSEGfGCep110LDLFuFg5cOGYgMLd9rDseYy2lhi2MRG+wd
         uEL7TUx2RDqLQ32ve0vMj1ha6PL3y9Zh1BNLAoq886CKfGhWhJTlmn7vMyHVCUq/tQaC
         tUQehbw+0hpKRHOzA4vJOYta2T+yh7EShLQgU4DNeOhVzNQX3YhmXdvmPKT/LG2216Zk
         KgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727185367; x=1727790167;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/uME0+c3yoQSeYNdrGoWOQQALteKo5322Un6DrNnXg=;
        b=DPRUtXkWbdKPRjLI5jvjPFOpv2Gdhecch1rmpdt0PEPAEP5W9nOjqFOQ5Qe2AOcQmw
         fxcx+v+PiaYbHDhwCI4HsNbKnr9Ypj2GW2mge2ZLQc4VljPuK/YQOu0rpSuXF90gJoQ7
         4ZYnPf6bkKd41H84o+4vBvel3eEIu2BKBr2T39j2uhkY3TggEyY91T6rdfpyoqqOsqW1
         +XqHhs0IpH7DdJ4dnsHraTOaVRCN6oZznsCrUTQLg6LVX8NYqjN6Lt5xu6Qz6dfmsE4P
         8oAVbtPLdem5x2vHrKLmlpBX0KGKUU5yvzVhMFGPTSMRO2MJzD73SkO2IiSSEUP76e2F
         HDEg==
X-Gm-Message-State: AOJu0YzOIXljiysXGueoQPb0Wn8aOKLDBzdgat2V+j0oL0+ExWlXPIBK
	ajbTyFnPoja36+zLpedWzNjtdZ3yxGYmSARN/Gn3jk/9CP7LeUspIWrc7w==
X-Google-Smtp-Source: AGHT+IEFYtbDLFO8WC9b0EwMyc74/Fwzw8gKlQUMi+aNSh8AxfV4nDL+96dod3EhXW4apj/c2IiQSQ==
X-Received: by 2002:a17:907:1b10:b0:a8d:439d:5c3c with SMTP id a640c23a62f3a-a90d4fdf247mr1829218266b.8.1727185366603;
        Tue, 24 Sep 2024 06:42:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f5475asm86544666b.79.2024.09.24.06.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 06:42:46 -0700 (PDT)
Message-Id: <eceb2d835be7168081d6eeffbce57bba89b5f423.1727185364.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1788.git.git.1727185364.gitgitgadget@gmail.com>
References: <pull.1788.git.git.1727185364.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 24 Sep 2024 13:42:41 +0000
Subject: [PATCH 1/4] git: pass in repo for RUN_SETUP_GENTLY
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
Cc: John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

commands that have RUN_SETUP_GENTLY potentially need a repository.
Modify the logic in run_builtin() to pass the repository to the builtin
if a builtin has the RUN_SETUP_GENTLY property.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 git.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/git.c b/git.c
index 2fbea24ec92..e31b52dcc50 100644
--- a/git.c
+++ b/git.c
@@ -480,7 +480,10 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv, struct
 	trace2_cmd_name(p->cmd);
 
 	validate_cache_entries(repo->index);
-	status = p->fn(argc, argv, prefix, (p->option & RUN_SETUP)? repo : NULL);
+	status = p->fn(argc,
+		       argv,
+		       prefix,
+		       ((p->option & RUN_SETUP) || (p->option & RUN_SETUP_GENTLY))? repo : NULL);
 	validate_cache_entries(repo->index);
 
 	if (status)
-- 
gitgitgadget

