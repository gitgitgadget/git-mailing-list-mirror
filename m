Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA73263F47
	for <git@vger.kernel.org>; Mon, 14 Jul 2025 17:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752513623; cv=none; b=NzzejqusgxDYZjF6kyUmOWIpCc3mRcnBfeAv4nscYeYGFv21u777kx5EH+kNlf2OTPLaJqNRBLH45n/1RlEImJWh3M0Bxo8bdkdeyTjYrm7Q9BplipJjqxEacmO2fNYVvvA+IFzJl78UZ9L74Qx4A/57o7Zyj9TJAWlBuOgtgWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752513623; c=relaxed/simple;
	bh=beHdVcw5UiQ4NVFMzn36tJvBeLcmF4E1Fd4Ftvrr4+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qxh09TzpeOhU9+6vVixzib+VwNmdWNON5V6B+LgV0hSeUMkN2HKb1FGz382OuQV7RTRb0alfIQrG+6h1VThlBwVYdOlTd6n3LEzoNcV9N9Be8UBTaILBY9qGeJCkugvuYr5S/QIa00sr9zt+hAB9j4yUX3mKZsP7PGZKEZDTGIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIiLNx0Z; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIiLNx0Z"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3df2e7cdc64so34386645ab.1
        for <git@vger.kernel.org>; Mon, 14 Jul 2025 10:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752513620; x=1753118420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gqq5k0PxCKMSbup7f1daO+MS27lQyUdKivYjvCLkvBQ=;
        b=fIiLNx0ZaAGYsf6S3eHHwMYM72alQvXEmHyakLrJbtXmedPrpKlINDQX1oO0weQyWd
         x2fGpbajV65hbUQ2LGxiaOzANBBKoR6GtC0TVp5pw//wHJ/DlE+y922LZuab9XGmQ+X+
         SR92v+73kVs80S0Y3px01PO21mtuS6e8THvdU5AwZ2RhoKVK3zdlmlaME097yqgCh2eJ
         YMy1Q7SvKU01m9sUnJKjolhnp106G5FZM6hwy7VbE/aYSALE4QsB6JRgNeZCMk7M7FCy
         ekLq4HOigNBITXZIPTRk5cvMhdwdYGxFlQvPfSolVZhie+8sxAJMbP6PluAqKHYv/Jt9
         s19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752513620; x=1753118420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gqq5k0PxCKMSbup7f1daO+MS27lQyUdKivYjvCLkvBQ=;
        b=vv3toAfv64ZzS2Wn62cUD8YIZvjzqKGso2lh84xmgpjE+jbHhskIYci3oj7LSSC5YG
         7sa/Da6CwETzxOk+03pGoNYusupmhprVpmZdbvvTOxLMP2H7Fl6q93QnKUGeaUWbYV4K
         WJd/zhrMx1fXWYBwrT/rTdxBKYh8CMxOlPm9cdgkQrJK3SgONVny2bakgcg5ygv9pMNb
         LCddpQDEIxLxbtO5/CAQpofW+9AvzCAVHUD4qq+SrEefzR5pRT0NSST3XSGHi8Ocjfz6
         ov7Z+zSAFlrE87BGHNAxf7GtsBlip8kGGDr9ESx0bO0VuErZQsUTF4IZ7y1c6maW8AQp
         Hxsw==
X-Gm-Message-State: AOJu0YzF0346oCUWGbMLaFdTRxe9fKfq4SChOspfPdIEawRX6TYp9Y7f
	lej3Egk14mgRMInfa0LJe7Dt/iA8w7aG7gY1pe42kzVNYaDECnjFB3nU/tKLrsoLVuvDd9+S83V
	Xz5PmVYjnjRScO5h7m9Pg/MgKEZ8waJU=
