Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33EC471415
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 10:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788429851; cv=none; b=fJ3VnARLlettuH2AHD+irgIavlJl7GpVsbyYKsqCG6BgZy0h3FaieleMQ0bVPEhjwnbQ6bvcnXpN09dGRLOJjwZB1Pu6Z/Ye6bFqtUhFsK/LVrXFL4HmfG2RasJfC1WZsP6qqmdMosVtoj5AneTztOMbDpgu9kkE7TvYmD4gMV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788429851; c=relaxed/simple;
	bh=y1k38iUyOlEcmi/dWdzjUcVWBGmT8D4gHJJSGOmMu0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQTRdAmAHgOlYY8cLujRDp+g/7BtWUpeWiwb1JEGSI93C++Ctgh1K1KKeQSh2z020ml7YacLdrMJ8DrBWB9lt5BDwp9tzM2bsKUbwMu/yEDJOy4cgKw+3tngopGQUsdJf1kQYx3Pi1orzZkNSuk7/jDcPctvmjpCSdySUs0gXK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=smMF2Tk8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OxsT+d8h; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="smMF2Tk8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OxsT+d8h"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 338967A0141;
	Thu,  3 Sep 2026 06:04:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 03 Sep 2026 06:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788429840; x=1788516240; bh=Y4br0oroiK
	QafBFP6ZA9trON7H3Ds0KHX+/Cxy6NkeI=; b=smMF2Tk8XL9UqVrMcgwTd0OoLi
	2ZOHTGiiu6FU/y2hiRN4yF94aBUqpycG1n08ZCQduX3S4NI3qYbtAk74gHazcf0f
	2y5qTFJzkb2Tw/MSSoeIo5oeXnM7w0ey/xOzj4QgsMeKnfXXOKCdGkCh7TRNyHTO
	kumckxCxfXu2PYZ2PTtbnfMhPui/RUJgMiVaLdkN4Mcpva/dhjwNdQuVagwavqDv
	hFftqw8zRmUJ9EyqXZiqP5dXMmsR4xjKlG8BOrW5cElCCc4e2cUu/BUOeLKcF9pu
	NpNOtA5ooFoYlV+MhKgbg3HxF0N+67FziSnAEUn+pyRDss7DdwD7t+lWMfyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788429840; x=1788516240; bh=Y4br0oroiKQafBFP6ZA9trON7H3Ds0KHX+/
	Cxy6NkeI=; b=OxsT+d8h6dbXZrrsfzbDRGJPjI7GtnYlyATu/1KrZipq/cEYO2q
	jIvT2KOGIsJO6bGETOI7ku9m8s0IFzC4+cJ9i6OGQ4pp7yrt+RN+mEstXS9CacUZ
	onHyUL/fN3tYYmOvMD6O7ABXDW+t6WA8HgduI3N3K/cBS1cVPMPjI4r5XACCT/dx
	yYEdUwodrVHH9USNHbaLuibOQjniEyNyRzwrh2WbPVoHsraVF9rT8q1fPlA4vdXs
	LUVh1nIxcPApEhITR51EiMqyLAUiPlSSC0Hf8Xpi4ziFUrdXX07EroP2kxmqVrEk
	n0LC4zIKZT8NSZ6ikH0mbY8el+aXZcuf0Zw==
X-ME-Sender: <xms:EEaZauXlkfT7fWv0xrr_lQLx5x4u3ZYYXuaLDQ_Y_GnoM-sAAa8ElA>
    <xme:EEaZaj4QtJ8cYvq9kEinPtG_3LYGjwt5_zjNNWLcvk4oKIHm0siuwsC3CjdpCYJf1
    d4O7QdBiX96S1CmdCmZZraEDXyDgByHikWCkUrrkgDuSSMlwuDtaQs>
X-ME-Received: <xmr:EEaZappt4OkjXJs68tcBHxlqeJ7MPNRGfh6092-UMxE1ZfO2T5Hm9Q>
X-ME-Proxy-Cause: dmFkZTGWUurb6DU1uBysGe7rXiCRvTeW84IhMEQI1+qruMXDjeG1g0Jul9C+KdNtvsNtaD
    bFyOnUImjBNq5rd2zr2Xt7j4dzvmCLHYF6Zc4luPJtz6C0SvHso+sRzvfe8UQvo8oR6pAF
    aFHnPfaw37d6XetpPsVnowOqBAwA8uU6KLr75c83pFDxlr+8xCZg/Wlo+PJrd6x+gnTHZz
    wAjrauJlyxR+yjnngy6U/f4xLjpoxVxcKuPhcVQ+miq32qRkd1+gON5FBuB16wiyKq1B2Y
    1Q5fSWCEg7ch7lIINlfQe5bJ3muSFdiGo4SF0T7zTvyecgbFblJWc+L2zljVmRFQoG0ECu
    U1rSSC7ZXdWx1wB5igskOF7dxy3L1PizpmZjzgsd2XFNRa2Lc3U3g0DCt0ihs7R7uyamPe
    GKo8TJQZSJuvQtroBiHv38oV3DmZN/xWMPZcSYmsKYW/2hX4YmvoCWETCQEeqyGVkpsy8+
    9BNoHzDY0zdN/0205MP0nXIhySC21Va/M2Pc5C1a8ujT1bj9VER6rcKTKsWjuPtmrQeKH9
    PtnAh9PxCcIHNcKPYqTBm2zcrVUdi4ss/od/rzDtFP0NjK115nKunMxqM0tzLXjAWEhAL8
    K86YM14cHHgKbVS24Z99uf5ndqFQXS6m/mf0tNlQOLH3zO71I8i52a9UnNFQ
X-ME-Proxy: <xmx:EEaZamklL1zWfPESSlshHOowvKqTvNjrLPIycE1VJlLusYE_zPdKXA>
    <xmx:EEaZalO6gzQs0BpUV-sYSpxiT83cUanElnX4FjDmU9lX57XsIs9hjQ>
    <xmx:EEaZaqPrznKW64Y_JtLoJg7psGDx0XB4Z7eqiKVLNrFQp7LNRXi78w>
    <xmx:EEaZamiiVkk_nksEMx8p74EYScl4mJIB_8cRPn2UPAV2xlGUBdfBng>
    <xmx:EEaZaje3dEqTlcI15ZRakNtnKSmuK81wfNKzaDR_MreG2hRd1-StsQt0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Sep 2026 06:03:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4ffc2adc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Sep 2026 10:04:01 +0000 (UTC)
Date: Thu, 3 Sep 2026 12:03:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, jltobler@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v6 4/4] hook: introduce the receive-report hook
Message-ID: <aplGBSWKfn02k7Ku@pks.im>
References: <20260903-758-introduce-hook-v6-0-6283b1fb9b1c@gmail.com>
 <20260903-758-introduce-hook-v6-4-6283b1fb9b1c@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903-758-introduce-hook-v6-4-6283b1fb9b1c@gmail.com>

On Thu, Sep 03, 2026 at 11:28:01AM +0200, Karthik Nayak wrote:
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 9ac10465ac..edfd5cf9dc 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -2535,6 +2570,13 @@ static void update_shallow_info(struct command *commands,
>  	free(ref_status);
>  }
>  
> +static void override_cmds_error(struct command *commands, const char *err)
> +{
> +	for (struct command *cmd = commands; cmd; cmd = cmd->next) {
> +		cmd->error_string = err;
> +	}
> +}

Micronit: unnecessary curly braces.

Patrick
