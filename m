Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886932C21D9
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 17:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781027721; cv=pass; b=i0CuBxvY1wVRgpZSi145UB7Z/8lOQ6xN5NaDyWoazdq5y4ZlGgUiEZKycnGo25jiCEbRvYRrbf/0q6sxU3mzsvvJzV3zRl6hsyt5wEtniwsaNXy4nxqOEq4+FCqGMgnkDiGc3CoqmOBY0pK85+fOIq0Xujk4dkvFrn4jYrYXVBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781027721; c=relaxed/simple;
	bh=MPcb5Mi2LwlppPVsGMNYIruC/Ea3xT5i8VqEgxsu7OY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bvdIh0UIOi0V9TTkjkeK5kMXksY/EHBQ5sDXB/bl2ATtJl8UEPgZXLb9LHVs7z/e4FhUBvA+8/jQ6esx/ZtmORd1wVsgvct6gZY4b1k+7/1S3slV2UXA52U66KoGmsfUvbt0Clwf6uEI3N81ORzvdetZJixKufUhvm9VvmV7gkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RL2oiCtd; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RL2oiCtd"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7dca5a81be2so55195177b3.2
        for <git@vger.kernel.org>; Tue, 09 Jun 2026 10:55:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781027719; cv=none;
        d=google.com; s=arc-20240605;
        b=Tn1ceEieLupgoOqBLTJMfVMf9u8FgTVD2ckS0xHHiE1U2gDApa1U66cMUFr/2Vthyy
         Y9lS/cBkmp5g+G4XTSjWydZPLl218XMwgbRKlK+h7aypMPYVsBJ/1sDUCb1cXPQuy7H4
         3BSl2f7UHqXxE0kdgaM4XbYOwJYj1X25g9KEBmV5w6yRKiiA+ORcZ30kCXTzGZv6/V7j
         ag3RTmkN1ubNk9nlKhS2SM3hWiaOvR8ALLITsHUD0R9ieLTsSxKLIGwxDvNv2le1hAi4
         mqpRgwGW3VaK36qbU3u/HDk5krhQ8jcHPw+Ks4jpaOG2s033iogfsVo6LVSnUg/xkWbA
         vNoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3K+XrKLe39Ta2IBsPEr30aQ/6XAoRPe7UkZ7rWndhQ4=;
        fh=/YTmDEts5H+NKga5CiKFf91jPZN0wFW2aNUe+mRtO8s=;
        b=PblhTS6knfK+4C5V8l4YNgSG4zU/6mUWib0ZzDEs32nvodTQPCaKs0GDs9D6MLV7qB
         dHAC4Eg7a4Lpw/h7b08/R4luvosShwxSYXURVOln3vSxEt4XxR/ZwtXbaNMrBj2q9vdy
         lvqWPm3V+cyuqAk52X66oTLrnqaTev4xj+XxyxBagJq80tTjG9kfF2i/VznAxRaqYrHb
         jIXE6UX6LAxtuddyLKt69gDh64kUmiyztnalWqo6c+97qgnVlzjMd5arE6e88IPcIfU6
         3uWtCXKPeidl3jfifMgvyqQBiAcJDIx/3TH8nI5IMNu6GGluI8uJ64wkUTjKNz3iPHhz
         dEiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781027719; x=1781632519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3K+XrKLe39Ta2IBsPEr30aQ/6XAoRPe7UkZ7rWndhQ4=;
        b=RL2oiCtdj73d8cSsYoZij0hSSk2RgYxvaw8ylxCcB6KloCTBwHWmAIAiRwU2Ms8mTR
         hEO+4UrSXMy8qeEJKii+wYBSbGA/f95QVJXcYXfbm4IiOAFbsw1GkvZ39K4GYB/2cEPq
         jsHcpboT14SDsuO+4X33MRQMTG4QWNyuQ05hT/QsIHwC9Uf+x0tVYfbSC0Ppu1+PI778
         W4sEDd/35dHHbiLj8uPph6RtZYtyseGWZ7alGLiBy+c3I/YuJ6aea+xf0J+jZooLXmsV
         wdWdlQ9ybZ+/izoK0LiT0QsmWV3kz5j5mjWbDLVZgfU9qsN6BlYJEINTWvLro2e+lHAK
         ecDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781027719; x=1781632519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3K+XrKLe39Ta2IBsPEr30aQ/6XAoRPe7UkZ7rWndhQ4=;
        b=Pccbs2KfkH2NrgjUGgokOvhCHes+KJj2GOZW64D4YrV8eR6GixCdDc+aMHyu17Lvbr
         1QSQk4E1C2gIseZuJj8zotapCge42jnrC//7hJ+iNDDTCv0U0rSi31sS7bGXJVte+jHs
         ipEHVn/5dverEhxq8Kh1OyC63/ZDSSqjAUstveoO7YpWWT+auEfqZu7L/9to3xW2wiQ6
         Cy52tlGtvzFfRNQjQn3oxO0lAGvIjhb8IyBMQvvkxoLEgMwKMuSBG4Gp3qihlyk+9DNx
         uBSQMFu6gOQp0Man//s+t9OoxZ8YUwUx9vKz6+l9l65AxZY/aiJGTgwoO1GMlECwneXR
         WYRw==
