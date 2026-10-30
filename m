Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793382281;
	b=YgFYSIS7iw6vyV4mmwOPsYfgjCgk9Sh6wMWrhkWigU2rUq71uBt7Qz5z0mWhJ7HUI4C5
	 lpFQby5/gQ5LrtjWH4j9b/Ruz6xEZtgfmHuVrvj3CrID9ixr7+1LF9aGbIa7cdKU8SmoU
	 7912qgJD8Rp1ypCRIJu5jXdEjb8io45F3fbMSwnJ04jmyhvjj5jtBQF2u7LmgMvWGeu/p
	 2L5aj3tVnbcAa4AGXvXfrbtrNb4ywAU0go/Gdx0i1LxogSXEXj9M2/kJ3SdIftzt+969e
	 eNz20kls950Jyg1gmCd11RGr0RwmMgKeF/WXSkMknJaUQlxr/yVl9olJypsDcRmCTjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382281;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=GvFP0LNyywFsYE3zdXYywL5nei3ZJKpq5xNGwbZYVNo=;
	b=S+oSPIGISPZch1C8wYAIbvlv1vWzS3elgWo7ec+IZjqqFHRnen1geBOExJZkQZ6H6eDh
	 /KC/5sIjb7TmTl5ntIpOpku4n7VrH31wI+YwHlF8vos3vhBKmXY6O7vuAn0Z0mI4aCqmS
	 WW8qk5qnhhUfHbmpIh0tcXzGskMiaItu15FVFX7Drq4HQ7iLRMJOMoSzLRUMN8oZ2O2kv
	 3Tb3INA+PMhXFXE1Tlwb6oNBdD2GymrrDRiIApOqwALFfe6wIFxrLmW4k2Hy8ItaFMGnm
	 RXRvm5b19brFNAQVONUzFzIv7Nm29kn3YTQ3QvT+F5yDn+ND5FP62R9pQ/dP8kWHjKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=hxJtfBYr;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=lDk9IeZL;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132D7606A323
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 17:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 132D7606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=hxJtfBYr;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=lDk9IeZL
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6B7D87A0118
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 13:44:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 30 Oct 2026 13:44:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793382280; x=1793468680; bh=GvFP0LNyyw
	FsYE3zdXYywL5nei3ZJKpq5xNGwbZYVNo=; b=hxJtfBYrRNUxIz/U/RD+2uH+zz
	iAmyWPMkwFws/me3Q14lSqjFplc7QsYmfiiHzoFVMiDrEq1CNg0WKwlko6s3YNxL
	8VoPdk5yfYQvEhFjtVo/oqKhGuSrvU09zD4yG8PGKk7lvvY2dn5iC17P1AR7R9Py
	LuTBkx9KEhI3nZIgsAnl6QUIUd4f2F8YRdLpvyfzvvDSWyj5RLhMtdF/D0ctDg/L
	SsFZlM4qQFFeMF5Ku8IaPyHDaoFDGjKcGAQcNCkfN/9hnTzQLfYwO+NGOAhhx2/R
	ZUgFGJOuLle/kJP8PVNXGnI8xPs65oT8BUac695vAzHz9jTF+WCX9NtLRi1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793382280; x=1793468680; bh=GvFP0LNyywFsYE3zdXYywL5nei3ZJKpq5xN
	GwbZYVNo=; b=lDk9IeZLSAI1Dr1anG8X3hTPUAH69vvHiLF2RD4PiCA+pX12P7+
	Co5JKarQSxpShwrehVOx+Spua7zbauSUVhVHpWhVNE2+jj/8OOqXyqpCHF8z77BF
	FNi6lHsP+UD7Ddqe//9FJy8cjAvpiJuQJpuIi5rAyC6qkBKB14i7UunfxLY29lSv
	O8wMbiH2HjCxRcgI8SZP12YDKTxSSt7yLbEydFLSwChvWfCNW6AHwSOv4mMq66ki
	v92zYww0DQwtCZ7Gq8SHjHsco8LzcmEqKxXhfBWG9VamkDy4isMQb4dW8/lGIvK8
	qYnEAxpDCPAqFbW52j8pJx+aEeDODaGtIBA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793382280; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ATfQrYBDieFAf/IusqTG+0DjIhlhf6alPPyP0aqW/TSDfHz
	jRFd/QbPNbGm1/pBK6IUA6evCcDkn+ZBQn/uarJGt4Gkh09vdpx1RU+ZmLkT61MM
	37wC0sDe16wMMZ/H0jtd2KWraYAkKPovk7JLkuRPgTaO4y22jTxFb9RKSid5N0hg
	8eH8eYq2/qVK7BVXIZb4uHARC70K+uMEmqQ0QBXy+jkndDvf+IjH9EvP0L48TPns
	ECEtBKegHmr9J7uviP09Kg3ScJdYQPeBugj2PndsR5Cp7z0738OFcn3NBhwXH2SO
	ABlCD6QHM2OEjmHvrbT71+G5BvsL/1F82ZqwQug==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Z+LAP/jipSOq7ptTTmCJsN5FgnA+ILFS54+AHZovq4I=:yuu1fQEFNTIjEhzuh98CNC7JwNqEsSdrInl71kQmhwU=;
