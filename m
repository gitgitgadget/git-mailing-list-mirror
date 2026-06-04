Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4978B3D6CA4
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 06:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780554475; cv=none; b=CnD5XQ/SBfthSZCeMxNklT/VwUZ6pP6Z19DnQ2EpdaoiKgPyr2PZ4eQ3G8WeGNlMS+a0BAHyIjApEx2rlP/wNpaTFM/z9IeRH9Mtnzgq3+XqWwk6cqrwdKAWMI7cXXuXStcqMNR7JwLvzgUboSCYS8WNSK8sjtZPEnGLC1ALAwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780554475; c=relaxed/simple;
	bh=mPqiNHFlGviefyx4t1LpQM6ugpsNP3kSVqGTs24HaH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROqeH2Hw0bs9iXMAoqAR1L/KkmiOxTA4YDIibAtInIlA/7YPgXbedIH6U+ikJvMT1o5YhG4mTsOAfR0lBsG4tV90RoJJN2ywTpWN0RI4AyB4WTSsNi4rYz06DMv74BflxnNcTZiUfRX2Vf5v5zoolwhYg89fejyGpqcV2aiW4Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=r93pOlIp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UjzjWaui; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="r93pOlIp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UjzjWaui"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6754414000DF;
	Thu,  4 Jun 2026 02:27:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 04 Jun 2026 02:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780554473;
	 x=1780640873; bh=uQ4N7Y3ubr+EsOnwDbX9xkKmgpW8WvTXQtp+DY0iUtc=; b=
	r93pOlIpZv97mWwZaWVHTfZ8sxzFo5KfHWF0g/tU4Km2r+T5+OUcEh0P8Tm2Vbll
	fDNs3S3Fb4vaMHCOvYiygvDKr3Tg2euPKSxi4lnLgCyOkz+NPLGyKz39RGEAP7/9
	vS9iH+KP1FHQrCUkhvwDCZ7/SGqhBE9wvtOxINpjKZldKGpSTVze8LMnRA9Gvbdx
	iDU9K1hoF0iQuF9Kup3qkwF4NzF88VXwJS9cT639qeRWXyFdQssK2DPql3JJ+0H1
	uTQXt+ilcML6stXxq+0Im+6AW5n8E9LUkBR3pqF39jr5l68XR4bv2tyZDN4PsobF
	J9dFG0oo0bR6mJ4LOBTYRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780554473; x=
	1780640873; bh=uQ4N7Y3ubr+EsOnwDbX9xkKmgpW8WvTXQtp+DY0iUtc=; b=U
	jzjWauioeP3wULDMGV6e+U1YCgi1cUPQp3D5jXHXqArUfHjfxYSXJ10p24/XRvgK
	OIcJ1LjeoHz9pmny9JLTmZ43FGz/OONNczGfgm707fghPQESDmiq+pi8K15Zn+0k
	8FcVHiEbx6Z+ol0wz+Fx4ez3vZCIeDhZGoDeUGQ9cpHlmrZj2XkgppeclVS8Bmic
	gy/UtmxDGNdgCkoFwOAjDAM708NQs2pXTaoaqGgUimhGg4J1+Z0h0/4dOc5LDffQ
	PS9MlGlTnrA6DeIFfrHV2TohBG3kcJ45uG/Sp3S1KnBcGjwT3FG530x0ziKH8d4m
	0h6HWUUeyYEIvia2vj/UQ==
X-ME-Sender: <xms:6RohajwaMaBhsdrjXZvlNu_34ywSXOIT0ckotkiFnw6pl6wAqT_b_g>
    <xme:6RohaiL69qQZ4ZjBlzSrb6mA0vaGuxQmPOtI3D6McXDi9RC0EBZSTyz7jthnNWV2O
    C1yrC-s_I_wxS04g6KqeRdmvijRV7rs82VCtuex2RGUCxAkqhs>