X-Gm-Gg: ASbGncvn0xtqUeZBo1GKcm34cSicel5uT0n7f/yxajtrelXL2de8ITSjiLyCcIqVdOW
	5nxMZmymSsMlXOgtoV3gEs0srw/w6PtzEW8PXZpedtr+ew6qfY6lC04PYpLaXgebto3xLUOl5s8
	YZTqNOTDJ2sPYbOtBWHB2a2PUaISMYVDKu4NPw/RTKZX/vNaMV68EQFeloY4Ld1Xva6QvrRG8XE
	FLuMRjHoUiSAuvC1UO5oHDond7SD8QRrOoyGnsr5G2gvN2Zw0I=
X-Google-Smtp-Source: AGHT+IG7j1a4LW/JxrXaztT3K6FYrzleeXTaQ+wjLM4Qatkk2qpR+o/KRLFPJKKQOfiiLDxyKXoIzNjc2p19utW1E/s=
X-Received: by 2002:a92:c24d:0:b0:3dc:87c7:a5a6 with SMTP id
 e9e14a558f8ab-3e25327847dmr141393735ab.4.1752513620093; Mon, 14 Jul 2025
 10:20:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752499610.git.phillip.wood@dunelm.org.uk> <a0f9182aa20d0f956072a3d185a2d1288f1bd842.1752499610.git.phillip.wood@dunelm.org.uk>
In-Reply-To: <a0f9182aa20d0f956072a3d185a2d1288f1bd842.1752499610.git.phillip.wood@dunelm.org.uk>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 14 Jul 2025 10:20:08 -0700
X-Gm-Features: Ac12FXx0od1k_UP54b-9rIWbFRGBaT-8_jDwaSQfxmR3a2bxzgMaj4B9IJI4MpQ
Message-ID: <CABPp-BEH9rtdPcS9hEXSdCqwydcWbakT59OuQOFUU7DGjPzdVw@mail.gmail.com>
Subject: Re: [PATCH 2/3] git-compat-util: convert string predicates to return bool
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 6:32=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Since 8277dbe987 (git-compat-util: convert skip_{prefix,suffix}{,_mem}
> to bool, 2023-12-16) a number of our sting predicates have been
> returning bool instead of int. Now we've declared that experiment

Now we've -> Now that we've

> a success lets convert the return type the case independent

success lets -> success, let's
type the -> type of the

> skip_iprefix() and skip_iprefix_mem() functions to match the return
> type of their case dependent equivalents. Returning bool instead of

I wonder if case-independent and case-dependent should be hyphenated,
or as separate words as you had them.  Anyone know?

> int makes it clear that these functions are predicates.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  git-compat-util.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 5bd69ec0403..9408f463e31 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -897,35 +897,35 @@ static inline size_t xsize_t(off_t len)
>   * is done via tolower(), so it is strictly ASCII (no multi-byte charact=
ers or
>   * locale-specific conversions).
>   */
> -static inline int skip_iprefix(const char *str, const char *prefix,
> +static inline bool skip_iprefix(const char *str, const char *prefix,
>                                const char **out)
>  {
>         do {
>                 if (!*prefix) {
>                         *out =3D str;
> -                       return 1;
> +                       return true;
>                 }
>         } while (tolower(*str++) =3D=3D tolower(*prefix++));
> -       return 0;
> +       return false;
>  }
>
>  /*
>   * Like skip_prefix_mem, but compare case-insensitively. Note that the
>   * comparison is done via tolower(), so it is strictly ASCII (no multi-b=
yte
>   * characters or locale-specific conversions).
>   */
> -static inline int skip_iprefix_mem(const char *buf, size_t len,
> +static inline bool skip_iprefix_mem(const char *buf, size_t len,
>                                    const char *prefix,
>                                    const char **out, size_t *outlen)
>  {
>         do {
>                 if (!*prefix) {
>                         *out =3D buf;
>                         *outlen =3D len;
> -                       return 1;
> +                       return true;
>                 }
>         } while (len-- > 0 && tolower(*buf++) =3D=3D tolower(*prefix++));
> -       return 0;
> +       return false;
>  }
>
>  static inline int strtoul_ui(char const *s, int base, unsigned int *resu=
lt)
> --
> 2.49.0.897.gfad3eb7d210

Patch looks good.
