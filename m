Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D01B33E346
	for <git@vger.kernel.org>; Tue, 23 Jun 2026 07:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782200758; cv=pass; b=l0yBMyjRWA2YhX3o/cuq9KoOpEl5t3We6n15PF7SZ2EatUHtxcmI5fObDmDviXz/xKFtPZp6HBosEABkFX+yVkZhzrrTPSEgcAmW87amzd+RE3anPt2ohnmFyS4CDhEPLevHlVIQ9CloilDdZOijjZ01c94ih/b9CjRrLWmqvsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782200758; c=relaxed/simple;
	bh=r6/uaVOfm1XFUUY/imqzQVJ2PGVk0xGswiMyt8nwuLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eJKSiMylwbcIjdWf6viV3pvhQhfeK3yOTZLxJP6CPywCUMovVRCb8++G+ibbNZCJACbUZbgrLGsDWKofXH51Ni9Hcui9aoGglGtW7bQsMcxU/9re94pTNXHvoLy98pdW/GtyrruDaKcCGHXcGfe6nrIuYJPQX1IIKcrCspyou5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bv74Q9DN; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bv74Q9DN"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-13988680a69so12208474c88.0
        for <git@vger.kernel.org>; Tue, 23 Jun 2026 00:45:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782200756; cv=none;
        d=google.com; s=arc-20240605;
        b=LxC0aXGnko69ot/epldN7aLM4m0fARmrFJPJXcAB+Jxpzx2UuDmVQ/DhOs1kyCmQre
         2C/aqyB9nsQNP5TY+yMAEIHGsZtZXM332tQ2n74x/CXpBraix8TpKv0i4xiap4D8W+Sx
         1vCkNMzxroELvajr6IbSU0J6XOTlFe9Xfx1+/J6reDFmCscGvG34c4xUG+J8IgXDJYrO
         LBZ+neX7q+n7qsLt4iGR8N8CKtQCDVjfWbXAI4Pbe80+L4IwKS6i7ZYsT7PwTdrgjS4Q
         m1QxAb4nWUljjUxuWJjIHc9fPXAw03OnUUgDbEIes1tc1FvgxXljxulIvkJz6IGGAHOz
         ofhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SkaX833jn30Z9fwg8rx569NWwdQCG2ETNSyqxyOkuj0=;
        fh=4hRD6dug9K2dA8/Qy44rHfFMnlFofhUgf7dxeZXl9E8=;
        b=RXBlKoOXE2XsJUagZX6QTb9y+kPLFlSeX4NJb8ScsNB1fWg7+boIaSRcaCtVT8h+jo
         FNVVEZlUzJUdfUouyQ4XcDnHTTfXiiZfn/jWtHKNYzctXXn6tJry8oCLzKgVzlFTZxku
         epdunohplZbISb0yq25C2h8JhpWUqyHlyZ/Irx+uFdQW0zCdSvqFQ18nvqTL5MqBfHyc
         hupx0BM6nVDACK5NFEMiod7wVLib+jdRQ8892yk3org6LXMDNQJylDMTBE8y8qLBxEQ+
         E85qR9QiucCLXh9Nbub1ZuZyHeC6M7ZLUDdAndoQyZfBP+JV6Qdiazj4YVkbHkvKlG5/
         HDcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782200756; x=1782805556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkaX833jn30Z9fwg8rx569NWwdQCG2ETNSyqxyOkuj0=;
        b=bv74Q9DNF3jPI9bVB4tymKKNzh7jEyZNItshA7YbUuHbtGpdxoM7wOAIz42WmhDgHy
         LKqAY+rdEzv/DEppapEwCyQE65gipRg9qX/yu1WAGivy44nvv2ZGG4ZqiOvxVD72dotH
         NV/aVHQxWLHuRM92N7m85WH82xs2ixouI0eKrfmDuedWanyLJKFiK5kqKmv0I+wSjsWi
         X0st5aWSjs80gUI/Le49RKo8YAFf36YFI4tlXBpAl6wnZ9ML7h2NOFrlz2jPnmrA8G6r
         5hpTpp7uFqV4p5PPTGvUWgIDHnDub2jIEYxg9ImhS2N6lO+dzjP3PAk063sNB5uSABTn
         zalw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782200756; x=1782805556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SkaX833jn30Z9fwg8rx569NWwdQCG2ETNSyqxyOkuj0=;
        b=YO5VP3GldWSaAm54UXR7qwnc8yGOB1hVeWElDGIjhCgQxuzj/QbiBBvbLoSTLMdo3L
         KHCQ/rlRp/juUpne+jwSDWQq/sbe+CPblV/o7ZplcTO1TKx6ASEQXj4dzVVGDmaLYaHN
         bg2eVWufkEsrG2AlqeUrzRGmJXlCBECmfqe53Go/JRyIU3qXiHEfsAkS7YtP/FCcmVD5
         7Snk3+DeWFGwre88iGLLqc98/mCk3NICI6VLToJ55i4b6a1TvmqOsz1A+wJred8If+aO
         Rz3Cnr9+blYjfr8TQqNsRmdtOhRrPVyEkrcI/HWnUmY2djZtTpkucPCKGGbubvvSn0i5
         dZwQ==
