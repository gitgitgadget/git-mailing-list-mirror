Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794511832;
	b=zXo77LLkDaC7bn+piLCeGd3t/cDjeutcFGbdwo8BVGpF5TtJ9dgnUilleANtBZTZpGP2
	 9DIvjm03Dc/nh1eO4FbciN4lH+CifWT2JULFc663yb8bmsEHunvwpK3neeTkuh41lt7FV
	 1HelNlcxZ0jNY1gEEPaWBYLtT8Gctzvr9Qq4H4od5qux4xIBn2TbdPSGJ60nMKNZG2dsl
	 /NTcpbMbWKf6u0+Z/I4z9B3iTJkpjT2S7zpZqpT95j30IKdhZize8QFfFDqAsMLVEP0Py
	 eSOoO+ngH3Um72eauD584/+WYVKdtf5sf+Q2yGgASjNsh29+E1eda2f6OKm/ZV181OQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794511832;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=NyLwvHOJV5Qr+CyLh+O7ShAtZ6uG70rQWDyLBYWQ4OM=;
	b=ECopW8Pre0y3TGd4lywPUHaI1PtbnN5LA3UIljcDEuMrJ4L1dSDcRnWfAIhvwfG5tSrK
	 Z+VpkIYJY2728o7xKz/+SkfyhEdv6IcydAVAy3MQbsmJngzfGi4pqSNr/6cZ96SshTj9r
	 skpbHa30mwngTonm/Dbrl2FONnLqN6huUfcCW6qxbbz6Z8vLwW+b8WGEHNYL7P7KUf/vM
	 FHiUgBH2Rm8/gdB11oe1GS8LCtOA4cAmFHRIhyeJ3fW3E8uslpckNrPc4ztISdAxm6OFd
	 ausaDFN3asKDQzHMWZEnRtbjJpBl+sTqLC9VI4n5phssSRE4IKVZQ60yoxX5fFr5qnQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GG2TBEAt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7145606A31C
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 19:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7145606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GG2TBEAt
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6798af41644so124249d50.2
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 11:30:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794511831; cv=none;
        d=google.com; s=arc-20260327;
        b=TDY8vi7M1DEGSB5vr2QrMnWYYtJNTM4Ygo7bGRWzYYu2vH9yXL2dIG3RY4Z93a2dpE
         DhO1yZse3qSWjA9Pzj6TndGwQOmH8YvTAvtJj6xjyVJlUIfJJQSHR3ptTtYiFHKh6AOH
         ey4X7/PrNJoZmPH4p/INWLYUWuIz3250zMm91yAoGZbCWdlah2stH0GHpON1X44eTDzN
         jWA6Cx94oNdDHdswADadDMvxWPXCJIVr3kCzEE9S/tfRcdva6EB26m/7H8jJiAf99Gg6
         gE9fwZ7/Y+uailvgiiv7QiHOF1aOAoeXzxo+lZriGGAcG+55JQfV4y8fCxoaTEyYmbEF
         d51g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NyLwvHOJV5Qr+CyLh+O7ShAtZ6uG70rQWDyLBYWQ4OM=;
        fh=b4KVj82bRX8v8E2krYoUGY3RMb341p9Y/OrZE41Y6lk=;
        b=ltol29GgbcM2QFZ0op4N2vwgnisDM3m4tLAf9dTsuCn8ur+z8sIl7pNXBkpDcsmx19
         4qsiij79naFmkU/2nGwBpWN2BTF5kAzrH3/4q0nopF+RFg+tdmAtftwtR2I1TDcE8Wl5
         gGbOXNLRA/QnzMFtdbgfgAiX5VhsevjxRahk6Qn/C0bZkwr3WNXUPbBSq4H1s742nZmz
         Belq+vkuixZjo06mThLasHCOx4RVDH4cLseHB5pHa6PzdYiG3WFQaQ+vbGq7TGHLYux6
         oK0HH3+d4rFYFCjbUzGEwEriGrUKjCZHZZt2KjMf7q+R2cqmH346W0Phk0WXWg7KXXSV
         /28A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794511831; x=1795116631; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NyLwvHOJV5Qr+CyLh+O7ShAtZ6uG70rQWDyLBYWQ4OM=;
        b=GG2TBEAtLroXr+dqc4jJ5wtKWIjUqIWUBC6g6zOjkJ8hjfnYd6OZrctMgUIcHl53g2
         EB/8ClEXSGe2OE3/2K36IxS804+vd6lkjV1mnzkEUBavupA+8maLgtja84bD73N4oZnB
         RrA2AgDd+pTqGRjEBtQGhqxbHJjohZyZasgO7DNqkwgyi+R6CARL8O4s/1bewNMk4IFE
         5cJI/iSMgifPdfIx3+aNc9H6Cd7YRVwd3QKDardQSnqE2W6O9FF0tFMccOXhmvEzpgBP
         Vi4be1QvJqBu4I0i9NMyN9YFk8w4dDmAcDPyTrPY1RLcVgrPboRy5cLH/IUQHsOUEic5
         dX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794511831; x=1795116631;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NyLwvHOJV5Qr+CyLh+O7ShAtZ6uG70rQWDyLBYWQ4OM=;
        b=GI9s08lFxCJU9fxALa9n6mGJ4+vLGr1obhp7yifNjHFQl+fWA03HemnpTetcidFWyr
         yc9SEku2l9Nd2tt90yPY6uo7cNIVx6VaYMY3TKwn1itefFHp+WntjFVHVFe2HRrxtEnF
         aHUfML1x1NulsWIc/BMZdBrIXyI6dC1uGHkYosQC6oCpVN+Cck/JIfofpsp1MGjbY7AX
         wAONd/viyFtFNwokKW+UAH4WtnllLfWiuPIQQAAX/oodp39NXVqHRUGkYninyA74WIew
         PJP+jCcxjCiGMAUY1hrJ5J7lSDxdMC6mb8wutIw9QDD9HLzlGv9yYwZWIdDSwnLJSY5v
         hxTQ==
