Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793988871;
	b=onw5VErzgS6JaVmG0lGfp55CtHCaxiTXdp2VkCrsG2ynuOXNhBKYs5G/Mp3lgRMO5z5V
	 SL61f5/n+8rq/ohicC3YxeZk0evsNUClII6xloGpvBAZn94wfBCPSngbVVnCiP54q2tiK
	 zOiagJvFL8KtHTMK4J2JMZ43vCf0WuY/MbcOOayvd+vfPE97jvXAtf8qzberHuK8AYjkw
	 O3ReB0SRFx8XmO5onbTniesnwMEVQZJuc3LkNATEDX5SLwHOhSJWxRqagXXsv4MydGkpn
	 H741DnLellfgQz4kj9tzwnmuQVmMJPrlZ9ffxUfq8WeIKkNffaPQExJFh116zpLTyvw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988871;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4IajLsQQvuN1e3SYxp8qgBVALHRmoJai74GyB38qW2M=;
	b=GHlqbye+p9XmnMlpFmCvmoa7/xvFG08zYqRFnLwqag7zSq6STcdT2SDr3nL7YPizMxTT
	 EA05U99y7xm+cSi1J5l2HBX5QtFKRwGUbRnbnAZqufEcFMxXOMHn3YNpMDMSHeZbV5oDL
	 +QtOGIEmEcwV6rGC1hWGkOemLjb5EwuZIHe0r7yFaa+Tu8vMyrgpB4IaBA57Yk90ojuj0
	 vheO6I+CSo/9YJ3L2rCBmcOGXLYVNMOYNXlyXVYk1tRI3US3LIFqv2OMWDWU6QClTB6dn
	 wpRi58D/JTyZPJmzjZrK27J1h1HtNRDo/5ewKoy78LQKai49Wh492yeE1sBAZ7Yu1VA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fv1MbY+9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDF0606A329
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 18:14:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BDF0606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fv1MbY+9
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-91c79f306e9so11324496d6.3
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 10:14:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793988870; cv=none;
        d=google.com; s=arc-20260327;
        b=jBfTxb96n5u41hD1ZWBxPSSYzZNlPaqyWkBz6wOF94iLyz3zEypPKwRoB/nzUXGt+2
         Sro0DSefOkEMf63yOWI6rgsegGc4qwzscc6nKxUMVjgO0ARgy6ZUdg7xAy1azCyDEZQ2
         LGWu/9u8sweAiMB69mjr0kklrXmuJFjQW63YT41xJl3+CSA0NVJt2lBdeNIEQq2A/M2z
         zwkh2gb4gi9AGLXFUo/yBdzMjr7pdIEuesiOsxkqQXuEKHckWoBFi6rANXGQGQM/zfjv
         Kn1zI2WAAPQPLjeBoctEhVzRe5yc4qrXk24c44FdePi2dAH4NUDluPNBu6xR2kJKU+2S
         HBiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4IajLsQQvuN1e3SYxp8qgBVALHRmoJai74GyB38qW2M=;
        fh=1b1C0YuqjfbX5kRQF25fXvHWTfksFVKM/nGajhrXZsQ=;
        b=DYSLVAuT4BgdwBOFejkRNlMA6wD6fP1AaySaX9qii390pkqv0OVDQsXf6YwirKXsob
         3BV24hzl5B0bK7sZhWAB1eoHfTXDYpblVcukiOmf89BuTUCE8yrtjMKf13drY6hiOhks
         KCX8vqPm+T1MsXMB1W77A0fsm9iGgzF1aa/eoGW2/OMBZqjAX+3csjMqc9I23L42HAeO
         PRYiQWocdSRBq22aaz8grqtKnfGjvXT5JF3stU6ZUyEaAoIbY0oIwtnCy3+JMovGSkw4
         dVAwVRpYsFI+ZBcoLZGLJ3IH5saG7/gasdwuyz1e9toKoQeWAMtfrybS6burgE3/3kak
         HitA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793988870; x=1794593670; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4IajLsQQvuN1e3SYxp8qgBVALHRmoJai74GyB38qW2M=;
        b=Fv1MbY+9BA0dYAi9EMoFLYM9EggmWRcQSjBsmQVCGoqVL2aqERQui/onAFPaidq1uK
         qV81ZlXL04xY38/PRg05yrbDe2ZOzF8FuV/Vb10lt82O3mWOQKbhRJSGIEOvv8Ud+OOP
         gDqVjdeYvp9kNfexNfrfXmQYX7OadJ0vddEoi046aC8vXRRcU4YE2RHk1w4ESMhIkDd9
         ta0Li+1tlGNJCUh9k1DCPaQwN2yKj4Syb3G9LQhRzBYXrqk+BJkJKvKWbZTniPLn4t4/
         CwfKMU3evKNiyERYYRRTVxMYwDhCpvWPF0HaMxZV6fvlJYaChlwjQ+G/SyglwC14TGao
         Gm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793988870; x=1794593670;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4IajLsQQvuN1e3SYxp8qgBVALHRmoJai74GyB38qW2M=;
        b=nfeXCODhcKnUW4UJvfEXKar68l6vLSQNpRtSFd+oj2TprOdMEmY/Z+mEZjVWgV/rBN
         p6g0sJMMMovQCwGX/a4Jla5kkZ8Nmh3wTN1aLgEvuvgbPhAjSjObA2qJ073c1RCJDXGU
         H3MpVwQTA/83gHBMBAuDX10dlCnDWteGKh1yKgoxIpvTs3ykf/Dm/FESSE9sJbqGp2I2
         vnvXe2/oVMp/7uxJSZBUfWK3PAzLcjmi3IVRQHdiQ5hkakT4taaHIBus8zpUn6e+/RyG
         ybgVpobiCLaT1O7SmFWhXIXnuwFbbYVL7xhPil30uC4w96MCb11IRrVemS1D+YfsaLLz
         z4qw==
