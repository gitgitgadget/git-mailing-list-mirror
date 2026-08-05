Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A953C199B
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 09:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785921804; cv=none; b=EHIQ3mfR5YmtmxxTTc5rYjgmPTDysTpS2i7zfEDV60oZTNLJmaidrnmZK3KmCVqcKBUpYN0vQoOKMEbdtoyfF3suRgvzJIzDDzeXkvFWYBmCUHeMwBrLfe0tFWEbxd/0aohplYAvzIhD5fQkZj+2lE43YuIQYy9jfSubufcsjc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785921804; c=relaxed/simple;
	bh=Wuh/gCVVChlCJtAZKqOLpXAU/FapKNQx5n0Ey51aqZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbfaC45qmME4hceY41/UsHKMq2NNpRPMZmY27ls/Sf++QQwBKaNa3u40iZB6piIchbw+aM34fund+OvtEC31NdNJNUHs9RzsVHtDJWFkiUEbiR6hWrAAnBvgwjbwMzPR4V4gmTvAf0xt7+JDjE0H+uUKcg4CfuKdl8LHtnFna94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gobGFHLJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W9Na1+pB; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gobGFHLJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W9Na1+pB"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id E7580EC0094;
	Wed,  5 Aug 2026 05:23:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 05 Aug 2026 05:23:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1785921801; x=1786008201; bh=7GlhE33ZCC
	uDEZI+Fh4s4XghJbN283GYf+EsPJbNIWo=; b=gobGFHLJlQ+jjPyVGvAETPNqLg
	x6oUsXqafW4GcdzS/z1C3euLrbA3fQVH3SuyqvOD4vlh/O/zZUX0qCGtBK9yXfdM
	AQHe2rTIeKlgrLAkJCcoceHGncWOQttESS9IgT6IIxgm1077sXp+B8QLhhUGymwS
	MGEJtku8+qH1pKJlOY5uuX5D9klsWGyqqPdy/CH4s+36ehotl1rDZ2Es5f/DaQB3
	y+b9PkeadZ+1Uy2FIXqCBObzlPwJHXo7BILFqdLDNSQkbfYi3d5wujsxdQtuhA3K
	HPmqMWWMQj3/C0RAU8775iXlYpKjpVwggV7VwaxvxRalNxatSJsrOhv0HaQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785921801; x=1786008201; bh=7GlhE33ZCCuDEZI+Fh4s4XghJbN283GYf+E
	sPJbNIWo=; b=W9Na1+pB3EAMZ9MDHMv+KdoYe/boOUa7i1yie3i2xEBW+QB5Xz+
	OjvGZTmJv0NcwxjMCLHRskV7w+Lg7r/2WaFfv5LzMrlJTnFHSi0uh63dHGlmu4VN
	BB7SiA1U3j6jWtxgeZVnQ9sPTF89711qMusF2OPRnZVzbUTUjDJnrtwwZOl/dNG8
	/UKXhPgq8SwcaO59R9B5KoSvDRLEqftc0LCERjsM30SzpFpSZ3SwpYl2I2qkZyPx
	xRImzqiXT3rirTLl65BynF40e9QpoRzsQw4qrZfT8WvEgc6BDAA+CPB4gXjohZ+n
	OlctkB2hp3BayiCm5JWDZbsWfBJrfK6ha/g==
X-ME-Sender: <xms:CQFzakfwW7vMq2eDEFHD4pTjzHWFL6xQNVUQ6Iy5v8weSiVT5paweA>
    <xme:CQFzapcg96e2T6xdqVoGfwiLzXq3DknI9RMZCZIBwE8PQFCYRgMQiVX25GQR5aq0W
    bx-BMaVfkFEV-J3cvZMXYnc4GD4WmfFn3P0Bn_qWqp-Prg0iVoi1u0>
