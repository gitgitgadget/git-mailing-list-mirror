Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793614053;
	b=GSNHKm++JBtYFb8K3AWIU070JKxuxB4yxKCT/wK2wkZxzepMjp/9MOfbiUmI8m9SWzaa
	 hCgYqtdq3g8X376t/7dwbChaNyxsIR0DJxAWm+a2uy7emBfl7ABfMsueZCkmQW/5YVBcx
	 oTTPdRXccXA07iynRjEk3mkegqIXpGFK3zPkin5TIndsU8zZGqvubWdzv+33fVwG+Ibb8
	 53vMO6vlzJOnPbhuZliDTOnBxsQJNtBJ6n1C/Cs7b4ThDuBUXvP7sMOiBGLnJF1skXp8i
	 fDseoLZMkLAhR4feFvgD+/DzP5EiavyNalCOP0yDf6wnywZX/I0ANbbw6zjssZcXsbw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614053;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Xr4Qaan9cR/NoxWAze9K9MgJtYouJ/5lzStxh7HfTRI=;
	b=IFMD2Q6kMPJAFS3moVAM/CwjERWTxp0f4pbrQth+jSFXbIz8OcAJ9u9Xe6+oXnREkL/2
	 gI6yy9mwU9tKaTmU86vJLw6dFc6Rt8g8MzPN0AMPgxAnM81fsz1D2qrgGS+7ShhbVErT4
	 jR+N8HPrWsCFwDTpEffcHBRz+TpbkSZG+3a+7AkcMJ6I9xrkJt9g05zCTfjs0HMvygsEk
	 Iz3HOavXZYHO5njOW4KyVDUs4zvYCf7k5iiRNRY2874zogtNsL/38fDTHVX7zC4XDGf65
	 NLLxDgKjl2IG7IpA8GQnVHLJwi+s/MpTZxcdY8f6yx5ATvA93H0x6HgtT0eeqmwDy5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eRd8x1DL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2F6606A329
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 10:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D2F6606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eRd8x1DL
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b4bd3d98bfso3321474a12.1
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 02:07:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793614052; cv=none;
        d=google.com; s=arc-20260327;
        b=Db+VaE/SUNjCwrMyffGuPyYmQjN9zKIAUfinuY0FenQk/Bv4ap3UiX75zyQPE5J+rJ
         sSatnyJQKv62bCunbNnsjy2GifUzJEnvmkcMiPmPj4NPKO7yeXfI3IN+glDAIc8EqNE6
         aHFsC9mRAmzTR+hLW1bGQRjrfAqduTd6w5dgYWkdScRXqrtxbQmZ6c+bKws/+hdXEWwC
         GhfWZuYX+nYDzhBAEAGSXnDggeLawH0SMtyXD+le+lVH9vb+akuK0XbvIChFmI1JvY+M
         UJbPdvOL3m2FOK/f3y0WQLfjZwE61zk0AY8Eae9sovO35Og+lHIVE9s5ZeboaYW1GFcz
         k5cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Xr4Qaan9cR/NoxWAze9K9MgJtYouJ/5lzStxh7HfTRI=;
        fh=p1FViMbzb6cpqRqwcan55kTWNDIZq+oSedwZ7qsgf0I=;
        b=N7Q04CHBRB/riJrHrt1PCoZofGHEBMqJhA721wDiICQChh9+GXe4WgCKqngdkCBgQh
         FVkpzN/aWK2RpSCoeevAaoMNppLL5Q0O5Q3Y8af9h9PE+WNMEQh1bOm86mPnTD1Ju7uO
         YaFuNYYW5FGiVwqhJRGP3r6b828MzLsshYeo1k01WA+JR87h/NZYFxEEaPXZe1w/dLOw
         pRw5u1j9xtumqF9vZfZ19uqgD3/Mu6Zq17OLM3EvwUsl3FjGls35rNi6KbEB+JVUo53e
         es6nLzXWsvgvV4knFUJEUTMQyi+NntogvobknIW92HzFMqn2X9ICuzNnQZ50LuwzZCgW
         h8NA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793614052; x=1794218852; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Xr4Qaan9cR/NoxWAze9K9MgJtYouJ/5lzStxh7HfTRI=;
        b=eRd8x1DLBrIBlZSX4Xylkfez984Vo1BzP/6x+i/sERkz/5M1B9UngQWMGfN6awtuVN
         1IvV13mHnoF3z1ipyymNoROKnvq8VS55mRbT2cLelTXK56VqGOVRMsoYn2JVslZcnA3H
         6HCngzJ5i7Iqu3gC4KoF6DI7HsV0UXYGUWDzO2mNKFhvOFjhXB/oENd/AbhW6reLmONd
         knfdR//gpWPcDprR/8wVW7sG884HBWGi8HD8A4Krw8I7B4G9BaBhSGE9SN3C40p9Io1J
         9u42aPs1LPQalpU15yONGWJ+nNfTqqmLE3bKdXetMdBWfCl2gLy1R07CkUhCeUJUQyRD
         v8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793614052; x=1794218852;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xr4Qaan9cR/NoxWAze9K9MgJtYouJ/5lzStxh7HfTRI=;
        b=UNmp5GNRgBGua8EezTKZCUEyowLl2gd/KrdkASsR0sQSL1sEl/zg2vzMYezkx02pXs
         t2OxpjlbEOwZ/DCxXjDj1ms95wGpLpjVQi9O2WLS+l5J1k/XL96EBY/5HjxjSK1ALOzg
         IfL8KXOSs0Kl3S1fh9kfOr77CNkQbEl6v+ZEarbtljljVWe2f1QGmsQ/PmMWvFTE4HQ4
         YxNimHomR03auCP/+HQxi4CHvFtmX777njJu8+kH4BIRJtewF9yaFM9lLaF4a1j5f+sv
         tVqF7Zav0pZXmcoUwV07azJ8kACgUq7wDLIP7i44Jvf/Dp7n2RnU70ec+mqyEgfLa9So
         mcnA==