X-ME-Received: <xmr:6RohalqfTdiOewTmwKRRSnjroENTaWnOhbxp7W4ad-TFeFgJW8cTTr0yJ_qnoZN-_LJxzHThQLoa1lSowth8VM1_T0nfBAtj0_ZAQWTUVqc>
X-ME-Proxy-Cause: dmFkZTG4nw3PqZR4y4BwJb8NNIKNoYx8B59rEfEPbhcDG5MXq9OP8vFDQwC5H1tW9tiRqw
    syLaDVoPjdpYkJQXp9NOjjOf+qCBEwfgdalLOK+b1wDXlBsMvaylAlsQRiHhikbCKAouxw
    9diy4AZFdxnQUnLtJ7V5YnwTiuqQUQx0F7Nc3wmMCrL9Fz4OkLGKYqPT4BWMDtIkyZRiVi
    qs8dOvM2JkipIB+YSvh4aad5VCQ05aH0n49DTSIWk+itIq+rCyv1cByXTodmRhm7g90g28
    Q3ngj9xXB9s0Y5ngnmf043DCx8A2b/O4/9SYuGjv7KIjbldQIEN5O8pGhLYmDeCMm4ZpC9
    aXO07NLcv+hMYub4cIgsnT5G9ci0b5PcQkhT9Tw5BSzNuS8jAxAAwk/XI0VibSpiq/DjYZ
    0SyvzmAfE/U+GrJhkGs+nmRjwukeAu7bAjrNYOKbA7qcfrBCmeNFLfmAi5CBp/wkM2CGzc
    6VaxTWBqnwmXRU5UiYCkmFm6hBOaY8jGGTJxGRveOxKC1ylghmYOTgerp/+h/Hy//dkL0V
    T57X7fgW00KjZyAbzyv8SdT86Ju8g+bvNsSjVyGhqeKIGd7zDA47cyq+/d1vSmhe7qx00+
    4kYbqEL+vA4JVGK0eqnISxMQeSV4G7k7P6E7vvmYI0ExI8pJqamhYpyUxvrA
X-ME-Proxy: <xmx:6RohapLf0E5qGTPvHRa3xd5ty4R2Q7I0dQdl1eng6oYeym8Py8OhCw>
    <xmx:6RohaiQaeiO0t6UhqRJpx-IkZDvkg3uw-o7N9xCoMxpfQx-QtpGM_w>
    <xmx:6RohagvTpSMDemg0JZqHDJ9WbB6p8nfQS5dsQ9y8j4vjpvPqtzGYvA>
    <xmx:6RoharYFlJcaOMLkuwgHSDmRox9A-5BA4pyYMYG450YNz0HvFCSL2w>
    <xmx:6RohakasGeW84uGsokopka5aa_hhFSv45H8Xn7HaPzSoGJNskoI6UM48>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 02:27:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b7956198 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Jun 2026 06:27:50 +0000 (UTC)
Date: Thu, 4 Jun 2026 08:27:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: kristofferhaugsbakk@fastmail.com
Cc: Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] doc: replay: improve config description
Message-ID: <aiEa5EWeAaaMsqRR@pks.im>
References: <CV_doc_replay_config.709@msgid.xyz>
 <V2_CV_doc_replay_config.767@msgid.xyz>
 <V2_doc_replay_improve_config.769@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <V2_doc_replay_improve_config.769@msgid.xyz>

On Wed, Jun 03, 2026 at 06:04:23PM +0200, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> 
> First of all, this bullet list for `--ref-action` introduces a term with
> a colon.  This is exactly what a description list is, structurally. Let’s
> be sylistically consistent and use the description list markup

s/sylistically/stylistically/

> diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
> index f9ca2db2833..4de85088d6c 100644
> --- a/Documentation/git-replay.adoc
> +++ b/Documentation/git-replay.adoc
> @@ -211,6 +211,7 @@ to use bare commit IDs instead of branch names.
>  
>  CONFIGURATION
>  -------------
> +:git-replay: 1
>  include::config/replay.adoc[]

Not quite sure, but was this change supposed to be part of the preceding
commit, where you also added the include?

Patrick
