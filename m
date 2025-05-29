Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B5E10785
	for <git@vger.kernel.org>; Thu, 29 May 2025 00:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748477756; cv=none; b=TgtPOZOKqZ/Lp7dNz9EU9hz52nPAuIT8BFren90YnDk1ovlgzMFUtdvl6qEFNVw2K7fvRqwtAVoL0kIMhG418ZeWP85LVly2ZeqTxbENXomwDz5xmaVeHKOX2C2T9fwkwj4JrpQOinMuQyfX21x9/UGiIX/v5emCmUTJJQQOcGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748477756; c=relaxed/simple;
	bh=oPyycXGwe09MyPgkRnS6HMVbmtezFeuKpuvZyWn7yE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SdU6ybyPCjsIauKqLAIgYefYgqR/YpkEo79vnK+FxwVxm7zi/cqW1R4zmyu8GgpVEpxoVL3aMwzJdk45gkw9zYJ/KRwEohyD4QUyd7dVgoC94NC0MfEGednv3hakzBZZwP1r9XljV5CK3ARBUjcjxiLKTFXDpxx/f01K0Cf8fAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OEmKc5za; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEmKc5za"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-85e46f5c50fso22132539f.3
        for <git@vger.kernel.org>; Wed, 28 May 2025 17:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748477754; x=1749082554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CW2eJLNTczwGB39W9KDKcTCVk2y/GDlooGQRZUVrWO4=;
        b=OEmKc5za+2zr4DHflwuP1m074j9RwOU+ARxZncASndMw4FsW56fUMpQLGIkvpy3Hzw
         WxI+YfpkbgWtOg52bZzsqZQxJrySMQGQWn1u2+h1GNF4HllUuYitz7wxlsMiYJrCMtwC
         bCWjlWPn8Wjno93csM1t04/Zive5Z53WnE8kPhTu7gd0sHtBtgU4NUJuqcCmq1J46Pzv
         UtF8vJtH5maI7K/C5EVE+Wx094Ax+gZEDlKGBtOacoaL95RP9TTO8HMelhJ9mm8Mt2S0
         WksZkKsqNYlRtCw+7RrO+QwUwDcikG/qbwC69hzhK4yNWmnbVTBJjbc0x/2iQGuZNGGo
         bu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748477754; x=1749082554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CW2eJLNTczwGB39W9KDKcTCVk2y/GDlooGQRZUVrWO4=;
        b=piUk8Ejmy9JzKpmwv/C35hz921tdhLPbXMO9SUhrOnjcJlc20juvp479P/T3ulApHW
         bFQhFD9dUFFiQFVvyhhyMA04iJfgV3XOtSnZIgii84klx6h/laCu56+zeJD43iOWMvY5
         gHv4sjs+MYm2e8Qb5aMdg7jzQIE9TWUlq2jMBSpw7H/C7Ns3I/kgYPj0z2L/Prk3saY5
         UeSq+/r296NiP0YiBZGYvL8dH6dtUbr24RRdcEQ6AHBRTDID2NJDCd/Dj5DbINGdL+o3
         sACYaw4lRq6TZhNWFRSn5qOkcc3RPLnVjfmhFjdEHxd4Q9gGtDD0+odO/mZeLQ5PQ3yH
         bHDQ==
X-Gm-Message-State: AOJu0YwveUKkPKgyoRMyjrAYlL4E30aUrA4rEYsVgSBwzsFZZuPXoEsi
	6AZpwO91w7oXuECsrI9f2gn80rFIgOSfrX/nXYg5iFDqmY9b3nrxiP0trpvm6DkADqJaIRzhVHP
	3fbnTeiyFt8liyC3G/xkfVuXHAfKomMpf9w==
X-Gm-Gg: ASbGncvz1Cs9xUEWBKkz1js3Wx1rZ7wCyTOkHnmuUhlsBb858Pn22qsshBIYI6xsKUg
	2HU+sdMnlcwkIp47VNj+VMNO8xwxY/97VoeBORNZbmeZcFUnubt31VmNwwLKysYL/dN5ZNwmHqV
	Qwzwfn2L5Kh++5rzA/IevPzl5AXjhJt7OPxvpTQzefiggS3uy0nD2vdvjJbNadEYwnepT5lHXE0
	046
X-Google-Smtp-Source: AGHT+IG0kVgZ7iVc187y50UVxFyIe/i8emZ7j5Ej9NMIKIEmhk/jdZ4AceCtDh6ZLxGOdhXPY7W0dgEo+CCK8EvdrCE=
X-Received: by 2002:a05:6602:3817:b0:864:4ab4:adf1 with SMTP id
 ca18e2360f4ac-86cbb8b6675mr1849385339f.13.1748477754252; Wed, 28 May 2025
 17:15:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1744413969.git.me@ttaylorr.com> <cover.1748473889.git.me@ttaylorr.com>
 <aDelMNw4AK0L9XHu@nand.local>
