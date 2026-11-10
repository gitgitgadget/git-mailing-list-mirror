Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794338245;
	b=lgZcKtX55zKuNtkb0xCXwqia/1DTQdwimDPENqYX6WVKlDydb6CJW+zA+mKDKqGgLYwg
	 Zb6WQljMvtYP0rXJ/C2WU+vqbXcN+yUttOHab9qoFmlIzouhVn+kNkaPHStfzxvbaNH5X
	 9DZMeJflGLf4w+62Pl0tLWuxLD6AtdMWyoHGfv1ac7UGE/vGNID/0IibCMTy0tK2tJUKM
	 +3PnLYjZGRH06J4S+sQolvwei0s8K2PK3KELQH7+nSRIjtt9RRlps6bR/oAhgfNJd7fo/
	 3Q15xfuwuN5gXJBaQZ1QxSBByqkG+4FDj4UOjhYIp5fnL1YsmC6JFdf/IOgE/s77lRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794338245;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=dGHqrCqGW0slpDmB16le9o8ab/fwcZqVcWfrY2Z0sDM=;
	b=A+jheJTMEUsHf6YAWHTxZ0ivl0aJFRJcxF0NdE82HKXZVn1RNXTV3chClDGiKwgkG/My
	 I2QwgrqpaXrd91OdL8/z1pgewvtq47UVg3LcinV7xSM4Hmx/prXMPjDfdIk+MbHPo4JcZ
	 whEbUKoTZ4408NXr11y2brRIlKyFpjDK14mUvSS0CrUZdahO3vWbqwCjpHvPYhwcGHt+0
	 s3MtfNEdiTqHxMSgxm1cSEth4HxKmf14JXokfjjjSbtCMyl0SbG8Fyqc1mQRSB8I6zo7J
	 hHCnXmYY2SpkCm6jh6dBvsXtrcnBayUNkEHxaKGIN7KrJwUFkCcdK0fX41lKFyxfwfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=k4ttXZnt;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=lMeGzfpw;
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56AF606A320
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 19:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D56AF606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=k4ttXZnt;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=lMeGzfpw
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 42A791D00249
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 14:17:24 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 10 Nov 2026 14:17:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794338243; x=1794424643; bh=dGHqrCqGW0
	slpDmB16le9o8ab/fwcZqVcWfrY2Z0sDM=; b=k4ttXZnt0jS3xEEhudEjbDs4q2
	LBf7vinpxJvPuqGx6IzJ1FJUbgjLDSOEG+b2Up1lNgHfyWokViKZtzudoYdO4gVJ
	zzVZo3diMDZ0i+Tl1kaac51vM+A4DFluS6ypIOGIS6A8HtHkUyjOH7qLbUG1VS6M
	9Y4RX/GO9NvYJjRPBhAsvACduTbntOwksu0mWR8O+L/zExiUkHCBkcsgE9+al33W
	Xel2gXpH9d8k+ielf8ozyReUKxUqOxp1TwIR2xJdDgQqezMbaAEo3vkhY02j3WuF
	KwY4W9j3hyceRsqP/dmI8XAdL0OOL6RrZFL3NtWsuBVMORfZN0bzIB9rNC2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794338243; x=1794424643; bh=dGHqrCqGW0slpDmB16le9o8ab/fwcZqVcWf
	rY2Z0sDM=; b=lMeGzfpwt8ZpMoO75VE95gst5B6d7lfW8107I2OBaaX+3HvOeka
	UVmu3BFxoLqTO1o90wkL/HJeD9vWVUzV0NUxoZsyGtdrKjqso3SX4dfTxN/8SqA2
	+UM08k+o4pmYfu++1qT3KI+v1TboD2lEWaKl/x9JfrnEHVHCsFMroy797tq8H9D6
	b2ugZEQhW2RpuqHXOj7G67NayZVqZG0e6WaVRD1QYXU2saUa3f5u4xW3GmbO+PHc
	Q9lTukzqYgjjjOgt4yeY2B1miuLBrs5xq2P6TVOIHVgRGqhJXFqMCChvPgG3URkV
	Ca6G30ARarPYNT6oTOQNHTDeFO4KE0Q+rhA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794338243; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:QWNNDBbJgJyUaQqWluKuJAaeI0GeedWVg/6UXappWS2uwB5
	Mt4jj0lMDi378X29G2u0yjx9PuLRUEPETjoCt0IQBhzwtL5S9l8hq0XYO1KD/9g/
	SV14EomGyqCBWlU5wlwr+Cj9YQJcB6L+RsfGePprrH49DOLTCykUkjaZypl9OymA
	i5Oho6xU802DuJzp8DMtkEEBluZQcOSgbhwNBj1daVBl6O38dHUWLeyjGGBrO/TJ
	8ISl+2dpMbj8QoqdzpgcY1lyWglA0jCRJG9VSzYj5Eftc4MzL8FgnjvL/7XonNH5
	ho9OcO0M8Rn+U8xaSpfe5tUxxmTpIKGu9fmgqIQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:FbfZpQoSLKpKi2Y6dV84h1LOz7nUFalFhvAQ2GyYoEc=:pjOPJvgxbVDVQNehD2E7sozuWy4yp9gUZEuiL9/SFs0=;
