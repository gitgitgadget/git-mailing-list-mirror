Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793215721;
	b=h7T0TERRnV640oDH5J2yFRvLFrTmcqbkx+KaSFmO3YEFzGOmEvPiSmHqOtuVIONDed4z
	 K8eyvKJzq/AIUvIAXQSZQS4K9drxJUQKDDgOQb8gBXH+RgOOQwNOwhbIPlq4twg0pE3GA
	 fH8m1dwz4F7BZ2fnS69++2sL52jUnS6XpN3Q3UA4YKDacn4PSwNkgylCUiUS3hRSzMS/8
	 j2v3CQuypMw2TniOKBsQRDWQI5E441QKb9OMn3ijjs44xY04gjYvR7yNr2m69nt2u5tTA
	 CGKPmUMI/+idwlzKkVVePQ880dzvPY++JpZtQTIUw/XtJ4OtPjTqyw3SpqrwEnrFmxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793215721;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=QFYBX8JLtKu06hRbPHmQC8zfe10uS/ehqiN8S62r4eI=;
	b=HmZmUFtQh+jdim2m3fyJy1P+jdVeDB8uBd0O8ZFW0nfscTjl29ej47Gh2jOUnnQDNwPg
	 x5f7AMooAgxGy6kitlCStGqLaeP4lK8GV3zkmm6dTGGApbkxyyqdp3umDTgrWB9MzEu+Q
	 Jn+kB2ejXI2Df/SBrWEsWAs8/sArMfvn4cxDnaIjIVkdGfbs56NacqpEiLbjYwu2rrIAn
	 2A4/eaaPoCKFRw+cbpLUDm20lkWSISDcAhdaeOMAsWJi8KVxONl3oMUPYOa1tknrY3Z26
	 BuYmso3sloynXB+3KXR7dY1EsDDi1LyrQsIu3XvD/v8EVC5K+IZvWXvqb+sULb688pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=UlcIWOZ2;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="T4eWB4z/";
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310DF606A31E
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 19:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 310DF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=UlcIWOZ2;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=T4eWB4z/
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6B8BB1400155
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 15:28:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Wed, 28 Oct 2026 15:28:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793215720; x=1793302120; bh=QFYBX8JLtK
	u06hRbPHmQC8zfe10uS/ehqiN8S62r4eI=; b=UlcIWOZ2O7usw26po6WT4sgUjT
	2PU9OOIYUIvmCT099689qQxAu/V5diUqd+buwFKMg0hHnV5XExdYyBcNh42RgJ1Y
	vRWGS8zYSPsn3Ap+/yt1meyXVSOKkBKA6FbizqRqlt5AjAPI6KR0dyRp6IE5u9k4
	Gg4wDl4MlDzEmJlEIToGFmL9TLauaafALsRBK2FY+/M/LDh0mCeoM7IjmcfY0/dl
	Y/B/cCrKHV+cOaotgu08B78XoWuk5ta30vFo95Sru9TfGKc9o6QDZ+TEsCe/RoKK
	71f8oAVjZO31RvXj2ejkF/AY5NvfnSdl5BopmzEwydXF6wWHE7rypleHBhPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793215720; x=1793302120; bh=QFYBX8JLtKu06hRbPHmQC8zfe10uS/ehqiN
	8S62r4eI=; b=T4eWB4z/+/aE9NHXkOoUNA/cAO0Hd+tahCZkp6hGNjyKSE11Zpb
	ivkIOq4V9cSfL7OSm60vGcNEu6ytmTfqNgBUkAOD65glgN8LTTGsJBc9LRCWPEHn
	szafJ5klv3No8CKLhRiJ2Gf04CWUs0ZcVffu7xNvuuAXw2aKM35wahaEuuDwISem
	t/c2R0TZavfpwyVMtZd+6IjHkxekNKZC8jGLB71QIsuvYjJgEXnG+moXcTDanY8m
	kStySCM26Oqwht6nPROIf/NIKtbPL0bORkR/uzaXF08C+S5JWMzbxikQ2bWxzP7k
	p3zltF8tvf5ZvvhFid9Up/325W76i+sJyPA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793215720; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:dNS2yOq/29FeSWd3w/wrxnlK7HF4vSocqKu+d6Dk85iMdDD
	SUpEZ8VilNykkysN0ImOsgp3Bx2nYhiPAGB1arB/lYJEU0Adc/yXdUot2H8Oi+6m
	GjPuzkdtr9IT8xwvY+KxKJmqgNJ7pf6t+ICeOFp90WfcCcmpNKBoB9mhr/sJpPhY
	jam6SV+2wFw9UiZG/cqpN4e5R3i7yTiLrivRebZpC6UbN+i5rH+/iqY4Rt1aZ2PY
	/x2GVHEsnRVGk2AzT0MdI2pFPikft/Ip6vgGDM0RbRdUfVwteW0z7h3GgJG6C8j+
	ZqxsdUmYPJNDkN6JUsOovGWFdpKkM91cQPypU3w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Xfpvf8xFJrTivwMeEb1uZFhnGRqM1A83CyzYtvTZ3pI=:QFYBX8JLtKu06hRbPHmQC8zfe10uS/ehqiN8S62r4eI=;
