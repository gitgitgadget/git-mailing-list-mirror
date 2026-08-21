Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4511540F74A
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 06:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787294460; cv=pass; b=hMrE2tFCjTGFmK9cSK62CNeZI3Kpu9+Po6kPRxPGMucDJFPjs2EJvvGGvebVUTUSejhfJufuzVoHhVGVLASpUxev/SRT86mTIUST+p54vO2NhCFxDKBYu7Agq8IxudqD66W5RO5FfcTmpCrr6ykP02SQGnKDEx+0UkjSL1qJk9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787294460; c=relaxed/simple;
	bh=xKbCKHtR3trjQU5ihby2C1EBiVK4RxYYR4+bhwWDzno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sVnuopkb9JzlDH6X02P2ayjJV3zSkW93kmdtlw/93pgC4S4RciBzlQEtYJhkEPKeQt68ImZjISnj4StOZ/alGAQjFGtv2SB+KfvtosRji6Lx01qZA/wGNwOluoVZd2r04oi98ytQSlBwgaCOVdwKKG4Z67uSdLOGJbLjLNdBfCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgg8claf; arc=pass smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgg8claf"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-45ef699308eso329500fac.2
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 23:40:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787294458; cv=none;
        d=google.com; s=arc-20260327;
        b=B+iihkcsJKwWH5ZMIMPIUxiUoiYiQaa9+JSyh4f5iP4w/cjC8P6tgllP7ZayY6HVX3
         s/ZIloYTSeUkr/LggXdu5TWddXJk5GK/zjwuXITIVSJuz8PLAb3+HAqSD/EdY/kfX/dP
         6OvBGFswctm4OjEVOv1EaffXKrXya4T2TP1Dv8uRVJlZpjLsO3A1DdjxY4qAPLbyv/DT
         mDKgGePxpPaXNtq6AW3QKlOErnd4GodgGgweZPYIvEkgduIAomGFTaFofSqExap5bvaO
         376gb8tF8jAthnLSm9rN0zRBV7f3+UHndbNhIgbUshA6kIryGPz3K/Xxn1Lzc4X9OHNr
         Omvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DPQNoZ6yNZ+2v1XMBwYiVuvl/fn9mLIFSS9NmsGaAsE=;
        fh=lIuTTwg3WPgzcB7dYFnAgBSGhvcsnUpdHUtspSjo8YE=;
        b=PV0yD2nH8MKHDQtdL6eg2u8avtwmbt3HiHdh5POE9vzo/VTQpSP4kAc0742DqzeXAG
         6bro3nGxtb0GRL26TFfkpHwnR0jGkZqffMFbIu6x8E/oFfXR/3pU4OOnHGb0b+yHe+Ka
         47fSen4Os1dGYpGrjlk3YFUKXUGj6JDX34cja323JMgFoqzOG2XHe4olsee1ZR9QRo/u
         ZKkqMQhLo7SIbo8ZmGZt8Zf2a8rggfwoLiPm4X5bxRXSaIf06W9TbDJiPdOObtGBbgS7
         xDWi3bEHYM9xweVZs18+f/y8P3FjPnc7fzO6A/3iV9L46YSUx/giKBiwC3OPplypXxUp
         WFaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787294458; x=1787899258; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DPQNoZ6yNZ+2v1XMBwYiVuvl/fn9mLIFSS9NmsGaAsE=;
        b=kgg8clafE1WndnuQxoIDRv3Nz+G+Otc/E7kPEYlHZ75Vw/y6zBmSh4yHSxpSaiIHXq
         oqfyhtKVDqkCmOqyU2SmO/06H2IcRjFQ3bI8Uh8k3HGT5r9lVMp38rEEQvhMtTZloTPc
         bQsDlX9J71jTDQw0hYkH+XZCq49Ykcht1yyIs5TK5WH7ImGWnlJHKswPwtEcT7phlyAz
         Zh2Wgmq8a1m4p3c91EpQZaBsfHIckY4SYIgbfpVIYVsYRoXvcyju1V2Qvd6Yvkuix+4a
         Jl5w9DpmUt/fmGjVvKWAxKFGO1YVgarb31TjFUS0lQeVYgEE4YFgpJgXgUi1iD0E2OD7
         HiXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787294458; x=1787899258;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DPQNoZ6yNZ+2v1XMBwYiVuvl/fn9mLIFSS9NmsGaAsE=;
        b=M4qu+W/QY3RIjZ4q07E8GA/qgQnX5yLpjo4H04XHNaPNJVF/4aNS5XV5GKm9l8wFWs
         McdpPltmLJWtwgp1ZMFiW66o4VL9gxOolOCXdyNz93+g1MDLSImM1VZ5V55hpWjA9afn
         iYovY1CyKXh+bBLHzgY+5DG4Td/GbKDj7lNnNhN3NrMfsH1f5ypcj5MTnuv6ZG9u4YCg
         Vx4zNJjINSqtb3/6SXMygNfYCilkSWIzhZekFWx+FkHuycQt2+TYcGG28LuYXALzhDJI
         6bFSRJGYMwo2bUSZ/0KpZFnBaVQPjRgoVm3G6wHGFiG/K4mX9noMNcTnQfZC7Q2fDcrM
         g26g==
