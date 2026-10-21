Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792585481;
	b=SIg1DsR2BrEoM+WuMBB/OlGLXf54+dg7yLn9T8VsmBbU7+bRZ6clzYPx+gBCnjkSj1lP
	 xjFxYW3MybVvNa7CdaYDzuDZveJTLakUUmhM2/FiAflaBasi+LRGZdyt4hzS1LUHKvjq4
	 AWoWJzdAZ1ISKx88J4xYKO7GreykIEqQGJkr+r2ZGbNWsN2F6s0yMyykPmLFxHJxSJZxs
	 orNbWrZP6uODjt8lZQKq/rcShHrNzgHl1G/Fy7Ns3G8SUlBqQfbrI2uuFxW1rsnxtSOpy
	 MXLEW5arXaIs8fjmIOhs3iRGvzkccAfPbfVSuxPvk7aCLPvKeg5n4eLrWYpGmVkuyLQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585481;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type:Content-Transfer-Encoding;
	bh=tUNw0P8n8Q9jtZsMaHjo+yf+EzX6KSZZ+E/Gq+qPxJY=;
	b=rS+EYUQzgDUu3XCRwjclF/Ys3jvgGW0LzQ8pI5gQ+wGIlUtkfKhAmFo+HDHnI9S+S/cK
	 fqrLMTUzqT9Hi2V0GNA5gZCQrFUFL+NsSnddA6wRXkwdnKcMiBvWx21lcUNYi0mozPsN3
	 xH9bjPNesGYNvva08xE0qjunEQlTmMoslOKb6QKng4EqV/gxVZTVmv9MUQIUxm+JbTago
	 I/WsjnonpzLWl3Jvb7O7xMnxp4c8SsBWp2vC9CM+PlertbWohj0uoChjQOy0OlkozFHmR
	 CEogqnX7t0aFjucqSd0TyxukAMZdCIuQGYH7GgWh0RM8PhILxS+sSFL7coMl96zrbKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gPjgTj9q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A38F60A2600
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 12:24:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A38F60A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gPjgTj9q
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7f84a55e31aso376357a34.2
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 05:24:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792585480; cv=none;
        d=google.com; s=arc-20260327;
        b=eQSVj8NQH38LZ2g5tET9gX6ryszCrdOzVYy6kBN8k57ezOw+WUVpIu6ifuW989yhdy
         YR8nVZFubjrL9H4pOP6JSjXPTeTTN+hF8d7swX2B8O7G4n4C0Ds7BD5YoyDnAaR20+qy
         Na1y2po0QVn2C+LpwVHevG+C/6f3xKbTBZuinJrL1N4LcFcG50vEL57VzMOF67+Uisjv
         z241MKWutMBB4F385sCM5+qDIaa+TJJRwSJTA0LQwh5SyWGvB7BewlDFWne5pm1XQuf+
         AVK9a3fN3ARpliSp3t+lXgoxpBjxc5NRW12xA3XTEo/L2PM1n6+q0lX6CZ7OQZ1tQyxC
         mWfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tUNw0P8n8Q9jtZsMaHjo+yf+EzX6KSZZ+E/Gq+qPxJY=;
        fh=87k/iisDVgU6loKxv7FmfVyzH7RbesydL2geIm+xpLg=;
        b=ohOopYJxoA0Fwatc5jRKfGRNPdxsalL8JAVig/Z4iFxYSlLraMtUNeuvTxlV+89cgr
         jrsulNK3vOH7hFbm7tf9UgZzwr9vYLr0NW7h/DQeUGsjGCGwjctpFiXiip/1DZkUtdqZ
         R7y220K3k+MuMvhEOirxUDKJ1OFdGlmEgkDt5q8rSsA8GrNNxZaU+5GDcbrmf1Z0wEQq
         tvVQ5Cyj0fgeZNyGtRDfFCsk4e7hUMxS24oNvpAkhgmxWQ+RhKeAA/fupLCzqybGGsnw
         Oqbv2BPgSPsDioXUZQVLsxDENX9WchLVDfQNVgz3vQcawAFk0NJQmIsPkBFcl8fJfYh8
         e9Mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792585480; x=1793190280; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tUNw0P8n8Q9jtZsMaHjo+yf+EzX6KSZZ+E/Gq+qPxJY=;
        b=gPjgTj9qxKg0OcScH21UW5ISxU94gdu787flAJsV+s9A9NeTeUzpPyTPBZVULfan+z
         5KJMG9HHye1HryT04Zi0jKxZ5+giZcGIG+1QrsTN+U0gserLibXDdJ1mGEyjU9Kl/Etw
         ZluTPCsx2TOjsvycBWlI3VYoWq79eur+MPkKOgbCQr73sRdoQfNbzid7QcNOuHngjK7o
         MuCCoxpWu3EJ0XcEMdlZz8VlDu2xZXZgRDC3IZFYfYEmF2tJphSMUoHJja7rKdRjnrTS
         aquIT1E7CZftbY7iHwL6ewgOEt+58q+h9IB4lRHGnxEtp1QmJg/b8MH1K9bNkfEDse1P
         oJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792585480; x=1793190280;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tUNw0P8n8Q9jtZsMaHjo+yf+EzX6KSZZ+E/Gq+qPxJY=;
        b=ME44f0oDF/pjjWxPc6wNLuh2rSvTo2mjdg042rF0g1ZHearrakThPcv6gV4ZSxCtSW
         HrUXWhMjsNWO9oLvPSbmQ63TZMPCbrNyc+uYhzMK22ocDsBG9TKd8UqDvPo4Su09KgAI
         VVDXRGzSwC/KPaxq39xK2u4bMMx1gwwFgh7pWtNESN4+i9Fmm8rr/HbGAcbm2eMrD1tV
         /rszJqe7B3v7sOKHPpxFBFZ5Ii9e3r9alc6C/pTmOY0Ys2f4faN03Z8V7rb1uwX116Q0
         M65LSWET0nNBZ3cmlCr2PaNhsLPJlPXwgaV4VCr0vnXNIsJp83yDR6HyvHKHhsGXJbEX
         oZtA==
