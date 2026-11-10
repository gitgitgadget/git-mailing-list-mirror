Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349329;
	b=ZLYonih0UffEfo3G7YqRQ2LAow/FZ3YdhAkw8g/QaL5/NbtCScntpujLHrBzNHldu3/d
	 wCMZwhM6nVloXmHFQzj3uT4aMee1grMqLjIKiDToPtQvXyVTSpVLctnUdX0ZnoKhUiZtJ
	 R8Aikmjt92uK9KYilc3HX9uv71iUS825ZLUb4uoBQGNqXszjEXFMl1xnqX5LZZlwMHvV9
	 nrgKfOlo5yKbvbJdNazVDc/Cxe1MBgkm04AgVA4dghsWlVYkTf3UQNId3eISHk7a1VVTM
	 P777V8hKzNEAsQxRbzWLXZ3vNPjvcnKRZu4S8AsqJyXhP4wIQFOPmeIe3rzZMIuolZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349329;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=zbEr5aYM1ji7sf4V6eR5qoUGtbChemVKqsTW/kghpNw=;
	b=yVnVoSh9dBWC5bpmrJJtWcxhZn2o7XDemgZ2EIWVO+3IlAeGj8BhWamaQt/xi5pM75u/
	 WIAhSGVzW9Vb6b6eKwKEEl/5QZckQgvEGbTwseETv7NF7ahbHBYIYakVKPo7bl5uBwZ5L
	 BsQr4upJOwHpM/ZZWr6x/v9iJuCeuvZCC0KIeDsuGl+5nwAG8u4ICzNOkVhFjS4zBn9rd
	 ltulJSUCtjLlnuR2+x+PBa/7hPQnwzzjqE9H1dX1YVuxM85NvZEkKYr0pmuulVXHK+2kX
	 QrKVJ6udjIltJJdruIAn6kXrMYlHfHC8a6KAiuKF4+8rUfCPShi4+KsAaRPGBS3RxLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=MeboUV3e;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=I8dpuVVE;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B332606A320
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 22:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B332606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=MeboUV3e;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=I8dpuVVE
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id ACEF91D00192
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 17:22:08 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 10 Nov 2026 17:22:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794349328; x=1794435728; bh=zbEr5aYM1j
	i7sf4V6eR5qoUGtbChemVKqsTW/kghpNw=; b=MeboUV3e82G4IvrxiteF8hmVGS
	dsRVBL3Q+5Zh4HbOLcgpTWsagHH1TsxxLQKnZP+/QFKTWlbKRjIxBUNnBLw1Yf3q
	khAODaQ/1MkqiCl8rNb7FhulSzb802NsCJ17xyOa/l+xbnNhbpR1oe9ySkZcEIqo
	7YulKfAtnRrwpipfk1TZLjAkq+QKTHO+GefQOxrFrgykA2xT+yH734GcBbuJ7N0T
	ovuKtsZVZTTYiHiZvZD9cfqyoh7qn1adBhoiaA3A4xRXOu+tpph33jyEhWct2Agz
	zHbQLliLxuE+GtfjDiCT//dyYLUTwvVofedMXAklUiTOc6/DD6yQkGZpOxrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794349328; x=1794435728; bh=zbEr5aYM1ji7sf4V6eR5qoUGtbChemVKqsT
	W/kghpNw=; b=I8dpuVVE0YalhZvKSHEw0vDbnL3Fq8hwD0KAf3RpxJvk+nBo4g5
	+mNhsuBHj2co88p9KDem66QdI2/zKk/3Qi12j+B8WT4pP9lUclUWFP66Y//lECoG
	PXSDsLm8wDrEHwgKLIPO5LaDKmC0nN3SCS7/PqvCqe7h7qEHKXFVcnVv+OrJtZT6
	ASAS2dgfSuJ+msWKGmkyYEsvSkAeH8NQONDj4m7rDK0uPOjiiyKBSBWYOv72r5lM
	x/T7OX1L8sOXuMGWGBqIl1NMRU6aiYxydP0xWikACdYyTnOW7ft1yfn+hj1++fOS
	TThATSyR3dNUzXmkC973VMyllJmXOQFZ2cg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794349328; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:CaJeMjElKpnE4i+MzTh+ennhcG0ITv+SOgeCiAtT/RVNBk2
	TC/whQN70qqWGsNh00Fj6DVwwo4QwmEJqF2yZd7jQ7zZ71i4r1PrS2FknXGfPa0f
	JOvFbf+AFY5PpyB4EU6lpJy0SbObo4bxPiKGT6+TAfHYmVmWMy/jMRn2TjTR2oOb
	5ND0is/uElSDLb33lTFS/PPYAeSxTZeYHeq7jx76TWnu0XOVtjII3aLJn48X0uZM
	XKAihvaLas/WP7mv1WfjJVR0Oroz3CTrX9tE6OhvxU/XX1C+8cmKx9KS6STxiHOi
	tyXPZJtDqB7kvLTWsubDQlAGTdFy2c38guUH/Ng==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:IInNC0JC67leipgeB+hArBIsKrR0DMwq4nOKGATs47o=:oZjZNwJ0xFExMWlk9oupw8oHZOSd6hdfsjV+uw6K6sk=;
