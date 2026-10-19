Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792426052;
	b=GG2b9xB7RGI1NeAXUMy0UPf8dLJYYK/dSld9SQmlUgP7tOt50UCwIe/ai/t8/2U2c4lv
	 AXH336UZpAryNQO38ZOjHuQqk43eMk21crBJr2CI3PCpzT2cOxDdVK1RtcwCojlyPkNnq
	 qFCDF/S4l5wlffHw02s5svHU8KH+HvvJe4SJxRFWQMp6FCGpHsp2YUJlHg4DsiEsrWfBi
	 57iGEvB67JdKEAH9z2al5Dlk/+4bUwzbPhVj/zr3BTn3xFOORbsC6trlz//nsgPkhVZis
	 jFbujF/21M9PPS4DH6cj3gEeVA7L7NJkTJspXPyyF8RDfMTvt9VYrTczM8t4e6SA9xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792426052;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Rt0bufuQe0Vr0oWVGOmFrYmgIhaYReQ76RgB+DKBkXo=;
	b=0UfIDvVssouYrcg+eHQJ8db/5CY1DHm+DMafP7Un3gVuKUT60MEVie14eeoC2ikbpnkG
	 F2CYKDal+Zg1Fy8gNKazy3EcjkUyfYxzEuPBvfaF2zdioptJocsDiftn468z348Cv/or+
	 fzktyzTF7AwEVsk9SGL29Gks6Ur0FvvAN7DePp8zVCh66IK1VllXTF/LY4tb5tS8Be5vA
	 wvTTX+HWYEZtJDZGG5obY7lRzkiBVLGSqBIRN0VgFCP44ckyKChA4ZED9HJxWIMHTgR4T
	 j/sKRh1BnbqKHyxg2YZMTVAXXnF4l7GtWQNLtA0G7jH5E26IWol4OLURAu69IegoHgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b="Gv9Wt/V/";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ECk7bMYo;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A357D607AF10
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 16:07:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A357D607AF10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=Gv9Wt/V/;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ECk7bMYo
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id C6981EC00D4
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 12:07:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 19 Oct 2026 12:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792426050; x=1792512450; bh=Rt0bufuQe0
	Vr0oWVGOmFrYmgIhaYReQ76RgB+DKBkXo=; b=Gv9Wt/V/16AIcKQ4cZBKlM7mOi
	eR5VexfcftuUksYL/ZicltY39rXUApJwUBLIUchdTZS+OM7S44cwCRwRVOLSNh1U
	eZ2/8jr6hpm6958wMR/TIUKOckSps50/xuA8qir+EXlpcJ3odzy8+PeQ9JdVDCql
	fv74ZFmNpny10WUF6dLi0XC/3gjrCNtPqo4gZPqme7Y/mG3aARJG2gkG3nQ16PVR
	dw5F0g8LdOYnAQVNWdPC7STL+jN15Uq+SETDtiV7p+I+mUO0lRIt21PmFV2oZdZQ
	5G5HV4mUeZtOeSDRGlXk3FIKvXLKFP8n0cRPwlTlvNw3Uil87rpqYfaMgTqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792426050; x=1792512450; bh=Rt0bufuQe0Vr0oWVGOmFrYmgIhaYReQ76Rg
	B+DKBkXo=; b=ECk7bMYoevauRNGtN2KjUCd1Q8AH45xX/s4DReQJU8mXNCPwKbW
	cJi410vRUoPLqvkXYStYUPIb41FiqicHp2XtdZUb3RvV1YKCIKkPGHZwV4PH0Tdq
	wUqPmRwF1A7AgiX5FMcTrGUeXabHm1PGax9DsBLpEJUkhKv+GqmTdgNf6of9R7zZ
	mU6jKd/cjYCzP3iYgcNAvYehZKzMV4/9w2PoEIvpHCTODUnlw7EP4orqeFsst3Rc
	8xNlnAUkr4E7wvpsuffiTo8ksEyVUx9HS6cj6K2IWXY8FZMBtdQIAzQ0RxSOdqtq
	44z0BUvdPxWIlnxThF3xzaNUfbWe6uVswCw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792426050; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:mOG1R9B33RKknlPdmYNcPjvKPIgVvPEakkY8r0d6R85kaRC
	SHl6ww0FfDr4YOHen9OUhS9QgjFgEazTFjn//CeYig4/RhbGQHxWruA6E1qcDfBz
	r+qgKqBYDYFiEF90FHKSsZGHZdBdPVGyl/b0xB9DqydynjrZdLyoCxUX2jglwLjr
	UWUMFd/7y6IYhFZ09grVi/b+LV+hvtjgUQwSpntSmuq7a4uT93IaM9SlHPiWgUx3
	xXyd3sqkxnlJOxkm/+5+F/WOFRiJOU9U+ywrWCerJYxHldaPMFV90swSsxMZtKim
	k1AA84XxILjDZqjm7qZKSOwlqzqKfnKf1Up17pw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:eU34EJIjH1trb8uDuVPKuFi5MP2rtVNeNFRI8FPYB6Y=:LYV5/B1N0flbMkXpHqqQUDPolTl7vMI3+vNvRxuvSLs=;
