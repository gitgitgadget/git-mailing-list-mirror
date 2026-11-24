Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795551864;
	b=4m5A7MieW0VJagq00e+ONtxoLNbyoIDty9RIHVQoeIt1KgoMNnULjaUyj5nBOZlF1/37
	 anSskBAtchvb7z3KQG3tJDqIyX0yTp/xyF4A8stlTg1gSAvJRzmZpbvKXTtFBFlKK1clA
	 1GDYIn2nhbiYlfFw3iLHdE2UmtdA5UICnYNKOIhbcT5fWNxTghd7S1/lDdO51fodg251e
	 l7G0q9PadJIgeafohVovGhFzHvt3ruO4gWYN+v9DcZ+3f83WQbXqp+uRdnGFkyicla/TY
	 /Q/aF+wFHG89IjNgOZs3BhL3zf7VJpvenRKe4dGmq5V93etiElTNnBTH7ogopMDf8Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795551864;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=2yQ2PJ+A03pPNAJcg11YAwOdroz2ApFcIsndOwqV7DI=;
	b=eWVL7XZSpGD2BACwqYbae9Igf3DdI/qg0KnsZM/qIqDGcVYKuKx/bFAyD9lT1WDeblMZ
	 +l4YI289JT3lwrqqc3mTI8EQmT/Q96CR6/3CZIiJynrro+MrrW9bSywCWsKvc9i+yUPQe
	 ws4ReCK0YYKdyTTiwivHjhvFGI6+QepubbTnT+U3D6xp1gIrrAJYIHjwAkoAcc/Af0JvL
	 tcCJou89NawFef0ULQthWdMSv90ED/rlSVgNX8BOHVWycAN8lWk+21wf5WlwOaenuQU4B
	 GtMvrd2kjWTUhaWPgkaFMAw0hQhe3Z4CioPpeSFMtGYWH/WQJU+ffrd89DhE/HoOkhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=BRMJuKyr;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ird50VIX;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C10606A31E
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 20:24:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25C10606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=BRMJuKyr;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ird50VIX
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 5374DEC0A14
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 15:24:23 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 24 Nov 2026 15:24:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795551863; x=1795638263; bh=2yQ2PJ+A03
	pPNAJcg11YAwOdroz2ApFcIsndOwqV7DI=; b=BRMJuKyrgcoCHFuWzJ6bLoxr1E
	8ymm0X/hqQ/crc+/LUJM3sOBtdc5D7u2ABApg528n3ZSwj46rBKSUITaUaU/pmXv
	xbXF7/BlK+6ncyqw3fjCS8pvitVwQTvhPHKyB+8SnjivdYSbWw8kowLhjLj/bGT1
	9X0lTrPQ+lUnX8XXPlAVj+3h1A7ggWeUBA+i02V7f5+03WFVN6h0L83Sqs8xW3Lu
	gFHJ1eOLDmxjQBXbqw2URtVdWf88M26U7Ys6bsmIvSlBinT5+bNzb/tu4HU6+m+C
	aZ/HG5eKZDH4rxSW9GRwOu+Uzk11Lm1/G1QZz5CDIWt7nS4Bw7qP/b82Qi1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795551863; x=1795638263; bh=2yQ2PJ+A03pPNAJcg11YAwOdroz2ApFcIsn
	dOwqV7DI=; b=ird50VIXs2PwErQNltvYiGnBP/d6r19Ea8MaxaubzBjmWDuPhy/
	6rP+fpgSJW6/7xCivKTKNRXgOyes/kWbhHRDgBwdHHfR/IoMekvxpsmttUx3Ri+U
	1umx3jX7KnHlfT+wvOzdCwq0nmOmVPmJI2zFYZxL4YN23IS38/lhrzD3Xd5IK9Gv
	dR529gAZPAY2O/mTlvfxGTpZ71RPAoqidvfwWlvmywR7/spXAGGYYQIAHnMMsKbt
	sHYKnPsw3zX7TxkI/HO7HkQBAc7e4MCpbU8JfbJffSpp9DEDbc6/eC9JA8sEqqJ8
	1tscyvuWeHFZG20kpmrlpA4MB2Mw/Gmmx0w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795551863; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:PqXnyOlJYs9IBBKca8Y1Jn5rbJNLvfjthWGOkV4bh/uMxYi
	t+3IutHILZrqf1spYgWCQ7A9qSB9UyREjUQElz+a6grlD/MPj1o9ScdzPql/H1oG
	pieBKXT0EO3rP6Xf3pODw1DZs72Y0MAaCAsPpIltHcENnDgprTTGdjYXjZHeTVm6
	lWou8D02fUWAXaULc9+Fi4lpzGmjIv3fYW/lSaJZd514TKYtUvnP0g2AYzj3U1Ky
	CXM9m01kXWdhfBziSz6xlEO6GcG02SJMjdyKAP+sckp3lw17sr9H5ylKSgmuitja
	l4LmIpRHdJNFuOStV+E/ePTRBV4X78PnWEtXvxw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:XgBt2QZajxe71KHTkMFhTvdrkLMApY+InmIEATh88kA=:SmI0l8LdeEtuGjOV0mq1jW0WfgGSjzqh7SYIRjR/5sc=;
