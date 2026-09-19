Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE2725B08D
	for <git@vger.kernel.org>; Sat, 19 Sep 2026 13:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789825439; cv=pass; b=u+IigcCQXLtP055nwaPk2u7KxZ2TKrpHoQ++R/DzhXUAfwyuic4L8r+5c5je/qgrBm8RXtTLs8CX7Anu1sAAWw6M+f1uZQfD2w2v1a3BloehVW5FHLdoMCkmH1j9TELCHk8ZWnDlT2NCUqP0K0WtRPSluyPjC86OvAaRCuvxIF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789825439; c=relaxed/simple;
	bh=rEUvoKYDr3ttl9w01HdeOyju0wgLxIYMs0iFK0OnP0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HAr+dx27V9dsBadE7GWwLxNoDdL7Nf1piDai7AclgiXjH1voaMq1OI1r9nV60ggqzyWSaj305erx286/Vp6r6C0iEPuEHT61Yc0b33nmrcQWt4J7b59art852H17/9YnsPe1thVqGMjCTPYGBONCHbO8UEMhq4Ca6mBfKnPbSn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUutDY7Z; arc=pass smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUutDY7Z"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-8693af0d7c4so1859247b3a.3
        for <git@vger.kernel.org>; Sat, 19 Sep 2026 06:43:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789825437; cv=none;
        d=google.com; s=arc-20260327;
        b=Hm1Qk6V4bS8BXuBud7rJSHLXIoi3Ru0PRcas/QuCd9r8IgYpG3V1WST8NrXAbhMTjm
         +S6a1A94C1T4cWd/GDjzyHtQcPSsSs+3+wl9989o57kPWppqDbuJfEKAeJIuLUial459
         ZrqhQeJgI4MQ1fxBBUUxkAPnW2Hqhlq0fBiHwW534tlZ5pdXiNMZIfFJ/oARsFeDe0hv
         iUbzPJdY5NE0t7kjFcCqUmTT58yLttUNS2lHvXQX7TZf8Be9V5+jq8AfS52kU++mXg5m
         JJYdRV/1v7tLGjge/ZZOdAtwV9S+CvX8wCJ7DA4slpVg0pQr48hLQxdS/OWiaubexItF
         nFUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qjTNmt7za0XJix7fSaDGft3ipRqNOjIng2kNs4jZDPQ=;
        fh=m7TaPQMiPZzT1+1oMINfQdWD00G0VND1ezOoostBefQ=;
        b=nao5yrsarEa5jY06u0rni39+i9/yINIsqh1XPjZqDQyGzOYFvB+nyt0kMcuA9tB4cJ
         EG038iYa+gPnJR3f4QlVBOVn+ukyhM8l2KIJpKr65UQtYl+zPcf2E8FlVtXCIwflyP0R
         5mSz52fX/tBXToyJ+MN4Yz0XLRHle7DiYNaWe67ORqvlrQK4KAlAcsXRIc/2EMYgW24C
         Knu5yWMYcEn8n++8pODuxoEpYRQLf02PCM9B8HzIyDQr8ICBmNyPeNYY7glSDcX1knBF
         Jf4fXol1wA4vHeiNNKpgPbPkxDw1cdSOiT1dC1vNoeuBhCmA9tuCD+k68HudpTamk8/z
         nrIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789825437; x=1790430237; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qjTNmt7za0XJix7fSaDGft3ipRqNOjIng2kNs4jZDPQ=;
        b=DUutDY7ZtPa90sm0bWHqRgXFjmbW3Yo2CxaWBKqhwQe6GMSzNZOQ2Z3axe0Cpf1dnD
         YQhfzrPjrzj9tEOkWWUEbPkToZ5PTv0W8gPEbDVCqp0pkRPdj8CMcyqjQq4zC++7+Yrs
         cKxmxDoLtfHpWObkOoPd4dx/UoJ4SbPuJ/GWdRZZGuBdLxz+mziLX3FmGWjW/BTfD9w0
         4E5hQ9mb6BMnd1aC4avAfMwPEyUvuB3uVmHt4XlzzUDcU+B7uVyc8/kuQkTZKUt1Jkfo
         JwHSASOzj5h0TRl/j2UHz4d/hAv9UPaw8AVxx0PirO9FcIhYaiOeEhxlzsruc/Smsmdw
         AnMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789825437; x=1790430237;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qjTNmt7za0XJix7fSaDGft3ipRqNOjIng2kNs4jZDPQ=;
        b=snkPws93LR8m8aceWxdTrg+0k6XZGYqZjH7wRIKllnLfRmVQgZynYf2Rj0ll6pS9YF
         86YfJmS+qLsv+7e++vGJKVhGjY9/7Ihq69jkHXJi6K9ZSW8yFqKF1pn40bZ5vTMI1msv
         7zn178odsyVb1/yOtYZyQwNAOtwNG7r0UoOBBKxX60ZRd63jONWd6yVv1OaynNeqnX4n
         p3CJeAxxKU1mKJ/kAHBjJDGDf1Tzv/LbHSbzOsmK8m0YOFgmM6Nx35/OIIA1hVa5IvFa
         jxVh+EL3dIZuAYi3pxdKwFA/A8BEji3j7Cpib4KTcXKSnNG75jVzEAsbONYwNPrGsL5m
         trEg==
