Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185372D3EDF
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 07:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763536197; cv=none; b=AnS1wq7IpkaBebfqBs4TjAcM76O+u529JApokssuil/lj9JjJxcTJAyjfXsFOKjZQiYuyqUsbZ+E6CH7vnMtsyXBroQ3/60fcc/Q7m6ceSz3/57FKDsqs0TyS0cNLkt3+pjXZnDaksMOGw2QjAC1vHLI01g9/4o6JyKTNMEwaRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763536197; c=relaxed/simple;
	bh=44WXqiSKr6Z5p4u0W4/S1Fb0A/02dAc1h5ZSjQ5/6eM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YIky9IjddmUkv+tgkmOEWsA3HtsmLeXTl9QAVxkG9QWfJXntMqQjYGii4dV5vXmp1sqoKmP/JbdN3hFPHgjA3ORFwZ3y1B8WcKYoYZhyRdUkI20v1ylbwP0nhT/RjnIhvYq3TegkTVj88lqnDPXJWkzm2F4qxd5o9V1MrYTip9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8b2e0a2ffdaso37605585a.0
        for <git@vger.kernel.org>; Tue, 18 Nov 2025 23:09:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763536194; x=1764140994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fuupyNrJ3/q5Lu4vfeRXmZinmlWNyI6slH/zvzeLRjI=;
        b=STgGzaKSU/ErSlBjJehwmhnsYILYpsYoA+he3jl/sr7Ti6tiyJtz+/0Z1lyjbUlRra
         Qgi1DQxexkJ9AI5QkbIwi76o7cccFurz7MihB0pPe2MvxZuaInIm8cX0JgB22bFQ0Qmp
         EY8df3g5ahX4sPcpsW7KGB/s+CITM4GZaa/Y05TepKd2M9qJg8RSm+COmBOCh0IIrlZP
         C5V1n5U7vp+1/yXPIq6TKS8bWPgyxEvcht1d4k7OgHmPWfb8t9kKhOwEoGCjuijg6HWC
         IAtp0WImqEJDJNh9GNtVqowxxpSYOtv72UjBHc1Z5F19zcsHs4GJFzr/Vcvl5e3vJMKI
         yERA==
X-Gm-Message-State: AOJu0YzTxYWKPz5xhWH48lrqpoV4vQkQ8GLTBqnZh4QeMle2ZOrRLeFm
	w8XQT+2p7QtZBDYFORVsPDyszMr7Ft4RwwTj4cZ8ETNBMltbeZNbD2kEBTR7JEayP715aEnzpKy
	Hnd944lUdcpbnNa8e0zE4Z/2jpfsd9+k=
X-Gm-Gg: ASbGncvxZjBulybnsVeiMOwa1zJgKrjzq22avSwaWjdTvR1LFAnkTDJJJaWbKPYA1ld
	58Sz+oCnOx6ow4iUg2swPYidUuUYEWsjPi4CrzAYiv3Jibmf1Wwuu+NUVNigsCTCKjx5fyleTnT
	hX2RDWx5sJ2xee9VEg2rrDNuFjWimm61Btz5Umg9ObPTNDiJ8cBaSyh3qqbImomw+tY7vx0Q1xE
	oG95NHVPHXQYmEbaDXfqw9exQCqtqEDSSaa7Nuj7dCbDZDPO+jjTxfTSXeln4LVnrLCkZWDJyQE
	/qFVY3hWqAcH6s/H8+0eGUd2SIMcTthfEuEErg==
X-Google-Smtp-Source: AGHT+IHS4udP5I9i6aG70Rcp7Y2uDYjTxEzWugRWiTeFl1CrtKporod3VSU/wjSN+55D7wAWKtqkRqVuBcltZ4cpc9I=
X-Received: by 2002:ad4:5c8a:0:b0:880:4dd2:1d0d with SMTP id
 6a1803df08f44-882927507c7mr200734236d6.6.1763536193731; Tue, 18 Nov 2025
 23:09:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763482051.git.phillip.wood@dunelm.org.uk> <b42d0f668b4a5ba0ec00fed1377cad5488f62197.1763482051.git.phillip.wood@dunelm.org.uk>
In-Reply-To: <b42d0f668b4a5ba0ec00fed1377cad5488f62197.1763482051.git.phillip.wood@dunelm.org.uk>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 19 Nov 2025 02:09:42 -0500
X-Gm-Features: AWmQ_bnH1h7dky4gOwuUKyuOdu6xjlWw0pxwKZ-wlFJcgU2KaRWzkxcoHSzl3uc
Message-ID: <CAPig+cSptp+a7jnUp3Tg=7D8WYKFNz4xWU2eaH+X5uy2mWjvgg@mail.gmail.com>
Subject: Re: [PATCH 2/2] worktree list: quote paths
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 11:07=E2=80=AFAM Phillip Wood <phillip.wood123@gmai=
l.com> wrote:
> If a worktree path contains newlines or other control characters
> it messes up the output of "git worktree list". Fix this by using
> quote_path() to display the worktree path. The output of "git worktree
> list" is designed for human consumption, scripts should be using the
> "--porcelain" option so this change should not break them.

I believe that it would be more accurate to say "--porcelain -z" since
that is the safe combination. Without -z, the output of --porcelain
will be gobbledygook if names contain newlines or other control
characters, but that's a long-standing problem[*] outside the scope of
this series. Anyhow, probably not worth a reroll.

[*]: There has been talk about correcting the oversight that
--porcelain alone (without -z) fails to call quote_path(), but such a
fix never materialized due to backward-compatibility concerns. We
would probably need to introduce --porcelain=3Dv2 to finally fix the
case when -z isn't used with --porcelain.

> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -1028,11 +1029,14 @@ static void measure_widths(struct worktree **wt, =
int *abbrev,
>         struct worktree_display *display =3D NULL;
> +       struct strbuf buf =3D STRBUF_INIT;
>
>         for (i =3D 0; wt[i]; i++) {
>                 int sha1_len;
>                 ALLOC_GROW(display, i + 1, display_alloc);
> -               display[i].width =3D utf8_strwidth(wt[i]->path);
> +               quote_path(wt[i]->path, NULL, &buf, 0);
> +               display[i].width =3D utf8_strwidth(buf.buf);
> +               display[i].path =3D strbuf_detach(&buf, NULL);

The strbuf is unconditionally detached on each iteration.

>                 if (display[i].width > *maxwidth)
>                         *maxwidth =3D display[i].width;
> @@ -1104,6 +1108,8 @@ static int list(int ac, const char **av, const char=
 *prefix,
>                                 show_worktree(worktrees[i],
>                                               &display[i], path_maxwidth,=
 abbrev);
>                 }
> +               for (i =3D 0; display && worktrees[i]; i++)
> +                       free(display[i].path);

And the detached buffers are correctly freed.

>                 free(display);
>                 free_worktrees(worktrees);

Although not technically required because the strbuf is
unconditionally detached each time through the loop, I wonder if it
would reduce the cognitive load slightly for future readers to also
strbuf_release(&buf) here at the end of the function. Probably not
worth a reroll, though.