X-Gm-Message-State: APuU4Z+gqrVxRP8SYiT+25N451Q1H2Dc0rOTp9drPi1F7TmdPkxtvUDG
	kSFTGXwYGbP68AVMeKAYj4OuX4dDnyw4eZ+cKC9dIFxIFrf/tLA7tzk8PEhog7I/ldhRgRJ7dct
	hJ4A7/nQYdz/OMAECAvU5BW9W5xNxRcaRyg==
X-Gm-Gg: AYBFou2GOB6U2gDUGfQBiE8DHv4C9F8dUmpPmBJztR3vygD5mWJdH4Jc/SHNWdbfxlH
	zyK+M8gZoU9+v7b/VxMekhYet9c6dK2Mxy7c4LurVvIWPBSInBzH5ImWhPnFPUZ6ckHdI+uO3b/
	EWn7jrq48xF6RAQB9zEQogzGPjHvIT/D9CLVzWS+43SOB2VKkAOd9vA5XryX5DNLDivAOqCseO0
	++4lPAsRSmJ9n6vH3wxz+Znl5L0DJTMVWbfHdf2YP4fLKYxrGjRvv6pzQX4U0G58r8EsHeFSPhf
	sn36eRv0KMgCPqaTnXJGdhm87dzbVGhB5nT7kEbtdIN4TI/v7ODVRbdgXp51yxmuSTL7QVLCw6S
	jIcJB4RttTz0cu3tvY0JWh9lsw4QUW8UNsSBI
X-Received: by 2002:a05:6402:2423:b0:6b2:2331:3ea9 with SMTP id
 4fb4d7f45d1cf-6b4d4d6e333mr6400501a12.17.1793614051489; Mon, 02 Nov 2026
 02:07:31 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2413.git.git.1789898013916.gitgitgadget@gmail.com>
 <pull.2413.v3.git.git.1790189759802.gitgitgadget@gmail.com> <xmqqtslzlhbm.fsf@gitster.g>
In-Reply-To: <xmqqtslzlhbm.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 2 Nov 2026 11:06:53 +0100
X-Gm-Features: AclHuK_0UjScJBxx7bbC8mT0lz0l_D8TTdIb_BUI_sN6B3vAeUQEeesLPzeZ70g
Message-ID: <CAHwyqnVzsvsGXzVj4P=rXJJTvfeQt0D39Aj7R1PTyQVkJbm4DA@mail.gmail.com>
Subject: Re: [PATCH v3] object-name: explain why <rev>~N fails in a shallow clone
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 10:21=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Harald Nordgren <haraldnordgren@gmail.com>
> >
> > Asking for a commit's ancestor with <rev>~N in a shallow clone that
> > does not have N commits of history locally fails with a bare "is not
> > a commit" error, with no indication that the repository being shallow
> > is the reason, or what to do about it.
> > ...
> >     Changes in v3:
> >
> >      * Drop the git log -<n>/--since extension entirely, per feedback t=
hat
> >        last commit shown is an unreliable signal for a shallow boundary=
.
> >      * Fix a bug for chained <rev>^^^ where it would print the hint twi=
ce.
>
> We unfortunately haven't seen many folks interested in this change.
> Is anybody interested in reviewing the patch to give it a push?
>
> Unless we see some volunteers to give it a review in a few weeks, I
> will discard the topic out of my tree, as 'seen' has been crowded
> with topics that have been collecting dust without getting many
> reviews.

Is it possible that maybe the review process needs to change if too
many things are getting stuck? Rather than discarding acceptable work.


Harald