X-Gm-Message-State: APuU4Z+py/J9SrFMchf1Gk4IuXe0oZnL3Yeeez61+hwMB4vELX7ak6a9
	WsVEFYcZCwB7xkf0jz7maQLO8zG7qQO7bI3xLam01fLtPfIFU5H9wunmuPmupgvhFvQprwl7Ini
	ONzfeElhciRE036X3WpC/luQH0sYEBBdbZrZTnb8=
X-Gm-Gg: AYBFou0EXIbBUv3t4fCvA3KXjxZIk+OiHgk1vHgAHVUett8piDPjWufcHW69rk94uic
	lrYlhTjAHn0p3RfyFmy/qe5XYzB8tWlBuo2F4GlCBYo820lcG0qAKwdszngw9Ps7OY6hbQ+n+9P
	GIV27bUFcny57Q7qZ5eEd01y3AH7wmHU67NnH13y2/h6Ww4YZsN3FOP6UzZIJeWixSPQI3VF4y/
	LdEds+Reo1hiaQqkNq4W31UiHBE1W7tVYpkREKYwUZngqJj04JqY4v/PSkb/eNeeCwaFNPMoyU8
	0NhM0Yy0zyBMZb8ma/SGer8kWAuHLAiR7O6zQpoCDMfU+08zGdNxazd0DhIawXkoAlwclJ0mqHS
	dSmEsrzy2aDcx88NvCWesA0r2GI0EqQ1BpobM2EofUMtjt8C1HcXpmUMFfjk9XlNb+PuLTksyn8
	9T6DjsG5KRxfimOptZ0bWpN2qqvvznmR5d8h6Z4F2Q06Ajf2hEr2ZVNIGRqCO0bPBlnFHf6HDNR
	20Z1OPmAJJ4ZBeai+r8Gk5MnRrEznPFbM2B+Q==
X-Received: by 2002:a05:690e:4281:20b0:67b:9953:2d97 with SMTP id
 956f58d0204a3-67d897c4ce6mr208733d50.79.1794511830472; Thu, 12 Nov 2026
 11:30:30 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261014232739.23021-1-okhuomonajayi54@gmail.com> <20261016212216.58000-1-okhuomonajayi54@gmail.com>
In-Reply-To: <20261016212216.58000-1-okhuomonajayi54@gmail.com>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Thu, 12 Nov 2026 20:30:19 +0100
X-Gm-Features: AclHuK9EV2JCWXXe0Nk5e4FVVzUwNd0UNjF9ypCs5PnjupZWgXDM7VtwaVmrASQ
Message-ID: <CAFpMFfATtOLN+rakxxBzSsdBkYL973AgatcJhQvX6GK=vBykUw@mail.gmail.com>
Subject: Re: [Outreachy PATCH v2] credential-store: add lockTimeout config option
To: git@vger.kernel.org
Cc: gitster@pobox.com, christian.couder@gmail.com, usmanakinyemi202@gmail.com, 
	siddharthasthana31@gmail.com, kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Junio, ping on v2 of credential-store lockTimeout.
It follows your review of v1. The two zero-timeout tests are now one
loop, the long lines the patch added in credential-store.c are
wrapped, the "both set" test has a comment, and the test that never
held the lock is gone. I have not heard anything since the short note
on October 20.
Is there anything else you want changed?

Thanks,
Okhuomon


On Fri, Oct 16, 2026 at 10:23=E2=80=AFPM Okhuomon Ajayi
<okhuomonajayi54@gmail.com> wrote:
>
> Support credentialStore.lockTimeout as the preferred setting
> for credential lock retries, retaining lockTimeoutMS as a
> deprecated alias.
>
