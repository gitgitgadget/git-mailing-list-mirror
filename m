Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795612049;
	b=GZN1lKG0DGQXwqOJpBsP/Kf/Ej3a327BqS/dg5jtDci7mH2BDfhXrsJgsf8l+pXRAHdY
	 cfGeIDumjkYtgZNf1AR+AWwgT0sEiuGOTsWtoXw8AY5qG1fFaapQwQrRc/uLR9ZOX2edT
	 Zxy9uxk7yYFtXbCT5m+A9RPoMM3r/ReU3DerbgTryhxMa8P+J7lnQiUKCjY76iGyrenxX
	 vxzPxORByTGSmLHR2G18ADb/WmLOWUAnjV4avqS6OTaJCUJeVWNtDo26Tjdk5XhtPLnfE
	 miwmQvmvmVFFMTsQMLH0LIabrkjNFBR2ccfx0CRTqIfHXrY9xxx28uHF4t8t0dzm9wA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795612049;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=DXI6LvFXS4056gAMiR1TPVq8EC6dscZ3aTp5Jqmu47I=;
	b=g1YS0wnA0DGGVhgTAlSg/XtNS8eD56sYLKbC6OMGljuS96gVY3pPVrTu4tnX/NtOEWrW
	 RfXUt5vuBYQPxV2efP99+7K0xMMuoycVyW2yTsCuFVM/mRcnKgAX2CFjAP7WV8hsaTh1G
	 Oax10y3J/WWN2yu6E/wL1wiIwWE3wSQ83hei9f6OUi6aYPq7+YbAfUUW0ZwD4WxNYclcN
	 ZmiVnUH4nkcH9YabsbVlqCay4+hs3k5XcvVA3SqnfiPXGgtHzRbJltQQ/QDccLOQTkUVY
	 Jhjt4hf37HpQHxHAUZ4sbHXQclPzh6n/nRaA5SmnQBv2biiesbbcT1t/DEo0YhazqQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G0GKxjGn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B836606A326
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 13:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B836606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G0GKxjGn
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b4e04eda5aso42462237b3.1
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 05:07:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795612048; cv=none;
        d=google.com; s=arc-20260327;
        b=f0K5cPE7JR/zjnpIl+bYq2JXSx/wI4+P0URSjTlyIRYW1EbFa/0/k3ip7gL7VMgwhQ
         nOOiLJs4vHEWS+H2spYPf2OBK9mUB1n+tq/MrpjPb7PiHU+fa2U2HeLhYub429j/oAgb
         g3RjhizgiI7/c+N5qfBFaUon4o9UyPCYzUboHH7vXK4AKdemVuTcby4oCC9UsKlD+hHL
         PVUkhYvtsDXl1tP2yjZHqsI034RG3jLLjSidx3LDUwcdysQEKFZk36U7RmX/Uk/Oh6e4
         1yVhEapveioaXq8wWnRrPrPHzI9sBJWIMAwL4SD6/0SD8up7NYqM64dmFl42/kaRRx4F
         TQXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DXI6LvFXS4056gAMiR1TPVq8EC6dscZ3aTp5Jqmu47I=;
        fh=Sj7Hs4RynTptnDQI13LlWhQHFCuJGBFOXNOrah35p/o=;
        b=qR3KFmguDM4PjjO5kiAd77nCPoxbY4RT2rHRDDiwwjmYbuY9YmflRxfJbHwOrBkSo6
         ClvdqBPOFtCSOpCd0WhId9uY3/h8wgoTKZ8Dm8PJSYuPzU+lovLqztbclCTresVwRGfS
         d5jINYkN/yBlNc28P09HQDP6JW7a6uPoj5ylHu0PLnsXVAEYFf16hM0tY93hyGmAsJLi
         DPq5oUK/qu6xt13s3M++eYozAaorRlEwMZp2qw2msWA4SPMBPtyJxR8S2Zd82asVLuNA
         39Iu3Ng3ExsVCrjyAKeLLp6YAA7A/C/YtnBwxXtE6tmX3QzJsHKDWZk+zTUMf4Qyu/02
         LIaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795612048; x=1796216848; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DXI6LvFXS4056gAMiR1TPVq8EC6dscZ3aTp5Jqmu47I=;
        b=G0GKxjGnk/UROdGrTi/7pk2v+J5p3QQxp2gIAC4CISsHvSo6Jqfz40tIRPu3VMRkKK
         cCc2YSr22TGEYeMXwoVtLfuklJ49GxCbK7BD5KzxYBpAdxupFuHO/1v8v0ulZMJxQgRs
         JtghU9NrSixxXPa3D/ZfnOwOCqeMfoZxOvDf6DJRcdVcJyDeudfVbbx1m+ZA68+GLbox
         g4vaBHI+a6EsfyV5qXSjzFZksYnGRpNJenXcnTOPqbh4c0uANyz9w1I1+CUHXwm0Rhud
         i7dDAVt6eVGg9bqrd/GpjqIAfOh24mLg1UMPNPgci/ppfQvb+7lNCcvw0RQPr1mCfllo
         NJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795612048; x=1796216848;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DXI6LvFXS4056gAMiR1TPVq8EC6dscZ3aTp5Jqmu47I=;
        b=CDtmdTphf1a7PfIfBbUuLgenvWafxUAP0m1z6ny+7qFX97zcEMQmmorbhVr+V/1t7T
         PI3XZrUrpEnIWnSIHARy9N0C6r3lcj7Xyl70F029y5GfSxsJlMjpXlAiUhBjA+EpMqER
         KXAub/70P2Tp5Bok3GY+22GVe4UF91HYpE3IShyvWzQTky62ac65HHIIQIwJEDX5ScGm
         Cd5hes7Llfm2/UMULJFzCLONo0ed/DaUPgnslCiPRpFc8L0khAFChYn5f+uLEDnvclqS
         sviO5o8SBCrLCNAD6VcO6FPkKCNOsMVLxmXXU7M43hZ5wKOAg9mX5yA6t/mwRpFt5nWJ
         wFMg==
