Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC833257425
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 20:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744750328; cv=none; b=dJo2dtlkyr7nRrb/1ZNt/2GpNoDnul3E6y1dxm/ejJ850NmhNDEhmttpwqesGs2htVT77/6u8TtMqFuyjAHHpTBbSAfwie0s26os7I2IK5+UqcR8pGUE5URgADJpLJnrVioE5NH/LieEDaGD4g+a7E/0TADHF8k+Papef1vNG6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744750328; c=relaxed/simple;
	bh=v6AAFKcHZ03iZ07y1crBc1wYixM0DtYiTP8tG7idKo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkrWC1tn5iocaECmFrsbp/SmoLlOXwHkDc53pVerMiIZsI7qBOnD3YgN9TRxsUe/BmCdLYgNVkXwDi9p0eYoetTOAA8WRflytzCJVJlxJ9zcMp87g2dwWof0tEkpcQ5yb/+pvqhNfojIXdOCXPdBrfkOtuRO19CCuJ61gSoyJLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ajI8WNab; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ajI8WNab"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c54f67db99so5638885a.1
        for <git@vger.kernel.org>; Tue, 15 Apr 2025 13:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1744750321; x=1745355121; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zkCW7bCcNx3da+RlZHlIr7VdCeyd6o64KsD9e7qIhk8=;
        b=ajI8WNabvtTt80Lei9uKmsmg1NWD+luo9djQfSNMd45kLTvw4T/YQS2VlEQQEm5aCR
         0E7s09PfombecL+yWx+GOkWDCyc1zuav677+au4zmRAkslQU87lvTR4ZRfgLzz1LMJMp
         R1Z3ImsJfqNPXDWKd5ps4Up5xRQ+yCiIL3x4v2YmJaPFQxg/0yRiAd5kM1d6CmEmczB4
         Pc8oltTsZmA9x/Qw1PDLTLC41kcLeEq74/WCVdMO4Cl6RG+y0koqkj81YxTBu1dslank
         N4g4oFHtiV27h5stp9zjW7fbU7v2UZYvp9eeeE3qA6Z0eZrV0/3pfk1Vybu6QaSb9bNo
         3dgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744750321; x=1745355121;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zkCW7bCcNx3da+RlZHlIr7VdCeyd6o64KsD9e7qIhk8=;
        b=sed1Y8lVISt+PwVbHXLvhku/XZfzkmdtKkFlD5IHXkdvKrNvlt+lZZ5Dv0R4qKzSW/
         WJxM1dBzigaPQ4xNAK5UKs7DfiSXkxpNFiq9U3xVEuvWj4QRDZCJQ8XhP0PBFbUGjmoy
         1tZoB6zjnCfcQShhhFDdM9rNY9IR5KzRXEdnza6M0BW8c76eZmbsamZhGXdzuoi23iTX
         arx+t32JKHxEXBLo+K/vWhSK35jRwzj9CJkl9fCsQXhcmhha7sh/sSJy5Isa/iC6r9QZ
         T5uS+MlHVD4kVDA9u9kN1/GXo7oNO5XPovp6Zk/yc8T8Cp3vygBi7Hd83t0NjXP8qrF2
         RA/w==
X-Gm-Message-State: AOJu0YyR+KX8PPLRwCo+o2NPnf2kHXXbMZTsr1Pn96GhVim3M9XVPz09
	uDHZ7/eFxuQGTaR2/LIwNQH1XXxdcQ5dzaq0pncfP1KvISAfVMwaJzhAYmEpcI9sYptYGhQ0stt
	NHvU=
X-Gm-Gg: ASbGnctqthSOvFbxFW998dHaK3g65mkBZTIKD3kYvnmRxJU+FRPMz5Ceu5smv2lE4bd
	QQq3c6S5XRs6300bb4jL73eCynFc3wCu1mINepBDpNSLBocizwLM5AQqx8wZSMIvzqnw0MCeUbn
	KQwOQHUsM+Fk15RabLjp25HkOC/Ji9MRo81rw72+ngYa8mOFs7YeqLPjHHLiF1K8P848apDLTO7
	801KF82YCbJ2G5y4W4lV94t1PZHwOsDmDlgDeyhqOLLApIloD4Mu2yEWTQuGK7VDzy4hFolA1sq
	ynu58BDXeZnFrhFnOPuSDjWtKceGzZbX66MRVSHr4yMTYgYwTNoJnvk9vET2XQEW5bB38zAXKS3
	fONi+CLti6cd9
