Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20DA472F73
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 10:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788429843; cv=none; b=LJli8hBbIljvkHTN98EHdOVwWywF8o8tgUtCjGQeC02PorXRGQyLKS0/h5Yyi3egmrCV4/1RMoafacvvoFy3/2iK6+OC3SKxwEW2rEAFl4+DaJb6tARC9oNdKq6QnpwNip8zHK8VPlm42J+hHjk9llxAjkGWWxwU1Ytz/G+A9Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788429843; c=relaxed/simple;
	bh=G2A7ay7oDmfxJ+/JCVln6gMIyUoCKph1vs2WAmKrj6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0OQoM2GwTCpXw0Q0N3K9fuFT3NA4coDYNvLzZ2w/AKxx5QFlOoGkP1WRKCGK65ItUijgsHGRBOlH2xaO42cw6XDBe0X1CR2ODLbQnOxWTmT3ySO1Ym5XbNaY62J9TObvHZG9kQ7eBRq3cwBbCx5JfJN4LuETZur1kA1oSRkojU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F2Mm+wH8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q0b24s/V; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F2Mm+wH8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q0b24s/V"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 938EA1D00150;
	Thu,  3 Sep 2026 06:03:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 03 Sep 2026 06:03:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788429830; x=1788516230; bh=BjFg8OGIli
	sszqT8YiAXY9CcnXj7JXjVdYm5BL63rj4=; b=F2Mm+wH8Wr75M2hD1W289oWgO0
	wUljbiJZGlG8abOe6Mi4HNyRnphACsWg1Um9UobHt1zaLrnIu397cNTXP90N2dQk
	oBv676dVLrICzhwjskq2BVZ3GX5Rs6qgMioAa/fMo/sQKtlE1CsoLMiku2/+kze7
	DJoVqe3+YP5Nt+fCceAVDRQRkP0JSHR+xCZ/hwKYli7kXiUK/Ord7rm9zkKTlePS
	IfBIjl8sUdVG2v4sU/3FfFv78SLPW8crFP6umfemeulHFXrPsHYYoKIssFynrYiA
	zS17SzF+r4A9WM25T/M8kNKZ0b43PwQzz+ghXk1uqyORR7PlRM1vnkEBcdzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788429830; x=1788516230; bh=BjFg8OGIlisszqT8YiAXY9CcnXj7JXjVdYm
	5BL63rj4=; b=Q0b24s/VxD/1Faj/zEJ4pLCJbB5BESVcV+2rDJgiH+uBwKACBX6
	IXbaK+H67IopQt+sIulGhP1fhIm8oOttA70a0a8Dkt7fiKphFnf8XExYymVeqMLB
	JDu/QatpSF/y2dKLjNl2u6qDCzbJsT3X4iIpr6OCqC1MnK+tllUYkE++pzLVc/kG
	bLw0WY3iaDOvzdU6tjU3BTysayyxbwDWiyUlKh2FfyIo+4Naob49x03qHEn4FE0o
	Wwe0tGVXKlbmHwL+83eRq/k6etzBMXsKKhwMRYJ36VvZSVj6QXHeXytXZNu3NdqV
	Vk6E66/gDwUVzPM7W3UUax6rIobOAf3RQpA==
X-ME-Sender: <xms:BUaZavrviyNXbAheY-G7rgohTOy1SfCnDycT7xipVy0KzZOJeQbuNg>
    <xme:BUaZai85lcbYwsi74qgC-kkQjds1Wty2VgEIpRPblSAsqTpEQvsIYQorpdPZLTg0h
    tJsX_RM7aCQq5OUdPG3XFOW0p_ri-PErejbWLfKD6RrpUG1Lyt5QfQ>
