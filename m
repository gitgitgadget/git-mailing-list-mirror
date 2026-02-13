Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3973714AD20
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770989433; cv=pass; b=CPOJHDQTZdMK8BNazOVNiPAZRUeoypccL94qLJ8b5dmEm7cCt+uefWGZCufWEp1BevvoaUwDLJGs0kg0k1LyjP/LsUUpcCCE8f1Ni/O3XY3iNgRsE0VW0jX5OAUjCDI9M/zgA0C/TjaQTS7qco1pTNOI48rn/2/J8wrvtQBbqQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770989433; c=relaxed/simple;
	bh=tPODDW4D5At0S9QuDXQI4pAJHWso2gyvJrV+WnYOOyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QWmP5Xf5TXDDlEmOVVbWX5wzCIbxNdvXTYtW7tLKl5Pp5Ns4jnrHQ/PFiCyHJDY16Z9PnB45bDXcyOIKHl/RwXk/IsTsjRODxRuxLw7KyNaVnF7Gn9P+BB4mkjT7STPLZ5BMnjprZex9NDlg8OQ7PVNjl0VB4akhNyjzHRBMaaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopify.com; spf=pass smtp.mailfrom=shopify.com; dkim=pass (1024-bit key) header.d=shopify.com header.i=@shopify.com header.b=T59Bbg91; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=shopify.com header.i=@shopify.com header.b="T59Bbg91"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-38709888abeso7365701fa.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 05:30:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770989430; cv=none;
        d=google.com; s=arc-20240605;
        b=GQO8f/z0WzIeXITeYMvhzi4IcZPFFpcQelGXLkBRBjti+VlswjYpAf6aKfvbnNx63P
         WdDtrUrm5RkYTj1kHmLl/8Y/y9aNfH4beSxdaF8MPDYM0fpvt54yo+5C9OBoGaEkGfT7
         GmKBg2PSbAq5hWI9NdGAC9YV7PosvWDuVicT8F7QZi62iLhsjMnUBCn0/zPGoWdq/dYw
         4zHQXpcwaeCye+gtDY78SNFxKy2tnUGiLOsF8RQzwZfsbmlNxbhHi3iwSg+PimqG/sik
         HcWiEEMiLXvVAL0nxuo195//feXd8Taz2bQjxQZKjh3tIpPv1q1q2xjLu9m6zRQrRUM+
         EkNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t2nGQVVNeVABhc4UOUeGgRoe2DUdKv4rKBQ51wMMBdE=;
        fh=JAOLoSQQXE803f25HZ6aFeq0/00jBawjuOD/KUtHH0Q=;
        b=QmyPRRIee5bK2lygaVSCNJ6fZnFNoMn/oxBenmBxZpw2BCpe1fI5wnuZiMOuDwMH1d
         ANrNgNo2zkaba5RoyGqRIAiR5m/aJ36uKGCsb2lQNILgqRVNfc6Qb9+RCA0EfDdNO7yi
         w6wEK81PGS1EeSuu+6mjYoW+a68F8pauICP4Zobm0u9lwJyshop8HqcEfmuHEdT+XP1O
         hrfbr21ahljWBLmGl5t5udfEwQTCPAY2+ooT74uYkJcSXfv4976WcyIW5ozcAzdtfnxl
         LNZtKCjY+CxwoJCb6/HQNJuqUvzxHDXpoPnULuvtqHhsTYVj0rZjMQC2NHDZMIBsorRq
         e2bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopify.com; s=google; t=1770989430; x=1771594230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2nGQVVNeVABhc4UOUeGgRoe2DUdKv4rKBQ51wMMBdE=;
        b=T59Bbg91gRMcO2oZA3F/ppRbGySj/q+28QoSck1crrZv6NnkMywMxLQOe6CEYYJ7G1
         7ZLSd6rsc74hUKEKsuLeCf+aj0RSvlr+/uvvzs97K//YLO7uIY5PshHDiZZkXplwYPu+
         /W2z4cRM5zZ0nDeraM/pIgMXOkw5BMeH5JmG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770989430; x=1771594230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t2nGQVVNeVABhc4UOUeGgRoe2DUdKv4rKBQ51wMMBdE=;
        b=DeBK4+fo6npW5VyP0ngbD3nW/kl2wwXoUy/H7XIHvzvgdQDQThMaFYeSz6EPr79Xr9
         /6DGbgG6vgLCAUrd2mxmJ56SzKTaSrjckLljHDm/ysPghEFWzr/U6llawIVF+vfDXU2u
         2n7/sVQUqF+1kYMtRa8MHSzIUyW/haQDkCtV368nIvJeKMz/+R4JHCKHpF4JU+as15vT
         OnvmrUA1JADY+P2oVNjffR9nXBarbF2Y9AYRjHqzXhfb4R45jm0bi0iCqcULTukCsBqt
         OgUbPk9xGxHkovFqBuFE0OsYUGoRkKUD9jTolZAQx594biNiW3bCiJx/KxmahIIL5io3
         fsVw==
