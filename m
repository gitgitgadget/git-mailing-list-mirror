Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B2525EF87
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 22:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776379906; cv=pass; b=Ww2DsGjGl7gDtLd0/Zzy7oJgOads7AkHEhN0NAZ2ikhOBpXba2BS815ScTT88fRFLWgJwYQWWlvfv7wIcHpF+ZikVAMX85c8ivoBUU0zdHZkMw9w864v9XEnT1AxepS9c2XsqiV9M8hLtYtyKbRtsQtiOQyr+WObSBXlIoFbAwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776379906; c=relaxed/simple;
	bh=DtLFwBjMYZL6OG2SU7k15oLi2DuNcPVNGGjB9aVDMZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d3MJ0ruuPETPlgjtOWsotawBVpoGtFfEnIU55J6wNJiqvkKOQbcMPR/d0GLQ2GfFps9fXQ9FpX631aOTmxaGfL87M7N4gHmHH1LnRlp8paxWEtJ4plSruviOnse49ZFlffzmJz+Y6uYc6bGnvcEY66TvJUyTsIn/+jaOYDFhUXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzWQFu5s; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzWQFu5s"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2aaf59c4f7cso125035ad.1
        for <git@vger.kernel.org>; Thu, 16 Apr 2026 15:51:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776379905; cv=none;
        d=google.com; s=arc-20240605;
        b=Yvwq0hKBogpeklonfQTQMgRFh0tZEp8Pfm5jvSP+L4Nyz6HnJmoxtSxYEMsuXbYACs
         bo2PPC7G5L3GdP3YEhCPayPJ2Qn4YxEe+R+yjS/gX7GtNRpujtBC/kqknLNgyQTG2Gpn
         y0TvCxJm4qjn5BrkGnqTrPGwGQqwnyFTp6ANxDY5ATUkYIldlETwGoBgehvYmn+KA2Ll
         +PFcktHUI7VG6cM9my9BW4uHyFyQ1j8hN4ZbUaIFKZe4m2OxQIQw/vsUEdayiU0nMhYw
         nHo+aIYKiy89T7FFCbX1rnJBI3pfNatNIs8z7b9+CaDvycx2gYEX0PrEa8ZeiOwVCO85
         pwGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kxgcEXMcp/xB7TKJUpPk7VrQFKmuKIcE34fabsiMfY4=;
        fh=fDra5E97jdgrddDfDvRTGbshnji+3XysukvVq5At42I=;
        b=UC97RZDvyFclusTLwpmP7kdaIlxOzNb3WmJkDum8r9nv90i95OIy2u1aX0Cm+yInQU
         qXWLaMksvUA0YdyvLZWyvzcKSQ0scCmOOjJv6EjwCjrXJN3Xr7z689Ik1mPvvrSK7bLX
         zcSQVZUDqCTQSjwvSeakQMsBWeJSBD+RozoKySzuVurJxU7R1ccw4fDg+5uC8mYqIH50
         OpX/w7sRDA+HrE8fNbPqO8DYW/t9kLK8cAPc/m+vU7O7CMmNZywVXMd2pJh3ZdzGbRLs
         vtkNbdzdvi/wU8s38/kh65vuhfmzAqw6dvWgXYqiutyFX2aAqjZ6E6ImtcdcXqhVghQx
         NmBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776379905; x=1776984705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxgcEXMcp/xB7TKJUpPk7VrQFKmuKIcE34fabsiMfY4=;
        b=fzWQFu5siuUpuJYdiYlT5Gto33xkpVIKlKiSr1CLrDStJHYjCV8ZonX8hxKT7SvZcZ
         p5YiHuQ2HheqbeUgJPExcIpY1gnConH3zIo+ZcHM+e1F06OhTLad63sQRQRLCOjtsFaB
         OcN3LLwI3U4Q9DE4aM6Rhf71AM+yT9WQ5BGZH1XNjZM1jQXPQLK0M+hsFDFg7tC3pNwG
         83s+eLg6EVs1/hukvmuKPHegNs3HEUJ1jMLiYHYG6AFGeiLzH9rlegUE+sU6lxSE5mo2
         BsPDzBxKrsSnHjJDr36yiYfqU+g03c1PKgE7RaSeveGYDG0Ca8zHwg27UiP9Gx7+9Jjk
         G9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776379905; x=1776984705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kxgcEXMcp/xB7TKJUpPk7VrQFKmuKIcE34fabsiMfY4=;
        b=NXjGWIqD0s1jXGx17SI4TX9oqI9hCE3aXWvFwnfrGIdWLNgqgXOTH3WLZdocfzh9HS
         GiE85EMCMlEKzhIZFd2TDqi2fRQ9ST8YwykWQuGIFNucfNplD9648GL7AdhvUlQyPGFf
         2XVX7bYgkf3eY71LqbmI3QX06XYWhqqE45l78YLcy4WdqiUnwX/t9pHwEU7vcVVb1N7H
         oXcSBmWPPisO7X31Cuhga1hajvx0dvTSE3NhmrmT6hIaoU2dcoeslyDSygCeA1FPsEbh
         iYSl+24EQvk10NbBcdb1dSB6JUO/imTDz3/U82qJ4c0kJev6xdgDm+w31D7jv6ZYMSN/
         JgBw==