X-Gm-Message-State: AOJu0Yy+h53HYofNadZ6q++zvojRwIVtNfH8GfPU99KlhrOSSLmH5v26
	TMWbZ/8WntmbjN6dMtKd933TOmNrJpuEOtfK/5q0tKjQ6yn05l3bdGyADxirxrHcPX7q//JHETb
	jraxIFbt+5nQ1I5t5+W56ln3Zve+iU3wWbg==
X-Gm-Gg: AR+sD13/u1frKH7mpEZPaU+dDNEZbaCLr41Qt3CA+pLfenwBvBaEmnk03ms/tpyXbb1
	N6xQlTMthuiQ3VQz0aj5rAgWEYTrCORbEGq/vnFuRH4BGzCerHNh5Xa+coZhqOgJNY03O4SUunc
	2tOwwPYJyQvGl6Yi4c0h2bofzlRGrqnRDUySyArCy8lm8fet1UR/jCklC9m5U80VV7wbrGffGGY
	VEaOdbFs8Oa3797XC9AjLwghhUd62egKz9cCtqqDVufK1G6EJ0SMOhkd06cjShWAKOEFi+P/SyD
	bK390/S99X8b9Zmt4Hz3PmPsU2vGh27FlMGp69Yi0wmskRN5dnLhU4eFapWJGxcDGjVM30eG51A
	fwYbpM/1AESoz/9x3yGA5CCPeeQLoHYlQlwPsZZKW/c7RGm3hGd3+UvpNy2lsWdMn
X-Received: by 2002:a05:6820:2219:b0:6b1:4cd1:a7b with SMTP id
 006d021491bc7-6b159402876mr3752081eaf.31.1787294457990; Thu, 20 Aug 2026
 23:40:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811-pks-geometric-maintenance-reduce-frequency-v1-1-7a54c42355ac@pks.im>
In-Reply-To: <20260811-pks-geometric-maintenance-reduce-frequency-v1-1-7a54c42355ac@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 20 Aug 2026 23:40:46 -0700
X-Gm-Features: AcwNN1VNhaCoBfbhlwjZuLOnQSPDthF5zrYQDFCDCKs7pYalfYUuPUQAHpQg65w
Message-ID: <CABPp-BHgyVTHB_OGmCL4JprFFe6_MapOQNSjUOhJxu-+oWbErg@mail.gmail.com>
Subject: Re: [PATCH] odb/files: be less aggressive with geometric repacking
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Stefan Haller <lists@haller-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Heh, looks like a typed up a response and got distracted just before
the end and never came back and sent it.  Sending now due to Patrick's
ping about this not showing up in What's Cooking; maybe an extra
review will help.  :-)

