Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1533F3B1A4
	for <git@vger.kernel.org>; Wed, 28 May 2025 07:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748416863; cv=none; b=sBthbh2JyjyeM/Xsn+ooYDH7chZHg3JEEb6Ezd5Btq8n8Fn2onlatZvtWzMD4mkXZ+VQiWUAINbHcwT03AxoSgGZdEoF0KHOWsb26TMpm3kt+ANUiiwqzP2g5W5r76gpKAD7s7DMM5bAwRwtHNZ8NjBRV31sHKOctJgk/piKE7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748416863; c=relaxed/simple;
	bh=yXN1onjBGHCKE0ng7UrCunxNVYHHNkd/XOWrEnJFMN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KbLhvbvZaJRD1tGyTF7CMiU21s2YrRI3MeNvDlSPGyqvMm1y0TI9JPxv8Acz819nhxs5rqwgSeGx+eMOxkAheWgomj3isvdRgzgKRiJ0/g9yStnEmj0ca133LQV4hgyO2SfR6jyM178LrOCL0UUllYuFrjvQgCnq10BHRgCtvNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c55d853b54so49060885a.0
        for <git@vger.kernel.org>; Wed, 28 May 2025 00:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748416860; x=1749021660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=svDpcx5J+NnbGr9/bvfeEs4dlcQ0iub3BgvYraT4JpM=;
        b=SFcNi46T+cQiYzxPl1FQd5n3Ykc88Y4PBMNFoO+bkFr3qwMTDmPAFeYb6+/mpi2fJP
         FI0U1ls5dp6F3AWiDwtOibxGGOxo4mMzRTxIOJD3fVKbQ9fRGtDUMps/yt1dUlIa1Dnn
         H1jUgvq+TqHo0cUD46yyt4YhcGXOA9qLpboTasJ51MAepHPMPP66rFnh89Y5ulH6Vl7N
         z8hIKuN1afbU+zhkQjoLRSn6Va0M2arxo/Zj+S01sMzTsCSbmGA8vsuykjcQ0K1Gu5Hx
         IKTKIaFD7m1mWylyB0Mvsk+iDx34FOa7zuXZxH2PRhGnwsIJVyWwRYJEgTsG0O9oM6ZX
         3WPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWATz9dWdmu/pCcJnayvob4U/YmGMxyKSm+op2PR70Oc+vG5UItDFYFeLiM0SaO6JkKeQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6qI4cTbrYruEZeLkfdrJMyA40OuxiwYQ36w36z83LsJN/Eq6z
	zQJnp6JDK4ChHxgisNn6N6FlvEXD8BrbAKowgYrZhC9+Ble+U7TGP4wKrNVde7/H8Q9yqPVibLf
	NJniNr8zoAzVBTCuXNXXqTO/B5bgGhDNs0w==
X-Gm-Gg: ASbGncs7t6tLWUz+GLUhfhQdjab/cVL6PufLuXS5YS9o9Tp2+KgmI1VWPRvcNTSPbVH
	NIzc+XfgUV+wOsAz2uT2oRnE8Yj3mk5I078IZ8XxmHbtfLBk3Las5yWgFGTLbjeUmCH06PqcI7O
	moLaQCRG51F47TWJUx8GL3+HA8CqPCXPE=
X-Google-Smtp-Source: AGHT+IEkAjpBK+0C3xoeXXEBDPkkcExf4sn4LR1xeaNh3/64xDQO3/RfFXbZ7oTe6I9hxUNKhojSnmkLh9TpGnsaBb8=
X-Received: by 2002:a05:6214:5095:b0:6f8:daec:8b7c with SMTP id
 6a1803df08f44-6fa9d32662bmr101415106d6.6.1748416859884; Wed, 28 May 2025
 00:20:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1948.git.git.1745239300668.gitgitgadget@gmail.com> <d8d8c10d-4f4f-4fde-8b91-b979e2931fad@app.fastmail.com>
In-Reply-To: <d8d8c10d-4f4f-4fde-8b91-b979e2931fad@app.fastmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 28 May 2025 03:20:48 -0400
X-Gm-Features: AX0GCFuLQFXrzG-wan17_fyK06RSU2y9AvkTf0IU383efqXKgZP_WFySFdA7910
Message-ID: <CAPig+cTdN=x2GXGW2p_g_k4jgC0eQmjW5zLsWhJm-PP7eMBTiQ@mail.gmail.com>
Subject: Re: [PATCH] doc: sparse-checkout: Fix list markers
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Josh Soref <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	oneee <kimww0306@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 2:58=E2=80=AFAM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
> On Mon, Apr 21, 2025, at 14:41, oneee via GitGitGadget wrote:
> > Changed the list markers from a mix of "(1)" and "(b)" to a
> > consistent numeric format "(1)", "(2)" for clarity and consistency.
>
> Reading the message I thought it was about a larger change to
> consistently use one style over the other.  But you are fixing one
> application of inline lists to use either numeric or alphabetic(?),
> specifically falling on numeric.

I seem to recall that I had a similar reaction when I originally read
the commit message.

> I would write it as:
>
>     doc: sparse-checkout: use consistent inline list style
>
>     Fix this inline list to use a single style, namely numeric, instead o=
f
>     `(1)` followed by `(b)`.

This does make it clearer.

> > +     word "patterns"), and (2) the sparse specification might
>
> I would also use a semicolon to separate `1` and `2`.  I think this is
> the correct style for any list introduced by a colon:
>
>     see here: (1) ...; (2) ...; and (5) ...
>
> Because then you can use commas freely inside each point.

I'd like to push back on this suggestion, at least in the context of
this particular patch, the purpose of which is to fix an actual
problem in the documentation. The sort of improvement you suggest
probably ought to be done as a separate patch, but let's not make it
seem as if we are heaping extra work on the patch submitter; it's more
important to get the fix itself landed.

As such, the patch itself looks obviously correct and is a definite
improvement as-is. It's not clear why it didn't get picked up; perhaps
it just fell through the cracks.
