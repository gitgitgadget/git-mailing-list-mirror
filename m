Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795454646;
	b=k6eiQ0nx0eaHTS7sdwnoGgAD08xcyWLQnKIi/S+exC2TJhaLFh40IsMKucpbN8XI0Msl
	 XPkPNjy4Edp4WcOWx1xadjMdy924RcDJ8EIN7448f4el6EEoQ08Mwxzgm07hL7iHXCw2L
	 6LcwQZ79NaZ5Fw4RnWdCe10zWfFAlkyhBHT9lA1G4sDzdc4KiR52fwl2QrE5r0kTI6r+9
	 FqEK2XDg4XFkej7SnmiGxq/xHUCJhyEruR/KEtvJpey6quRuWCKe9Hs4qLNnI59tZSNet
	 nGCEXvq2NTdHAUa9yHgOLkpl+LtBPBaVI2Zm/tS/XIHU5bU9OutXgLHv9+PJbwqFsNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795454646;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=SAn4R4VQWf90FuiLi4lH+RsMgaIYeUpEk1QdmP0EVN0=;
	b=Yqex9Mp+TcW4kw2DwnJa4+kAOJdV1WZR3HJfA/taZouWr2+Fm6OLlwFTdEjowW9IOgLu
	 XaWdj/PVO7PFF95p+f+E5H00Qw01yQGPGHIV3XuHnDr8BOnXOD4pfUQ2gALTYY0Py7dAo
	 M+zKxV3nL7XWyqMwBc9FX0KfbMfRo4BgvXYqtYWWUnw/qnd1Z7FCDcVSNOvQmtXakR714
	 TpZfnPhCZx6PuexjFnBlZj7ctTKtrfN8qeoZaHu9a7lya65lHvmqf/7I9g0nC4EfKOmE4
	 onVwOu9tCeJ/H2HUiX100Nyqdb5zo62f71TBC/0KJBhjtmhtHp68AVkSGQItAVBCEbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=CxOhEJP5;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=GIRgETy2;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8991B606A31A
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 17:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8991B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=CxOhEJP5;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=GIRgETy2
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A4D3F14003A3
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 12:24:04 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 23 Nov 2026 12:24:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795454644; x=1795541044; bh=SAn4R4VQWf
	90FuiLi4lH+RsMgaIYeUpEk1QdmP0EVN0=; b=CxOhEJP56oOszkMj9HaLxYxXBw
	mN0+PXofkYUbsQgiKZbMeVpCmpZvJW3VmPdxqfxLOSF4zwHGuThLdAFeRLSiR0bp
	bLVsOWH3Jd+UGHGRuf+15fZvEMbtp+ZP9Z7KSlh7j8gV8HmK9vdUDg1tmvVzVQbF
	OjV1ufugBG5bVWi/++R55a7a7kMTfEBq4ambOvMZ0Ao3RCwlSmf96ecYzBRryNxc
	YHx3l7JL2YPTOH3ec5Re1fX0WJlMskh/5M5a3GIIbReEo19nxhPjv0zhMS0jut/w
	YE/hNpeNUJlUzR1XSHCYaLm2ZwE8c+CRnNeK2eO4Yj6nyOCclc6xlPZC2cNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795454644; x=1795541044; bh=SAn4R4VQWf90FuiLi4lH+RsMgaIYeUpEk1Q
	dmP0EVN0=; b=GIRgETy23z5MchaIa3SkloZJfUBYq2uE7AJ7jXnK9WpkoYs3Key
	9zOegQ/C5G6xGMxY2vQTaYB9I1JoUC6Y1AAxrDVFeyqRDzl1ACVw4ZT41dV0eyJz
	GqRMGahBrX/qpUlMlMADQlYFPev6va8FrZUbMO0gsFZ4bQm87HojmwkjVb9OT8s/
	tFNWqwwDRyRvAs6eo33V+E9EN3td746zy9oNa2I5cmClHdvmmkRHXAwZLcShaamc
	s/ioPdvLhHW7wrJzx55e06a1lzYjZJ55Q77LnvnQAxieeF0qwKA8yH58UakuOkyc
	36SE0YNWbfQRQZETGoX+u5vPGUc18n+9GIw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795454644; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:n9IYXDu/Lxz7ODmG7EcNDuvVD0nE5F8t+2QqpUVONiyzeeD
	N2+RoYLTfrM1U5fgH39XaYYK+HK/FiAP3m/8xzytpPTVpsVrKT1gqmrXGKls/HHS
	2wOBY2cMEEFAlZsqngcfW3h4e5bDyScx463RqBNWcjsNchL7m11DQwEa3sXhvVkL
	Ff9Uw+IxvBTht8TRYIOXb6xm0HQ4eWMnnmZzZqwVjbhW+uQXQmy8Ybl4ebgRbmgd
	0Y2SPyHPDzniID6/1M7FlzhedIa9zvCP5z9MvvMf08NhwLtQrIhFn/zvqREMYvSn
	WNBlW2gGqaLfdnRa8DPJ0cxLZLFzLkG1OGzstyg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:YDBoyCIo7KZACszY1BWxVAPkYcSEIFUNKqgslOVjEpQ=:Y8uabyW1tSZ/GSJhuH1JVg4QLb7fV4lGd4/gxBEuZQo=;
