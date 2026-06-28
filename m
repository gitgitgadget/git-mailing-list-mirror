Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93BA3644BE
	for <git@vger.kernel.org>; Sun, 28 Jun 2026 22:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782687327; cv=pass; b=k/mxUZsNlIuK0CXZGLt9XhLqipBItLOQ8uU9EDGOkOngxDsBHKV7qYo3WRKiKsapHtL2/Fe8PHe93aNPHqxwIBYI3Dy6kRUuO6cMXMzoAwuT97QzO9xXpOtlybCnzz2zwHusSdEf7tYjy5b/yol/el3G5w/kdmFRAKZan6dyIWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782687327; c=relaxed/simple;
	bh=wQoVTJiLjLmkt5wbdqvkMRN+XT/yvwI/JsOjDiVyBS0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dc6OKxogklxQYBXfj68FGCnFKYOn1fMcr1b0DEMlwnTeBeTwfginrvbY3OmRvcW3iQcRM5pKLo+tUR9PrH4SZ080S1vBIk+qh7aoLJllF2Bg6HTPNQjy3f4hetnyoz5vcs8VYiHtddH6Cn18qoV1w6HgVp2dD5JekDIMb524dyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbC/2Twb; arc=pass smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbC/2Twb"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5bd96d34082so418800e0c.2
        for <git@vger.kernel.org>; Sun, 28 Jun 2026 15:55:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782687325; cv=none;
        d=google.com; s=arc-20260327;
        b=SmOodyT54kWz2BgB2UBtPUrWEaxd2ZLdv4rauax3/qWSTKm2B/OoN+JNSadmGzjmKC
         IDKo8lZvjQ1rtC6csYhWH/H/Ay+zrl2VGMAJty6PDQ6ynvNDTcSS3y+bPBDTxNZRVX2I
         oV7UWKYqmQPBJPlUjZm+hj5Ar9joXpiBuUPvR0ia1YtchRXE0g5L7bOtiCpAqVkFyzv7
         SDAcidcqIeGqiQROvJUWA+AV1lMxvjT6C3u6KGHM+J6+UXgjIB/3J3PB+aWJugui1Rmb
         xYVuQj5DNCkFv+84QG5TC9qZclxSEQq8rGcf7hRiiaHjgxzhsio+UMzcjVHrUB5gXPhG
         75lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Z71/t/vIJCIK2fGLnXy4KPU8554q36gV1ZSlVXkB6M0=;
        fh=a+DmZIFe7THWpkmuJvXgRBgodOc3qZoAt/WDNS3QDRE=;
        b=kwYY5pW1ZKFuspcZu4kk+6/bU4NkMZn9qrzGVDLIi/X8h9AxogIpzA/i2s5fWdzMK1
         rIcfxut9TbTw+UpZLYqRSEAuPXArIyxiS4KfM0rIKNmsjZkXXQBZVu/62SICegCElynY
         vePq7ruf42gwOKYfWDtXua6eZ1/nWsn0FoHzhKZitOkcUuPG7bqIdgoWz796cABQkX2w
         15CZat4Hd935c5Y8672E3Vw9jIdh7skHSM5zBpy1zQp8HBW3afDMv9Fo9cH5dvN2xbJN
         HMFJsykOCXCZHmEZ8E4S16FzJtJsAzBHiLjlXwxZ/J2WweDEt6BXPJ7LjMXXElM6d4ik
         G8fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782687325; x=1783292125; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z71/t/vIJCIK2fGLnXy4KPU8554q36gV1ZSlVXkB6M0=;
        b=kbC/2Twb233FZJcJCC9Y1A6N4hixYlA2hBjvD+hoMpyy9sC7xKdBqJYH/La62VFGoI
         SXQYGqkk0auGgXg5djif6SwWwZ5Uavrj6Ud3qPshuHELp4j8JPdCS2ywYX3URQXIjydU
         wAhaXpcPGFYbWSK/f7Y7oBRx+Ah5oMfH7jPgiaSEgxULqP243+tJYtGtR4eT08AbAGSj
         tMP15w19fHBRMjxMhATHDDenCB5CjDsoWEM2/uYlOIuOK3WATLoCX7fXRJ44afAqRo4y
         t4PxFfM+RNAQddXKZQ8RmoxfoPxnPXFtZjKljIsitzDdvSJFQojMubPeNJDwzCj59xaB
         tSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782687325; x=1783292125;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z71/t/vIJCIK2fGLnXy4KPU8554q36gV1ZSlVXkB6M0=;
        b=FsBW9GoQuo44/CpzNTGONCC+PmS4oTenUxAzuCqQIh5qxBermrlOYumK+YRu4Gt31t
         6sZvV1oqlNMxcgIxcwj3lnw9nQ4mmUA69eb3Hax0G9yvP+Mh2wFCi54cxr2cSnOAjPsI
         D4ua9ksaKvkIAiDOunINMmRU6HMWQ+d+tto+hb/kI8vuklXRdkcfYNjqzTtfPeTsnkap
         v29YdPbY9ZJpC30aVcm7q9ZQeZmX3xRJTVD1IOme7pZpVNL2G+4QBgg8sSjkIFV+j01E
         3nJ8XPUYoACijsgE1CcdGK2jlc4tZ2tHA3+JQcKq1gTa2eyhk0QmjGStLWBvqIEhSFTO
         rhiA==