X-Forwarded-Encrypted: i=1; AKwUvBwU511V5EguJ3862wuv8RY8JAqEK7hoIjzmn8m0TAF3hrWmkvcLkthvljAp3vmruseYCK8=@vger.kernel.org
X-Gm-Message-State: AFuF++meEO/s3mYjBAo//crdFC2rW5E8O116nzl5Q8LwARpXUEDDXTvY
	/9OnjZETrWZ7UndR8IirpJheyDj3SL+IxTaH/AZcn0Z+Tx6WPPI8I18AsnUn4SyasHKlZsbrFqF
	ZeFl9JeIpgRyPNsm6q1xHgxJmxFkAzKGGSjqNbzkr1A==
X-Gm-Gg: AYBFou0KCMmsBesWqx7qT8trRXuGEg1dD2yrmoWoAy2G1AfFci5d2VaXfAiaVIUDqhN
	m91gaIUYcbcvqP8FllIH9tWFWVz7p/NV7ZHKMv1FTuLFp/h9ffNyLc++qrCJwBPuXUEJSrLZnN1
	dS6Qk3Y8cNjTaFfS709H59aFiTKknqlUdojzwSle0jwyi4tMi2TMr3gFqHzooYEdnRVWnIn5+ug
	Dz7WS20sFA7HcuW1AZKDPhEwqTyaXMG0qN5u25EYQF2fG4fmBKv0SEmPj+FwFHIYfh4P8bwjpMu
	rhqqUL3hE9jjiMK0EuiB9rioQnzzg0vW0csMyz+epj+pIr7cIu2N/k6d4AXgnSlfTo829Rc2NTl
	NzlufByTH6+w7fIY2bnl8gfc8JuFS4M63YPsIpjVdLP3BOU3tDcgvHYbjPExtkz/2GG3EF3K2Bo
	3vBUnOVa8lhwG6sZ8Nvo17Uft5Y/7lYvJ2CrvyEw==
X-Received: by 2002:a05:6a21:387:b0:3dd:a197:cf34 with SMTP id
 adf61e73a8af0-3dda197d87emr3398592637.88.1789825437248; Sat, 19 Sep 2026
 06:43:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP8UFD367UD=AomNVHEBnhY-2DQmqTNRcBX6NW7YZywWgOmxTQ@mail.gmail.com>
 <CAP8UFD0oYnoXgQ84wHbGg3+QhX78Ucn_CXXYOe8uFpReb7X1Ng@mail.gmail.com>
 <CAP8UFD1hAjtPuWL8asZ2LzEMJKHGh2oO73n_tsUSADtEHh9b-g@mail.gmail.com>
 <DLEWITFIKFFK.NSANTRY5XBCB@gmail.com> <1b904e64-e681-4744-b83e-690f3ca94ea1@gmail.com>
 <CAP8UFD3kd=6QHp2oB+t+g-2D8bY-Oe5+_Vk+RJeaCa_xhxGrsA@mail.gmail.com> <fbed7a60-57ab-439b-a550-2d2b76ff24c0@gmail.com>
In-Reply-To: <fbed7a60-57ab-439b-a550-2d2b76ff24c0@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 19 Sep 2026 14:43:45 +0100
X-Gm-Features: AcwNN1Wswjh-KbdlXV533KmGyQ6jv8TwwxaDr47w2L48jE4F2o91E5Cb6gVNL0M
Message-ID: <CAP8UFD2VutDBA54c1e5uiCjFB8v3Y6yS3MTtY2P6sM5+Z9y7PA@mail.gmail.com>
Subject: Re: Participating in Outreachy's December 2026 cohort
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, git <git@vger.kernel.org>, 
	Git at SFC <git@sfconservancy.org>, Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	Tian Yuchen <cat@malon.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 1:07=E2=80=AFPM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:

> Just for clarity, this is tentative mentor allocation. We may need to
> shuffle it a little bit based on the applications we receive. We'll see
> how it goes.

Yeah, let's see later how it goes.

> >> Given that we already have enough mentors for both the projects and I
> >> have some bandwidth, I wonder if it would make sense to also propose t=
he
> >> projects that we proposed for GSoC but were not actually taken up by
> >> anyone. The following are the projects:
> >>
> >>     - Implement promisor remote fetch ordering
> >
> > I think it's indeed a good idea to propose this project, even if it
> > seems more difficult than the other projects we already propose.
> >
>
> Thank you, Christian! I have proposed the project. Kindly check and
> approve it at your convenience. We have until Oct. 5, 2026 at 4pm UTC to
> approve it.

I have just approved it. Thanks again for proposing it.

> If anyone is willing to co-mentor it, please chime in.

Sure, it would be nice if we could get another co-mentor.

> I will mentor it but may need some help / guidance from you as you have
> a more experience with this area of the code. I hope that's fine.

Yeah, I will definitely help, and I can probably even co-mentor, but
let's see if someone else is interested first.
