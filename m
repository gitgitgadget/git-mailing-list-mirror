Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793310016;
	b=KmUGVjH/PAoZTTyarPEZEz1swxa4yoV7uNWDmXrHOs8pASbly7RXPRHNxcBx6ZJqT5B3
	 0MNawN8wRszeJudiBu4hjlUD2zS4b8mzHMhglm/pjxCVSRNQiBBdyeXr1T+ayKR/0X4Wv
	 IMY4GBPfhsPcp+NFz/KDnJFXoAdVZ4d96rtXXYqFt+wESeAXUlGqHF6Ey5Z2qqkFeVKRH
	 WFg5HpCtC9W8PCgfMCwguKYYermKOObkGaDdTWLpUYk39ln+SoVr62A852WmpY614zB0p
	 F1Ix65coxi8tlW1OfFXNut8N2CgReA4dKw+X4rLc2wM0wY/e52Bl7Q/hQvZ78hgtdpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793310016;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=v+Qt1w3m3rX2VnKx2IA5W0PbpGcb+YxHX+Vicp+RO8w=;
	b=RM1qRkQD4G/y2c/TBOMx3lNo05fGNO9kESKbBJ0vyF9eAoOCXuHklmOd5jbhrdnDp7YH
	 JyVam9pV99Jy4RF9oji5/K+FjNPIQEHGO6b5oOETdhy7n5xpwhHttKmWMP2fzsRkQwfUe
	 HZUp2LWHwSRItWBjAnEgLdRa6umV3iENvo5hhyAu9XxU9FfWQfZaSitx/6zwD/MdaWOW4
	 ix8QHWeId/Kb+3oJkKBA89bV+0ztMjTGQcajFnbjnZDBUiZTi50lJu/f3S1ZcU9YU+mAi
	 Ti50eGAv28quMnkjJc0Z7TTA0y6EstYYY6B4PYiNqyxcutBW98mGSJVq0LD2ZqCS+RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=M07xAOm1;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=bR9pknOV;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F368606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 21:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F368606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=M07xAOm1;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=bR9pknOV
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 799657A0147
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 17:40:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 29 Oct 2026 17:40:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793310015; x=1793396415; bh=v+Qt1w3m3r
	X2VnKx2IA5W0PbpGcb+YxHX+Vicp+RO8w=; b=M07xAOm1FNLOz6zhZ28ltHSXWH
	pv8jqGZ0H7Sfv++J6mEFYLwOSDyOs0dxFNQ7wBiH4chP11B2Il03giU/PCMIFIY9
	+vOj5nRNcrLcKYTwWBMlQi9qd5MSOB+ErRQylMLte60zsbKkD71+KYFndMpYiCsm
	0DKyipaGmF3WQlC1IGpP63oO2zVWWTbvH5T7yJRBTEXc7Z99thDGwqkFcy3jbbaQ
	0r8yeiV5a47oReLxcYQEGuF87YawV96dT8eYhjlZId+QIM8IBdN4/10QwozAsLiT
	kBpCCWyH7Wplu6mxna0e6qHcpC03Kg+Br+7W7whvpS13LhJTW/kH1QTsoU/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793310015; x=1793396415; bh=v+Qt1w3m3rX2VnKx2IA5W0PbpGcb+YxHX+V
	icp+RO8w=; b=bR9pknOVCJCAf9kP6JF1wAcDLwb7XFKiH5FwdbxKOb3OmA6xRgj
	pSJ5VYpRjLYj+wLaZliLMWqxODJTp996LlKLY6sRUvdePjkMB2dyfu3Sl7uZLH7q
	EKAGYpNFfbX7vhX5T4YXMxLGg/ybCKcgAYCqSPG9tVMShN86xZtM5/8uAzUHrgZP
	FN/oL2H3GgngjPxo4a6vb9gHojHD7AcILlJ4w0Vq5lKF6AQz6cr5Jdv8o5g7rkGh
	v88Pl6nAYWcU5OTOWrNd2ZRGD/BXF1tbECOn5v6r/AS3AANgSZTQ+mvzjcjwgwRO
	TUmCQvC4JeDgMkVxvK7e4Ew2x+TU1jhVSWA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793310015; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:F9krH+E2uSsDit1q9J/2tNTzTr8S9gOgZejiHfeyPJ/1LOD
	UUcXE5k3V3H9DpCdwdn3HyLI8MW/37iP5/gjGteDMT+vmNUWoflCxST3mIo4kH7X
	uuApTjfnndpOvHmidf5CSZCFmd+TKeWi0A+IQnADVvlW1Uv0zqFx8pcgAhBDUIw2
	llVTMrkXtsIc6D+PT7mbAYPgkeJWgNRQXAEMGKmyPEqm4DV2gX4qGhxrFSvcboaP
	JXgRKXGwTJJ7y7EafVmwWRBYyCh9NpGCQq9706gS7Gb6/FZGUB62EbQdt/GvvzNo
	H5511YJogsyU/1kHNyAUOjZA8VApvv22Bi81c/Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:NgthqylMBFs3Bz08amNwYHfDjaM0lcACbs+6+r02bRI=:4h+lAhXLxBFNXzC2pl6I2GYGVHEej0q6ibROz0y5Y+8=;
