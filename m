Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E816C483BF4
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 14:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786632979; cv=none; b=Indmx138BTrF552OumJ2I4BCgq+Bsm3RLcQ4E5zPeLCA7sIhw0gE/ljRDtOcWvZWB1JHyckt7OyAj7OivOnewzBQmw93X/mHPfS/FCnzstqErsQIdWot40Klw4lRnGY85wAvbKYmY1xlky8rM/CD7KW9++NWVBG14v6SX9/JpIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786632979; c=relaxed/simple;
	bh=nQoo89Tuvwiq0Wf4memVLPmGl5DPelWekXA5nOU5DMc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oFjWTMNKAjJ15WpTcq2d0/to83IScD88T00FAq82jF6usUeod6ajurH5fQ4VdsEfblbSuI6luxVhsDNBq7RKco7g0K9ra2+sZlsQa1Xg0BNvEQ1oJQb20K6TMzFmqhH0GTPWlWSySkFa0JJaP2sFupzG60MlgN1aVAI7ftJo9yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbUJlW0K; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbUJlW0K"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7ec3b429a3aso255a34.1
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 07:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786632969; x=1787237769; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BNUGlZqmC3UwAswP7RqQWAaSYO8d9oo4yqjiXiRq1V4=;
        b=kbUJlW0KuTTBeq/Zy7Df2rAJrRhynN9pbRpbeqLOWRQldzkMpDyKyKsHPMNX/fGtDw
         pD7DjLiXfuoK9hTnqgs7tX3QktoBd7mc9OrcxRL6YtHgzpjZ50V9wMRmM1fnlUfDfFWl
         bImbOw4xmRn7nI1Xkx7IaftdytutMdAs4+9+XwT7KrKOGYENrND18m+3zyFdTGO5ff+n
         GYH2BN+XBIuL9AjcwvuFDTgUX0x5VeK/gBhpQqnl8WhUKaJFniqOzKQjxy7FrAQqSSSA
         26YMwGgp2iHWdiT7xoD0jeVaDdspPBVF/MrbZIFB8DqkPWjhab4R+AqezpwkH4LNS90E
         HlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786632969; x=1787237769;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BNUGlZqmC3UwAswP7RqQWAaSYO8d9oo4yqjiXiRq1V4=;
        b=moVGjfEbFitzCviGoPducPs9qBQvVYXIDQQAp1hoXDSVb5kBqJ5V0hszpQDb0ic+Tl
         guNvRw8W3ORBkGdgUTtmIOPH5enuV6jc3CJ4QGSkhlxhNBbyzqfMk1OtNfR0jIEG6hLn
         ajCqxb1YslmeUALO5ANvxPZqzcKoGXUpjtHfs6GFzpjP40QeJWToWynmj7lD2gsKn4Rg
         xVHlQ5AyRpjJZFDzsQPHIorac/J6tO/XVIIYxWpZ2/db9UThpEi8duPtWKf8wg13aRgI
         e3ClpbtuBXCGwM+4RYVrJLfFyqV8XES60Y7zPMTB1xVUJM8TpIVd+EU0JnV41QDW1UqO
         rMyg==
X-Gm-Message-State: AOJu0YySC2j11aiPTbBGo5zvSAePH6MRXLnK6lkC1qu44FSkZ9Hcqyla
	s6Kaos8rRlhF5+4oX4sYoviQZMZyEGHyI+0oFClcXcd9sqAQNW6Pe2fgB91Ejw==
X-Gm-Gg: AR+sD11WcA+Rp1TwokQOlU902tX64ubU1JGNnKj97lcQRVVcvMBipwBHPba+HHh/tOU
	AZcCxF+3L1V20akX4Q+W8zF193qlM1WIpTDRMA8nqyqwBDgGMq2vHGkIZxXLdTRdiI/s9Rh8Ypg
	Cg696V2Wuob1YEepgLIGvHxKYJzqOWyYPZghW/qYS2J8hPkOeDnpVUWEshksGKPlpAxgGBnJLJL
	d8zCd7NMw3lvr9O90IZeByHSV7tBNB4J9cIPBv5p8cX8NmKhEiSh6xVjfYTvteXGt5N4QIWY/wF
	5Bj/iQA7xp+xJ0deEKqnHzX8m+cgbKtES8aX3d/T3vMxsdT9wrvZL3g2t/tu4lDY9NfUK9rubXY
	1ZXCN0sjtwV2ptxLX0fzrZD0w2S5WdAPe9dl5yvTk0oY+ADWjikZiwPf9aR3BIUQS28a27oKEL7
	eupdf/Y8XMD4zvxFNoUrHWNbbZFvn3Adoko5NsAeMFaZKGgEvvr3f8CUWy6qvsPrStglLdwt4w6
	to=
X-Received: by 2002:a05:6830:3789:b0:7dc:d967:63de with SMTP id 46e09a7af769-7f3ca540566mr5949198a34.3.1786632969089;
        Thu, 13 Aug 2026 07:56:09 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.160.250])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f3c9cf3b0csm2431377a34.21.2026.08.13.07.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 07:56:08 -0700 (PDT)
Message-Id: <c91b4d7a7e35f48c4b2094614d2c07ccd152ce77.1786632952.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2175.v3.git.1786632952.gitgitgadget@gmail.com>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
	<pull.2175.v3.git.1786632952.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Aug 2026 14:55:48 +0000
Subject: [PATCH v3 10/13] http-push: widen `start_put()`'s size local from
 `ssize_t` to `size_t`
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The local is initialised from `git_deflate_bound()` (an unsigned upper
bound on the deflated output, never negative) and used in exactly three
places: the initialising assignment, `strbuf_grow(buf, size)` whose
parameter is already `size_t`, and `stream.avail_out` which became
`size_t` in the prior commit. There is no comparison against zero or a
negative value, no subtraction, no arithmetic that depends on
signedness, and no path that would assign a signed quantity to it.

The original `ssize_t` was the wrong type to begin with: a
`git_deflate_bound()` result above `SSIZE_MAX` would have wrapped
negative on assignment and then implicitly re-extended to a huge
`size_t` at `strbuf_grow()`/`stream.avail_out`, requesting an absurd
allocation. That is not a real-world concern for the object sizes
http-push pushes today, but it is also the reason the type needs to move
to `size_t` before `git_deflate_bound()` itself is widened.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 http-push.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/http-push.c b/http-push.c
index 3c23cbba27..2a07d14259 100644
--- a/http-push.c
+++ b/http-push.c
@@ -367,7 +367,7 @@ static void start_put(struct transfer_request *request)
 	void *unpacked;
 	size_t len;
 	int hdrlen;
-	ssize_t size;
+	size_t size;
 	git_zstream stream;
 	struct repo_config_values *cfg = repo_config_values(the_repository);
 
-- 
gitgitgadget

