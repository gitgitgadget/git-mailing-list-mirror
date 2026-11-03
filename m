Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793686877;
	b=RJTDJmvVu/LEBr12BTdNxcsTNlfPww5md/qi2jjMtBLcLXxRX4nnwKnSeAtTzCelSFjV
	 EtDglFTazFDoQpZU0JWcAp2JGz6uZtbyTax+FJQPOPADbdjCUHmj2fmM6ZVmEVrR5uW0u
	 5D/yR+WrySC1qyi6R2eRABaRx7hH92/MVlP35hfS64nbkXFCmAOIWEzR+0JuYgaw7bEEL
	 3GpGTaeuodkqv2pqJypfeZcUipecZu2FJt7FW7dblFnnHG1zgfzTJE21vdrDDid7DrPiw
	 zUaftn1rtCGPrGWbbdqRwghJCXoQaDghxcJlD/sHSCKOuEVC1h5GtzhE8vjUoHOcOQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793686877;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=YOFgLeXR/Rh4+64nlEXHvofFPe664CGQtudLYfr1Td0=;
	b=aawa+jRosvklHJEwvkri4ODBX8r5hvFticMRFSLMwlrBVyRo/nbFQNlWJXHwbwtugfkc
	 fcO8Jf5d2UbrdBjzqVkoCPSe4KsNWhjBpbNwyp+YmaEYhvZUVlwEk1DgwPcAY5VHu2BHx
	 htY7TBoMcYwXgdK6C4Mf1KFzbXhBnCZQdQo/FJkpR/S7YXEb65hGW9nRBoF+vjbsJqCyd
	 unBTpcw49cOdp5FuRiqkEvw3dVFl757St7K7Pb0qCxDpWxywzeypzM0M6v5zJ5kJRDwHr
	 5QhzTGcHBXfxbWsR+cOZ/XyhDnv3qitW5W6A/5yCrrrwdXEwkslzStBSuQYmB9abiIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=qA46qiHP;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=AqPvKmAV;
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225F1606A324
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 06:21:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 225F1606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=qA46qiHP;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=AqPvKmAV
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 6D2B91D00154
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 01:21:16 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 03 Nov 2026 01:21:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793686876; x=1793773276; bh=YOFgLeXR/R
	h4+64nlEXHvofFPe664CGQtudLYfr1Td0=; b=qA46qiHPMxni4AvcqsqGK7CuBp
	Nfaozt7gxDaf2W7X87Id5HbwnSs78gEu7y9iWgrGxxZUPO3RMuSt7GqZ0mieDvYN
	eV7NUDFsAKdLFttzoXkeFKsV2tNu6pkFShonU1x7lfYm2BKMjLgNyfOVEMHoJ7Ig
	pH8jqjdTfUpPYaEUSKqHtwRJoDHKenjB+ftazwuWZFw8XtA8SjoC5iI6m2/TrmA+
	88BQLUOUP7zwEMZwQFfSfILqYQj+2M2sgzacGmRnub3MjexWcdVuVqJSZ8d7swk0
	HK2RPI4A7euo4VpaRndAKi7+mM4UoRKmof8k5mA49V0Kg065YdpLgQnY7HtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793686876; x=1793773276; bh=YOFgLeXR/Rh4+64nlEXHvofFPe664CGQtud
	LYfr1Td0=; b=AqPvKmAVNPbjPuc5QqEwQ6VjUgtQrG/48va70cXsN/pK+YfwxZS
	hDHzjRhGDM9tFCP0Ai2ojX3qwo1MT/N0F6eFDTnJLXpY34bagRMW3tkCcYpaRetH
	GO5dPP9XsRUgNIeLIzpIyYGTI7SKi72A97AZ5SzeL+Jqn0lWl17l3T2y9E4VTruX
	UvNPnz0QRCN29zgNadBVLbyChHP7TzxY3Q0l4Jlf1MniI5r7YOzvUQit2rlY8Hu3
	516H+/gXV8hK0PRK7LvYCPmHvseOnpUHgbFjvNb9W+hYmpMnwYmQKXYGnnTWTw0+
	zio2aaD8TY52rZFiBrEJh6SKjtfhpiyuzpw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793686876; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:RS5ORksF33EVR80r4zjhfUBLVpVFYW5bU863viewBOnig2w
	J6PsacZR5+UhV94xYcHVMrZZ13vVJH2+Zbui2hVLuHBQFbICb5kD9nlzVj84PTlx
	10U7SBhQ2ecG4tevb8foAixLvRSpoEG53gQL/+LpmTMfJ58tqvtV4w9DGYyWzWZK
	NyudG5u7F0bg/okdg9UzHOlLwN95WeBFwyS1Jm/7YuNMjaqGzO8qtJ+CgADGZt6/
	Jd51jn85x/ndyUAI7miIX1MvQdasjALA15+Z8A0NCo6fOShPv4FtUkLsFzgemzrH
	pl8z+ZFtsHLCQeOOjhDqq8hF5mnU0FnPwLTNnXw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:YbCk2d2fTPbdWsVEpwhN81Hwda19AsDlhyPEXQ+dcGQ=:5vv6Ad5KVb7ZKlbD3+RV/R27ypEep+xlHPrh5xcJNa8=;
