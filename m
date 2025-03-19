Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8328A15D5B6
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742400032; cv=none; b=G8PVOFQB/c7s/YMNRYodbuKt5A5BweRpBrRARPoS2XbL3rr+0uP0sJDdW1y2s0bewRvMQimH1Q1P+6H9+XTnGSi9Un8GCUMNKvDAzKpaYBX8v+kgHYL00hyTfFmzkgVIVraEzsfJ5iyd2Sa/YswNp9CunL+ao1I+JYkxKogr18Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742400032; c=relaxed/simple;
	bh=Ts3FfXsy6M4IuSNe0dZkYZ2JRlb9Me/OuRZlOJ5jCnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H6u+4L8t8+AcJ7tyEZlYq0uKHbWBn3BdWbbvcyoWJjOobmXsrBqvGwQf+4OiZuI0DY1No2YzLj7Us9gh+5JPU/T2YxoviBzBWUd/VbtoDVimYvoXPJsAhmZoDHIzBluxVsTX+iIxfqPawzjzZW4axt6qE6IuHJw1U5QkeB0+x74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSNYzTG8; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSNYzTG8"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3d03d2bd7d2so79455105ab.0
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 09:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742400029; x=1743004829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OY5h10oOsndthc/fsqyEYNbMNzf8x1qlwr2nSrRr8gk=;
        b=VSNYzTG8kPCQ+J2K+hOjcikW3qzQOL2ZCNM6wFmqW1/yehm0nAmRYrjNyMHpiY5Puc
         eXa/Q6aHneqM1P/DBAvC02M6GjKjLAe6P9PZE8+zsxnE/jFhXaIkXMM/4IFzOXLZAT3t
         nwFPVN/eulC5pvJojX0rz0Cp39J/bTidgjLjgQ5qWDAXwV30dxnSQ0Qy1ZdqL1TPXR3c
         O+FDst5kqpKH1Mhcyh49dCcXCgGkykn1jp47eB+kXDT+1/GnUVmLfaWfE5PwRkkwVjTj
         bJTgN3nhHpblsB0TqYan2rf9v3V9LPB+aMIGbeOkbdAktupykcGTQo9nIrRin1JG1eS5
         ia5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742400029; x=1743004829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OY5h10oOsndthc/fsqyEYNbMNzf8x1qlwr2nSrRr8gk=;
        b=HgNMQrqyv9bZqZ9eAXczSIwh7QJ+7qf21xg1RGLSa4A46LRtfV8uO3PLG9DZidobkI
         HlK57mGk31eyo64SyLQRilHXIJzGUz4VZo5a5krzYKRtQQrNNkD+CE4dt84yVtQaX82k
         XSXJqOh1aE435UT2l5ysJcJ4UxHoF8yNwjtexhMX14TjLzK2RD9c2cldcW4GnPXYkV6N
         9rLYER9FZQy25FCJ+tXfweWY7zZw32Lmzv/TuOMcQ8cRQEM54TOP1pt77TBJQA/zOVTD
         DpCdaM2ce3kSnHsbfjFW/Trf/p/TEXXxYWFGYk2c9R5VpfGNKlt2qFL0XwB8g3NgP4Ww
         ELgg==
X-Gm-Message-State: AOJu0YwI8o3jhGMBMfrcvH8HT0P2euYPH0IPBk/rHOtInkk3e+BKorwn
	Ld4LjA2TKUy6cA2FiGEFKiO5xtQb1LMohsp4KQxzV+bZpf0NzsF77yD+WESkZ4JaMbk0VkAxwHS
	x6lERrMjS4DYS/XZWp/8WEOyQ73rF9Q==
X-Gm-Gg: ASbGncvSlx49R1huyliaDoQQxTRlXVx868MxwvalTdNy+8d2HLEF4ZG5X/Pg7Jwq/Ft
	k4bfaCJwEm5aWf4ZraKJREO7r1Pc/2gE5Qkzj9ZhqYiOzw7LgOVLACZXMOVz3OaDPpKOCg/mMid
	kMpZMqldofCKp1T5SuayutHEubdHaT
