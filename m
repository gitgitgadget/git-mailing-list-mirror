Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792733398;
	b=nJPIs7GhzVy2AFBPRAwOTwh6yANi2ucKePcmBHmZ/D00dqteqXYFUURIMFv2AFjLy4jH
	 IZEXkT7Qed0tQHl3i5qPXhpoJMC0jKk+5AhffbQ+0bkK/GZxllzB7eWYKM3DpnLdpKARa
	 YqbPAmsmOClv75XxKnlakhlWx3FP9LUozzO2Id7V+CvJUfZCyh4MQZD3GvEcPMmYpIlNG
	 KNFw+m/DIKByShV3mPgOMmNxPGjn6tsW/BJQjel20IFFFcCeoanGUOJczrl7fJI6/It8o
	 2lyv1v9z1V8FNAiHgolRuFoUmEJwAyl/uNwzGQq3fGNW9ryCzxAvO0AaB94WN2Kkzng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792733398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=lYFHVjJOtjkuwMw1VktvKQtNZ0lAELDaO2nRVlxGcdY=;
	b=UqytOSix4gDRVHkd4wTQYDR4KFS4hHvRIiyxmcd9xgnL0rTxlURnT3JieoFKiZOtt2I6
	 Jt+ZNpgtzFMfzXteVkWWkRtEbj2hLTr6MlXZRcinoAeT13OdZqzZ54F2zHQwJwCxv0I9h
	 COrF+Eu/rLsOlWFW3b3FimldOaQXB+0VVjLIwEpCEdpL4GyjkBEQ/GWDWvK5jfF3gSct/
	 tPdJMzmo5okBrRe1X98KJc+2Uv3J4OyPpZnXR4FpvcXCKA66tW3on3SpYVpIRVTtkYlz4
	 V7MudaqU5apqnqQvgga1/r2v1kxFKhCRSfe8gb80OocaBy1EhksbM4YuDCmF4BHg5jA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GYo3TZG0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9474D606A319
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 05:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9474D606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GYo3TZG0
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-9178aabd30dso5675316d6.1
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 22:29:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792733396; cv=none;
        d=google.com; s=arc-20260327;
        b=jrlyTe15ghJ0RYPHvIy7Y4hQtmWBZ8qyS3QrH9apcSlTG4qLpWJqdYNXD+uPTp92vm
         6EtDYilTrRWdRvXKFlqXFk4GgjcaBxZQD0ZiINoxN0IOfbI9x7WbYRjnUNZRrbF5vHN6
         pLDVVbQyAJRY8m7+bmWX+aLyUnsS/yyrOkRe1jIotqUko0QJOp5G2n7mGBrKbxO+VbpW
         CyqCDK6U04Y9jfK2JxcDV0oANvlUrn6rp5ina6FayG1qqKfibEUdE+B5RFO7ipIvDkMi
         O6WnS7K1kqvykjWSSUKvSrXYNWrxs2eJsj2jgcBB+eOFcbmVzYAvwlnXqUexKsu/aPbZ
         ziVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lYFHVjJOtjkuwMw1VktvKQtNZ0lAELDaO2nRVlxGcdY=;
        fh=LFy+lAQht3Vvun8X78pIW0ODmlxv38IGiZyBRYcOw/c=;
        b=JdNbrkCspwEJZOuaPqwZo4WooAUGM7dHbrh/ON5b9sNXJXvz1MXHpYY/sIpxJ4VQ/X
         /jwACAaX0zPAuLGGFOADIXzd0k3rlWnlDvj7OJqLfuh6toc78nx+2pihRRJHbscG7hd8
         VS4oABSaeynY7FLij9bCwpbZ1rwgBEZWCeeZ0MtzED2u0fLWYu7f4//01ob43htqWktZ
         g+IpoZ1zQDG2OodNuGBG0fxUi8lIHzGBpwYn1jty5CC6fBWa+rSvB6CPTFn4WCYpldZ0
         AMVddBiWNc4dtqfYYuWc86HlFSM2WU39syKFt/LKT6hjuYYCNEP6nD2bkFjabg6wGE6X
         FmwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792733396; x=1793338196; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lYFHVjJOtjkuwMw1VktvKQtNZ0lAELDaO2nRVlxGcdY=;
        b=GYo3TZG0K/dp9iHJZW7zXRC89uAf88+6g0HhXUP8f5rbR4DlorlrUqNnyMvW9RleJY
         fx+5IQJTG2bXMNXQTK+45j5Yk41d5M9nC59JifUz4qs3id96QgrUlAL7YmL+cBWMK6gU
         VCxxgIMsIOISW6yRllg/buy2koEWKd/LGd8+Etw2OOTQUGzBQChZ2JlbYLBGc2loWkoS
         AX7Y3qjMk8MoHW4wy14utfzc+NPzfXTUmfqQ6pnTO/tAaOYBv6LRVbpo/lm/9faumN+P
         ZGvR6/ygO2rf4AG7k6zx/Htd2vFvRI2bmtZaeAPIuX5hTypNPFuDEQ5kRiTl8IR0NquT
         2TKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792733396; x=1793338196;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lYFHVjJOtjkuwMw1VktvKQtNZ0lAELDaO2nRVlxGcdY=;
        b=vuGvCfUY/dI0+xXuOKUWJ+HbbezHZ6DCIISNKaLiC1pCqOtyY2I76H0/djeo0eqo+T
         vS4xRYMRjajFF8ap1LRaJCDCyfYAXfEO3SA4Wbuayn7emAKPWGqYqgtkkSfAW0jCi/eK
         rmIL54545qeSYq/AC4rm3/ypHdEs+fWHruWCXgdA9q5RKleDCwnuGMAafoDa6ARlwq4z
         7aV1yhFviQD8l5yD8iKzZdv3h83SL3h7TYlVt6LDZ2/Q0/0hzouhf9zB8qVyP0bvP6mW
         Kvdc+oNIXsOu1ep0WfPP0flirjcZeq/jWiWSfEc8/q+/dxDDqoaLkCfEMAtObR1iG1xT
         O+sw==
