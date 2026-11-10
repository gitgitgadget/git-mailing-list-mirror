Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794293592;
	b=ehWOmfGbrla2yAXKqRrzKRn2OP88/6hvBAJ6Y/x4mIyNGjOem9f3Cjc1hl1AzqROA4Bo
	 XBNn4CI251uUeBjVQEDFz4U2Ni/FZj/mgipBtEEtLmkUu+6sF4c/m3Xhh7P0YEE54vEO/
	 SqsQ/1yJG6zElLtGJPmNqVfvN9g7jLJBQXtZf6gv1PADXiJJGhde3J2TkpwNFRmhmG2ja
	 9bjX4x3w/7xzwkB8eLzVv0dgf1tRncSop8eftOGbpepHav0fszBXi9dHqmCZ7Xoe+ePdH
	 pdM5rRyuFCsuqA9daHIr/7S6OWIPhk8LN3pOhr4NGqYsRt+TNwE6wy60T+o+9oMkIQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794293592;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=YVAgL4XT/HmD2d+gizWutDh15glOy0e8oSBrNijtCYg=;
	b=gbSXEB3pU4OhgwAMQ00zpMlimnjVZGGZaLaDGYG0ctZKb15gpwBw5g7uF67eY+tkDDds
	 HWTGWex5V4WnP82f9DM2b8rYOL9r9eKTvNarJn8kUXNXpOkJHNc7BVaWhEHqG95FJJuxQ
	 MmfGEFXa7hCqVkBBSM+1eGJjEj4MzAfOc9jsq82O/eJGTwcksl/1ilgnYFF++mCaFcqKU
	 LqxjQu3GXafRHPeEcDBZI+JnJOxg9UU/sfTzMIheOE4kP9vGZ4ohRwuKdFPiE5tI+erlm
	 2UUdmfjyijJx64CwMKZDNoSXGBYYF4vJX7bxK0fMxwmbEc88EPC+xyBae15zHtl36AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=rRR2bqAK;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=KnSrb2Q4;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB356606A321
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 06:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB356606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=rRR2bqAK;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=KnSrb2Q4
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 96300EC076E
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 01:53:10 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 10 Nov 2026 01:53:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794293590; x=1794379990; bh=YVAgL4XT/H
	mD2d+gizWutDh15glOy0e8oSBrNijtCYg=; b=rRR2bqAKo+PL8mJG3+j+eH9Nyr
	OeNfFQQUV5yi8VKP4lvr8TLJcl2lRqbBDfwUJVRlLQ1Z5xnu2flXtRDnQRjI7KGz
	kQZzMNr66pmvg9OCshrfTSn3SEwg3bjPKFFyULMhU/ZLS5rVi7cluBypNsorL6NT
	TC3gZqLKa0ztBujC38cwr0Ae8+kULgOk/yrCbN6OFXUc5jizvzuxAWJn8jK1KWY3
	qmI8QiZ2/etZb+5w39CDJtuCyi1GIcXospABD+C3sBG2w+2XJX95QokVem4FwvJh
	0W/09znvB59zUdFBUXnoxSqrRyF6GqIw7hD60reYZcCr6Nm2++KCgKJ6NdCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794293590; x=1794379990; bh=YVAgL4XT/HmD2d+gizWutDh15glOy0e8oSB
	rNijtCYg=; b=KnSrb2Q4SKTF9DVEdhVjhFCn2hTG25Mqm77veGZ+3O60DwVu9Qh
	QXVnM+yt7ZkeUMNNQ6CiJah48Zr3wN5wvxGtadvygVCTJlRVV1WL8bssnkkfCDRQ
	zGahgWxL0oDqHFrGMcwx3MJCSlghYsOk9SXi6Nyx8YZb0FsfH+v+IVY0LTFjAYa4
	NVxKqBPKQMH1b1WLhB6eBIGy0X6LRXfL8Oy78skYa/0BQmuZZGek7UIXFkGUYFjP
	cuI2WfAeOh2gNJv/Ft2ULCen2PVCCTWf5AFDGldzU5KiIo4ZHRI18eLUwYQwlW+E
	bTLVXhOcxU5sPUGBmEdXXTR7PM6AddoPsjQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794293590; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:dTPrj1WZAsHuIhtLLx4qngsjdYoAIh10IwcH/RFGWFZ2YcH
	6vyVoyzukLMJUMhPb44vgeKf305nTPxogsvxk2S5XDAeh+7FHW6ngrNEZ/d/jn6I
	DaL4Zd9nF0uPatkVgLzWReLgULR52DOzpi7Ybn2ok1n6R0D18ADZX2YtzfrCR6NN
	j4KQVEupaJN4Zb3EeVwrnglkoUgjZBAQj6oWIo3fYZX0uYXJD+JHsADYUKFsSbD7
	aDG46pme1LwHDaQgqYG5fOPRG69q4scuZJ9QWBK7ZTyDbulsGBeun2EhwHIVAadp
	l3s9R9xquFtAQvUHQ4XrOPDPOxXBiCqOFRQEQNg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Ja2k63k6fTlDHqINpxePiuhXijOAsD2YexBwc7/gsvk=:ZYoCJr+Nk6b/5cvKZdZYNYizQyW7R/4M2MsUUnZJ9rc=;