X-Forwarded-Encrypted: i=1; AKwUvBwqwyZjGRFOLiwGR+/KtRYi6ayO5UOmbz78S6VBFig+Up93PwhA6QHEYKG2EI1M28oQiec=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ1ZXpr9EvRVdt+DVq4PDjE1yXhXPNtF7wa0ysHSsLUoqkN4Bhn
	vpU/xuitT25G3HVe7FFZcD8E2W6v6kwh8Jd3BU2hr3RAq5DXfjCYjZZh+dIG5puQ2rWlXhgcLAP
	/Xwz0YJegZztMsa3tE25KMHRWJLYJC/s=
X-Gm-Gg: AYBFou2buTzFQB5nbIiNF41fLiDNuurp0NTblEMtqc5wFZYspDqilgIMw6nnO7lr76f
	qxiKy7DRyi6WO0OZPiia2pVWSdXHo3KCuCGKFmLTCSnXvqJCsL14SlUYs3uUY6lO+jtb8LdmRwZ
	JJpDmQSB2ltEv9VUQqgBL4sooyNqicoJ4WjNA4h4xvFAcRgI8O6DLqkDpPKG5saKmnNlnN3IDrJ
	ssDpQdXqjhKncFjRJmNq5JB9wTKR/sdFoXs2PbPStficPxuIRIZF7uJAFiPjHztYxgYWwOYNfR5
	Hx8IC/XAPh+Zkwj/yizJ9LdFSIKsmlQCozcDkzEd72+qqpMOia2XYWgooM7gfRv80YLhgkjcRNt
	0AZpmUs2Uu7NbkKYqINgU1wMP0SkgK7LolqInomxlpjYu0V3FxF7E/0/CRPIagi/JIJrysY796+
	/TnnOj
