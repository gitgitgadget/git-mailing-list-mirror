Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794815848;
	b=VYys+ctQwe5vZjGnE3oDG2lfXqDnwVzKiREOYtf/ZXlOv0KH38DWStYIApnna6lAdaYs
	 nHvmF4qEFu5O7rnIH2nNTg7qNszWeg5//YRxweAbBYxiI14/wHneER68S0DnNVfAIgQN3
	 k0k/1cxgchNsFUTlYraGaseoKr2xxcuBzBZTauIAQSdcg+z/Udt2+iReKte2GNf+DvJl2
	 7GZZf8rBXbLNQRvv422fWNSlIMZHq0/DAVmaDlGWq0EKcKo+Nb5Q6EvXsSNhd8MG4HDK8
	 lRP8nN3LYMxTL89xp3RrDVl7lFAltHr4BcnTB+5S2O/am2Edi4HfPXoPm3oXpItQd8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815848;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=uxC4znurNDtN5MB2cF/69AsEcjVDwDmmiwMp6uatgGE=;
	b=gFtAGIuhYk2BCUnDgQ7593EcEZin8XjMwxII2Ct1OnEz/LbaQRfsKaSNO1h+FKbLK2DN
	 kLku2OYcgkTB5l+YgPJlvPLPOzrn8M3RT0VB8dly+qsgJ0n0LObeJh5vcoHA2EznUuUA9
	 /b1E/+nrxzPvkkY6cnEkcVt1QH0f4eXcelnJFF8i9njsFwOhyzmIjRp6nStObiKIcEgiJ
	 M3foKt5+pS3DkViZxpMuYuHe85HtqTF0V37hDq9EcA2x5ZrOI5LGL1NpT0evHZD18xEkx
	 rX+ltx89tGkLoc+hzu2ORvtVIwYYTOGP1mpzDujMh9FQnRK+RS2iwotVlPdwtEhR/iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=QiaB2c2l;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="DGj4yQh/";
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A92606A323
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 07:57:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2A92606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=QiaB2c2l;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=DGj4yQh/
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1B8747A013E
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 02:57:27 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 16 Nov 2026 02:57:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794815846; x=1794902246; bh=uxC4znurND
	tN5MB2cF/69AsEcjVDwDmmiwMp6uatgGE=; b=QiaB2c2lisxKj7cuEt+xWhKAjy
	ANcd+IsaTovjiQDCmC82h4ZchtVpvptYrmeIvFy1zIfAaxk0Gk7E/QjxmUrdtIi5
	hwEOOsN3l604jiTbevvQngQIECpuhgAsIC3FrT58b/b8NahUJ4uVr5E0R0On2gcV
	bkIMb/tWvH4vUA99IN4999kiRGx93RZ7JYrrBvFGYtCJXrNwbbEIwfQWDLAHxsOG
	KjaxqrI40Xgi0NyoQtduNwXvHK28Rr8y6WNGbxLQJW28XlQLhpC+GFmuNuwiuDGT
	iFAGEaSV1ZH00PGJhhptjbOBXEsgtRfAs+dRu2vD8/EbylIF8AXPSjPxbKuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794815846; x=1794902246; bh=uxC4znurNDtN5MB2cF/69AsEcjVDwDmmiwM
	p6uatgGE=; b=DGj4yQh/QxF9vwwspkwC9ubqv/N9iHMZNA3k5NoE5jxBbk34FEy
	ZHJso/yehzz27P5jcDUCBtyb8nLOcorGo9hthBabR2m5D91BEod8eOp5BX8Nt/5P
	xa9TMfWetOupQlLT1A0uj4kwd1obNWPgiLpJF9ya6gnLlPoaqcbKlAgpkagyiDYB
	QKL91h0nAVQGuTuUztP/zzQFZcS3MaisbHg4Fny+xvTU5X1qQHj1uC9WYRWtRIc9
	v/QZSM1DHzzTENgQk2sQti2TKMtFHJiLe135vPdXhjqGBG+lphIhuKKbdOuJ1fbC
	EKDi+qEhp3wZ5kKDrjdE5p7JdEbnXfzdM3w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794815846; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:Jk1dMu6UzGl5igsR2SMXJ6ZOO8NHc0w2tkuHpijz7a+UJe0
	1NnpgpO56Ib2369tFUs9Fmkzad95OK5mi/ILVzt6+YWjSfNQz9NVw/y9+wTsO5Bp
	M/cQvjmjkNdy2E0MEqnMmKuJ1E43tN5LIAaOoosCftFSmWdS5+lQkGRkIxwqTjPc
	70ZBzVmjqVa3mFpxzVroXrG6AZJyixixXw4nKQmDqVjzpUbf1Bt1lHQMJ4Utlj6B
	gl8IXCSkw1EZoFFcuTNA5bkMD7EolF/VQoMGEUur0noN6jOzgSBgY69wntrjxMNc
	oMSmsaTx8dZ77lA7vJu0lNq7Ad9mOcdKqdB6y9A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:whfFtbPdmtS1MV0pi+8R7KROpSYpzEIHTptoOIFMc2E=:R7afolGdh1A40iKfjl81UANDtG3w+iHWVwzzRoNQ1xc=;
X-ME-Sender: <xms:Zrf6akx9iZoIL_-Y5j-3SV2MqmwjYrv92dStnw-0QiYtMFsRNJL-yg>
    <xme:Zrf6avRhWyAKS4RHQM1-jo8Yt-XuWGt6kOc70772mHL7veW4lzP1gGl7T1gFnwL11
    LaLzcCWQAIeTUhC20D6t8lDtcBzSu-U8OX22dyiK5oOQkKA6Shr1jQ>
