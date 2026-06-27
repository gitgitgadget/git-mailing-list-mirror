Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8966F37EFE2
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 21:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782594435; cv=pass; b=n6NBrZBTEEvG5nfHjNPgPeV6nMIhmRSuDpisQxx3YR6Go1b5G5PcfS53FrCiZL4VSMUlb5aza6zqwlkQ9Om4XNrW4JWxtgYPORx6m8grwug1/wjwLHNqlvWoSX1/LljFYYzTukp7mra+04Dc83ZPhArst1s7IRZ0kHwd0t/6vWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782594435; c=relaxed/simple;
	bh=lGyKtNVXBT2DXOvS3+lwaYUac6npsWbiIrTs9CsdMmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1vql+vAb1aPy3zffDJACgjCS6X9s1Dpr9KxgssMzdOQdwlwJHyivtF14abDzKAT01HPc2G+QxsW5VqoOLITdgNs+UAgh6SFx/DjgEQ38jMnrvxTiBvPzFTya+u4oHIt/bq8G6RsRVXkZZcUzEl33AeMVMnCRDoFgTneg/Sea+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CdGJ4t6z; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdGJ4t6z"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7fe36f1be74so25706677b3.2
        for <git@vger.kernel.org>; Sat, 27 Jun 2026 14:07:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782594429; cv=none;
        d=google.com; s=arc-20260327;
        b=JNYESjCwvv5/xzu85LY6uT1Kv4uT0A5qiF3XK/T8CQC5HwmSUwJSpBGeKI6GoishGA
         IObau3nAVn4tae5i8bDjUTWNYkzuoaTYUc9GmXp23SeQSjZcthdsoEgntDJKFHMD+4s4
         dDc3NF2bbVkz6xiF0sg92JlcdUReVZphT5ilf0N3gfm19Fbpa/HZ54LJnipHYAPIa8vQ
         dFiv05GW9Zta6S7TdzPCZO8+QKq75I4ZD+B6TU+K3vvTBwaJzxUvyPgCzJGwEZMyBJ5f
         xbVCaXLHUEC8Unm3d2qjKMhvc9kh3McZOYDSX82wxwXwK3FZnlzPSlVvsgHT23D/sr8+
         Kg9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IoIPof4gcRFb20qvfaMzh7fIOLS3bsGPSmhH9gi7090=;
        fh=II1xNaWpsbGGoje1lWhXs73nMC4GzAl4tRfC7+O7yrw=;
        b=YUo5+77pNwkHSo9OZ79tUmRs9r3NAnPBt9OpgxmPqvbs4rlUSIW7e7mbKNmdwMZoRP
         9V/Xw/QdGqhz6VDNXre29iXPv9LY5f/+qUByz4CmIwR5Jc9BPbY0AR0dSyG/eoo6fnPD
         zEWbUxtshWeVcxRgfmHUN/pb0KYtvqXPbMvJ9VAMEXuwUcjs8UYLQtLu5vJfbnpoGK+N
         bK7j5Q0MJiWz0TOVyMk8IhGmG3m9ogHW++LaLG3Af+RzVr3k/AnLr0nBkgq98p5l0tQq
         vDyHq0R4+hjXDpZB4BuZ8uA67hmSRK0JjdFmYvWWwIlbbzi8IVk+XR+8VPslkXzUf90F
         iHJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782594429; x=1783199229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IoIPof4gcRFb20qvfaMzh7fIOLS3bsGPSmhH9gi7090=;
        b=CdGJ4t6zexrZRoN9xp6vVJ+IBO7Mq7EiWWdpQlsD9rD4SSRh0h1g0eleNsg5qIGAXS
         8ztytCOpnJO+06fvSjjFs2qdf44yMxxBXENze4JRIf94hLbjdvsFX0pTqXEGDN4914js
         u7Lkmm9TZe6kqpkhDfbRfixQV28Bu7AgGYzOGQCWRdP5M3jfcUvcieo+l7I4ltZp3dAK
         vGsh/TCZbeBA3vk1nxNIrfTtLquGdLWllwEokOedM3mBZKlXCHrwSBXRfyZVs3rMoPmc
         ljRtnUOKOF2XQdQw/BaMjBuivOUvm8j9mXfx9MQvlKdN4XPRp9Wg4QJfIRJgKXTiO7yJ
         XLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782594429; x=1783199229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IoIPof4gcRFb20qvfaMzh7fIOLS3bsGPSmhH9gi7090=;
        b=V0GkqVgWhEJ+lH5t26FXQmkr+hpZXElFku1JRfQptT373YbrXO2gYqOsk1NdbXcq+V
         4UtttiLEWRdS6GyrbgpG2/9TRjQrSEIEWZ7Et0LSVJpXJMwFw22L3bCZdA4mr6VWGjpe
         AEme9FO5pfICKI5elE8rZVuh8LLQbvQLilJJfyVLIbJTLd5+Y8u1EvD4B6+o7hRVQVDW
         0Hax4pikZrV9ijodcwBX0jybpvz/08mWeq6aqUGFZkknUtO3xOp27u8/X61VJ7DF4QIL
         xBDRwfwkjxmfiJibSPVtsG1W7mUKllYz2I/yp9UZ/LjbdUWfz7ESYUeZHqigxlfFNgfY
         g1qQ==
