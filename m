Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C6318032
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 02:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712285547; cv=none; b=BWivr/CFiTv8JB4yWKLVsKtlOdkxSst9StdFz4zRpkfX0lfom/DNnl2j8S1gXinumv9A8fyebzH1de2ittbfVkOxaAkl9fnP8BrRh7LBupQnDnIFoy6TtJgvgIrTulWuhs0pJs9xtWjTqzOhyo9SunI3Ulxw1ffrWoQBcwff9b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712285547; c=relaxed/simple;
	bh=GoE+yoiiYSi5+G6/4U6mlbaaN8VM3qgEAAGKyarL43I=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=e/iESqP48s5LJH3FlzsxmKpm5Qr1Ur9n5n7yT87ZPGm9nc6Q94bfSl6Hd95AjvHwKKyCYe3dPktCwbeMDgMtjWRrLLc85fOCo5NAWmqJPsAKWUDsZL9yHipZZSNGCP2bcVgazyXEMJJDeLh3Yco0Yz14ZhhoLjC82lX6kD2KwD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMjYCoWN; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMjYCoWN"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-343d1003106so580966f8f.1
        for <git@vger.kernel.org>; Thu, 04 Apr 2024 19:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712285544; x=1712890344; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1kcJoZhN4uxRN25MwQzq4iSIdt0SgDPfw26VFBrIrDQ=;
        b=IMjYCoWNYK0mN6TYE9gRHUhM5zi5KxXZg1l6zI2oA+dOxMfoEQUzjCWk8egmvw3oxy
         9tv/dP9CE5HZu3QqAO9sMyykYYFHgqszgLfuIxd6eSkMdkQqWdqk27w/irwhVovl17TK
         OJVL6k5TVxSd2OgYVOInObN7UbX4xt2hG6xSr8MXZbljHOLJxYgtMy2YdXcNLZ5VdIDs
         FYRzrN5mKjCiFhPR3kbUXOyUmvBTkDXAZ2LusYV2g7L/KO/r6576RoCKL5a+cd5Eg8f7
         l/NDvWRYlzqx3wpOw3axDTbSpVTVKF6jYqzqNlmwPrzfnuw/nAwRKjoqIB3DpMY1e9/C
         alvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712285544; x=1712890344;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1kcJoZhN4uxRN25MwQzq4iSIdt0SgDPfw26VFBrIrDQ=;
        b=ZJnYQ95JpuCXEJBThC0SwNUz+UH6UlPFe4MpPOVt4FwV9s545N136qu32D4N3o6NEV
         k1m07N9wOeYdxyHIGHAcVkE/rAHqLg/8+TXASVrcuwVyN6MTENrfJya6RhsAGldGhmAT
         QrGbmjL3ZmVMz2fyKR7R49+BI/t1JMgTCrKKmc2vnARJMHQewfAEbbN/vuJzMIAn5R9A
         ADIGQJ37qLrYH/muYhs8d9CE1wXeOLPner0jTJvJaWhxDLCPatMn+Ht140pMJC6F2Tz5
         cPZGG4rqH0jvVCQltd4tvEIllncnN5tFiHJyNQPDMC+W2JpCQvMFp6J89JBH0VXaULO5
         OS7A==
X-Gm-Message-State: AOJu0Yw6mRY01YcfzE7DmI9dX1JIrM0zcNGtlsUJpNKoKBdyW1C4Er36
	eh5lQf03nz3ja37kkPrqqfPhUByCz6Vg98+P+jFjKDN736iYn09ZBA2KPQom
X-Google-Smtp-Source: AGHT+IHnLUVxcgALLORyHTp4Vh3SA29AlUcrB5inJ6ltqfCKzRpL/f/rc09hN1PgZph5I3Xq01L+8A==
X-Received: by 2002:adf:e541:0:b0:341:8412:a6e7 with SMTP id z1-20020adfe541000000b003418412a6e7mr174993wrm.18.1712285543714;
        Thu, 04 Apr 2024 19:52:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w18-20020a5d4b52000000b00343723c126asm809482wrs.48.2024.04.04.19.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 19:52:23 -0700 (PDT)
Message-Id: <pull.1709.git.1712285542303.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 05 Apr 2024 02:52:22 +0000
Subject: [PATCH] fetch: return when parsing submodule.recurse
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

When parsing config keys, the normal pattern is to return 0 after
completing the logic for a specific config key, since no other key will
match. One instance, for "submodule.recurse", was missing this case in
builtin/fetch.c.

This is a very minor change, and will have minimal impact to
performance. This particular block was edited recently in 56e8bb4fb4
(fetch: use `fetch_config` to store "fetch.recurseSubmodules" value,
2023-05-17), which led to some hesitation that perhaps this omission was
on purpose.

However, no later cases within git_fetch_config() will match the key if
equal to "submodule.recurse" and neither will any key matches within the
catch-all git_default_config().

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
    fetch: return when parsing submodule.recurse
    
    This is a super-nit that I noticed when looking into this config setting
    and couldn't help but try to fix.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1709%2Fderrickstolee%2Ffetch-config-parse-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1709/derrickstolee/fetch-config-parse-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1709

 builtin/fetch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 46a793411a4..5857d860dbf 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -138,6 +138,7 @@ static int git_fetch_config(const char *k, const char *v,
 		int r = git_config_bool(k, v) ?
 			RECURSE_SUBMODULES_ON : RECURSE_SUBMODULES_OFF;
 		fetch_config->recurse_submodules = r;
+		return 0;
 	}
 
 	if (!strcmp(k, "submodule.fetchjobs")) {

base-commit: 7774cfed6261ce2900c84e55906da708c711d601
-- 
gitgitgadget
