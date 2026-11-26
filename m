Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795725692;
	b=pmbVg4pVEGdCk2pfryivqZz979hS4e78rH6ipwv62+nUhczhHvgJpzodVOyGDa6KN97/
	 Xjt0bpMGeEwFs1W6vxgJSOCGjfyFnzvzfQhS30keDB52Lp685M0zaA6oq7Rglm+ppABxD
	 uiHATQm3XZIetUVXZZT0WlwR6JGvvpHFWlUxnXIEkc7tAhZt6gCLgXNMcJTsdQrPr1FLp
	 0jlQP37dz790FJsB5Giecji+WoEeUAHoS1m+Uug1T1gbXLDFtjt0VJkCdXsHsg2SqBYQW
	 /3Acxml/OmnTEkSgRa1G9/ZMsAtEPfw4ig0MJm/bdItyyjG8ROFQxxQaqaHmc2GqwXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795725692;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=2LqubboXPR6jUIHzEIY1sOKfMHFAkffbfYSbU/juChA=;
	b=vh7zFFFkSUiIIhgaooeGW2OEl2tLKyFJ+61kYRPRg6Xs+Xc5VsOX5yVsYggO40fIttCA
	 tgHmmArD2xFBlYgs2Tvqr3FOZ/Jked4zF0bAH7n8YCYUEbDKKdACbktfYmyW2K3TyAN19
	 7uzKHZLi1LXUyy2mT9mF3HnXIQKdmB6Vk6hEuLxB/R7oR9K2a0eCQV1YhiOtynZLDZxHi
	 8fyEm5nVqUOXIj1NceA/cqY8nDpAng4e2exluec0+D0B2PAOmgmDsidVA8s2na8CXdA0G
	 ufUK5ecL5ItaeZCi64TCxOeKtaClz1IFutIuKwMm9K2xhU/TIFioEmFDnRrj4+s9P1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=InjvNqLj;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=PKHinOQc;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630BB606A333
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 20:41:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 630BB606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=InjvNqLj;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=PKHinOQc
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BD3BC7A030E
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 15:41:31 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 26 Nov 2026 15:41:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795725691; x=1795812091; bh=2LqubboXPR
	6jUIHzEIY1sOKfMHFAkffbfYSbU/juChA=; b=InjvNqLjTMpFPW1rffwsAYC7Ud
	YrGMV/0xpsS75D+8J0FTC8bWpPKZOeGSxtI2uocbwuSztCG+GPhGijpYeoJIkcQB
	GxCqyv6lQRKayqUZBzoOrNXDjFtmw5jfIR987J6owWVxlZD0Z3mC0KT28tQvaVmZ
	ES5JyLif99UdzsqW14gyZL9wAXEA5YnHoMldUWshO6R2XNI3VSi7CpO+Fhu2mtPt
	+HPTZ751CfcFz3LobkUVbMKtXyV6w4H9JzQhXyyEWJJWJe7CFBuZEcxwc12q2XI4
	Nz6Rlk0zQ9L5tq/TCuz/8g4Vwc5RxHh9cxBl+F+UaC2GjDnqBusCKJ0hKsrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795725691; x=1795812091; bh=2LqubboXPR6jUIHzEIY1sOKfMHFAkffbfYS
	bU/juChA=; b=PKHinOQc1MWPzS8Tt/YPqW8N9MePejLfp3VfAmhxtX/6SHg8o/s
	nhffWEE5YOjQuV+YzPhrW7TlpUOT9KCrRvT29PcCeb1JOmFWDMK0vccVKeqO5eG0
	1Xm6m09zOsk7z1OZwF8MxmUsJjMAREbERBa6zCTamfHrTjhHQZDrswqMuHKcjiBz
	4zaJBxm55MVHBQCMY5vdLQQ250kR8Vfpt8Hsz7elxH/c4FGXHS3b1plo8YiYhc4y
	CnqT8lOO3d2NujA6KPk3Ua6KX7yGu3JZLoX4SWN0FNl5jWQLHyNrzza0TcI52JNb
	aJo4jPJvMuqnSotRNZy8lSiwXLnZKB3WaKw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795725691; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:AcVHMpTpE2v0xJWfcZNikVCMKwgWrGprw0u9JU5/9vopR9w
	Xs2zs7VU/a2q6wXYZoi8U242M1qSmEHQGRnpfmC0hcdTUkZ8b4WVKHarzm3ihDup
	nya7zozjbRTP3lh8Se5tHrsCbSyI5TWUnGrg3qTyi+izp82AyFvEp0WG+txzw20F
	/u8b5scZBUymGl4aEZOC7e1tddGynyz1zQYU0ACQ7tSG3j+lnE2x0K7d5BBNxvGo
	iX5c9YwhidR13jdFlP9MtHsSrenrE3oRIY6AWYM2bOhr42LBgt0jK0Ie4Vw/bnnb
	66131uOxxM3KrgO1maGYV4QKFde1VfjgUGo/1iA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Kxw3frJr9CdCtpKRdlYAzgnMJjhblaO3EFzW1jFJpGU=:ShfSRvtW8DXWKdLT+HV3FrlWUjLErZuYIY13rrFQOhY=;