X-ME-Received: <xmr:CQFzau8Nf3GYJwh5Mvzu9HM67KOI-TexmgBLeCOAGBLfYvO20HwMLGiPWdas-SarF2OUXSg8oSm-o_Iroj73cc4YfEKE9kefvG5ktXJ6pg>
X-ME-Proxy-Cause: dmFkZTGBpZQysTzqwV1OOTBxRKnKzG9qj3qrnRTh3fGnnnnXoilMXVaXocxqPoeU1pZ88f
    8A0XnxYunKUt4g4NtA+AeR4kW28+cAMazPkXfS7ATtOr3zZdNDyDYNSy5Mx6B/pAuJ9pfU
    2IB3PkXhTsDOBH6LyqwS6X05JZAmYkeMtB9pHU0pd3HahVEH25/t2KRR5gu5ODqea37Sd+
    F85HeQ1miHq7QR9JXShqxirsi3kqIqopYqK98n+HyaemR8cgrazGHYfKhPTULTRUVxyomK
    YCNPBMP0Zwy0bmIApCvHEx2OGFsYIzPqzyRp0AYBuH78nZT6epmeTbzJXHgn3LFA/IVDtu
    DHU2Vh9T8byL4rSGyjOJeilysIwJWfw6krSMi9lzys9JC48oC1P7QWZAruojjV12Gs4gaY
    rycBmyEUzAEL09U0rte/WKpnX5wHz8leUg/gsfg6/5bfJ40DSHam9APzDp8eKQiF4wY2oS
    y31LERJZbXX+3vReG+Fu+aCmBt16mqVxMqMzgbp7FSmZOZpVhqpWz8yg5KengCVj5i07Sn
    j3Rt24YBc8Bf7zaScFdHIfw/OhjkETUsaYXLtmT5oPrG9eJ+aaapjd+6TgxJKT3+SskmpJ
    IAgi5hF3YP/YgMN0DQxMsS0F7XmrWNkIrrQJmk7bge+RMOKlk6BRhAkeebIg
X-ME-Proxy: <xmx:CQFzalkkU_6RWgrxFJWKQPnB9B-ECo8APxL4C82rmKod5NkhDYshAw>
    <xmx:CQFzag_xq7ZAVgoz9tohvOd-oUNMPqakhDBXulOgEV7bh4N-Mau6dg>
    <xmx:CQFzajkncOsNPiWbqx_VP_MNfdSm5T5lYDURHfA_zS60-shA8tOYCg>
    <xmx:CQFzat2puPtCNdH3oOcO13_r6vjABLuCdC5mBDqEact87ew6IhbhIg>
    <xmx:CQFzarl2nkSd4axdKozo9ZPQuxG7myvwq8Pxvg2GrGgphYgmA_OAhU3l>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 05:23:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1bd668bf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Aug 2026 09:23:20 +0000 (UTC)
Date: Wed, 5 Aug 2026 11:23:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 12/12] git-zlib: widen `git_deflate_bound()` to `size_t`
Message-ID: <anMBBW_arzuri4Qo@pks.im>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
 <ab911cf55647ed335042f5ac3a6490c36c3ef1d7.1783615780.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab911cf55647ed335042f5ac3a6490c36c3ef1d7.1783615780.git.gitgitgadget@gmail.com>

On Thu, Jul 09, 2026 at 04:49:39PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> All four `unsigned long`/`int`/`ssize_t` receivers across archive-zip,
> diff, http-push and t/helper/test-pack-deltas were widened to `size_t`
> in the prior commits, and remote-curl and fast-import were already
> there. With every caller prepared, both the parameter and the return
> type can now move without introducing any silent narrowing.

Nit, feel free to ignore: I feel like all of these patches could've been
squashed into a single one, as they're trivial enough.

> For inputs above zlib's `uLong` range (i.e. >4 GiB on platforms where
> `uLong` is 32-bit, notably 64-bit Windows), defer to zlib's stored-block
> formula (the same fallback it would itself use for an unknown stream
> state) plus the worst-case wrapper overhead. The existing path through
> `deflateBound()` is unchanged for inputs that fit.

A link or something like that to the formula would've helped here, as
I'm not familiar with this mechanism.

> diff --git a/git-zlib.c b/git-zlib.c
> index d21adb3bf5..ebbbcc6d1a 100644
> --- a/git-zlib.c
> +++ b/git-zlib.c
> @@ -167,9 +167,21 @@ int git_inflate(git_zstream *strm, int flush)
>  	return status;
>  }
>  
> -unsigned long git_deflate_bound(git_zstream *strm, unsigned long size)
> +size_t git_deflate_bound(git_zstream *strm, size_t size)
>  {
> -	return deflateBound(&strm->z, size);
> +#if SIZE_MAX > ULONG_MAX
> +	if (size > maximum_unsigned_value_of_type(uLong))
> +		/*
> +		 * deflateBound() takes uLong, which is 32-bit on
> +		 * Windows. For inputs above that range, return zlib's
> +		 * stored-block formula (the conservative path it would
> +		 * itself use for an unknown stream state) plus the
> +		 * worst-case wrapper overhead.
> +		 */
> +		return size + (size >> 5) + (size >> 7) + (size >> 11)
> +			+ 7 + 18;
> +#endif

So is the idea here that we estimate the highest number of bytes that
the deflated size could end up with?

Patrick