X-ME-Received: <xmr:Zrf6arX6wzMNVWRbFPzHCsAAfsRtg7b6pI0YZytnb6RwIPQC11AaKB0PefI-g1FYJY7Eklg>
X-ME-Proxy-Cause: dmFkZTFZ9JhNd9GiBhX8PZKSCOqEvR2QYF/dFvxpKvr2l0haYiCYqEvrE/QjqCJTGUuiN0
    MZ7gY6ltp33TKIGTLI6O5r2+rjPVMyY1k2R/Ng/4CVwzh7y05gix56zMnu9YQQJLEINsLJ
    HJ2orev954lJ9XS51O5qsyI/gRLp341XUPGyUB12/q9fI0HJK/biiRf09itw8gd/ceO3O4
    X9glPwoNapQLaV/zsExSD3IV72QVWttz2iItit/JkoAhx2NL4Mq+GQcL7gtu0WbItlqFeT
    Z1Rqq8cjM9lhn8x6+LqFa8VWBYWYo0Ao0FyJ7Y6JFfIm5phH7OGF8s+2Dj08PrCvQXejC1
    SCcBWFRglG/lbJ5XQnbfgz+bR3rI+huSAiekzLBkLDNABUtfGDrrsO5OX1/Jqg09Y0Nnnq
    vHCowWdJ3/kO++gHtBiX41mEAW3VZ3tUOZsRuikYYhBZWCz3LxaIOlSZcK/7fhJD80tAY+
    hCH0anbj9y/m1FM6nndzHa5Gzs0+JtCgNznIJnC+Dfs+/9BZcBcQRD19CA+xM+nsaoSiAf
    9Ssz96dqh6+1tNCvwmXf44mYdXOM0mXTbPx1gJyXn2bxTfhbl3uV6yXDJczXR/9PqG+zeh
    FmUsSLDz8jPqAUP/AJI7ZolcctjKlIH8Gjnmy4TaEtx22t2pS+bVjuf77vaA
X-ME-Proxy: <xmx:Zrf6ahZrrAtHXY8KnM4u9M9SJIFmXAzwS621qyweshbA4MWhO_qt3A>
    <xmx:Zrf6ah2SKFpfMSoQa6rueibPu5WwQvw1feM_-i_p-LnkRFrL6PBPOg>
    <xmx:Zrf6ajiS3v1SFbY16GzZ7JWjr4cxfmUvZRNMAaoqium47-RlVbmgtQ>
    <xmx:Zrf6alalrfLFJdUj9JYJ3rxS7kCmgDR_cFgKE6aG0fPw5PJnIQ7y7g>
    <xmx:Zrf6ai21Unfomm6Y10wNm0jY_TkOFcemh3gp0DdC6BbBuIlgIbDZ3VYL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 02:57:25 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8aba6729 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Nov 2026 07:57:24 +0000 (UTC)
Date: Mon, 16 Nov 2026 08:57:20 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	"Mark C. Chu-Carroll" <markchucarroll@fastmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 00/12] builtin/rerere: convert to use subcommands
Message-ID: <avq3YHb_J8Ww6Kq7@pks.im>
References: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
 <20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
 <xmqq7bifponx.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7bifponx.fsf@gitster.g>

On Sat, Nov 14, 2026 at 04:45:22AM -0800, Junio C Hamano wrote:
> Does the new syntax introduce a subtle UI regression that does not
> allow certain options before subcommands?  We used to take "git
> rerere --skip-locked gc", but now it has to be spelled as "git
> rerere gc --skip-locked", it seems.
> 
> I do not particularly care about the '--skip-locked' option itself,
> and I personally prefer to see options after non-options as a
> general CLI principle, but it seems that it is now required to give
> the option after the "gc" subcommand.
> 
> I do not know how often people run "git rerere" with these
> subcommands themselves.  This subtle change in the CLI may go
> unnoticed in a smaller project, but because we probably have more
> than a few thousand users, I am afraid that somebody will notice.
> 
> In the transcript below, "rungit TRACK" is my short-hand to run
> version of "git" from that integration branch.
> 
> $ rungit master rerere --skip-locked gc
> $ rungit next rerere --skip-locked gc
> $ rungit seen rerere --skip-locked gc
> error: unknown option `skip-locked'
> usage: git rerere [--[no-]rerere-autoupdate]
> 
>     --[no-]rerere-autoupdate
>                           register clean resolutions in index
> $ rungit seen rerere gc --skip-locked

Yes, as documented in "builtin/rerere: use `OPT_SUBCOMMAND()`.

  Unfortunately this means that we have a backwards-incompatible change
  because we no longer accept the "--[no-]rerere-autoupdate" flag for all
  subcommands. But this was arguably broken and misleading as we ignore
  this flag for any other subcommand aynway. So we cheat a bit and simply
  call it a bug that those flags were accepted in the first place.

But yes, the same is true for "--skip-locked". I was expecting more
review feedback on that specific part, and was a bit surprised to get
none.

As documented in the commit message, I would argue that the current
status quo is just plain broken as we accept options in cases where they
aren't even being used at all. For "--skip-locked" that shouldn't be
much of an issue, as the flag has only just been introduced, so it's
very unlikely that there's any users of it out there just yet. So now is
the right moment to fix that design wart.

BUt that isn't true for the "--rerere-autoupdate" flag, which has
existed for a long time already. So if this backwards-incompatible
change is deemed to be too risky, then I'd adapt the code to only allow
that one flag in all locations.

Patrick