On Tue, Aug 11, 2026 at 2:17=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> When performing auto-maintenance with geometric repacking we have two
> conditions that may trigger a repack:
>
>   - Either the geometric sequence of packfiles is invalidated.
>
>   - Or we have too many loose objects.
>
> The first condition shouldn't trigger all that often: it may be hit when
> we fetch a new packfile, but users tend to not do that all the time. The
> second condition is what typically triggers more regularly though, as
> every command that ends up writing new objects may cause us to cross the
> threshold of loose objects. It is thus preferable to not be too
> aggressive here, as otherwise we may end up repacking objects quite
> often.
>
> For the geometric-repacking strategy though we have a default of 100
> objects, only. As we're approximating the count of objects by only
> reading the "objects/17/" shared, we'd only need 2 objects in there
> before we perform a repack by default, which is quite aggressive.
> git-gc(1) on the other hand has a default of 6700, so it is quite a bit
> more conservative here.

2?  Wouldn't you only need 1 (or if you could have fractional numbers
of objects, only 0.390625 of them)?  <looks around...>    Oh, huh:

        /*
         * This is weird, but stems from legacy behaviour: the GC auto
         * threshold was always essentially interpreted as if it was rounde=
d up
         * to the next multiple 256 of, so we retain this behaviour for now=
.
         */
        return loose_count > (DIV_ROUND_UP(((unsigned long) limit), 256) * =
256);

So, indeed, you need 2.

> Being this aggressive is also causing problems as reported by our users.
> When running lots of concurrent writers, those writes will constantly
> end up spawning maintenance jobs that end up repacking objects. As we
> also prune objects, a concurrently running process that tries to write
> an object may see that the sharding directories get removed under their
> feet. While we try re-creating such leading directories, we only do so a
> single time, and it may happen that the directory vanishes again before
> we had the chance to create the loose object. This is not a new problem,
> but it is exacerbated by us running maintenance this aggressively.

Unrelated to this patch...but should git avoid pruning the loose
object sharding directories?

> Improve the status quo by reducing the frequency at which we pack loose
> objects to the same frequency that git-gc(1) uses.

Makes sense.

> Reported-by: Stefan Haller <lists@haller-berlin.de>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> Hi,
>
> as reported by Stefan at [1]. Thanks!
>
> Patrick
>
> [1]: <4f6a96ac-d993-4872-b3c4-30d899f61ca9@haller-berlin.de>
> ---
>  Documentation/config/maintenance.adoc | 2 +-
>  odb/source-files.c                    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config/maintenance.adoc b/Documentation/config=
/maintenance.adoc
> index b578856dde..da8be9f812 100644
> --- a/Documentation/config/maintenance.adoc
> +++ b/Documentation/config/maintenance.adoc
> @@ -101,7 +101,7 @@ maintenance.geometric-repack.auto::
>         there are packfiles that need to be merged together to retain the
>         geometric progression, or when there are at least this many loose
>         objects that would be written into a new packfile. The default va=
lue is
> -       100.
> +       6700.
>
>  maintenance.geometric-repack.splitFactor::
>         This integer config option controls the factor used for the geome=
tric
> diff --git a/odb/source-files.c b/odb/source-files.c
> index 5a68af7d84..555e466145 100644
> --- a/odb/source-files.c
> +++ b/odb/source-files.c
> @@ -521,7 +521,7 @@ bool odb_source_files_optimize_required(struct odb_so=
urce *source,
>                 };
>                 struct existing_packs existing_packs =3D EXISTING_PACKS_I=
NIT;
>                 struct string_list kept_packs =3D STRING_LIST_INIT_DUP;
> -               int auto_value =3D 100;
> +               int auto_value =3D 6700;
>                 bool ret;
>
>                 repo_config_get_int(repo, "maintenance.geometric-repack.a=
uto",
>
> ---
> base-commit: 010afd3166ddc64c9863b1506f12cbcdda0d4ea1
> change-id: 20260810-pks-geometric-maintenance-reduce-frequency-5c1c9423ce=
b3

Looks good to me.
