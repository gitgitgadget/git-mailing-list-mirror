Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E4C42AFB7
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 11:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786533752; cv=none; b=e9HufGfos/PZ5WaxkXB7cg9B7RmhEacW54trb39traP6OvtB1i4apRax5pSq1VrkQxL2p2GFC761OHI7q4rbuU0EwfPBDUxUtbPKmM7YGsL1aMN5MaNcq2ReVTe+tE1Z4ADzeUXguPvuWvUyN8/2KL3PtaB3tr3/UT9xlZZqjII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786533752; c=relaxed/simple;
	bh=eYNQ5a0LpGFEasaPtT6VUjBxnBqbgu4JawShbkvrWe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2jM0vrl0/2oUfbNbI2dRfwZora+LfFLl9TvpR468pDPLMw6cSKDEb74YmBZis96e0ZfqOCza3hxCLqRusBVSBq6pfYrozokij0haMu4qReKUU6YgXtGJLi//9PfPHdbu5x5C8ZtDnxDSdN9J1yjk/4aWEQeUjQ928MMDwp55F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ho3p3ngF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M2R9VMhR; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ho3p3ngF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M2R9VMhR"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B5DAB140017E;
	Wed, 12 Aug 2026 07:22:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 12 Aug 2026 07:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786533749; x=1786620149; bh=rPKs/D19C1
	HHcDXX6eQCm/uAbSlgNHlEh1cq7/Kn0pk=; b=ho3p3ngFWcOD0DXpMFSyy5D2Ln
	GuYAe1J0+eu+68IdQrR5Ir7jnt//lHi4KRj28Ir8PtdVxDcOP8ZvIn2gdLG9A2HI
	msnATr0bnosKKeJYdlxpG2M6BKaPvZr8fQ3oxM+yJiHlxSjoFOf6aKe0J1+/i5hy
	q2MbgMDiFhVY6qAnltnbmFTD0qxzSApwfydjOUGBytt8uu3VvZ9FlM+/52PMRh8b
	39Q/s97YUeqVJYbuJhiKmvczEleD1vMaewobSpw1eKiMPLuz1fYyGELax86QxOoJ
	pg4/2jK+1Mm1Wp3uIf24phQZtwQKhCDQKVD7rOyskqF24SmZC45ZFkh5Qm3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786533749; x=1786620149; bh=rPKs/D19C1HHcDXX6eQCm/uAbSlgNHlEh1c
	q7/Kn0pk=; b=M2R9VMhRRYMZiJ0MwAavWTjwlew4oRQ/bYbaQNxv94761EaHEwB
	Pl4P7ztqGGr3Vje4OEZxX8/1J+L9xLdL9CFZI89jLaKbNgrhdfgQyKsk2eYOjvVn
	p0dNCCGyoSZaFxDpGuczYGY+WPpR5yItDCK7PVZG3cDY5qZkiMDvyM0E0UHPb88X
	IyXmwpA+/U1olGbgm7njKH9WhSZX37EjiOEWgGLr+skajh42+YEvfL6FvyWcbpaX
	ZJx+m0addwDI+l5/L1B8tCr4sTsBy2FxCcFNbp8EbnKKpk1kAlgN2lYyfvNDIts3
	kvDCb25+7h58eqdN+Ubs7JwMSgSVbAvx2aQ==
X-ME-Sender: <xms:dVd8ambszRErUMXoexBAfjGCPHOoyGVWPkq95b7X8q3eFu1H59XtZw>
    <xme:dVd8aodGgofFrzrcJ6xSTS26mwiVhRwGgDj1D0m5oO2rwRGsiHipsoXP72-gx9Hdj
    MioThucwmRfzFYXFUwOKPDeT9PjGy-rIdchLqQLDfTRtGex_OOnXw>
