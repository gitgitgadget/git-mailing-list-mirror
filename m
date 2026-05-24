Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AD21DFFD
	for <git@vger.kernel.org>; Sun, 24 May 2026 13:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779627912; cv=pass; b=hilzkkzRfT++zCatVUaD9X7NAv5sumtVDaSN5RLZFH/3oQ6mcu+YCWHpAl0tRl6vuY2iGyujVScbF+FoSg1wqsWmS/225rqY7N0RtiUMurKxro2obLDF90AtKI/U/bfko4rE32eo0ZZaTVCAo7YgraCHnpPU8eq3r/S0SiLKgco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779627912; c=relaxed/simple;
	bh=ESVcasOeRvr+qMT1iNmOG2O2ywumWhui0KCO46r5Oz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ExhasqxsXHLeKegxFzyHk6YDUFvzhK8Gui8MV1XQlLekPnZpUx4ERDevq7mRhOqM63ZI7/KrpKwRur16ooBE06c2i8FmpkbnsA37oEtflmtjJu4AEIYFilgu7zxkMTAempnC/4FpZTBx+iwj3yevJ0j9k4OehCPfsyd5yevqeh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=bXPGlROh; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="bXPGlROh"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7bd65714dcaso86292867b3.3
        for <git@vger.kernel.org>; Sun, 24 May 2026 06:05:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779627909; cv=none;
        d=google.com; s=arc-20240605;
        b=cn68fdi1c05ZB8aHJalfixKbUsjb0jd7283gYZgzpt1/3Y8gVx17fycjzKGLx+sZ35
         W2x4siiHMWL5R8GJ8Lhcao+XqMikHGaCxezXzhQWrAmt2NPpwZ6u2osgUtah8JgNu3/g
         De6kuPvOM7/lUPOi9EiMmCthR/wHbS+WM4GUhuzsAQibJnS7iJl0Su+BMe3O0LEvsLBv
         SkDjrvOy9I57DFg/72nfYoPGU6D2xv0MSyhU9heBpsbi8V2uF95DPs00g11VfkjjuSfL
         sQf0c73lSze2We5lvw5YXEu9n3oySM5reUn9s4kObekXndFv3deVWd/HpCeAS92/XsjR
         yuDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FROtN96Iosb2qd2uqwVHijbdMx2YPwP/jzZBcQSMLag=;
        fh=xVfeUGQU9wchXVAQQFvL97NUfYmzdzCSDcc/rBcymtA=;
        b=VksK+xJVbqb1E+xKuwdjF5q0Ul1KNJTHtn8m76KvQYlRDyw9cp41z2wZcfPubM7Vv+
         E8zHB08HsDv55mnJg0wTN7m4cEDX66oFckoIDZtX+ii4HRX6gCG+kDLi8uNe1SjMQWMD
         iICy42sd0BUnhH4rX0qBiTXLUnEl6yXGnSq93K4TfRqtxrqgTdx8ho897bW1QCdvnb1q
         IWOlR0uMck4v0RDO75CzF9Npuqg0nRm4Vv0rRLmlp7w2cxCJUXzaBpNDEwpQtlsG3wCS
         C4UZM6vaQkjXTd0EuIS2HrYIy9BXwUcYlVB8rNBCZXZ8XYCaz9Tj8pg0u6HkRKiC9Tqr
         08Jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1779627909; x=1780232709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FROtN96Iosb2qd2uqwVHijbdMx2YPwP/jzZBcQSMLag=;
        b=bXPGlROh0yN5miHA3RtzhbFtIQnWaLmta61lvtejqRn2eiktyMV2yOCrej3jdlFxtd
         X3TQLOVQBFiw1s0SDGfGJjnRpxk3sFiSOJHHG2XnJLWrle9CG06B0tAkjTTMSxYx0Rzj
         2vCsbC351ppq3+mg/bWxpZoUdfdxFmx6HGbbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779627909; x=1780232709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FROtN96Iosb2qd2uqwVHijbdMx2YPwP/jzZBcQSMLag=;
        b=VaE/N4y6hvqiGunBjFXM522YOtgUEod/wMmwqFSMt6Fo5u8RRp6r/vwJvdvKDG/ay2
         SG6fEw3s+b7ceeqda79iK+KcTAYAUWOK8KAl0X9BGqxLOsAWr/CcZ3/YD7VDsQeMvB5V
         G5VNBgdCSF7bWdM+Dzx4Yn/iYqWNFRXAlML/7DOJbAUK7LbvppbJxd492CPREi/+99IX
         7hWNYAEcgI99DxwFaxpXrZi8EV9Q3YhJJbBFhjuf4Kh6FtdABaUe/BGWhNYEk3nKLVCW
         8Vy7hCZ6NVKugqIxezZswdA/atRLBAWh3U8i1MndS9ajWnG1yPynpCtOMgXTM4D0xQDJ
         yZig==