In-Reply-To: <aDelMNw4AK0L9XHu@nand.local>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 28 May 2025 17:15:43 -0700
X-Gm-Features: AX0GCFuPkuwKV7o5AnvAVfFG4AEclhKzmiweihgWD1hF0OIxrBnJxFHDYVCsI2s
Message-ID: <CABPp-BHv938Cn4LcwBDq=jZwrFuOGMJhAenUJiQ6JZNTMe4SUQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] repack: avoid MIDX'ing cruft pack(s) where possible
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 5:07=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Wed, May 28, 2025 at 07:20:07PM -0400, Taylor Blau wrote:
> > Range-diff against v3:
>
> Hmm. My tool for submitting patches botched the range-diff here. The
> correct range-diff is:
>
> 1:  986bef29b5 ! 1:  2753e29648 pack-objects: limit scope in 'add_object_=
entry_from_pack()'
>     @@ builtin/pack-objects.c: static int add_object_entry_from_pack(cons=
t struct objec
>         if (p) {
>      -          struct rev_info *revs =3D _data;
>                 struct object_info oi =3D OBJECT_INFO_INIT;
>     --
>     +
>                 oi.typep =3D &type;
>     -+
>     -           if (packed_object_info(the_repository, p, ofs, &oi) < 0) =
{
>     +@@ builtin/pack-objects.c: static int add_object_entry_from_pack(con=
st struct object_id *oid,
>                         die(_("could not get type of object %s in pack %s=
"),
>                             oid_to_hex(oid), p->pack_name);
>                 } else if (type =3D=3D OBJ_COMMIT) {
> 2:  6f8fe8a4e1 =3D 2:  32b49d9073 pack-objects: factor out handling '--st=
din-packs'
> 3:  2a235461a6 =3D 3:  a797ff3a83 pack-objects: declare 'rev_info' for '-=
-stdin-packs' earlier
> 4:  240e90b68d =3D 4:  29bf05633a pack-objects: perform name-hash travers=
al for unpacked objects
> 5:  9a18fa2e52 =3D 5:  0696fa1736 pack-objects: fix typo in 'show_object_=
pack_hint()'
> 6:  6c997853f1 =3D 6:  1cc45b4472 pack-objects: swap 'show_{object,commit=
}_pack_hint'
> 7:  0ff699f056 =3D 7:  3e3d929bd0 pack-objects: introduce '--stdin-packs=
=3Dfollow'
> 8:  58891101f3 ! 8:  52a069ef48 repack: exclude cruft pack(s) from the MI=
DX where possible
>     @@ Commit message
>          MIDX with '--write-midx' to ensure that the resulting MIDX was a=
lways
>          closed under reachability in order to generate reachability bitm=
aps.
>
>     -    Suppose (prior to this patch) you have a once-unreachable object=
 packed
>     -    in a cruft pack, which later on becomes reachable from one or mo=
re
>     -    objects in a geometrically repacked pack. That once-unreachable =
object
>     -    *won't* appear in the new pack, since the cruft pack was specifi=
ed as
>     -    neither included nor excluded to 'pack-objects --stdin-packs'. I=
f the
>     +    While the previous patch added the '--stdin-packs=3Dfollow' opti=
on to
>     +    pack-objects, it is not yet on by default. Given that, suppose y=
ou have
>     +    a once-unreachable object packed in a cruft pack, which later be=
comes
>     +    reachable from one or more objects in a geometrically repacked p=
ack.
>     +    That once-unreachable object *won't* appear in the new pack, sin=
ce the
>     +    cruft pack was not specified as included or excluded when the
>     +    geometrically repacked pack was created with 'pack-objects
>     +    --stdin-packs' (*not* '--stdin-packs=3Dfollow', which is not on)=
. If that
>          new pack is included in a MIDX without the cruft pack, then tryi=
ng to
>          generate bitmaps for that MIDX may fail. This happens when the b=
itmap
>          selection process picks one or more commits which reach the
>     -    once-unreachable objects, commit ddee3703b3 ensures that the MID=
X will
>     -    be closed under reachability. Without it, we would fail to gener=
ate a
>     -    MIDX bitmap.
>     +    once-unreachable objects.
>
>     +    To mitigate this failure mode, commit ddee3703b3 ensures that th=
e MIDX
>     +    will be closed under reachability by including cruft pack(s). If=
 cruft
>     +    pack(s) were not included, we would fail to generate a MIDX bitm=
ap. But
>          ddee3703b3 alludes to the fact that this is sub-optimal by sayin=
g
>
>              [...] it's desirable to avoid including cruft packs in the M=
IDX
>
> Thanks,
> Taylor

Thanks, this version addresses all the issues I brought up; this round
looks good to me.
