Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ED2DDD4
	for <git@vger.kernel.org>; Sun, 21 Apr 2024 10:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713695331; cv=none; b=f2zVnCD0lEqnHsLHVB7hNpCYaQPVkXP6XHaS1a+KLT7Gwbo3mlDWCUTElA3jS+skCw9HJ+UBftwvpr4hyt41fWmbuJSd/uvhh4nGXkSPfAnZeF00tDO1YFwlgq2bvXuGopo4Xbn8v+I4PjYxPm1iwdxBkCRigTDLEiWSIAi3EcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713695331; c=relaxed/simple;
	bh=/gQhFJmvBecJiEHHnRohfuX0TfWh9XSRA8Eo/fgezN8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=GNlKkoKfgmhiB1vR1QCTOrGHFYIhSHTqwzTZ+PnoR6APMoM+bpNFCI/CuFAQm4Ma+jnaS6ViRdZWgvaHD5p+9B+YMwkE0HM1bcsOWNe4Ytrv38WULE1wo7HoCJBbuGx2Y7QZYPAKANDul7AhwH+RVgf5Yd9yD0EY/gVf28UNXM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNJIJttV; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNJIJttV"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2dd717d3753so1843111fa.2
        for <git@vger.kernel.org>; Sun, 21 Apr 2024 03:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713695328; x=1714300128; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5bSz4nfukv3yJQSA8/NeQrL/gRpdK/EDEQMvpaCDGzo=;
        b=lNJIJttVB4txKlhgSEc9fTamOFu1kOJPOQY5oiP1tLtQkwb8AkUvxma8HUzfP2KAgG
         AweO3UcCKFcILjB0PirV0LmNiW0J95UJwrI6w1fzXOTibT5H9txMAy/jDrNxmCQCIid6
         TgkPvmDrDQEW4kUOiGswPModrvZIJFgkJvNNKWHnr418zP2Lh2DdJENcVud9/4ved/tQ
         5kuCmm/+QPy2V0SV5mwsvpJfzo1lv9uZz6w1Bn+SIFsPuSC4oV/+/Xg4+7yw8LPqswkV
         5KQtAkVsJ+39NRmZL3jy5llL4BbfFEp8vPnP6ipUBmqNrCuuDEDMVvuTuTozNOh069wg
         WhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713695328; x=1714300128;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5bSz4nfukv3yJQSA8/NeQrL/gRpdK/EDEQMvpaCDGzo=;
        b=jHcm+aMBM7X0PexMWy5dvKwYNYofwDj5eM8lEaji2AO/D2Ec40KqG3eLmVUTD67ukV
         EnLfVuG9+w8y0fay34yXoc/oWgQaHyDJpr0FJ/280vTOLySAJqmOiv8jG+GPC5GusUAg
         FJLUF9l+57aP8AfwmWJBsf8qNvLdYgAF27kTYxhWGAUojsyHLtPUqsPZLih5pWl7piDV
         tsvVbO9wn4K+PIRjpH1tXzQcRjm/M6DfsioyzeLVp5Z0YQ8j0l6wTLsKIyT/3YtNKcUB
         SNPp3xkf79Za6OJKpk/L1JQUDkkRPaiyPFEoAWkHDLUOW3p4CHifep8k86ZBKPAgSbMO
         2WVA==
X-Gm-Message-State: AOJu0Yx0zbWZSWox6fsI0gjxIIOOI5v1XD8Q1v4oE9Feu+2fvoZihW4x
	6+rOx3CJCrj6MN1Aof6RC8lsKAL54jMACMtnpkaWCUEGZ4hTX3cchagz5g==
X-Google-Smtp-Source: AGHT+IFXJCI25ffUQrj1dM/RJQnq+Ybk53aszil771PeWbDsqfrCI4P7Y9xY5ew0hrJwnSYKT6OgDQ==
X-Received: by 2002:a2e:9e03:0:b0:2d8:d8b5:73c7 with SMTP id e3-20020a2e9e03000000b002d8d8b573c7mr3899002ljk.23.1713695327733;
        Sun, 21 Apr 2024 03:28:47 -0700 (PDT)
Received: from gmail.com (145.red-88-13-173.dynamicip.rima-tde.net. [88.13.173.145])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c468600b00418accde252sm12942985wmo.30.2024.04.21.03.28.45
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 03:28:47 -0700 (PDT)
Message-ID: <506130db-63b2-4e83-8545-66a71c728693@gmail.com>
Date: Sun, 21 Apr 2024 12:28:41 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 3/4] add-patch: plug a leak handling the '/' command
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
References: <b7b2d0d2-245e-440f-a7cc-fa0df1ce73ad@gmail.com>
Content-Language: en-US
In-Reply-To: <b7b2d0d2-245e-440f-a7cc-fa0df1ce73ad@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Plug a leak we have since d6cf873340 (built-in add -p: implement the '/'
("search regex") command, 2019-12-13).

This leak can be triggered with:

    $ printf "A\n\nB\n" >file
    $ git add file && git commit -m file
    $ printf "AA\n\nBB\n" >file
    $ printf "s\n/ .\n" >lines
    $ git add -p <lines

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 add-patch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/add-patch.c b/add-patch.c
index a06dd18985..0997d4af73 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1646,6 +1646,7 @@ static int patch_update_file(struct add_p_state *s,
 				err(s, _("No hunk matches the given pattern"));
 				break;
 			}
+			regfree(&regex);
 			hunk_index = i;
 		} else if (s->answer.buf[0] == 's') {
 			size_t splittable_into = hunk->splittable_into;
-- 
2.45.0.rc0.4.g08f77eb516