X-Forwarded-Encrypted: i=1; AFNElJ+xoNBps6925oYcv0SfR9DhLpovuCfBkQOkzxAZnJPtWtugyyLb8wtuoMt703J7M8Rzj94=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl+8XX8sI5mIuhikcy9y5Lv5TK69FEfqJFX0MrdGkFCUc7DHpi
	w/Cw8TJG2N47XbkSStBsL/An25/Boif6+AyWSfePzgOKeWlfJiI4MBoMB+bcFY5kt+ctbVL1BZQ
	W2HmSrXsgK5/O6fx6HQHMMnSG6/J5tR4=
X-Gm-Gg: Acq92OEqAPKrJtilUDNARrFXmglGUVDd9ikWG080crHXqM5w0ZM+kjlp0aPx8XVCU07
	IAdaIg1J5Wb2stT+NPPxwE/isWHbWANJfBJl4RsJG1HbU1+7yY8rwKUxieCd5gKO/zTjhG43u8r
	vLX0K725j7u6KcMW+gFVY2pqOKQf8wRf+z908ha671hBQ4nDwiYJPUNZZdWm1CAR6tE1leVs+rQ
	GdOifoiIEmtiT3SebY9jSElUIKu6G3tz1Iui7+YBjHn2aoMzyQx5c6Vy4Wh3QbMoRUjGRW8FZ4j
	wkW9KM0x6fP1HrCGvf/TDR9hqUldnpPFNKlDJGO7OAckHOOHomEUcu/yuTQv0Dxm1I+LeLSD5qN
	e9da5/zJtGtyG5Tvv0yq5D/t3e8m1g4RabJG4ARJTnujIlrsItFqv1DHGXXvy4MRE3YNRNh9E4U
	czpXupqBPqiosG
X-Received: by 2002:a05:690c:4b83:b0:7db:ba77:899e with SMTP id
 00721157ae682-7f2b197775cmr35430417b3.0.1781027719368; Tue, 09 Jun 2026
 10:55:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221190451.12536-1-eric.peijian@gmail.com>
 <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
 <20260608-ps-eric-work-rebase-v12-3-5338b766e658@gmail.com> <xmqqzf15w0cz.fsf@gitster.g>
In-Reply-To: <xmqqzf15w0cz.fsf@gitster.g>
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Tue, 9 Jun 2026 19:55:08 +0200
X-Gm-Features: AVVi8CeC4m-TEpxPp68BKmRsJyFMj0kxpmfqzUYTHjdpyO0qhqtPpvc0xkSgQvs
Message-ID: <CAN5EUNQQBRoHUbZtkhLoBX-K7_4Carsxws_fyh1Ac7Lmd_FjKg@mail.gmail.com>
Subject: Re: [PATCH GSoC RFC v12 03/12] cat-file: add declaration of variable
 i inside its for loop
To: Junio C Hamano <gitster@pobox.com>
Cc: eric.peijian@gmail.com, calvinwan@google.com, chriscool@tuxfamily.org, 
	git@vger.kernel.org, jltobler@gmail.com, jonathantanmy@google.com, 
	karthik.188@gmail.com, toon@iotcl.com, chandrapratap3519@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El lun, 8 jun 2026 a las 16:52, Junio C Hamano (<gitster@pobox.com>) escrib=
i=C3=B3:
>
> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>
> > From: Eric Ju <eric.peijian@gmail.com>
> > Subject: Re: [PATCH GSoC RFC v12 03/12] cat-file: add declaration of va=
riable i inside its for loop
>
> "add" sounds a bit strange, as the existing code wouldn't have
> compiled if the variable were never declared.  What the patch did
> was to move (not add) the declaration of a function scope variable
> that is used to control for() loops.  Would any of these work?
>
> Subject: [PATCH GSOC v12 03/12] cat-file: narrow scope of loop counter
> Subject: [PATCH GSOC v12 03/12] cat-file: declare loop counter inside for=
()
>