X-Gm-Message-State: AOJu0YykTduQZiZ3S2V1CdloRCnTBidpd6g/FflF3q7lZrjeZKTK+G0/
	CYpVi3Ob6O+mZod2N+swNZZ1s6YPWPDMwyttLbTkw+jx4BsA+/Wt1q3ic0paOeqjATxpIs1lsiA
	Fzq/qnYKsOsiExsdrZpsasHwQE+Dojn8=
X-Gm-Gg: AfdE7cl8G9sG/7dv6xauRTW2ARElA2QjtKrwUO0dvN3ZfTThhlCRJO9gxsEJm54SUCT
	yTev4jSdOezif5Q2ZT3Hc+Dxs3jH26Qub8t3tDmfrPaCMBfPOYjBkU3w60OkdixFNuo1CyO35Nm
	HEZIQdbp97PddsA7dWHMGGWPidPqDlaKIrEj9fOaFeutXss+T/M+xG3QDdTIM8YHjtMDg7pKrse
	i5B2mB4BUIZZNPF4LFlXkw9cLz7sXF4LWbhKenzPwLO4zNDY+dY8JlYMtwIt0WA6wX6yUeGHzhV
	LQWV17JCCAdq+R6ODm+vwkPY9tLyOaPB7yRgOj5zfow3f2v+8POgSX7xXR/kLLX4rGRfEupe7Fb
	YCmtKUinBMWy/w8iQ23bO1hNI4kQ4VjfMV+ve1oBgSHfU2lo1p6AIFi7KGC8JKLbR/rXJKg==
X-Received: by 2002:a05:690c:6e05:b0:80d:964f:890c with SMTP id
 00721157ae682-80d964f9080mr25391957b3.19.1782594429412; Sat, 27 Jun 2026
 14:07:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
 <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
 <20260625-ps-eric-work-rebase-v14-5-09f7ffe21a53@gmail.com> <CAOLa=ZScS3Gmm5BAgJF69phpaDXGnP_j9jx+bMhn_tfF65RXEg@mail.gmail.com>
In-Reply-To: <CAOLa=ZScS3Gmm5BAgJF69phpaDXGnP_j9jx+bMhn_tfF65RXEg@mail.gmail.com>
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Sat, 27 Jun 2026 23:06:58 +0200
X-Gm-Features: AVVi8Cf32qtbW1Q-CKIfgPJHGnUgnlu0v4Z12Jlnxm_9c1c_txXSoC2VeYmu1TQ
Message-ID: <CAN5EUNR2Sv_JtSwQ66m1CwYxgDs4Zb_RxpkpnDTWevPVAOm4xA@mail.gmail.com>
Subject: Re: [PATCH GSoC v14 05/13] fetch-pack: prepare function to be moved
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, chandrapratap3519@gmail.com, chriscool@tuxfamily.org, 
	eric.peijian@gmail.com, gitster@pobox.com, jltobler@gmail.com, peff@peff.net, 
	toon@iotcl.com, Jonathan Tan <jonathantanmy@google.com>, 
	Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El vie, 26 jun 2026 a las 18:54, Karthik Nayak