X-Gm-Message-State: APuU4Z9ZDwvHgvztMZB58ans4fSLpanVJymWcuN+BSCLVvfovtN6otCD
	E0glwj9B7Lx4iq48dWbZ5IX9aHQAgQOy4oL3fKQ+yEF1R9YOJ51/d92qF5DeXsXRwhoNiZj6cyt
	FI8xm/pzbSLaRaoi4tvfwEkgprgsWM60=
X-Gm-Gg: AZFdTZdrtfOcfOl16S1eePa2/0ZKf4SF5hSYLWYFhMTfIH9oVDlf6AAevfOdoZJoxkh
	Wq/gIBUDsvHTJmWyojJLfSFTEG34kF69NcZnlJAnxG18WJ9EMwpXDEIxwUfFKv/VtIyWUsIWpfe
	S8JPjrQqg2i8yKYolkZe6Wb8BAAAW/5r9denif80MlcKsOxwIXxB9m9j+J7GuH7MESbZ+PIRTlB
	44ptZi/ZodhMb8OKmHiRCGu9nOAwmy6gjuU96KPeDbzCLaa7FhFZuxw+swe/GaHeqzL/UxoeYwy
	tKrKR4g+Q4gxgGQ0M169qP5EfvmyxJyNxi+pkYIoQI+tqUjm9ycGReuiwhsdtC31QxYSwiczGgH
	+bnFdY6i1EctOMFHdUy3VCRBhO+MSbUm/MxonWw==
X-Received: by 2002:a05:690c:6306:b0:8b3:40ae:9720 with SMTP id
 00721157ae682-8b520518b73mr84527397b3.47.1795612048253; Wed, 25 Nov 2026
 05:07:28 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAAQS9U+Ht3x=V3e1XJT9V120Tj5jCuCMTrxTnZyzTpsg-G9uBQ@mail.gmail.com>
 <CAKrRMNpHHHHw3goFMwLKF2GRzQefcXJaXZcjY6yz_7QdbgJ_cA@mail.gmail.com>
In-Reply-To: <CAKrRMNpHHHHw3goFMwLKF2GRzQefcXJaXZcjY6yz_7QdbgJ_cA@mail.gmail.com>
From: Steve <steves.sk@gmail.com>
Date: Wed, 25 Nov 2026 14:06:51 +0100
X-Gm-Features: Aa3M54r_lWogXG09-PblVkKe9cn2TV_icq-ujpClCUoJg9NfndkS8gTtKjmJhi8
Message-ID: <CAAQS9U+76TGukWp+AMWN9CY_tU9kD_3Wzq9k7PzLnUqAd8SuhQ@mail.gmail.com>
Subject: Re: User-initiated recovery for stale index.lock
To: Tanga Joris <tangajoris@gmail.com>
Cc: git@vger.kernel.org, quark.zju@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tanga,

Thanks for the links. Since core.lockfilePid already tracks the PID,
why couldn't a manual recovery command perform that check itself and
remove the lock when explicitly invoked by the user, along with
ensuring that we wait for some reasonable time? Removing the file by
hand doesn't allow users to apply any safety checks.

Thanks,
Steve

st 25. 11. 2026 o 3:05 Tanga Joris <tangajoris@gmail.com> nap=C3=ADsal(a):
>
> Hi Steve,
>
> On Tue, 17 Nov 2026 at 20:51, Steve <steves.sk@gmail.com> wrote:
> > Could Git add a user-invoked command to recover from a stale
> > `index.lock` when no Git process runs anymore? It could wait briefly,
> > then remove the lock and continue, but only if no other Git operation
> > contests it.
>
> Git already has part of this. Since Git 2.54 there is
> core.lockfilePid. With it set, Git writes the PID of the lock holder
> next to the lock (index~pid.lock), and if it can't take the lock, it
> tells you whether that process is still running:
>
>   Lock was held by process 99999, which is no longer running; the lock
>   file appears to be stale
>
> You still remove index.lock yourself, though.
>
> Jun Wu also has a series in 'seen' that adds core.indexLockTimeout,
> so that commands wait a little for the index lock before failing [1].
> That covers your "wait briefly" suggestion.
>
> Removing the lock automatically is tricky. A PID can be
> reused by an unrelated process, and it says nothing when the
> repository is also used from another machine, for example over NFS.
> When the PID file was discussed, Junio was wary even of telling users
> to remove the lock [2].
>
> [1] https://lore.kernel.org/git/20261017073231.3357477-1-quark.zju@gmail.=
com/
> [2] https://lore.kernel.org/git/xmqqbjj4hnkr.fsf@gitster.g/
>
> Thanks,
> Tanga
