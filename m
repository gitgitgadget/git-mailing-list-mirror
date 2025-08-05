Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D33A11712
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 05:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754371882; cv=none; b=RWxSu71Pbzy2pT0b6oNHi7TI/6feS6Xx1bdVFoG29KjzYe925adwF6g0Cq0kzSCkAHUGTnIEV/jmNYwLyjKl9yQr0+yVCmeCKap30O8prjTONFV6myAJAZOfdHzadEtTWHCdlIrjlYKxVqQdjOwq0k9FlKfdB4Gt6ytBKpWlUwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754371882; c=relaxed/simple;
	bh=uq5V3wAN0+eOSVD2FqoUFjshmhWMabYaBJp4I3dSTA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQZJB2vXFdBgd7cb08alOPBGndoDY/16rwBzzq0zskBqs7QrZ5UGCVqCxVk4IEd2kckAHpHXrhnoJVWE/OgbNglAh6nm2EJ8JLhYw/kcyW4pEEPDPCeD0hN1bv6QBIpTv8Vi6gk09mdr0mCE0oFIEI1pdNi+N23/MMpolcg7J7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TO+rvvDM; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TO+rvvDM"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b3510c22173so569960a12.0
        for <git@vger.kernel.org>; Mon, 04 Aug 2025 22:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754371879; x=1754976679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V8WaEOJec7558a87ThT1X9+BxsAQNDa2c71d6cajGSU=;
        b=TO+rvvDMWRVZWpmgA4R60APrnKqE/itg9cnEx9uNb+2Z/hSsGeyg7jgSYDMwm4PzxZ
         /4URcP3KRfQUvy3kUtroRh+JAiOr08cj1MMRi0jEWs2axB8dyxPJg2azih2/+JjK1lOa
         +3R4jVWyDDWbix+qi5yA2F1MoE+Dlj/BjUgw7GfgQy0crSfj5LTQ+yjK0H8RiEYBxLOu
         LQjlfqkYJrkatu07z//LDfQotrgT8AVNBEN0SZWx1V4clCUj1VjqUKRfHyh5G6FGUsG5
         00LzL6kmvNto0Yn0+TGDbM601H7GiwYpD98+EEXw7Ti5P6kMvrIqyItM+qDavsWEymTt
         yzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754371879; x=1754976679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8WaEOJec7558a87ThT1X9+BxsAQNDa2c71d6cajGSU=;
        b=Yp9hcNAJDNRB2sTAJ4nQVUe7zHks/TUn2CvW+t4vYxH/bGlM6terAaHZzZA3D/7KII
         yHUrzkEoRg8mJ69VpBYkVn+JQBkhqj+cJahICbYgGwtIUpEWZV7Y2AvVTAPcb/z2UQPA
         /hkHpO15V3V/AHHBXOkRUzUUHU4TGPinq+V4L2Uyospe9Wg6o+tyDQ5kSl9dXKSwICuu
         bWqg1fmZnkrELIE0dgVb8yUjU057prtsPi2+g8QFar1pSoEEqP1WMhKa/KV6+vZ64hos
         Db+vWUSBsdcefXhOtwU9JLXr4jSrScoyP2tlsIbTOa4eeWT12+sB6dy5khQ6xsdvWox9
         AIQg==
X-Gm-Message-State: AOJu0Yzug2KcGqZ1xLm/3NboAVXPPwY6JvzF6p+atbVmeg4EKz8N87DQ
	1pkob0scJ3iVxQoDxvbELA5e7x6D6ORkbqo60QpzNpZl75Oy8e0+DDcpy7OktQ==
X-Gm-Gg: ASbGncvC20LBO8fh1m2mghzrJ3jxhvQ/yPafOk2uciPZVE0/uVCXilSQaNoARYJDWwz
	GLGVViJhAGNY7OMAGd3WsWASJ7MWETkqJqTG1KHZRvIS65fmUbUnMwONQXb+IHbdz7cmO/hfvgD
	xK6raUaWx74DbZBUJvQkzry2d54pu1kPzS394pCa3cZnkDJIw+66pBIQ4h1rd+PHvP8vkPhWbIh
	KgylHqj3/9Q4mbbZg71kfOz7Qpq6BJPlzeQIBqFxrCVc3bN47deRm6dJfOvAmy4fjCgDSFlNt7Q
	y0sS/Db8+jVB5hiB1tDyuSmcFedgtrgQGX0Db10S1ypFBZ+14zUU4mUnUdUabhbHnoNjlPVix44
	SJk7Mt+5Gpbm5lwMyxx3lylMtghGQuA==
X-Google-Smtp-Source: AGHT+IG1IZ3FkHMET1y5PdlEENcKcDtenUVgFFRxyV10V6xfhkN5u/En+GR7wjiFGEBgKph1o6R4iw==
X-Received: by 2002:a05:6a00:2ea2:b0:76b:d7a4:a327 with SMTP id d2e1a72fcca58-76bec4b022cmr6322042b3a.6.1754371879130;
        Mon, 04 Aug 2025 22:31:19 -0700 (PDT)
Received: from generichostname ([2601:645:8300:3b10:e54:15ff:fe8e:caa6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccead450sm11938537b3a.54.2025.08.04.22.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 22:31:18 -0700 (PDT)
Date: Mon, 4 Aug 2025 22:31:16 -0700
From: Denton Liu <liu.denton@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 2/2] t/unit-tests/clar: fix -Wmaybe-uninitialized with -Og
Message-ID: <8ed0ac14092e7ec979e53d2a3da84dfe884d6b3f.1754371650.git.liu.denton@gmail.com>
References: <d03308e9474f5e26fd4a5494ec243a278e971443.1754302009.git.liu.denton@gmail.com>
 <cover.1754371649.git.liu.denton@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1754371649.git.liu.denton@gmail.com>

When building with -Og on gcc 15.1.1, the build produces a warning. In
practice, though, this cannot be hit because `exact` acts as a guard and
that variable can only be set after `matchlen` is already initialized

Assign a default value to `matchlen` so that the warning is silenced.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/unit-tests/clar/clar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/unit-tests/clar/clar.c b/t/unit-tests/clar/clar.c
index d54e455367..03a3aa8e87 100644
--- a/t/unit-tests/clar/clar.c
+++ b/t/unit-tests/clar/clar.c
@@ -350,7 +350,7 @@ static void
 clar_run_suite(const struct clar_suite *suite, const char *filter)
 {
 	const struct clar_func *test = suite->tests;
-	size_t i, matchlen;
+	size_t i, matchlen = 0;
 	struct clar_report *report;
 	int exact = 0;
 
-- 
2.50.1

