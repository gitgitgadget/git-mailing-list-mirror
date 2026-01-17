Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6A713AF2
	for <git@vger.kernel.org>; Sat, 17 Jan 2026 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768671612; cv=none; b=ZJjz4xHQqnOe96eKML4Nz/HGXVbOUvYaN2bLc7iAJbX1YvuB7WlRQ6/UUIpwVhdtX/70qP6pd/X+yafH6zpjjf2RecOmjC4tfA4gJT0j0Ki76HDjfetG8gIRGB5F5xQHQkoRGpFpBcHD+GDEmm9oxdWz+5VvzZUoMMlxpoCELMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768671612; c=relaxed/simple;
	bh=6jj9jG1HDPc8bloTts7RnXqAibh3roVZuCAkBTBxZf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vCOXx2E4foNfh6RinCKhHR98C5d+dlbOR1zOwV/U1cUeYtJl3IdrSGkJpZE33273v2XMyFG8OSYMtuCZ96DbkBlZ33oD0Jh4YowZjLldXPONkRjEz5PMj4DUCmAkTVqDs7EcLxDLcStMhewUJVckwL+fnEd2gOhrFAi0/Y4VFlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GB9Li+bG; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GB9Li+bG"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47ee301a06aso26862765e9.0
        for <git@vger.kernel.org>; Sat, 17 Jan 2026 09:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768671609; x=1769276409; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zfv2dVE8IqC8ykbiVvCrXTbCxRbDXbwX3G2GxEezljA=;
        b=GB9Li+bGkoj+U9qgGDC3fu8B45K0t6AZBABP0aHtHIrQXDGPILkmM9lAFOVRskmc44
         mExHFtMxVJ8oX19eNt8OJS9I8XX2afX8JvhRKNm3WvkjCnScIxeIubokRu0pTvjhNuCJ
         hkSm7NIPj0OV87wPTC5pw+H4rsvS+6/hY1+G2UiGXrkTGriHU+WOh+ALRiGBq86ZyRfF
         y6HEeT8exwgALU50Naj/6Znju1LmzG9EctnClO/1RZjpZnvJKW+m/TV8+3TTCSNMdIW1
         wpsowOUWQtPlVHnJmWJh3VFC+AyMwOCDoLZNZ4zI/TeXjtcWzxtrTf4cZojKj3SzlGcn
         4XeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768671609; x=1769276409;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zfv2dVE8IqC8ykbiVvCrXTbCxRbDXbwX3G2GxEezljA=;
        b=rZGEcLd6Codks6TyYYY3qFbsvEfNNT6Ej16+5gGfYcUvVuRpaqSG4W70xzXGMg6Qei
         BODamsOgsSS1wjpQhJ4eZvK+AOiIqC9bhz7KGOUeDTvu+2jCg6yoXZSONYCAGPiAd5DM
         TG/szVBOAXEy3h1pQVZRAxYQpX1nB9Tfmm+nOT9pypyh+fmoHOJmnQtcre9hMVk970Dz
         YdpnmOisDZg0htfbjC3aHDDymdHM2sTLu3tETA+ByLtgqexEONA+0b/lNxBA8c9KeYZ7
         WRJbgp8AlB/FsJFghHDM+bhxwrQti+z8kTK3CiZ+mraQzOPWKPxW4P0Zfq8uYPyvIimu
         CmMA==
X-Forwarded-Encrypted: i=1; AJvYcCWz+ELVDy1Kvq3q8pRhOFN02tI98QEMMUJXWv5snL5mz46wMs1IzwfOuruxCKRAxWixjIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzORdKyGGtiCD858/bOSfyujZezO4FGRP+0uME4FgyzTndUk+F+
	Zk4JnZws0OrkRDB6sRu/IBtG374cYvWHIklp1yKFFJQuywxUlb0E1e3c
X-Gm-Gg: AY/fxX7IgUQlNQtYI/6tnfpAh8aFMvZil2fDX30q61cTV5cWhPn8FeW87/2g9WR6FBr
	XgeCC2MgJfFPkCQnHQdbHxR9L5UW5WpaHu6POLxO3Fz+gDVjsohtFrnBsxV9JPWE9sthkkW1acX
	SIrUysv5NulJAnIleIuRGy80VLVi1V81WcYayocNt4lxA68+FGVEi3eqTGWJ3M0TfVicHxQphi1
	cLQ9qJXD9Vh0eiZOcNs2m7l+KmGy0J20UtK0AsIS7ocIjuqE+iyFu13tnywLuzQYK2Xh/dM18nm
	x+54RKXUrjTn2O4iYOTsHB2yXsCLdI/fQ7riNW718pU/i1ByKps8ATVNG8CnYFiSEqZcebWwN1n
	ck2y7Qofb5ez2wSv7EDGVl7S+5H0LmzHln2ffWLk+EJCTPpi7cD5J/ApKO25T0CuAufciHotV32
	PRJUaJX7umFVEbSKwSKAa4CgxLZYF2+lpBoSOTvcJmoUpCamiXvYrhtWPNxDot+wxBMMoFgRI=
X-Received: by 2002:a05:600c:3581:b0:47d:3ffa:5f03 with SMTP id 5b1f17b1804b1-4801eb03348mr81653305e9.21.1768671609232;
        Sat, 17 Jan 2026 09:40:09 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:31b4:1316:18dc:6259? ([2a0a:ef40:627:1f01:31b4:1316:18dc:6259])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801ea19f94sm45483255e9.3.2026.01.17.09.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jan 2026 09:40:08 -0800 (PST)
Message-ID: <6ae80903-3cc5-4017-9eac-0b3100b93b04@gmail.com>
Date: Sat, 17 Jan 2026 17:40:08 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] ivec: introduce the C side of ivec
To: Ezekiel Newren <ezekielnewren@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Jeff King <peff@peff.net>, =?UTF-8?Q?Ren=C3=A9_Scharfe?=
 <l.s.r@web.de>
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
 <adf1395d201e916f23accc7644d21aff4f58368b.1767379944.git.gitgitgadget@gmail.com>
 <0437b899-5a36-4499-a30a-c2a074a80f7e@gmail.com>
 <CAH=ZcbA_HgEO2T2smn4Yg6gf4sm4jrR8A0ek1v9nqsa1MXbRJw@mail.gmail.com>
 <c2d9a432-0753-4786-8de9-c3dcfe69ac36@gmail.com>
 <CAH=ZcbAogCpqg0RkKg1WjuAcuKyArDs4aP+k=McCs_byDT2Weg@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAH=ZcbAogCpqg0RkKg1WjuAcuKyArDs4aP+k=McCs_byDT2Weg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/01/2026 16:14, Ezekiel Newren wrote:
> 
> If the size of different kinds of pointers ever differed from the size
> of void* then wouldn't that make all calls to malloc undefined?

I believe there are (Havard architecture?) platforms where function 
pointers are a different width to data pointers, and that's why you 
cannot store a function pointer in void*. I agree it would be weird for 
char* to have a different width to int*, I suspect the restrictions on 
casting from one type to another are about alignment.

> I
> don't see this as a problem since I'm not casting between structs with
> different members that are not pointers.

But isn't that is still undefined behavior as far as the C standard is 
concerned? It might make sense for it to work, but common sense has 
little to do with undefined behavior.

> I could use void* for
> everything, but then we'd need an accessor like *(T*)ivec_at(&vec, i),
> but this is much more painful and error prone than simply vec.ptr[i].

Yeah that's horrible

Thanks

Phillip

