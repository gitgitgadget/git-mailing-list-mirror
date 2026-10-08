Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1E149E5FB
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 12:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791464185; cv=pass; b=E6uExapSoQO8rDJ8caBuSZomAX6NJgN8KZgH3KDg7ZDkHvQON4y6tgVzLY/DMOw2cGMYvCsbawVwhlSMfgDrPEtzoWE7MCQkS64cV7+nPdz3d280B29kPdbV0cUBEP6kERxF60lF62ikosmlXXIGV3sqJbLKz9uDE4ZkLdzapPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791464185; c=relaxed/simple;
	bh=Vs8EGuI2P2uuMV0ttAt1L6iqs01zz6b4Ux4+bGDZE88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WDQHWUIZf61Vw/niKjEpnQ8x8WNAc+S/VuO6BibgmnpsOSbe3JgtyhbjbTiLFySGw0tQOCG/0uggdbgukgmm0fN/SxHrd3G3u7tE60kNOUHmZnr/ZzAuhvFoYOHWwedZJLTgVWQvSmOm0ol3fyTsWn3rN3mHYIyTUZYfjSdPmV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FG92o4xY; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FG92o4xY"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8875d220446so1553036b3a.3
        for <git@vger.kernel.org>; Thu, 08 Oct 2026 05:56:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791464183; cv=none;
        d=google.com; s=arc-20260327;
        b=lRjIzICpcURaV9wDDGipBDk4vBtZDCe1/+tqZ384yZayrjM304bhmZCpFN+SntDcYV
         6o40JwbPq+lNT1pl7G4uvuV6DZrsP8M0HrCGFFjelxSRKrcs0n4+GRAH1lXVVfALRVt3
         1WYMs86V4XQpifzgFaAxC4e/dBcYwYLvY5KsbFb3/pOxDzqZjxI8GaEAewlXwt7nQmGo
         5LCJkH5ERBuRS59y92tDiVeoe9Lo/WypXUTthEt9rHdGHf7nRThdeBFg7aGBSfPvUtSq
         frHJ60aYrWEBmjD7yy752pS6Or18zAqONiDzqRrjpNZPIqb/kOLgdaY8Feaf15Yl7Y+A
         u/Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qrg5rDyIfisk02lD3K77xusluohGNRXcpJwgDOCMjzI=;
        fh=Z4J1+AR61sp4gi0UHVqEqnniduPfCGneOHKt83rHMjo=;
        b=C4PrU1OlDAOmB2Yesf6P1RXBg5KvQHMBxF0lUPbJyFkt21XGEFbm6va+m8OTbZu3BA
         53il2+tmesp9f3AKg5dUipklnFZrRGNYgjuEApKQEVhbWIlUjZyH17Tqa8/BKcxBdDAw
         HMAg/zkVlAnG0Tsjh9nBBS5QmMHpTO9dqMz4tZD5vxrmaZarDPjSJBaCqgewyRdot+aX
         EjWmC4h94gzXsNFum/JE519DpJTKgPgX1dYXI6+gPIeNihRBDrToVY8RhckcSBeUdvEe
         prwgwXI2TnzmAjvLT3xDpAx0YxH8HINbVRavGHBDMIxg0NBrwO3oNnSalPniEJ8lnIiZ
         nrKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791464183; x=1792068983; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qrg5rDyIfisk02lD3K77xusluohGNRXcpJwgDOCMjzI=;
        b=FG92o4xY2M0WGGAeGGuGD5UZc4rlIMz5sLEgXpxjV6rDMlGv1MwQ44+zfgJkpIX2UJ
         pizdaoccPymW93oTBskLnWmzceWSueOWLYIKvIJNbY0BXW9/DCE/t8ay7bsUFlxfCgmH
         nxWZrw3kZvp5mIYeX13GtRCAY45sx2O3PPt8dnwBwALRzX1ap3fi81pRWqFzOiAUPTlt
         iwo/6UQFpsr4TlXnbkO24SdjzI2qA8R3DxtrCGq3Uqd9bKnmFBdi2Rcz7OqJqV5pZy9O
         JYpZW6DGKqgwQCfJt7gHRWIZs5jWaUoAy6OypuszKiFH8+jyVk6DDJlYWEw2Ah2YhhIc
         gaCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791464183; x=1792068983;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qrg5rDyIfisk02lD3K77xusluohGNRXcpJwgDOCMjzI=;
        b=cgoyOISN/kYRe5Cxgwp1kEgtX447yadgdmBD4xQ6HlpBfu7PfP5tkrfb8ZGYqzBM3o
         AFYjktYhr1rhOxholXzrEWfGEkgzggunyuudQUuS858SVdvrmxvm+CTOuT0eF2g4rjvq
         /Y5AmiWHc4ahHLQ4wK1xY+azLhFQAoaPbKJsMK/MpmNZEAt9MtSiwdyGICxLYZkGZPk2
         wU9ct6v5Gt4XSuRNerM4nBx1GUJdLFIBhig1an/zZocFT5QcHLsy+zI6tl8kBo9Z7diK
         /9TlWHJwApYs//CmJpV/0vVCcVYPJ3O7DMsHQ+Xw9gxK/MJtwE3u8zLK/dlO6UlxxVgy
         MT5A==
