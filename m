Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27881CF2A1
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 20:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728592375; cv=none; b=hsxKrQsIO6+GxjyIK66j9nIU+BaXv9APn1RPLx7+tbKRIX8ZVUfNExsrowsBnqywrd7G7PfusOckV5tswp9p9JYqTBzfql/umuZexjZTtS0OQjvLJJX/mHEmgUu3QJZwhkeackyKbMgk2wBW6bNGJjvkSielTLPLodZteGMth4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728592375; c=relaxed/simple;
	bh=tI7xi9ebSc6kditxz2tJuNi7YGdYTiNvTnK2p1yQUCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLKNChGG7VyivsOw1dDl0ILmocx9EV0hRPyXaV6Q08uayroHJxnrcDLuE7fMybhvS7lDCJsIwFpfFo2Mo/+c+IUK4pVCHQR0Ec1TTZ9lk3T18cATbIC6AcFZGgVtr9x1GP/tTtxULGNyzS+Oz+XLpwF2gYxZ/Z0HQ7u5c9t+SRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=spPzOliv; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="spPzOliv"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e25cf3c7278so1186371276.3
        for <git@vger.kernel.org>; Thu, 10 Oct 2024 13:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728592373; x=1729197173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YFOykvTd3xbAWHwINoj3zoXCLPUHyhCqEo5XUjv/nqg=;
        b=spPzOlivEjpJzSAtxE6ZpM4Q6G321zIjsjffdWEcPvlpXef6urD0wwziAKazM6jAZy
         4/GXYUOZ1ZOfAEI4vlEL8zA+OoAWBtqseo1Kv0xGl34L6hzgLms/33UNbfi6ie0dgPPW
         kdYirA2kNCkQ/KNC6B6bpAzanbuCHq31OM109Mbz7zJvBZi+svOc91r42WKUNPVdwB5n
         DVv//aMRXoCX1aKVwh/rjvzxw984t/KV0Err63yLuUbIJoWoMsTn3RKHRV3OBuOaXd7c
         TVjWzLvXBPjyazGM/0CDZ2jy0tK1KxdNL6cwUXcUGqMys5ZsZzp/V4bFtXBKhf6UPBaa
         dyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728592373; x=1729197173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFOykvTd3xbAWHwINoj3zoXCLPUHyhCqEo5XUjv/nqg=;
        b=HEuDOCM0Pd8HWYLnWkXbuSaFX/yUqGzu+t3gtCGSs+Bnl10O/96T4j41e0pok5JSfS
         l4MRFHtsLCaFUbG/I8tRCaaUxS0/F2XkIbm+YQcW6PIGwSRd4mLBQ0OHDCPNubg74RWA
         FVXFa5bTBywwMwnOdtCPu+TA56QZBxHRyTIfrtArszUHrQ2nJkxklsRRP3CGwZCtTEjw
         wVLeFUj5zwMTjaR1h1liI/SjC9oGf1S3ZLWn0KRw1Pa/HJW2+QwLvjgJQoJBeUM5fH9D
         FvFQBDKLsEz7ZmNKroRZQGnVQZ0ykc0+rFmvKbmn5A23tY4mf/L0cxnzt+rtkYMEKn45
         SmWg==
X-Gm-Message-State: AOJu0YxvaxRp1G2lmfXLTXex0CZjqlHVaJkv7hIDNUTSmCUvX8rRbAgS
	RTADMYOXVdirD9aEMI2/cRvMaqrZXIITsfWcVPk80bCKMkQs2/JT5lFfCb2GYw0=
X-Google-Smtp-Source: AGHT+IE1NCVjdkryOMRekBntdbPejvW4A6+77WBJWdEpJllYUjLx8E1D/j88bJ5PrpRxKR7VfpEaYQ==
X-Received: by 2002:a05:690c:388:b0:6dd:bd27:8b07 with SMTP id 00721157ae682-6e347b5136bmr1528367b3.36.1728592372831;
        Thu, 10 Oct 2024 13:32:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e332b611c5sm3411457b3.6.2024.10.10.13.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 13:32:52 -0700 (PDT)
Date: Thu, 10 Oct 2024 16:32:51 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 00/11] pack-bitmap: convert offset to ref deltas where
 possible
Message-ID: <Zwg583RghrWdgqO1@nand.local>
References: <cover.1728505840.git.me@ttaylorr.com>
 <xmqqzfnblxdj.fsf@gitster.g>
 <ZwgJt19kWVRTQhld@nand.local>
 <xmqq8quvk8w9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8quvk8w9.fsf@gitster.g>

On Thu, Oct 10, 2024 at 01:20:06PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >> So when you pick the copy of Y out of another pack, what's so
> >> different?  After emitting Y to the resulting pack stream (and
> >> remembering where in the packstream you did so), when it is X's turn
> >> to be emitted, shouldn't you be able to compute the distance in the
> >> resulting packstream to represent X as an ofs-delta against Y, which
> >> should already be happening when you had both X and Y in the same
> >> original pack?
> >
> > Good question. The difference is that if you're reusing X and Y from
> > same pack, you know that Y occurs some number of bytes *before* X in the
> > resulting pack.
> >
> > But if Y comes from a different pack, it may get pushed further back in
> > the MIDX pseudo-pack order. So in that case the assembled pack may list
> > X before Y, in which case X cannot be an OFS_DELTA of Y, since offset
> > deltas require that the base object appears first.
>
> That is what we have always done even before we started bitmap based
> optimization.  If we happen to write Y before X, we consider doing
> ofs-delta for X, but otherwise we do ref-delta for X.  We do reorder
> fairly late in the pipeline when we notice that X that we are about
> to write out depends on Y that we haven't emitted to avoid this,
> though.  All of that the bitmap-based optimization code path should
> be able to imitate, I would think.

I see..., so yeah: before this patch series we would have not processed
X via the bitmap-powered pack reuse mechanism, and after this series we
will.

Thanks,
Taylor