X-Forwarded-Encrypted: i=1; AKwUvBzYKLDSgfKMU2NbdSIqMCOdZ2VQ84WYfHybRcxqAJSK4N08KXGMz7vaGUtzwVtFxXS2i9g=@vger.kernel.org
X-Gm-Message-State: AFq9FYKjtCU83yvziHFAE+DL5KvSPt/akCpM1rf7yO1wOxIyRqVcIwij
	OGu841qKEsXmY1UAwp4kd9tizlBBDgpWQBv1zzTVPuHds47ynuLcg7+/gQD1RTCQ11ea2lg1n8p
	O7oyaHcY4I7rhDnvcUhZOW+oa5MKq1Tw=
X-Gm-Gg: AYBFou2Obag77LqiOvzulgLUp86gWjcfuQe14uDJm0hRTKYJKMUU6A3RHQ3fR6B0FtS
	R5ITANvraXo+a1QloucY9z4OGRDhf8O5VMDE6YAn0eXHCqq2l7FxP6NfyBcLW3xTTnkllArAlCR
	G4a2PItQm3m+lFb4DIEwVhW7c7Lfkn7Io8b9w0NYYGkLeyjGh9hKc6WeNKliO5gCH+P1zknqQY4
	TkT7DZNTJv8ZZk2clZOmu1srVWTQXARVmbHq9WhIlkiqHgvPOvfeIMBHhRpPJ4DBYUMgq9842jf
	usM88yB6sCUJu+Gc7vA21IlgpIENC9FShKzPE3MRjfUBP+OOHW9jrrsnS2jd7mnfgZ3F/910qLE
	FmYKxxBUwuu04liYySfefTNP/ddrScuunX5C9s26LLpanwhHj1cWgM25BR468AdLumQ0zZ5k=