X-ME-Sender: <xms:6Eziat2Tj7Jt4W3_kHGeDaUL8y0WVtk6mdlkcJI7vyvhFywAFW36hw>
    <xme:6EziarFD5V4hkIFM-NmG8kpKgQ24MBkCNTLlindmwHEtBTYjo0ip2FDPn4xm7-yvj
    nXWmCgAGBta4TirhX9-i4PzFepFPo5akQVytcyygybavLbdri5AIg>
X-ME-Received: <xmr:6Eziai7mhLWmoXwIX4XGCwpjJA1QxyESW7z5gE4lBzHMknM6JcKI_AhLbU2oIKSrVRQRB16PYa-DVHerT3uvixThmGjXGemkUqAE>
X-ME-Proxy-Cause: dmFkZTE7X98lbSDbGAXXooJoGPbiWD7jnofDZvbEic9ZoYCphqO6RT84T9AVduCctbo139
    eCI/cBaMI36eIhcXozR2UXxONJQxZ1Oviw+mV++r1gNuVptw0PShwBAUBjVZMN8ofgpV1U
    fDSlt3FNswjrBHj1eqzKN88knMqr8EEWUMZxCfc9pTZ2EaOWy4Y640EYJoX++lQAKlVggO
    mlDn+NmC4XR8u2kHMQTcqhca8Y+FuA1e5iuiI9WrtZS1Y5tVAODk3r1X7SmolyJ9WbO81E
    2LcKoyp4hIG9KNwQ24EE2DJK2pjH3y/t2+sSLZWi1yvJ7M+xHjnbsewO2hBJRbVbv/dhP1
    z6QbhBzPLDnowL1D5KKpQo2atBtmUkIPXlvdj/GlogxMWvMJv4AF4nL4QEH0xs1ts5wkB6
    2jHRFYGy5dYEZiAQ/fyZtobGUItgzdISa/r6mVunwfQ+iDUGeP24J9DHT9rVXD2dokbxOc
    p4Wj/xs2+ikMP8MCyiODnOLlmhrNw23lI7fAYowhum2e3PASKhoFlqaSQoVUZpsz1yFGjv
    Id4moHbVnJDsxwsYF+kf1B3/LfOL9OrlIGYR53qpO1L80QqSv8bDRNZMubaavX8vjQAJZI
    hjyVJea226mOefJ5FafNjBtGPAOaihw7q4aBewLoSaXnSHw05EXri3lT/S9g
X-ME-Proxy: <xmx:6Eziaptj65-ECQ4yN8e-6vJexWPTRFt3EaZ-8dpVSHO-Tr5SyQUiNw>
    <xmx:6Eziar7g23z3RSIz2H3sLPp-kJ4Pxe0GVb-PiC0F7_bPnvNka_HGdA>
    <xmx:6EziasWyR_csK-DcoDTxLjsQA2BePSBk-FBDnuUPKk5n_8doBpPwVg>
    <xmx:6Ezial8vq9_smPimUWHUFn25GwyT5BrMvT7yEOFr3G_RLoGXIkYbdw>
    <xmx:6EziauZRBvJiip5-5x1wkIjbs2rUNCtHnGwUZaDeipv7dalw267GXkR4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 15:28:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Git mailing list <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 0/5] Improve error reporting to mention how a Git
 repository is discovered
In-Reply-To: <20261028115412.169748-1-kaartic.sivaraam@gmail.com> (Kaartic
	Sivaraam's message of "Wed, 28 Oct 2026 17:23:58 +0530")
References: <20260924120502.2642141-1-kaartic.sivaraam@gmail.com>
	<20261028115412.169748-1-kaartic.sivaraam@gmail.com>
Date: Wed, 28 Oct 2026 12:28:38 -0700
Message-ID: <xmqqwlr18w0p.fsf@gitster.g>
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

> At the moment, when Git gives up with "fatal: not a git repository",
> it does not say which directory it actually inspected or where that
> directory came from. This is especially confusing when a leftover
> environment variable is steering Git somewhere the user did not
> expect.

I think [1/5]..[4/5] make sense but I am not sure about [5/5].

Thanks.
