Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E7F2AEF5
	for <git@vger.kernel.org>; Sat, 10 Oct 2026 21:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791666393; cv=none; b=VFkS0Tb4UJS0Ln8HdE4EfB83IOZdjbI1AVUC7vrZw00b20ADYvey1vAkymrs7jjiMvTZ6n+uocSjX6lFVkIfNvYRQNb7BKKAGU8VeIoH4L+GwRIK2i4Jx8Q0E7pHq2TletUl9Sbestt4U4d28yY16HFj4ci/UkI6Ta0GMz9nj70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791666393; c=relaxed/simple;
	bh=2i7K5r9B8EQfkSl/c7mwpaL+x6N9z/B7x4GBia+o1Uc=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=EOOKqXbSow46eDox2O6UnQPNaLR0i12vmtOb6i7qKsniw3OAp7wf4tRSBE60mYdbalQfGkii12kR6FCcF2u8BVPDN5zmV5E7phPhNnQMpPzWo7J3GezPFN9PnxszlDMKpAkf++wQPdnE910/YMYzIzqBCM7ImjBavGF+iFdO8Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDbCMBWY; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDbCMBWY"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-885cf67963eso4838787b3.0
        for <git@vger.kernel.org>; Sat, 10 Oct 2026 14:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791666391; x=1792271191; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=trVBGo5hIrK7kNYeeeeBswN3YD0tt6D+CETrQNqApWI=;
        b=cDbCMBWYfCbF+xjupyYhF2/AbQ2KdScsaSKzx49fFndsx4xBq+QzFVCXOSLtsdnxXQ
         LXTMRwxCP03/TJB1F8G0gNlglLdNfq5qLNwlp3+kQ6Fhso6lxGGlJXd4h7tRzn0eON3k
         kcODP6S6SIe61VitEZ5/Ws9vrWWZtWdEd7a2THlOItUs3lkUr6uGmMh+nKacuv8y9yOy
         /0vrdAdS97eEjg+0XNcJ5BLLmoCHW8bj+FeLGt/SCFZPNTgvl1LG9Yn6R9acB2g1OFye
         4DgZEx4LUxtl0goiEkM3k2Udnt2T0UI+hfkSC6UYFUrE+VJw6RBBV3HaksNZiBfBI9av
         REgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791666391; x=1792271191;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=trVBGo5hIrK7kNYeeeeBswN3YD0tt6D+CETrQNqApWI=;
        b=aSwvJ5f4dklgB/+iwYGDY7v2AGuADNT02Lli1r4EQlqQ0cxBkjNEBkJW+xbq6Y67ii
         t0Sw79LlEST7uCRWkuLbR3pZm9RNvdZMgWr2dYW+gJmkaDaetfFWqvzkZcmFTXFQjbUj
         jZ91egtsYhZMRosRpIjo9W9zMzVx2aYZfiLpg0zfpVecUP2G6Ub7AObc07Cn2KUPHHOC
         TMf+G/Odza7BPtv+P0ew3XXj6yOipx8n9Xwxu6PDt3nz099I7e5OAsS2V5OueAvXznz1
         FlDvEfxhO9AqH5249Z4fFAdK19gfY2HrGMZIlemSnXA4m1BnfD0Jw8I1yDOnjxMkylmM
         OTKQ==
X-Gm-Message-State: AFq9FYKTqudQoBxbj/gQUsQNpW1GfjdZfLE5f6UPe2DYFodg2vlFLjSk
	ItzeWBto5NBdzwpIbX5VnozDBoAoO16Wju8UVxbJOq0WwvBO665o8U82Qyv84kmL
X-Gm-Gg: AYBFou1i+Cs64vP7Rgw7nDMe3mjUGbjdvSoGc+v0vytMZBe9UtsYOmCY8WG8wvdpKAt
	dCeONbkBC0djYy6hLDbbe8qsnRhkpu15ypz5aKMdTF1GJjbG8h32lfmUEuBdHvGGgCbGjDQ8+b5
	DsyOsrMP+6NNQa2LGNQzxKKOdZy89sywjlD0rMJAT3pjHKvlkrSDC3AgtpLfXLhhU8Iu9cOyr2l
	LzKb+1aNr0SQ1FsYFW+qykNowyCwP6ny6wA2+HA9b8Jyo7Eg3ust3DfKvKeukRAfWPMlyDDZdEV
	2oPIErbPaRAU7I3Ws8qDmLuwD+j1Z+KBCMyhKFPjWh4mFM+xqSj6nwlNofoJo3J95dfopvtuK1M
	CrtRKFmZ0ROA9pt3JkDDJUHUUBja79gLt4qzPIw6suxZAD5hhQqWRpWslcypGhEcAIGamzEEgT6
	GBmiUdc83LA/7GBhdi1iVTegebtsdJnWOvLIhYZJeiqBD23bwkzchKAVAuJYXh5WkpOvtDaXT0f
	1yFWX6BkMCMdHtykK4LQ9pSgrHf89/xIUKRygNGKWmrfHOifM69BDhRt6VHJgCkNgSZCisHaI1O
	599xxL/R8On08pe07orHVpGiPqE8RzWWImORGnmXK5FdS3ku2dV1TkDnWqA=
