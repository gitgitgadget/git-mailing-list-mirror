Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEDC1A2C0B
	for <git@vger.kernel.org>; Sun, 30 Nov 2025 20:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764532836; cv=none; b=AyPY9IUWtHdoPrZfjkaWBmSJKzhmRD2lTCLyvHmX1dzZ5ueNnnGfm46QsiZ3WQXNlxxV8GG6x1ZBy3Vq8itHxLzDuMlIkFmP9Grq6zjKePZK04yBB1gXCLX79gKFj9i4HPYbrfO5Or2GbGeZg42vaj3r2OMogFlBOfjpx/yPtBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764532836; c=relaxed/simple;
	bh=BX8P/g6pQ1Hx+/zaEXvBVT8y2Z4ltwcbWZl6ICRtQdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E8r51xcC9WIJLBmOhAn3XpTpTC6tDzyHLA7yPk41/iq5Tkom+Rn1G7T3W0m5JYBmRBbC+wkW2+OKOPfMvOSUONWNHh6ntv/M0a10uEIZmflcq/2NgsGdcTzFaKO2hnC5XoFe630VZtqpzyDtRThGZMGx0T/F9QRyhiM01Z2+10k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iaICBiof; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iaICBiof"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ed6882991aso28126001cf.1
        for <git@vger.kernel.org>; Sun, 30 Nov 2025 12:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764532832; x=1765137632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=krh91qmdEeyd6uQNl2YOrSoD29jduXVb6cQdwOcYZcg=;
        b=iaICBiofhyNYaqEpzLl+MCRhudZvD0qYjnPRCjDU7Gz9XENiQTb1fuatV2GsER8XhZ
         v3hvQQuuD1W0rJgNy/v9YMrFRR72TY0zgv7zVLv/4dJLe8qB2AKaUja6kkeQLhZf2wR1
         /wnm87J0LsdVIyGXl0O/ogA6XPYXBfFKPaAsxyJ8HVXi6I4UAAnvG1XIFtxOr9s/KYn7
         e0EQm+Z8m3WAXXVTwkjG+BEYm2xnrySOo478MEYSEPb3UQT1p4L4Neag2KgiMShH/p4J
         D6ePRdZncgyg9SdQooeGzr8O2eXAurTYa8RZBYSA32yUIIG2owD+PI8sJiLuBR0EDlBC
         1Brg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764532832; x=1765137632;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=krh91qmdEeyd6uQNl2YOrSoD29jduXVb6cQdwOcYZcg=;
        b=FY0xf216x0/5VGhgrxaz1egvvL9s0LK9VVsvPGwehmsf97j8C+4RKSjtAyS3VTWdPe
         pqG8Wl1DpOA+o4Fsd8J26W4mLRTm5+DCzXTi4japwiAdAd9MtefasoAo6WlFVvgz58Ig
         R+jkhimO5966ixnRCPlwZnP5DnxZWF4TjEV3pckXshoqrgvwLvyvz/iOAgyd0pFAlhZe
         N4WLS1wrXVOIoTJjoxDGjZJ1LuLmgFRtsl77bm+lUfENgAZiw9e6Ys+4XxQkhMFQxpYj
         kk2hPRSWlQaq3U6W8URaRX5mxhwtka1GYCQXzbSIsOlC+npgA4/ESEXdUfnACwRE8VVL
         /RjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwRFgtIZUWutWkc2d7NI3GmaNEvyZac41Uo0xeIGP1WQYN8K3HoWZlFL73pojbCQzlbMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSHYmpQzPXsBhOtKaZ7z3TtUVVlN3JekzO3G3Gyf/MCx+ZLbt3
	g5H+vNyiKSFstxBqLyDwqCAoPM9niGlDRCHxjLAasdP+EfTidvewel62
X-Gm-Gg: ASbGncsIAOG9kUpk4Tn0mjxLwR815uYFDl56C11uOlxfYGomRnBUcwgJzA2y9JSOHv/
	yAz3PGTR1dIo8D2FhBh6YR408wOcx+BeNxUrCfN5nYghQLXBKtTRIGB6OCe1Mpiho5haOuy1epP
	3/4sCX0DD3GUAUIAVDjjIQVZ0igKomYHGqagex6VhGIJV38CLnc0kGpqfNCiHebFuSYyU5/9nbL
	mWBKVGuhGjKp+BVoLBF3rs7DNLVtM965Fq4gHJnADFKVvk0tFDzxEA14mxCYhNPRL2rM7ERZxw/
	5cU/UZJwpbvQdMoxjdoGQGxdo3iF19YNVdn4xIYdrHgSRLazYemtkf5CsMPzjFh/EluQc4GSG+P
	+/4+KnnrIGzCkg/PvYUomPPQ4QFubqgiopT8IbZcurkwqAsFIPe0cbzs0i4diEHNPS+YgFvc6+a
	RWx4EkccRlRLhfa/N5czzX6Rdq8pwFCVdWglhxCuQBdtDj+bKg+f5vKnksGw==
X-Google-Smtp-Source: AGHT+IEvds6yjVjPf35hK2nHFpOJjSoxtwlpUapsxFtgfE+Nb1dxhkaLfr4iCUatfGX0V2WaBgDdsA==
X-Received: by 2002:a05:622a:1354:b0:4ee:bac:e3aa with SMTP id d75a77b69052e-4ee4b5bf500mr584718261cf.35.1764532832340;
        Sun, 30 Nov 2025 12:00:32 -0800 (PST)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4efd341f290sm61673251cf.21.2025.11.30.12.00.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 12:00:31 -0800 (PST)
Message-ID: <75f862a5-2663-4211-b96c-d2c5d1c6f91e@gmail.com>
Date: Sun, 30 Nov 2025 15:00:30 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] last-modified: support sparse checkouts
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>,
 Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.2013.git.1764423826908.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.2013.git.1764423826908.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/29/2025 8:43 AM, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> In a sparse checkout, a user might want to run `last-modified` on a
> directory outside the worktree.
> 
> And even in non-sparse checkouts, a user might need to run that command
> on a directory that does not exist in the worktree.
> 
> These use cases should be supported via the `--` separator between
> revision and file arguments, which is even advertised in the
> documentation. This patch fixes a tiny bug that prevents that from
> working.

>  	argc = parse_options(argc, argv, prefix, last_modified_options,
>  			     last_modified_usage,
> -			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT);
> +			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT |
> +			     PARSE_OPT_KEEP_DASHDASH);

I'm intrigued that this is the only fix that was required.

> +test_expect_success 'last-modified in sparse checkout' '
> +	test_when_finished "git sparse-checkout disable" &&
> +	git sparse-checkout set b &&
> +	check_last_modified -- a <<-\EOF

Would we expect this to work without the '--'? Should it
fail for a directory that exists at HEAD but is outside of
the sparse-checkout?

Thanks,
-Stolee