X-Forwarded-Encrypted: i=1; AFNElJ8w+bYpSOc12WJ+9Glx0XKGLffh4G4qxv0jwhAO67npEBKbgG8H0bAiwcWksPQDlK/Gm1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvKwKHvecE3Keb1u6O8mdFZeqiMSm28HMZJjNx+hmgzdvqUSzk
	YB1PEmDss8fcQSyWnPL5DKbpaY5FAuUwJ7YpanCvqJQ5F2EWzN3uaiAjVH/txHixxNinyAoHuGG
	T8M92buZqlqVhx7WBMN8Z07hw5oiKmASR/2RhWrri1Q==
X-Gm-Gg: Acq92OFTF8QdAtBVCi5weTeHz9Ux0aDf1CmwyjYnK11EAdfuAdojzboNGoF6hVhgxzB
	TTXCQjU7maEB7CUugkdDclwwVhPkK79Fxx6Vw5X0lkRwuUHRA2QgOvvNzjUF5T09/MZfWEFC202
	yZB08CEoPQoQaIiN4f+ZoVPcHVqWzHHaN4JCnnOzyYl/xdcoEyZn8ZFWGU6XxJF5jys2kz0lEdb
	/BBcppgBY7l4JBECxAI/CekFzRweT99B7BEbl5RzOqgAJ2OaVZGfHK3Pg4xh5Z2dZMiZ0w3DLA2
	fL9kKR3n
X-Received: by 2002:a05:690c:48c7:b0:7bd:a6ea:c4d4 with SMTP id
 00721157ae682-7d3367b4fffmr116870047b3.44.1779627908673; Sun, 24 May 2026
 06:05:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2123.git.1779625693328.gitgitgadget@gmail.com> <xmqq4ijxhst9.fsf@gitster.g>
In-Reply-To: <xmqq4ijxhst9.fsf@gitster.g>
From: Kristofer Karlsson <krka@spotify.com>
Date: Sun, 24 May 2026 15:04:57 +0200
X-Gm-Features: AVHnY4KrinKQUR0RPNR4BoX8wLY8AztXo3Z0Wyo5XWrqzWAa0X21aJ9ron5IHq0
Message-ID: <CAL71e4Oct7SHEi+=Xx8Q9LxrRKXi_oov=wm86VyWwioyNCGoaA@mail.gmail.com>
Subject: Re: [PATCH] fetch: pass transport to post-fetch connectivity check
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Good catch! After finding this case, I looked into the other related
call sites but found that they are already correct as-is:
- builtin/clone.c - already passes opt.transport (this is where I
copied it from)
- builtin/receive-pack.c (3 calls) - no transport object available to propa=
gate
- fetch-pack.c - only used for the --deepen path, which sets
connectivity_checked when it passes,
  so the store_updated_refs() check is skipped entirely and transport
is not needed
- bundle.c - no need for transport

I am not 100% sure, but I suppose it's always possible to follow up
with more reuse of this later.

- Kristofer