X-Gm-Message-State: AOJu0YwRza3I3efzIdLH/2d2V/hU6g8lzdxQCXd7Wl+1JmvDb/TO3Ou5
	k8z4h+xnWKpJAs0n2B9yK82drijyi7ND3e5x0fiFdVuwx4d351xNAZGfKq1ezpyS0OlCQE6PfSK
	nc9QtiRagHIiqw69enMFy0wo7Lak6ofs=
X-Gm-Gg: AfdE7cnbMv98CP2jNjRDwzhUqcKvHUZQevszucC0KNIliu7pZRN87ryHSxVsCp3BcSK
	f7qptq+aYsryV5lzxp8rktRuyAnZy1IHHGmOYFQ9zbjxhQLJkhwOlu4qDMRRPm++j7oaPSp0vnk
	M9dK6UGfUResEiqOXHDkbYAw4J19zCMf0MPdslxkMVteDtf60Rg+XcAVot0xPIXy0Hjo1DDN36F
	HhlHXaozK3piEHPaHqyTJ0BVft12axtIqsVDhSFiGxnof/ddgCeESALxs5qs4lXBlKFIEkCSE/d
	Y4BLTU+oEs54rph565HmNYoPpWvhBTl9f0mZz1WQBTan0ODxqNBLyh3WpHgr8Q==
X-Received: by 2002:a05:6102:e0c:b0:726:accd:6ec4 with SMTP id
 ada2fe7eead31-7343087e97bmr6467008137.0.1782687323641; Sun, 28 Jun 2026
 15:55:23 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 28 Jun 2026 18:55:22 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 28 Jun 2026 18:55:22 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAN5EUNTrdNArd5SX9df6x9bOhRfzE4c7dLOuNu7ONUdn4TLsUA@mail.gmail.com>
References: <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
 <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
 <20260625-ps-eric-work-rebase-v14-9-09f7ffe21a53@gmail.com>
 <CAOLa=ZShTcHOekT+NuxMwZz-7P5i9aSWXSL6MW9_9aKkNwqsig@mail.gmail.com> <CAN5EUNTrdNArd5SX9df6x9bOhRfzE4c7dLOuNu7ONUdn4TLsUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 28 Jun 2026 18:55:22 -0400
X-Gm-Features: AVVi8CcgBcAWGEa5yvucRZyD9MNIVt9OOpC-gKLlT3M-qQXpFcR93ome34qH84k
Message-ID: <CAOLa=ZR0B-wEOHFNeu7HjypiTqr45mfGd1NkN5cPH85hxYqe4Q@mail.gmail.com>
Subject: Re: [PATCH GSoC v14 09/13] serve: advertise object-info feature
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org, chandrapratap3519@gmail.com, chriscool@tuxfamily.org, 
	eric.peijian@gmail.com, gitster@pobox.com, jltobler@gmail.com, peff@peff.net, 
	toon@iotcl.com, Calvin Wan <calvinwan@google.com>, 
	Jonathan Tan <jonathantanmy@google.com>
Content-Type: multipart/mixed; boundary="000000000000abf5c90655583cef"