X-Gm-Message-State: AOJu0YxNI33FBm/I0SNX1Nd+1rYrX/yVsA+/YjF6QeXQ9NOhP/uRbUyZ
	bFW1q33EOI8MuwyorGo6sYJY9p/iFAW2+b0X7VC35B9G3r11ixfOD3VzWhnbydArBaN8/HEuT4Y
	a2DtX01U8T7gqCm0UIwF99nU2YVPmqzs=
X-Gm-Gg: AeBDiet7rEJsKArQtmo+jsCdnShWieojgYDbFwMs0Uf2ubBRP1jDTVy6TtHleywnv9g
	StewrTLo1gyt1Cm/L6sIwjevPAKJvwA5dxx7TOAVqlZYkrMQByw70d9n8W9QA+pMEkBa3F1r8oA
	POSqJtM1zkZGnuHTsd4vAZ+OP14vS/CPznY6RzToeao5mgX3CCC868wUZjRwkiwlDPg9dx4cnHG
	Z8OVdE9KlBFm74tDnod2MNoseqduu36cpvnO6Uu0+HbXTwoU//gN1cctxgrgFdc6s2CvukyydyC
	YxLEA2ZDAXGzAA3mtk0dwZS6LHb9voqjvQucWlUI8ctnGvY9/cOji3szlwsxNPNxBW04VvxGkL/
	5u5ysTcLSEReeqmerDFyqJTcFJO7nbKcwJsaN
X-Received: by 2002:a17:902:cf4a:b0:2b0:4b3a:9b4d with SMTP id
 d9443c01a7336-2b5f9f1c862mr2978205ad.20.1776379904710; Thu, 16 Apr 2026
 15:51:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1774820449.git.me@ttaylorr.com> <d2c667e841300c3310e3a23493ac27eb2b08992b.1774820449.git.me@ttaylorr.com>
In-Reply-To: <d2c667e841300c3310e3a23493ac27eb2b08992b.1774820449.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 16 Apr 2026 15:51:32 -0700
X-Gm-Features: AQROBzCQg2wPxEvwgXCxxZoeJ6MR6q3_rkMTf-Gk_pbiEWO6BoylLMVeUju8gvQ
Message-ID: <CABPp-BGhXzo7yLQ5z_pPztSNf4vEiPM2x2pMxty99rak_NU-CQ@mail.gmail.com>
Subject: Re: [PATCH 11/16] repack-geometry: prepare for incremental MIDX repacking
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Mar 29, 2026 at 2:41=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> ...If the tip layer has fewer packs
> than the threshold, those packs are excluded entirely; otherwise only
> packs in that layer participate in the geometric repack.

"fewer packs than the threshold"; I'll come back to this below...

>         repo_for_each_pack(existing->repo, p) {
> +               if (geometry->midx_layer_threshold_set && m &&
> +                   p->multi_pack_index) {
> +                       /*
> +                        * When writing MIDX layers incrementally,
> +                        * ignore packs unless they are in the most
> +                        * recent MIDX layer *and* there are at least
> +                        * 'midx_layer_threshold' packs in that layer.
> +                        *
> +                        * Otherwise 'p' is either in an older layer, or
> +                        * the youngest layer does not have enough packs
> +                        * to consider its packs as candidates for
> +                        * repacking. In either of those cases we want
> +                        * to ignore the pack.
> +                        */
> +                       if (m->num_packs > geometry->midx_layer_threshold=
 &&
> +                           midx_layer_contains_pack(m, pack_basename(p))=
)
> +                               ;
> +                       else
> +                               continue;

Should the commit message use "no more packs than" rather than "fewer
packs than"?  Alternatively, should this be >=3D  rather than >?  Or am
I just mis-reading?

Also, the empty-if looks a bit weird; would it make sense to invert
the condition to get rid of the empty-if?  In other words, something
like:

    if (m->num_packs <=3D geometry->midx_layer_threshold ||
       !midx_layer_contains_pack(m, pack_basename(p)))
            continue;

> @@ -173,6 +196,20 @@ void pack_geometry_split(struct pack_geometry *geome=
try)
>         geometry->promisor_split =3D compute_pack_geometry_split(geometry=
->promisor_pack,
>                                                                geometry->=
promisor_pack_nr,
>                                                                geometry->=
split_factor);
> +       for (uint32_t i =3D 0; i < geometry->split; i++) {
> +               struct packed_git *p =3D geometry->pack[i];
> +               /*
> +                * During incremental MIDX/bitmap repacking, any packs
> +                * included in the rollup are either (a) not MIDX'd, or
> +                * (b) contained in the tip layer iff it has more than
> +                * the threshold number of packs.

This wording looks consistent with the previous check, but not the
commit message.  If the commit message is deemed correct, then you'd
probably need to update not only the above comparison but this comment
as well.