X-ME-Sender: <xms:QkDWapFt6_ufCsGajjspRuE0FUj5mhDq8budqcPZJ8kILN7swuUxOQ>
    <xme:QkDWalWtiOoO-BAO6t1AYYIDigXoJfOXU7_9LzBHjmW1th5Byjrbe9b-bJ428Znkf
    UEg13pGT3csnUvjNf7xiXXjAUY-QCtobAUS08jX6GS-RCsysOhSog>
X-ME-Received: <xmr:QkDWagI5MpYr7IqfMYAGMx67az3uyi_H-BtMOWZJUu7BnMuQ-P_b7MT3iYydOKKftqQXgrZoSshTnRUBTYqmRzQtmISjirApA_5y>
X-ME-Proxy-Cause: dmFkZTFfL5KuugyErn4wTcMjILGldD7u92YUfXfJH/lXvHwbhuna68d2/xesHllZ72qgGc
    tMKMSe+gn40aWsjsRMrgweh5ihC2Wsc4zI65F9ZtGo03XgDON30f6Z17MLG6KmscuzDCyr
    qa9R/yAfgVyNZe5GSu1oeixlyZCjr/bXmA3HIdbYlxv8FcW9+IMiDE9DhNOJ/B3XVECXAy
    sv1r2q3QpTxYTRZCj0pQJPeXaTzbpZGJb7aQZNBznlENGN3/HUK0CvL2x7OPQ1XxjVXqie
    rTNBZXu2yut7zyMvsTPgXntUWkmicryIfE0wif4fuGpS+sr2FHqfeQKaxNOeq40hWJ2jXz
    UdGTtMKfxoxLdFGJPoAg4S183+yYXJ6wGoGs4xGrc4qUMpGcJQz6+VtnaVpxATPvzQNXWi
    HMoS682TC1HX/rEDLEgkwim3CreWF5XwUZl52J4SeeUsSlDjn7xaeyh4rvuehbNbNN7mrW
    3Qnty9Foj8E6qwNCCyMxh5AwGtne278oHsNvEMI3fTEWvDqiqUWnsz3Z5xnX2BeP5ascXW
    oWYfaWgqSefSosNQXYksySumPRttbCDVGQzzcPBNgY+BxVWItudumnX6ixvqHF/s9s+7ca
    YRBqy/5N7+06IQhQNU7jBiU7NbFIG+TVwJ5N7YM53XO1NCjgYcWX66JhvyjQ
X-ME-Proxy: <xmx:QkDWat8fkjXPNxXkfDi6Kn8ZZjRRInQcMkJ0J5uWBflQJWsw3XxPfw>
    <xmx:QkDWarIhr4jXPlIIXTWYDXca2Rn1nc56Lnu-78kZhvqTXRRgmV1Ggw>
    <xmx:QkDWaqmShUWoJF3PsuLiDAMVwUKMWlnn6PASiBDKcrUYleH16TtqLA>
    <xmx:QkDWanNbWuVAV4w-mWHuzXqLzn01Yc6jxfbqnVap0YM3ReDee8PqXg>
    <xmx:QkDWarr1MzIbsghqyfDB-5sJQ2TIX-Acn5E1aMKJADmVIxQRjE7SEBs1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 12:07:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Olof Fairbrook <olof.fairbrook@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] bundle: do not free uninitialized memory on bad arguments
In-Reply-To: <20261018142130.2701449-1-olof.fairbrook@gmail.com> (Olof
	Fairbrook's message of "Sun, 18 Oct 2026 16:21:29 +0200")
References: <20261018142130.2701449-1-olof.fairbrook@gmail.com>
Date: Mon, 19 Oct 2026 09:07:28 -0700
Message-ID: <xmqq7bjd65dr.fsf@gitster.g>
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

Olof Fairbrook <olof.fairbrook@gmail.com> writes:

> -	struct rev_info revs, revs_copy;
> +	struct rev_info revs, revs_copy = { 0 };

Obviously a sane and sensible thing to do.

Will queue.  Thanks.