X-Gm-Message-State: AFq9FYL2r33dyVpHplgQbxSExWP4VhgVY32apUXVMrrfmn3U2dLZX+SI
	Od0TPLKcnUP3N6PjkrMW8hFs1BYa0d98C+UmhZ4XY7ux1yBRk/6ZH1bhx2H5DQy4sUj2XKW+pIO
	LrJpDNMqhviJmInwfi6oeQBNbaqVHg8s=
X-Gm-Gg: AYBFou1iHPneoW2++T2h9ClY+g9poTuRvlMVI0a+M2LztMfrTT1x33K5Ky5EWu+MaII
	tDUP5HGX4blj0f785dxSkmiP5yQc3aPb+TbAe9MMY2+QGIqIXHIcRfFn50xTTaRVLqWAkXY7X/N
	zqydvyzP7fthLrwqH6g/+hpei+/egaTu4LGHWm16+aQSJIL/+G4DKaB8NXaKHIA9RkZN0YGwwKF
	eqAjNRofPeF1jSb99zn6FnDe5RIxM4wu5Iz8gxGIfcIMIr++MgiDHHyx4ecCG0g8F1v/GAE6fRf
	UQTikuwmcbfx0fKex19j8X71kdqKD64WgWUFb+rI8N9PvRfZs1z3BGgVJWveSr+1qqSwWprOh1o
	X50MPEq3wzKmgxWrI2HakOWiy4wmhJejsyAv6r5HHhIfNqut/miGUQTd9rTF4wYEC8URD217cVE
	CTOvngLvZ6WqJTjZ/kIQ==
X-Received: by 2002:a05:6a00:331b:b0:893:32df:ebe6 with SMTP id
 d2e1a72fcca58-89332dff690mr1585828b3a.23.1791464183363; Thu, 08 Oct 2026
 05:56:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008062521.25505-1-r.siddharth.shrimali@gmail.com>
In-Reply-To: <20261008062521.25505-1-r.siddharth.shrimali@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 8 Oct 2026 08:56:12 -0400
X-Gm-Features: AclHuK9yZ-9bON4QWwJCLOxJ5NucP27aMaUNiy4uG5bksXF6aEVrTuWkXxps0LU
Message-ID: <CALnO6CD9roPhKsYRVXRuZXQckTmbCskKmvxiUyxp6vkJ03S8rQ@mail.gmail.com>
Subject: Re: [PATCH] repack: do not rebuild packs on --dry-run
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org, coygeek@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Siddharth,

