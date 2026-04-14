Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F009D37266D
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 21:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776202851; cv=none; b=qu7bFWx269TjDlG5nY/FCmUWkzqkM2dhdE4hdSC25itrlSY1Gqf94CuOVmsKgZCcrb4jzvdgxXsnhtJKB0EjiKCsN1BgZUizyt1TFrBiJNLqR078lmuZn0MoSmd9zWtTEvx3Zn873E6OtRMHSsIfsMDgPZQfaFR/lQYr6x1enIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776202851; c=relaxed/simple;
	bh=njMM9jsz2dB7a3a54dFNeKYsz/5OP5aCQHpYfkf0lQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6ccYL7WZEeEvoFw55dPZXF8lhpbdiiEIir0PNj+7OfS4N3Oocct39ZW+xsKmtks/kA6DrTzxYlw9YhZcCH4Dm73pbcg9yWunCGtLG16sP0CRd0/hS+7w4cpvRDf4GeHhasowOTYwH51Wq0BSWXo1SZ6TGIP9fUB7anU8G6Q6RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=DO8M7FTG; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="DO8M7FTG"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-651c366f7efso2943857d50.1
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 14:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776202849; x=1776807649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aK3nxv2LA2FXY4oj12ejXxRKtU/RJLMxSzvka+R+Nw4=;
        b=DO8M7FTGqgIQjmfv3p3sRSbAzWnhG99CuZHIN0TTvZjvIqjz+whSrnKj1uit6qEfFd
         /mRtAM27PJ63bkUTwKRkbd8agS3ztaJXzgxQFCTBeGf+j22sXmvKQTifEl70h1j4KPSc
         7pNUwtI6IrylBRgEyRssIi5kda9tbK1NvI95CjtbhERb5Ts6WGsIxC3ECnCyfGh5/8lc
         MS1xDQ9QOi39M6eoSh94jP75Frxw304JBBnjDt42k9i5g8e277f6BZ+wpRRDXfqOksj7
         yvU5/O8jps/8bxoTpE3i0wSrYkQqlpuvyW1WiVpMbTBzpSTAtLKtxFpvDQlRKfnPZ2hu
         kHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776202849; x=1776807649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aK3nxv2LA2FXY4oj12ejXxRKtU/RJLMxSzvka+R+Nw4=;
        b=b9anxUpgvUlHm2vF5pk+GHhMdoOQvDajkUyp4+YtnJnuSxouev3GQGquVzhk5/Gltt
         LTjNSpx+5q5P0yu7fLJK3LsOW1U9UKqklA8BDxMQ9vj3RZmKscHvj7Rs5a9+Lz1zno1X
         eRRQYwXnq6gpE79EUo7oxmMcrJfw/DcClQpxrCo2dJbDgZuhHwCQbY4UlL0flHF5cnNY
         eKkSGh0CZQLJrHmLbmboRSxxr/1cn5HqF/CLcHh0XFJ+JInADah25HQuXJKt5B3pga3y
         7CNU2e+ow1LbJNOOmY4BWt6/bnHLHfWqmsyCZ6LTXqoXRu/sfAgA52uTGcWdPhuSBDN6
         u+PQ==
X-Gm-Message-State: AOJu0Yw2M+O0N3z3DTQvlVGPq/ri4etQN0xeyichzxIucsMg6m/z7TPC
	NqqgAei3PMzIKfLtOoSPV9YJXij4MajZnP9Bob/IKqVaW3bOC4fTMwdgxHOTE1yIvws=
X-Gm-Gg: AeBDieurE72uCXm7fWjIRMHQP8M16KmSPKUYEPYF8Gy2oe+8sNQJAYxBSM0dyjseXzo
	EJzno4H+BVY7nzMxFE2cwL2sRlsW9n9Lyn6mjMVDI3s+zY0mz78b2IxwD/0EqVV1qoodjVvjxp3
	1tKdcD1K7GK4ASikvgNrhG1Zqhd2UjU6YCdhjDB0ERmGjlRaaYX7QQKBG15Ajro4ym1+0xvPauF
	UGt7cq+NndPi81eKypaOiJNaJ+JEIZA9lyHO94m23chnxPqGaRJjOGFA17HDMyAjuYipcqdQiBK
	yg9om+JJLQxXA+A3utq2qlvkJuCwucHduVoxM40+K/OkweHntxudS/vXBAyNhHE7M/vrfGHF+yg
	ruEo5HyBb+hl3jXAy6HXcSPBGc0CrfYrOhPcaPVAj/UzZ0Sl6LQGrv6aPh2cZzxAlRylsco4FJ7
	4Pl9Lpj92VdfPchM3gyzqBDtai2DXjlVFws6TajjgY6K4vJV2GsEAiojU0m3ajCopvxMVd+Wz4i
	oZba+Pp5DlqEPfhImrXOn027X1JC02BZp91YpsEv/UKeFD7GRtz1Ac/oA/5K2S8AxtM7qh/K082
	1U4gKOPxB47lwg3PzJBdz7emL5E=
X-Received: by 2002:a05:690e:1404:b0:651:ce5d:3416 with SMTP id 956f58d0204a3-651ce5d3639mr8754119d50.8.1776202849008;
        Tue, 14 Apr 2026 14:40:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65197bec348sm7276501d50.13.2026.04.14.14.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 14:40:48 -0700 (PDT)
Date: Tue, 14 Apr 2026 17:40:47 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/8] t/helper: add 'test-tool bitmap write' subcommand
Message-ID: <ad60X98/sbp9ck49@nand.local>
References: <cover.1776124588.git.me@ttaylorr.com>
 <d5ef6b959fd7c05c73bd33aa2b394558320aceac.1776124588.git.me@ttaylorr.com>
 <xmqqik9t9vby.fsf@gitster.g>
 <ad6xn6KmP3TsdpcH@nand.local>
 <xmqqqzoh8bvq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqqzoh8bvq.fsf@gitster.g>

On Tue, Apr 14, 2026 at 02:34:17PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > That's right, and to the point of your original question, I think a
> > better name is warranted here, perhaps: "test-tool bitmap write limits
> > bitmap selection" or something.
>
> Perhaps.  Or "limits" -> "forces"?  Neither verb exactly conveys
> that the outcome must be exactly the same as the input specifies,
> nothing added, nothing removed, so I dunno.

How about "determines" or "controls"?

Thanks,
Taylor