X-Received: by 2002:a05:6820:16a4:b0:6f7:2050:a2c8 with SMTP id
 006d021491bc7-7093fbb82b1mr1040571eaf.24.1792585480063; Wed, 21 Oct 2026
 05:24:40 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2271.git.1792522587065.gitgitgadget@gmail.com> <athzKcUyQjqUTKzZ@pks.im>
In-Reply-To: <athzKcUyQjqUTKzZ@pks.im>
From: Joie Joie <soniqjjj@gmail.com>
Date: Wed, 21 Oct 2026 13:23:55 +0100
X-Gm-Features: AclHuK8HPR1XjBleejkVqcLWkfn2DAkF8XSN2SthEhU7k4puG-7OWtljaDMuN4E
Message-ID: <CAH=d44dU8w+oVc=VEH_84afYsTua2YEVkYEcqHQ9npckymzo6g@mail.gmail.com>
Subject: Re: [PATCH] config: move pack size limit into repo config
To: Usman Akinyemi <usmanakinyemi202@gmail.com>, christian.couder@gmail.com, 
	git@vger.kernel.org, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

Thanks for the feedback! I=E2=80=99ll take a closer look at zero-initializi=
ng
repo_config_values and see if it makes sense to include it as a
preparatory patch.

I=E2=80=99ll also keep your advice on commit message structure in mind for
future patches.

Thanks again for taking the time to review my work!

Best,
Joy


On Wed, Oct 21, 2026 at 9:09=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Tue, Oct 20, 2026 at 06:56:27PM +0000, Joy via GitGitGadget wrote:
> > From: Joy Gundu <soniqjjj@gmail.com>
> >
> > Store the pack.packsizelimit value in repository configuration
> > rather than keeping it in a standalone global variable for the reposito=
ry.
> >
> > Update the configuration parser and pack-writing code to read
> > the value from repo_config_values rather than a global variable.
> >
> > This change removes one piece of global configuration state from Git
> > and helps make Git code easier to reuse as a library component.
>
> The commit message typically starts with an observation, followed by an
> explanation what's bad about the observed status quo and then finally
> explains how that state is improved. The order you have here does not
> match that typical flow.
>
> > diff --git a/environment.c b/environment.c
> > index c83cf44839..e350d6949e 100644
> > --- a/environment.c
> > +++ b/environment.c
> > @@ -728,7 +727,7 @@ int git_default_config(const char *var, const char =
*value,
> >       }
> >
> >       if (!strcmp(var, "pack.packsizelimit")) {
> > -             pack_size_limit_cfg =3D git_config_ulong(var, value, ctx-=
>kvi);
> > +             cfg->pack_size_limit =3D git_config_ulong(var, value, ctx=
->kvi);
> >               return 0;
> >       }
> >
> > @@ -768,6 +767,7 @@ void repo_config_values_init(struct repo_config_val=
ues *cfg)
> >       cfg->check_stat =3D 1;
> >       cfg->zlib_compression_level =3D Z_BEST_SPEED;
> >       cfg->pack_compression_level =3D Z_DEFAULT_COMPRESSION;
> > +     cfg->pack_size_limit =3D 0;
> >       cfg->precomposed_unicode =3D -1; /* see probe_utf8_pathname_compo=
sition() */
> >       cfg->core_sparse_checkout_cone =3D 0;
> >       cfg->warn_on_object_refname_ambiguity =3D 1;
>
> Hmm, quite annoying that we need to explicitly zero out all these
> fields. Maybe we should adapt `repo_config_values_init()` to first
> `memset(cfg, 0, sizeof(*cfg))`? That would allow us to remove a lot of
> assignments. If you want to do that, it would be great to do it as a
> preparatory patch in the same series.
>
> Other than that the diff looks exactly the same as a local patch I had
> already written myself, so thanks for allowing me to worry about one
> less thing :)
>
> Patrick