X-Gm-Message-State: AOJu0YwvOlin4+rSPRRiPsTzz7M2v27s5iKlSQu4V2DFQmCTfsVpDJbI
	/x8ekYeAVruRczKwghX+j3QT/QHDaTxpRVfaGtNdu4w2lLFYq32YIlxa37rgeFJmmCcRuLgQq5i
	AcEclUwyAw69BVQQwIr36JcW4pFahGELxbH9O
X-Gm-Gg: AfdE7clKCCR8hwVwcoiKESDwjLzmc3hJnK/jJY/LQrpigL/3bmt4GsWGexOIIrl8c+9
	zyPAoiJGPlTvNbMK0ytp6UJLRlD+6QyiNiduwiDIqgI0zfl9q0P04W0jcCkdH7PMKI/VmOy+th1
	hPsudK7ZeAjg4tZW+XC33h544E+B+4ZEu9M86YoOHpTvGcveUxXH+93wYVfEAIktE/bZY8ZH7Hr
	K43ChL3D/WzWwXTKgrtLb616Nn/BdD3CbljdUScPLDa0xTKhGig5oWG+NP5y/7ZM73kCl7prOjZ
	x9fUnjHqJLSdJEygNsZhzEQwMHuQjzhywC1z1i6VUw0WFgcEv4h3yQVS/g==
X-Received: by 2002:a05:7022:326:b0:137:fad9:397c with SMTP id
 a92af1059eb24-139c6ef75femr1144350c88.12.1782200756204; Tue, 23 Jun 2026
 00:45:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622-pks-connected-generic-promisor-checks-v1-0-25eba2698202@pks.im>
 <20260622-pks-connected-generic-promisor-checks-v1-3-25eba2698202@pks.im>
