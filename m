Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793112439;
	b=1brYrwTD9nrEzWay0phfvfgZsvtp7O1vHbm7gmPmY4pYvM/HFhoze/2tds23Zf3OVfSd
	 r8/w1xUXA6boTP06I9qfzSB71iQQvYv0wwHa+/F7s0QAR/tlXP0t8yRQaRiO6S6KVTmP4
	 oVK4/meG7sUV+zAjFY6q4miBQISmiHM1x/XvFH9sfwSo1kjo7Wwh3k5WRrTPRgOFq/YJG
	 NOGvqvGgy9FfBguiwdSqjRcXwC6LfRl8XguUSWdvwuBskOBSAeUXchOlZCaEIk6yeq3r2
	 PkDIOBygJ3QPf7kqXcnuaWp6UooefoFeo4R0cPinoXAk1cYQCwfpB1PjRAzLj5tNv5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793112439;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:Message-ID:From:In-Reply-To:To:Subject:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=0HjJ+0TG2Uc8xzY5X4+PNEGPPTn01zGGm8QYSwsV51E=;
	b=5gib3FhWYeAZYojhFof+iB/ys1NSqrC+4ZdXxyydQdVdxympk0bb/0gYvUr0kh0vEmIu
	 YEXioqErh/jcswuGixpyJq6/y7VAfn/WiPTK8jJqtL7i+UQjCq0hADi8Zegy7LX0Jm1fF
	 OPVXIQzJjpm2m5G96Hk3m0nkMnAQgLGLQFpKJcwpvVmj5hId5YGsBDMIgMKV63BkOmz6+
	 C5tD31Nk1luWjbFHzGoodP/MQSYdydnqrwndOSVaH3DhRaA3MwEgnPugCQpFdM9fSuQ/O
	 zLPxs48bcTvyHSBJZE8O0uqnjyuI+td6ZTXAw7vYbSCtVjVPbzQlvYg1cuuXwh16+vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=j5kGPrWe;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=FDH46hm6;
	arc=none smtp.remote-ip=103.168.172.151
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F0D606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 14:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10F0D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=j5kGPrWe;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=FDH46hm6
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 61DABEC01F9
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 10:47:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 27 Oct 2026 10:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793112438;
	 x=1793198838; bh=0HjJ+0TG2Uc8xzY5X4+PNEGPPTn01zGGm8QYSwsV51E=; b=
	j5kGPrWeeilHCDTmmo+hzpjsy/Mh7/fEc0JQvy5k2fqlVxRYAeZEDl7iv+lnBqmI
	VoQhC4ZkmG6ihCs0785qHUzWuQzQzyqda/hB5RDaj1gRD6V8TGN0+MSQnni8trSN
	2ssESCWqAeerxFFS1Pb8jV49mFFuGzjUVFPA4LYNpQr8yO35F7DRTwlgzWZJyvSJ
	ZZOKUplIX5WmxC1RKQbF0m6oFo5f1Cnyij8SshJQQLX3OjS+tWW0bWA3/Xl5KhxB
	1xI3PvSLOP0CzYPPWJLP68BoU87jvrWW576grceoY7m0aZwBo1YN2Rf88jp0y//N
	XiAzkn7zMceYaoV7cAzf9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1793112438; x=1793198838; bh=0
	HjJ+0TG2Uc8xzY5X4+PNEGPPTn01zGGm8QYSwsV51E=; b=FDH46hm6sdtFL8Usj
	qKGu54vSh0Amw+18r2HmBhoH1qAHJok0GPiPrwgSADerK0hRF2qswDqM0larp9TX
	knQhsThHLSj2IJTpbAVVoXJcZDN85igQz1Pb+w2HT/MHLN2tadv6rpDW1AU3pDyN
	az83x+wJsPCctHENBt8O12Xlivip46eFJCmfHPwyzGotKsN9MKcQ6S7m5DBYPUiL
	Sqg+Ie9RDaLg496ru+3+6pEQvQkHTpl0e6E83S2SXC1HBJ/Rpvnv9Exhk+dJIzyu
	nxTD3VeqkWMT2EpnSFYxIzJw/5q2CIQwq4nYtTgj4cpwzypiaKPnK2pHzRz1B8UV
	NTCzA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793112438; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:q/nmg16ZhVM2OXR3Kn/F6tXRefoE0My9IGMtrLKWxLmbJ/0
	WPvPZqVwDstrq165KAiPFXRUY9GZvjVrprYQ7M1dk1jQHHOs2fSXu2R+KQdnwKlF
	Fq6YEDjqJCTRTQiTYjHsLUYkqFGnzPcF8whXAZn/6Lso3HaMilBWTfyaAptGxxnM
	249f4UXTXdINDp29BNUmM2PfdQEtXPDsnhKubRmVwuBev1b4AS9+iOzfwhVdNM1R
	+ZIyUDeTRA2IVEKfDUEnkdUhTZHiQQ8aWMRsBxwgNH8kipMOOOHWyG9tCcgjdrHW
	eux7ZGzF/nSKghY0//1nGy1nCwmDjZ7eAI/dl5A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=content-transfer-encoding,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:tfiR06AGzOFLZhBZKfbdqK9wMFQDbXIjP94ufh5EdjA=:sGQfP1AaahQPvMJ+4TY2iE1nkIDdB1ZAqpAvw39V4YU=;
