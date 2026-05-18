Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8294417DFE7
	for <git@vger.kernel.org>; Mon, 18 May 2026 20:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779135592; cv=none; b=IHC4aryPtMiZOWH6YoCCxq6zpL4lyZa+L7QHOstZV+bortK0/vUTvWTYNqbmbQWfM+CeOC7uhHutCE5neTsVS0VCo483A80KX4Zld6Vd4ITHgqx4rHy+MtZqXGqqOZa2WPX7rfLivWqaMf45HJe0HT7v1pMirRwGLUMTG1zgtbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779135592; c=relaxed/simple;
	bh=5+ySTkuI8wg/QytanpXtNpJOSsQt9+mBMYjm42eu/7k=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Y8KpN+r266T8MR1TKV1tzSUoG1xWxEHOCg8wpXliHXS56+xvCmwAHzFlyr6RcZ12cPbKbQs4TAXob7+uAKuWGgLjUWkTbtMT3E9DOrPCZRh/oCeqQGXDEM2Dskmbobgf7ugrZgWF99/xgsMqBnSyGH70XUdcz2dQpcTaBl+nHr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8wi8H3Z; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8wi8H3Z"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-6312b8f8e47so811225137.3
        for <git@vger.kernel.org>; Mon, 18 May 2026 13:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779135590; x=1779740390; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/06b9pEaf4r5ib8jf0Nze/J39T3YkneS803ccKdQwo=;
        b=c8wi8H3ZpPXGPeImRD+wgN5e5nbnHKjfAoXjR2Y1wpwWiSQb2o3HZSFvoVN5ppsmcM
         yOyiMFl7JD9cIPYtPLzP7gkRunZDbRjgQksymt9oSwkrKxiMllLur3Q1SkVbBKwuDV2U
         iy+4V+YC9tJMMgh6T5WWSjdBkUyuK95dQYpciAEyhRGQP0FWz2v1OgOIwee4ks9c4aGF
         0MG1bkKp821APszJrwNA1JEstRTSnX6l6oRdu19ybAvu2OYMq0296gU3v6Pj8Xn/wA3t
         n/Sz4bT7lOioNOyBCPl10yrlmlAfOrHY07cr33ZCHDEl5bMso221Jn8oJwDyVFQsnmRd
         1m5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779135590; x=1779740390;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H/06b9pEaf4r5ib8jf0Nze/J39T3YkneS803ccKdQwo=;
        b=X7wBxCrpGTr2MNEvnFCFPiIF0CCi9MPM5T6VPisYjnwnnvYyhSRSdy4uZ6Ug9BQ0op
         HQVvi8T9DC1gghfInp0lmRS9sB+sGtpsOFlzs+Iu5V7iXwi3tLZYeI1sJLW7fnBomrnX
         jaT4aOKaf2kXTcUNe7N3q08T6NyJ97s8Bzk4HQ54BxBslt4vCDVhuVug9Uv5JrNC7LIn
         l429ewsETkpbAaduh5Gsg8lMZdfZ7b6z7ibAezefCHgN6tsTnMnL77BFNo+7IJiQRajV
         2wAXKldd+Y598cDch1y0jLaDfcEwmqS8ApmOm1cYk3Yh3uZ0ceqDfwuVknWi7gTXVXbn
         DuBg==
X-Gm-Message-State: AOJu0Yxwm3tLo7T2XENYDwEr2A/dWFB01qLJqyvW/1YVWx0KPXBi/bMB
	WCMfIkiqyTE+Od7HETj4JMoAnvR4YYJ6TtaxRIqVcXmx1oJRDFzJ5eF8UXarUA==
X-Gm-Gg: Acq92OF0PoL71M2Wsb3DNbfUQJX4DvJFePUq+3qfCQvQVUy/ZWkaMqiE4f64GMuH86p
	+Yb6tdAYJ+hPqP1y+fZJyxu2UKGnQr2zh0iMnv9mBOglGEWeeS/7/9jzMBX/N1rDmCYcDolLhk7
	S7sX6Nc0oNwOziw1PZBcTZMGIef7T+D/fJBNDnvgGBTDqUcIcOlrbXnpiT3HOQ+5+FMEadPYR0m
	nf9E/1KaoLqtr5dOF/3nwJlSlRunC5gFg1hyVyEJEhOpKyzxJ0H0gvlMMl80pugeNuatCXHjv1Y
	B7BVhXWZBJa+QOqlWGU4VRnERlVSQqAAHub68IG8m8ZO/RRpieAYSodFiOoimFVDZVN2GbUHOQD
	9Obnu04TmVIlOR6EUmNe0TDsKAQWGNaK0ErBFD2sNsAF8phxK/GTeZAEfx3IX6J2qezYCrOHd/l
	4vf8Vwz6crZsbkR0EYoIrF2fmcIT2kyVy04bo=
X-Received: by 2002:a05:6102:800e:b0:634:92c:bdce with SMTP id ada2fe7eead31-63a3dc4948dmr8266349137.12.1779135578020;
        Mon, 18 May 2026 13:19:38 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.117.36])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516514e0b91sm131169911cf.15.2026.05.18.13.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 13:19:36 -0700 (PDT)
Message-Id: <538913a3271e98a5f6b3c543ae7585e9f4519d18.1779135575.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2085.v5.git.1779135575.gitgitgadget@gmail.com>
References: <pull.2085.v4.git.1778762495.gitgitgadget@gmail.com>
	<pull.2085.v5.git.1779135575.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 18 May 2026 20:19:27 +0000
Subject: [PATCH v5 1/8] t5516: fix test order flakiness
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
Cc: gitster@pobox.com,
    ps@pks.im,
    Matthew John Cheetham <mjcheetham@outlook.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The 'fetch follows tags by default' test sorts using 'sort -k 4', but
for-each-ref output only has 3 columns. This relies on sort treating records
with fewer fields as having an empty fourth field, which may produce
unstable results depending on locale. This appears to be an accident added
in 3f763ddf28 (fetch: set remote/HEAD if it does not exist, 2024-11-22).

Use 'sort -k 3' to match the actual number of columns in the output.

Reviewed-by: Matthew John Cheetham <mcheetham@outlook.com>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/t5516-fetch-push.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 29e2f17608..ac8447f21e 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1349,7 +1349,7 @@ test_expect_success 'fetch follows tags by default' '
 		git for-each-ref >tmp1 &&
 		sed -n "p; s|refs/heads/main$|refs/remotes/origin/main|p" tmp1 |
 		sed -n "p; s|refs/heads/main$|refs/remotes/origin/HEAD|p"  |
-		sort -k 4 >../expect
+		sort -k 3 >../expect
 	) &&
 	test_when_finished "rm -rf dst" &&
 	git init dst &&
-- 
gitgitgadget