X-Forwarded-Encrypted: i=1; AL+hErEZxuDDhe6hgNUd30VD+DzIkVLc//qOcl6MkGp6AYJAq0tlLwszKdRKGPvwiCLINMgmFUY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+3th6k8t9ZqTPYR6LvOEkThZ1By2hsIl9JMjMUJLuuuFVQMf61
	TvCcMZUxdSBQVUHHJAVL97mMv0QuQmg6NuBa2mZMyMa/LrguB09AUdGRsnev8zQQV/Asfy491hw
	vp7yB0NJhc3rYpC/4Ql8z1bZBZYViZ2Q=
X-Gm-Gg: AYBFou12tQRAB98q1kNPB3aeDDtA+lOwS3axFrXKvJNOuUVqcKYaGaw3PQ4J5Udy+5z
	3DScm56dkMePI1lqFJ1BP8kFLvE+yxrLg141AEpJQsrjHQj0G/IO6QVLjEbx640Ik9S2GgcH5Gl
	WfXxXB437DhANZrawd7igqPCnnnJF8+SEIXfhPSV0+67T7lPca1BGjKMF4nBJZAk7WewJtXwlc1
	ETZtlDZgV7b+KdbCB2Q1JkxBgS0nOgug1yvfsJ7CHpBVp1/VB0s3zApRgCAtwr+EqYoCLNlokuK
	FTl/o9tImsOqGGMXt0CHomaEWM+kka8drEH97WofvWKqgVn2I7AqmfteB/txzUszTFJ1r5OEEPc
	8SXQZOIf2Upil9Sisq5VnvzM6kwYb70au8vhIWXA4xOpWa1/hz4jyK3tgqVuIloDLZY00XuWGEn
	SuFDToD6qOvDRzRWsgiAF13D+VVbVbSXQbcBufZOiRfUUYcLbQnx0v0qA=
X-Received: by 2002:ad4:594a:0:b0:91c:73c6:2d68 with SMTP id
 6a1803df08f44-91ea92f3c5bmr46642256d6.5.1793988870205; Fri, 06 Nov 2026
 10:14:30 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2288.git.1793435149942.gitgitgadget@gmail.com>
 <pull.2288.v6.git.1793821554097.gitgitgadget@gmail.com> <xmqqecczxq2y.fsf@gitster.g>
In-Reply-To: <xmqqecczxq2y.fsf@gitster.g>
From: Srujith Poojary <poojarysrujith@gmail.com>
Date: Fri, 6 Nov 2026 23:44:19 +0530
X-Gm-Features: AclHuK8F1OUQy3J2hbzVY_3UQEB_DqsDbfoxYRHoaij0SOkdACb6FjzN6EvOQpM
Message-ID: <CABh_KWg-j35OrpnQvn9L4P8qpWHv=GGhaEJe1MHV_eH010itOw@mail.gmail.com>
Subject: Re: [PATCH v6] submodule: use the submodule repository to abbreviate commits
To: Junio C Hamano <gitster@pobox.com>
Cc: Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 8:50=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > Range-diff vs v5:
> >
> >  1:  f94aa2476f ! 1:  01c3cc2573 submodule: use the submodule repositor=
y to abbreviate commits
> >      @@ Commit message
> >           Use the submodule repository when it is available, and fall b=
ack
> >           to the repository from the diff options when it is not.
> >
> >      -    The expected abbreviation for a submodule commit depends on t=
he
> >      -    repository's hash algorithm. Use test_oid_cache to provide th=
e
> >      -    expected value for each algorithm and remove the SHA1 prerequ=
isite
> >      -    so this test runs with both SHA-1 and SHA-256.
> >      +    As the expected abbreviation depends on the hash algorithm us=
ed,
> >      +    the test uses the test_oid mechanism to switch the expectatio=
n
> >      +    between SHA-1 and SHA-256 repositories.
> >
> >           Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
>
> Very good.  The patch text was already good at v4 and hasn't changed
> since then.
>
> Let's queue and mark it as ready for 'next'.
>
> Thanks.

Hi Junio,

Thank you for reviewing the patch and for your feedback. I appreciate
your time and support.

Thanks,
Srujith
