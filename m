Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49FE10A3B
	for <git@vger.kernel.org>; Sun, 28 Apr 2024 22:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714343475; cv=none; b=EHxex6zUdfNiqbDupAZfF2KaP5v1/ZfOp+seEvcDEB7p4jJUb9Wn4iGP4BUA1y4sjVqk+XNpcMTSNL4ZyJJKYdZyWPqXvJN9DQdc3x6lDecxVZBITs4s+A0ytkZG76KWpE5cR0pqY2qjgsD2MaD+zuT90mZfosrgnIlodERPlJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714343475; c=relaxed/simple;
	bh=tHk2T77Rs5E324KFwRwEYaV9LBcZlx53SROJvyVatuM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Pf5N4zAHDErvPnVV4vqAiaESKgVWbZvkW8NTjESEbjrXmJx4eZ6FRqWkhQzkGkU7irfgGCtsqqKp3xeRFBX1HILqG21Joi06LekhdsaoNdJTVXGgOpY/o5z05BUl80DRQ46oS2+aJy3s/bCDrjtHdJSfmAif3Nc+sIorifOfqaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpzmM/pt; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpzmM/pt"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-34d0aa589a4so337463f8f.1
        for <git@vger.kernel.org>; Sun, 28 Apr 2024 15:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714343472; x=1714948272; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMSBnx5sk4mLWZi14pSEtOGXQe3nHFbwwTnjv9+JGgI=;
        b=EpzmM/pty5aGUtsBFyZOpNTAXBS4FqYagwBkP7gyOtdiLeviuRla2+kEdj0ZVfhO1u
         L1OCBALRXuhFSF49QHpyrSh+Ys6Ez1ujFObChk69kRhA7DJwewcjvMQT95jjLNjrbyXY
         NUxAE+wzIn3TjxtoyVL7CO19QKIXcAppFZn0b3OwuN3tbXEe7fFJTDtgSFnIy/oKipBS
         A8fU8qFWqy0rcOsQnD79U/ZGMx/A20s29MX5NHNxxvm6ifu9EgiIVmiNU91POIqDBpf3
         nfgkGcDeRzPmebNVlukGdjDK8j0451B1k8uLULHcAN+AnIJ3OjNteuSCv4HWCDbhTSp2
         GjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714343472; x=1714948272;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMSBnx5sk4mLWZi14pSEtOGXQe3nHFbwwTnjv9+JGgI=;
        b=DtujQfwSeInAaaQ5U4JAZ29JBwa0vRF4c38iIWO9zzixtXHvuIzRQzbYfpNP7F4NJc
         /Tn27ExodBB4cy7ZUBSzwRNNXX4QGj1dOiPRKhS14HA4e5O9D3BpC9tsCL94FVdgqQMl
         n9rwMMWlYsiZxy3ez1NI671IdZD6gjmkYU4OmM5YFq27xfcFR3EtU9giuym59MCGhHFf
         mIKFO19idDbvYLdCWhkP9Cn5MBFb7ceDukTWSGaThxq07Et7pSs4TomUJuZ9NRvVluB3
         6OdWkTnqILMazo1uVkGP9WPTo/F39r/bXAX7yq/PT1GGauId1nPq5HW/KlIo0wLPtxmy
         4RrQ==
X-Gm-Message-State: AOJu0Yztfo4giRDsSA9DZC04ZRYpPGAUkings50pdaaNt+v8xq1Fp3ZG
	6xQ49sFX0IrQJky/HmRCx7igTMbY2rVy20TKg5FXZ9AYingm0iICu1bMrA==
X-Google-Smtp-Source: AGHT+IHknQJ8bPJ4A058KWVjUil2FMyBVlESPCcO12UaOBR6YF/oI8V1wzqW+XzFgMV3C0F4uuM7+g==
X-Received: by 2002:a5d:4712:0:b0:34c:eae9:7650 with SMTP id y18-20020a5d4712000000b0034ceae97650mr2086780wrq.46.1714343471862;
        Sun, 28 Apr 2024 15:31:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d15-20020adffbcf000000b0034b1bd76d30sm18182165wrs.28.2024.04.28.15.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 15:31:11 -0700 (PDT)
Message-Id: <5de00324fb7011549da066068a4d102b9bfcddd2.1714343461.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1715.git.git.1714343461.gitgitgadget@gmail.com>
References: <pull.1715.git.git.1714343461.gitgitgadget@gmail.com>
From: "Matheus Afonso Martins Moreira via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 28 Apr 2024 22:30:57 +0000
Subject: [PATCH 09/13] url-parse: parse options given on the command line
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
Cc: Matheus Moreira <matheus.a.m.moreira@gmail.com>,
    Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

From: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

Prepare to handle input by parsing the command line options
and removing them from the arguments vector.

Signed-off-by: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>
---
 builtin/url-parse.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/url-parse.c b/builtin/url-parse.c
index c6095b37ede..03030035b4f 100644
--- a/builtin/url-parse.c
+++ b/builtin/url-parse.c
@@ -101,5 +101,10 @@ static char *extract(enum url_component component, struct url_info *info)
 
 int cmd_url_parse(int argc, const char **argv, const char *prefix)
 {
+	argc = parse_options(argc, argv, prefix,
+		builtin_url_parse_options,
+		builtin_url_parse_usage,
+		0);
+
 	return 0;
 }
-- 
gitgitgadget