Hi!
True, it's better to write "move" and about the title, works as well,
I'll change them for the next version.

> > Some code used in this series declares variable i and only uses it
> > in a for loop, not in any other logic outside the loop.
> >
> > Change the declaration of i to be inside the for loop for readability.
> > While at it, we also change its type from "int" to "size_t" where the l=
atter makes more sense.
>
> Curious single line that is overly long?

True, I'll wrap it up correctly in the next version.

>
> > Helped-by: Christian Couder <chriscool@tuxfamily.org>
> > Signed-off-by: Eric Ju <eric.peijian@gmail.com>
> > Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> > ---
> >  builtin/cat-file.c | 11 +++--------
> >  fetch-pack.c       |  3 +--
> >  2 files changed, 4 insertions(+), 10 deletions(-)
> >
> > diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> > index fa45f774d7..c060fd4800 100644
> > --- a/builtin/cat-file.c
> > +++ b/builtin/cat-file.c
> > @@ -726,12 +726,10 @@ static void dispatch_calls(struct batch_options *=
opt,
> >               struct queued_cmd *cmd,
> >               int nr)
> >  {
> > -     int i;
> > -
> >       if (!opt->buffer_output)
> >               die(_("flush is only for --buffer mode"));
> >
> > -     for (i =3D 0; i < nr; i++)
> > +     for (size_t i =3D 0; i < nr; i++)
> >               cmd[i].fn(opt, cmd[i].line, output, data);
>
> The loop limit "nr" will not become as large as size_t because the
> caller passes a platform natural "int" to the function.  Wouldn't a
> stupid compiler give us warning on comparing unsigned size_t with
> signed int here?

Yes, I'll change "i" to be int.

>
> > @@ -739,9 +737,7 @@ static void dispatch_calls(struct batch_options *op=
t,
> >
> >  static void free_cmds(struct queued_cmd *cmd, size_t *nr)
> >  {
> > -     size_t i;
> > -
> > -     for (i =3D 0; i < *nr; i++)
> > +     for (size_t i =3D 0; i < *nr; i++)
> >               FREE_AND_NULL(cmd[i].line);
>
> No type change, so the result is as safe as the original.
>
> > @@ -768,7 +764,6 @@ static void batch_objects_command(struct batch_opti=
ons *opt,
> >       size_t alloc =3D 0, nr =3D 0;
> >
> >       while (strbuf_getdelim_strip_crlf(&input, stdin, opt->input_delim=
) !=3D EOF) {
> > -             int i;
> >               const struct parse_cmd *cmd =3D NULL;
> >               const char *p =3D NULL, *cmd_end;
> >               struct queued_cmd call =3D {0};
> > @@ -778,7 +773,7 @@ static void batch_objects_command(struct batch_opti=
ons *opt,
> >               if (isspace(*input.buf))
> >                       die(_("whitespace before command: '%s'"), input.b=
uf);
> >
> > -             for (i =3D 0; i < ARRAY_SIZE(commands); i++) {
> > +             for (size_t i =3D 0; i < ARRAY_SIZE(commands); i++) {
> >                       if (!skip_prefix(input.buf, commands[i].name, &cm=
d_end))
> >                               continue;
>
> ARRAY_SIZE() is some arithmetic over sizeof(*commands) and
> sizeof(commands), which is of type size_t, so this is better than
> the original.  Use of size_t i of course is a natural way to index
> into commands[] array, so the result is just fine.
>
> > diff --git a/fetch-pack.c b/fetch-pack.c
> > index 120e01f3cf..f13951d154 100644
> > --- a/fetch-pack.c
> > +++ b/fetch-pack.c
> > @@ -1388,9 +1388,8 @@ static void write_fetch_command_and_capabilities(=
struct strbuf *req_buf,
> >       if (advertise_sid && server_supports_v2("session-id"))
> >               packet_buf_write(req_buf, "session-id=3D%s", trace2_sessi=
on_id());
> >       if (server_options && server_options->nr) {
> > -             int i;
> >               ensure_server_supports_v2("server-option");
> > -             for (i =3D 0; i < server_options->nr; i++)
> > +             for (size_t i =3D 0; i < server_options->nr; i++)
> >                       packet_buf_write(req_buf, "server-option=3D%s",
> >                                        server_options->items[i].string)=
;
>
> server_options is a string_list whose .nr member is of type size_t,
> so this comparison is perfectly fine.  Ditto for ->items[i].string
> that is a natural way to index into an array.
>
> >       }
>
> v

Thanks,

Pablo.
