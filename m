Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793128359;
	b=c7KCwThloku8vfdU0MWnkNv8oJtSNkMH8JWa2AaOO/E7Fn2sDhtZEI6R6gSnxpMgnpq3
	 p7PYcFu//xZiMCEeqpYJ4xMgxxVg4IxEK/EGJ0GGM3wTJK9FY3gUzo1EFaponaNgJbr59
	 ZfuLOXPtpjmbdi364mVCSOkBdpUesyc+UlygMeVefPAmA0FSe8uBhhXe8Exod1OaPWwLB
	 Y6m+SVmcDOy8bRWy97cRMtgNKrfwzyZ5L7wt6FLxwuJOsnO2AqaWn2F256cX+F6/THfbT
	 vXK999V3DbOT0gUCPSDY02IYQYbJ3sTxBcwUd/c4sp2xQ6HY6Wo24gKyY3ye3Xy+UuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793128359;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=P1mHWb/1OJTm1bh0j32Rpp+2TiDmSJZA+V8y03KEI+A=;
	b=kcSk0JHKL6Zn+vYHVCniTflyW6D2Yc2dFX9nU+j5zyUZeaNYeNmPBClXMsRBVQ9hy6QY
	 BqQ0O5mXRYjlXfMYVEhMFpOf05lxcDJ5c7HxJv3SgGE++L+tZkLfyWb9Osdeo5H9usXXO
	 3uVTzUXbr+rBbYRSJSxZ0B1sYdZzU62Gr/44fP99DIu+g1eVV0p64Fz1LulPvODvc0QeW
	 FxJk7Ipgm04Vu2ca4V+ttfszsb2MuY18yt7j6+MXt7qr+sX6vLtZD6UAAbG2HsSJYCEDO
	 8AH8qQ5acMQK5UXKQHz+0JzKbS4iOZ0bLgVnDlQoi4nMWbNpyVYSnT7r9rrcbiohI5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=mbA1NPdT;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=QX5260Vt;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A21606A31F
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 19:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2A21606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=mbA1NPdT;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=QX5260Vt
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 08F2F7A00E0
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 15:12:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Tue, 27 Oct 2026 15:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793128357; x=1793214757; bh=P1mHWb/1OJ
	Tm1bh0j32Rpp+2TiDmSJZA+V8y03KEI+A=; b=mbA1NPdTzDBjDRHEbLD48hfuTX
	BjmOzs/KTRGjb/f6QPL1YtGeVBv8ssJ2X73AOKcNNpMOuX7Y733HoheUMNpMOvWA
	MtXr1poeh5eE48wLWepDlGZd3TYnErnhc+Fo+Vpfy9fmBsD97529eZjMB8GpJZDW
	7QURn0lZwN8tgBvEbcvDz6OA+P6doVBxSS/C7PTRoOtaCRzXpxaxaJmL6RoUdvVn
	c0k8oh1iS/UAtjAS9OEdckxfjrKeQEr4HP6IdGXQiw0EClyw+Y/Ix2BVHPNq4pdz
	ke8N1hxUv9YvIkyqzRFM2PAG5IhYExe5aKt4+lVrc2jMcEHmcyZHzjJoRnBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793128357; x=1793214757; bh=P1mHWb/1OJTm1bh0j32Rpp+2TiDmSJZA+V8
	y03KEI+A=; b=QX5260VtQ6Tu4NLZkE74cDRGivVxEQ7nH87lhfvzyB7X/KeOKik
	/L2IVE+XDr+GBHCPRt8Li1ro+7s4Dc4fLWj6Q6DI3PQIoMMgDj567SOw3u5Sy+Fb
	rzgndguIDeFOVotBZX4wH8ps1aoNZNSQIsepZ9n+NgM+el6oANPJotVpwKA3bnLe
	9rPHGC4Ft5APacveUMmcihXk4f3y8WhrHL07hBKLedCNPWsPlbh5szRRqiEU8rA3
	9V2KoYw0Lvh+8OVN2s1qAthHrB06hqyuJXMCda8RlFanAuHi4/IJX/NQiDsdv5FA
	/rXBKoT08h15roQSuJFAni8qlU23mL1O/WA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793128357; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ffVSEjwrExD4HWnsZTwrjeqdhjHAtNl1F7jrOAvxc3dHGu6
	89FNt9WkhqZ+FS6lCWOPDa3yzKmLFl9GQsoywM+e2NKUB3YDIbSvx8wHq0MFa6PW
	M/NE3GSC748mZIqgZypO0I4jb1aKFu7PfZNsd9WA2/PU9aEdbOgRiC0GcaYuk5fo
	ohIGEA9BDejwQxKybDbQgZyHSBCPUExkXDj+5HFbf2FMEziWURecMU9UQboslnl/
	QLuWNbKbz2UdvTshEXPRw26uSKGLXeOVv5NliMIrUE9wa9ehj9lk9xfWZZiDBIof
	ee1IN6eFwLcDEsnNMemzb1pDLiFHDohwGtF5qlg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:UeVsudZ29cNFdKaQoPHtrV+kl1KeOdHaMimGOfqHPc0=:M8Wpf1v/gmC6PF5WwRZmkZLGkiUK7KGLMM7YR+apdRM=;
