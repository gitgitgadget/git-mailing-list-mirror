Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D04C4499AC
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 21:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783633444; cv=none; b=uKzkxRO9lkWtjTYpdQRR1dGD8vb8+6JRnb2r64/KCRS6Bi7l5darJJbeoMpXVkboM7nEKbksEOXvN9TFfimIeBnmMAq1cW2PzT/WQpiHG952+i45xhrPAUj0ZEo7mC94BojiFpLpPeMpTF1wpqN7cirrIJmyqjtrOzFUJJzCT0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783633444; c=relaxed/simple;
	bh=Ri8EueB59aQW8fItXfK1Wh4niyjn/vPWHLTkyGqJbAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+lv6LztMNCKtY/U2c/Tne40taH7goB+QZYHma2rMBNHsCvf6qkx9YEBGmZh5rqR0wcjkooeBYIQS0+wTqOVKnZf2MMITBA4F8yD+14mMgnkKZWBhUUyqhGmjgoswPnfeV+EGimMEYc4zjAzXKCqn7w8DWGbLWCJAm1/h4pJHLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1FstsJa; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1FstsJa"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6a373df7d4eso137911eaf.2
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 14:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783633442; x=1784238242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EB+xK7X/9QJ/O5EMChCo9hEr08NQwhNMIem09/CWt3c=;
        b=I1FstsJaON6pzIPXl7D/KauioHSFM2V4fo3uWoq4SN6l19xodg6kb5746bjqxFnD+S
         EfyVP+2/drtJ0DcVqjCH0EQMD5X5CNGeuyrZOgZwETfCKJy8I2mKtKHXaoBM1UI5tCZF
         KMu/g1/vFcP5Xt7mqvrIfdNqjxQqAGENka6eUoz5741GvlgUn71yMEOnlRkGaNIe8nkt
         fNaX22ssfyM/ihRD0p0Iq19Yz5pzkiOIrrj+BWjIAHfXAdW/Ko/Bth6n+Mn+ty+ZhlB3
         xa292lqaR1wIWuLDUOA2TwG2KG8BZsPkegeOuJ3VAQm2sVu0t7maT+rhtnKsF3coBeos
         ngdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783633442; x=1784238242;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EB+xK7X/9QJ/O5EMChCo9hEr08NQwhNMIem09/CWt3c=;
        b=RO8ql/ntzNgCAgdUcT+iZv3x6uGeL77se1KLTJEkEfR49B14SA8Z02zYi37FIBcOOO
         B2KQ3VgxtiZ/qogfht61TdTDiX5ibg7xLchep8rS4ugv2YVVGtnFQRzFy4kVFmI7y1Sc
         X0xWAnoXRaoJAs+NBLzZxY0146YUzZ3KOl2ALV06DuW1v8tixObUN54NjxwTFBefa8Mq
         68eOWHZjkxVFYcY+qKJ7HIO5RBOlbFmH4j+y9rtgf8EpsEDRAPlC57Mcj+EoXcEx2Ogg
         8UFkQ0tsNe9nHcZlHaclV41opq29q9Vo3/MuBj+D5SjodnrLItiuvK8d4Lv3UHsDHuqw
         /rAA==
X-Gm-Message-State: AOJu0YzoOBM0LUq9EAcz1b2N4vT1W4CbsQ9+kzHKgweuuJ/v2tjGYUhc
	jxbYtfkOZcmAxylgwqtUMl2JWW+cLny+KI1kDDiJEB4XLjNOO6NQmg0b
X-Gm-Gg: AfdE7clyBfLSxX/wGaFxyGSMf1fc2D7dlnJrdgog7R/RdQmpj5b9nLR84n7HdqUp02C
	aFtAUFy2qP2OYlKZMriU2VKYsvKubmkhKMhYCFGZU/HRaYOAexlKJ4srtRwoQVX+hRZq6AYTp3b
	EfFPBigvi4Hnn0iP+/hgKiLTiZoNQuPYiEvF0rJkhuzX2JdQuwRgxJl9FXd8ZC9QowlKcRVpz2E
	p1V1DRMJD8JIICU49sma7SpM/I1+WcfdTSq54XKINOePeoOkqmGdipK8Xj/iRRM2HZrydYV0/2Y
	bSTc4ix7LbtTzFt9sb7BDzgicLVlsaAoNtbqP2bElPzfYBC5KpjbQGDXeZQogfM4yrjo4ZMtK/Q
	9ZW1k+OAgzMMjpGRd6EANhDcMrmu8Y6jpFmpEehznKmJCTRuj3gZBU6d++gWfrZcbTaKuhfvPk5
	2MY/ujsg==
X-Received: by 2002:a05:6820:213:b0:6a3:8898:1811 with SMTP id 006d021491bc7-6a388981c7fmr1533473eaf.13.1783633442394;
        Thu, 09 Jul 2026 14:44:02 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4519124d07dsm3129956fac.2.2026.07.09.14.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 14:44:01 -0700 (PDT)
Date: Thu, 9 Jul 2026 16:43:58 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/7] odb: introduce object filters to
 `odb_for_each_object()`
Message-ID: <alATd_YS2d_l3CHq@denethor>
References: <20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im>
 <20260709-pks-odb-for-each-object-filter-v1-6-82fe014b12b3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709-pks-odb-for-each-object-filter-v1-6-82fe014b12b3@pks.im>

On 26/07/09 10:35AM, Patrick Steinhardt wrote:
> The function `for_each_bitmapped_object()` can be used to iterate
> through all objects covered by a bitmap. The benefit of this function is
> that it allows the caller to efficiently handle some object filters. For
> example, this can be used to filter out objects of a specific type with
> some simple bitmap operations. But callers are currently required to
> manually wire up the use of bitmaps though, and to do so they have to
> reach into internals of a given object database source.
> 
> Introduce a new `struct odb_for_each_object_options::filter` field so
> that the interface becomes generic. When set, then a backend may
> optionally use the filter to skip some objects that it would have
> otherwise yielded.
> 
> Note that the respective backends are free to ignore this field if they
> cannot meaningfully optimize for a given filter, and consequently
> callers need to verify whether they actually want the returned objects.
> While annoying, we cannot easily lift this restriction anyway as the
> object filter infrastructure supports some filters that cannot be
> answered by the object database alone.

Huh, this feels rather awkward. So callers will always still have to
ensure correctness by filtering the result a second time? IIUC, the idea
is that the backend may be able to more efficiently process object
filtering so we would want it to attempt the first pass.

Is there a subset of object filters that we should expect any backend to
be able to answer? If so, maybe we should define a separate list of
object filter options specific to this interface? Any filtering not
supported would have to be deligated to the caller then.

-Justin
