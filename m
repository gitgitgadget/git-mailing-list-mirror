Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E8C1BDA9A
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 19:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732130041; cv=none; b=TWpyjlots/9Vq0RPnahqLwEuKv6NLrNde53G1UeWihZus133qSka4sOiVFWbKJP1DxHKUvuj0W8iA49QXBzVeSqHZzJl5vw3hqJx317PTQkyoONGMJdGq+DC1HBnVReI9rNSjy3BcsabfI0AUZv/xDshYmFdVmvE6V0qAMllcC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732130041; c=relaxed/simple;
	bh=tT5h8GDADbe7S7URz5YCHmr4PCkBZykN39avR2JCIfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JeZoYFNypKwhhYJowWQDna7cYJieE/mUyG2n6ErLAkdSgzrhHeDu2/IDIlRGiTjGs1tNvOH3FTS16DHnyJ/cM9uOcZBeUvU8AJBLcgSzgYjPNZMS8lJLazx6LsvP4P6GvmjAfDZQ39KZ+SXm6urwW5ytu/z8vhzfi6l/vnsmK+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=H/LKO0B/; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="H/LKO0B/"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e388e1fd582so31568276.2
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 11:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732130038; x=1732734838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oV4d4QYvOcPmjHsN5KRpjrkaxyQj0TY3391mCEyLgJs=;
        b=H/LKO0B/urm0HgLZZLYKcrQ1P5EddNiXdU2phYi5KP8dvPN/tHu182zdlNC9eaqADP
         SHE5fKw19cmotYOvYpmwoNImgVsdKRDIFnnQB34v6/h/NHHqYKSn0cPchhV7vTGz6OO4
         hFE1xWjGBMHCmudo5d+YG5RRjjyajabyn9bs/HXZq0jqVvZGDpUiizL1p2XW8oiYZO/K
         GWoD5TEjUxc3nkHzJ+AThDEomcYe74wP5jWiVPjo+4YaITroBtk92goVzu23Xgc5acMv
         i/YgXSZ//3jUgc8F9sW6EeQ6KSz+TpneewlRgBjEHeZ2w4B2QxtWXzgauJXhvYQ7vcfr
         QdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732130038; x=1732734838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oV4d4QYvOcPmjHsN5KRpjrkaxyQj0TY3391mCEyLgJs=;
        b=AtIWVERxtqhzMsOAzZvBMfrF8Wcanvt6SA5swDUnhbYTNqTWAd4LUfAMVJ4HX7knNL
         SD+gtigDH+jC4WoXbX0Ry3P8axluIQa2T3e4pu6g7Es2L+agL0hm/jJeUKr8PntRY5tj
         derCiP1cM1UWfbMtHioKhiltsaRtEKp4M0t6Kw8ijqXAzA1dR8aKtIFlF/Pgx3+WO1wi
         Q+amxw++3E0+3vx/u0JpkVaZaxFvtET4BBzXVlwjOA9nGzTbu/4vj3FzgCR0+cuiQq5C
         YvnZjJ+5OlQ1oJ8T8So79MmoGvi9OFtQ0yOLxtiCUfnZjO2dYs7GqLXyLHIeVyB7KNl7
         mm/g==
X-Gm-Message-State: AOJu0Yz/BzqHhnLq3aGDm8/6p7mXoCs5VJnZ0a2NZ2eh8AOFFnBukqV2
	gqF5+HpiHHCTm0a5nQMOHA7TpwytdBqnYSMBtksbU/3SOUjyHqTAl+fPu/UReHrP+5NSXSZkni3
	z
X-Google-Smtp-Source: AGHT+IHiFacgyjhtg099gDWqK1T2yji+ezDPIpAId1Pyhp7jTPpkLSPw4NZoqI0FNytQ+QFt+eLQ/w==
X-Received: by 2002:a05:6902:278a:b0:e38:fbd:48db with SMTP id 3f1490d57ef6-e38cb58d48emr3377369276.29.1732130038208;
        Wed, 20 Nov 2024 11:13:58 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e387e753e11sm3307443276.23.2024.11.20.11.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 11:13:57 -0800 (PST)
Date: Wed, 20 Nov 2024 14:13:56 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 5/6] t/helper/test-hash.c: use unsafe_hash_algo()
Message-ID: <a49a41703e22f0c5d57fb59f6a00d95bc16bd245.1732130001.git.me@ttaylorr.com>
References: <cover.1732130001.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1732130001.git.me@ttaylorr.com>

Remove a series of conditionals within the shared cmd_hash_impl() helper
that powers the 'sha1' and 'sha1-unsafe' helpers.

Instead, replace them with a single conditional that transforms the
specified hash algorithm into its unsafe variant. Then all subsequent
calls can directly use whatever function it wants to call without having
to decide between the safe and unsafe variants.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/helper/test-hash.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/t/helper/test-hash.c b/t/helper/test-hash.c
index d0ee668df95..aa82638c621 100644
--- a/t/helper/test-hash.c
+++ b/t/helper/test-hash.c
@@ -9,6 +9,8 @@ int cmd_hash_impl(int ac, const char **av, int algo, int unsafe)
 	int binary = 0;
 	char *buffer;
 	const struct git_hash_algo *algop = &hash_algos[algo];
+	if (unsafe)
+		algop = unsafe_hash_algo(algop);
 
 	if (ac == 2) {
 		if (!strcmp(av[1], "-b"))
@@ -27,10 +29,7 @@ int cmd_hash_impl(int ac, const char **av, int algo, int unsafe)
 			die("OOPS");
 	}
 
-	if (unsafe)
-		algop->unsafe_init_fn(&ctx);
-	else
-		algop->init_fn(&ctx);
+	algop->init_fn(&ctx);
 
 	while (1) {
 		ssize_t sz, this_sz;
@@ -49,15 +48,9 @@ int cmd_hash_impl(int ac, const char **av, int algo, int unsafe)
 		}
 		if (this_sz == 0)
 			break;
-		if (unsafe)
-			algop->unsafe_update_fn(&ctx, buffer, this_sz);
-		else
-			algop->update_fn(&ctx, buffer, this_sz);
+		algop->update_fn(&ctx, buffer, this_sz);
 	}
-	if (unsafe)
-		algop->unsafe_final_fn(hash, &ctx);
-	else
-		algop->final_fn(hash, &ctx);
+	algop->final_fn(hash, &ctx);
 
 	if (binary)
 		fwrite(hash, 1, algop->rawsz, stdout);
-- 
2.47.0.237.gc601277f4c4