On Sun, 24 May 2026 at 14:53, Junio C Hamano <gitster@pobox.com> wrote:
>
> "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Kristofer Karlsson <krka@spotify.com>
> >
> > When fetching with a transport that sets `self_contained_and_connected`
> > (as index-pack does for self-contained packs), check_connected() can
> > use find_pack_entry_one() to skip connectivity verification for refs
> > whose objects exist in the new pack. This avoids sending those OIDs to
> > the rev-list child process.
> >
> > However, store_updated_refs() never passed the transport to
> > check_connected(), so opt.transport was always NULL and this
> > optimization was dead code for post-fetch connectivity checks.
> >
> > Thread the transport parameter through store_updated_refs() and set
> > opt.transport so that check_connected() can take advantage of
> > self-contained packs.
> >
> > On a large repository (2.4M commits, 374K files, 10.9K local refs),
> > fetching 200 new commits:
> >
> >   Before: rev-list connectivity check  22s,  total fetch  36s
> >   After:  rev-list connectivity check   5s,  total fetch  14s
> >
> > The remaining 5s is spent verifying refs not contained in the new pack.
>
> Impressive.
>
> The check_connected() function itself is a battle tested helper
> function, with the optimization that originates in c6807a40 (clone:
> open a shortcut for connectivity check, 2013-05-26), and then
> polished in 26b974b3 (check_connected(): delay opening new_pack,
> 2026-03-05), allowing available "transport" to be taken into account
> does make very good sense.
>
> The other call to check_connected() that appear in builtin/fetch.c
> does not pass opt.transport, either, but this one checks before we
> even fetch any packs over any transport, so a tweak similar to this
> patch would not help that code path, I guess.  In fact, many calls
> to check_connected() elsewhere use opt that is often local to the
> scope, that do not have transport at all.  I wonder if there are
> some of them that benefit from a similar tweak?
>
> Thanks.
>
>
> >
> > Signed-off-by: Kristofer Karlsson <krka@spotify.com>
> > ---
> >     fetch: pass transport to post-fetch connectivity check
> >
> >     We're working on reducing git fetch times on a large monorepo (2.4M
> >     commits, 374K files, 10.9K local refs). Profiling showed the post-f=
etch
> >     connectivity check (rev-list --objects --stdin --not --all) dominat=
ing
> >     wall time when there are new objects.
> >
> >     While investigating, I noticed that check_connected() already has a=
 fast
> >     path for self-contained packs =E2=80=94 it uses find_pack_entry_one=
() to skip
> >     refs whose objects are in the new pack. builtin/clone.c passes the
> >     transport to enable this, but store_updated_refs() in builtin/fetch=
.c
> >     does not, making the optimization dead code for fetches.
> >
> >     The fix is a three-line change to thread the transport through.
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2123%=
2Fspkrka%2Ffetch-transport-fix-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2123/spk=
rka/fetch-transport-fix-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/2123
> >
> >  builtin/fetch.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/builtin/fetch.c b/builtin/fetch.c
> > index a22c319467..647fd1c30c 100644
> > --- a/builtin/fetch.c
> > +++ b/builtin/fetch.c
> > @@ -1213,6 +1213,7 @@ N_("it took %.2f seconds to check forced updates;=
 you can use\n"
> >     "to avoid this check\n");
> >
> >  static int store_updated_refs(struct display_state *display_state,
> > +                           struct transport *transport,
> >                             int connectivity_checked,
> >                             struct ref_transaction *transaction, struct=
 ref *ref_map,
> >                             struct fetch_head *fetch_head,
> > @@ -1228,6 +1229,7 @@ static int store_updated_refs(struct display_stat=
e *display_state,
> >       if (!connectivity_checked) {
> >               struct check_connected_options opt =3D CHECK_CONNECTED_IN=
IT;
> >
> > +             opt.transport =3D transport;
> >               opt.exclude_hidden_refs_section =3D "fetch";
> >               rm =3D ref_map;
> >               if (check_connected(iterate_ref_map, &rm, &opt)) {
> > @@ -1432,7 +1434,7 @@ static int fetch_and_consume_refs(struct display_=
state *display_state,
> >       }
> >
> >       trace2_region_enter("fetch", "consume_refs", the_repository);
> > -     ret =3D store_updated_refs(display_state, connectivity_checked,
> > +     ret =3D store_updated_refs(display_state, transport, connectivity=
_checked,
> >                                transaction, ref_map, fetch_head, config=
,
> >                                display_array);
> >       trace2_region_leave("fetch", "consume_refs", the_repository);
> >
> > base-commit: 6a4418c36d6bad69a599044b3cf49dcbd049cb45
