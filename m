Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754B92DECBD
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 09:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759485114; cv=none; b=jVjvkLn1nhcUm5thOguIydj3ScGxQvkp6YPrZmdEt94qjSw8uodOI5SN496gccBw4w3HQBbPoGQJAtpYYJClTzH7YolsCVj5/hy0MNghKkpLjanPA57ugVtbqXPD3pkY2Zs9Y+kDRnVszBh8bSHX9iYasFDIehewVGdztMDUKH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759485114; c=relaxed/simple;
	bh=OjiptpeOPZ6jlWnSXS6zjksp6SSPOF0ug55P7VOBca0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NLSCDEuFkOoW4gaIjQT+pvm4dJzWdWh5I5zi44nRQYqR7xGrUpFojUyEHO9vhXoehvexjWYU0MZ+Vu9iqrgcIhQ5Ph/wIHRLfI6idBcqHpVAEJHCBw0RQ1CE9iVAfUcftdL9oBmTHn3Q+QnJYZOTxZNGc8p2q0MNg/WUcThxD5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJmfttap; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJmfttap"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so15003065e9.1
        for <git@vger.kernel.org>; Fri, 03 Oct 2025 02:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759485111; x=1760089911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/95gw8vkXM6mUDPiKwVuibqbu4R+dlnNQqrSqXcOysA=;
        b=HJmfttapiwfm7nLWYH3kBhvs+v35o75LvL41++kls2XV+tNzyGPsmBMdgmGvNYTJp/
         UIZ+SOCXZf06ka6xt1mjhcsP+Bu2toBCBKam+VO/Mr8iMZxc1qvbo9ZRlNLTg3FvDoKp
         8tVqnq76VnQxpW4iV58YZ22kCFcemPjXrgvqctaSZtHUd7LOGFkYdtWx5wtU45L4D9MM
         fgwNuarRnYb6mOwANWJohvlXcKks9HJWEUDGXqzuXXgZmEyFK3FrMAHDU2OaD2bX9s6j
         0FHPflu4RcE0VgW1zlojrXhrYWTWFrfve1Jo1edrCLzPSY2ObrQlk0RdqdRMT9aF+TjR
         EEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759485111; x=1760089911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/95gw8vkXM6mUDPiKwVuibqbu4R+dlnNQqrSqXcOysA=;
        b=gs1gjyEkoTjfdybFQhxncNf1UG9hsSkPyl8t94Sy0Yqa17JT8fUrRCgnCgEepLbXOc
         LXQVCIUQU8m2pAUHrSG/2NHUPnDCCfR6ab76aRR5SGYOXLoTiyxxicSMgIR9nn0S3kUA
         867nklWaiBQ8aKFzoNrXo5gwPsliCIOEcf7TgMPycDCDCnR98aq30RWH+Z0eNbvZPpYQ
         YcnGkdHrhMpj3LDgmnhjR2ctJCAp/UTSZ9ea60cN3MesziTCv8H4tqhoqZA2hsu2IjaJ
         LizyvZnvO8xo8IETQKgFOZdCJm9B8PRc7sk0H5qtJ1bE70KAXuXfJHDG4t8/11i9Q1gq
         KSxg==
X-Forwarded-Encrypted: i=1; AJvYcCV5T6zvaD5Xq3mADXKWQOC7hx1G06TkSyY1Ao2LsteYG5TFdyfbldx4CvyM2Nr3Ws6LlPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXtI5Zbxkb4OuxT0gIZXcBxUCKamyIg6z5iECmM9cRuZWopesV
	v4FmXRPmaLL8KuaOSK83qGHILw0Wdm+SJI/YcaGFmatPzHv4VXO22X7E
