Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B512741D6
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 08:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753344745; cv=none; b=f+dDxgV/BnVcDKKOoeshVs+9UKgwZN/dHbO1l+8UrNSo86Nw7WNJ3nILzA5agsRn3ia0bCOo2o99mWoVrCphE3tVUb6H2k/E91Zctjy7OSG6XYnPgYvlGzoellTLGBPE1YPOm++i1SsqopsJszUFFDrDYFMnxjoQnRv4/+mfZIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753344745; c=relaxed/simple;
	bh=YCKu45V9/UBTxah4jtfByy04kTlQsDT4XldrfU4MtgY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=njAQ9ZVOSY5qxxqwMX0QWPDXl165SpjWaPDUDvCjJnh052951ukVLNjNS3aFUCe0t49buh+0F/gKaRF+ZRtkAkpsD90LGu3XfAIoYeHOLfPpMf/huIaWY2F9PYR1OmOX79KKTSBEnvY7qbXPGnQL0eWcItJGk0rIqPeQcxVwEqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+F/X+iw; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+F/X+iw"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-87ed3b792a2so143558241.3
        for <git@vger.kernel.org>; Thu, 24 Jul 2025 01:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753344743; x=1753949543; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UfgvoKGRRv6f6lrP68LWqeYz7WYx9A2H2v1MuJXLRa4=;
        b=a+F/X+iws3OvSCC/vasF4/DsjEd55pyLpG/mkDI41+zBTWafyEt8D8Ye7miZ2IwjL+
         brEbyz11fToFuWf/RF3KLSLTvnvt6fzjZ9cDSJ1bTOV5XVTFdfwOXr0rNLH1m7kxITHF
         etV6CoY0V6DVmyIeEbQdzySG2hnl8mH7o7QjOsiCfLLvd2EOBDnRP8MbpAzFIhq8PxsT
         dmhEjGw1BEI/TuhGZGWBzDg7ib+eZawcjgEdwrCW2RcO7FzXcWRW+KNGWtC7Txl2SD8g
         GDpbEtFfxBd8G5QzGgIOb9S78GtcRE5WLCn2LMzblETKJzoBCAmx0SMshRezftwztTHJ
         sr5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753344743; x=1753949543;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UfgvoKGRRv6f6lrP68LWqeYz7WYx9A2H2v1MuJXLRa4=;
        b=QwBNZFk1O2fkzNlTJAVGpVjTeScU1EhPdUEsZ3nEde1XE99Ka0MYkUzWBpJ4i+Oxb3
         cAcNQfYc6E4a5eP6Dvmr0ThsQzWDIdbOs7LAysYRdtRLWKejZsDi0wo+/IMJkR+aXXZN
         iWAuLVGWY+tlOtv1hlmTknxNmRscL0l6SNmHfE1OcsICCugXUNAUeS4fGiFLwwVh7pGl
         ybylGnvGh/HTaI5n1aeRsEDVr+nGSpg6kXJPzzCuq5n3wctHCBUpLFTqlZ1krZyjuQvA
         aHT7G6fTqLzeNdAquHEgovmzVmxk6FTowx2rXR215f+9HMT0nfL62A7T0GZ0s6ZdzzGL
         DsXA==
X-Gm-Message-State: AOJu0YwznkZPwuBpJFYHSN1tuWHV6RYlTehv3mmW+EQDjbM2jPadbzI8
	I3I3taDdHjNj1TpfA1ywYdzHi0G9CVuWjSdMv3bIkcd1j/E0krczSBtifz/QaRyOUiwQ7s59OTO
	Zp2hb6S5/fiMdBgLVRhvEihCrrIW6btY=
X-Gm-Gg: ASbGnctvZ5aKMTdVPu76TZkWMSwS/xz3SpVA5xAgEhM56y6k+qTfmxecNLOpzfIM6AK
	bK9zTB0hlWWd5iehKY0Jr9mr1MEOgIks8Jb3dLGkw4x3dmh7gFC9Cr9TO/5djURONQkTLpXDM8O
	ve+3ueYHSMljDk0TOWTbq4X28X6hxqn04b9rrEBaDZ2zy+ePwFxANdqm6iqAoSvOoqQxBBm2n/u
	D1ZtA==
X-Google-Smtp-Source: AGHT+IECOsxr9Ohi5yPEgymHhHERMykKWl/feWy2a+TyJgr+l+ES/T+Xfa8dVLTkit17gLkBKHTf+uw6xlTn8g10yDM=
X-Received: by 2002:a05:6102:2d09:b0:4da:fc9d:f0c with SMTP id
 ada2fe7eead31-4fa15082578mr2985710137.12.1753344742993; Thu, 24 Jul 2025
 01:12:22 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 24 Jul 2025 04:12:21 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 24 Jul 2025 04:12:21 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqldoelgnd.fsf_-_@gitster.g>
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
 <20250715-306-git-for-each-ref-pagination-v5-0-852d5a2f56e1@gmail.com> <xmqqldoelgnd.fsf_-_@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 24 Jul 2025 04:12:21 -0400
X-Gm-Features: Ac12FXw2v2VITOgqu3imxfjR-fgPogxGjWHqbR2k5MGAs2lkeWkwBeqU0FSzXZY
Message-ID: <CAOLa=ZRr4fpF0E8EM3nL37aSYzcHyCNnv5HzBzisM4C0UQUx8Q@mail.gmail.com>
Subject: Re: [PATCH] ref-iterator-seek: correctly initialize the prefix_state
 for a new level
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, schwab@linux-m68k.org, 
	phillip.wood123@gmail.com, Christian Couder <chriscool@tuxfamily.org>, 
	Kyle Lippincott <spectral@google.com>, Jeff King <peff@peff.net>