X-Google-Smtp-Source: AGHT+IGmdn2G2aKtPsKM5ufYv7dh95s8JkxZo+MXE5LHFaM80tDW/Igdh2bkkcfsiP1R4qxI9TgxHiVzT6oLqPT7KV0=
X-Received: by 2002:a05:6e02:3089:b0:3d4:36da:19a1 with SMTP id
 e9e14a558f8ab-3d586bb9f0fmr39123045ab.21.1742400029311; Wed, 19 Mar 2025
 09:00:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1742336481.git.me@ttaylorr.com> <ba22a121fa699e490de00eba988552b6c10fe2fd.1742336481.git.me@ttaylorr.com>
In-Reply-To: <ba22a121fa699e490de00eba988552b6c10fe2fd.1742336481.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 19 Mar 2025 09:00:17 -0700
X-Gm-Features: AQ5f1Jq4gXf41wuH-y0v4_TBb83fKkXW2AyVocxmThn0CfCLK1g-5hZhEetaTcQ
Message-ID: <CABPp-BGcsVAbaAj628ACGb=cgMaUBH0LO316tj9pJsj6=WrH8w@mail.gmail.com>
Subject: Re: [PATCH 1/3] http.c: introduce `set_long_from_env()` for convenience
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 3:21=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> In 7059cd99fc (http_init(): Fix config file parsing, 2009-03-09), http.c
> gained a new "set_from_env()" function as a convenience function around
> conditionally assigning an environment variable to some variable if and
> only if the environment variable was set to begin with.
>
> But prior to 7059cd99fc, there were two spots which need to first
> strtol() whatever is set in the environment before assigning it to a
> long pointer. Both instances stored the result of getenv() in a
> temporary variable, and conditionally strtol() it depending on whether
> or not getenv() returned NULL.
>
> Replace those two instances with a new cousin of 'set_from_env()' called
> 'set_long_from_env()', which does what its name suggests. This allows us
> to remove the temporary variables and clean up some minor code
> duplication. More importantly, however, it prepares us for a future
> commit which will introduce more instances of assigning an environment
> variable to a long.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  http.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/http.c b/http.c
> index 0c9a872809..be564fd520 100644
> --- a/http.c
> +++ b/http.c
> @@ -1256,10 +1256,15 @@ static void set_from_env(char **var, const char *=
envname)
>         }
>  }
>
> +static void set_long_from_env(long *var, const char *envname)
> +{
> +       const char *val =3D getenv(envname);
> +       if (val)
> +               *var =3D strtol(val, NULL, 10);
> +}
> +
>  void http_init(struct remote *remote, const char *url, int proactive_aut=
h)
>  {
> -       char *low_speed_limit;
> -       char *low_speed_time;
>         char *normalized_url;
>         struct urlmatch_config config =3D URLMATCH_CONFIG_INIT;
>
> @@ -1338,12 +1343,8 @@ void http_init(struct remote *remote, const char *=
url, int proactive_auth)
>
>         set_from_env(&user_agent, "GIT_HTTP_USER_AGENT");
>
> -       low_speed_limit =3D getenv("GIT_HTTP_LOW_SPEED_LIMIT");
> -       if (low_speed_limit)
> -               curl_low_speed_limit =3D strtol(low_speed_limit, NULL, 10=
);
> -       low_speed_time =3D getenv("GIT_HTTP_LOW_SPEED_TIME");
> -       if (low_speed_time)
> -               curl_low_speed_time =3D strtol(low_speed_time, NULL, 10);
> +       set_long_from_env(&curl_low_speed_limit, "GIT_HTTP_LOW_SPEED_LIMI=
T");
> +       set_long_from_env(&curl_low_speed_time, "GIT_HTTP_LOW_SPEED_TIME"=
);
>
>         if (curl_ssl_verify =3D=3D -1)
>                 curl_ssl_verify =3D 1;
> --
> 2.49.0.3.gbb7a4a684c.dirty

No behavioral changes, just the use of a new convenience function;
simple enough.