X-ME-Sender: <xms:EJnzas3NE1l4YIK2756fn0Nb-llzbbJqH001Xk7P4bH1eJ1wW43Z4Q>
    <xme:EJnzaqwPwi5lBdF_6WDuQpYzeCIrNZwIx2PgA97NKGi2v2m8WddxbvQryl7anCtn4
    v7qXX_I13CEaoLy-nebIt16DyAeiIKJF-jQPqimGoFhy0pBGLAAIQg>
X-ME-Received: <xmr:EJnzauuOCCZ3ca16iubzU09S4v8D5pfgdJH0KoQNKyMVnrduDclhOLlpOSBRQ7VO5lr8bWUcIAHmuB18VkiqHi44qWs1rtGMFzzJ>
X-ME-Proxy-Cause: dmFkZTGVmEz/DHt/0jyYL91CWqQFWYSz3ue8F761juxONO+gugD7OYjcfiZPNtjqhKYEuQ
    Vod+fzZ3a3AvVfocerFWuwxM2jFY2tRtVEDft2baVRDhmvMpAwYgnx53iemTfHLpRsJCsh
    tYEpwiyoJpMmLN747hcpoa4Pj3S/ZfRh4qRjgVqqz1K4PzzGzFF1hWu/JpWMknCDQ+Vdrb
    +7LYZlJ05EYpags3EjwZkkUu9r5XV6L3SIyGR8OkjiWPpXnPa9KOJ+IcJHANkls75XMHOH
    U2IwiBwqCqWuoTHRvENaTjO28gXsF8F7nLTDBKHdX4Ug53OUwcDO7bSFROLQE9Sg/S3zTT
    zQRETYzacOlUGwA8qKnenYXPQF/v1TYT9qz1wQ3xqzq5UfoXEdnqTgzEtifiGNm+KAgSW+
    ubv2n5HQ0m5vgPNxiDl8AayGUxYKO7U4Eo7k685H3sHLN1riXSbivaAbFxmnAWm67xHKXF
    YS9BJzEoZR/YQkJj9vvM9QcUQhE7RHZ9PJHLxYvIYHcGCguOo9x+ie7YKwco+MspkVoDxQ
    BArqHCRp79hoCEZdjbqjN1xyTiDnOLaCm9MyGzVOhrKqSQJpW4KXBkF62JUu6HK0FLBkHA
    ShLCJOE7mEe+g492/+FJYtxmnWPuvdEz9J/0aC50X8WUXHlh8Hp+UinJG6Yg
X-ME-Proxy: <xmx:EJnzasxrnVBD4GJdyV7Lrg1T3pW7bzmwFRMkWww20nXVk9kmFcMVKw>
    <xmx:EJnzahD9ZXAzq-RptCPFazSjhgKAJNztrJQ7EpJx2pTKZRxRT56XnA>
    <xmx:EJnzaqc-uTamkWv9GOHNPQhFo-ytor7p62m1XNjofKU5AZ0FGopBWw>
    <xmx:EJnzarktJl1EygxrNkX2S4IVDc18U6rlIYpeHIoqjQmmpBvW1mpz5A>
    <xmx:EJnzappPw2hXSdjpAuvO2vMtLJOwJi3tnPcO8-3mnvq6cc7ykMpqUjI1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 17:22:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Wyatt Holden via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  wyattj.holden@gmail.com,  Wyatt Holden
 <wyattholden@microsoft.com>
Subject: Re: [PATCH 2/3] checkout: advise when orphaned commit checks are slow
In-Reply-To: <90f09054-9013-46f6-b4de-9be88d1f3126@gmail.com> (Derrick
	Stolee's message of "Tue, 10 Nov 2026 15:48:58 -0500")
References: <pull.2264.git.1794337920.gitgitgadget@gmail.com>
	<a9b81eb87684fa9bfbc83e845eb67ded8d7cb6d9.1794337920.git.gitgitgadget@gmail.com>
	<90f09054-9013-46f6-b4de-9be88d1f3126@gmail.com>
Date: Tue, 10 Nov 2026 14:22:06 -0800
Message-ID: <xmqq5wy4pbsh.fsf@gitster.g>
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

Derrick Stolee <stolee@gmail.com> writes:

> On 11/10/2026 2:11 PM, Wyatt Holden via GitGitGadget wrote:
>
>>  	[ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME] 	= { "checkoutAmbiguousRemoteBranchName" },
>> +	[ADVICE_CHECKOUT_ORPHANED_COMMIT_WARNING]		= { "checkoutOrphanedCommitWarning" },
>>  	[ADVICE_COMMIT_BEFORE_MERGE]			= { "commitBeforeMerge" },
>
> It looks like we have a slight whitespace alignment problem here.
>
> Thanks,
> -Stolee

Good eyes.  What the patch aims does sound sensible to me, though.