On Thu, Oct 8, 2026 at 2:25=E2=80=AFAM Siddharth Shrimali
<r.siddharth.shrimali@gmail.com> wrote:
>
> "git repack --drop-filtered --dry-run" is documented to list the
> objects that would be dropped "without rebuilding any pack or
> deleting anything", but it does both.
>
> This is a bug in cmd_repack(): after printing the candidates, the
> --dry-run block falls through into the regular repack code.
> repack_promisor_objects() writes a new promisor pack, and with -d,
> existing_packs_remove_redundant() deletes the old packs. The command
> still exits successfully, so the user is not told that the repository
> was modified.
>
> The existing guard only skips the implied "delete_redundant =3D 1", so
> it does not stop an explicit -d, nor the new pack from being written.
>
> Fix it by returning right after the candidates are listed, and add a
> test that checks the pack directory is unchanged with and without -d.

Makes sense

> Reported-by: Coy Geek <coygeek@gmail.com>
> Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
> ---
> Bug report:
> https://lore.kernel.org/git/CACgTecOm+=3Dvbf50tZNXhcYvRi1ZTsQwbjVoJAbQqs2=
CmXdJCxg@mail.gmail.com/
>
>  builtin/repack.c                |  8 ++++++++
>  t/t7706-repack-drop-filtered.sh | 19 +++++++++++++++++++
>  2 files changed, 27 insertions(+)
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index c4360382c1..c048053912 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -391,6 +391,14 @@ int cmd_repack(int argc,
>                         oidset_iter_init(&drop_oids, &iter);
>                         while ((oid =3D oidset_iter_next(&iter)))
>                                 printf("%s\n", oid_to_hex(oid));

Just outside the patch context is the "if (dry_run)" conditional, so
this is the right place. (In this case, formatting with a larger "-U"
value might help.)

> +
> +                       /*
> +                        * add an exit here, so that dry run does not
> +                        * go on to rebuild any pack or delete anything, =
even
> +                        * if the user explicitly asked for -d
> +                        */

2 notes:

1. "add an exit" will stop making sense as soon as the patch becomes a
commit; that is, it only makes sense in the context of proposed
changes. Once those changes are part of the code base, the comment and
code are not adding anything. They simply are. So, if we need a
comment (see 2), it might be best phrased as "exit here so that [=E2=80=A6]=
",
keeping some of your original wording. Or we could be more terse:
"skip non-dry-run operations" or something.
2. Do we need such a comment, I wonder? git-blame will point folks
towards this commit :)

> +                       ret =3D 0;
> +                       goto cleanup;

This matches the pattern elsewhere in this procedure, so that looks good.

>                 }
>         }
>
> diff --git a/t/t7706-repack-drop-filtered.sh b/t/t7706-repack-drop-filter=
ed.sh
> index cb36115834..a1c475e4ec 100755
> --- a/t/t7706-repack-drop-filtered.sh
> +++ b/t/t7706-repack-drop-filtered.sh
> @@ -135,6 +135,25 @@ test_expect_success '--dry-run does not remove the f=
iltered objects' '
>         git -C repo cat-file -e "$BIG"
>  '
>
> +test_expect_success '--dry-run leaves the pack directory untouched' '
> +       BIG=3D$(cat big_oid) &&
> +       packdir=3Drepo/.git/objects/pack &&
> +
> +       for opt in "" -d
> +       do
> +               ls $packdir >before &&
> +
> +               git -C repo -c repack.writeBitmaps=3Dfalse \
> +                       repack --drop-filtered --filter=3Dblob:limit=3D1k=
 \
> +                       --dry-run -a $opt >out &&
> +
> +               ls $packdir >after &&
> +               test_cmp before after &&
> +               test_grep "$BIG" out &&
> +               git -C repo cat-file -e "$BIG" || return 1
> +       done
> +'
> +
>  test_expect_success '--drop-filtered removes the promisor blob locally' =
'
>         BIG=3D$(cat big_oid) &&
>         SMALL=3D$(cat small_oid) &&
> --
> 2.56.0

Thanks for adding a test to cover this. It looks reasonable to me, but
I didn't study the surrounding tests to think very critically about
it.

--=20
D. Ben Knoble