--000000000000abf5c90655583cef
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> El s=C3=A1b, 27 jun 2026 a las 0:23, Karthik Nayak
> (<karthik.188@gmail.com>) escribi=C3=B3:
>>
>> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>>
>> > From: Calvin Wan <calvinwan@google.com>
>> >
>> > In order for a client to know what object-info components a server can
>> > provide, advertise supported object-info features. This will allow a
>> > client to decide whether to query the server for object-info or fetch
>> > as a fallback.
>> >
>> > Helped-by: Jonathan Tan <jonathantanmy@google.com>
>> > Helped-by: Christian Couder <chriscool@tuxfamily.org>
>> > Signed-off-by: Calvin Wan <calvinwan@google.com>
>> > Signed-off-by: Eric Ju <eric.peijian@gmail.com>
>> > Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
>> > ---
>> >  serve.c | 5 ++++-
>> >  1 file changed, 4 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/serve.c b/serve.c
>> > index 49a6e39b1d..2b07d922b3 100644
>> > --- a/serve.c
>> > +++ b/serve.c
>> > @@ -89,7 +89,7 @@ static void session_id_receive(struct repository *r =
UNUSED,
>> >       trace2_data_string("transfer", NULL, "client-sid", client_sid);
>> >  }
>> >
>> > -static int object_info_advertise(struct repository *r, struct strbuf =
*value UNUSED)
>> > +static int object_info_advertise(struct repository *r, struct strbuf =
*value)
>> >  {
>> >       if (advertise_object_info =3D=3D -1 &&
>> >           repo_config_get_bool(r, "transfer.advertiseobjectinfo",
>> > @@ -97,6 +97,9 @@ static int object_info_advertise(struct repository *=
r, struct strbuf *value UNUS
>> >               /* disabled by default */
>> >               advertise_object_info =3D 0;
>> >       }
>> > +     /* Currently only size is supported */
>> > +     if (value && advertise_object_info)
>> > +             strbuf_addstr(value, "size");
>>
>> So is the plan that further options will be added here to value? If so,
>> whats the format we will follow?
>
> Hi!
> The current documented format is at `gitprotocol-v2.adoc`, however I
> think it could be improved. I have a more complete version in the
> not-yet-sent %(objecttype) support series, but since the question
> comes up here, I will update the format documentation in this series
> for size only:
>

Ah nice, I didn't see that.

> oid <oid>
>   Indicates to the server an object which the client wants to obtain
> - information for.
> + information for. They must be full object IDs.
>
> - info =3D PKT-LINE(attrs) LF)
> + info =3D PKT-LINE(attrs LF)
>        *PKT-LINE(obj-info LF)
>
>   attrs =3D attr | attrs SP attrs
>
> + obj-size =3D 1*DIGIT
> +
>   attr =3D "size"
>
> - obj-info =3D obj-id SP obj-size
> + obj-info =3D obj-id SP [obj-size]
> +
> +If the server does not recognize the object id, the response will be
> +`obj-id SP` regardless of the number of attributes requested.
>
> About the names `size` and future ones `type` they are arbitrarily
> chosen, so for example: `delta:base` could be `delta`. They are
> appended to the buffer so in case of adding `type`, it would look
> like:
>
> strbuf_addstr(value, "size type");
>
> What do you think?
>

I didn't know this part was already documented, so its all good :)

> Thanks for the review,
> Pablo.
>
>>
>> >       return advertise_object_info;
>> >  }
>> >
>> >
>> > --
>> > 2.54.0

--000000000000abf5c90655583cef
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6359b9d01f4dc256_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1wQnBsZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMXFkQy85U0hsaCs3SjMvVWpXN2hhcEN1SnRLOHRqRQp0WVRPSTNOOVdP
Ym92SnErcTNWSkVGZUM5NTREaVBBNWdKcW45b09wS1dyM0JYVkVZeUlqaHgwR0czRUZZcTFXCnFa
UkJITFNDR2RDNGtNWVBTYzJWd1c0ZS93bGdoaTJDMjM2YU9lVUlKeGFwWGNRaG5WVTZnc1dRSnBQ
c3hWdHUKNXFTVVhOYTZVL0lEZmtqYmtxbUs0cTNPQU85eXVYalNZeDhkS2luKzRtZkRSdDdySWFL
SzVueEZZZkxOYzhrUApmeEdwM0t3ZWlRSWVHb0Vjb2dPLzhUZFBrOE5GMERHVGxEQklCQnVNTmQv
VDluVEt3RjlQd2dZWHNPMmFSdEIyCi9BN2pWdHlZa3hlSTVzcUplTjJaVHkzYXRPUWhmdHczVWhv
VTVLTGxrU2xEVUVJdEdkaFlDQjc4VDhiNGtUaGwKZVByR3k0OFRiOTZDWURPUTZaSGVVM1hyQVVy
WVJxcEE5TVM1ekVIUXpnUmd1bXpJaDFoM3dtaE84bVBwSU9ldQp4NlhBc0VtSnVRQS90M2xQOTh2
QXA0emZlMzhtNE5JZHBzMWFJTmVFd0hLcXhHYTk1VGFmaDA3aWVOSnlGUWMxCjJmWVliU1lxL1V5
cldPREVZaEVsS1pzSDVCUzVZZUVhZGFOMzFwTT0KPVBqa2gKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000abf5c90655583cef--
