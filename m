Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792EC23CB
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 00:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742343239; cv=none; b=tENPoauS/VRUvV6I5GGMPujU0Df/Pq0RwK5+RT4icql2jAyEFMDSLlcSz1g+p9G5HuwDnfjHKFNcDJB1iMQpVTDysVUyQ8f+v7nGLASF8PmRI4l5DWBnAgL0dAZlLAwN72khIE2K/zWoasNk86EPyw/U2rTxjwANEV8VJFI/8jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742343239; c=relaxed/simple;
	bh=1uc8lU7M5W7JebksnNJ0NYzjV2fNaxZTT8+z8KgBjRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=daLOFkKoVcug2lHPZPEoP2pqjT/eI4XMuYdPsgSh+Q+1dA+fzbzg2FAhRgELPOjra53aNw6FoqP+1FCqyaa2WmcMwvXyELYJLmf7MnYQyxe2SafXUJwza9i9hHP3nDMRG9FnNDgUVhYp0mzw78mZsfd2Q2s3hPu8LYwMr40dwRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=mXaL8Jae; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="mXaL8Jae"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-476f4e9cf92so18677131cf.3
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 17:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742343235; x=1742948035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7uESDTrePwZu6BBpM/wiaKjopRGVPTiCEbpl/2oBI6Q=;
        b=mXaL8JaeZ+BHgJmCBFTBOz11XYQCPiNM5sULspSC+lEnzfjbP+UuvUhpNefLud4dDO
         HrsQFalCxW5wZvo6VWfnx9dO6K/7ecTXsYPOtDQ5FfsszE3ez72gr/4rH1iDaf/O7Zz0
         apEkwEnhZBcLqD77vcu6oif2E6JfFsdSFQ29G3PjnrR+d4MrOXeITaK/moAFVh6bkxXq
         C6eSryiB2JbQVnQrPMK+DNQmhhu/5pXtLdwVk0ovZenpuoJCIrPfgrd1fpjUzULxYaNb
         4x/pHCaAHFtE9yn5eyZ+ffSoRop6HYI6rf9jZHSHXbPAdO7s6fpQwx0eX7WmXgG1UhaR
         JY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742343235; x=1742948035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7uESDTrePwZu6BBpM/wiaKjopRGVPTiCEbpl/2oBI6Q=;
        b=ICX5UkzN7wQTpxpWwVUY+6XI11wdSOQ0fb0EyCNUfCC6RH9T9vkALhHl2b2+ziMBZG
         r32UDF+wDWVugyML10D7uAsED0rR+PDts7GlG28JLZAbfKVpb0ByvxK7n/vMbskTsw73
         2AM+DE4N5sqVrA9D7zI8A/+KKOYkHZlh/rPomAWtvj3DKZA8vLECTdSLgsfkwLnmlBNk
         wcQ4CHcbe4XRvJau4Ubh4RjJq4Qz3jS/8uefdDUOokb6CypPxCgdJMkmTlfa2E+ZYGRQ
         z0Hy/+Exf6lQ3pR7N0ZFDjxoK0wMSV1p4j5EOpjUmuZ4JaXPm1B4Zf29mUoedEDk0hBA
         bIwA==
X-Gm-Message-State: AOJu0YwDE9jq2RJ89wtVHuGzSmwUMFDLSwux1Dkyl0UKEz7YsIm3QMwk
	YY7skQONv/8g2dOMaqsdSQhUN9X6eFQyc9nzHUJtFE7Ak065dgAhR/xJtD5FdwU=
X-Gm-Gg: ASbGncupUFoUJ6AL523uUtOHPMTBqX6wKm46fmHKWT0U+ipgWwwl4TdgLzfcdnMsoZP
	/TBJp4OFcOSqidmAiIX/jz5tZpcYPQN0cZ5VJ0YfZlIzrV81G/KqSpR02o2iZNifZ4aLF6J+Ioh
	W+EPZ/FeLQlGtmmraXMFy5NJrDZ2ezQ+vW+u7e+08z+WjtGuFynKSVP4GsgJc9o+6eb14/wUtQj
	ZES0JFg0TjhDilQ5gy9kZk3qF9PYMrp9bxSpfaRhUXvYzj+wUBmkaB0y2e7YECXBgkb+qQd9JaS
	+9slB2qQ+/uo/dMh60iMP4yymdChLaCd0B43tyucA3LGfP7dg7iFy9auvh311PclotU7fJsbeVX
	Kmjk12RloqyAmjrKN
X-Google-Smtp-Source: AGHT+IHqzcu+dvDqkxQhTRPZBgtaU3gmv3t8XQxOeJvrxUUTQ3aJojyvuUQw0C4v2sFLYZRHEYnsBw==
X-Received: by 2002:a05:622a:5a07:b0:476:87dd:16f9 with SMTP id d75a77b69052e-477082f4dbcmr17934251cf.18.1742343235243;
        Tue, 18 Mar 2025 17:13:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-476bb66f9ccsm73792741cf.47.2025.03.18.17.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 17:13:54 -0700 (PDT)
Date: Tue, 18 Mar 2025 20:13:53 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 04/13] pack-bitmap.c: teach `bitmap_for_commit()`
 about incremental MIDXs
Message-ID: <Z9oMQSvqfD6R9T3a@nand.local>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1741983492.git.me@ttaylorr.com>
 <832fd0e8dc3a37e36b3d59085e448f8de84ce4b4.1741983492.git.me@ttaylorr.com>
 <20250318013823.GC1471939@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250318013823.GC1471939@coredump.intra.peff.net>

On Mon, Mar 17, 2025 at 09:38:23PM -0400, Jeff King wrote:
> On Fri, Mar 14, 2025 at 04:18:31PM -0400, Taylor Blau wrote:
>
> > The pack-bitmap machinery uses `bitmap_for_commit()` to locate the
> > EWAH-compressed bitmap corresponding to some given commit object.
> >
> > Teach this function about incremental MIDX bitmaps by teaching it to
> > recur on earlier bitmap layers when it fails to find a given commit in
> > the current layer.
> >
> > The changes to do so are as follows:
> >
> >   - Avoid initializing hash_pos at its declaration, since
> >     bitmap_for_commit() is now a recursive function and may receive a
> >     NULL bitmap_index pointer as its first argument.
> >
> >   - In cases where we would previously return NULL (to indicate that a
> >     lookup failed and the given bitmap_index does not contain an entry
> >     corresponding to the given commit), recursively call the function on
> >     the previous bitmap layer.
>
> This makes sense, though it does make me wonder if we could/should store
> a (midx/pack,pos) pair. I.e., a master hash table stored once for the
> whole midx stack. And then you wouldn't need to recurse; it would just
> be a single lookup.
>
> Or would that work badly with the lazy nature? You'd need to load all of
> the layers to fill it (rather than doing each incrementally). OTOH, if
> you ask for the bitmap for commit X you're eventually going to have to
> figure out what's in all of the layers as soon as you have a miss and
> have to check them all. And I think the lookup table extension is what's
> supposed to make that cheap-ish.

I think that it's a good idea, though TBH I think there is even more
room for improvement there, like recording cache misses. I suspect the
details are fiddly enough that I'd rather tackle them outside of this
already-fiddly series, though ;-).

Thanks,
Taylor
