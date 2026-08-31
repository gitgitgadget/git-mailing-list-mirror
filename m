Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B293B5311
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 06:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788158709; cv=none; b=HUfZVy7ZViAwUixYp0N5EWKlPfsMsePhDTgRuywocw9lpE6ZbJXbw8nfSsJp4yxXOvWLj2Y/mVAcKGf4K1XgWdx757Cu3qeJ14attgeXRhwzhlWKqu/hrjLi146+7d+/GUpZ/JqyXEnqZ9FG4GiFQSam5B8L9oz+fn3uBVINFyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788158709; c=relaxed/simple;
	bh=0iXKsp6LuKqM+xhfWNFo619+LywOF2+G8X7pVCM51fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrK2XqGhDQz9O4rD81IhAX2oZwxfWZjBioDCStnblGwwLFm2yugphmIQabq/EU0S/okcFoyawQKq7MDKNEIe/FL+L1RFAmwVgV8KEtLnqaNwJEMrdnYrqyZSCgVrBENBOFewDe1zeP3i9ZqDL+FKyCs+58Ig9kL5IYksRbrsKlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=THxPnwBv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iv7RWf/G; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="THxPnwBv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iv7RWf/G"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 219FD7A0145;
	Mon, 31 Aug 2026 02:45:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 31 Aug 2026 02:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788158706; x=1788245106; bh=YFYs6bvNvw
	6QWZ+G7/F9v+HQr584X5v0V8pjTdPPsAU=; b=THxPnwBv1CRD9qK77IzvOwsJzh
	BfYnoZkzMokoKKGI2JIDhfcgMdlBy1cffGN2qidJ8TJEMGxy+TrQoHp7unify8H9
	L+joFvB71d04p0OfYfb2SE5XhwPIAVDxDjgwC5hL88/Qcxfz1uzBWsv+Shxa937F
	fDbLGcW5EIGLrEQRyTxYs6DSyu/9Dlr6QAe/h8d13Ae/AVirqmlJm3DsQC0/fzvk
	VoJ5TV9n5/IOFZB9XUEKkq1avhaf7A8MB19AlZQHDTJuS4WmifzZQLDHapRhNeJm
	czW8HGSV3+rCEjGVoBJHWCv2/f6lo3PMAl6Gdgw9rPdtmMhVrdvDgOXW/88Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788158706; x=1788245106; bh=YFYs6bvNvw6QWZ+G7/F9v+HQr584X5v0V8p
	jTdPPsAU=; b=iv7RWf/Gc87LEXNdj/KJ50lg7Yp0/Y2sxCEpZ1cDEK+u8onoziO
	sXyHxBETvILZwi8racjMe982BCtdNMRbzg/vfVmAi5HCaxxi/J/VBhnB2xJ6MwRH
	V85kvJadtKCynsgG3YABO8acJWaCUlWpRwK60aDFEODNd0OStrjqW+MPJSHPgp84
	IXaepPhGV5ZSzMPmcjtEcB1zZhdm6vIGqgpiBslyyz6JJ6shAd2Y8C2plcmvefmB
	XEBdOXxmoVCyjSM5rHUJ4dFiWL5Wa2L4lA816RgMaQfVNWvfQlRDLU+c8bbkmwNZ
	6Wxx3WziWXgsJ1owioMqvEjcsedCtasVQGw==
X-ME-Sender: <xms:8iKVale4dBpoaLTgafq95dG-uxP7iPyQNj9RT6w8br-JFB7pXDqgQg>
    <xme:8iKVasgWcmcGdaaD_-SdJMvjHKvb0WqjO07gOiqU-DTlggSZYw2KvGJgof5mWEn3z
    BPZS3TFBQ_PV7uZNncUv-eheXmScS-JvhLZSro0bIVyD0L5wtSm>