X-ME-Sender: <xms:Vr_yanSRyHpzJKF3ISwMzn-Zx9TKB5FQwJyOqzjMrIJrZ-Dp4xkqTw>
    <xme:Vr_yavzmMowz61SpfgUF6RGI-WkSBftkSuxzxfzYFIkrnQXS--F507f5pyaAF8blx
    he56kquEKPw50wDgeKD-mHRqE8HN-mRZy76WyO1TmFTSUibf6z5ww>
X-ME-Received: <xmr:Vr_yah3PbFNydbXrbFQGxKuJKQE_40qXh4qD9TGnNMK02JWGVF4ZyyaHe_MPHMijvKo0MQ>
X-ME-Proxy-Cause: dmFkZTFxi6oFjG8Dw1oD0cEkw5axZ87QS187ebd0DHJAHviaeeqe1bZvI3X4aWEfePBMzl
    0Dkxr7TKHH8WaElLWjWvJhl6/N+POSBlzE4quCOdV0ocNUyyUBVvpKFGnc2OFFnNn/BoLN
    geQQScA9lEmhUlY1QdmrwjFlr0gMFGXFlhktH5ZOM/it2WLaVMMED1XaGFqFyXZJX13eHZ
    MeCFWzlvIQI5XT6NXTBcCMFT2ByTnzGVOsM8NeM1K5zIrW1NxOaL6d/D37Vatb7RFa1Em/
    E1Jkad+8H3yxJa82b2eSAsqUn7aVLTqR3FviQkwpjwYMAhYG8NG6EFFrs+0pu2/DzUr+qx
    BYw/3WlCfMaeMMykidIyrydHRbwDC0uj3L8t7g39lYR2zM5Uv5UafZv/wRWhXBuAqQ82rb
    PHXuJvofZDPCawCWvwmTRSUNkX9yk4tAX+gkS/u1blJZwFAeZn8h6R06knrEfT/nyJbRNq
    27JKgUMo2XiMbgofn3sm6l9KYD8waXkV7BPvotz1mmHYbQxlHwN+j5FetK5wxtluYU8mtF
    xh1TjS5HhK1IP9eBzcWqScTYtoVzkDCLNNjtxD3BrXyQlePt4TQUsbMQjPOAKJTxflXMUD
    rhQ7iBD6LR4MOxhVDIgmb5AOWrAw7soP2KVkK3vjbsI67y7Tq9wU06VhmSrA
X-ME-Proxy: <xmx:Vr_yal5LRDWufBPB17_6-_XtC7OvzB7MmfP-LadOLQeUyvLSmHAT9g>
    <xmx:Vr_yasXAs7UKYM2lZSUh-gXDMNfn77ja6-F61JVrY9s0oASUktCofw>
    <xmx:Vr_yasBf7LZ-4Dj2vzu6khCwaWq8vvOyOVTuBybSg2-IbqDCYFXeFg>
    <xmx:Vr_yaj5Ylo0U1NTX1Bahxy_5fXX-jqj2yikauqOKRHvufm6-mqi0XA>
    <xmx:Vr_yarI71l3z8SGqwKE_hBQ9U6mLaAotq3C6Euq6gSTghz8vaQ6l7HWs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 01:53:09 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 50ea5d55 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Nov 2026 06:53:06 +0000 (UTC)
Date: Tue, 10 Nov 2026 07:53:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2 1/7] gitlab-ci: speed up installation of Git for
 Windows SDK
Message-ID: <avK_Q_QDmdkl9r5s@pks.im>
References: <20261109-pks-gitlab-ci-speedups-v2-0-508832602d0b@pks.im>
 <20261109-pks-gitlab-ci-speedups-v2-1-508832602d0b@pks.im>
 <xmqq8q320wv2.fsf@gitster.g>
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
In-Reply-To: <xmqq8q320wv2.fsf@gitster.g>

On Mon, Nov 09, 2026 at 08:53:53AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > +tar -xf git-sdk.zip -C $directory
> 
> Wow.  You learn new things every day.

Yeah, it's fun. Windows uses bsdtar, which is in turn based on
libarchive, and hence it also supports ZIP and 7zip files [1].

> This is in ci/install-sdk.ps1 file.  Right now that script is
> referred to only from .gitlab-ci.yml so as long as GitLab CI
> environment has tar that works this way we would be fine, but I
> thought that ci/* was designed to be portable across CI and other
> environments.  At least we would want a comment next to it that says
> we assume BSD derived tar that can grok zip archives here, probably?

Well, bsdtar is nowadays distributed with Windows by default, so this
should be portable to other CI environments, too. So I don't think it
really warrants a comment as it should just work everwhere. That's
certainly something to point out in the commit message though.

In fact I wonder whether we should maybe adapt GitHub Workflows to use
that script, too. That was my intent back when introducing this script,
and for a brief time we in fact did that. But we eventually figured that
it was too slow in contrast to the
git-for-windows/setup-git-for-windows-sdk step, so we reverted that
change on GitHub again in 55d62306eea (GitHub ci(windows): speed up
initializing Git for Windows' minimal SDK again, 2024-12-17).

But now that we have found a way to remove the slowness we could unify
both systems again. I intentionally left that out of this patch series
though, as we can still do that as a subsequent step if we want to. In
any case, I want Johannes' opinion on this topic before doing such a
change.

Patrick

[1]: https://learn.microsoft.com/en-us/windows/tar/
