Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C0F35E944
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 17:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782320582; cv=pass; b=lGdhJXyWR3XrnOf629WGtpWTFHWTUV6iuZMcpAP7LAPA6ic0JmmHNNS+itrreltE7kfDhHWSW4f6ooABcJVB4kS86kxFvqq7I1sWi00AYPHUUdrsd8wkVVvizeGLTrp6z+LETk5C4bBcaMe4BVHBurHbvga1Wr9NZ2xy4lz1mD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782320582; c=relaxed/simple;
	bh=Z5gBa6Aq2lvBI+yCehmuGa6F+LMDN6+aSplP/hOqZ9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AptRwryoEYnGAg9EH9+fBgSVQhLb4Sa2KbXv7PN8JKazokZHcw3TdO01DoUEv17Kl8SFwpG4IZyX/vFAmS6D9nxwZRD23beJA0UGjwkn/kK7M9lQhv8JBgULWR9Dm6EVNW9GXAvEk+h+RVRnxfqj+5gXchQWN9iFtKe/RH7WEUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ym5w1go8; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ym5w1go8"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-139d5c9a495so1246127c88.0
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 10:03:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782320580; cv=none;
        d=google.com; s=arc-20240605;
        b=QbFSYCaMKOg9qlQ6BMlKedwR+Z76w7z9ALcg/aQAGa/4x2HGOUAySlsIIZmna1/wwI
         C4Yw5LU0Oa5jlFJbycg1QCytXw5Qu8Apl8MPyUIUlcLyFTzHH2lAMlrEuSwbFpbhUXEd
         Wc83yD0GQkdADk81ZXYt0UQjTCxcf+0o/DF/PExRhLFSTlXb+b/aojuzXDYsHZOa6J8w
         jUHP3TOtIuPkLe6CVkJ6pih/A8SkoGnQnkRpjOG0G7L4wQ2HmIkpDC2X8+WDW+E31LGp
         0Ord1I0UR8f/UzpS86s+hFuw8h7GKrptXywKwEyrbiwf4sgRP7ezBIYHWf0Ic6R+qrKR
         RTrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7Nhor4K6un2D5Eq3pEra7OxxpRCzcX2Ek4W8cQy9TaM=;
        fh=ebIcNbKB0JG2w4xMpvJpGPA+SNdk59nNNN0zMfEBs+0=;
        b=UQNSTOj8fNPGgEJW317Sl2BD6dk1swoysjz3OYb0sgBMeIOoYziw7J0IIUpNnn98ae
         nJlDKoVpWHJELBSi+vFbdMYxTC63BZv485U0qAqlaYA1+SLnW+IDWp+kWUlvAf8QVSk3
         kpktu2nYI2f/ASe7vCsAH4XI4ThCjr6W66d/J4DuggJXypAQiQ2ygpZREjkCOH1dlZWt
         a7EzcAJn5bxfCKLPm55k5WY6LbA7iNJRSqbsV5X4fBE0PgD6hkRZcnwFfz3M+Boanp1v
         u3Pg8PICw9315MgrUdAljyWZmHk8Gf+2UwIppscTVcO77To/r5ghYvK66EYa3CGz5UdF
         HDOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782320580; x=1782925380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Nhor4K6un2D5Eq3pEra7OxxpRCzcX2Ek4W8cQy9TaM=;
        b=Ym5w1go8lM7LdR1+dYp3gXG+j2joSz8IEIdbl24zv2MqE+q83bsRbman3okc2jXlip
         u0AXv9fp7zP7SOvkipd8M5/fct/Vfv4tLncWlLRO7meNLK49x2sCK+HEuC1C9dDhqYwO
         M0JwvDmOn0NmFboSsrxOcWKc11+fnaiMreV1S07gZCMr3rlnnQ4NWjP1SvsFBvvBAKqa
         nHXeEKAu8yuJN4AgplgEYjAT/bg3sfqyZPm+R0wVWyiKihWCbPv+TXAZFS2JfqREcfhJ
         lNw1eiXWxWDnh3xF6t5EfSMjtQRmSWi8ftPLVMsyxsrnCBPcVyDP7QT6b4CLcC4itHJ1
         LRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782320580; x=1782925380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7Nhor4K6un2D5Eq3pEra7OxxpRCzcX2Ek4W8cQy9TaM=;
        b=beYKcBE9yOgkmZIlykKXOe30spFh7tpjqzIEQEW3GA5AP1V7Y1P5U7PVnyEyybYhgG
         KTVSv8LyRqZGhiIEEeugKwvsGkzhm0wc7Ipl/K7tYCEosdNJv2tngbe5b4ZttK9ZiGTC
         4JX/MDaaCOtq+l3yRmtYvo612vizXnvRsL/VpBrOEEaIuFpt2B7DXAqTohnfr7pnFN/R
         U9AWiHKmnc4zcLPriGCw9N6E1hnBmac6pDMvDjxvkQOhgIJL0vnPX+vS9GBbPtxHqgnZ
         u/SkhgE+wIsYWLZbAWg4BUTiHz7jcueHX3gsHyhzZA4gAdg9SBtxEXGVkfYxrkQrmkkZ
         sc6w==
