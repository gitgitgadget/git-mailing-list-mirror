Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E11221540
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 21:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775598395; cv=none; b=MoUUojfvP8sBPht9ZvCMuT/jJeWPiTEsIuUG+iDYwE+lMzvt1cnMYMFd2hweGThEU6VbkiDvGaXhvBfmoauCiQz1658M6Hjq8Q5UDC6PUcqVjQSsajhQWAxhjDhKt5eErwkqqRagFh5+FjFWXE7QdP4GkiRO6/cLhg+kIUE5wcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775598395; c=relaxed/simple;
	bh=tc1kQhT+ZInZJdfVN8RfTwnYYnfzkCdm0WQO5qfakng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QuYEEXyYGVHstQBXh/fIeiKbsEf0COYIU5WOSURWn8df4VcDXl6tdtCtrIUg+wtjx5205AqBt4P8Qi22wu+K/9xgH0i8vJ85P8m6B6HeGJpnEYzhM4WuUuTyHm8VIr7k1FOOtiJZfoi7wzWiBXyfy3AFdUwxQBuFRZk6q4uH/t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SiO9wjI5; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SiO9wjI5"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-482f454be5bso3556155e9.0
        for <git@vger.kernel.org>; Tue, 07 Apr 2026 14:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775598393; x=1776203193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0JWiDAVmy/Oycpxpkj3/G4TEBSyLs7xy2YwmlILAEG8=;
        b=SiO9wjI5FoDJmF7//h6PBlYU1FRZs4CdIwls7kE4n3EZx1oZfYHghysef4Zskc3JPu
         TkdQQMPLamTt3blNg/KLVAJRrK0b5hftb+sIAGG25WH43DFI7eDvJFRWlLiSCfKYiSU8
         qZ/j2aFlZ0d14P1ZGgf8txmCmisSaZvfMkTOlevdcGlMVpd/QV2RkR2F848F2iy5ihnc
         EyVhONh0IzhJ69BqJYg0IwCVyZUzXZ/rxzZtEKHjVsLbiD/1nySUkthuVZKFVwC/gu0V
         5H/ckMQTd26mrDQQpSFIP4ujcgbgX69Jd/XckuejHx2Lp+GFTj9rM1fWMlzqAmu5pRLn
         owwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775598393; x=1776203193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0JWiDAVmy/Oycpxpkj3/G4TEBSyLs7xy2YwmlILAEG8=;
        b=TDEo/+0jZqG2OPKH9bouwkvwSaXv0lXSTmY3Q/mYwXUXbS66+oncjaDky/UrO4jWlL
         YSEtgxp3S5jh1HzbezXgA39HQ3MVlO+YVWQhdj7LN2vzPs6vVigr3MnffUFL+vpUk0Kk
         84TvESn1PJwTci5/wQZquf68GQpPUGl6OM/6d6buuR5yPG/iwYxK4N87wABseBU8DyEB
         3i8dxV3TD9GZ66lxSCy0Os0vvoXPcfvOYoJKfYL6YyEK8H1BGoRdMuOXPH0AmwxZQNQn
         tCqaWa0G/rpJmKm5pb07UVv3qJttbzXWYCugM8YwAuu0RFreXxI3x4WuTdx3mSV/9//m
         6Y8w==
X-Forwarded-Encrypted: i=1; AJvYcCVl4NmuXxMZsPwNYloM5xNUGwjgbg2sKv+F5tuRDW/UctTBM9hpQRnifpsDNFQA9zJTSIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHtaEQe9uuw27+HOD0zwkas5scpPxJEfMlfZcPC96XNazqz6aQ
	1ICGDhxuFVXGkaNHIJANxCLnFZ99U42/fqxkSGgRA+1Z7qMNZZ3lXBJP
X-Gm-Gg: AeBDietdsFz8qMZVR5jejYpvbzR33I/bRz4mM9wAKreI2jSFu709dIb8XNyivpA8NXr
	xcFdHgN01jX75AyQYE0BjAmZ6R1YR8K1RR5S2MCdtzQzZLJgjbvFlWVY6u/quc1mbnAnaykH5/q
	6H8HGWXPPHS4Mm5lEZNGxjJ0wbTPR66H9fD7gN2axyk/DXai/hIW1x3fNiEssXz//w++l5lYCPh
	Y7+j6LiXT0uKKVwoIye5YbBeSbeQ6/bGQuP7LkaemC+doEfnbeVqxg8IZm2GDET/aJXsh4hSXt3
	ZoyOhSpZejWYMGQ58k4xIhhgk1/XaQ2quhLgXXBc7pgfmLnzy0/WVkZIVF8kM/sVf6/f3aPhkXl
	5F3oN2JMXL5ds3/KjsZ2YVLO5OGtNy/YYH3HR1ggaIwfuCO82Qeln/CxoPdx55t+kyxCVMujppO
	DmMDRVJRhqBGJymj2AhyganCkE5/8aZ/vQDCfTM2JRl1E=
X-Received: by 2002:a05:600c:450d:b0:485:3428:774c with SMTP id 5b1f17b1804b1-4889946a42emr56860715e9.4.1775598392934;
        Tue, 07 Apr 2026 14:46:32 -0700 (PDT)
Received: from lorenzo-VM ([84.33.160.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a72baa8sm447187735e9.15.2026.04.07.14.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 14:46:32 -0700 (PDT)
Date: Tue, 7 Apr 2026 23:46:30 +0200
From: Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Tian Yuchen <cat@malon.dev>, git@vger.kernel.org,
	Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC PATCH v3 2/5] pack-write: add helper to fill promisor file
 after repack
Message-ID: <adV7Nq2fqA-Rz3JK@lorenzo-VM>
References: <cover.1774205661.git.lorenzo.pegorari2002@gmail.com>
 <cover.1775431990.git.lorenzo.pegorari2002@gmail.com>
 <3cd15429194c763727fbfd5981ba38c1dc2cc907.1775431990.git.lorenzo.pegorari2002@gmail.com>
 <f2540dc1-fe76-48ec-91a7-82e32ced75fc@malon.dev>
 <adP-MYYSmElK9wL3@lorenzo-VM>
 <xmqqeckraiwh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqeckraiwh.fsf@gitster.g>

On Mon, Apr 06, 2026 at 02:17:02PM -0700, Junio C Hamano wrote:
> Also strbuf_split*() is a bad API.  Unless you need all the parts[]
> strbuf instances all editable at the same time, an array of strbuf
> is a data structure that is way overkill.  Splitting into string-list
> may make it more palatable, I think.
> 
> We even went through a series of patches (and follow-up effort by
> other contributors) [*] to rewrite callers that unnecessarily call
> strbuf_split*().
> 
> [References]
>   https://lore.kernel.org/git/20250731225433.4028872-1-gitster@pobox.com/
>   https://lore.kernel.org/git/cover.1761217100.git.belkid98@gmail.com/

Mhm makes perfect sense. I will rewrite it using `string_list`. Thanks!

Lorenzo
