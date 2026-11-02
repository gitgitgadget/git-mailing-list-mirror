Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793617850;
	b=Vk7TpPgRXzdNvqSW+jsTZWKJ7BYmXNS6vBS277o8D73ybh+PYWrrtJpocU7WN686jg3z
	 S1ImRBWlmuOItlGbq7wA3LGYm6k/P9liNq/L13vz6A5+WUHESLkbf5U7z+x4tQSJkt3tx
	 mcP6dxaojZS2d0ViBUDewSrOojZ+xNb/2u81wPP4E3wn9C+ub9QXLQB1Cgtz8yN/jdraZ
	 63X1ID7aaQO4lmdqtrJmgBUWTF7fsTsr4krW/uKxsdJilNHtz1GuezDfztWo1wWquQOnx
	 y8yzyKLp74DP3wHaC2zg/AfRjR9e4RfgNDPAnTEMFYLio48ZA2ytXn6kfZ0aA3DAm/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793617850;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=nvO9HwJiEAzmmmNXiKcirib3ZvU95qmAdDhRTSlckPY=;
	b=xEkKIFTbOMydoZBeKQsGaUsW2yKjB5Y0Qp4vSsis/+MZS/v0zk1aOTTcRVrYNHeQvRCf
	 CpoeomHLRXADnbu9OX1PDQTtb8wgryiLPBqMV0Ieho5bVt+LSVFzZrUdDSq/uMLgQJG5O
	 ipW4puRjZ/MKV+HGsRlAh41RMvQVvyb/8nrwouFkPWNNvK4XDUkvMberJONMCtdHWDxQy
	 /eM6cRfbXqq1jlIpzWZAZAJ9b06ksswJ680gdgRsPQ2DOX6+ZpTNBsnVdbb2ZTdvZf+Ye
	 q+qP/RUq1ATWdERxTYnMTL8qXXdfmAyurmAz0NrhDIADdPcF2JrUj8rDSRGsKVyJyBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qjy8pMkA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE860606A329
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 11:10:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE860606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qjy8pMkA
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b0e21048f8so22658807b3.0
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 03:10:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793617849; cv=none;
        d=google.com; s=arc-20260327;
        b=Ece0X5NyfMjYTLZbBrtTFIYhj3MuXOs11UbGiqMU+bIB9PUlOH3JE/LwX6wGZKAuwO
         Rq5MReQR35xya2au/yGDA2sJdPUpkWNZ3nlqHs2k4CeZoMkldk9Cqr8gSMQXA1vIZCyO
         uHbU1H1OT//ZLueC/e0ApS0Qu5RLgVRT4ksJTSQVVPHBNSQK0OYfDKFY29S6yXe0m5I/
         vabu+h9MzqtpEo354gSMcr3ui4bNt31rNcDeXXLNe5kCPHXuFrfa0OfXWuGI5ouX9iML
         J56sSgFfXMpcuNCEjs0U0Xnzs8kobWZ5pe//zGFZfnRVH0Lnl3UPkN6mDwPSXH/W2bGz
         eoSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nvO9HwJiEAzmmmNXiKcirib3ZvU95qmAdDhRTSlckPY=;
        fh=hIzMqH9vtF6hTCMPH1CwC4iasS4kLBtDt9YK+UGWA84=;
        b=dyg4U3hHGeStuhTyR1AuAy1tYBHnepR90bgYDjV+H2X0pwWWo2bL/8HbrllvZwNjIJ
         KLE3u9bPuUV6L5XINyioajR5XJDXkXDHz0vD3DIJdJ0Bkx3vHDeOpguzB88ldW1ss+BX
         PWQm/k7+deiJkQOYPte719CIrzCSD4+o9YKvOHthWARXqOah3WVAmQ7mb3Ueiqhcn42b
         iIEOJQC4WTaCIAQG7rV+sTA5TDml4ZEBXG18YCcDmTsHsyzzyqO5+fNczMlGtvya7Kgx
         6xqitMhASXg+xt4ggCnwvQsSsjM5pGm10WVm8JEeeD5IpWeE1wyrRjoePnoGyJIMtQkM
         GRNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793617849; x=1794222649; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nvO9HwJiEAzmmmNXiKcirib3ZvU95qmAdDhRTSlckPY=;
        b=qjy8pMkAP4/0utT9j7ZybAyobVYWXIs8xjxWDtjg8EfsU8V0cLnpFFURNtMK5T9Fmq
         GSJObZsM9RzEhPPAUAdoHEr6mNhzGmCUq3A+VVhPcQEX5DKecrsPkF0MBbT4y7uLZkJv
         VDCQ3g9+ZElbo9SYAqw62YdGDRWCLdHRrDi1BFvGMNZcbb3jsIg2esooNXxa93P1HLQ1
         ya7Sg/nPa70LSxAaXMlgnwm2hI+5Xyg+tFBP6hXb+prQY+U1/yD3DC8SlrosOA9Cpgjp
         QqXzgSWaonig9HxC7DryCDNVv/DLhf91SIXkLGhLXdd854o/q0EYHGTxK/sJpgPDhaIK
         OZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793617849; x=1794222649;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nvO9HwJiEAzmmmNXiKcirib3ZvU95qmAdDhRTSlckPY=;
        b=Ifn1t57PoiRTZUNSWEiK7PvESaGC3MRjDGyIBl/sYTZWTgBdKYRwv2UxGCYDRA/6mR
         8lp4iCZhlUAVhxwde5sGZNKRkeJilAcuVXkLOHFoBmgzp7YL4llqlAIk5nVks7mLULH2
         ODe8LeSJoWUcLJcM66IHU2sGfwaJO4G4Sz1w3S2CMT96DdIfqqhVNxdE8UPH4aWuvj4n
         PMzie7k/OUFXZTnn29ghwoD9imY1gwn8KvBAhBZ/CbxIc7kZwvdyk1IE6XbpdgJuRo55
         tEhic1DCty42fTrQjsbIRHWyq6Z4Oze4jxA9ZFc4XBCahkvnLK8gDbyaWSI8VHIfPGy+
         u0TA==
