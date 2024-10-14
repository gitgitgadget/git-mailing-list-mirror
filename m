Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1B61D1726
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 22:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728945299; cv=none; b=JaYVLuyFUIsPy5qCDY9M5v+MJjOgXGOqFnklMKvZHgoaoxDuPeSQ0ewTYLTWkRgoI0Iop0HwURefVBbloUpFWB2LLSH13S7sOyx6MHKj0o82kHzCRpePu2OGZx7e00ewbW8AyaPvGY33jhFWyJ52rEUFIF48xokwoHesmer10c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728945299; c=relaxed/simple;
	bh=xbTcPvdYGcCKPwvLAeDz0hhGBU2aTcWFayKgYgAevvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ER+Kl0PZkTYmvJCA1HsBIy150BPV1teoCunw+yR2diQpiQqulXNpHJ1gokFNxCAFSOgdRTTqk71JJ8hir430rMoZK+kWb0DOG/sZNu8IlABtXlHXCa1olyx14EXIoCHFALjBGgHkD388RyU620bLzb2Sq6cyqPheDZpzwbqsxZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=o28hnjXX; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="o28hnjXX"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7afc847094fso374371185a.2
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 15:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728945297; x=1729550097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yGykJE7D44teG8A5A1hq7Zq1AG9pG19BM2KCdrvvV3Q=;
        b=o28hnjXXiMZ87ey4qmBLL0s9lN9CLwx4SZYpkk6a/aJpb2dcIpIMqEDU551cGxI/UN
         CokWZhCl8toIoGUGfQwApmGJoyprp1JHCd9MPQPxWbzgBAAx64w8HYUmlA79kIe0tSXO
         taHpGglGR1Y8IwpjAOPKoQaexhS6f/au4LJBg+ntJYmK8oHgZ6m6y+xW7C6fleCWcpRD
         liG0M9NCCE+BEa3+mEccAzkyXOinzTjlFzZvft91xTAf8oHUNKfK3iTfN5jy88yedP0a
         FWmperJoVFD+F1OK/72jaoO5CCW0GsiiWwf4V8sAUORvMnXEMN75GqtTbvsXCd3c3Bts
         wK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728945297; x=1729550097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGykJE7D44teG8A5A1hq7Zq1AG9pG19BM2KCdrvvV3Q=;
        b=YqHVr9KoARKMiUTuxgpIHL5Nz+PXBmFdcPbQYQLX2B05p4HjfL4fRrKqz4tqePbOYS
         TcCHgCtVgHP7yrlqQgzweEG260Fv33PxikgJTqnixBis+xlUALXbnJFdbVyMfLfjg+pp
         2avLJPB/ZRHZxdKJwjeQbjvPueedLQk9Uef9VEEp9eFYzWGICiNlsDHe5Be48Y8PwsGU
         QntRAmhGVSsrjmXUmJVJe35EwS8T8rOBLQWyvNuD4lyspXh++l5Teu4cYpS5OHkpiUo3
         31EuzOHYhww+Gm+fLJ24AmcbsiWZz3CRD3tH8biUKNWpaOWu2v++qDQR6axTbFyQEhhW
         NIkg==
X-Gm-Message-State: AOJu0Yxc9L9mSmOObV4s2tMfZNIfX2lR3NEFqzTphcjQAn3o+r8CpAer
	59Nb9sJ7TIKF4Ry68Rkq58bWrcg4htxW8WXcTBlqbO6MpM8gm/EtgjmF+4IIuhA=
X-Google-Smtp-Source: AGHT+IHW7B7sO8tpiUZX0mkjwTCO8p507h2pvyxWd/Gmhz1R+OarJmmYRcEmCC41keAuYMJ3lBoLkQ==
X-Received: by 2002:a05:620a:28d3:b0:7af:c818:bca with SMTP id af79cd13be357-7b11a3a7436mr2035838585a.46.1728945296820;
        Mon, 14 Oct 2024 15:34:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b13616fdd9sm2482985a.45.2024.10.14.15.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 15:34:56 -0700 (PDT)
Date: Mon, 14 Oct 2024 18:34:55 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 03/10] reftable/basics: provide new `reftable_buf`
 interface
Message-ID: <Zw2cjxpDf6MowCP+@nand.local>
References: <cover.1728629612.git.ps@pks.im>
 <cover.1728910726.git.ps@pks.im>
 <0ddc8c0c896a006e4cc094390125efcec0b3cdff.1728910727.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0ddc8c0c896a006e4cc094390125efcec0b3cdff.1728910727.git.ps@pks.im>

On Mon, Oct 14, 2024 at 03:02:24PM +0200, Patrick Steinhardt wrote:
> Implement a new `reftable_buf` interface that will replace Git's own
> `strbuf` interface. This is done due to three reasons:
>
>   - The `strbuf` interfaces do not handle memory allocation failures and
>     instead causes us to die. This is okay in the context of Git, but is
>     not in the context of the reftable library, which is supposed to be
>     usable by third-party applications.
>
>   - The `strbuf` interface is quite deeply tied into Git, which makes it
>     hard to use the reftable library as a standalone library. Any
>     dependent would have to carefully extract the relevant parts of it
>     to make things work, which is not all that sensible.
>
>   - The `strbuf` interface does not use the pluggable allocators that
>     can be set up via `refatble_set_alloc()`.

s/refatble/reftable/.

> +/*
> + * Add the given bytes to the buffer. Returns 0 on success,
> + * REFTABLE_OUT_OF_MEMORY_ERROR on allocation failure.
> + */
> +int reftable_buf_add(struct reftable_buf *buf, const void *data, size_t len);

Is there a reason that data is a void-pointer here and not a const char
*?

Thanks,
Taylor