X-Google-Smtp-Source: AGHT+IFabXWn0OcXfAYB4AJfYs1VRwYaJbUg+woD2SNJZ+mXb3fPJ5g5hVYey1qLU/bxoqBhOV7uLQ==
X-Received: by 2002:a05:6214:260f:b0:6e2:49eb:fb7 with SMTP id 6a1803df08f44-6f2a1726868mr66204766d6.3.1744750321390;
        Tue, 15 Apr 2025 13:52:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f0dea106cesm105530826d6.103.2025.04.15.13.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 13:52:01 -0700 (PDT)
Date: Tue, 15 Apr 2025 16:51:59 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 8/8] repack: exclude cruft pack(s) from the MIDX where
 possible
Message-ID: <Z/7G73FmI/bK1Jti@nand.local>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1744661167.git.me@ttaylorr.com>
 <a2ec1b826ceb88c33e2b91c6beef49c21ce36632.1744661167.git.me@ttaylorr.com>
 <CABPp-BHwewWMp1CY4jAr=sWwxE9of2Q73nyXQ5wpOELJZQ1OPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BHwewWMp1CY4jAr=sWwxE9of2Q73nyXQ5wpOELJZQ1OPg@mail.gmail.com>

On Mon, Apr 14, 2025 at 08:11:22PM -0700, Elijah Newren wrote:
> On Mon, Apr 14, 2025 at 1:06 PM Taylor Blau <me@ttaylorr.com> wrote:
> >
> > In ddee3703b3 (builtin/repack.c: add cruft packs to MIDX during
> > geometric repack, 2022-05-20), repack began adding cruft pack(s) to the
> > MIDX with '--write-midx' to ensure that the resulting MIDX was always
> > closed under reachability in order to generate reachability bitmaps.
> >
> > Suppose you have a once-unreachable object packed in a cruft pack, which
> > later on becomes reachable from one or more objects in a geometrically
> > repacked pack. That once-unreachable object *won't* appear in the new
> > pack, since the cruft pack was specified as neither included nor
> > excluded to 'pack-objects --stdin-packs'.
>
> I believe you are talking about the state before your series (i.e.,
> this is carrying on from the previous paragraph), but it reads as
> though you are talking about the state after the first seven patches
> of this series.  Some kind of connection wording to clarify would
> really help here.

Sure.

> > If the bitmap selection
> > process picks one or more commits which reach the once-unreachable
> > objects, commit ddee3703b3 ensures that the MIDX will be closed under
> > reachability. Without it, we would fail to generate a MIDX bitmap.
>
> After reading this part, I had to go back and re-read and figure out
> what point in time everything was referring to.

Yeah, this is confusing to me too after reading it back. I made some
tweaks that I think clarify things.

> > ddee3703b3 alludes to the fact that this is sub-optimal by saying
> >
> >     [...] it's desirable to avoid including cruft packs in the MIDX
> >     because it causes the MIDX to store a bunch of objects which are
> >     likely to get thrown away.
> >
> > , which is true, but hides an even larger problem. If repositories
> > rarely prune their unreachable objects and/or have many of them, the
> > MIDX must keep track of a large number of objects which bloats the MIDX
> > and slows down object lookup.
> >
> > This is doubly unfortunate because the vast majority of objects in cruft
> > pack(s) are unlikely to be read, but object reads that go through the
> > MIDX have to search through them anyway.
>
> "have to search through them"?  That could be read to suggest those
> individual objects are read, rather than just traversed over.  Maybe
> "...unlikely to be read, so the enlarged MIDX is for mostly tracking
> known-to-likely-be-irrelevant objects", or something like that?

Thanks for pointing out... I clarified this one as well.