X-ME-Sender: <xms:tHYEa4SPW91D91JnXAt5V0K0CCI-4nBUthD6oxv0RQlJhqovxoDG5A>
    <xme:tHYEa8xzy6u9eVdqwMZs_hX-Apok2aLzSuS8Y5_7EVJM6xPWrrmrVLMlOGuijSQk_
    pNtEwqR3HRG37gvnYVxNa4v2u9NGJJfBHeUOxy8oPMGAvjbAWxklLg>
X-ME-Received: <xmr:tHYEa62jowUeCCApDQpMDES8gTbnm4VIqLal6O3ttlBERBVWTJsmEsyq0y2CCKbgHv48FGWoKN9B9kl5vXgd8ogyox-cr1jfGlGykdA>
X-ME-Proxy-Cause: dmFkZTGI9DSdlIc639BdukxvtRh1+/wRh3B7+0Y9DjpMV1L2jL2Rs/E3MzuuS4ap1Ahmfw
    7uhWlqFvbTTAIh9os0qkqL1ydtQFbMufbqecXoBZygEqtINwTdORUfwsjdOyZkp9WTA/E8
    cYMa76ZTDU9Hrre/w5Xtdj01D3LOOnaD9Ufuy8BqkGKr3/MWAkplWVYl2F6fJYAjFlCp2a
    a0XXZj2NA2QerP4JlpRLkmVtMiHceB5qo2o+ls5mVCXTFO7PtHmJVfpqeGolXdh+gJAaQM
    lU0J6NO7Zm7wi/wyQCpKx8g2YEQnyeHDVoTfAiNQ1GwkCAGI9yv8Tm0WjWPJRgV4VY4Kks
    xvzR7GF09w7Fj8Lkkbj+0gYfg7WGLItXRPTACK55zM6rkm0XI9UUBWeXVknlRdF2IcCl2w
    QA7bQNBp7xc7FvVO4nOT+7sAiWAY6wSg+tjo/RmEGW8vXGextWOb9/smJsEWESyoAN5LoH
    ncuB+fo3LpUpLDocofNvJXyk377XS9+ZHxn2xgnvysbLC/xnc2evOmYTdPQfz6vKWKoaaJ
    JN14FbBRjGII7Zu2o1/PHuRkF4Bb+uF9bzu7AZN7WrYJdGMJMJEOinJY7jmK/EgzNPi9+f
    DVJpy3QW4hkGniS2+bLA2hMPMHfyGHqqoAC1xvHuSaQDcHWMyQslI51z2Kjg
X-ME-Proxy: <xmx:tHYEa64sVi5Mdeml6d_bbj8toqDeouSEde7Q5jH-NQ7UgivEXGnB2A>
    <xmx:tHYEa9WPfuhiPBv23Kvaa4in9XfcZFQ_PomtUlxS8Lxif8AEVMVS1Q>
    <xmx:tHYEa5DpDlBlFshcCwZQ2S9PHq7yxOmD-3SpiREna5IQELUyYo8gUA>
    <xmx:tHYEa87l2zQ1AGRNbf6HAWPcRWwBz7U9gK5J1mOHI3cM17R_TrZe_Q>
    <xmx:tHYEax3xvMto4LbrMv69qiIQ2iXHpnldFNPVVxcXzcl-smY0vnA00UkD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 12:24:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Dirk Gouders <dirk@gouders.net>
Cc: git@vger.kernel.org,  "Junio C Hamano <gitster@pobox.com>, Andy Koppe"
 <andy.koppe@gmail.com>
Subject: Re: [PATCH v5 0/4] utf8: bounds-related fixes and a doc fix
In-Reply-To: <20261122-master-v5-0-313bd1bb3c45@gouders.net> (Dirk Gouders's
	message of "Sun, 22 Nov 2026 15:51:23 +0100")
References: <20261116-master-v1-0-dc2a50ce0aa0@gouders.net>
	<20261122-master-v5-0-313bd1bb3c45@gouders.net>
Date: Mon, 23 Nov 2026 09:24:02 -0800
Message-ID: <xmqq5wxn8nrh.fsf@gitster.g>
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

Dirk Gouders <dirk@gouders.net> writes:

> A patch here on the list made me look at
> display_mode_esc_sequence_len() in utf8.c and I found two details in
> the file that are perhaps worth a fix:
>
> 1) utf8_strnwidth() disregards the given len argument when fed
>    with proper string and len.
>
> 2) The comment for utf8_strnwidth() is incorrect: it states the
>    function returns strlen() for cases when it actually returns its
>    len argument.
>
> Signed-off-by: Dirk Gouders <dirk@gouders.net>

I had pointed out a few issues, but other than them the series looks in
a very good shape.  I can see we are getting closer to the finish line.

Thanks for working on this.