(<karthik.188@gmail.com>) escribi=C3=B3:
>
> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>
> The subject doesn't really give much insight into what the patch does.
> Perhaps something like:
>
>     fetch-pack: use repo config in `write_fetch_command_and_capabilities(=
)`
>     fetch-pack: drop static variable use in
> `write_fetch_command_and_capabilities()`
>
> > `write_fetch_command_and_capabilities()` will be refactored and moved i=
n
> > subsequent commits where it will become a more general-purpose function=
,
> > making it more accessible to additional commands in the future.
> >
> > To move `write_fetch_command_and_capabilities()` to `connect.c`, we
> > previously need to adjust how `advertise_sid` is managed. Currently in
>
> I don't think 'previously' makes sense here.
>
> > `fetch_pack.c`, `advertise_sid` is a static variable, modified using
> > `repo_config_get_bool()`.
> >
>
> Perhaps:
>
>     To move `write_fetch_command_and_capabilities()` to `connect.c`,
>     drop the usage of file static variable `advertise_sid` within the
>     function. Currently, `advertise_sid` is modified...
>
> >
> > Initialize `advertise_sid` at the begining by directly using
> > `repo_config_get_bool()`. This change is safe because:
> >
> > In the original `fetch-pack.c` code, there are only two places that wri=
te
> > `advertise_sid`:
> >
>
> This needs to be modified no? This is from the prev patch, where we
> moved and refactored in the same patch, this no longer is the case.
>
> > 1. In function `do_fetch_pack()`:
> >         if (!server_supports("session_id"))
> >                advertise_sid =3D 0;
> > 2. In function `fetch_pack_config()`:
> >         repo_config_get_bool("transfer.advertisesid", &advertise_sid);
> >
> > About 1, since `do_fetch_pack()` is only relevant for protocol v1, this
> > assignment can be ignored, as `write_fetch_command_and_capabilities()`
> > is only used in v2.
> >
> > About 2, `repo_config_get_bool()` is from `config.h` and it's an
> > out-of-box dependency of `connect.c`, so we can reuse it directly.
> >
> > Helped-by: Jonathan Tan <jonathantanmy@google.com>
> > Helped-by: Christian Couder <chriscool@tuxfamily.org>
> > Signed-off-by: Calvin Wan <calvinwan@google.com>
> > Signed-off-by: Eric Ju <eric.peijian@gmail.com>
> > Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> > ---
> >  fetch-pack.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/fetch-pack.c b/fetch-pack.c
> > index f13951d154..ad07603755 100644
> > --- a/fetch-pack.c
> > +++ b/fetch-pack.c
> > @@ -1380,6 +1380,9 @@ static void write_fetch_command_and_capabilities(=
struct strbuf *req_buf,
> >                                                const struct string_list=
 *server_options)
> >  {
> >       const char *hash_name;
> > +     int advertise_sid;
> > +
> > +     repo_config_get_bool(the_repository, "transfer.advertisesid", &ad=
vertise_sid);
> >
> >       ensure_server_supports_v2("fetch");
> >       packet_buf_write(req_buf, "command=3Dfetch");
> > @@ -1395,7 +1398,7 @@ static void write_fetch_command_and_capabilities(=
struct strbuf *req_buf,
> >       }
> >
> >       if (server_feature_v2("object-format", &hash_name)) {
> > -             int hash_algo =3D hash_algo_by_name(hash_name);
> > +             const unsigned int hash_algo =3D hash_algo_by_name(hash_n=
ame);
> >
>
> Agreed with Chandra, this needs to be assessed.
>
> >               if (hash_algo_by_ptr(the_hash_algo) !=3D hash_algo)
> >                       die(_("mismatched algorithms: client %s; server %=
s"),
> >                           the_hash_algo->name, hash_name);
> >
> > --
> > 2.54.0

I'll reword the commit message with all you and Chandra reviewed.

Thanks for the feedback,
Pablo.
