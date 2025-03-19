Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE64202C5C
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 22:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742424566; cv=none; b=ect8ZmwSFktX4vBJnVQywAxFnPX1JTtNjROuNXCQGNns8fDG15ejX/5eJTo5Y3WFmvRRhc1YJvtOxw/ulbUCaQReXmY+Il42cu67k6EO/8s3u26jaH6woTPNuQd6Lt3VeNVWTEajyXYedXk3BmmUNPUAXsiHKapR2CEIIACim5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742424566; c=relaxed/simple;
	bh=sL2T3X+s/gf5io8lsKjbyVWyLdT6yKhHh6aqsHTi8io=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hX/W4wpH+/eWou+HLSVt+y8aYFx3xf6l9ZSUDBUJ7iPa7LR2NQKaiOiDDiabif7D2z7MrDo+hCXIeGax5JWxxZZUqxPBigjToN2mDTaKUxJSyB+I/TTYC1Yo41y5cP8lOYJqoqexAItGjxxrCnuAXs1GR2gk5Q9wK3zJz7UMCT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WD54SlCa; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WD54SlCa"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3d45875d440so1408305ab.0
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 15:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742424564; x=1743029364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttTsU6sJg2ORrLMatToTxz6J7aEGQ70sknjnbCrKgfg=;
        b=WD54SlCaciacsy5ixpLZt8V0cFQB4SBvPoBUgwaA3Qugj9egmK72SdHIGCyWzOVuHK
         A85MoBjTj75XLKQPxjuog2RATw8fQU9UKcpn10LU/R1+MD2ua8V7oLGEFjBl5z84FsEX
         toWasKb+kyXwEvZPA8qRIUQ8JRPwfDL+J2JciZQGqlbH1IZsMoyFfm/xNI0L+4J62vn6
         wEMVZM0AM8N5mRyHu8ye4tSe1o+ZeDfyKiTMx5eqsfaBctQkLggSyg41BSZcpVwEetdU
         DHTDDw+6I7w7IYG0jzlXhBB6Dehk3mgErkF2nKBMKupJIkzQI6txoudNMaXytqFeTeiH
         F8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742424564; x=1743029364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ttTsU6sJg2ORrLMatToTxz6J7aEGQ70sknjnbCrKgfg=;
        b=VKl6LLTSoB4mR4U/mlltodqpH1BZRftNW2HSic3Q7lsKjBOfVd7d9tniuaUCrbfOuA
         JMsS4IjvK1UE3kAwJI06Dv1xYqH6gW7PzKtHa6nuDXz7sumGsTQmYlzn2EXP4Jy4yssl
         k2rwVrODHfnoWGUcsw9TKOFkcf+h6cba9ReG0SY6fs18zhprFt6OAcm6ojL8sNQm7LZW
         22FKjFrP2s1SunYLu95mMceQByuxY+vGgrZUKifF20+5CxM02mwjMUs8RoZ5Ph3Tx9Fp
         NOtwERzXW1wtxF32hoOiQ8m7W3uSQWz545XSuK9eqfrHes6Df6WntPCblnB5rpMZPJay
         U+Ng==
X-Gm-Message-State: AOJu0YzEzaA5Kk5YqHgUtkXi46ReTEnNnN6Q4QZ4sNGi4Ac7S6pae+GO
	EMh1MoPyoByCdNHRD+oHe+Y7NzGdCzDrJ826vA+PXKqJps6QwPYDXQC42oBQENV2e+ZTiChmatV
	l9qIAu1ZHnpIaugcm/TCtSQEPvds=
X-Gm-Gg: ASbGnctwe33sTsDJVr42yPttkJyJlpFZUw3wN3/GVHNqfHUyLLWEWXRQDqGpYypqxIv
	EFkQdlkGK9PwMX8sqoS6j1XmNE8n+WT+whxi8jNw8qinulP7iD5bFfTrUXKcLhC4uCYjNCKxEQK
	hWcnRFxuk2UtCRkk3c2LhI3xNUneP5UFdLQfgph6nIlnAgLD4JSUtQUNWkjQ==