X-ME-Sender: <xms:iNfkaj-xvYGkL71cTg-YmiB9ExaI_-W8AFsxhaRvttpL1V3c3qUgow>
    <xme:iNfkanIJ6WQOUBk1iOa6bWoUkDwuTsLq4pM4qKMYiWbN6OvramviUjfHSOFYkVtu8
    eRt3xT189Ncq3LJ7aBVGNjRsuXOsaAv1t-hd4uyffr_yjS_LmesGg>
X-ME-Received: <xmr:iNfkauZ5Sxu6H7zC-JTHdNOmADV31Pta48eZafyrPlhBArZzA23o1Y8Qp3CjNA-jbLG4g_2mMMmPq1uGxENuzN8nxsBFhKLgj2wF>
X-ME-Proxy-Cause: dmFkZTGsqkSltZmAH0fiPiT5ck/2xxnU+m0hPG/4qMs4i5mEpCKB87SzMPLZHs4Aw6XNOU
    M6yWD12qJVZObqNoqgg6Lh7Ogw0EkEqWlpni4HxgYlabkDjR46K95ceCVYffU9XL3lGljM
    CCzzQPcBw3kovdl6WJCFy3o4x9wtfUC69WCb7Rl7UsWLhpVXiZhwb0ojrbN406zhLltm8W
    wecP7A0I47GMTAfzwTXAaS0zfKtNCP7QvXvc+LWcFGyNip/CRGf3PsuXq0RzJL+zIDhbVw
    9VZGu5WWXOQSZ3+tp0ttASfNpBKFJNXgMzGw3GpsVmnFZcX2tMh70onWPhKiJcy9AFBWEc
    NGAq06jFHPsLXaHF0G23nuxMLxEGAjqX2vwAp481/sh7MYTraYl4/vejrZ1di47FC2fc0S
    3RO6j/6uEOI1GIVldTRRgmdDF1Sax0LNOlfOnDP6rZC9EdnX8v6uDVfABtwRA7kSZLy4xT
    CYhKUxm+l6dZfcn5wiGyETKqZpPzt4Jkir2uU3U6YIA9xuFZtMZUzBVPweSsFWTUm7ZXAV
    zgfbIR2O0xygqNinJQ2gEVO224BvTGr0gGSIrYZ8ovz2MLr5emWia45rbjfHz27FyvDHqy
    fQ/5Rirrof1B0sevEEDQ9cNSuh2wROhC36hlOUyhEGf1zPZfoyWgRJMC+E5w
X-ME-Proxy: <xmx:iNfkapIOeiswX2YgqMsudir_tj6nHcDFRRIBHAFr6m6alux4UpyTiA>
    <xmx:iNfkasDbCKFU6alFsjyi31kweim9uGwHw989O1l0QLEfgeeUPQYNdQ>
    <xmx:iNfkauqRxaVCq_j8HVO5gCJLkNlUDp6O7sNc9AH2WYi6BdYA6hED4w>
    <xmx:iNfkanhmwvMXYKmiWk8U8Ec0Vzw9tuRKfrt_juP7oyv9KvgU1XgbTg>
    <xmx:iNfkap12IOMg7YtuoAy4FFB30L0PioPOTOOxI4_tJeE2VPEO9E84YGM_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 13:44:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Emily Shaffer <nasamuffin@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] Documentation: propose community voting process
In-Reply-To: <CAJoAoZmyADCU8VdVDrvR-OuDKybSnT2pMOKbrofRBg6YdpxZ0A@mail.gmail.com>
	(Emily Shaffer's message of "Fri, 30 Oct 2026 10:15:57 -0700")
References: <summit-2026.94e33e9ddf234334.06@ttaylorr.com>
	<20261021200341.378978-1-emilyshaffer@google.com>
	<CAJoAoZmyADCU8VdVDrvR-OuDKybSnT2pMOKbrofRBg6YdpxZ0A@mail.gmail.com>
Date: Fri, 30 Oct 2026 10:44:38 -0700
Message-ID: <xmqqfqxnw0ah.fsf@gitster.g>
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

Emily Shaffer <nasamuffin@google.com> writes:

> Changes I will make:
> * Modify the subject line so that it makes sense after merging, from
> "Propose..." to "Specify..." a voting policy.
> * Make explicit the requirement for secret votes.

OK.

> * Specify that we will vote on _only_ the most recent version of a
> proposal (not an earlier one), and that votes should refer to the
> commit ID of a patch in Junio's tree, not a particular subject line on
> the mailing list.

Please make them refer to the Message-ID instead.  These commit
object names will change if I have to requeue the same message for
any reason.

Thanks.