X-ME-Sender: <xms:pffgakX4_f6yKleetdOFIeU6dKoI942XFnYvp0r1FhVJW5yhpz3vZg>
    <xme:pffgagCrniaRRiHdetHQLq6H4YIDO-_vmopaLVpt3xscsquW9llPLLkRPpUBMTppe
    r41L34KExvYEgucmIN0uTiNi9JQKaHUnHNigfcFX777wxSAoAn6Rg>
X-ME-Received: <xmr:pffgalzXrtc_aThjNeas4QO7utIn4ZrhT-PL8mJB4xLRw9YiyZ1oGEOIGYEv-AErKuuWIPTxzYr1E4osNMKdLTFflkDhuy0nOC_E>
X-ME-Proxy-Cause: dmFkZTGejpocc9kJwcsgpToXnP36PjmJpu5UTxxf8nYnt6LNSPthjjFIJIyB5+fiCmgiqO
    PB/Cx1O1ZygiD8jHKGQjJr9qfqRmpnft215/f+w+7m5J7m9BstEYvqAMzfRUAs4yBCIhrX
    eauuFgshGoSZH/U+MtPo+yzpzkxPXu5rLcj4tDIcP7Y96qENoRKjcXEbdRnbWeq2kASYez
    re/3pA6MnnYaCQVwqOPQjOW0R9i1uUB99oKCTHB0veE5HwTP4WaEX8CLHLB91i4kbC7CxT
    Y+BgD6EwkGHhqa9cRHAqIXQ1DFvSn1xoXoJoDW+XkuXOdfuKCkGPd9/JUISJOd7A8XbDqq
    MexH/wEAGlx3TZklPTN/ivR9LhFWlg20pdh4Cq3Wp44S+s7u6AxJx6RfmtOJ+l+ploilZ7
    0P5Pxx7lK6odx56qd+TyLdXejyQU99n6NiYktFM7Hsivb0piK+MHmcLE1+Wr3ai67ytr+m
    +hF68wbuVs8gQSKBJVxS/5pM1iqHhdnlwxuJHMUEPc9loxS7yBZrRfd9580IlwJsLABvS7
    KfcX7AVGOThnO+SD5lWcucqTwpfO5hAo515Yw3I1MvREQq1QKFOwvsUzgLuA/5+C+H0cMx
    /76TipnQ8TRXSJ4OfdIESmJNFU00m/yaOyzRR1GL1C/awNrCE1tEx3O77R7A
X-ME-Proxy: <xmx:pffgatDdiCRBTsTZq6WOeM33IoEKBaU5QZK5GuvZbKj_WqI7UTKWSw>
    <xmx:pffgaibNsMuiUQzZzSIUUivVISKRud8ozlpboth1UJj6NVLhP9mT7A>
    <xmx:pffgalj-MLCftN5pl04cE547DvF9S3DsdNhZYVSVvyNa8YRPFaZ54A>
    <xmx:pffgak5lUkAlCiafO-18oC7RtIk4RxBLG8iS1Yry7gZ1LUYOiv0zvg>
    <xmx:pffgakAVsGY_I9uyCc9uAH8ilt9Qi5SJ3QI-fqEvB0eEowNbEx3DACDC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 15:12:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] cat-file: make remote-object-info request in
 batches
In-Reply-To: <20261027-remote-object-info-batch-v1-0-ea7a1f0b1df1@gmail.com>
	(Pablo Sabater's message of "Tue, 27 Oct 2026 03:16:50 +0000")
References: <20261027-remote-object-info-batch-v1-0-ea7a1f0b1df1@gmail.com>
Date: Tue, 27 Oct 2026 12:12:34 -0700
Message-ID: <xmqqld7jj6u5.fsf@gitster.g>
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

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> A noticeable difference can be seen from a 10k OID batch to a 50k batch.
> After that the difference isn't as noticeable (the number of batches to
> be requested isn't that big).
>
> I propose 50k OIDs as the default number of OIDs for the
> remote-object-info batches. Coincidentally, git backfill's default batch
> size is 50k as well though it's unrelated.

Interesting.  We cannot share any code with backfill as we only
retrieve info on objects while backfill does grab the objects
themselves, but using the same number may make it easy to explain in
the documentation.

> I have barely done any benchmarking before, so I would appreciate
> any feedback on the one in patch 2. Is there a better way to do it,
> or other things I should take into account?
>
> Should the server also check for a limit on the number of OIDs it
> accepts in a single object-info request?

What I am more curious about is how this updated code interacts with
existing code (i.e., updated "cat-file --batch" clients with deployed
servers, and vice versa).