X-Received: by 2002:a05:690c:4f08:b0:890:c0ab:2303 with SMTP id 00721157ae682-8b07edb1fb5mr16406347b3.21.1791666390741;
        Sat, 10 Oct 2026 14:06:30 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9092:700:9449:280b:191b:a3dc])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b07f28058dsm20425137b3.48.2026.10.10.14.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 14:06:29 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] repack: do not rebuild packs on --dry-run
Date: Sat, 10 Oct 2026 17:06:18 -0400
Message-Id: <BBCEC2F7-CA8A-4460-8A4F-D8305D3E9134@gmail.com>
References: <20261010210050.76064-1-r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org, coygeek@gmail.com, gitster@pobox.com,
 r.siddharth.shrimali@gmail.com
In-Reply-To: <20261010210050.76064-1-r.siddharth.shrimali@gmail.com>
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
X-Mailer: iPhone Mail (23D8133)


> Le 10 oct. 2026 =C3=A0 17:01, Siddharth Shrimali <r.siddharth.shrimali@gma=
il.com> a =C3=A9crit :
>=20
> =EF=BB=BF"git repack --drop-filtered --dry-run" is documented to list the
> objects that would be dropped "without rebuilding any pack or
> deleting anything", but it does both.
>=20
> This is a bug in cmd_repack(): after printing the candidates, the
> --dry-run block falls through into the regular repack code.
> repack_promisor_objects() writes a new promisor pack, and with -d,
> existing_packs_remove_redundant() deletes the old packs.
>=20
> The existing guard only skips the implied "delete_redundant =3D 1", so
> it does not stop an explicit -d, and it does not stop the new pack
> from being written either.
>=20
> This has been broken since --dry-run was introduced in 1e746b00aa
> (builtin/repack: add --drop-filtered and --dry-run options). The
> --dry-run block never returned early, so a dry run has always gone
> on to do a regular repack. It was not broken by a later change.
>=20
> Fix it by returning right after the candidates are listed, and add a
> test that checks the pack directory is unchanged with and without -d.
>=20
> Reported-by: Coy Geek <coygeek@gmail.com>
> Helped-by: D. Ben Knoble <ben.knoble@gmail.com>
> Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
> ---
> Bug report:
> https://lore.kernel.org/git/CACgTecOm+=3Dvbf50tZNXhcYvRi1ZTsQwbjVoJAbQqs2C=
mXdJCxg@mail.gmail.com/
>=20
> Changes since v1:
> - reworded the comment
> - documented the bug in the log message

Thanks, I=E2=80=99m happy with this version. You may add my Reviewed-by, if y=
ou like

> builtin/repack.c                |  7 +++++++
> t/t7706-repack-drop-filtered.sh | 19 +++++++++++++++++++
> 2 files changed, 26 insertions(+)
>=20
> diff --git a/builtin/repack.c b/builtin/repack.c
> index c4360382c1..7797972642 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -387,14 +387,21 @@ int cmd_repack(int argc,
>        if (dry_run) {
>            struct oidset_iter iter;
>            const struct object_id *oid;
>=20
>            oidset_iter_init(&drop_oids, &iter);
>            while ((oid =3D oidset_iter_next(&iter)))
>                printf("%s\n", oid_to_hex(oid));
> +
> +            /*
> +             * Only list the candidates to be dropped; skip
> +             * the actual repack
> +             */
> +            ret =3D 0;
> +            goto cleanup;
>        }
>    }
>=20
>    if (delete_redundant && repo->repository_format_precious_objects)
>        die(_("cannot delete packs in a precious-objects repo"));
>=20
>    die_for_incompatible_opt3(unpack_unreachable || (pack_everything & LOOS=
EN_UNREACHABLE), "-A",
> diff --git a/t/t7706-repack-drop-filtered.sh b/t/t7706-repack-drop-filtere=
d.sh
> index cb36115834..a1c475e4ec 100755
> --- a/t/t7706-repack-drop-filtered.sh
> +++ b/t/t7706-repack-drop-filtered.sh
> @@ -131,14 +131,33 @@ test_expect_success '--dry-run does not remove the f=
iltered objects' '
>    git -C repo -c repack.writeBitmaps=3Dfalse \
>        repack --drop-filtered --filter=3Dblob:limit=3D1k --dry-run -a >out=
 &&
>=20
>    # Candidate blob must still be present after a dry run.
>    git -C repo cat-file -e "$BIG"
> '
>=20
> +test_expect_success '--dry-run leaves the pack directory untouched' '
> +    BIG=3D$(cat big_oid) &&
> +    packdir=3Drepo/.git/objects/pack &&
> +
> +    for opt in "" -d
> +    do
> +        ls $packdir >before &&
> +
> +        git -C repo -c repack.writeBitmaps=3Dfalse \
> +            repack --drop-filtered --filter=3Dblob:limit=3D1k \
> +            --dry-run -a $opt >out &&
> +
> +        ls $packdir >after &&
> +        test_cmp before after &&
> +        test_grep "$BIG" out &&
> +        git -C repo cat-file -e "$BIG" || return 1
> +    done
> +'
> +
> test_expect_success '--drop-filtered removes the promisor blob locally' '
>    BIG=3D$(cat big_oid) &&
>    SMALL=3D$(cat small_oid) &&
>=20
>    git -C repo -c repack.writeBitmaps=3Dfalse \
>        repack --drop-filtered --filter=3Dblob:limit=3D1k -a &&
>=20
> --
> 2.56.0
>=20