X-Gm-Message-State: AOJu0YxlfPlWe9Wcq4NCUM+TucJWmBYC+2HesSWoGFjd9MymPyju3adR
	y3R52hyvHQZ+FmMuLpt4IrgyzqMTUQuFpwZBPx1GkwPx1Bv1JAFnRhzsUhW3QX3V1Td21ZrxKxO
	Iy+Cq9N+HrsT7S3OXxAThuUgg4wDXSQc=
X-Gm-Gg: AfdE7cld3gLqnQyRQOOt0nltn3Ot7Rt719nj9tcKk+Ym1ak6/tLVP4DhoeEULZBhVgA
	Bg2YsBbF1D3tvtZYlDkroCnx4mE+DdU0mZyAz+SBK72eo9ornYKopg75J7UgY9fZCzZH7785y9R
	eqqp1gqn9gc0YG4OMd+JjM8q8X9pl4gRFtsZm/uXF8WQyyKepIBKnbfkRpAKOmmcO4cFvyTBtWQ
	JP1V28lOZZcZmoKn+lZe1RJovh0ewkd40YzZEz7O36kb0xfxfMEQJEbWgOrz3gu0Wk3kN8fftUg
	4JgwR2IaH6BJUu2eXd0BYUv2xCOpGM+iaxFMDzReY8MBPN1B0yYLqabS8A==
X-Received: by 2002:a05:7022:79d:b0:138:e4:c601 with SMTP id
 a92af1059eb24-139d0c816d7mr3335938c88.24.1782320579689; Wed, 24 Jun 2026
 10:02:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624-pks-connected-generic-promisor-checks-v2-0-132d73ee47b9@pks.im>
 <20260624-pks-connected-generic-promisor-checks-v2-2-132d73ee47b9@pks.im>
In-Reply-To: <20260624-pks-connected-generic-promisor-checks-v2-2-132d73ee47b9@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 24 Jun 2026 19:02:48 +0200
X-Gm-Features: AVVi8CcNLRB8pi4kVOfMLHo2pkAJ9I1mPShd1d9le1fEtxpvjaXfYhMfVRcDc6c
Message-ID: <CAP8UFD1sJNJbAAu9ZUanB8gJV-Vb64pLVkNULm3onSFZirdKxA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] odb/source-packed: support flags when iterating an
 object prefix
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 12:37=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> Callers of `odb_for_each_object()` can specify an optional object name
> prefix so that we only yield objects that match it. This is incompatible
> though with passing flags at the same time, as we don't yet know to
> handle them.
>
> Loosen this restriction by calling `should_exclude_pack()`.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb/source-packed.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/odb/source-packed.c b/odb/source-packed.c
> index 3afc4bf01f..6f31f0ff94 100644
> --- a/odb/source-packed.c
> +++ b/odb/source-packed.c
> @@ -148,6 +148,7 @@ static int for_each_prefixed_object_in_midx(
>         const struct odb_for_each_object_options *opts,
>         struct odb_source_packed_for_each_object_wrapper_data *data)
>  {
> +       bool pack_errors =3D false;
>         int ret;
>
>         for (; m; m =3D m->base_midx) {
> @@ -171,6 +172,20 @@ static int for_each_prefixed_object_in_midx(
>                         const struct object_id *current =3D NULL;
>                         struct object_id oid;
>
> +                       if (opts->flags) {
> +                               uint32_t pack_id =3D nth_midxed_pack_int_=
id(m, i);
> +                               struct packed_git *pack;
> +
> +                               if (prepare_midx_pack(m, pack_id)) {
> +                                       pack_errors =3D true;
> +                                       continue;
> +                               }
> +
> +                               pack =3D nth_midxed_pack(m, pack_id);
> +                               if (should_exclude_pack(pack, opts->flags=
))
> +                                       continue;
> +                       }
> +
>                         current =3D nth_midxed_object_oid(&oid, m, i);
>
>                         if (!match_hash(len, opts->prefix->hash, current-=
>hash))

It looks like this is:

                        if (!match_hash(len, opts->prefix->hash, current->h=
ash))
                                break;

and I wonder if the `if (opts->flags) { ... }` block would be better
after that prefix check rather than before it.

Putting it after the prefix check would make sure we don't continue
when the prefix doesn't match.
