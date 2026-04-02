Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26882E1F06
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 06:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775111713; cv=pass; b=ULGuf7zdHP/hmmGlDqiG+ZACf4szuATzNp4ND5ceYWzrHq3ajNoiOrFuQ+U5gzgvIhIoN5zQZ+XEKKLNw8Yykqu1d6dBkuqpd9R7tDCBbdqcZBnEoS0KthvCxqHCsvToIx6pIL6EgIo1NffWARHL2PnokWERI+qeHnl4yOr9/HY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775111713; c=relaxed/simple;
	bh=RqwIZiHr90SpjF/YWZhU0hXvF7gic3TY7MeqtTTXWik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DMPCIy7Jg7WwjYKndN2RVP3sZkL+NXQE84JHiSHHnzbWLsqClz4xUvY3vHJR35k3HKiujuyyct/Y2iFYbFHh035TOy9giyoz2OcSH67/A0pXXEfmrz6aI5gN2pdU+WdYacvruqVJseOXeAj4exkboASiUdgxRi7+Md/lvbCZc1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3MuJ1IP; arc=pass smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3MuJ1IP"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso533518eec.1
        for <git@vger.kernel.org>; Wed, 01 Apr 2026 23:35:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775111711; cv=none;
        d=google.com; s=arc-20240605;
        b=gF6VmcjBwzFt8eVI4GdEPjmGJw846ImyCHYhVjwfnSwQ3tH6HlLm2VAFL0yngMz1vo
         9a+S1wJHUwwYDIOoSVWg/WVRtOqUKMgfGRv4nfqvzFdmVoQF1modrHk4NMeMSqGrvrTe
         HUwmbeFlqFPruMgTL1O+OgXUB1h6BI5ESjwyuv1nLuSgst9ef0XfrFn/MmpxaENKocg5
         YTlfxLFQcWOUxe6bBP6O+A3uL7bGmUSkkkRszIvYkIPBQeBoevQhHXx1BSPmcwrZsdMQ
         Kd+36qPabeAVsgveGIzy7S8A1p8YCwuGPKI25dUuf3klAsnfy+NzQAz6/YyouZV4dE7z
         nVmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rF4TqPGtPHL5uBx0pU5hzph+7sjedLqjXg8dsCTOPxA=;
        fh=aY+RodnsZwaVQgtho/D2F/LrJl8TcIGRGapA9S/T9w8=;
        b=BQjggZV7eMqvzIIZS1XyisKTjHBhK8BkTH5saljYt9BLIY8y6FG9HIpiSKMSG5MtYa
         WuQolfMDbkxsJb3/lv6NeuEzbqLTcUJBM3bKgsfh0vYVMa1Waxt87hNHOf2aU4jXsd63
         7a/Q8CzNVIaMJc1yGvfYchwTrbvVIytG2q1s/Ncy1wfAd403BMT0rsvBmLulqoeRVubv
         N9HmeueOsktl50Udk1YinkRPDYyepPxo7W8qHqTjdULgLsUPxAU5+gSRfFNKWmLlnm4h
         FiIc6hr+vi7gSeQc0V4BeQu04nAiWo/kpJ9t+9MY25ntFOPjk5xKFLISy3TXvxEWSvlj
         UhAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775111711; x=1775716511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rF4TqPGtPHL5uBx0pU5hzph+7sjedLqjXg8dsCTOPxA=;
        b=a3MuJ1IPVclFY5+7+ihIW8KNW/LKlQwkDD5FoXkVxbY+iW3q+V/VICE3N/cW9g2e7w
         4AI0fBPmAapbrUpxnpaZqZHYL+5oeq1Lu1qR6Vm5YGmJ1wH2ODDrB2G0ytdViX+wVTDB
         IoCuk1akNEDsqmIsxtD4uDDL6EsYOZvy/6OG6nDhOgoLEHOOSJjkwy67hKXYrSTfcYh3
         nnxzvRREA62gQxRIIylFG7v4LKHf8a4LLqYy2B4UFbJl+6YfUKq4uLlY3c2QCuN9LLfz
         rhPk+hkFs6Ju48fm7tuI7l/gVIEO/eJOcVg4EgPSfOk00vsDiuzrh6BsegNzKx1H3dX4
         m9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775111711; x=1775716511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rF4TqPGtPHL5uBx0pU5hzph+7sjedLqjXg8dsCTOPxA=;
        b=ayk4pJP/DZpc6cbhfVoL9H4FavQ8fhp8RgPdt/+dT5DoL+yeWMcIhBxDza2iVbRb//
         IO5zayGKovyhoI3yxGUWcTzQFgNhhxIB9sIRxbN2JJH7A9iX6DPvjzcA04j+i7Jkhnu2
         ThPXkXM7nM9Tg+enpu2Yp7+iT/Eg3vabNlx3eLWwWVftfO2yeaRZIHoR1aMLCgvdOYYG
         RJoMZRhVdny3b8l+juQALTBCbhOBMtXb8P5NOs4Lfn5k73teiYjvZEzmOo7VLp/9XIry
         wvP34EbhJYaNYql8v7xKuKZ8FOO9/uUiPzF9/RF4iRjGLQESRQnSpB5ZZADyNZxgGSOZ
         iD+w==