X-ME-Sender: <xms:XH3pajOJsFCv61dm-A0q3GWVjZC-FjKZ62szvlo90p8zvTV62mLZiQ>
    <xme:XH3pahp-46KwByozrN_uTyfv_oiefCwn43ZpoKZ3zk20XdcavO_ILUgV2_jCTl7mB
    rgESYpjBssSD5SO-fYuCHWgsw3JCNxMDayFi3IAO_w3ht76fWsKAA>
X-ME-Received: <xmr:XH3pasFn49KqgUGZdTKEufoWc7FFOAtYvbGkxgzYE7JN07nbgMhpJD_rge8jpUjlIwVLk3hCMsisy-feUp8sNUjJcQeiBYLVe9Qb>
X-ME-Proxy-Cause: dmFkZTEE6khxR87XhInmT1WI497FHR+0OKYG3PucccZfKQPP9mUUqZmqvl6D8i8ABXFE5l
    wgvutpPNTe686DHcLmK3CpSYIhDsWSbth8pmOJpIlN0sJ6U4jZAXmXryyklucq775W1YpZ
    vk1Cs0lqNpKVswZm8oIJ9O/oxWtc35Q3mlMrOwLnvfrH5XVNjGbKVhFNvZ45ZSz7dWgM5a
    W2MHuOK2JJWXhnwL3AlDGrM8g4fJTJYzgQ9luXZK0CLsOYZVz0r6zv3Gqg0rVJsHYGCCLl
    WmlNwehCZF35qkFplOxK1CAj98CBIjI7uZ3igQtu8hZj1qoOgv230VG6lWeRvYUeKRI0BB
    v+hMnjvZsVhgNtmqL1Q4IzREaE+BsyVjRT921GFONMSh6DbzouJ3Ajg5tSssLRZR3fkw2Y
    mVmqO4pjQM9ZMwrXGVfYoOG7X2ZnlMSyAJnln1jgPdV25YOOgTHJ5+WpIRLxFpcPQs9uFI
    3P6DbKTQUZiaZq+DKYQEDzNY0po+uSgIoV5XKxjJOSrdmD2bcZE1nPadETD2LGlGGcOYMg
    BYdEHkKB00W/CSihiyN6IQ5w5My66QS88gPJvWswYc5s9vH5+z/m2vkHoORliRxFesqeDW
    6F2SZyXcKonLtyIPt/0oRxYydRkPXRV+X64j4TCvB7EawKzHmKi4JSV3mRmA
X-ME-Proxy: <xmx:XH3pauoC5AFUb0kQjimSCS20EyPap4GpYyE3Jl6iB72Rpll4JKA5tQ>
    <xmx:XH3patZI4ap2LU2FWHiX_fEZrRg9DaR5erRTnj-ccqy7uNSR7f9c8A>
    <xmx:XH3pavVl1HF5_fMPHXodqAYRSjuP1dRLczym4Aada226wckPNiV9BA>
    <xmx:XH3pau_97cy5tLT5vtFrxQo8WYCd8vDNMVTXJ_XizRL_ZPWrq-g6nQ>
    <xmx:XH3panwUOJCXbJRpwzYXVzJ_Pv3CL52ywGMUxCIkqdifiw97wmjZd1TC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 01:21:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Ebele Lynda Okolo via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Usman Akinyemi
 <usmanakinyemi202@gmail.com>,  Ebele Lynda Okolo
 <okolo.ebelelynda@gmail.com>
Subject: Re: [PATCH] environment: move diff_auto_refresh_index into
 repo_config_values
In-Reply-To: <pull.2289.git.1793607304156.gitgitgadget@gmail.com> (Ebele Lynda
	Okolo via GitGitGadget's message of "Mon, 02 Nov 2026 08:15:04 +0000")
References: <pull.2289.git.1793607304156.gitgitgadget@gmail.com>
Date: Mon, 02 Nov 2026 22:21:14 -0800
Message-ID: <xmqqtslybfl1.fsf@gitster.g>
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

"Ebele Lynda Okolo via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Lynndabel <okolo.ebelelynda@gmail.com>
>
> The diff_auto_refresh_index variable is currently a global,
> which makes it difficult to use Git as a library since
> global state can't be isolated between different repository
> instances.

We do not want to put it in repo_config_value, because access to the
structure will barf when given anything other than the_repository,
hence such a move does not help the "library" scene very much to
begin with.

It is only set in diff.c when the ui related configuration variable
is read from the git_config() callback.  The callback is *not*
repository specific but is a synthesized computation result after
reading system, global, and repository configuration files, which is
another reason why it does not look like a good idea to tie this
setting to repo_config_values.

Thanks.