X-Forwarded-Encrypted: i=1; AJvYcCWYfTfTSU00zTYrEdmIJ/ak5TjcgfcsNknWrZLWP/LDVzT/X6Q3vXvNhvdbUdZAgUi9ozQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkleu/tVAKQsEWSvcSAUcHBSM9mgkOB8+3N9aGx7DPkH4gYeQe
	Yy0hd7rRdh6aHUxnuaP+M1p5+svDYpRHXkNXlqxAGiNZQ4yd+j5YXumDpkUQfnXX3acIJpiXisk
	NjpasrAcIAX0kIEwqr30d6Ob1Xe2hZobtSuAuIDarHQ==
X-Gm-Gg: AZuq6aLaCi+LSJjD9MLJgy3BFRKnMeHBjOUOhIunS/W3HwRhYY3hhIlPN07UT3eXM4s
	hEUDOaCtsUz8I9PfEZW7s67vrNVwlbDWOWT+VzxVhBrTy24ReMpVrD5RXhA1gnbqalKh28+N/4x
	iTYKxWLCJDPidTAcgRwknB4hpHQgTXoNGB9kxiqnmy7ArR+Mx51svSe37NdyYtu1lnMlubgUJXn
	Wa4VBjdK6zXDaJ1yQHvn/dVvJtVFf/LzOxyvKZnDvwUgvChyfWP7FsrQ1xFcEyRGfDY3+m0kfpG
	NyI=
X-Received: by 2002:a2e:b8ca:0:b0:385:da28:1e40 with SMTP id
 38308e7fff4ca-388106c11bemr6685471fa.39.1770989430054; Fri, 13 Feb 2026
 05:30:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2008.git.1764160227.gitgitgadget@gmail.com>
 <pull.2008.v2.git.1766069088.gitgitgadget@gmail.com> <d80ce077038bab96aca26b0b0ad706c91ea1d8a8.1766069088.git.gitgitgadget@gmail.com>
 <aYvV2W5pcvqZig8S@nand.local>
In-Reply-To: <aYvV2W5pcvqZig8S@nand.local>
From: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>
Date: Fri, 13 Feb 2026 15:30:18 +0200
X-Gm-Features: AZwV_QiGo5-Bk9Tz0AcW9ZT2jdfZ4ebwEAtSPiH1HrkeSe1O54riaF8u8plRf64
Message-ID: <CAGjQmDMA1sZStTP=NC7Jp62zSLaHS0d3EYweY0BS5j63m2pDNg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] http: add support for HTTP 429 rate limit retries
To: Taylor Blau <me@ttaylorr.com>
Cc: Vaidas Pilkauskas via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 3:05=E2=80=AFAM Taylor Blau <me@ttaylorr.com> wrote=
:
> > +http.retryAfter::
> > +     Default wait time in seconds before retrying when a server return=
s
> > +     HTTP 429 (Too Many Requests) without a Retry-After header. If set
> > +     to -1 (the default), Git will fail immediately when encountering
>
> While reviewing, I originally wrote:
>
>   Setting the default as "-1" makes sense to me. The current behavior is
>   to give up when we receive a HTTP 429 response with or without a
>   Retry-After header, so retaining that behavior makes sense and seems
>   like a sensible path.
>
> , but I'm not sure that I am sold on that line of thinking. This is
> controlling how long we'll wait after a 429 response before retrying,
> not how many times we'll retry (which is `http.maxRetries` below).
>
> Should the default here be zero? We would "retry" immediately, but that
> retry would fail since the maximum retries is set to "zero" by default.