X-Gm-Message-State: APuU4Z+MtGKU8dxPFZSJAZsvf+IDvNAG9f0Vxc0Fo2gH/2t/5310qfub
	4OJySvQ9SVwIR1dlbJ4lkmcGfwKKd6F+bEZqZoxNoCBcFlN91+hTgH7TFkiEc/KwLomhCURw1f+
	C1MhXQJXiCks5vrUHVZyotzvUvtB4+7w=
X-Gm-Gg: AYBFou1z4tuxEq/uTof4yuN3LUWC5egzsdbzoATwJlyVY+qen7zbW3dkLzkKwR56oY9
	I2a+l5/ZqCzqCryCUCxqI19IPnMIlT26X31SzxmsY1e3M4o6nv7MI8yY4xX4iVHNDYqmeqCq/Am
	49+IiBdhAVZmvlZm2B/PhBDbFSoghkQehHF6T5FKcHIgLJhXKtyPcJbr5IdxOM1+l/8p3RBBpRZ
	FARUFyYwD8ylkicR4Q/w5zS44HPwOLhmhGwRkESxwcT/ZObVa5dJanXG7CD+V2+0FXguVGWQ/8k
	Jr7npq0UbLDNtRcGSvN8eYObyMGOdVwYeDlbq7UYNemVlZdF4O6OMTl/PZk98WLPlXkTPffoH71
	xy3fHtwPD55N+9amfygb3l9WOK+eCbTXOPoiR2T/rWEtbUkGrrRIvia0paDu5wzq4srHtzWUYkR
	cMjMHiCK8CTobj2QoIB85ZfVc7mev/uGiWM8kdJ40v/74gIMu650378+a1tTAYjYnBxx5mBjxGb
	uxGcHj2a6lTtU9TChCKJkwMYXEIAaHtVntw8jnP
X-Received: by 2002:a05:690c:6d84:b0:8b0:b0d1:fc47 with SMTP id
 00721157ae682-8b2b67fb2a4mr60683027b3.60.1793617848817; Mon, 02 Nov 2026
 03:10:48 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031104526.46711-1-okhuomonajayi54@gmail.com> <auhtiZ86trLamccS@pks.im>
In-Reply-To: <auhtiZ86trLamccS@pks.im>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Mon, 2 Nov 2026 12:10:37 +0100
X-Gm-Features: AclHuK-l_ysVGp2AmZALL3d0ipA2A9rTzis-7EzxLyrsWVGCCACuL_T4J8kKUq0
Message-ID: <CAFpMFfCkMNvFWOUsDJgRkhadd=jZX=ByavgsiYiCCuAsxiFNFA@mail.gmail.com>
Subject: Re: [Outreachy PATCH] notes-utils: use the passed repository for
 notes refs
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	usmanakinyemi202@gmail.com, siddharthasthana31@gmail.com, 
	kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 12:01 PM Patrick Steinhardt <ps@pks.im> wrote:
> I don't quite understand patches like this. They are _so_ close to
> getting rid of `USE_THE_REPOSITORY_VARIABLE`, but then they just skip on
> the final change that would make them work. I've already asked about
> this on one of your preceding patches.

Thanks, Patrick. You're right, I should have gone the full way here
after your comment on bundle-uri.

I'll send a v2 that also passes the repository to
init_copy_notes_for_rewrite() and updates its callers, so that
notes-utils.c can drop USE_THE_REPOSITORY_VARIABLE.

> Also, could you maybe reduce the frequency a bit with which you send new
> topics? There's a ton of in-flight patch series by you in this vicinity,
> and it gets a bit overwhelming. May I ask you to maybe batch related
> patches into bigger series (maybe 5-10 commits) so that the reviewer can
> focus on way fewer patch series overall, and then have less series in
> flight at the same point in time?

Sorry about that. I'll stop sending new topics for now, and batch
related conversions into one series from now on.

Thanks,
Okhuomon

On Mon, Nov 2, 2026 at 12:01=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Sat, Oct 31, 2026 at 11:45:26AM +0100, Okhuomon Ajayi wrote:
> > create_notes_commit() and commit_notes() receive a repository,
> > but read and update the notes ref in the_repository.
> >
> > Use the repository they are given.
> >
> > Keep USE_THE_REPOSITORY_VARIABLE because
> > init_copy_notes_for_rewrite() still uses the_repository.
>
> I don't quite understand patches like this. They are _so_ close to
> getting rid of `USE_THE_REPOSITORY_VARIABLE`, but then they just skip on
> the final change that would make them work. I've already asked about
> this on one of your preceding patches.
>
> Also, could you maybe reduce the frequency a bit with which you send new
> topics? There's a ton of in-flight patch series by you in this vicinity,
> and it gets a bit overwhelming. May I ask you to maybe batch related
> patches into bigger series (maybe 5-10 commits) so that the reviewer can
> focus on way fewer patch series overall, and then have less series in
> flight at the same point in time?
>
> Thanks!
>
> Patrick
