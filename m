Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329001;
	b=j6gLM6j1RFHw0YwgSnixPXJqV/p5pY81iSJ6TvJ/fUyq0HYWwlAfPtufA+0prahuBlsd
	 qMVnRLBmMB/lq6H9nzwOPZBWInliHB+WLryOJlAy/eimTP24O9mnb/ul9pS/3enreo/z/
	 fjeieRp3wbhXBNfozgE37WadFXP5WLRenAVGTOTGtlzihJKo6C/Fsmp8G1WZ1OZYXd/GW
	 TEdJLUvTC2QYPWiEJz2mqo5xK4R0islJxwxU5XtRd0V5Heux8RLN/+StKwvJceAzCd4DU
	 ManJiHJznqyvUL9sEDROMVgJfyLRpJ2i8LSJejV6YHWPrsjKH/Cxt/6G9qiCEoISQgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329001;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=hkxzbQ5xPwfTvQk0dgAtrEcZ8BYjQbZSpJt68YkDsf4=;
	b=Ibo7f7CbmLxi5bEFkp1WFO6wsdo1xGipXeA3fOtP7EdyW4E0V2pVhnh8UlLqIb0ER2FL
	 b715IGXCHaX3Twu4qtEjLQGnviro8fgT3IBHmIm7MVaEI7Dava6/63uTHKGDaRE4vy3za
	 5f0KSd7JFVqm1fnb1LSqQJA6qkIjHVwB5ZlDAGFGEwdue3zQhNDGjTe/AvGnJg90IjLoa
	 edVTKjXcWD0Wfmcgy12OcvLjoDVoLAnPuFUrttN2JxjI6QXExGn0g5IgMyx+A3GanSCGC
	 Am62CYvDSGzur5TTfwdlphV66LnwLzW+8Zsx4wvmUCCqwILWB1eoJYlrP6zVXdA2maQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=QlQBHo1g;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Uec4ivJc;
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DC9606A320
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 16:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6DC9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=QlQBHo1g;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Uec4ivJc
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 3C3351D00249
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 11:43:20 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 10 Nov 2026 11:43:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794328999; x=1794415399; bh=hkxzbQ5xPw
	fTvQk0dgAtrEcZ8BYjQbZSpJt68YkDsf4=; b=QlQBHo1gBYHTUwQRv+lKENSHOv
	RVjx8awnCl162Sl250xVj2qlqa3OxOHitTBu1T/7aRVGJiyVZ3OtIhhg75eR/f1S
	qgDe2nJToAQMyT58Z5nGDIaU1IvjeeLmsEs9IlLiB/zQHekb40jDrnLuGgCSZG1c
	EMAIEAh1bO0QD44b33d1ajDiebx1xkTJAFSl3m/Sab0ExM+rqPGFY/YeS0gAEXWU
	j+yY32H3BLcinoFd3N60AY6gXhp5lKT7siqxUaDbaysvy1psGixSisGd0ZhgKCug
	o8G1YmP2kiAZEr8iy+vNP2fVjvsMFgEeEclkjPlkl5LriLWKAWn46zmm97Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794328999; x=1794415399; bh=hkxzbQ5xPwfTvQk0dgAtrEcZ8BYjQbZSpJt
	68YkDsf4=; b=Uec4ivJcAAgddk92+HirjWvcrOn9gAMJ1urkBGM4xQTffdzDKZk
	Vt0sf3y6OHsg4OhDOZm2/EXoAElhwKqLcIAmp0ORKkfb6B+b4n++GMcZWsPGy9Qw
	01raMGtvdBVuuJATmr3dFyWyopuSvexNxOyRcWCfgJZphFLPmzHTNjfUHq5rSHyD
	zYxDYxh4Na1Se8eai7J9854FH1LrV10mItD2XrMkmkuehYX7UPt4UwvjfU47CqoQ
	BEvCLo5I0SLh3b13BVOnZjfUuL9Esb4PpphM3TcyLpa5wel2Xu8YSkixiXoMpMDU
	LI5/oK3UQjrUQ68oucwHOkPH2YNpk4Mjmdg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794328999; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:BEL+tERBVgwlj8J5tf66SE+YNqd1SMTJEEmPAhNGfbLbkpQ
	FeGAjP0vEbMiakvTmV3fcZTk9zpwhbNLAd02lR47J3nJF0INd0VKtSBsoXDkWzsD
	kGouzwxiFU3t2RAAfrvvx7d+10IfJwZBQkAMefrm+tZ+qBtavAStF+oBcPqXIMHv
	cOmf7EVYmLmw2sQw876Ugd4cNFW1xUQSAsU4EKOMovWODLMSZYV61llHdWmHyTZf
	zd6GasFAFfRVIoNHKvb9PkfvpRhij06JJt25IhEMEfhZZamW+1/1c6gRIV977je6
	C9BBnK8XI4P7WrEcoUmiTWpOznWnEf6LfSIHWrA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:e70ShPOH5OXKItIdkSO84IQAhykYw7+SE8IdtrqFVOY=:dNiqiZG53SlkxwgMjyK3Mp8YcjdwdG29Bul8xgZXS0E=;