X-ME-Sender: <xms:P73javZK53q20KQ_bFvaZHxufbb1XN7e7iRtvShP6q401Pn3EDkyGg>
    <xme:P73jal3mbUKsBOabivhZmiwuK9cIORb1Z0z2P8EhoryFl8T9hGn2sh9EZD3qBBsNV
    W6iVg9wecHF1OS0feHGqa3v1p0fZPS4fqOlhukoFWpKHsjDI-fo5sw>
X-ME-Received: <xmr:P73javWr_D17PMgW-KdT-AKVoNkgIV_vbfrnXl5oLBNVVS2SwOz1TRKuNKMki6n1IiNgBc0xZMI-UpWckysV5OQpQuD5SDWj5bdP>
X-ME-Proxy-Cause: dmFkZTGuVhMGnSR3bVHK84MAhaVvC7xo3FjnZRIffa7UgWY2jo7hxpPAH5wjhFCKoLjScG
    1ZY0w2QqPiNqLXIHSUxBXYXPDYyeWJnV9HlBD15Pq53t8VjZjhTezqJxr/1BxJhBZPVvxx
    I0Xe8YxGlY6Qy9fKAZ+HX0a1Ll1y1BTdJktuhcPED0pe81tOGV/Ib9JCwTOt7GXTqed+GD
    vs9+XG7blQUOeil/ePZN9UAPxwQzxfy5LDnOz9YJ8u8fmhV5R9dgDBuRLWmt1h+rxg2lB5
    y4zUCUonW9GL90qL2jJZYcxIfmkPW6UXceKjqTlm7OGKaADrzlyBg42ltuGtUCfOvyr1fy
    sVwa5VHWxDOHMj6P/kVrxg8K//XI3Dil00lSnVXnLl1tHlys4I9ut8Cy1agOCg3zrRImfM
    y+VhA7A3hG/7Pje1Jobk+mx8a5poHcc93JAe8XMx1eaNxNMEzOUc8og3fyFeFBiB8IrzbG
    Z1PxfMRIjJBLL6+vQSgLCJK7edXnfhyzTL6XlghjVdsiQQTB/hPXQ/V5rcpj2Tibb+w+Vj
    owajGX8a9bW0wzN3m7wPCm8MTYCt+5WprP/lJQG5G9jZZ+bW7Dmzud0cPTjDDIZaLYvADi
    3WfE8JVVdk6M/8JOkiaFQK/bDRbtxcPbN9hSOSPNjaCZKtW85deqGuaksJyA
X-ME-Proxy: <xmx:P73javXYuUvT343U8fIHTqCx_FUiukYelq33EpdxGZVjHagP06Uabw>
    <xmx:P73jauf5ShmaFyGh8_Ciz57kOrBypK69FmIckQA9aos-lL0sZq53Jw>
    <xmx:P73jaoVy995aedz1x5Js-3vzpjJCN61YEsrqV6O3nN4vhGL5-3ggEQ>
    <xmx:P73jandKrpY7Fs-fwVF2tPYuUe8gDV46RY3Xq-o6jgEbTEhaZjXaeg>
    <xmx:P73jar_Ervl09fS5FiwvpEEWTVmO1sEx8INHteMcbQtD79lBpzSjgGIB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 17:40:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Edson <edsonwasswa54@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v4] builtin/diff-files: convert ad hoc option parsing to
 parse-options API
In-Reply-To: <20261029203904.432-1-edsonwasswa54@gmail.com> (Edson's message
	of "Thu, 29 Oct 2026 23:39:03 +0300")
References: <20261028170432.3524465-1-gitster@pobox.com>
	<20261029203904.432-1-edsonwasswa54@gmail.com>
Date: Thu, 29 Oct 2026 14:40:13 -0700
Message-ID: <xmqq4ie418zm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Edson <edsonwasswa54@gmail.com> writes:

Your message has these headers

    In-Reply-To: <20261028170432.3524465-1-gitster@pobox.com>
    References: <20261028170432.3524465-1-gitster@pobox.com>

but that does not look anything like the message ID of the previous
round of your patch.  I do not see any such messages on the mailing
list.

This hurts both automation and human readers, as people cannot find
and compare the previous round (v3) from the message of v4.  It seems
that your v3 had exactly the same issue.

Please sort it out before sending more patches, as messages with
broken threading will take more resources and time out of your
recipients.

Thanks.
