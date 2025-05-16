Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA955254877
	for <git@vger.kernel.org>; Fri, 16 May 2025 18:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747419155; cv=none; b=aQktdfmz1nouw9DTA08x1a//X6P2vjHMEsDthIq0L5QNz9GYHsNQLufX0TIjzsVNpbyLulhrTwzcFSOD+j665K48ieKHBduW8vaFM24RIWH9nlkTKuxJKCpNBtSqmx/22fzHdEihzePeus5N0ap5WfoV6oi/dI439hQqlbOMLKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747419155; c=relaxed/simple;
	bh=vOA0TsvZ9+cPyL3Kb0KEXjwxDI18WQ26br/MZVMJoLY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RvCZswURNTrwnaF4Bd+npLrV5vAw/kCZeeeB+zeeMTAUX+GcO96HUhoxFK89OLyZ8ADkM4+SOv8kxbkxdhyBQshRhlokkD0uE0URyJbCacUbmeR0O7ZFDQ9Q9Vy7K0lnTJVqQcTzBls+0wVfzoGJ6fNv5xjbyUjZZuRz9t3zpFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3yIvOL1; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3yIvOL1"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cf680d351so20648825e9.0
        for <git@vger.kernel.org>; Fri, 16 May 2025 11:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747419151; x=1748023951; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1uUDjlVSRmntj35/FT4pJrexvomUU26SHI79M9fwGI=;
        b=Q3yIvOL1Var1IsO+06BxUI7DgiWWxL8075tk9GeybguFZ0hHT2NDH8N2a+xLveM3Ua
         DNrqqz2uzIfc35wbtoEGea4XxxJ5Ipn2WXjq1cVaKKscmiGleqoUwl4tSGZbCzgAriAk
         kal0cUWZ1pYzRLfgLW93uuxDatRFLk+WNGqwWDAumBpyPhWrvrKnDBRznHYNGbta+KUf
         He68k93JHwydh/vwo84JpZsgJSxtkh+xqfn9pRjVTYu3BausPKwf187miiXpOOusTHL4
         0hMtS8t1o9DRwLsm4xvVcY0StxrB+xVxy/zZqLGbNGhcUpCX92BQwhEPeKkst8PXKUUd
         7nYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747419151; x=1748023951;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m1uUDjlVSRmntj35/FT4pJrexvomUU26SHI79M9fwGI=;
        b=JaPYK1EJSmXn4T0CS7/idba1SlNNPQcP0geRQbE9ZRohz6kMIG9NWIZCz8TDc22YUz
         hoTXV2P1qMR8eMWE1BQSRhS8nVR9RAo2/EUlJLQaI4YLWgZ/Bzd3Ml7m5XdBXM42lJik
         VpKmLIELg3jh81iZUcPhxEWOwPSNxYDxO4A1GNahaLPbMUL5ug49EZTg+Bwf2WeAKv3w
         AZqnubPcQf0OMrWMhWSLid+OXPdCmGoYeQvi8qQDUX5vrXwbhYsvHMRywct9AvF9z3wC
         yYxjPoPKYgjDB+rcdBuc2nXs/2j4jNSBO/J2Mx5/SBxhAk1XqYvpqAk6D4ABi60JoXtF
         GaJQ==
X-Gm-Message-State: AOJu0Yx0HnysoVR0Z+n+K6RlU7UV63neJ5nEvhYIEbuWIFvlqKqZjq6e
	WGHfoTjLSJaRdmDxnjreaYN4jDyHpHRWm81Ve3MHymnSDRP5C9GP5ZhVbGioAA==
X-Gm-Gg: ASbGncvNkUL1Lqo+CwtlM9FN5lHSBj+C9OXtzUVBGVC2rfUnEVU+fhpM1bvy1PEdpzg
	M6fOQYiHe0TjCavw1HhqrnlDzn08xbCPYqTnEzPfqZI5G3mcB8YXEvJOSj44/PbKDzBDeo1Zo3b
	BvgwqfZK8Zeq6I6TOYg3OllJCxsOVzzjpqcUIZm4FSOxwdXuX+aqAd9xtHUd/iqeIrDeGl5hrxe
	zR/iQYvbJuJ8z2mgwFJgqL+OktBWasmY12RnPSxgpSQ14u+bBhtf3pW644gSBvPMMck12EMBRDi
	ziVldK4j1ZEg+k+OGsdhE+t6ltVw8JU+tPgRtJnGyH9uwjPHngpn
X-Google-Smtp-Source: AGHT+IGfDDr/X6t8OVy82KhL45bxTYvR7iql5/tb3TeI4Y2C79fBW82I0IKiJv+wvPKMfWRgU4uGLw==
X-Received: by 2002:a05:600c:3c99:b0:43b:4829:8067 with SMTP id 5b1f17b1804b1-442f84cb4famr88184855e9.6.1747419151093;
        Fri, 16 May 2025 11:12:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f39e84d3sm121380485e9.32.2025.05.16.11.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 11:12:30 -0700 (PDT)
Message-Id: <8e1d141a1f87dcdfd967c239a68a864380f39d02.1747419124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1819.v3.git.1747419124.gitgitgadget@gmail.com>
References: <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
	<pull.1819.v3.git.1747419124.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 16 May 2025 18:11:59 +0000
Subject: [PATCH v3 09/13] scalar: enable path-walk during push via config
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
    jonathantanmy@google.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Repositories registered with Scalar are expected to be client-only
repositories that are rather large. This means that they are more likely to
be good candidates for using the --path-walk option when running 'git
pack-objects', especially under the hood of 'git push'. Enable this config
in Scalar repositories.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 scalar.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scalar.c b/scalar.c
index da42b4be0cc9..bf638fa34b80 100644
--- a/scalar.c
+++ b/scalar.c
@@ -170,6 +170,7 @@ static int set_recommended_config(int reconfigure)
 		{ "core.autoCRLF", "false" },
 		{ "core.safeCRLF", "false" },
 		{ "fetch.showForcedUpdates", "false" },
+		{ "pack.usePathWalk", "true" },
 		{ NULL, NULL },
 	};
 	int i;
-- 
gitgitgadget

