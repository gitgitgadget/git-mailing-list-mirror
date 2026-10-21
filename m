Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792603182;
	b=zJSnHnaI3bqm5rrjfZi2+vinLem9qYK8J3fmbYYQICsamvl/csrn7BXS2qushPFsLSXe
	 CZYBvBngAg9NiVeDuAlpTRhS97LZkS4uJf5DEqqMm2Fr6ycCKRg/yJMWHsbAC342ViOGr
	 bzjkFiHFeiF2zkL/uRjlhDL6QNulv8RTaLJlADR3YxhrJ9asUCPrpuDxrrAg6tFT6otcf
	 xnIqfpK6y5AjJNiYlHyo+Pu18GYREWh5LLiHBGXKuaJAN7+LqBWUo7OkFB28SUH7EJlSI
	 s8XotnftklOKA+sFjskgltB6U4YVulXxoM1RJaf9YAsjMpkYb/fW70TOx+PKSnnh51g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792603182;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=OQEPziaRa61k8Y8WGD/haQ1/evkCynUVKvZb0RQuDtQ=;
	b=HHuxp0Wg7rwZUa9e5JfJbTDY/HXx0VqKAd18aP0reVwsf3whBSKmCr3qGLrfCDFV3ItK
	 v3ZNH4x7ifbvZKU/D3TbPOPTS0AZN0z/3MZr+1ppT90aPnRFPto5EgONt9T4lPQ6z47N/
	 fJNPIvbFc/EydzLMy9MuQih5wVOrIDN8bTkt+h4fTnv9evh4DpaFBrf64e42monawxpJd
	 rnhGkL8VxGzhLdaxnheut6jG1b7Ve0hr6NTVnbV848Jjj7udHsqToiy9d9dtcSqpnovE+
	 ctxbiQ3tn4JzH+O0RbYc1akrOuY1I0fLjrKdHS99URL9gtJZy12IKRxSnc+m3SsClGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=MMhGgRWj;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=WyIMh0OF;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FAF606A326
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 17:19:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1FAF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=MMhGgRWj;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=WyIMh0OF
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 23D941D0013F
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 13:19:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Wed, 21 Oct 2026 13:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792603180; x=1792689580; bh=OQEPziaRa6
	1k8Y8WGD/haQ1/evkCynUVKvZb0RQuDtQ=; b=MMhGgRWj0Dsnho0xbXsfa3jCCs
	Uv+5/qxqRJOSJ7GtqMsvGJNB86TojfaN1q1zxHNfcui/GHUz9oBocyhacQDcdZAw
	M1uMUT/XrN5Nk1Lcg+ivpYtgpOJypQUkEggPDz7auENOKN+Eg657EBgC6dl52Alw
	6V+orckPSqwca92fM6+nxzrzS8Tid6eyDzoW28uc31vFq+3QmUkJQPSrV4NNa3GR
	e9XZC67Vzx97BsvHbBGlGTRF2heNdUeEoFUdoiX7nkpNJiH0LUuKTjaaDXi/tElG
	b8ZMSnmToOUnEoG6dVtlYtRlKoPOAiaRF67oGpDf/iCJSIGo7RakNTeS/A/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792603180; x=1792689580; bh=OQEPziaRa61k8Y8WGD/haQ1/evkCynUVKvZ
	b0RQuDtQ=; b=WyIMh0OFwmR9Mj9nnMxQNzZonzsBJG/L5YUu1CTXKH60/e9i4e8
	BXr2v840dPRaxjXDXrdB8jam4DAQgWmPuJjB5QG+y3T3WRNRQWojCDwgimrsijb1
	9JgL5SBeLhPu3/4m5mFlNwq7r+VpKypgeSLZE9jklJ78pcUaNdzHCWDf5GADr51t
	ch5wqmEQ2hbn9TrsH6t+wvFJA5C3JAiyMiQnwM5XhRERhEis2OORPg23e0jUiS0+
	XMo6uWSPl/5XGqDefH7Vj9xiCwdhTrhffZZ01GthLiVOT1CnqVJAR4OtZlMQvjdf
	T2STS7BQhLnBNBDosNpsWZcqqytTsKdy+lg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792603180; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:j/8Nt/5FuPa5mPiV4PPRlQkJ6cDw28cTeIAKGTGuAisFzDf
	awAXYELVVZZXQC+/fUTysL1n/2+1gJjS8gYiWGGE4rFQddSxYbHj/U72+luYEFht
	CwYbLzrAk+fCLdDHV4P0IGJ6M0oHTPY07CJpDrkhqRD6e3lIryzbNbkSNcoTJOxv
	BRBuUFHr6EAzKq9uBR4c50ez1HrDRCbLEVmcG19B1TSnMUhZYf0FqK23J3p9r2IE
	tgs/j3B4yKGNPJronz/Dnn2OA483D9IOKoTqZtUB0PCWZ+eEP8KTWw2F8+YfECBM
	QJ5wMeKFpIOsNy/bfZbjhokHcuGf4T/4mtEdzIg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:+E/PJ/tDfKpCscy2bmrCcJ1pEQ0lrG06AW/ZnlTejsc=:LsIIVlm8iEU63tzNsUS1zqiUMs75KQ4jK+LoxNK7aDg=;