X-Gm-Gg: ASbGncsQzQNdAgWA16Ny3yib09NUXaejcK4HbfExyM+vk6G22IAglMCpkdN/4/hKLFv
	RjMgTaIM2RjPCAiq2DiNppGRel4fPWXdw++milUhMyaTo2cniPPOc9AjWigtH2euu2OxJDIP89Z
	MFi0oPR3kSVfwz0d92CnXEfwfKcxU9YCzSuTV7XClUxRy6MnbRJAtCnocstd7BX3cEDognViYSp
	jIaE4X9oN5l+JIVIy9Ow9O5zcClrLiGIrRyihLSEYT3atFNFHnvkLrx6a4NI9hkYALdd3OTnXD7
	8iwhBBDBsOU1PAr4hopUHQcuS6cmo9ZBkwILMPqSXBL6IoO97xMIAL4Vv1OxOM5Lv/LfXxAlbHm
	wMQdg2PKTqyRZaeTK7v3xyTDMNFvHym7vpFQG+LmvrkSls8yVQbjIU7pnDxZk3hNO4bl9Ttnn1t
	9u3Y5XZwTt/aCIWayF+dH9uso=
X-Google-Smtp-Source: AGHT+IEhmEgS7TFkXrhNNWlBWSt6iXs5Esc0Mp7frNpvn1Wlwz9j07LcVWpbvRNR7XWd6TiiCQEq2A==
X-Received: by 2002:a5d:5885:0:b0:3ee:13b1:d70e with SMTP id ffacd0b85a97d-425671aa0b6mr1720312f8f.40.1759485110370;
        Fri, 03 Oct 2025 02:51:50 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e723624b3sm22954335e9.17.2025.10.03.02.51.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 02:51:49 -0700 (PDT)
Message-ID: <ea27273a-378e-4f75-90f2-6615ce297a43@gmail.com>
Date: Fri, 3 Oct 2025 10:51:47 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: gitoxide-compatible licensing of Git's Rust code, was Re: [PATCH
 6/7] xdiff: conditionally use Rust's implementation of xxhash
To: Jeff King <peff@peff.net>
Cc: phillip.wood@dunelm.org.uk,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
 Ezekiel Newren <ezekielnewren@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <5a959c9bdad79cf972b95dcf4324135dd7c94dac.1752784344.git.gitgitgadget@gmail.com>
 <5596e569-6632-c2b1-37af-a978de5408cd@gmx.de>
 <dd3a7ab0-947b-4592-a086-8c7028f02ffd@gmail.com>
 <9818dc92-3569-3e6f-0252-245c2bf0bf84@gmx.de>
 <20250923174825.GB1136654@coredump.intra.peff.net>
 <bfaaf26f-5759-4812-9057-b3e0bf7c7949@gmail.com>
 <20250925022555.GA3202669@coredump.intra.peff.net>
 <20140030-6bf1-4393-a941-bfdbc69c79fb@gmail.com>
 <20251003031805.GB6381@coredump.intra.peff.net>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20251003031805.GB6381@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/10/2025 04:18, Jeff King wrote:
> On Fri, Sep 26, 2025 at 11:06:38AM +0100, Phillip Wood wrote:
> 
>>> If I understand the suggestion correctly, it's not to license it
>>> specifically to GitOxide. It's to use a permissive license (like GPL
>>> with linking exception) that would make it compatible with other
>>> projects with similar licenses (like GitOxide).
>>
>> I was responding to this paragraph in Johannes' message
>>
>>      Note the exception? For new Rust code (and of course excluding code
>>      that has been ported verbatim from GPLv2-licensed code), GPL v2
>>      could be used with an exception along these lines: This file is
>>      licensed under the GPL v2, with the exception that it can be freely
>>      used in the Gitoxide project.
>>
>> That suggestion is pretty close to what libgit2 has in its git.git-authors
>> file[1]. I'm not sure how practical it is to special case just one project
>> though.
> 
> Ah, yeah, I may have misunderstood the proposal then.
> 
> I don't think that really changes much with respect to my concern, which
> is for existing code.

I agree it doesn't change anything with regard to that, I think it just 
adds more potential problems.
> That probably needs to be explicitly granted
> permission to relicense, whether to a specific project or not, and it is
> hard to pinpoint a definitive author for a lot of it (even if many
> authors have agreed to relicensing) because it has been touched by so
> many people over the years.
> 
> So there are probably two separate legal issues to consider:
> 
>    - how the explicit re-licensing grant is worded
> 
>    - what problems may came up with porting existing code that has been
>      touched by many people

If we want to seriously consider this we should probably reach out to 
Conservancy for some advice. Did this end up being discussed at the 
Contributor's Summit?

Thanks

Phillip