X-ME-Sender: <xms:p0nzal0EA577r5iJFkLARsBdPS9UgosNuBs0H9d4ilf087TfLLMvdw>
    <xme:p0nzajEqHwzX_sQoO-z8VjTf6rZS81uQb3x6dNyiU9SlmJ86MS8NuwjnJG-XS_I4w
    9sWlIjx3X4hVurutLJmNJMrEqSS2cCnI8V3lXK3LHaBN7OxTtnkOQU>
X-ME-Received: <xmr:p0nzaq4KQ_oWy-ApU59k9o8-lAFrK2Mlfy6uueNNcU8HitSWET4X9M-4QlW4rFqSqnlUr1Wix7xUq9OcWaEHLHCsgGWnqzNENwJ_>
X-ME-Proxy-Cause: dmFkZTEDrH35uuVJMAFzHiLttNIu66Qjiz5cRgO+UyeCCxGb92O8tenawawWMkV3a3zBUY
    ig7cFAm/02NsVNMOdC5b/U3uH+37QZAEWWaT5gsp8YkpZgK28LEvnfHn5iVSWGjmbUvsyK
    wnq77ZWRabSJWmkUMw3ERcDQIV4owwo+ws3tYzr+rfnsedH3+9jlNeyh+grLqz+3yMUV0D
    rb+Lg9znyKqDKT9mTbVcJ12xGprcrjwPFFqx+lJw2EhrlbjKTv1GP89/WSFVYXHdZPK8k0
    48N6ef8XJvzTXE23IyvJ1lJ0ICanf1LN5F7XMDQnG7sbooc7MuG953k+YpQQxUKI5DeKfw
    PMTiRaBSZdMbW/fNvG3VRsiCxWUu65zcpM86s7oV5FS/j7PqCCbqHGRS9NE+IgFAiJp1X5
    5dioLJKTOWpKqRiIlW4p9Y2t5rh8bjAZlqjheMjECi/4qHqTJXKF+58IcUD6+nzacHsYQV
    bMCrGruR4Hw3MOurThJvKmMK5BpI5HJOf7Egnn0ipIDQxC4tWiRh9AFCQeTDsSalRCdYUX
    Sk4mLkpU8bamHDlTQjnE0+fxnRvKiqi/yD3K7d9ERgALIxWm/jrVqYMK26S5HpU6j9/0V7
    MyqF1Ul2t/F3Md1K6aERybzbk3fhfr7d5VHYcU3zICHt34DMhPS/2RvwJeKA
X-ME-Proxy: <xmx:p0nzahvuq1-utJw4jell-JRw1AkKEgPhxFPXhS6el28dfVMImHk4xw>
    <xmx:p0nzaj7ZRcwZtA0-qLSmlaCsISERe1JbWAFs8fB7F1M6lOn1v3o8MA>
    <xmx:p0nzakWBqRKNMbuDzmSRLCLlJL09Myqp8VYzY-cqM94X1-u2aULSzQ>
    <xmx:p0nzat8b18U5vynVeffgsBUv3YdchwqaVs3DkR8Apl_XqKCuUzukIQ>
    <xmx:p0nzamYWr0-zGWA4H_F1pD0QXBGoMHnJOiiRf9khJw6_cDkdGZvj8vtI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 11:43:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Justin Tobler <jltobler@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 2/2] object-file: return error on index-pack abnormal exit
In-Reply-To: <4c7c44df-4eca-4abf-a825-1bb3b16015c2@gmail.com> (Kaartic
	Sivaraam's message of "Tue, 10 Nov 2026 14:34:02 +0530")
References: <20261103212410.1389988-1-jltobler@gmail.com>
	<20261103212410.1389988-3-jltobler@gmail.com>
	<xmqq8q38yz5i.fsf@gitster.g>
	<4c7c44df-4eca-4abf-a825-1bb3b16015c2@gmail.com>
Date: Tue, 10 Nov 2026 08:43:17 -0800
Message-ID: <xmqqmrrgtz6i.fsf@gitster.g>
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

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

>> Personally, I somehow find that the original "unless we positively
>> declare success, default to 'ret = -1', and if we may have detected
>> more specific error, return it back, and reset ret to 0 when we see
>> a success" easier to follow, but that may be subjective preference.
>
> +1. I too have a slight preference for the old flow of having ret = -1 
> and resetting it when there's no error. It may not be worth a re-roll, 
> though.

Note that my comment you quoted was made with a misunderstanding
of the patch and misses one important point, which is that
read_index_pack_report() used to overwrite "ret" even when it
succeeded, but the new code uses a separate variable to avoid
clobbering "ret" when the call succeeds.

In other words, the original failed to honor the "have ret = -1
and reset to 0 only after seeing everything go well" pattern,
either, and Justin's patch is a definite improvement.