X-ME-Sender: <xms:LPTYaphNtA6SZvCz9ma3kumLqaH7YCdaxzBzlwpLrwTGopnZR2_mWQ>
    <xme:LPTYausHSyc7voBWTeFIHKMv-tTM7vRfeGPpkb9q8U2GasqOZojPcU-wMMw96mIzr
    KPs6rnKiNnY6H7Tj9B4ZqRwMfiZMdPiIXIjgoVUizY8lGG2Pc7TA6s>
X-ME-Received: <xmr:LPTYanRVaILSNlOSltmPYNZU0dA41xB9U4Ig33m2vWa5ry8BqJzHJB9WELC_wzwDcTnKj2g6Q1sfdawvcAip5iI7WotWcPELfmfL>
X-ME-Proxy-Cause: dmFkZTE7t/4Zsget9VKVoqQo6RUw4wlZbtWfaxNJrk3fsGwIcDP0WXKl/igPtx91uNPxxh
    WbQG8GeCdExcItcnaObEj1AYuTooqWTtJN+q/2RvIGwYHUD9aBtZnHxj5MrVdLimbTiDVP
    oGdPDjas1npO4cvSvyIWXXJzFrWTA5kp6s5OifWw0OLAVW9B8t2HZvZ72dF65Yu3KUlUCA
    +h3Vj62CIjFE/m4Ru5yz+6sHyGVLaXBtDbypVBoeWO14EhYFr2LV88mvresiGWfDgiHM+i
    yaKBRaaxuz6Qnb4f0sgj0UK3uoNkA2ZmegSgAgdUulg7n1Im2wLRi9WuyYjReXKWMeD7Xu
    yL/ArtaxR0JcOIHTUI67BVLFpVGZw4ZzizHds/PlZcMQhr43eCvkAE+R81/P7uY3IDFfJJ
    iOCKWaUnHYyXJgoho18p9V4KxJXiT7jqTcMCwfIWz9aOzB9FU9mrxNnfBIcTrgabD4jjSq
    NvxiIVMPf4FUVIrOn29TN2muXF9I+KQWMN4ASck9DDq02ruVVl4nju613nKmEPO0WhXNQ+
    UGzEdllBe0NkGJFMVvWIMQaWDSW///RxinSYxF8pEfR9S9Y7GALoEjF/TOLTz+BPalWsQA
    BWusH1u9Ubp9HJ2RqcgrGDbqtWusfYTfwQWaXJZ4UPGg2DNKOyR2jv9yaYRg
X-ME-Proxy: <xmx:LPTYai36b_QTJ2xM0iDtz8rjV68tp_oGpf7R7eVpWQ1KlP_uYvpldw>
    <xmx:LPTYastOyMkXuq68tAdz3wM9kR0JbrZaZbfl8IAYdKMTd8kuhCtycA>
    <xmx:LPTYaojpoBzzAz6wBLO9v3wQK_af_iXDxE0R8nBexBPuiLmpBzVKVQ>
    <xmx:LPTYat9cQI_D-N0YFrgp50KtgcPnxksFx5KWT17JMKociQaT-sY-Bw>
    <xmx:LPTYau3AnB-3cUoLk91Bp0aTEFfl1M52LmTDFGqcUKGcJzSyvOfVzHVy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 13:19:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Theodore Tso" <tytso@mit.edu>
Cc: Steven Rostedt <rostedt@goodmis.org>,  git@vger.kernel.org,  LKML
 <linux-kernel@vger.kernel.org>,  Jonas Rebmann <kernel@schlaraffenlan.de>,
  Ricardo =?utf-8?Q?B=2E_Marli=C3=A8re_=28SUSE=29?= <ricardo@marliere.net>
Subject: Re: FYI, git output messages are being used by other tooling
In-Reply-To: <ate61iEAj4HDIvzY@mit.edu> (Theodore Tso's message of "Tue, 20
	Oct 2026 15:09:20 -0400")
References: <20261020141011.0015d172@gandalf.local.home>
	<xmqq8q3sw75e.fsf@gitster.g> <ate61iEAj4HDIvzY@mit.edu>
Date: Wed, 21 Oct 2026 10:19:38 -0700
Message-ID: <xmqqse1zotsl.fsf@gitster.g>
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

"Theodore Tso" <tytso@mit.edu> writes:

> A structured output that contained the result of the "git bisect
> good|bad", and the first bad commit if it has been found, would be
> certainly be a more reliable way for automated git bisection harneses
> to rely upon.  It'd be great if that was something that was in git
> 3.0.

I am afraid that anything we propose today would be too late for the
3.0 breaking changes list, but a new optional feature does not have
to wait for 3.0 at all ;-) I do not know if the format to do so
should be .jsonl or .yaml or what, but I agree that machine-readable
status output would be a helpful addition for automation.

Thanks.