I think the only reason I was using "-1" is to have an opportunity to advis=
e
on existing configuration for retries, but I guess we can live without advi=
sing
as I expect folks who are willing to configure retry handling will be advan=
ced
users who are aware of the options. I'll switch to "0".

> > diff --git a/http-push.c b/http-push.c
> > index 60a9b75620..ddb9948352 100644
> > --- a/http-push.c
> > +++ b/http-push.c
> > @@ -716,6 +716,10 @@ static int fetch_indices(void)
> > +     case HTTP_RATE_LIMITED:
> > +             error(_("rate limited by '%s', please try again later"), =
url);
> > +             ret =3D -1;
> > +             break;
>
> I wonder if there is an opportunity to DRY this up a bit? I think the
> case in fetch_indices() is very similar to remote_Exists(), and ditto
> for fetch_indices() in the http-walker.c code.

I'll leave this code unchanged as per Peff's suggestion.

>
> > +                             slot->results->retry_after =3D retry_afte=
r;
> > +                     } else {
> > +                             /* Try parsing as HTTP-date format */
> > +                             timestamp_t timestamp;
> > +                             int offset;
> > +                             if (!parse_date_basic(buf.buf, &timestamp=
, &offset)) {
> > +                                     /* Successfully parsed as date, c=
alculate delay from now */
> > +                                     timestamp_t now =3D time(NULL);
> > +                                     if (timestamp > now) {
> > +                                             slot->results->retry_afte=
r =3D (long)(timestamp - now);
> > +                                     } else {
> > +                                             /* Past date means retry =
immediately */
> > +                                             slot->results->retry_afte=
r =3D 0;
> > +                                     }
> > +                             } else {
> > +                                     /* Failed to parse as either dela=
y-seconds or HTTP-date */
> > +                                     warning(_("unable to parse Retry-=
After header value: '%s'"), buf.buf);
> > +                             }
> > +                     }
> > +             }
> > +
> > +             http_auth.header_is_last_match =3D 1;
>
> Could you help me understand why we're setting header_is_last_match
> here? I think since we immediately "goto exit" this line isn't strictly
> necessary.

Yes, this should not be needed - I'll remove the statement.

> As a separate but related note, I don't know if this function properly
> handles header continuations for Retry-After headers, but in practice I
> suspect it doesn't matter, as servers should not be continuing
> Retry-After headers across multiple lines.

Yes, I assume it's not applicable to Retry-After, so I'm not handling
continuations.

> > @@ -1660,44 +1729,98 @@ void run_active_slot(struct active_request_slot=
 *slot)
> I wonder if run_active_slot() is the right place for these changes or if
> it should be handled separately. I think it may be somewhat surprising
> for run_active_slot() to return without actually running the slot, even
> if the slot is marked as "active" but just waiting for a delay.
>
> OTOH, like I mentioned earlier, I am far from an expert in this part of
> the code, so perhaps this is totally OK. shortlog says that Peff (CC'd)
> is among the most active contributors to this file in the past year, so
> I'll be curious what he thinks as well.

I'll follow Peff's review for this part.

> > diff --git a/strbuf.c b/strbuf.c
> > index 6c3851a7f8..1d3860869e 100644
> > --- a/strbuf.c
> > +++ b/strbuf.c
> > @@ -168,7 +168,7 @@ int strbuf_reencode(struct strbuf *sb, const char *=
from, const char *to)
> >       if (!out)
> >               return -1;
> >
> > -     strbuf_attach(sb, out, len, len);
> > +     strbuf_attach(sb, out, len, len + 1);

Sorry, I totally forgot about this change. I still got leak reported
from CI, so I
narrowed it down to this line. I'll make a separate commit to discuss it.

> Not sure that I'm following this change.

> Thanks,
> Taylor

Thanks, Taylor, for the review!
