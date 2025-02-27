Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A68D276D23
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 23:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740699587; cv=none; b=BTVs0dOspQILBSv8vOBGUrgYipNKTHZ2F+OPNt6OeybiYSSgGeqLlV/ZqDZppfXz69KecGCk3EQnZlCNQOAGp9jO7UP58dnmxFNEgEAqHzmtdFVrgNS6u8vfGMQHsXFoP0Y/l+OyW/vEDPvgwcW7MMllAjcCcawkhN61Ef9hUG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740699587; c=relaxed/simple;
	bh=qlRzJ8+xLA0D6LZnDSkY0b1VTsLm45qSPQ/au+xNDMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbRcqrQej6XkPZCNfChYgEeUVnWmURdJ8HhE+H8fJ/vIfr3FHJO0rVUvlTaP2A/nKix2ooSqLd3eAfqyBsEKX6ZJ8rU+Bb1Bq5DXq7YnDHHwpo7KpJQ02jkYpwgh02z7ltBbiAexG0G9KbnwHO3qOdjv2wca+FLRB6rCm4safc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=boGBzwWq; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="boGBzwWq"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6f679788fd1so12055667b3.2
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 15:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1740699584; x=1741304384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D1xXStYBLWPjeYGiyXjDGvEkwab0+NSUT2Q0igcfcw8=;
        b=boGBzwWq0j2XiBqxnpvhdr6iBaouXULaz8iIkvodMpSlaRo323bYjiTVYDRDYBE/PR
         5wsZI0Kyq5ZQPLP5g8+vS5JHZDUozZkRxeE5dhEdJYpSUnFIUqHQU7vyNrIwz829rRUq
         dgSdhp87Z7CQINmpCORUp7gAuIDpaOIKL7T4VLcqL1/NIBnu/XwO7JS7q8Z6cupCvnjQ
         Aj2XnF+gerS4yDzieMMl47EB++AStDhnMMsNONkzHMK5KIf9hwafDbKOQp9zAcEkPefJ
         jzgLVypCtAg92htq+bcbsb6gi2Do6AB8vqu53/SUNvBQi4j7X57717vKxG+TAQzn9zC4
         TzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740699584; x=1741304384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1xXStYBLWPjeYGiyXjDGvEkwab0+NSUT2Q0igcfcw8=;
        b=GFqfURR2S1N6Sfve60wvkHst1bOAr9qgBMD3gaHMHe/M5o37Of1f0/oVbUGpVO3cuU
         HamO8l71drmB2qLVxlqPU3Xmk0B+icoGUfS/EKtYEqQcV5hIuTDabv7tbidVLLkchFw0
         /I+n9xE/F5p6Kbny7up9DQfjemQBmXl2fXBV+xBuD/Zru427mhQYAgCNQyUwgcEln83w
         pZzW9vN5hdNaE/pVOJfZyxW9JA64XcpHlQNeB1g+PqYK9dk8mvC8mcx/TazutkTdwuVS
         OxPXV2YbtuaiPwDt08UQ8zHQzceXAsVYH/yvrIdc9DLioi8gttFxLHK7OSsMRuC/Jb70
         gSLA==
X-Forwarded-Encrypted: i=1; AJvYcCX0QKUnqivzbxDZpoHIq8QrKjVeaeYpwnBh0OyC5Xl1w4SoNl55X74jJtrOznC1+51S7TE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNdZas2v3NgscW2CP8zFxz3lysHfo3EvHLmWuj5iVf4UZPM75D
	s21UKQVwcwckQse3yHZhk6LlEaWiJvLdR75PrBx275Es3bBFEXZAbqE9XuoYMWpQBPoMsuuyiYE
	D
X-Gm-Gg: ASbGncv7Km3TRcyoKGWM/5gwipQqIiSsQQsGLDJt5wa7Cvb8LPcOGq88YX+SwR4y5FP
	wXOBfH2Nrt3kWeJKgCM0K+qLaemicSxhiWTSJZNhFGIngDbSN2rZGgaXpXhJ97JXpEifcVAo0az
	w8NVxbkAPE02gmxozrtkj9T6PwClML8KsVGW0JUGlA4P72AsTZwFEJbwB6rfAJojatFqUwbeGZ7
	Av/Esjnv2ba/fh72YrB+cAE2DRIKLZWmOoKgU4aXoMlnlo/+GnTu7Y/Lp3qERj5JOmPfKVE1gSS
	8xBNrH4M1AWHOCshkxol8IuNZgS33mZs/UvIBhKm0KCjuAjJhFuJQlbMYtcdWHxYdlpOsHB9LA=
	=
X-Google-Smtp-Source: AGHT+IHjTOzzbaKWPIC3Ds2zlsHsK+0ziYWV+gVLdTWJYjObpmZfxP87n4Butb0rmO2tlhk4o2Xy+A==
X-Received: by 2002:a05:690c:3686:b0:6f9:b0a6:6a15 with SMTP id 00721157ae682-6fd4a102c24mr21934117b3.38.1740699583971;
        Thu, 27 Feb 2025 15:39:43 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6fd3ca4796bsm5041637b3.50.2025.02.27.15.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 15:39:43 -0800 (PST)
Date: Thu, 27 Feb 2025 18:39:42 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 6/9] pack-bitmap: expose function to iterate over
 bitmapped objects
Message-ID: <Z8D3vsnwuKO05KaK@nand.local>
References: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
 <20250221-pks-cat-file-object-type-filter-v1-6-0852530888e2@pks.im>
 <xmqqseo35ic8.fsf@gitster.g>
 <Z8Dz6EkIpr/g3vuY@nand.local>
 <xmqqo6yn55gv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo6yn55gv.fsf@gitster.g>

On Thu, Feb 27, 2025 at 03:32:32PM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > It looks like the aim here is to introduce a function which executes a
> > callback for each object of some type in a bitmap. That's a thin wrapper
> > over the ewah_iterator, but it's not clear why we need a wrapper around
> > that function since it is internal to pack-bitmap.c. Likewise, this is a
> > performance critical area, so I am not sure I'm in favor of adding a
> > function pointer to a hot path which executes once per object for some
> > object type.
>
> It internally introduced ewah_for_type(), giving the "struct
> bitmap_index" object an abstraction that callers can ask for the
> bitmap for any type the caller wants.  Before the <type>_all bitmaps
> were introduced, there were one ewah-bitmap per type, so it made
> sense for a caller to ask "Now, for this bitmap_index, give me the
> ewah-bitmap for commits", but with "commits_all" added to the
> bitmap_index object, it is no longer clear to me what the answer to
> that question should be.

I think these are orthogonal. (FWIW, I think the correct answer would be
"commits_all" in that world, but that is definitely out of scope for
Patrick's immediate concern). In any event, I see that later on in the
series it is important for callers to enumerate bitmapped objects of a
certain type. So having a callback to do that makes sense.

Thanks,
Taylor