X-Received: by 2002:a05:6214:268b:b0:91b:a702:cc5b with SMTP id
 6a1803df08f44-91c3a61d5e9mr14662616d6.7.1792733396530; Thu, 22 Oct 2026
 22:29:56 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2276.git.1792727808109.gitgitgadget@gmail.com> <xmqqld7paty9.fsf@gitster.g>
In-Reply-To: <xmqqld7paty9.fsf@gitster.g>
From: Srujith Poojary <poojarysrujith@gmail.com>
Date: Fri, 23 Oct 2026 10:59:45 +0530
X-Gm-Features: AclHuK_lCd7YOBx8ys1m5nKVq4xhk7Krzh6N8pM3ThJm5pONxLw3Xm8ZYB5T5CA
Message-ID: <CABh_KWiKmXP4KTgF=k2gGdSvcZXkRipD61AVn+AS7ZgvhcjHWw@mail.gmail.com>
Subject: Re: [PATCH] [Outreachy PATCH] diff-delta: use safe integer arithmetic
To: Junio C Hamano <gitster@pobox.com>, Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 10:34=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Srujith A Poojary <poojarysrujith@gmail.com>
> >
> > Replace manual multiplication and addition in create_delta_index()
> > with safe integer helpers (st_mult, st_add, st_add3) to prevent
> > overflows while preserving NULL returns on failure.
>
> I do not quite understand what the last part of this explanation
> wants to say, i.e., "while preserving NULL returns on failure".  It
> makes it sound as if the function would return NULL if the integer
> helpers detect integer overflow, but I do not think that is what
> actually the updated code does at all.  st_add() and friends will
> simply die() when overflow happens, so you will not even reach
> malloc(), let alone return NULL when the malloc fails.
>
> And if you reply to this review message, please do not top-post.
>
> Thanks.
>
> >
> > Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
> > ---
> >     [Outreachy PATCH] diff-delta: use safe integer arithmetic
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2276%=
2Fpoojarysrujith%2Fc-refactor-target-name-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2276/poo=
jarysrujith/c-refactor-target-name-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/2276
> >
> >  diff-delta.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/diff-delta.c b/diff-delta.c
> > index 7cbedeb507..45df070ab9 100644
> > --- a/diff-delta.c
> > +++ b/diff-delta.c
> > @@ -162,8 +162,8 @@ struct delta_index * create_delta_index(const void =
*buf, size_t bufsize)
> >       hmask =3D hsize - 1;
> >
> >       /* allocate lookup index */
> > -     memsize =3D sizeof(*hash) * hsize +
> > -               sizeof(*entry) * entries;
> > +     memsize =3D st_add(st_mult(sizeof(*hash), hsize),
> > +                             st_mult(sizeof(*entry), entries));
> >       mem =3D malloc(memsize);
> >       if (!mem)
> >               return NULL;
> > @@ -258,9 +258,9 @@ struct delta_index * create_delta_index(const void =
*buf, size_t bufsize)
> >        * Now create the packed index in array form
> >        * rather than linked lists.
> >        */
> > -     memsize =3D sizeof(*index)
> > -             + sizeof(*packed_hash) * (hsize+1)
> > -             + sizeof(*packed_entry) * entries;
> > +     memsize =3D st_add3(sizeof(*index),
> > +                     st_mult(sizeof(*packed_hash), hsize + 1),
> > +                     st_mult(sizeof(*packed_entry), entries));
> >       mem =3D malloc(memsize);
> >       if (!mem) {
> >               free(hash);
> >
> > base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926

Hi Junio,

Thank you for clarifying this. You are right=E2=80=94st_add() and st_mult()
call die() on overflow rather than returning NULL.
I will update the commit message to accurately reflect this behavior
and submit v2.

Best regards,
Srujith
