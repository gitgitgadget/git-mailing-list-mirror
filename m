Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CCD76410
	for <git@vger.kernel.org>; Mon, 26 May 2025 13:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748266315; cv=none; b=Bgz9bpTd4cCtqy53OgITWS0TCfODyWVeKIzV3zFQtKDeE+UsBte9aGwZyRqbXKQG3JqPi/M3B7Y6gCgkTCZIvczFzVZFcn8wXzUrYVnhIZO+9a0DsAF3t1oK1aOHFl46WZ5QSas3Esw/KZWtdz+M5ALDdpaW7q/4nQ/a0L9euqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748266315; c=relaxed/simple;
	bh=FX7kAlNgKcfWqgm4jW98d3kfQ2pZ9ImOSdStLPs/Eq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nvh8Tw+u7eINynCUifxl2psDE4oAJDTPDgTq8MJ+QsqLAEHUn+EjMnP2MkD0JgABfqVvISg9pIbeTvMSYuA8p02RK8bz+YBI9WdeWPMp33RcmlbsxTbLrau25SGPDoe+Abg4yNR7emHbRsxjX9r/Qcw+RYb+57AmC/Yx/f9mbb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBT9CmCY; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBT9CmCY"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60477f1a044so1730596a12.0
        for <git@vger.kernel.org>; Mon, 26 May 2025 06:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748266312; x=1748871112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/SPb2VJlV6Re6EWseqZdkz9TWfm+ovfMsR/AmijPuUg=;
        b=cBT9CmCYbPBv2YelNd0kMlDSqzKFAj1Na/smaifi1TobXMV+vrdPRiR6YCvkPdxhyS
         liqAiJQztnaBDzUuA9IT1rQBcUHGldlZrnCCEvxzWal0axYbtHB3Fr/HGmaml7n6ewHq
         mQ6ny+Zmd9FgNo0wc+fsky5lNhJDFWCAk8Fqa2TbRaby4RUuNStv02DbpbhAOhaeZGXq
         xZHnRq+IyFUCZ6ElFBL/RE6uTr41lcE686++ILSoDcG3sJ8FMzasAKMYdCo8fU7OJuVP
         CeHan0CE6/1FMMD6q6gKbwGWZ5OC4h7LtYtsscRFX6WkZYq9vtdD1uRanYexcJiTB3i/
         Ks6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748266312; x=1748871112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/SPb2VJlV6Re6EWseqZdkz9TWfm+ovfMsR/AmijPuUg=;
        b=OujO6ZKnOiRnHRQTMFE1CfN8e/lF4TvAv5yemsQCEWI7QTECpYJ8ILiDOYhgSWRmyl
         41890yUc4o79i8DAsCr1l2zHidsI3I9LHbKn1Ek0a2pQXGz6Ay/BYgcbYL27wJ/NcGAf
         N1hwfbFgAe1yToL/o3lQIeb8gs7/Y0YgoU04iJkUS9B8Vr6JhVfpG5QB9baDsws2TEpv
         4cW/myNLLcexgLTSszMK0Uc9Qsltg4/bZEs6jZJiVl5z21ce+XyFjAUze5zrEG7DNMt2
         htr0lpUXQxTmt6UVh+ZEgZSFFFJJElD+9l3q6URq2Ns+z2xTmkeR6JPm2aBIuxY2CKWW
         ryYA==
X-Forwarded-Encrypted: i=1; AJvYcCWlaj3SGGQrEiMGtUiyklui1OirZtUMVw2ll9nDFbvJ8/4cz9XwWF7RNzHkRMWUWPZR4VM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9WBOc9M38Jdp0zE1g+MOR0jYM4ELfDa8VIMwCrEJ/AythFybj
	pl04SFCebBMBLdt4Z4aK9e9rxWbq2qkWTcqYFcQkSvccw7s9HXFJy4tr
X-Gm-Gg: ASbGncvzP+MNb0TJnvqICdUGlf0EELTTKMBC7geVHrDoPC8E9wCz+GVC/CZN5YQgnWw
	ctaTwcyL5jxiPMsN1sVJ1PQ4n9mSJoleacOEXqP/Axss4W8WaL9H11Q75e0RAzJqkc8FtY7Xwn7
	tNljxLGeeSlMSeXGxSK1skljdpAyydnk8KUOl73gWnqnkcReIxzpXCjAuoLuTzj1fXhmvH4gDX/
	U6t/RwbF05q3hE0pIQ4cVsi5IpMpZ9ErHrrdTJF4b0q91RpN1IFpkRiuv4dmaPqWP3spKHQ63an
	vwQqQm4j3MsCV9OMI3xjOgqUD6IZyIjjx+nUaeYfx/8zHEPNBmyq0IlD6ddBZcSOs2/vJk4Y9uX
	Hyi7+ALKWODbbO79ew1twU0bSiP0=
X-Google-Smtp-Source: AGHT+IFSHvK+MtQl51cBPhTVs4L+LikXWGuZ6waW9Mr8SvGxfH9fnfNmuRL6DpgRiATRfA6dSdYfsg==
X-Received: by 2002:a17:907:3da7:b0:ad5:9ff4:62e6 with SMTP id a640c23a62f3a-ad85b0d6281mr728344666b.23.1748266312269;
        Mon, 26 May 2025 06:31:52 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d06ad94sm1685163166b.38.2025.05.26.06.31.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 06:31:51 -0700 (PDT)
Message-ID: <74c03ad4-b132-4cad-b65d-821324380343@gmail.com>
Date: Mon, 26 May 2025 14:31:35 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/4] meson: parse TAP output generated by our tests
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org,
 Eli Schwartz <eschwartz@gentoo.org>
References: <20250506-pks-meson-tap-v1-0-5aaab2942a4c@pks.im>
 <aC2xp4Cdb0j6OX-G@pks.im> <xmqqcyc2aqy7.fsf@gitster.g>
 <xmqqfrgx8xkw.fsf@gitster.g> <aDBH7G-oKKxAXWBp@pks.im>
 <aDCNqRAoGygwnAbq@pks.im> <xmqqo6vjz5cn.fsf@gitster.g>
 <57de5690-f683-4e8c-a05d-a91198b352ca@ramsayjones.plus.com>
 <xmqqwma7w29o.fsf@gitster.g> <aDRiLdUCEVQHq26z@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <aDRiLdUCEVQHq26z@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/05/2025 13:44, Patrick Steinhardt wrote:
> 
> I don't think it's inherently a bad thing to fail on unexpected passes.
> After all, it shows that our assumption that the test fails is broken,
> and that we should have a look why that is. But I can see arguments both
> ways.

Personally I'd be very happy if our test suite failed on an unexpected 
pass. Currently it is easy to miss, especially if the unexpected pass 
occurs in a CI run. Missing an unexpected pass means we don't change 
'test_expect_failure' to 'test_expect_pass' and a future regression that 
causes the test to fail again will go unnoticed.

Best Wishes

Phillip

