Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2378528FF
	for <git@vger.kernel.org>; Thu, 29 May 2025 00:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748478029; cv=none; b=WccbulVF2hop7XcwEQJqQg5KOPEzerHr63MCIfrMXhrU6fqLY+DSTyTWBrHqQQ0a3YPlD3ISBc3HlTpwekGEG4D9S3nVk5UfXMXy74rUoth25vkB0Qc+UD+G9PhmjGeuyVkwaG8xG9E7KQDMjAx8W/QoC3JsSMedHPY79yZ5qC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748478029; c=relaxed/simple;
	bh=TvKlpiWX1XayDXpaW5ygKfnA6XaZkfn1oWmBwZWzeKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKmFDtUYma2qZOhyntAWpCeiL9lzF35jnK3SMTaMGw89pJG3u9AqWhmkR/H50DWr22doOoyabHzN9LLDkJiOgnZ+iuj1NyjsD53JjkvDeke3EtjUXQLPfy64kCOVcG52RsfkbIOZkaoMwajT2TppbNEEFmNtp0Uj5rmbpaE435U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=LsXNs1zc; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="LsXNs1zc"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-70e64b430daso4903997b3.3
        for <git@vger.kernel.org>; Wed, 28 May 2025 17:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1748478027; x=1749082827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=loIDfpuUUy9E41NFwVIpuzbHgI9l2tPPss6PQLynric=;
        b=LsXNs1zcqPslYiOWO8u6hgywfjSbltmgOOafkU9n+YsD0i4Yhau/Dp0FpkOU+SMGOk
         ObBg7KcRG0lvtb+bsbthGK3fZvfMzDmuRpar9ey+IIifMdzDEgGYt/6FHHmh7h+lFtzn
         BO/NFz0EytHeU6nYtO/N7C/x3Yy6I+4x669y3jvVpS5JtACDpj5oBYIO5B42npJd60zQ
         zmZGNN1o4Se46TJAbVKBrRyGrDW1mirUyRZduIq6X8LFCNuBIgiBv64VNo9tj/3rdMo8
         M7PEmXL/nZVBQOf8olFguOLh2Oa+JwS1hjEUbuj5bxZI3hO/JJbBH6rtGRgOm1lAwrFP
         qAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748478027; x=1749082827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=loIDfpuUUy9E41NFwVIpuzbHgI9l2tPPss6PQLynric=;
        b=iNphPGuvboFMsZh1czeyHqiHdAaF4fdWHwDCUo9X7x+2xjApRWStXW1JAHn9+dAVKx
         +Jg2JTJATBNLdX8+67q5Sp1rTq6P+cHca0pSAvMRyXUjTz8cgiv35x7J4d/MNzsSXYlL
         lz07HLMUKhcVAxL/NlmwQBqSUrsRLxczsHWXuzKoobTYEhhpY3Ke4gn9mEZFbr/rTRGR
         /rEeZCEQpeNf+7Byx9ydi0dhoPvKJgoV4CIlgRdO7Q7/c9LazWsbC3j4+rl+g0NQ+V9G
         E5HnNogIT1jZ1V8UfCq4w8h/F3EX5jWJQ1eCLZXod+MAyBc5IbAe0yfuPNujde7BedNZ
         6fLg==
X-Gm-Message-State: AOJu0Yz44E2GvNE0/D3vSmgvxhPxNAM96tf0NIF4cgiBN2y1XVQ7R1G6
	HAh1KpT3dIwPmbSpuY+YBFY40/xYc5XVR68dqGkU14SZ1JGeMolJAAh6viLJTM1cGv4=
X-Gm-Gg: ASbGncufJ78a6W/jVQxVybRGaYREd7LF19a9k/sBnRbjVB0R66UJnA3DZOtXg5USSW8
	WPmNx67OxiCeHQjCJQYo8EPdX9Mx9Su3sB9NfuWIdbw/JK3bKh4KcDnCCpP2RIxUhdKErQ+A4Fh
	c4+uF7W0beMic+IvKc5AaBOjfZuQ6Z277EKS1tQePBz0xeEEKsuoLP7ojD93fRPnrLUfg/53KjU
	1g0VfEzXSvcNG7qECmegwLXw7V0Yl7Jcr/GqRIZQvvGxpijR9iMdJ2izn7TdfuwDq/ZHRb1E0q7
	WEFmcyGVjeNqtoO5zWrgM5jvdYns1ezrinuyNqcvJP1lUFrefWQuzBwunDm1FqnUUWQhp3W1DWl
	Y9T7OWUwzaMH/8NchsyalbIE=
X-Google-Smtp-Source: AGHT+IHyxhh9P2hZ+WvXBkt3/UehgvMajN0gjx0dNqpNcknh1RFIu40HgHSXNSQ73+8qjEZ8nujyiQ==
X-Received: by 2002:a05:690c:4444:b0:70f:889e:96fb with SMTP id 00721157ae682-70f889e970dmr22851977b3.30.1748478027064;
        Wed, 28 May 2025 17:20:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-70f8ad2439asm551357b3.125.2025.05.28.17.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 17:20:26 -0700 (PDT)
Date: Wed, 28 May 2025 20:20:25 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
	johannes.schindelin@gmx.de, johncai86@gmail.com,
	jonathantanmy@google.com, karthik.188@gmail.com,
	kristofferhaugsbakk@fastmail.com, newren@gmail.com, peff@peff.net,
	ps@pks.im, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 00/13] PATH WALK II: Add --path-walk option to 'git
 pack-objects'
Message-ID: <aDeoSW0pZ7r7rCog@nand.local>
References: <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
 <pull.1819.v3.git.1747419124.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1819.v3.git.1747419124.gitgitgadget@gmail.com>

On Fri, May 16, 2025 at 06:11:50PM +0000, Derrick Stolee via GitGitGadget wrote:
> Updates in v3
> =============
>
> Thanks for the review, Taylor. Sorry for my delay in getting back to your
> feedback.
>
>  * Documentation has been edited slightly for simplicity.
>  * is_oid_interesting() was swapped to is_oid_uninteresting()
>  * sub_list_size renamed to sub_list_nr
>  * Several uint32_t and uint64_t variables were converted to size_t.
>  * Several 'unsigned int' variables were required to stay as-is, for now,
>    until a refactor can be done.
>  * An unnecessary update of tag_objects was removed.
>  * The logic and error message around incompatible options is simpler.
>  * Tests are expanded, especially around config options.
>  * Fixed commit message typos.
>  * Extra care around ALLOC_ARRAY() to avoid a zero- or negative-length
>    array.

Thanks for addressing my feedback :-). This list matches the range-diff
below, which looks good. I think that this one is ready to go from my
perspective.

Thanks,
Taylor