X-ME-Received: <xmr:BUaZajdis352yQHd2K3kOKReHVnoPqOh88kdKWl3XDXxxM8sCw3ekQ>
X-ME-Proxy-Cause: dmFkZTFi60GcvFnvry02xxBuL3KSmu6IyNJ+R11mHwXXtZe3Dx5+qQ3b4yu0oo+M9D/WpL
    rkrAyZ0ntpQnhJ9Wd79oRFUhv+XXFxqplKcOtWndV/Ao+jMrZPDjIHBY2dnlLA3+leVAy/
    +/uH/qE/euLtDCElye+28Wkmvzf9p6lwHYNA2VMLm+CgMhyHbGiJjuzRTBRVOuoPaGZf2z
    63ML1nfZCzf4lwssapzBEcBs8apgU6gJlgXy9gmSe3TKX01Lov+tReOZ02Dwf+VkwyJc4W
    WmfHscBOr+RW9UsQRJvBzSIFgTVgBd/OjUAr46J6ptMVV6+VHxcDFOCgBgCCU/b08ISGlL
    LM7yslQ9z8xkZ/v4Y7KaRkx2K2UMibLOu8/kWb6oaX3rB9qBO2I1TP+GYQiu8Qys9q9BSg
    3LOSm89VeUQzAxNd7u6b+kycQiRO+kMwCupLVv1HDdfkVBEnVlABcLrgLkGWzgTWmROWVz
    OeiMvdR+ltdZCBKYCSkBOOne8h8gAvnS6RYArTYx5JPhBKnnE/Qy2K3UG8tUsnQy5CKCbg
    ecd5uu7Tg/+FYyXnCMK4r9ZCb3IlQXIuls4RjQVlKA6RMeYomWxdr3/UUybwKACxFbNC2O
    ErbVg0PU0qdMBtjIiKsp4PB7ZT4E2xr+hsxr9fuG4xY5PqgLtBYZU/D/B05g
X-ME-Proxy: <xmx:BUaZakJaguh4LKt3IfrYkQVJpwN5IoAXJKFskqQ1zmMLLgFKK84BYA>
    <xmx:BUaZargweJveAQNvdMPAov-4vcK95B24EMVSeSuwsmgTZfVT8ObX6g>
    <xmx:BUaZaqQSYKYzYOUpleV6dBmb2ZltrN4vlRl55HCgMUBAST1eNCLWAQ>
    <xmx:BUaZatUjG3p6tGxfJFunUpiVeO3HLQFbQr_1Ekt7KYawz9nyqVAK6w>
    <xmx:BkaZamzKhFviCunVOXTLrk9wBxWoBrz7CVfnAcKxrCkstlMC-FW6ilZ4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Sep 2026 06:03:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ba0dc5ec (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Sep 2026 10:03:51 +0000 (UTC)
Date: Thu, 3 Sep 2026 12:03:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, jltobler@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v6 3/4] receive-pack: move message generation to separate
 function
Message-ID: <aplF-zxlGRqZs6tf@pks.im>
References: <20260903-758-introduce-hook-v6-0-6283b1fb9b1c@gmail.com>
 <20260903-758-introduce-hook-v6-3-6283b1fb9b1c@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903-758-introduce-hook-v6-3-6283b1fb9b1c@gmail.com>

On Thu, Sep 03, 2026 at 11:28:00AM +0200, Karthik Nayak wrote:
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index a9a3d21c24..9ac10465ac 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -2535,67 +2535,72 @@ static void update_shallow_info(struct command *commands,
[snip]
> +static void report(struct command *commands, const char *unpack_status)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +
> +	generate_report(&buf, commands, unpack_status, REPORT_STATUS_V0);
> +
> +	if (use_sideband)
> +		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
> +	else
> +		write_or_die(1, buf.buf, buf.len);
> +	strbuf_release(&buf);
> +}
> +
> +static void report_v2(struct command *commands, const char *unpack_status)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +
> +	generate_report(&buf, commands, unpack_status, REPORT_STATUS_V2);
>  
>  	if (use_sideband)
>  		send_sideband(1, 1, buf.buf, buf.len, use_sideband);

A bit hard to see, but aren't these two functions now exactly the same
except for the enum passed to `generate_report()`?

Patrick