In-Reply-To: <20260622-pks-connected-generic-promisor-checks-v1-3-25eba2698202@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 23 Jun 2026 09:45:44 +0200
X-Gm-Features: AVVi8CeJJGsPwtY3aarSR5MizeP9fU9FQ9h5MWfj5Jn4E78caI-ybmb1_LyeMo4
Message-ID: <CAP8UFD1tqBBRiJV18xBMcDDT4Q7xCkqOLrtJGAO7o4oA=-Vr=w@mail.gmail.com>
Subject: Re: [PATCH 3/3] connected: search promisor objects generically
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 10:50=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> When performing connectivity checks we have to figure out whether any of
> the new objects are promisor objects, as we cannot assume full
> connectivity if so.
>
> This check is performed by iterating through all packfiles in the
> repository and searching each of them for the given object. Of course,
> this mechanism is quite specific to implementation details of the object
> database, as we assume that it uses packfiles in the first place.
>
> Refactor the logic so that we instead use `odb_for_each_object_ext()`
> with an object prefix filter and the `ODB_FOR_EACH_OBJECT_PROMISOR_ONLY`
> flag. This will yield all objects that have the exact object name and
> that are part of a promisor pack in a generic way.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  connected.c | 39 +++++++++++++++++++++++++--------------
>  1 file changed, 25 insertions(+), 14 deletions(-)
>
> diff --git a/connected.c b/connected.c
> index 7e26976832..9a666f0cdf 100644
> --- a/connected.c
> +++ b/connected.c
> @@ -11,6 +11,13 @@
>  #include "packfile.h"
>  #include "promisor-remote.h"
>
> +static int promised_object_cb(const struct object_id *oid UNUSED,
> +                             struct object_info *oi UNUSED,
> +                             void *payload UNUSED)
> +{
> +       return 1;
> +}
> +
>  /*
>   * If we feed all the commits we want to verify to this command
>   *
> @@ -46,6 +53,11 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
>         }
>
>         if (repo_has_promisor_remote(the_repository)) {
> +               struct odb_for_each_object_options opts =3D {
> +                       .flags =3D ODB_FOR_EACH_OBJECT_PROMISOR_ONLY,
> +                       .prefix_hex_len =3D the_repository->hash_algo->he=
xsz,
> +               };
> +
>                 /*
>                  * For partial clones, we don't want to have to do a regu=
lar
>                  * connectivity check because we have to enumerate and ex=
clude
> @@ -54,31 +66,30 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
>                  * object is a promisor object. Instead, just make sure w=
e
>                  * received, in a promisor packfile, the objects pointed =
to by
>                  * each wanted ref.
> -                *
> -                * Before checking for promisor packs, be sure we have th=
e
> -                * latest pack-files loaded into memory.
>                  */
> -               odb_reprepare(the_repository->objects);

Like Junio, I am not sure it's correct to remove the
`odb_reprepare(the_repository->objects)` call.

I think it was added for good reasons in b739d971 (connected.c:
reprepare packs for corner cases, 2020-03-13) and I am not sure
odb_for_each_object_ext() is performing something similar.

At least the commit message should mention this change and explain a
bit why the reasons the call was added are not valid anymore.

>                 do {
> -                       struct packed_git *p;
> -
> -                       repo_for_each_pack(the_repository, p) {
> -                               if (!p->pack_promisor)
> -                                       continue;
> -                               if (find_pack_entry_one(oid, p))
> -                                       goto promisor_pack_found;
> +                       opts.prefix =3D oid;
> +
> +                       err =3D odb_for_each_object_ext(the_repository->o=
bjects,
> +                                                     NULL, promised_obje=
ct_cb,
> +                                                     NULL, &opts);
> +                       if (err < 0)
> +                               break;
> +                       if (err > 0) {
> +                               err =3D 0;
> +                               continue;
>                         }
> +
>                         /*
>                          * Fallback to rev-list with oid and the rest of =
the
>                          * object IDs provided by fn.
>                          */
>                         goto no_promisor_pack_found;
> -promisor_pack_found:
> -                       ;
>                 } while ((oid =3D fn(cb_data)) !=3D NULL);
> +
>                 if (opt->err_fd)
>                         close(opt->err_fd);
> -               return 0;
> +               return err;
>         }
>
>  no_promisor_pack_found:

These changes are difficult to understand as there are a number of
`goto`, `break`, `return`, etc involved.

I think it comes in the first place from check_connected() doing too
many things, and adding a preparatory commit to refactor it would
help.

For example the preparatory commit could move a lot of code from
check_connected() to the following new functions:

/*
 * Returns:
 *   1  =3D all wanted OIDs found in promisor packs: connected, done.
 *   0  =3D at least one OID not found: caller must fall back to rev-list.
 *  <0  =3D error.
 * On the fallback (0) return, *oid is left pointing at the first
 * not-found OID so the rev-list path can resume the iteration.
 */
static int check_connected_promisor(oid_iterate_fn fn, void *cb_data,
                                     const struct object_id **oid);

/*
 * In a non-promisor repo, pass the first OID as `oid`.
 * Otherwise pass the first not-found OID resumed from
 * check_connected_promisor() as `oid`.
 */
static int check_connected_rev_list(oid_iterate_fn fn, void *cb_data,
                                     struct check_connected_options *opt,
                                     const struct object_id *oid);
