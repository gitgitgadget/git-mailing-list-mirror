Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10E93AB29C
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 12:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781786380; cv=pass; b=qJxtVaqlJlyQPHCulbdxt0ibzcQosiEGPlxIAVU6oNOALhsqoUTkv0w/CF9u4irfX5RDfiZKrwFoMQlS+gIZEbmxAwAnwjmkJtFKHONbKqy0RkwQERstnJ5PUM9Cz4/aIE1Xk8SJCmRkoxV470WPz4WYcLAyQGSiwNAqOyjbHTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781786380; c=relaxed/simple;
	bh=YTM34jvzOKso9pZCo+E6gnfgR666ePSxJ/iXe5q2cl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m0SCC2gXFk3gbPrc4b+w/hK43FAmVxTYgtgzS8n0H91fh1QAhkzPNRQb1iq3qvf106EH6ZXNsQGXwGTy24mUPExk3wPIyTqZZnsJL7HtIiYNWosp2ZmsMggsND2CcPBNzKy3LByVM1Pzr7Ia4mNa5lJCTUdUvIixi5m8lhPGj5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpEpZCWa; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpEpZCWa"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c07d76ffd0fso47173766b.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2026 05:39:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781786377; cv=none;
        d=google.com; s=arc-20240605;
        b=OuDKS9f4EVt2npccaCK2Z5LxwwbEFZPGOivhAdi1oZg9PqbnIcPgVlmAOKLVSUhpsp
         ImlPTTCbvnVfSzJEkmD/bXgOayk04dF82T0pRY+bv887mMB7xqij9XMtN40b7y/UxnI3
         UMXUN3h7ArWTb0OMEPqIDWF++b5p7um1G1dBekpu9fKZRak1J8OQLJtPgGg35pb7pLPR
         e5Z4B858KGkOHTTUIAFq5hZ/yDRZgk99RVLEipRi/HAWaT+Dh4wVPQZ8oWUgjFd0x4FK
         zdg4GSG6FSugKRkeDYl3eiwE3noZ9XRgNuYAbmk3u6x/ZlXh9epvqNkXCpNalZ0/YMIw
         46Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WKFRGn23JdmXoBBzRZQZZKxxLJ52G5K/EIqWKEa5+VE=;
        fh=PKmQoWv9AfrOA6Yd8Yj7jUpQA4HxPWHwiMIuMHDbXsY=;
        b=N/P8Dl73vrl9K6lBUX66o3Wpg7oPqIScP5CAEpWvkY87MUYnzJJ8ANQxD4yeiwicxX
         DAF6euDHo3eY+5qXsnvr09YBlKlj3zjLUN+cVCqtxd93SgB1yIKP6s5w45GjR2oHTlAc
         rN1gbYcldJI2m3kRpoatZ+aLfyTVd8mQup+D0B8EwJ10WqHMdfeL5lxEuvtuXK1p2l5A
         1sg0F6iw3diO4HrRT1QcS0M/pYZmev1SIktjnUSSx9MRYtBuR8yzAb72+BDafUcNpLD7
         U6oIa4xS46a2G40UZFyR9kOygsd7jL7ztIElQLqw7Bk2rpnYee6YqK8jLyj/iDTzjVD3
         gqcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781786377; x=1782391177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKFRGn23JdmXoBBzRZQZZKxxLJ52G5K/EIqWKEa5+VE=;
        b=LpEpZCWaITtHQEr/5E27oOT0k+ggBt4pP3j39M50hQcTVlr0uRPIewEQTU0/7NDS0f
         M1ubMB/c6tWQwZDrInLMZiZDsoTQWrQ8QG+Fz4ovT8e8UU5sVbjJR8Ejb2CcRg04xEnI
         LMHFuh1Cu7u6Z8RO05UPVjM4szhIzUFDxwkDDnkyzXGqDcju5JW3+zP6OrzrSV7lPg0k
         8g70C6XMjmFEaYgx3YKc6TpUHhpOD+Pg7jVd5vZMAGmxhptlg7mjEhqVOfdgaqhmz4j3
         4NNh2aShYjvC94VjD5xuVD3ORIAsIQsNx7N12PYRFs6Iia9lwkilD5dT+1FqJLvanxOm
         3SJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781786377; x=1782391177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WKFRGn23JdmXoBBzRZQZZKxxLJ52G5K/EIqWKEa5+VE=;
        b=hmQf4NFwWrEX3eTLZI1gLMntuJ9zTAE4PJy96PcMZXXplV6CsGMwzn3gxBOV0nc13f
         RgXvmQc1FH3jhvek1FXHsr5DI0v3P3/fQgyCDaRvW06kiU+F5wnugXbbbkdIsZgowylP
         F8mKCJ/t6w+jW4Uu1rCRHH70Gy0BfcY4fhMl4hIRU25z9vPkdxnwUPPJV0RPxOUvKd9a
         hhHKSzpRurR6xlkEwPTq0PtP+768LpjJH278G7TaK15Mx5272SrOgmMssYgntQ8uEM6v
         SkNKWzfKW4fC9NcnInf1d2h/Qd/7nerXuUK4whQiiTGUsKmLv0DpDyFs5jY8cKxW7loZ
         GR/w==
