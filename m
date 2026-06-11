Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5ED26CE2D
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 12:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781181680; cv=none; b=pseb8a8CEa994AmBQeuEspl+oAlhNiIrIN4O7Sut5rZjQgt9H6LkyBajPOCdxSObT8z8xKti5ZcUKa0THCzBdea1XmzaTH4UZlSyRHI9lWUoxWFxxeCFayzL9v00kUMYWICyfuxY09POxNyn4+n3hMcILYdZtt6R70UbAUAUq3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781181680; c=relaxed/simple;
	bh=1iP3ATOwkRoNA3q2xankDwBM9QHSAqQutcfDYg50098=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUQB0ii/PMUP7QEwdRF819nbEABXVetq7rx2T6OTMb2vLlhD/6f3K0c83V3tqcTqX4k0U5OtJ8PegGAw/hgqRp2T/kedMcHeuyP9o92KjscH0pXopQv1cLKrMBudLZ9YlORP4tKj2Gp6lrF2efB0VMsqCd+khSMeT3s/UrGsFnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tg2Bxdqt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MdnsjEVh; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tg2Bxdqt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MdnsjEVh"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1064714000EE;
	Thu, 11 Jun 2026 08:41:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 11 Jun 2026 08:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781181679; x=1781268079; bh=EKyDpEJ3u2
	kWYFnkdfpsZi9MO/WpUGINp5Fw8G2iWL0=; b=tg2BxdqtrsF80rtN6cnzpkFRcK
	k7qfOhhtXIAjtJ+HV/tHNuKEzSrz0ogFEShB0orW7e49WbBcwEDwWC3FuwSgs/ug
	GvZ5jxjhW33/G4+WKr2bXXBpEoXeXl4r6LvPolgk0M6wovvpa0QnrVGpYphNM3bw
	tkPsr7olQGKfUBv5wvLDaxzFGedbSNB1qI+z9BvMx3dMAU58xFcWswpQwYJVXDBm
	dpWaHpafVhBx7RKXQZyiEsxF1Kx4bCbScGeTUzC+h9L98auQwUzCbFxUTJA0iEb8
	LRyf45uq3oGBuE8ttPKUSgku5q1y0Ss7CeP5WVJQDgQPdp9+cC5ANKqaVTzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781181679; x=1781268079; bh=EKyDpEJ3u2kWYFnkdfpsZi9MO/WpUGINp5F
	w8G2iWL0=; b=MdnsjEVhmc061y2NVKpApNvpLUdxBtVLhlhZd1Ib3e+tWurdeeH
	uind6Sn79XFUo8E9DfhrPaiyJJm9DbVecd+Dw+BHjL3nlFWznD/gWtAMFY3VSm0o
	ThbUQW8RGvL0mg5lVN+A7ZuhYAy5PheX6KkWATbcPvRoQt/4hvx4Ou8GxLoW2Mx6
	YhDmVgc9QKMbfyGv1ccdUIydjQaiHWGSjfX2tOABC75tzEq0/5CnL7XGp/VgkS6V
	XEX9wbQ0hMIHUsOKws6N+CGXOoCyxCcNLht9+03RoyBqIEDthsaq1TkP1VmqZyr+
	uoEzLrRbj2vXeIFr+3ALnULQ/DOcP6CEIlA==
X-ME-Sender: <xms:7qwqaq-7XVN9sQ9zm_Udi3K0dvvRIDcU1-oeA3ndlRnIcrMgaQbL4A>
    <xme:7qwqagvDb1XqJXwqcdBWXUJA0hyuBKOkrhOkMFn5kTFjHoQIJ-Tw9_Jq6vmoK9FgF
    1ZUII74r2wvAeab3myZangdtM_BQdbIwSi52x9GOtohU7dp1D5X4A>