X-ME-Received: <xmr:8iKValwy4WLzkrtB9uIT2o-JwchS49Vq2IEVsl3pjoXdJGkC9msq43i4FVmxIzFvPWUzYw>
X-ME-Proxy-Cause: dmFkZTF0lhxVI2SNImni3LGLJIS6/cEZ8oB5ybC9Ftl18g3G0/2qKTKY3nY/zPwzMXmQir
    QQ88m4VMWGjNts171qx3v8yLraWhdK727nn+CZ3cJx5E/ZGOFyo47x4c5AYZAKJQ7u36tK
    pyjuwm/LTwYF1BLkvn84nf3mcD1HTh2WaMave/OKB2OcadQ9GGcLGZJAlxckzK61xXnq9j
    3b5OG8VAyxTWmOeTqWrratyPQ3zZKQX3zPjZll/4d9NPmLC56NOjxpGgMtuZ8SvEAt5UTV
    cL7rNaQX2FqkOUhC7lb3rmMgPaWzVJwgrAbNPvBkvD1gwUTrsB5hDD10ZoH9E4ONb7JFa2
    SjAAFvX0eMDCZhQEZIZHUpexcWoUsy1vcMn9NG3oJoQe70vEBZJW79tLuMPgjl+Xbsli70
    jCDfOa+nM7ZxATVMQb/sufIBsLOIJJE9+t8jPxUCpzvgmTR9eAn8nJgya2NiLwDFocEwJW
    5V0FkpT4HOSAKVLTRTsOig/vQ1LdRiauGGKwSKpDkXqPoFuLkZ/4CUdwlX+ZdQuYdSeS/1
    tCnyGHS8LvL+p7dJMRSiURSm3nSFRf8sC64UjHb7r4FRNzh+HkqVy9VSS3jmr7At1xexbZ
    +wO2WdAoewrHOODV5/gPljHaC96Jlp2RGNO3407hfDiDGQtFkomDrSPwzUkg
X-ME-Proxy: <xmx:8iKVagM4ITFtiJhMqn0tGCcMG3nThYKbZmJN6KHBykVWiGVEWBwDcg>
    <xmx:8iKVauUBRA6UUOPRpKAYy6fYBMWcZwWEU2HEsZ_fUIxxbbi_UJqp9w>
    <xmx:8iKVas2QkoCKQy1v1IvXrLDRJjcXpF2nPnDMm176723oNvj0ifpanA>
    <xmx:8iKVakqxv5oZQoRmvZbxFmcQYwt7NDcLqKeo1Z_eiABGrGVeBqq2CA>
    <xmx:8iKVaunoc0mkdnKcfj7PKzETfu7roKWCbCFD9rinIKvr5JGpzLZbeBSs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 02:45:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 675c247a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 06:45:11 +0000 (UTC)
Date: Mon, 31 Aug 2026 08:44:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, jltobler@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 2/3] receive-pack: move message generation to separate
 function
Message-ID: <apUi62Q_0CFBbBVO@pks.im>
References: <20260826-758-introduce-hook-v4-0-6b14975ad957@gmail.com>
 <20260826-758-introduce-hook-v4-2-6b14975ad957@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826-758-introduce-hook-v4-2-6b14975ad957@gmail.com>

On Wed, Aug 26, 2026 at 12:19:38PM +0200, Karthik Nayak wrote:
> Post the reference transaction, both `report()` and `report_v2()`
> generate the message to be sent to the client. In v2, we also add
> reports for each reference if available.
> 
> Since they share common code,
> move them to a common function. This will also help the following
> commit, where we will need to regenerate the message during hook
> failure.

How about this instead:

  After git-receive-pack(1) has committed the reference updates, we call
  either `report()` or `report_v2()` to report to the client which of
  the references we have updated successfully and which updates have
  failed. The only difference between those two functions is that the
  latter also knows to provide a more detailed report about how exactly
  a given reference was updated.

  In the next commit we're about to add another site that wants to
  generate these reports. Refactor the logic into a shared function that
  can easily be reused.

> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 86933d8d7e..70a686c142 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -2530,67 +2530,71 @@ static void update_shallow_info(struct command *commands,
>  	free(ref_status);
>  }
>  
> -static void report(struct command *commands, const char *unpack_status)
> +/*
> + * Generate the response to be sent to the client invoking 'git-receive-pack(1)'.
> + * For v2 protocol, set `add_reports` to true, which will also add additional
> + * report per reference update.
> + */
> +static void generate_response(struct strbuf *buf, struct command *commands,
> +			      const char *unpack_status, bool add_reports)

Response sounds quite generic, so should this be renamed to
`generate_report()` instead? If so, we could adapt the parameter to
`detailed_reports` or somesuch thing.

Other than that this patch looks good to me.

Patrick
