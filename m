Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680402;
	b=R6o/iWJsyQoBvNAq0Y7exGvqaqlPqGlzGuztDL7hSfFUaiw+XYg7f8Zjd8qcXhE2QKdV
	 ujfJ0k1douLEgpZgN1r8c/Saq63QRT7sSA39XQNb8Nd6zaHVbr+Na1//hEtzVLy8Sj++M
	 HyLjVt06hhagctb3VcGn5RswOsh+j9cSflr7Gflt2yi/srwN7GtrWu1VUQ9lMIsmDtwuW
	 1hmvb1lGfxxhcSW0Ps+iA7l63kcUOMVN+c2mGXnJTgS0nR7V2LRKro1zx8jdORFC3ueMU
	 TcvuaWktYuhu7d6Ujvv/oxWY0Bocu0pswexl1GEF0xRxiDRGYtlgxs26XRUD/B6OXMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680402;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=oiBoBy055PJFCOzYXb/4SwMFDijQEAobh9CBcPmYbwU=;
	b=g+HJCkdEoj3zXwBNClk7ypfnfpfXzuR1DZ+RObUfmRJxDNlGfZQaeClWjBNPMw+DY8BO
	 NUl40LZdqYKIOY0Sy+093sFdlmJgY7RJY/zbhwQ0wVPrUEGQ1PLESIexYTuDW1duZub6x
	 84g6DJ54QbJ+zCKyHP9YCvmngA/RpHkTo1xTUnsQ0DQSSt2Wl8Mz3ek4/CJ5EkaREBGH/
	 TMw/MH6VxgalsYP5aUWr8OoqzmwKieT0J7VLCCqIcV9GmbVp7kkiB/T+fSaf8f2ujxuSE
	 HZ2FideHTxWOFrm0N2/RqkqiAJpB9wORk1VcaQJUH54K84KQ3eQTZc96ewyV0mdTnpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=fsbXmUGG;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="M/CH1smj";
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CB6606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 14:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77CB6606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=fsbXmUGG;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=M/CH1smj
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id DD4031D00101
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 10:46:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 22 Oct 2026 10:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792680395; x=1792766795; bh=oiBoBy055P
	JFCOzYXb/4SwMFDijQEAobh9CBcPmYbwU=; b=fsbXmUGG3VD4VM2LxeRF6bdBVS
	cO7rYbUUHZbO4/5y8xG2pB4Yd1kC43eOEKHgY8kN0a9nJdHuDHUJzzSMSrhuxmVR
	Oy3OkIhQ6Pcin0+lPUENCj4WSlOku8pToThZp3LzUMxob6oLqhvZiyTioWcoCVOZ
	cOYfhejBnMu58BKaKXawmJ7zWNmflaeTRdlCpdpjitfUNbGzQjcG+62G+8tVsi13
	sfXl4QXJJIzd3R+qvs+y41+pCt6E72H3jE7nzbFPDQICRFwyB3LiA8KdHc3HqWsu
	7SgMf3H1JuvUxG8ASFcj2wuWB6/1Fe9w58upqVJiCIPdcnwsDrbFyTukB+bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792680395; x=1792766795; bh=oiBoBy055PJFCOzYXb/4SwMFDijQEAobh9C
	BcPmYbwU=; b=M/CH1smjIy+iJuA4DA8JTrnIjOr4nLQt075+pkFniNARz7rzCp+
	K9aCWgSs7VTSpbRkkyalJDTwnP29HH+WymygJxSWhzH8ZJUC0/aGF86+7goInmsv
	nMqA5HBdy9v0YGpQlWexEOBAKrO1nZQrIUbO7K9Yk9TKH+OHa700xCVK/1VSkyE1
	5fZ6XC0Gq2ovtgZVVnvLrGtlJn9aQZ4j+4377g1sWxxuv7NidK52rKMgtNsbIEKJ
	O3UYIIZ9bfkTfr4zWcBQ1UlwzN8D2FzqX0QVV0cjXuESdNM0AW92hKuIJ0h6p/Rp
	DOd+4yXVNTsS2jusu+GZMtPzeRfGJcg8RlA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792680395; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:aTlwAefqC7iEBM20hnEPIGoabfMDflT+FIePns4z/JW8vK/
	tzAucBotsi4/3Yaln31UrIUScCLyT62uVp67vpT+vHU7ge5y5mHML9kJaN16OKpv
	YBqepob91Qk/01mFl7kcZAbXE9lNoqDJURyH0JJSnq3vHjGGTFO+7BlP51xWLJWK
	sZyuNS/xsqA+4G4X2TbycnRvM80f5lSdw9UIXEzmcM+PwhValX6Vr3vpCWtMQqIO
	GBW1BnOQhUumgwGwMFxAG0CXvh1W6lzG+rUcH4X4V8CpHMa51sXejCYAO8KApczm
	3/94xLRCO/h7Ci3TH+5Rk0WPTV0ZdmgCW54p7pQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:bPcqNR1qAuQl/WDFIj22eflSe7tbrmHaqFmH6eFiIp4=:oiBoBy055PJFCOzYXb/4SwMFDijQEAobh9CBcPmYbwU=;