X-ME-Sender: <xms:d_IFa3_HoaIz2-kwHslBqToKIR1TSyiO6OqJm1Bvv1guTCwb0O_3Kg>
    <xme:d_IFa6vLYAbEwWBuYo07byL3gEc6O7C_IP5_UfQyvXpgjXILdMO6XLiNvyywO3xMR
    nKFGR3Q0V92KIIf1kFDlYpmB4Y4-f_0jS3xewEAOnTQqKFBfImI01Q>
X-ME-Received: <xmr:d_IFa6BnwCdSIfsXDjZjXlzkf-1BoUs-D56g95TFUbu-mp6KWKttBP51AmhleG2queO9s5bblynUR3ICKEsSCrgFwAg9jJjp0ioQySY>
X-ME-Proxy-Cause: dmFkZTEDEJ4YW61rYGufDEKAL2U7vs5taFj7dz3oKkanEcuvXs6YsCK7jJfuH1+OyZMC1p
    bIZBdOIQBkhlssMK9bdrDLAuhmSB+QRwpnB2qm8cdEuTYw3/O+Ou1OFviWQcWQVE+FtBlG
    l68Gq0uSCGwMGrhhVrF+8nXYBjZPRp/ddY8ljdwybSxyPNKYiE3SfLw77gXLB4SEzsel3K
    73nCvQZeH9KBgPjtYWSVroXSHapvz/DFzoOIXqCjHDfuW0OWpOuneOH9LMDGSKbLsIWg2B
    y7LtiRmn81f/1Zi+L3Yp/PvinioxB41zC0tkCPhjXus+2m0PZEYL6cNXSTiWA53j4Vc6WN
    QKejx01YAlLDRLV+KcuXU7OfKGgiJjVcqkrN9Uc4giPjWu0RMhFlP1HLP229DywsSMMDPe
    +Xnrlg3xM92jk+zaEhogxWaLrgTt7M8zLyaWt4G/qNPS3NrmmVun5A2Ayomswm7lbahAUZ
    32dFt4vNaQ3CKcVV0RCnVClz2c2VmbKvD3S/E7KU+1H5+1TL1qeQdcFSadZD2anty5T79d
    PO5JgezWb/TcT9X7eLA0bjHHw2PApouK4299lHRFVXpdZsJojn/RBwlzqBuPGMoMYLg2Hx
    T16GwjuqFJtD+CfC3TLBjn7RC5LV2Cb93zXx1LfEPAnBNo5BenmjYOrJE+CA
X-ME-Proxy: <xmx:d_IFayXtpeqNpfnlqf1z29pE6ECWTSxMdl1cd15sffaQcWC8xiBTPw>
    <xmx:d_IFa4BsEl1kktwae-JuLUZc8_dzh9w8RPKHnDnScdIyOiCO5367KA>
    <xmx:d_IFa1-A6YL2o3wgj59Zvi39cseblYuTfTNUK-pGUNsf6bNE4WxXRA>
    <xmx:d_IFa_EVQMhhn_z-v_-DJTnS7lSc1Cx7rcGqmP0yRemUM0REBL2kqA>
    <xmx:d_IFa9-qB-kc4bUhhrLHqndHjjqt7xMkMacZuktS4phYD6jJ_d-uKhY_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 15:24:22 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH] var: add GIT_COMMENT_STRING
In-Reply-To: <fa8b80af26481e0dc96fd8f80f3c7ba84f60f9d4.1795516651.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Tue, 24 Nov 2026 10:37:38 +0000")
References: <fa8b80af26481e0dc96fd8f80f3c7ba84f60f9d4.1795516651.git.phillip.wood@dunelm.org.uk>
Date: Tue, 24 Nov 2026 12:24:21 -0800
Message-ID: <xmqqh5h6ou4q.fsf@gitster.g>
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

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Since commit 9ccf3e9b22 (config: add core.commentString, 2024-03-27) we
> have two separate config keys that set the comment string used by git
> when creating template commit messages etc. As that commit notes, when
> core.commentString is set to a multi-byte string, it can be useful to
> keep core.commentChar set to a single chararcter for compatibilty with
> older versions of git. That makes it awkward for scripts to determine
> what the comment chararcter is because they need to do something like
>
>     {
>         echo ' #'
>         git config --get-regex '^core.comment(char|string)$'
>     } | sed -n '$s/^[^ ] //p'
>
> Add GIT_COMMENT_STRING to "git var" to make it easier for scripts to
> determine the comment character.

It is somewhat unfortunate that we honor last-one-wins across two
variables (otherwise it would have been just the matter of using
core.commentString, falling back to core.commentChar).

But the motivation is good.