X-Google-Smtp-Source: AGHT+IGMFPR2F/+0pPzkUOHCfzwnYlDgT8Cb+ose2LE5mlDkYIqmG6PswpYoUx11ncd5mEKBwzCfm7vltImEe4AhSHM=
X-Received: by 2002:a05:6602:2767:b0:85b:4ad2:16ef with SMTP id
 ca18e2360f4ac-85e1385b0cfmr528542639f.9.1742424563856; Wed, 19 Mar 2025
 15:49:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1742336481.git.me@ttaylorr.com> <cover.1742423021.git.me@ttaylorr.com>
In-Reply-To: <cover.1742423021.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 19 Mar 2025 15:49:12 -0700
X-Gm-Features: AQ5f1JriL-FsFNm8IDS3vUJkUNBm8AaW8cqvQoW0loCzVdwlWfNwyIw-VFcKie8
Message-ID: <CABPp-BEn+NfGu1c=ZWjwnFBJgmsxRVSq+Roin-KDQGqKPdDhCg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] http: support fine-tuning curl's keepalive behavior
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 3:37=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> Here's a reroll of my series to introduce new http.* knobs to control
> curl's TCP keepalive behavior.
>
> This reroll is mostly minor, with the notable differences being limited
> to:
>
>   - Added error handling in the new http.c::set_long_from_env().
>
>   - Removed unnecessary casts from int -> long.
>
>   - Only set CURLOPT_TCP_KEEPCNT when compiled with a version of curl
>     that knows about that option to begin with (>8.9.0).
>
> As usual, a range-diff is included below for convenience. Thanks again
> for reviewing!
>
> =3D=3D Original cover letter
>
> This short series introduces a few new http.* configuration options to
> control curl's behavior around TCP keepalive packets. The details are
> spelled out in the final patch, but the gist is:
>
>   - http.keepAliveIdle specifies how long in seconds to wait on an idle
>     connection before beginning to send keepalive packets.
>
>   - http.keepAliveInterval does the same but controls the interval
>     between successive keepalive packets.
>
>   - http.keepAliveCount specifies how many keepalive packets to send
>     before closing down the connection.
>
> The first two commits of the series are general code clean-up of a
> couple of small things I noticed while reading through the http.c code,
> and the final patch implements these new options.
>
> I couldn't think of a great way to test these new configuration
> settings, and given the simplicity of the final patch I opted for no
> tests there. But if someone has a good idea of how to test this
> behavior, please let me know.
>
> In either case, thanks in advance for your review!
>
> Taylor Blau (4):
>   http.c: remove unnecessary casts to long
>   http.c: introduce `set_long_from_env()` for convenience
>   http.c: inline `set_curl_keepalive()`
>   http.c: allow custom TCP keepalive behavior via config
>
>  Documentation/config/http.adoc | 18 ++++++++
>  git-curl-compat.h              |  7 ++++
>  http.c                         | 75 ++++++++++++++++++++++++++--------
>  3 files changed, 84 insertions(+), 16 deletions(-)
>
> Range-diff against v1:
> -:  ---------- > 1:  204e5e18d2 http.c: remove unnecessary casts to long
> 1:  ba22a121fa ! 2:  2e39a78e87 http.c: introduce `set_long_from_env()` f=
or convenience
>     @@ Commit message
>          Replace those two instances with a new cousin of 'set_from_env()=
' called
>          'set_long_from_env()', which does what its name suggests. This a=
llows us
>          to remove the temporary variables and clean up some minor code
>     -    duplication. More importantly, however, it prepares us for a fut=
ure
>     -    commit which will introduce more instances of assigning an envir=
onment
>     -    variable to a long.
>     +    duplication while also adding more robust error handling.
>     +
>     +    More importantly, however, it prepares us for a future commit wh=
ich will
>     +    introduce more instances of assigning an environment variable to=
 a long.