X-ME-Received: <xmr:dVd8anIP1mfrzEnVxaXTX0pt42U21FoUaV-ZVcYtVK8bzIDy9eBXtuAGJk-z2DyeA0i79FSmoMijaIXHkiKNcr-B2JMZk7gnzFPQHTXdhw>
X-ME-Proxy-Cause: dmFkZTEEy1SJvtGvGqdHAvSopJwdXeU8qfKVib7N2tSQcb2d+b9IdPaE3gq1tl4PjRQ5wL
    Ee824K79ESzYbfX3n+jimeOajicV5EAAnn2iGEf6nVIU6hW1udw4MY2dW3mhf0U+hbhf0b
    3YhICaN95U6bE9kuFGWpEQGimpvuAbx25HXnuS2iWOmhRODl/zf19aa+QsCLYDiLAu2eX7
    mHvjCpWV7aLW0OpZGepmP2QyDqY41jlQH1AV4AxlDuJm/mM0gN/OE/4P1WuDs3jMh4a734
    5Zm2T1+CUzlePisXbjx3jAShPsMaKC2d5CBEDccXyvfjsO9cy5YUQAFlpaMe7hAhJH+6Y/
    x6j+J8013WVDS255ivYmvg2q5ZhM3Izr/8o3nvcUI+IKMgA9bOvGTty1Alw7a4JMXDAPM1
    EtxhTF/7Oz1wnxAJYJOydP+U6TRroufqdTCCLzeiSy+pMwzea4pz9wUhLIltzD08laKyR0
    j3MU9lRj/gajVvxJk7g7ScOTmKhqtmw+zIiyz46ZaydCGe0a8UczY7w6Sig5S81SeyzaqV
    MqeoTUh3il7GmuDIzANGGLu0aTYs02cTURfcSUENJCwaXwNl4bD4b4yRvMpJdjYrwxlMPt
    BqIyJ/sWAuUbcC2blTuk3JTgusb/vN0b5Nv4mof3tlm2G9SGcXlCmwvmyuNA
X-ME-Proxy: <xmx:dVd8alIdBhZFFSZbmnfBPsxTd4CY9zTv6oStGj1HPMBJ43hqje7xxQ>
    <xmx:dVd8amW2yCp6-YzHYj0LVGgIcjKl60qFWXv2FdGkXs87818Hf686lQ>
    <xmx:dVd8aulkKCfuvqmCw-GBmPhAxVULB5HFygfdiPHhkvywl_YwYBO98w>
    <xmx:dVd8asmda46qIcrZjY6OIVa5G3XMsOOTsuGuJwYJFOxlM6xQPTn-cw>
    <xmx:dVd8aglqjK06x6GywmDHiyDVu2G5hLory9VLPk_GtzRaiQBc3rk7bzT8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 07:22:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1de8cc1c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Aug 2026 11:22:25 +0000 (UTC)
Date: Wed, 12 Aug 2026 13:22:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH] git: avoid segfault on "git --shallow-file" without a
 value
Message-ID: <anxXbnuRt4I4uPdI@pks.im>
References: <20260811121446.2080190-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811121446.2080190-1-christian.couder@gmail.com>

On Tue, Aug 11, 2026 at 02:14:46PM +0200, Christian Couder wrote:
> diff --git a/git.c b/git.c
> index e5f1811b6b..96df15b5cd 100644
> --- a/git.c
> +++ b/git.c
> @@ -304,11 +304,15 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>  			if (envchanged)
>  				*envchanged = 1;
>  		} else if (!strcmp(cmd, "--shallow-file")) {
> -			(*argv)++;
> -			(*argc)--;
> -			setenv(GIT_SHALLOW_FILE_ENVIRONMENT, (*argv)[0], 1);
> +			if (*argc < 2) {
> +				fprintf(stderr, _("no file given for '%s' option\n" ), "--shallow-file");
> +				usage(git_usage_string);

Should we maybe condense this into a single line?

    usage(_("no file given for '%s' option\n")), "--shallow-file")

I think that also printing the usage string is only distracting and
doesn't really give the user a lot of extra context.

Other than that this patch looks good to me, thanks!

Patrick