Content-Type: multipart/mixed; boundary="00000000000093529f063aa862dc"

--00000000000093529f063aa862dc
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> When cache_ref_iterator_seek() "jumps" to a middle of the sorted ref
> list, it forgets to set the .prefix_state member of the new
> (i.e. deeper) level it just initialized.  This later causes
> cache_ref_iterator_advance() to look at this uninitialized member
> to base its decision on what to do next.
>

I think the explanation is correct. For reference I had some more
details in my local patch, but this is totally okay.

  ref-cache: set prefix_state when seeking

  In 090eb5336c (refs: selectively set prefix in the seek functions,
  2025-07-15) we separated the seeking functionality of reference
  iterators from the functionality to set prefix to an iterator. This
  allows users of ref iterators to seek to a particular reference to
  provide pagination support.

  The files-backend, uses the ref-cache iterator to iterate over loose
  refs. The iterator tracks directories and entries already processed via
  a stack of levels. Each level corresponds to a directory under the files
  backend. New levels are added to the stack, and when all entries from a
  level is yielded, the corresponding level is popped from the stack.

  To accommodate seeking, we need to populate and traverse the levels to
  stop the requested seek marker at the appropriate level and its entry
  index. Each level also contains a 'prefix_state' which is used for
  prefix matching, this allows the iterator to skip levels/entries which
  don't match a prefix. The default value of 'prefix_state' is
  PREFIX_CONTAINS_DIR, which yields all entries within a level. When
  purely seeking without prefix matching, we want to yield all entries.
  The commit however, skips setting the value explicitly. This causes the
  MemorySanitizer to issue a 'use-of-uninitialized-value' error when
  running 't/t6302-for-each-ref-filter'.

  Set the value explicitly to avoid to fix the issue.

> Kyle Lippincott [*] and Jeff King noticed this with MSAN and
> Valgrind, and Karthik Nayak as the original author located exactly
> where the missing initialization is.
>
> [*] <CAO_smVg9TDakUnubepjPGmLyOzW6n8Z=MDbnZKvkwN2=kN2RRw@mail.gmail.com>
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  refs/ref-cache.c | 1 +
>  1 file changed, 1 insertion(+)
>
>  * I had this as "fixup!" on top of your topic for quite a while and
>    forgot to ask you to send in an official fix.  As Kyle's
>    discovery was after the topic hit 'next' (understandable, as
>    their internal edition of Git is based on 'next'), we need a
>    separate fix on top.
>
>    To prepare for merging down the whole thing to 'master', I wrote
>    the proposed log message to help expedite the process.  Comments?
>

I had a set of patches locally, I just didn't get around to sending it.
Will send the others, omitting this. Thanks for doing it!

> diff --git a/refs/ref-cache.c b/refs/ref-cache.c
> index 1d95b56d40..ceef3a2008 100644
> --- a/refs/ref-cache.c
> +++ b/refs/ref-cache.c
> @@ -527,6 +527,7 @@ static int cache_ref_iterator_seek(struct ref_iterator *ref_iterator,
>  				level = &iter->levels[iter->levels_nr++];
>  				level->dir = dir;
>  				level->index = -1;
> +				level->prefix_state = PREFIX_CONTAINS_DIR;
>  			} else {
>  				/* reduce the index so the leaf node is iterated over */
>  				if (cmp <= 0 && !slash)
> --
> 2.50.1-521-gf11ee0bd80

The patch looks good.

--00000000000093529f063aa862dc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 87a4282952135e33_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pQjZ1RVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNkRtQy9zRW5kNDhCU3E0NXdUc1c1UG9tQWQxZm8vaApBcEtNWFJSSWh2
dUM5cXlsbHRUWmgzSjdDZno4bGk2NEFxcW1lK3ZmcjZabUpuaG0vWCtJZngxeDV1dHBDaXZBCndn
TXhFNDZNaUtUR2RoRlNhN2VndllPTkJUUzFrUjdZOEIva3liMWRaMENSVW5IcmJMYnZPOXIrWGlW
VllnbFMKaVRWQ20vOGZkbWMvQWtXdldTYVBGdlVnUG5jeTF6ZGpEV3U3NzkrTW5HSmF3UGNnQVZT
K3pYbmUyWXdvMGUwMwpJYnBhRXBDcUFWNDhaUE5wWmZpcG5XRnFSbTNQdnpxVWRvTnFGOUNDbE5P
bzJrRSs5eXZ3ZFUrOUFZQjBkenhUCnpqak9JZWRiV0ZNclIvN2g4SUFOOUQrNExUM1lYWDY1SGhB
MFd6NUxUSGNZeDZYdFNVYUllNDd2N2Q1UlNTYWwKTk1hYUkzR3hCMzcrOXVpZjlBTi92K1lBMDZO
WENTK1lLWFljMlNzTVU3RDRjc0xOY0p3ajhkaUVYZWNrbk1wMgp3ZzROZ1ZkNWFRaytPemNjbU9J
bWMvNUIxb1ZibWdJNm5PYlF6V2dFajF3VEVNY01GL3p2a2VZUWZHa2k1ZVIrCmhyYndrTWM2K0o4
VmRnSTk3VmZFL1lublpCb05waFZuZ0FEcmJuND0KPUcyV1kKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000093529f063aa862dc--