X-Forwarded-Encrypted: i=1; AFNElJ8HRsi9kDSfsoWquNuDAyZjTVg2CTyuGZcrnEx2WIYo3F8AmVIRlDdPM2KFY61ULyxb5lo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx960FMCGK8qKer20QJXxVdaEaLbD52wIilKNCUxkwOYDz5YM+n
	ss/uvLkfm2pXDBSGykkBbmKmPqBKQDNybB2y5ccR55yBMN15/49kGz5IlT2Nhrdba4zrI/IvodX
	cqNAH+hbITgc0HWn5nX61pY2qKgcCa1U=
X-Gm-Gg: AfdE7ckrD+ughmwbKfTxdjUgwnEeSFN34HGO7PI78iGDCqs5ZIN8hXIG8H3E+YRIErt
	IuF53k/xLe1Odv459SjbboALRjf9/YpTV90vEVxsgZ6Js6WKrREEozAv7i2wF5kZT+aSloldp2T
	jhA41hPQW3fOYWnrrloExPqb/g9CRAg1EXCH+blJRZ06jF18O7KrTv7RfIrek81M2o7ICGvqbxx
	thpehiC5dVbAY9LIiP61vxaafCpZBEUqGE9SZfOUFf3d3nB7u2fCszpToxRO3+/ESicCE4j
X-Received: by 2002:a17:907:3d4e:b0:bfb:ced2:2f83 with SMTP id
 a640c23a62f3a-c05d23ba4a2mr453611266b.17.1781786376657; Thu, 18 Jun 2026
 05:39:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2281.v6.git.git.1777847487823.gitgitgadget@gmail.com>
 <20260507201253.41428-1-haraldnordgren@gmail.com> <f23eb128-958f-475f-911b-eac4f6daddff@gmail.com>
In-Reply-To: <f23eb128-958f-475f-911b-eac4f6daddff@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 18 Jun 2026 14:38:59 +0200
X-Gm-Features: AVVi8CcRUqjztfM9VqrWFGVjPrAQGK116BEV062RX9Lt3E8trRV7qic5JHv78MU
Message-ID: <CAHwyqnWU9DaaxkLhzq-8ADBTXshC0zJUFN4amUh3xDgvCqad3Q@mail.gmail.com>
Subject: Re: [PATCH v6] checkout: extend --track with a "fetch" mode to
 refresh start-point
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: gitgitgadget@gmail.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Phillip!

How do you feel now, is it worth it for us to move forward with this
topic or not?


Harald

On Fri, May 8, 2026 at 3:15=E2=80=AFPM Phillip Wood <phillip.wood123@gmail.=
com> wrote:
>
> Hi Harald
>
> On 07/05/2026 21:12, Harald Nordgren wrote:
> > Is this ready to move to next?
>
> I'm not particularly enthusiastic one way or the other about adding
> this, but so long as we only try to fetch when the user explicitly asks
> for it I don't particularly object. However having had a quick scan of
> the implementation I have a few comments
>
> * "--track=3Dinherit,direct" is nonsense and should be rejected
>
> * currently "--track" has "last one wins" behavior so
>    "--track=3Dinherit --track=3Ddirect" behaves like "--track=3Ddirect". =
We
>    should probably keep that so that "--track=3Dfetch --track=3Ddirect"
>    behaves like "--track=3Ddirect", not "--track=3Dfetch,direct"
>
> * if "git fetch" fails and the remote tracking ref already exists then
>    we should print a warning and carry on rather than dying which is more
>    convenient if the user or remote server are offline.
>
> * "git checkout --track=3Dfetch origin/branch" should respect
>    remote.origin.fetch so that we fetch the ref that we're going to
>    checkout. I wonder if we can share this logic with the code that
>    sets the upstream branch.
>
> * "git checkout --track=3Dfetch origin" should only fetch the remote
>    ref that we're going to checkout, not all the refs from origin. i.e.
>    it should read origin/HEAD to work out what to fetch.
>
> Thanks
>
> Phillip
>