>
>          Signed-off-by: Taylor Blau <me@ttaylorr.com>
>
>     @@ http.c: static void set_from_env(char **var, const char *envname)
>      +static void set_long_from_env(long *var, const char *envname)
>      +{
>      +  const char *val =3D getenv(envname);
>     -+  if (val)
>     -+          *var =3D strtol(val, NULL, 10);
>     ++  if (val) {
>     ++          long tmp;
>     ++          char *endp;
>     ++          int saved_errno =3D errno;
>     ++
>     ++          errno =3D 0;
>     ++          tmp =3D strtol(val, &endp, 10);
>     ++
>     ++          if (errno)
>     ++                  warning_errno(_("failed to parse %s"), envname);
>     ++          else if (*endp || endp =3D=3D val)
>     ++                  warning(_("failed to parse %s"), envname);
>     ++          else
>     ++                  *var =3D tmp;
>     ++
>     ++          errno =3D saved_errno;
>     ++  }
>      +}
>      +
>       void http_init(struct remote *remote, const char *url, int proactiv=
e_auth)
> 2:  a05269552f =3D 3:  cdfc9baa8d http.c: inline `set_curl_keepalive()`
> 3:  d840415808 ! 4:  3fe62181e5 http.c: allow custom TCP keepalive behavi=
or via config
>     @@ Commit message
>          keepalive behavior, expose configuration and environment variabl=
es which
>          allow setting curl's KEEPIDLE, KEEPINTVL, and KEEPCNT options.
>
>     +    Note that while KEEPIDLE and KEEPINTVL were added in curl 7.25.0=
,
>     +    KEEPCNT was added much more recently in curl 8.9.0. Per f7c09406=
0c
>     +    (git-curl-compat: remove check for curl 7.25.0, 2024-10-23), bot=
h
>     +    KEEPIDLE and KEEPINTVL are set unconditionally. But since we may=
 be
>     +    compiled with a curl that isn't as new as 8.9.0, only set KEEPCN=
T when
>     +    we have CURLOPT_TCP_KEEPCNT to begin with.
>     +
>          Signed-off-by: Taylor Blau <me@ttaylorr.com>
>
>       ## Documentation/config/http.adoc ##
>     @@ Documentation/config/http.adoc: http.lowSpeedLimit, http.lowSpeedT=
ime::
>         A boolean which disables using of EPSV ftp command by curl.
>         This can be helpful with some "poor" ftp servers which don't
>
>     + ## git-curl-compat.h ##
>     +@@
>     + #define GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR 1
>     + #endif
>     +
>     ++/**
>     ++ * CURLOPT_TCP_KEEPCNT was added in 8.9.0, released in July, 2024.
>     ++ */
>     ++#if LIBCURL_VERSION_NUM >=3D 0x080900
>     ++#define GIT_CURL_HAVE_CURLOPT_TCP_KEEPCNT
>     ++#endif
>     ++
>     + #endif
>     +
>       ## http.c ##
>      @@ http.c: static struct {
>       };
>     @@ http.c: static int http_options(const char *var, const char *value=
,
>         }
>
>      +  if (!strcmp("http.keepaliveidle", var)) {
>     -+          curl_tcp_keepidle =3D (long)git_config_int(var, value, ct=
x->kvi);
>     ++          curl_tcp_keepidle =3D git_config_int(var, value, ctx->kvi=
);
>      +          return 0;
>      +  }
>      +  if (!strcmp("http.keepaliveinterval", var)) {
>     -+          curl_tcp_keepintvl =3D (long)git_config_int(var, value, c=
tx->kvi);
>     ++          curl_tcp_keepintvl =3D git_config_int(var, value, ctx->kv=
i);
>      +          return 0;
>      +  }
>      +  if (!strcmp("http.keepalivecount", var)) {
>     -+          curl_tcp_keepcnt =3D (long)git_config_int(var, value, ctx=
->kvi);
>     ++          curl_tcp_keepcnt =3D git_config_int(var, value, ctx->kvi)=
;
>      +          return 0;
>      +  }
>      +
>     @@ http.c: static CURL *get_curl_handle(void)
>      +  if (curl_tcp_keepintvl > -1)
>      +          curl_easy_setopt(result, CURLOPT_TCP_KEEPINTVL,
>      +                           curl_tcp_keepintvl);
>     ++#ifdef GIT_CURL_HAVE_CURLOPT_TCP_KEEPCNT
>      +  if (curl_tcp_keepcnt > -1)
>      +          curl_easy_setopt(result, CURLOPT_TCP_KEEPCNT, curl_tcp_ke=
epcnt);
>     ++#endif
>      +
>         return result;
>       }
>
> base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
> --
> 2.49.0.4.ge59cf92f8d

The new patch and range-diff look good to me.
