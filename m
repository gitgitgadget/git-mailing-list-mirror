Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794165393;
	b=h0TOJYUsJjoRzZu2BA5ztkygGhG0MLsyu0xK9qn2P0aZwxOzR/IKwGKKvc0mRLVlRen1
	 nFnUpjRhpte2sTnTXBuYsdhUAV5wsxnQxJvxGhDVaIuz1a0FdWeAQAribpK+m7QMBXnte
	 gEJLJo9+hioceLG2Jy7aZWHgJRf0pv4kZ7bP5JCuRzLWuQ3FATcNVe9aUJfoxJTIe+4g9
	 cKP7RrrpaJqSVcXrCUUREYt9DEYF6BgARruEW5XGo5IJ3ijldPqVQd81qL14gxb026Brq
	 Ae21LGjU6TJ4Hu6I2SekcQbXjMBarEOao2R129yaH6/drNMSlPM/Fa33NG+GrknmV7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794165393;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=XNSw0XoYp6EOtm33+keWlZDR7BDsThext1QxkKOWa84=;
	b=4ZDw+zDiMjDiIkomRw8tkyWRTYjRSyJkPftlK0ye1dMhzd6jBHHksyfmqa+lRGeOGhOS
	 K4LU8moTPadlsBchl/XiZnO6Y+53XRZlKB/bm+Ey8B6SRtBja83k/Av4xBXNF8BJNv6/Z
	 sbFYAYcKrSpfGLH6o3z28f8LAOwcAyOWRcvfLn/OtAwxb6bwtEQ4m6MN528hNZxlnxdsl
	 46nOvCuZ+BpwfOEWuweZc5i5/G5PFbn07rmI3jQvozc0O+60FDAWp+ixabzmqOLsXK0Yd
	 6KNevMi1qukvfRiRIh/teCXeeO2A5FnKn/IS1O0v0IxvMNaiFQRXMLtbyTeH4yDyKAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=mQ0s8PPt;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=v9h8vIlA;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0083606A322
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 19:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0083606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=mQ0s8PPt;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=v9h8vIlA
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DF3551400107
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 14:16:31 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sun, 08 Nov 2026 14:16:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794165391; x=1794251791; bh=XNSw0XoYp6
	EOtm33+keWlZDR7BDsThext1QxkKOWa84=; b=mQ0s8PPtLQY4k1ApB8PfLdeFDz
	1tYKkuaKSmVBYBTiJO42UON4+f4scINmcjyTJVpijgKFckSNSap5hD7S7ix1u1YV
	0lRZXir7WEswaQNctdZR+WN99xjARxuffIqPgaEUlvh4X0sRbEB5lHdTuFOKW9sJ
	KkTv+AyWBQL9//DswKWx/oSU9a1QDkwblDpV/p3/qPn1ISoxVWS091tOKs8O02gI
	V0a5ehbx0MOAwW/HgzwHyFP3v9fGZs/ytPUmbjQZlEJXAtJGB0QN7A3BcwRCxtsq
	/jO7B5QHzcTSdh6XUVQlCCZ37fefpMIfY14zmx8sfrNv2B4xN+ImNDnkwZAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794165391; x=1794251791; bh=XNSw0XoYp6EOtm33+keWlZDR7BDsThext1Q
	xkKOWa84=; b=v9h8vIlA++yagqMgkyQZ6oBh0CzE3WpfmHMYII4mzlDTC2NwrFS
	kbvhpf8rgxzRW0+WYE1SM5UOi9MGSHHvqipNR1JmyUgGgiznRON0FjFiWkIuDmRE
	zfLC2tW5HDwAnK3lsi50GT4fZs9nz6aw0+S5SPeHsXCmDQKwIA4AGPxRz6FwCWkc
	qN61yV1kbntpcf1df8OptB4Bfj9dkOazc+Oa/uyiS3ZzoPYCZNf0S3F0MQnwjoMO
	V3rhqrS3aeYAEcixrw+gNUORJ7m6OHW8hWqjpnBQF0H/KXotTzDPpMlVzd69WjVz
	g5jPHLP1j2s21b2qzyhxE8Hwnmr54zbqp9Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794165391; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:llAaXPJm2qUWCE0LLNkzfNW6FJZpMivniqswLgjR0p/PVBQ
	OHtae4GxZyy4gOL5yTL92sNEZ+S4UldHlFtOJo/dt8LDDI8r+SoV5az/qvViQuwL
	ou72ObMkBXQ/x5Je7E9Pyy4GFpdzmfOQNRto3NZZJ26ZdzkoOWRMdtAlqwOduTYY
	rcU2qbXPnxy2is2eqVtJFVirPbS5xRJn2OgqIDl7WeCX+uQbnkKtOL4lqYrNe14y
	zmDSfQn6aZieggC81c8ZgXIxlfJPP2ABhcahdkYyy1RhwJ3Di8q8AgVKBWF6cXOl
	71H8tjAKI0IksBId2hXLT7EF8d14MQdi4UllzCg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:z/hauV+D1x4ur1H75eM3QrkHd3FfIunvsVFoRp1DLnw=:mpvnfHx5ul5EYE1uDuWGyqPZ9LJRqPRjP7pBiib64Nc=;