X-ME-Sender: <xms:drngaiMIH7QDAs7xg-zZFhWBHFM0f_FDwAjQC_XWTudAHik1GcKPZQ>
    <xme:drngam-IXUVpjxAlR8ANN7iTkdyyIUlf8FnYAiPrlWImw_qidfXlc8cSd7J63ZymQ
    NfzjSRU-HSh7hIalQZR3OQ1AV1md0x4M_f-odlSQWm6ozVZ1rfAF9Y>
X-ME-Received: <xmr:drngam7HA87FTx08b-r1Fttl7qNhJBUvCM_TzrvlmPb5HOgywQ6aJ-Dzf3B9wx4AvNtkU3kAsOmG0i74c7pygQ>
X-ME-Proxy-Cause: dmFkZTExqVyoRJw3JhcVpFCXiOUpLVnq10SUOibdRBYtDA6BEtHsIqcqFdnrePzRHXf9YR
    CSEkfEuv8Sqq8ulB50guF/wsEUTvbtXm7J/g6YkREWvnpAYYhlFgIRM0WOF3fH5g4tlCVb
    fiaBoY1aGwQXcc0/yYECtx9sVXujjJsH0aO7rrTuk/o33zGEfRyYe2CMrKorrfH09NhgiM
    ANjT3+SUTGNFhd309gi/OuTtGAVFbNMZzLLhmdQ462llaa3srs4IPXQQRzD1tgYmqrvvve
    0VHS5voP8jMSdXfRiSZ1ZL6mSzePWAmjmow2T5Krnu7ZmvNm1rTRjMMYcUUw5yzcISakCO
    sR4H7w/eGhleGFrx3g3+1TQV/+wl1DFQPl2VfYKfAwGv0yCXVWqAceMgz7U5/k0cggpR9I
    UNECkO7/+9O5aMygiYZJ0eV1CS7e5BLUY/IgzE0tozTOQmpfxQDg2glBiprLuzSiDJYDuq
    Qe3j9NCRAUbraQUhlQ6nJEVdSDRXwOsoQBOYBNcfQJGX3s/BPJQXPSv86lX2/fXHBRJvhe
    gtVBMjDlHBrbjflOmjIAZSIYI/tLnNbf4BYibFnkGQ3xY7qHbSF4VEfgXeH4FVv0tUJW/o
    hCPU7+R69OV/uiR2J3Uv0xusbePDVAtD84eLbgH60QJRySa8usnPmsAc71hg
X-ME-Proxy: <xmx:drngat0GC4KefjLMkv9c6l2TTJTxSrUtgOwSKLdeEDS3quHgEoe-xQ>
    <xmx:drngatD3XioY12y0y5ZNoQpQHBgqcZuND70PERgCUo__rxLBfxuVQg>
    <xmx:drngav1ObM4He94vjzYQ6V8zbW7DXf3uuYUDFLIKuWeowAy1pfGjQg>
    <xmx:drnganui5UVhvra6yaiL55PmnWhm4lGI6St2BtJwU1bg9oiKtT7MGw>
    <xmx:drngatnjAf3PAJRxmt5I-Q_TapTgtnB7wy8zvHn0-OXs_LTqE-c7BvJi>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 10:47:17 -0400 (EDT)
Date: Tue, 27 Oct 2026 10:47:17 -0400
Message-ID: <c23c4593fa3add2b40613febb2911cfb@fastmail.com>
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
In-Reply-To: <20261027-pks-rerere-subcommands-v1-2-d836c36ce0c5@pks.im>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 02/12] rerere: convert flags into an enum
References: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im> <20261027-pks-rerere-subcommands-v1-2-d836c36ce0c5@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit


On Tue, 27 Oct 2026 11:46:45 +0100, Patrick Steinhardt <ps@pks.im> wrote:
> Our modern coding guidelines say that flags should typically be passed
> around as enums so that it becomes trivial to see what kind of flags are
> expected. Adapt the rerere flags accordingly.
> 
>   <snip>
> +enum rerere_flags {
> +	RERERE_AUTOUPDATE = (1 << 0),
> +	RERERE_NOAUTOUPDATE = (1 << 1),
> +	RERERE_READONLY = (1 << 2),
> +	/* If MERGE_RR.lock is taken, return -1 as if rerere were disabled */
> +	RERERE_NOWAIT = (1 << 3),
> +};

If we're moving to using enum flags, then wouldn't it be better to
explicitly add a "RERE_MERGE_LOCK_TOKEN" to the enum for that case, 
rather than have this value only documented by a comment?

  -Mark
