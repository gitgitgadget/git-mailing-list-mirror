Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B9F1A3BC3
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729612232; cv=none; b=iRQLHTLmva0jHt/KOX1++OI6nNsakQrZn9hsotUIhfhP/6yw11mH3ao4194VuNsd6umk4iOGSLT7/lw2fLU9KOrrBzpqyOVIOUF1hEeJ1EthZ7qKqqJbuDC6+C1rJ3EJcd/c2SqexN0I/LqEYo+H5OKSeYnAn8m7HQ9dTL4vMGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729612232; c=relaxed/simple;
	bh=RiQTtCDupKW83OyMihYD2Loqank4DSJbc7pgJSEGclo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t557/PlAVwtkKv0t3Eoz2ecuIXM6ZQrfZmYv2ttn5C1g8bn76v6lyETXA51FiP3NPTd7is0qW1JEzPVMyL+puw0JvfwxTwuymYmeTgBsA41bRhd8wGkXU04l7voCQiFeIQK7J62+Me0ZF9TwGtY68DdjkH6chUS4crJeJ5VsCJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=O42N0xPb; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="O42N0xPb"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e3d97b8274so48472417b3.1
        for <git@vger.kernel.org>; Tue, 22 Oct 2024 08:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729612229; x=1730217029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RiQTtCDupKW83OyMihYD2Loqank4DSJbc7pgJSEGclo=;
        b=O42N0xPbDj4/U7Bnpxzwgkls2NdckBP4U8fIJnKlvjE2jXsXB4h/FEYI7RHO8DTxXl
         oE2eapgGhkMbqRTNGzG4PHOs8W2Qbj5t3IkRA23NUyz1lFW6SWZFhCCGscOemW3CKPFX
         rGwp6hDegFdgmaN5OGQZ5pLzj/Vq+f4/gFgAWtYrA+/YIVABJek+Nah2RLrXWyWpQNA6
         mBipXLTasCLWD+SJYIrjmpiqjGHQKo0MCKPz2jxkX6Ls9sPTyPDDCB82x88gLF9S1spo
         SALEuQj5k0JJpvQ6niPIDGjdooKnZjwz7Qvwh+pkz60zwoX0wZGbP7J4DETUHi82nAj5
         5psA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729612229; x=1730217029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RiQTtCDupKW83OyMihYD2Loqank4DSJbc7pgJSEGclo=;
        b=ojlKa5RxpgbSrztsDHGMUM5ILRilUDO7v3/Y0DNmrD8gFFwFO5XxhHanhKieC9DQeU
         IhO/pmcuixHCuWQcw+k2Oz0rPX6k5Fq4cLgqMLh18UtCzyx5gtBJaE0X1up1qPI1Jg6X
         cuQwPfvwcEDydLHCGk3SpmR/TZ7tiskVFu3dq8iahqyWOQgEwoNWb0FVzb3GGPnWR7Jn
         riilN0bYv9S5QjDvCwSSeW0Vka0PJkIjJ0VgCVixHX3S7Q8RDMO5/np8WbRaB1wod5H7
         BCnieXuSgv7V2wIrBchhY+uZjt823WKJJ8t6V38BQ0S+Ul7SEcNdnd0SZaINPSBScPIG
         oQ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUnVRfcVhiwMXoIeag5giytfkL7JLIiD+hEuAIvuBD/hjVp3oGQpWFK2gP0PPUu50foUFg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhx7IQQj48/yIZrh5l/eESzzUYkKHITAev8NS7dMnD26YXIC9k
	vWC05uLzMQWccOHqviGA3EmZN3MF9unskgxNSPqMCBBsLYGJIvdKALNtyxUVD6A=
X-Google-Smtp-Source: AGHT+IHiU5O1A5aXTGE7DO1zOgIzm6+nR0fjH/5mzsu7v1pkktyI9AqyGddjHNh17NlnDXug2TrQ7A==
X-Received: by 2002:a05:690c:6686:b0:6e3:dbe8:f46e with SMTP id 00721157ae682-6e7d82d5712mr32661977b3.43.1729612229434;
        Tue, 22 Oct 2024 08:50:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f59f5be8sm11365967b3.22.2024.10.22.08.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 08:50:28 -0700 (PDT)
Date: Tue, 22 Oct 2024 11:50:27 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: fox <fox.gbr@townlong-yak.com>, Eric Sunshine <sunshine@sunshineco.com>,
	git@vger.kernel.org
Subject: Re: Bug report: v2.47.0 cannot fetch version 1 pack indexes
Message-ID: <ZxfJw1Ju8WBDktj1@nand.local>
References: <BA07EFA0-0793-420D-BED9-ACD7CEBE0112@townlong-yak.com>
 <20241020012455.GA599236@coredump.intra.peff.net>
 <Zxa4XU+j4+SSmk9c@nand.local>
 <20241022050040.GA1247135@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241022050040.GA1247135@coredump.intra.peff.net>

On Tue, Oct 22, 2024 at 01:00:40AM -0400, Jeff King wrote:
> So...what does it all mean for this fix?
>
> I think the patch I posted earlier, to keep the .idx files as separate
> tempfiles, is only slightly worse than the status quo (it doesn't keep
> P.idx that we didn't need). And given my general feelings towards the
> dumb-http protocol, maybe that is the right place to stop.
>
> It just feels like we _could_ be improving things with a better managed
> .idx cache system. And that would fix the regression at the same time.
> But I'm not sure it's worth sinking time and complexity into this
> terribly inefficient protocol.
>
> (Part of why I laid all this out is that until wrote all of the above, I
> wasn't completely convinced that case (a) was the only one that
> suffered, and that it was so mild).

All very well analyzed. I share your feelings about the dumb-HTTP
protocol. It would be nice to fix, but I have a feeling that our
collective time is probably better spent pursuing a reasonable band-aid
and then focusing our attention elsewhere ;-).

Thanks,
Taylor