X-ME-Sender: <xms:j8rwat_HDYU_OxJtjCkvSJNbfRJ9l-lN9AZYz1i_ZGjoYzcTkcKSeQ>
    <xme:j8rwaos0Mw-kDjGOW99oIwSuYDtD0Bez6_sbI8CdhvkKai4XjPiLo6W8IUnjvviVd
    dM68UNjDlGhAnYZEwUQHB9m80AHJAJpCcVoSnMu_6M233Q1L0jVUS0>
X-ME-Received: <xmr:j8rwagBPEOICgMrnUrJ0nCoaMj2yJsmQAGtDl3kcXNs9Njvxn0vM0mQ-p0Z0ZYx-PWrAuGsSJtjztJj6FawgdSchv13Kk3zzKQVK>
X-ME-Proxy-Cause: dmFkZTEhtFNapWzUjTjBeoXyiyoGSLmdutOyfronMiNRZ7VysrnMrBOHd8xOHcjxGXW6z0
    U6htJzEzE4dgzjAAjAGMhDqAY4uRl1uG+rN3SSKBsCdwqUvumKbpMLPDCFv+eqORJtaxYT
    BbJ6uWK4BAGnm9AhAvL98q1fFqGpUT+aYBJ/vK93c0/1B6K14vDHJd9ZsA6FXQ/08lXWzN
    SdY5BUh48RxA3cEu1j0asX511jCix2lMjWoN9uN0mRmjpnYYaag+f0AenR8ybvoATGtxBV
    HiVksL5lN3SJzfkwQETduEq4PUGhi5SstWdiIQq9GBow4cgPoO+MCtjn9HWsJIO16+hELd
    lsEPNzOlTesZeX3x2MOJQ/5R17I2+Sk4Q16EfdKwYLTGRtU/g/7/kCfgVJO/Zln3578efR
    kt368oHrGMODVRMnuvik3bZVPB4gNqoBKqeFdMxAYtBYh9mFGHIU8fccO9EyZuy77mjY8K
    EOsFs8d34k48YVHGBH7KIMOvZpQE69eKXajqoP7lQu2YvxotqwoFrSLh1zH0Vjm2HkFblG
    tLCeDGC8WWXzEY66vqX9qEfWAdx+89LTkIm0J6XEbeLaKeJhbGVctLXBlUSfsqyYnGlj5a
    lIptEdBxayPsga7DmJWHIckzWGLES3cZ8C/j31pKPr1bOjN235IpcDBYxxFw
X-ME-Proxy: <xmx:j8rwagWxC5UHxuGmCTHmteqN62ayI-gyAOTWUdD0h7sSdej9iL_OTQ>
    <xmx:j8rwauAS4ioZhdxrOBI6G4VUiBfewfqf3r-e85rQIrXvDqrWoNIqXA>
    <xmx:j8rwaj-XTVRWlA5fpWnphcGOMlAt5RBZ61J0DywPYvklbSAaGxXSPQ>
    <xmx:j8rwalET6zLO03nd3EziXsZ_YGmhZnF90tHnwEF9YG6lHJhQDpfG3w>
    <xmx:j8rwajg1jKeJ8LwW2hlPRqvhUIquG7kGeXy7On8qb0djHexQ4E70WWzf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 14:16:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Hussain Sitamouwala <husainsitamuwala21@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com
Subject: Re: [PATCH v2] doc: describe promisor remote fetch order
In-Reply-To: <xmqqse1b2ljp.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
	08 Nov 2026 11:03:06 -0800")
References: <20261108071933.6586-1-husainsitamuwala21@gmail.com>
	<xmqqse1b2ljp.fsf@gitster.g>
Date: Sun, 08 Nov 2026 11:16:30 -0800
Message-ID: <xmqqo6bz2kxd.fsf@gitster.g>
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

Junio C Hamano <gitster@pobox.com> writes:

> Hussain Sitamouwala <husainsitamuwala21@gmail.com> writes:
>
>> Explain that promisor remotes accepted from a server are tried
>> before other promisor remotes, and that the remaining objects are
>> requested from the next remote when a fetch fails. The ordering
>
> Well written.  "next" sounded a bit strange thing to say in the
> context, but it was understandable.
>
> Assuming that I understood what the author wanted to say correctly,
> that is ;-), so let's double-check.  Would it mean the same thing if
> we replace "next remote" with "other promisor remotes"?

After thinking about this a bit more, I know why I thought this was
strange.

>>  When fetching objects, promisor remotes are tried one after the other
>> +client accepted from a server's advertisement are tried before the
>> +other promisor remotes. If a fetch from a remote fails, the objects
>> +that are still missing are requested from the next remote.

I think the entire sentence after "If a fetch from a remote fails"
should be removed.  You already established that while fetching,
remotes are tried one after the other.  What does it mean?  We try
promisor A, and if the fetch from it fails to obtain certain
objects, we try promisor B, and then C, and so on.  We already said
that and you clarified in which order these promisors A and B and C 
are consulted.

So, there is absolutely nothing left to be said.  The last sentence,
while it may not say anything wrong, is simply redundant without
adding any new information.

