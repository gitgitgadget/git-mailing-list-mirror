Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3651362
	for <git@vger.kernel.org>; Sun, 20 Apr 2025 02:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745117717; cv=none; b=NnCKcsKl7kj3n8npsp9SqKHwra+AAFa3odcas74AWBsfyiLnFxOvKajYl8q15LqLESqb5QazNh0Zb1EdP9bArkL9/bdJwsAQY8bgJZU6R7GsYhKvu23pQXQmmpLLKrmXwpJ3tIwe9UkNy5dyNbhRgKnO13OA6E1C1CvBpR/097M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745117717; c=relaxed/simple;
	bh=oRh1SI9zgDrIwgFOaD7xmohkkDJ3UPI1vFvGOUvGH54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oxq2tF5MW8IWw2Y/VM6HcgPXS43foC2qgdVpxHV/63MdiuhMkyuOtskqPxB+GqDRNIOx34u4iwRIqjG4kX/Zq/9A7DjIRAKreHA+Z2jB+LqB8s2xfL7T3G90UC/wAK7lFQJcViMl7yOS4HREl2v4s209dJtWDVw0jdfgMYkyaEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJBS4OmE; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJBS4OmE"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2241053582dso42632635ad.1
        for <git@vger.kernel.org>; Sat, 19 Apr 2025 19:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745117714; x=1745722514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvQcU0wfp3idQgJ3pfsBjRbqTyqsAHY+wQ4bBr2tH84=;
        b=mJBS4OmEVq7Z6UrfsR1Z9ayjsfOs4E/wrYoVg9GEztuoUKd+yR0+kbAR8tLvuvxz9R
         ucCMmo1jJO7Z4NIU7VF8QKOdzzZxJ95sdoDvCcKtVO/MIhBn7hgQg2FrZdcOYmtVJZdq
         7nj6VCLMjnTY4szsLemNDasTyXRyxAPeLiszaxZ7CTF0+7PJNVAH5GnRU+90wn2PmVbc
         3VCzxWvJZef/iKiHkDuWA1V2BmXS+gSvd5KJxlorDqve3zozIvkkClmuERdvdkREgpyb
         Tbxf70tejyJteZH0gHiehP33YshS4bYWK3eH9S2EdoSr5zGRRouBpWQlLtRgYDGErfhx
         DZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745117714; x=1745722514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zvQcU0wfp3idQgJ3pfsBjRbqTyqsAHY+wQ4bBr2tH84=;
        b=k4P9QzZIfIywItZIH6pSkALTXsz4Ub/mXb6HqKqVG8vTD2sg5Scwt1de2EpAsIsiO4
         52EihHUMqAV9k69njCM8EEfodf5FZ9BlJg+AViUZ2ZpyWAf6r9MRaPjxLMSjv23tfoi7
         fReZCQJlNf0ZqU7zZWh6sSdDgZtl+Cp3qfvF/w1de9IG5iqFq7+PtY4FEut8Do+dzVdH
         bwzv4gzl3T9rvBti88pN5Tdl0UnavyRN1lpyccjUgi/6sApT+8U/CNMFoBXRXxVBEv/p
         J6s1+P7XBCcgaZ6L6v4iB5k04N+wHVaI5mgGyz7gc8+1j6fBqf6nDNo8l7NM1HDxgybu
         hSyA==
X-Gm-Message-State: AOJu0YzXK+38X8zuK/hxM2OdeYSdZMd6RTNIvHwhtusde/9uKGKumuXB
	MelyGXBfKyzctQ/h7SuMy5ypjIYLrnycgM9nEqwRsnLc1MCGW3nUrppWCBsH
X-Gm-Gg: ASbGnctQrkGuDoaby8IkoNMSnBcG8fArxEbTxAW3VFbPYwZOacesn2UvBUywkXA9GmH
	vNvDibLI8viJT1D1ZkukuRdG4rO2IRqUD9RZPL8mE4NkGEYLN8AEn0/yOnWcETmFYLMU8xTlV9+
	WPwO9SgRfM7iV+uIscKJKy4fcZjcnvw3UK4ljfKIJ+6TR0jtyVZkRRrXIzJs6l4v6+MOy+Lm1b1
	bq0LdFbVffn9DvsQ02CAAgmvZEYI+Q3QrhDe2n2ZdUhhPEo8TNxQM38+pvH0YeZCi+43B+fRbSI
	VUzUUvtxqrcs7vFrTAIRbxQPicwzuWAgnLc2iTxd2pvwikUAJA4J44EIIEE6c1rvHw==
X-Google-Smtp-Source: AGHT+IGwpduFtPkKQ4OrSV7h3HNDixSveBujenSDuPWq1h6GxYoT0pAkRXUen70BEshtR8NkwzSVlg==
X-Received: by 2002:a17:903:3c6f:b0:21f:564:80a4 with SMTP id d9443c01a7336-22c536053d2mr102112255ad.33.1745117714680;
        Sat, 19 Apr 2025 19:55:14 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50ecf362sm40568605ad.164.2025.04.19.19.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 19:55:14 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	johncai86@gmail.com,
	me@ttaylorr.com,
	ps@pks.im,
	shejialuo@gmail.com,
	phillip.wood123@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/2] builtin/difftool: remove unnecessary if statement
Date: Sun, 20 Apr 2025 08:24:33 +0530
Message-ID: <20250420025501.183290-3-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250420025501.183290-1-usmanakinyemi202@gmail.com>
References: <20250420025501.183290-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since we already teach the `repo_config()` in "f29f1990b5
(config: teach repo_config to allow `repo` to be NULL, 2025-03-08)"
to allow `repo` to be NULL, no need to check if `repo` is NULL
before calling `repo_config()`.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/difftool.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 41cd00066c..c7348a1dca 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -750,8 +750,7 @@ int cmd_difftool(int argc,
 	};
 	struct child_process child = CHILD_PROCESS_INIT;
 
-	if (repo)
-		repo_config(repo, difftool_config, &dt_options);
+	repo_config(repo, difftool_config, &dt_options);
 	dt_options.symlinks = dt_options.has_symlinks;
 
 	argc = parse_options(argc, argv, prefix, builtin_difftool_options,
-- 
2.49.0