X-ME-Received: <xmr:7qwqatrjPlaZCk0CgzJHfqGdeFDu19ZCQRmjbx6AY59Zp7ZJk22mj__WPsW9ENOF6Nl-T33zjVZQ6Ifg7dTE2sK1Kx7_AyVyFveX3GvqOJH0>
X-ME-Proxy-Cause: dmFkZTFOHZvM4bNkoEm2ybmUF5HVTyup+3PbHpE9ZDgMQskZmDzrtZlr4H6iubiV3awExN
    zFG/665BgqG0Z40EyVMRE4EYS9K3TIKZfRK+22sDeMnv7GrbmSFpEuvuqqglkN2bfUyS/C
    7wRRTUxp2xTSkKCNcv/GozVgRbO2OwIy9Fygc7YIQRIyITA2uV5srMUlmTAglN4cAvGPUY
    6aKO71R/0vbLcM980mBD9yuH+uTWdWZ3EjuKwxZkJhe0k9tUMmChu0n7TFm9fgkdZViQcz
    P1mnQJS7f0ZmQlolx9HSJwSvI1sDAxMckI/qjEOX/hE81WEF+/w/lPbIfiVWla8xsUzyQq
    vzGrpbFXemey6oqSc/+tx/r+XD8wyYMwPh3Dvn1xpKKhfin/gPHxpKXNXW614ScuCAPWYa
    X4l/SjiB67+fm+znukjniiz/LmCRw0YJA4vwKItgzDYBC/KUNCBdl2QSZc8pjl+Zj6nWzp
    2Vh+tZBfYSEqxGda+62DfeB0XuMiTSJ5E33Bj5DQ7sIcB+kmFJQUdSDkh6/PmTgMA+NBUg
    XE8JHHradJkTIW4HgCNJXTDDoz4jetk3P9HzjbNIPqOTY9Q6fPMF69bB2IelgTKMUP/JCH
    zB/62dzCfMN1Z06flNHLQLO7nA8KTqbSpszFz+pMxfWpqZjuRYh4mRP6k/XQ
X-ME-Proxy: <xmx:76wqatkoT3rP8MIOih19OIk0zGYDMmmVfnLSCwDznJAPjLx6l9I7-g>
    <xmx:76wqahzYOfI2I0NxrOPscoZy5IuyG2loGOTeiWtNK_lENipn_4CUaA>
    <xmx:76wqalkXMjpXRZXNQoCvHaxHMcBJdDorYv5SDKGi7BX6NLnz19kd7A>
    <xmx:76wqaqeZ7ldNr7CJoq8Eyh-X_F8FVT5GOL0CEhbtUuFTX0uaCiyDsg>
    <xmx:76wqajQgbhUzhKcXdMa6UTL5W9EpVhRZ-WNp2Y5PW9Ye-i9jJas0tFV1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 08:41:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9e9b5dcf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jun 2026 12:41:16 +0000 (UTC)
Date: Thu, 11 Jun 2026 14:41:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t1400: have fifo test clean after itself
Message-ID: <aiqs5Wq2Di-6yW0D@pks.im>
References: <xmqqo6hit6rn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo6hit6rn.fsf@gitster.g>

On Wed, Jun 10, 2026 at 02:39:08PM -0700, Junio C Hamano wrote:
> One test in this script creates a pair of FIFOs, "in" and "out",
> that are named so generically that later tests may be tempted to use
> them.  By the time those later tests run a command with its output
> redirected to the file (e.g., "git foobar >out"), however, nobody is
> reading from the lingering FIFO, and the test gets blocked forever.
> 
> Clean them up when the test finishes.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t1400-update-ref.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index db7f5444da..477af544bc 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -1610,6 +1610,7 @@ test_expect_success 'transaction cannot restart ongoing transaction' '
>  '
>  
>  test_expect_success PIPE 'transaction flushes status updates' '
> +	test_when_finished "rm -f in out" &&
>  	mkfifo in out &&
>  	(git update-ref --stdin <in >out &) &&

I'd expect that such a test that tried to reuse the sockets would
probably break quite obviously, but I guess you never really know. In
any case, it doesn't hurt to clean up after the test.

Thanks!

Patrick
