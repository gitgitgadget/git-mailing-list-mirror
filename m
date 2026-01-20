Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95330296BD6
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768923400; cv=pass; b=iVqcQ0Ay78g58nPYdbXHpa4XKDAGBNw5YTaeY1+CvOH+Y5cdLsFMGHPUJJcyr7T4wvjI/gnuXaI9Mdbe3JShP2yLu6la2ECynYi3iOmJrhI9m/HGNlEs3K60mMyayVvD7vDrU6Iw6rpszBiyVp6KeYoQ9EkCen5vuiGm7F6jrUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768923400; c=relaxed/simple;
	bh=TmXC47L0P9gZqf7Yk62tsudZ5taP/XmEmWnF/3Z/7Js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=exmPS8BsE/HeRURfSqa1EV585SiIRPD6GBHYIvDEyOwaViDAvgxuJCeb2AbUfaozJOhn8IS1YscRONFjgeHsPqz3od5zsqF97TAbes4gnPSps+p+RyoLA8G/gC6QYgqw1OIfbP1xk0gluE55bwDKNNs7BDD57VvY0c/qfkhAz1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJrvAsvQ; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJrvAsvQ"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64c72418c6eso977578a12.1
        for <git@vger.kernel.org>; Tue, 20 Jan 2026 07:36:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768923397; cv=none;
        d=google.com; s=arc-20240605;
        b=FllSiazCrT4nerJmwADJvYBfZVRUwnsnpLmCNuPjk2N9gPzRLTpFseqyfU2FGtGHk9
         +AvUY+IZgQ5kup0+GGW7pFajXYr5/k5sDON6uqmtvWIRv6WdecoDDpcSkbTPlH/toMbn
         0dgPcpPeTPE0r02nIWlwKsmqpCGBPk7uyN3oLP+FCc0UaxOEx9jWbTJN5KiM4yGN4Nf3
         qbPLnNDyuA4EssZ9jTyAeXuUDwDhjaQopH8D70tHAGtpx5MwoDwKl7u2HCM6LMivpHTn
         9gaaAbj9btwbP5xTKIR/Jeh1jskyaMR+tILPLgYqoWJt3UQGm1nomJ0FejPZwf3bX3LF
         qbsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4mmhyztoyQ6WjOmkxYWAMaal9jMASShkDFk+D8uM5Rw=;
        fh=mKKDE1BltftIrVGBfZkLs5NTy7eSiPHLeuQL/NjyPzM=;
        b=YZoEXaZb7UF97Y+oRpCK6wisAqNAXTzO9AbSgTsK53UDyTvsVWuNmkji/D8nq8xTzv
         soH/fGv9Q7Dajo6oczrvB7Kex34L/d/U//Hq3cwPho/9hpTMlRIyPEwe7SFh2DsPNvJC
         hNLoGxrvYQ8KIQNXz1MDMLKIDAJ0c/TVIYF/aFxkb1efWgTjKc85WMKs47NCM70t2Oev
         g5yJamxpqj7h3vGFXe/xisOrEf2wAk16i0Q59dzuxq42fh/ZyKIvSLMDZEdays5f1RaF
         3rXvKPD/ZiR9dkLHbhAY2eJHdiuOJYJLbwcUgFX6y86owQH5osMfZmKOxoTbA8Yxd062
         zrkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768923397; x=1769528197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mmhyztoyQ6WjOmkxYWAMaal9jMASShkDFk+D8uM5Rw=;
        b=cJrvAsvQG8/qNwUypWgBSf9crl3LvuofjQtqo7aF4rdKOLYANDXrE9Dkn1nWjC21PB
         jOTc/r9BzrBq/6wsNDVYgqhHF3rwXd1lNMbCy3At4O+rvJrpLiiX16hJnybTFuBm1VpW
         UPmX4ku35hqDXySJMviOMB98tI/b7nfiPzTwhfEdbHuo90vkuo99r60263x8yTXuXCdA
         Fd2XAZV8WiHVUlu3wO3ZgyqMvKAJLTF46s1Q468kyaPppFGf2C1OwLo/lOcYbL+8S7gg
         i4yFedAKjCyUB7jLJkZUfpzm2XFF+JTH8P8kilHdi/VrqYKa1nujFk2odVRFd6UCIbvJ
         HHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768923397; x=1769528197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4mmhyztoyQ6WjOmkxYWAMaal9jMASShkDFk+D8uM5Rw=;
        b=tIjCv+OU2POvZ1R6PN8y+bJ1wiY83kJyO7hD1CHJ9CqRIuimpBVCPB2IIDfXQwzuoF
         mC99s6G3lALo5+I+gA4pB6MTLWHTDflG6T5RS5fpNwX4DdJTjmaCaT/h5xYMeHy/xYCC
         Lo+K+ZDej78Sgg6Nu13/azyMOLZv1r78t0e/I/A2RsljcbAUac/f9OLuu/G5Km4MKyn6
         JNzv/vPkZWX7vQUihBGEUOI+fp+Oz12g0XOM9PAlYLo5Fb8UNDAt2QASiuj5dfmjAnmO
         7pq//6YXgB+AlxVhR7fk5RoTVkC7v5oJebhEl3Eigu6S/VEYk4hlTXmu0ydNg6i5WYCO
         4GEA==
X-Gm-Message-State: AOJu0YyuhYeGChxfRN3IKTprAF1Z+6l4q5XkumGFZamWotlCeK6QYSS/
	kI02RfkPTCR/+6MLNQwEKfaKb/F+09p418wItFAWPe4oMUAx6usX+0XvcTToKI2RuIeo8Csceru
	6Sks1W5jMo7UnUl0rdi0WGkLNZO+gduChawz/xXyH3A==
