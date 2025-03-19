Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E4442048
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 16:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742400096; cv=none; b=BiYMW5HXpzS/ehkblL98ZIac9u7v9Cghezqn1TkIR3E0Vop9X6nFKaA/d5UN0M1v7yVKcqNqS3jOTjbkkHYEBLxwJ/ruDOWwdtTvDVc9zr2HFRHor06NxlN3ojYS+xujLmktGJmq/1SsHxiVXMcgvRK73xCb4+csHD6QWD3IfTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742400096; c=relaxed/simple;
	bh=UA710YOwrQMFY1ohPIE994Z0vbdwGSqNXYDJt7RgV5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ka+jSFe0Nsq/QP+yIhDAiqnsXnVuKJdHi0rlPAgMGi2Uhdgt4mHb1GDyCthBRQ7aV2ln3yAxPIYtlB2jD3dcTc1pnEMemJqYjeM8BiLNsmz48chVIFPcrISO86dwbvb04A8na3jPU4hT7dcCrRMU8pUpC2E5TlIsdSRNrK6BJvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6VWil9B; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6VWil9B"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-85b515e4521so217174639f.1
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 09:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742400094; x=1743004894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQGUfYLiKh2/Xb0yzOQLMorV7bSvWvgw4pDMuy4aRa8=;
        b=e6VWil9BjHWiABwMEpL26SqNAQIVrBjmTyVKCTrY6pQYTpJ2I9Bp6Goutd4mH9PGie
         tkepeU36D5VEVjwMeGBtlB7u84iqE0Wa/NKMT2bXiuuuZQd/+DqEX4BOeCRofFw98t5i
         FU1l1zKY0gXpgDc8KkKjgROwsamBVgEcyUfc0qv4efD3OvKmUSNm7TUHvAiIVsUtH/HV
         eUnD6ePmmTwY6ioI2gAc521pIdFsf6NSAA/qf86knSzUzSqO/+dRcjvm8BaULK+KPOFW
         QkmpIZkReuruPsdRe0OWPvK2SpHU7cLqTA77rou/Mjo+7641YqkSZ7n/RbpNH+eLs3Tw
         SHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742400094; x=1743004894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQGUfYLiKh2/Xb0yzOQLMorV7bSvWvgw4pDMuy4aRa8=;
        b=FPlESipM4EjWa4wuyQ26NJEUx1aH8fvwE8BCdGsYvwVcOtojTTMYpa8oV5aarFrKK7
         183+sLEH8OZOkePxrsCwzYQReSArG5kCAdaRYdj9dlHjeyxhFI8krGYpPhZEwXR1d6yA
         8Lwt6V1QEK9ljU85sOOhqTtRuIFd2tFsIHpL6V72HHeVma7lqpYT2iuZHwU7hlhngdY4
         cN+SQBU1j7MWbCj2hWb2IdQmSBjQ0XDHGaakILlYzDYlhodYq0Fc4vRoNOlntxwkk9T5
         8iYeEcqvpX4U8BgT0Sc6xNNvNriCDKdMJczeRusiD4T94AJy78NKSYVSlbBc4qpBYywj
         pESg==
X-Gm-Message-State: AOJu0YxkJDVUqAz8QjSPs2wRvu8GY1zvbV+RRlss/R8bW3Ax1dwbZUH2
	t07wNRrPJTCzyOKS4ZvCDHAsHKmd77bcvNdp5QymQcYWAjZENBd21rBQnBKsV/QhHukbkLx2Mo9
	uv55DHZWpOvUhT9ZaBhEToVVzOqc=
X-Gm-Gg: ASbGncs3sQz+QeML28bTRVsRQjPTnYdaoaO+nhL4x1tKQQXSbjSGksifsZyB59XbO2K
	nZY4x4YZuYUzdfq8cCt/y1zcMSn7IiGxreE4qnX6W1MWdwPBx/sMS6/H2O4k9KINbwwaLTzbJzK
	pIS0P+wFpWhr871+TLnR8pI1cW/4ECWR7bt6lmzbw=
X-Google-Smtp-Source: AGHT+IGgrZpGTtft8UIJQq9hk6nrVNjOxyzTyu+mtmoP7YC25bQA8cgLD2gZW81GP93jsklmI9TIk9N13DOoLnFwgZs=
X-Received: by 2002:a05:6602:3a89:b0:85b:46b5:6fb5 with SMTP id
 ca18e2360f4ac-85e1384abb6mr389927439f.11.1742400093561; Wed, 19 Mar 2025
 09:01:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1742336481.git.me@ttaylorr.com> <a05269552fc2c17519b935c3b9c279c2e231c5c5.1742336481.git.me@ttaylorr.com>
In-Reply-To: <a05269552fc2c17519b935c3b9c279c2e231c5c5.1742336481.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 19 Mar 2025 09:01:22 -0700
X-Gm-Features: AQ5f1JpP5vEakZXXPqKt_mElM12atwKtWnnD1GT0ekL3zq-j1Z1RlHEfBisy1Ug
Message-ID: <CABPp-BEpVhP3rKXAVVZ4MUSsUZUF=YeqA23fnp0-h2S-Hk4bEw@mail.gmail.com>
Subject: Re: [PATCH 2/3] http.c: inline `set_curl_keepalive()`
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 3:21=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> At the end of `get_curl_handle()` we call `set_curl_keepalive()` to
> enable TCP keepalive probes on our CURL handle. `set_curl_keepalive()`
> dates back to 47ce115370 (http: use curl's tcp keepalive if available,
> 2013-10-14), which conditionally compiled different variants of
> `set_curl_keepalive()` depending on what version of curl we were
> compiled with[^1].
>
> As of f7c094060c (git-curl-compat: remove check for curl 7.25.0,
> 2024-10-23), we no longer conditionally compile `set_curl_keepalive()`
> since we no longer support pre-7.25.0 versions of curl. But the version
> of that function that we kept is really just a thin wrapper around
> setting the TCP_KEEPALIVE option, so there's no reason to keep it in its
> own function.
>
> Inline the definition of `set_curl_keepalive()` to within
> `get_curl_handle()` so that the setup of our CURL handle is
> self-contained.
>
> [1]: The details are spelled out in 47ce115370, but the gist is curl
>   7.25.0 and newer use CURLOPT_TCP_KEEPALIVE, older versions use
>   CURLOPT_SOCKOPTFUNCTION with a custom callback, and older versions
>   that predate even that option do nothing.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  http.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/http.c b/http.c
> index be564fd520..526f9680f9 100644
> --- a/http.c
> +++ b/http.c
> @@ -704,10 +704,6 @@ static int has_proxy_cert_password(void)
>         return 1;
>  }
>
> -static void set_curl_keepalive(CURL *c)
> -{
> -       curl_easy_setopt(c, CURLOPT_TCP_KEEPALIVE, 1);
> -}
>
>  /* Return 1 if redactions have been made, 0 otherwise. */
>  static int redact_sensitive_header(struct strbuf *header, size_t offset)
> @@ -1242,7 +1238,7 @@ static CURL *get_curl_handle(void)
>         }
>         init_curl_proxy_auth(result);
>
> -       set_curl_keepalive(result);
> +       curl_easy_setopt(result, CURLOPT_TCP_KEEPALIVE, 1);
>
>         return result;
>  }
> --
> 2.49.0.3.gbb7a4a684c.dirty

In contrast to the last patch, this simply dispenses with rather than
adds a convenience function.  That makes sense in this case, since it
was only a single line of code anyway.
