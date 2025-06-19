Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00F030E826
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 23:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750375608; cv=none; b=HQphsb68WBQniCiEs6+vH+RiBB48PFHzBxKw9Iwscni1I2LMk5mlU+W74XOL6LO9hKof768YP4R09lLKwHvXTY0/hXqOQWAIlU+dTjaO0yREcdLHa5Y6TUPmE93ymu34jU3/oZfmQJO5a/h5TAIZgnJfnHneRHke1Uo/iefFd0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750375608; c=relaxed/simple;
	bh=HXwflvrTxiE0aUSdokbWdGo98ZAPr+UVXGOgpnpKl3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3QPtp1IL20kLLDreAZAWn4A4PGwtoID/vHWzRKsiOTs7pNP1CEWWOion1+/4Ss6DHWVBl3bsWlSS4v9G7VOI1Y9yDMav9FFVp5Imp33xgNHlJVz1rICjkIVHFJxZWzy8VsLqLrD43nHV5C+NkuDAHuWofCdhE2AGi0C7j0h2Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Vt7KNLzD; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Vt7KNLzD"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-70f94fe1e40so13726637b3.1
        for <git@vger.kernel.org>; Thu, 19 Jun 2025 16:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1750375605; x=1750980405; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l8+NaqPksMD2d3hc/i02UlQ/Q48f9rupxrJjffUvn4c=;
        b=Vt7KNLzD3Vtu+Mr72wBOGjFW3Am+Lz0IeDfCHOQUq44x+6+WEPhQvuyarqvolkkcDS
         o9oP7WhjVWoecjNhaQ4MXeqBMD4jm9Dc+uRbGz1s2o6XwNaKfL2JmZNUuB46KIn4uSqP
         4GNje0JdY6SjqihClXIGWP1wR+jQob0MS0rD8wlcGiJ0xn02FrPr0uP+pm+n3mQPPADI
         cwfkWs/9LZHqCxN50Y3NxMKjlZfod9mYywoeyJDKYZm7ZUJpMKbhEkWfwGtEGhGqFsuY
         l0+GeUrt1axZDCV9iz4Vbo/BCnBkF8lvOsNTqkN6OkD5mAU5r35BvHgOc5Wi4sWpcts8
         j2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750375605; x=1750980405;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l8+NaqPksMD2d3hc/i02UlQ/Q48f9rupxrJjffUvn4c=;
        b=sPsv0ULoN0NWP5fQW3U9fBxCelkrZB44dOijCvhZUuyzBoREbV82GHo8yuWOvkQQ2m
         OgzsZ2c3Dl3ZR7AXhQtjrKxr8tm7ULZhfuK6a33ngUAwc0uBAg7n+kGta/TT0lVCURrq
         /AnSDlhV/a1zyzsTah0aALRgxpnGwD23OG8Ah78srcbV9GCGxlj1j3MEhG1ketaOZA3a
         +n5XhNzMe0m5xo/FYkm0GsyiTzUe7wR6FWKVHAqpXKvIAkKpbcm5rylZWlOl3PWW/+I9
         tFB5in54lkQzflZ3EF0RqE9NFH7F7xmp4TJGMdfvmGsMjQ9iYJb/4SiXP/5LpefTgJex
         LCFA==
X-Forwarded-Encrypted: i=1; AJvYcCV0GfZo8RYC/ADI4qjNNtnuMQnKWk1RUnmBhPI/66fexc7OqexL19s8I8e6G4Hf90A5EG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU+Kl15nQ773thYuFO8uT1RGEGr+xf6H11ieX+MyFLSy21SIlG
	9VZKuWi6SPHq4YAanrItVd7jXtrLfIIMHgsb8Yi+8E0fc2XLy5coEPDiIFaZsxv2kiE=
X-Gm-Gg: ASbGncsogs+T4jx08voGZa17IJn2DWZiIPYC3CIgOrBhpz8IQgqgrF4YJxDX6J2bFDt
	O4wjZyGcE3vL5ebIZFmBy3FytdNQ9C4kuCkJzS34mvQHHbyjcoxvz85nYIXDqj0bUNnoly/XJa8
	wtI1taJ0ZEtsajGxmf871r1FUWvHVnHAj2bz1yzkzN3Cq38egEKVR0MioG0fWLIbFJJQ/ZqmrCy
	SnbbkxgzDUHL0bWwzIF/VOXZDA7NHhbOiuDl5yVtTD/MUX5XWM3a2wBcAeqjBVpKk84AtrGWbd4
	yPXueCVlOazwTqEed+YKFOzyIH2Z4tHjqUs4ehFKWUzq0Z1ahN2zJtJbWGReoxjK8KuKslMmQ0I
	wLJ80fuRmby/Km46KLFSAbfAhq+X5gFdwFA==
X-Google-Smtp-Source: AGHT+IEsoSArPD7PwpYSbr3eGkChy3Omihb98sGH0ssF7OHb7Gjv/p8rcy/hQSbVCBN5sIHdSkZyPg==
X-Received: by 2002:a05:690c:3583:b0:712:c295:d012 with SMTP id 00721157ae682-712ca41e347mr2858797b3.13.1750375605658;
        Thu, 19 Jun 2025 16:26:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-712c4b96a86sm2011397b3.72.2025.06.19.16.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 16:26:45 -0700 (PDT)
Date: Thu, 19 Jun 2025 19:26:44 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
	git@vger.kernel.org, newren@gmail.com, peff@peff.net
Subject: Re: [PATCH] fixup! repack: exclude cruft pack(s) from the MIDX where
 possible
Message-ID: <aFSctDdIfvum+YtH@nand.local>
References: <52a069ef48f5a573c58a369b69827a40c7712247.1748473890.git.me@ttaylorr.com>
 <20250619130807.48057-1-carenas@gmail.com>
 <xmqqbjqjace5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqbjqjace5.fsf@gitster.g>

On Thu, Jun 19, 2025 at 10:07:14AM -0700, Junio C Hamano wrote:
> Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:
>
> > In a previous commit, `grep -o` was introduced as part of t7704.
> >
> > POSIX doesn't have that flag as defined and while it is a popular
> > one is not available at least in the latest release of AIX.
> >
> > Use a sed equivalent that ought to be more portable.
>
> OK.  The patterns are not exactly the same but as long as we know
> $packdir does *not* contain a substring "pack-", it should be OK.

Good catch; thanks, both.

> As the topic is not even in 'next', perhaps a refresh can squash
> this change in?

Yep, I'll squash this in and adjust the other "grep -o" use in this
series.

> >  		ls $packdir/pack-*.idx | sort >packs.all &&
> > -		grep -o "pack-.*\.idx$" packs.all >in &&
> > +		sed -n "s/.*\(pack-.*\.idx\)$/\1/p" packs.all >in &&
> >  		git multi-pack-index write --stdin-packs --bitmap <in &&
>
> I do not quite see the need for temporary files or "grep/sed" here,
> though.
>
> 		(cd "$packdir" && ls pack-*.idx) |
> 		sort |
> 		git multi-pack-index write --stdin-packs --bitmap &&

The grep/sed is unnecessary (I was just trying to be clever and avoid a
sub-shell), but the packs.all temporary file is still needed since we
run comm against it later on in the test script.

> Tangent to this discussion, but I just noticed that
>
>     $ git multi-pack-index -h
>
> lacks quite a lot of information.  Perhaps it needs updating?

Definitely some good #leftoverbits ;-).

Thanks,
Taylor