X-Gm-Gg: AZuq6aI0JAmOps5E188wIMhwHlnXRKzGB0Ro6KFvFZhf87qbjqKjya2PUTK5G15d0/J
	adbuYGSnOy3xy1pAYqFEPsdHuVoSpTbIcDJOE2AC7F5NMRixH/SCvc3TuDlzYyfKXG72OAwQmqr
	xRhBQkz+/X1FjF8KN5gfBSKiijhRCH80xq+TBjExdPcHVqYKxQI03IYUILvcmYS1DM2TKj/pG1h
	Vkrnsnch3K8eutoU0j7C55G/XO7qb9D1xlKtLyif+9etbVl9QWVzGkwc/9rDZHw9bxrwQ==
X-Received: by 2002:a17:907:3c8a:b0:b87:6f58:a844 with SMTP id
 a640c23a62f3a-b8792b3a359mr808423566b.0.1768923396267; Tue, 20 Jan 2026
 07:36:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120152219.398999-1-a3205153416@gmail.com>
In-Reply-To: <20260120152219.398999-1-a3205153416@gmail.com>
From: Tian Yuchen <a3205153416@gmail.com>
Date: Tue, 20 Jan 2026 23:36:25 +0800
X-Gm-Features: AZwV_QjS7pTAeUoAm8eJuzDWyI8fFLULAb0fBVqGt5qmkozQSfPms-uHCt22KsM
Message-ID: <CA+rU_o6Mrw9ga0TST6p+8MANYaNGiKP9qud8izHL+hwxou9upA@mail.gmail.com>
Subject: Re: [PATCH v1][RFC] symlinks: use unsigned int for flags
To: git@vger.kernel.org
Cc: gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Me as total newbie to the git community (also preparing for GSoC
2026), welcome comments or any possible suggestions!

While preparing v2 to fix the return type of lstat_cache(), a broader
question regarding coding style came to mind:

I realized that even without changing the return type, the code
compiles and runs because of C's implicit integer conversion
 (since the flag values don't exceed INT_MAX).

My question is: In the Git codebase, are such "safe" implicit conversions
generally tolerated to minimize code churn, or is it considered a
best practice to strictly avoid them and match types explicitly whenever
possible?

I want to ensure I have the right standard for type strictness in
 future contributions.

Tian Yuchen <a3205153416@gmail.com> =E4=BA=8E2026=E5=B9=B41=E6=9C=8820=E6=
=97=A5=E5=91=A8=E4=BA=8C 23:22=E5=86=99=E9=81=93=EF=BC=9A
>
> The 'flags' and 'track_flags' fields in symlinks.c are used
> strictly as a collection of bits (using bitwise operators including
> &, |, ~). Using a signed integer for bitmasks may lead to undefined
> behavior with shift operations and logic errors if the MSB is touched.
>
> Change these fields from 'int' to 'unsigned int' to align with C
> standards and typical usage patterns.
>
> Signed-off-by: Tian Yuchen <a3205153416@gmail.com>
> ---
>  symlinks.c | 12 ++++++------
>  symlinks.h |  4 ++--
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/symlinks.c b/symlinks.c
> index 9cc090d42c..ed63891149 100644
> --- a/symlinks.c
> +++ b/symlinks.c
> @@ -74,11 +74,11 @@ static inline void reset_lstat_cache(struct cache_def=
 *cache)
>   */
>  static int lstat_cache_matchlen(struct cache_def *cache,
>                                 const char *name, int len,
> -                               int *ret_flags, int track_flags,
> +                               unsigned int *ret_flags, unsigned int tra=
ck_flags,
>                                 int prefix_len_stat_func)
>  {
>         int match_len, last_slash, last_slash_dir, previous_slash;
> -       int save_flags, ret, saved_errno =3D 0;
> +       unsigned int save_flags, ret, saved_errno =3D 0;
>         struct stat st;
>
>         if (cache->track_flags !=3D track_flags ||
> @@ -192,10 +192,10 @@ static int lstat_cache_matchlen(struct cache_def *c=
ache,
>         return match_len;
>  }
>
> -static int lstat_cache(struct cache_def *cache, const char *name, int le=
n,
> -                      int track_flags, int prefix_len_stat_func)
> +static unsigned int lstat_cache(struct cache_def *cache, const char *nam=
e, int len,
> +                      unsigned int track_flags, int prefix_len_stat_func=
)
>  {
> -       int flags;
> +       unsigned int flags;
>         (void)lstat_cache_matchlen(cache, name, len, &flags, track_flags,
>                         prefix_len_stat_func);
>         return flags;
> @@ -234,7 +234,7 @@ int check_leading_path(const char *name, int len, int=
 warn_on_lstat_err)
>  static int threaded_check_leading_path(struct cache_def *cache, const ch=
ar *name,
>                                        int len, int warn_on_lstat_err)
>  {
> -       int flags;
> +       unsigned int flags;
>         int match_len =3D lstat_cache_matchlen(cache, name, len, &flags,
>                            FL_SYMLINK|FL_NOENT|FL_DIR, USE_ONLY_LSTAT);
>         int saved_errno =3D errno;
> diff --git a/symlinks.h b/symlinks.h
> index 7ae3d5b856..25bf04f54f 100644
> --- a/symlinks.h
> +++ b/symlinks.h
> @@ -5,8 +5,8 @@
>
>  struct cache_def {
>         struct strbuf path;
> -       int flags;
> -       int track_flags;
> +       unsigned int flags;
> +       unsigned int track_flags;
>         int prefix_len_stat_func;
>  };
>  #define CACHE_DEF_INIT { \
> --
> 2.43.0
>
