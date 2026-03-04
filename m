Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5EF222585
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 21:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772658499; cv=none; b=FnlHugNGdTI5g0VST/PGKA1h1cJEcUa9PePPu7k9cTyvZtWE0yafZMJvaY10YE0bEfPyWeMQhlbbmVNrHYP/Sedwc75Bf12eXDG/shd/Hz7eLNQ5wF3PRQ/e90BbZjInyiQOPPzGljORznaIPM2t/PlGp7sXmNWFw/LhFP+FJMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772658499; c=relaxed/simple;
	bh=02s1VJqVQpTHuD+JbmN5sVqNPR9Qra15Z0FQKlaKexo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upkxb5NLbaQL64ulSBhB+ZA01YWWdPsegQ2STONzc0GH8n96EMzftBHTjECH8hBot/7bWNLAjtVHhEyTVsQQFGxvVG/ylgOxDQMDbSLBz2P3i7jkoEvl2TcN21c9519pf0Ge5BaxOt58RdbdXFncD5/2Zgj0cFORXisjKErupzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XiJTCuUl; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XiJTCuUl"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d18c654458so3558798a34.3
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 13:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772658498; x=1773263298; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cO6kAmCwLH/oamm+dIVkjA5nEJiRvukOnfyKaOhUu+0=;
        b=XiJTCuUljdFU1mXFhd2DD9AgktNApM2Lv5YIhqY9oD8gioIw38udq1y++Ye0Ad6Xsj
         a9V+un2i481UfpoGwBZ0HHu4AzdzhIp4V6uNcY3pi/wPHp1GzIPCW2PfCOQ4tlmFUoDP
         HDg3rj/pfEEoJVZpxcHAdJDAO5N+EskcG9fO4A6i7pGASFyiE4Yj4GmyKhiEHeROTjt7
         gZmfaJwJkMDgCDszfQJX36qxsv8ermzrUmMa8NRUNVISvb3B4WMarMSlWBPN6F97yRSN
         9CdCMZ6hBfIMtFc8MH0L0kobD/gaz5CZGQlzY+fm9U+AaEjD0PbGD5X2fQ6Oup+7VZzo
         3jkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772658498; x=1773263298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cO6kAmCwLH/oamm+dIVkjA5nEJiRvukOnfyKaOhUu+0=;
        b=lFcgVDK69SM0jaojE8+A3DZYY3MaK49QDb/18JzRNOndWGHYaqVXgZwgHuxA2UqebQ
         Mwo4h5Z6v9VyUsyEPPWNZtSFR5XvXJCJY9zXCIN7yBZVXdrrEVCFEEEMBsKxP7eAd2eh
         LUSYatjedfVkqONSLxcCxq1NXxcvTLM7dlUAbvf1zGN2YYYAuePCWu8lAzJ2smzch1Un
         9LJ+RMKPe5/6UHuUTujxvo1fgt+5EPFTs92sqSvWzaNruAJwtzk4SoavdJAHGawkHcx5
         Vt7MfrGbVr7KipcFKZEU6SOihGu2dTsY024SKo9hNAWvMwKowAu+Wk68WdNuqFYfnwmd
         z5lA==
X-Gm-Message-State: AOJu0YzdBv4aztDxbR6tyJirnGXqpXWVDHiGfdzHQMGdH2dvMj2c6RPT
	xxJv1jAM8/hXvgPjI+mUQ1WwkLoGOOUVVtWcrOCoQkbHehHHeM2Ne98igWyXvQ==
X-Gm-Gg: ATEYQzxapJ2EbeVTHhxTHvzUuazcklWVrEeJY09lvIV1X21w4fO6o/LV/MjyUtu+nU0
	d3ZmiEvnYoodAHyzeI4vMTE4Gmd0Vf/BHbJTC2RCCAZA566LgFco0lNuws3Bhtz3Pli0eOSm8Wp
	UXOQMpqZIZexemd/brwld+ngEC4XE5OZyBQ9SQ8AFhoT/kvGwzO27bHyZocBK/PKWCUmpGfZum7
	t8DfRk4GYihCgxg1eqsu1Y9Jh/ddy4NCIRbaDhuuiRZJUwrh3GalndNbNNKD+myZuRs+cVHxIg4
	ZepTPE+/6/Z45V13EssLuV8oXs1AL5TO8QSQ0YMIh+CyfDXvoYXrQ7r5eoKmcv9kFR0YJxyqECI
	sxzwPAnlpXKx8mFpa+WRLQH0Xx/ZYBQidU8whiQqu1ri2GC7EuMNgh883lqwSVuJ2Sm8xqZh/Ls
	UHEpQ4jBuuupZwU1HXohVetynLllI=
X-Received: by 2002:a05:6830:82a2:b0:7cf:e4e6:2cea with SMTP id 46e09a7af769-7d6d12595edmr1970777a34.15.1772658497736;
        Wed, 04 Mar 2026 13:08:17 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d58644edfbsm15908655a34.6.2026.03.04.13.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 13:08:17 -0800 (PST)
Date: Wed, 4 Mar 2026 15:08:16 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 07/17] odb/source: make `reprepare()` function pluggable
Message-ID: <aaiei2ZN37i0Xkf8@denethor>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
 <20260223-b4-pks-odb-source-pluggable-v1-7-253bac1db598@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-b4-pks-odb-source-pluggable-v1-7-253bac1db598@pks.im>

On 26/02/23 05:17PM, Patrick Steinhardt wrote:
> Introduce a new callback function in `struct odb_source` to make the
> function pluggable.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip]
> diff --git a/odb/source.h b/odb/source.h
> index f84da59ef0..2f8132f9e1 100644
> --- a/odb/source.h
> +++ b/odb/source.h
> @@ -58,6 +58,13 @@ struct odb_source {
>  	 * all associated resources. The function will never be called with a NULL pointer.
>  	 */
>  	void (*free)(struct odb_source *source);
> +
> +	/*
> +	 * This callback is expected to clear underlying caches of the object
> +	 * database source. The function is called when the repository has for
> +	 * example just been repacked so that new objects will become visible.
> +	 */
> +	void (*reprepare)(struct odb_source *source);

Naive question: does repreparing a source still make sense outside of
the "files" ODB source? I almost sounds like it should be an internal
detail of the source when reading objects.

-Justin