X-ME-Sender: <xms:e5kIa1N452Q5Wy-QTBMSfT_iMEq74coG7Hd3kUQQ8HJWfF8fdYiitw>
    <xme:e5kIa--NWzbZAatrkaRhrldW7eAzf3QkqtCrfPZ_FHQwPo6KUWq-dtaznlL2DP-vd
    5qgrxLq56jN9NdlLisP3hZ8O64bK4qONPzkz-wtssjTCx3s-aC_iUs>
X-ME-Received: <xmr:e5kIa5Q2vu5HA4iEI_JyQkAApCJuLl22wKvsKtP0JM4djP55ITbTfxOip2vFp5ufRwDaUadbtZWzucs9wG0BCjBofwMrOoaKFdq1j3M>
X-ME-Proxy-Cause: dmFkZTGcrPQ4oa0oeUZHsohVBQbrlwS2/Opxe0HXs7bK7560CmIWMsPWHjJ7nBFoJmDioW
    p03Ap+6RjdF+usV4iOJhLW3j7JYyf6huv3sn141sUsFEjmEw/3CpAGYPclq2p+EO+O9SQ0
    UJYtuI/vKiNvjotXQWCbldq2K3vXr91XvSWaQuNCnpcSs49CshJZrx80hil1QaJ8jOffqY
    6js7Vabso45Dn9T+FcVdqb6+bgD5VYj6+QdjaxUIG/EtZXmjbg7ooLc2A4FoZ0jE95dGwJ
    kTZNAFCQE/Tb3SKI4O7r6v/qfNOKypH/WvfgqEfEovwLnheg8z98Yr0qj77hOYbkmgADK5
    NCNT+DWCiVSsyV8lnW1KANFcjLew9k+LXkeM4j1seReujUEEgck8b0J1S/GUyKV+dtnHPp
    eDsQXcBOZIJDRt4ngM94rClzYjzS3YBAc+ESw0ZNp1I0HY3KxGTx3ccUslZGELQGRl6YrI
    6+3yHpiZhwn33x52rpoOTBOdyLW/PmTCarRr7XqgfhpJiRnDOrUe1p4gCp5KkMCLM6hlpW
    25GLGniPGKfGGb+akkfmM9NtLbDwckqhfZf1x21agcv+3BZ0nuoWMW8EtIZc4PzAWGv7Vh
    yEWZQyNZKn3RU+BC3IFy7QPYiN1h90J1tKWH0ExwBcXx2VRMOaMuHpz/u5yg
X-ME-Proxy: <xmx:e5kIawlDlg2YQT2p_f89bosNhPnAx6X3fmqYqG7IspytGh1KA1662Q>
    <xmx:e5kIa5TWwRC2iJsZdJvE36L9EEIHDTI1XHMVG78ZwYjz4ABQ2rCRow>
    <xmx:e5kIa-OiV8CYGUz5F9-NkM_y_CyqqpaoSFgs2zuzQDM904CVvQmjUw>
    <xmx:e5kIayVg1yz8fsKHXaqCyAWg-M9__R11_Pky6OtMY3HjyOheqRmOrw>
    <xmx:e5kIa6OWiJksCBMgaozt0sBP48aNcg_RSCYbeeB1MiKO0yhRL3KF3Fm_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Nov 2026 15:41:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 4/6] packfile: introduce function to free a packfile
In-Reply-To: <87ik1jsmt8.fsf@dev.null.iotcl.com.invalid> (Toon Claes's message
	of "Thu, 26 Nov 2026 15:13:23 +0100")
References: <20261120-pks-packfile-global-statistics-v1-0-19beb83b145f@pks.im>
	<20261120-pks-packfile-global-statistics-v1-4-19beb83b145f@pks.im>
	<xmqqecc9ncc4.fsf@gitster.g>
	<87ik1jsmt8.fsf@dev.null.iotcl.com.invalid>
Date: Thu, 26 Nov 2026 12:41:29 -0800
Message-ID: <xmqqik1jiava.fsf@gitster.g>
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

Toon Claes <toon@iotcl.com> writes:

>> It seems that we have three kinds of free()-like functions in our
>> system.
>>
>>  - Ones that make it the responsibility of the caller not to pass NULL
>>    (this one falls into this category).
>>
>>  - Ones that allows the caller to pass NULL.
>>
>>  - Ones that not just frees, but clears the pointer the caller has to
>>    prevent future headaches coming from use-after-free (the caller must
>>    pass a pointer to the pointer pointing at the resource being freed).
>>
>> It seems all the callsites never passes NULL to this function, so this
>> is fine as-is, but I wonder if we want to move it to the second category
>> by guarding against NULL, making it behave similar to free(NULL)?
>
> Yeah, I was wondering about that as well, because there are a few
> callsites doing `if (X) _free(X);`. Having the _free() function
> NULL-safe would simplify them.
>
> For what it's worth, the pattern isn't described in CodingGuidelines, so
> technically speaking it's fine. But I wouldn't mind extending the
> guidelines to adopt the second kind.

Yeah.  Helpers that are file-scope static may not matter, but we may
want to standardise public helpers like this one, especially the ones
named TYPEOFTHETHING_free().

Thanks.