> > This patch causes geometrically-repacked packs to contain a copy of any
> > once-unreachable object(s) with 'git pack-objects --stdin-packs=follow',
> > allowing us to avoid including any cruft packs in the MIDX. This is
> > because a sequence of geometrically-repacked packs that were all
> > generated with '--stdin-packs=follow' are guaranteed to have their union
> > be closed under reachability.
> >
> > Note that you cannot guarantee that a collection of packs is closed
> > under reachability if not all of them were generated with following as
>
> maybe: ...with "follow" as above.  "follow" or "following" feels like
> it needs quotes so the reader understands its meant as the name of a
> mode, rather than a verb in the sentence.
>
> > above. One tell-tale sign that not all geometrically-repacked packs in
> > the MIDX were generated with following is to see if there is a pack in
>
> same here with "following"...and below.

Great calls on both, thanks.

> > @@ -808,26 +886,55 @@ static void midx_included_packs(struct string_list *include,
> >                 }
> >         }
> >
> > -       for_each_string_list_item(item, &existing->cruft_packs) {
> > +       if (midx_must_contain_cruft ||
> > +           midx_has_unknown_packs(midx_pack_names, midx_pack_names_nr,
> > +                                  include, geometry, existing)) {
> >                 /*
> > -                * When doing a --geometric repack, there is no need to check
> > -                * for deleted packs, since we're by definition not doing an
> > -                * ALL_INTO_ONE repack (hence no packs will be deleted).
> > -                * Otherwise we must check for and exclude any packs which are
> > -                * enqueued for deletion.
> > +                * If there are one or more unknown pack(s) present (see
> > +                * midx_has_unknown_packs() for what makes a pack
> > +                * "unknown") in the MIDX before the repack, keep them
> > +                * as they may be required to form a reachability
> > +                * closure if the MIDX is bitmapped.
> >                  *
> > -                * So we could omit the conditional below in the --geometric
> > -                * case, but doing so is unnecessary since no packs are marked
> > -                * as pending deletion (since we only call
> > -                * `mark_packs_for_deletion()` when doing an all-into-one
> > -                * repack).
> > +                * For example, a cruft pack can be required to form a
> > +                * reachability closure if the MIDX is bitmapped and one
> > +                * or more of its selected commits reaches a once-cruft
> > +                * object that was later made reachable.
>
> The antecedent of "its" is unclear here; just spell it out to reduce
> how much thinking the reader needs to do?

Eek, good suggestion again. Thanks, I fixed it up and made the
antecedent explicit.

> >                  */
> > -               if (pack_is_marked_for_deletion(item))
> > -                       continue;
> > +               for_each_string_list_item(item, &existing->cruft_packs) {
> > +                       /*
> > +                        * When doing a --geometric repack, there is no
> > +                        * need to check for deleted packs, since we're
> > +                        * by definition not doing an ALL_INTO_ONE
> > +                        * repack (hence no packs will be deleted).
> > +                        * Otherwise we must check for and exclude any
> > +                        * packs which are enqueued for deletion.
> > +                        *
> > +                        * So we could omit the conditional below in the
> > +                        * --geometric case, but doing so is unnecessary
> > +                        *  since no packs are marked as pending
> > +                        *  deletion (since we only call
> > +                        *  `mark_packs_for_deletion()` when doing an
> > +                        *  all-into-one repack).
> > +                        */
> > +                       if (pack_is_marked_for_deletion(item))
> > +                               continue;
> >
> > -               strbuf_reset(&buf);
> > -               strbuf_addf(&buf, "%s.idx", item->string);
> > -               string_list_insert(include, buf.buf);
> > +                       strbuf_reset(&buf);
> > +                       strbuf_addf(&buf, "%s.idx", item->string);
> > +                       string_list_insert(include, buf.buf);
> > +               }
> > +       } else {
> > +               /*
> > +                * Modern versions of Git will write new copies of
> > +                * once-cruft objects when doing a --geometric repack.
>
> "Modern versions of Git" -> "Modern versions of Git with the
> appropriate config setting" ?

Heh. Great catch. Can you tell this part was written before I added the
configuration option? ;-)

Thanks,
Taylor