X-ME-Sender: <xms:yyHaavcNgHxpaeozv8OUImAKu1iOA1VV-yBACrkdFR_rVF5PO-tVSQ>
    <xme:yyHaasHC8jsef1jbLLYEmmZ-ANgZ3G9w4HzQwI_U5bDkM9qf0rjYD7_F9wiDYpHNH
    ADF7nfd8rpp_RwE4hJ3yIV2roKAtHgM2vvFFfS4ZOSNMHcBKn10Pch4>
X-ME-Received: <xmr:yyHaag3lVCxyPn-ErCALls-J_oeWmNto_EQ0yr_RTSX-H-zqxCj57-BktZM-f58qbp3IydHDeRKUadpfOnxuTpbXztTh2McX4fo7>
X-ME-Proxy-Cause: dmFkZTENrkAM+HC24lT66jYaogBh1Dc1JVBr2o602+VKF2jxSdswx/eO5btrA/PBEwmn+M
    v976ifTfG0qACzpIGZX1cH991lknhtAgi58BHHzRF6z96iUzLUYIgE5Of+AWT20ptJ+nyE
    tJrhHDZgi6p+4IWZdu0b6/f8wrPkJESS41uVa9PQXVHDhXpzlBuipDkE3W7l5x2Gi5GKHc
    dNN6wz55PaH2GCr1hIltf538yEoBoBJHJf90F+HniZ0c3qMwZmwcZXMkoqutFGg+Kv90Gn
    yU7Gm+e/SMK50HzJEb7Aou/nn0Rj2VrdmeYQHri9zZ3FCyGdKy37dOc9I3/lCbJNV6GiL1
    wXNrvKt0W9oHLFwvNGzG7eQHO25hmLuYtQXgJ+bAP82f3fMaLfWzw5bqHt842vtr3CleCv
    sxuqiIxgKNLJvEaAIufxyY0u66VOi2qZgXRuGXv5SRQr0Mj1RzipWIMBZVLjhNyhcrz0tz
    gspP41ZS5pv1JHOX6LYmYISB/PPUMxDyDn/5Rhnjh/Jiz2fEb8vvi2rfGubzpzV+x0WasC
    aIedUlMcGFP6ufsmIeD3AaAdKBDopqbxb3Ez1bemYCUBmUS8W3f3PgFBWy5kR62+8ZJ399
    6iVravT3gdEMg2GZL7U8mDYryHZt7vjOk+Y83JrDpf753bf1D168oCCLfOGw
X-ME-Proxy: <xmx:yyHaaslejBlmyw9S5b96wdrRjvxNYEdanli-U0KPriiOpX0ksmCFgQ>
    <xmx:yyHaao-uTuLcbmYqth_XeGA3uW_OqGzus8A8QhZYpma1UNUHIb4GfA>
    <xmx:yyHaapomJf7aWacI7BhbNmjL_y14cod7hGvhYUfuWbQeIw120dmL8w>
    <xmx:yyHaapkTsQ74QMd1g4ySxRmT-ZXzeXmReEJaIpGlyvpVBJ_xY1ZfVg>
    <xmx:yyHaalnujXo-3vi25Tu0E4XnmZJajpRVftEaxOvQq6T9N_AnHepYn3ZC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 10:46:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 5/6] connected: add incremental connectivity check
 via rev-list
In-Reply-To: <CAL71e4Pe_NRxeu9_+pnp=pBOk3SBNyePUbT5DDtDhd1bJpwJng@mail.gmail.com>
	(Kristofer Karlsson's message of "Thu, 22 Oct 2026 09:00:12 +0200")
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
	<pull.2211.v4.git.1792581744.gitgitgadget@gmail.com>
	<d76dae801b3303ef4271f71c7b3999c10cac8556.1792581744.git.gitgitgadget@gmail.com>
	<xmqqecdin6xr.fsf@gitster.g>
	<CAL71e4Pe_NRxeu9_+pnp=pBOk3SBNyePUbT5DDtDhd1bJpwJng@mail.gmail.com>
Date: Thu, 22 Oct 2026 07:46:33 -0700
Message-ID: <xmqq4iedkd2u.fsf@gitster.g>
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

Kristofer Karlsson <krka@spotify.com> writes:

> Yes, and an earlier internal prototype (that I never sent) did
> this. ...
> But even then, the revision walk around the verifier and the full
> check would still depend on fetch_if_missing, so the verifier alone
> would not let us drop it.

As use of _extended there in new code will certainly be a way to
avoid making things worse, the above in distilled form should be in
the proposed commit log message to help future readers who may
wonder why these new code paths are written to rely on the
fetch_if_missing flag.

> I think it is better to refactor that all
> at once in a separate follow-up, ...

Yeah, I think it is a good idea to leave it outside the scope of
this one.

Thanks.