X-ME-Sender: <xms:w23zaq3rYpxejW1VhrXc-k4khatKqWKV8S_mC6jL_EHayjRxntqUaQ>
    <xme:w23zakGHhiIZU_HhlkIBm15iHwMlj1F84sCokYtamnEckW4dyqjpuIozEaaID_arU
    ocMAxsgari-MCEtpe3upKbTYdIEyy8CD1M9IxEnoA2JxX487teCdio>
X-ME-Received: <xmr:w23zan4KogyE1iRV66EwAwjajH7Xl8bTbVH4SQAQSmQ1USZ__fZyjPB0MRjPRCbxGpwVFGvj0mCO13k1_b6faXosdlWOYtmWSlg6>
X-ME-Proxy-Cause: dmFkZTFwlcWpuuJkw+dnTLw7tuw5NcHjJxmK3ZmUZCb3mPlxO0avFHYJ5cTngS45WgJVOn
    yF39+fSA+osNVG5OiV/Y12v5OPFJe4zmvvm6FCpvwzl5bsKBoFAE5Xk/TiB2Nmk89jCf9h
    mT4sWzW5005L02aOtezQD9lYTaXANI0cAOALLMVJ31A/KpbASH9WLLTaSmhPlpRoOHBh8w
    tV33HwSzzzJXsqKlryR0ivNIHhgXghXME5DV7GFrGl0IsX4Xj5F1nbqDSdXaVGucXZb8ni
    qW/jTAvmBzFlBeRBCD2tblV9FSTz3xgoInLBEo/UsnELdFG9nstOYw6v5PvWJ17vaQMQVL
    s3Sn/X9OqS9AYyAvUpbjs/zWprRCSWz3f48kWYkrUt+spTB1eebOq0FfUFS+89m2YgL264
    iex4gCjSDxtg5+AFI7r7Vr28XYToZs4xRgR7WtqY0f0/euH9PmlS51A6iRXR/OppYVdPdz
    IqoLO4EEyL7IMLc6c0oqDVh8vipPhHLYuv0Td5+BdymEFSbaqj87lZHCuLsbD1xCYPxpQt
    HMK7+a6xGrAbUpCutH1bzp/2YjduNxE2/Te02ATCNUXCB9rPaILgZGcPVLDBmRsqi9h0i8
    kU7UJhAfSyoABlPEPhTkMtJM0ItL05SMWBLDgAtq7tnvdBeqVrFaeojziXwg
X-ME-Proxy: <xmx:w23zaqu5s7_7ux2rm5UDjNbRhrSW8f3DRaxQ39p6e7z2xXGyFpWbJA>
    <xmx:w23zao7lOjlZfT5qOxt6aDpdRI-pGWZXl9hLrCGASSrFlmUP2ELMNw>
    <xmx:w23zalWfz1l7_Q99h5njzrvrZN6WhUGrfrTYOv5jnQh-L3KE8dOdcQ>
    <xmx:w23zaq9I1OZXsxfTo2e1IhIpnXah7MKBey-JCRGq0mxoPT73dqa33g>
    <xmx:w23zajWLwDfUgIz_1Vdh9ueRNTjj7Yu5uf-sSQ3tdu5YY1w6HeIt_gDb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 14:17:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Srujith A Poojary <poojarysrujith@gmail.com>
Subject: Re: [PATCH v3 0/2] [Outreachy PATCH] archive: remove
 USE_THE_REPOSITORY_VARIABLE from archival modules
In-Reply-To: <pull.2305.v3.git.1794335969.gitgitgadget@gmail.com> (Srujith
	A. Poojary via GitGitGadget's message of "Tue, 10 Nov 2026 18:39:27
	+0000")
References: <pull.2305.git.1794251100.gitgitgadget@gmail.com>
	<pull.2305.v3.git.1794335969.gitgitgadget@gmail.com>
Date: Tue, 10 Nov 2026 11:17:22 -0800
Message-ID: <xmqqzevgqywt.fsf@gitster.g>
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

"Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Refactored archive-tar.c, archive-zip.c, archive.c, and supporting files to
> use explicit struct repository *repo pointers instead of global repository
> variables.

It is not considered good manners to send a new iteration before
first finishing the discussion on the reviews you received on your
previous iteration.  You respond to reviews, saying "I will fix this
point", "I think this one is fine as-is because...", and so forth,
wait for responses to your response, and eventually come to an
agreement with those in the discussion, so both sides know what the
next iteration should look like before you start working on it.

Only after finishing all of that do you prepare and send a new
iteration.

Thanks.
