Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AA685C73
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 22:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710972309; cv=none; b=Mutg+oCKcz9KFruNIbNqVGXYxGErBXBJoYLQwaNPQ6fvPEUvkuKV9P4VYySThEiNSsvSEMXhELEy9OGqvN7jpOpA2DuXy05s18lqlCNRZWnrb7WXR99NG7kKQwKmOISDTg6R91T+Eh3OJrgjfe8TCveWe04Rx/vZIrnsTrTxVOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710972309; c=relaxed/simple;
	bh=QkihwEgs8ZxBmvY0MTBlZKV2ht4WRSE9MdXgxVLNeQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqL5F95aYW20B5/gVCaLI8elax6zmH+YAq38MJ0kqj0Qa/bTSXihWJsiBcwBFVMDBcDrDRpurwHYzVr6s9Zsgm8FZc440LK4C9Wf27hzAoSzZ2SlsomPGFarRiCqTeVCFaiiGV0bYLJPwJRQrMl2yuX+/ag0sDxGAdHD1JfkyOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=lhRGM+fl; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="lhRGM+fl"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-42a029c8e76so2462841cf.2
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 15:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1710972306; x=1711577106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EKGCWjpo/g6qCHA4QqC1LIycna/MfsD0TEekx5Y1Hkk=;
        b=lhRGM+flYOJqh3EZcu1ePg1n7/IQbvY/aC6Z/U/l1JGp7ocGFJawHK3n7NS1UY+Taa
         Ri3VzY1NqLByAiHgUZgtupCAdzvsNhZxapxHPebmmajRbSl5+Ofn3VDfT0B33InALwLY
         W0SvCQbWg6pctbJwC+QAocoWJ+Zenam+wm9nMv5p+59Iyr/KWZTNvhbp7mtAq4PViPU/
         hqCQE9wyOFhxiB+APekaGKtqt4cZVmjrL+CkuDfvSlxspcJZdv2hVeXFehwBhEJVl2eF
         3cLBtK1Bt8Lb/SpCE4JZ/bFlFPUMgCPqXZY7u/SgJc7wL1BZCtFSDa7WkWjx5YgigAMa
         qOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710972306; x=1711577106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKGCWjpo/g6qCHA4QqC1LIycna/MfsD0TEekx5Y1Hkk=;
        b=B+YAvP2ZaLuhHvvGbi2eyxW6s0E7kuGBiHezqotzK/f1gzsPY1z8NG+6sdyzA8tdWu
         WXZdiTetinyFvcnON2UfyzI/zh55raAaAU9jNmi9anegstE5j4lZSiOi48S9FjIqFIdv
         WAr+hNFOvNWnMUuVDDj9aLmTOOrP6gjdpTdzOyirdA5eZRPpgTDlgks9HRY63Z4uWzfP
         FX3kTrOGh6rUbMWba4zA3piY5HUP/qMUsk/uvp3FDXqrKAYSX4PiI59neiC6AAiYeDeY
         +ia6xnWCJFyKIs46KVSgS9P7vgAFXND9Z2bwlRc/vHV2Af5n4QnEXagxhzZ4MswsFFC4
         KMSg==
X-Gm-Message-State: AOJu0Yy/mRKhJ6NoM7CYAh1jpUW82fQh3Q2d6tdfFigf77SjwmJuBhIS
	DQU7RSa3TAREJVOvzZQEKVaHxarGZv9xjgLYz2+A02PTHWUzT0JnhsR7eC+HNtqVPFn52knMOkQ
	2DNo=
X-Google-Smtp-Source: AGHT+IE5ns+ZgMoADw/B6WIxqzBshohNnUojVuuwOc98Nvqhf7kja1e+s6nmkRtH2y6JYyN6rUFuCw==
X-Received: by 2002:a05:622a:11d2:b0:430:e8cc:7e0 with SMTP id n18-20020a05622a11d200b00430e8cc07e0mr6713346qtk.27.1710972306496;
        Wed, 20 Mar 2024 15:05:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id fp41-20020a05622a50a900b0042f3fa77602sm7923687qtb.2.2024.03.20.15.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 15:05:06 -0700 (PDT)
Date: Wed, 20 Mar 2024 18:05:05 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 02/24] config: repo_config_get_expiry()
Message-ID: <21d8f9dc2b4ddc8ac3f4e8f6b21bfb762fc6ab77.1710972293.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1710972293.git.me@ttaylorr.com>

Callers interested in parsing an approxidate from configuration
currently make use of the `git_config_get_expiry()` function via the
standard `git_config()` callback.

Introduce a `repo_config_get_expiry()` variant in the style of functions
introduced by 3b256228a6 (config: read config from a repository object,
2017-06-22) to read a single value without requiring the git_config()
callback-style approach.

This new function is similar to the existing implementation in
`git_config_get_expiry()`, however it differs in that it fills out a
`timestamp_t` value through a pointer, instead of merely checking and
discarding the result (and returning it as a string).

This function will gain its first caller in a subsequent commit to parse
a "threshold" parameter for excluding too-recent commits from
pseudo-merge groups.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 config.c | 18 ++++++++++++++++++
 config.h |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/config.c b/config.c
index 3cfeb3d8bd9..8512da92273 100644
--- a/config.c
+++ b/config.c
@@ -2627,6 +2627,24 @@ int repo_config_get_pathname(struct repository *repo,
 	return ret;
 }
 
+int repo_config_get_expiry(struct repository *repo,
+			   const char *key, const char **dest)
+{
+	int ret;
+
+	git_config_check_init(repo);
+
+	ret = repo_config_get_string(repo, key, (char **)dest);
+	if (ret)
+		return ret;
+	if (strcmp(*dest, "now")) {
+		timestamp_t now = approxidate("now");
+		if (approxidate(*dest) >= now)
+			git_die_config(key, _("Invalid %s: '%s'"), key, *dest);
+	}
+	return ret;
+}
+
 /* Read values into protected_config. */
 static void read_protected_config(void)
 {
diff --git a/config.h b/config.h
index 5dba984f770..619db01bc27 100644
--- a/config.h
+++ b/config.h
@@ -576,6 +576,8 @@ int repo_config_get_maybe_bool(struct repository *repo,
 			       const char *key, int *dest);
 int repo_config_get_pathname(struct repository *repo,
 			     const char *key, const char **dest);
+int repo_config_get_expiry(struct repository *repo,
+			   const char *key, const char **dest);
 
 /*
  * Functions for reading protected config. By definition, protected
-- 
2.44.0.303.g1dc5e5b124c