X-Gm-Message-State: AOJu0YxAjrxsKpqhG2gWJxKSsB/7BGXdHF0XkdNxt5ovh5j2ro9iHz9y
	v+rHIMES0tP9OwNDSRPUJdTRpDVYBLrJIhmr3HqXTAJYBKF4GF2kJx1Q7qUByQayaFXncohW+Xe
	hKxdB7aeH9OYf/q+N/JRQ1Z54RRYx47M=
X-Gm-Gg: ATEYQzzegd8Xf7jGjmhc7wQ10f+PL4jiuNhJYTNbGgKEo17dA3Lmba9ftNflIqR39s0
	Sbym0nixcr8M7aXlOjrwYxp1kVv6iJE/hwHZ6s7xWjmUV+s7JhS5Fxog288eCsT7Sgx3Xghr0Nb
	Ed9SGXAyenhLbhdEXXNSwQwpqaNW/jmBhtv306GKefxEtJjA+orhmd8uzolg4cHRBf+Oi2YhWLB
	VjaU+eFFQ2g3b8Jupkh+UroDTFJZWfiWO+Ho+b5t2tiQ0ZWRukMBcgPEwN/D594zjFOavjfd81G
	ahMyYcqh9VaIwZT6lDXpcMLmyK2RYpr1qwbLPqef63EWL9XbpH64gBTfa9hIQti2RWrt
X-Received: by 2002:a05:7022:ea30:b0:12a:713b:8953 with SMTP id
 a92af1059eb24-12be64267b4mr3903621c88.12.1775111710976; Wed, 01 Apr 2026
 23:35:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323080520.887550-1-christian.couder@gmail.com>
 <20260323080520.887550-2-christian.couder@gmail.com> <acUklLd07f04wOYi@pks.im>
In-Reply-To: <acUklLd07f04wOYi@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 2 Apr 2026 08:34:59 +0200
X-Gm-Features: AQROBzAF2XfEJMXwznnzl7jBgb-sxC0hpOdm-EzoRo4U00m34pLQ4bf_v_e_A5Q
Message-ID: <CAP8UFD1C-+0Nwpj-2ZVvpHVj91ogj3s8dHKz_6MoHR0VJeSXxQ@mail.gmail.com>
Subject: Re: [PATCH 01/16] promisor-remote: try accepted remotes before others
 in get_direct()
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 1:20=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:

> > To better reflect the agreement between client and server, let's make
> > promisor_remote_get_direct() try the accepted promisor remotes before
> > the non-accepted ones.
>
> Interesting, and it feels sensible to me. Is it documented anywhere that
> the ordering of announced remotes is actually important?

I have documented it in the next version of this patch (which I will
send soon) by adding the following to
"Documentation/gitprotocol-v2.adoc":

"The promisor remotes that the client accepted will be tried before the
other configured promisor remotes when the client will attempt to
fetch missing objects."

> > Ensuring that accepted remotes are preferred will be even more
> > important if in the future a mechanism is developed to allow the
> > client to auto-configure remotes that the server advertises. This will
> > in particular avoid fetching from the server (which is already
> > configured as a promisor remote) before trying the auto-configured
> > remotes, as these new remotes would likely appear at the end of the
> > config file, and as the server might not appear in the
> > `extensions.partialClone` config variable.
>
> Not quite sure I correctly understand this paragraph. Is the idea that
> in the future, we might not even store announced promisors in the config
> at all but simply use whatever the server announces on any given fetch?

Currently the promisor remotes are fetched from in the same order as
their order in the config file, except that a remote whose name
appears in the `extensions.partialClone` config variable is fetched
from last.

The idea is that with `promisor.acceptFromServerUrl` it will be
possible to store accepted promisors in the config, but the resulting
config order will not be the best for fetching. Especially if the main
remote doesn't appear in the `extensions.partialClone` config variable
it will likely be tried before the accepted promisors which we do not
want.

So fetching first from the accepted promisors will also make things
work better when `promisor.acceptFromServerUrl` will be implemented.

> > diff --git a/promisor-remote.c b/promisor-remote.c
> > index 96fa215b06..3f8aeee787 100644
> > --- a/promisor-remote.c
> > +++ b/promisor-remote.c
> > @@ -268,11 +268,37 @@ static int remove_fetched_oids(struct repository =
*repo,
> >       return remaining_nr;
> >  }
> >
> > +static int try_promisor_remotes(struct repository *repo,
> > +                             struct object_id **remaining_oids,
> > +                             int *remaining_nr, int *to_free,
> > +                             bool accepted_only)
> > +{
> > +     struct promisor_remote *r =3D repo->promisor_remote_config->promi=
sors;
> > +
> > +     for (; r; r =3D r->next) {
> > +             if (accepted_only && !r->accepted)
> > +                     continue;
> > +             if (!accepted_only && r->accepted)
> > +                     continue;
>
> This can be simplified to `if (!accepted_only !=3D !r->accepted)`.

Right, but I think we should go for `if (accepted_only !=3D
r->accepted)`. It's even simpler and works because `r->accepted` is a
1 bit bitfield and `accepted_only` a bool.

> Also, can we maybe add a test for this to verify that we use the correct
> ordering now?

Yeah, I have added tests for this in the new version.

Thanks.
