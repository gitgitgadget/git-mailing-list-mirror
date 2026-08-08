Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119183290A5
	for <git@vger.kernel.org>; Sat,  8 Aug 2026 07:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786173937; cv=pass; b=fRwMZhE+yocwK+M9x2iD5YJSGIjS6Eg+H5kGleBCZYzqiQWl1BtFws/q7XU5vSU7mjHT87EPGidNnX1h1cbd4pfG7X16TQgxL02JoN0Ir/U791CmcO9beWkutdYH0PRHYJv0GyyanetuwIRpf+jGYE1gZLjO6lskyA8rPEAxFWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786173937; c=relaxed/simple;
	bh=4VQAx2KXa70ZM5ry4RpoBX430uBUiUgj7GReD5iOpOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GuSrWDv/8wUscJUWvFZT6u2e1njOkuGIB4DDRf8niutog7cvgqV7B6/njMWSji2EICpSJXpFmc/YKBLxC+BPYjuN3eEi6r0zwZxcllnYimobpQ4+bI9VKQKwWtEjwt/Le+H4LkX7RKZEsVMocHvNaR4eWirP7QTuUAwYlDSbnpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kF3THuYa; arc=pass smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kF3THuYa"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-49c38a4f110so190815b6e.1
        for <git@vger.kernel.org>; Sat, 08 Aug 2026 00:25:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786173935; cv=none;
        d=google.com; s=arc-20260327;
        b=MA2iV31Iq556ysVzLoSluCpUjZ8oGDPbhD5VVOtp3erf6tHE6xSkPIgdZPI6CKjl4V
         AZqkQCkmDuxT+ot7BfHdm2Jy0W1x5dVsbawLdcTrIye+Nii0u+dwE0mBkuHwbywOhFlz
         E+SIdUwr5TeCsc0rAzlKY2GeTH6uNH/sbMZpAZf99rQDquVlGj38JjcDx+ZDUzaAieOl
         MikVSEBF/al1sbwkewtRjl6MWaCK/1ePm25ZncxwGd5RHWGu+vyqSVBTvxF2mZDQhVoq
         6Cy8Cs6/JXUpz/clyzUCu6DX4lBn18U29IfM7xrv0zu8YqbTivFqNQMs5shWyfCnzQmx
         4lAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LXHDZpzQFoxRB66+I6uiT8lflMsmuOQU/CF54SXaJ08=;
        fh=dzZik3sWO5Hm7VdeOg6TogxYFNxNltXRHvX8714ZSR8=;
        b=sq5ojdhTjHz/MJZoVHHu6GnWxKRXDC/goRAtVpu+us9q8ByFlyAm88MIZrXUykwaKl
         LfeSUa1nEBkEcBElu6BWP5vTGdd9Y52hD4QzLD+UfPQtq/j49xTivDlQXGR8BUEuJR2A
         sJ9se5688JN5N96b272EOuTTFVdDMFPHPEltMnPHLOWfkZKqdO2Cs9lMgY2x/qAY7+AZ
         N7LkUoIRGSoHX0k7N2z6QFyA6fKWafx3trms5qdJU/L5+K8bnlw4Hujj/cCf2wyKqIp2
         Q7+uzVNukKatbZAv8wxcUvG2q9KG5bimHB/tllovCeeHYNO/5jU9gxW5M5ckNVnVNMlx
         gzlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786173935; x=1786778735; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LXHDZpzQFoxRB66+I6uiT8lflMsmuOQU/CF54SXaJ08=;
        b=kF3THuYariGU0ikAyOzAybfvxn/u8drhN/xuRAEe6YWvBGN5HWysy7GGcksFr3DvpC
         0vU8RxLJH4zjn4kwbaZ9B2zzyAo9GhI1DdKgPAMOLy5hkcls9q3RNbhl2FakTYKPeRxA
         RpLuey0uybhL4RlWdRMpxoYcT4mycU5XsqoVcRcAIWwoSe41QYV2sn8dRKgIgLnzcRcU
         LzwppZsxHfGDjnUypvsfWZNlMbRqiapTDn6TUI6zurzSZcGOHyIiu/l6cQ3J/dD6qHgk
         /tP/Up92dAxSK4SPsdjg697IFB+ejmg9pZLoaACOEOcs9PFrK8O0+tCWPxCeZFRBOYXs
         aVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786173935; x=1786778735;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LXHDZpzQFoxRB66+I6uiT8lflMsmuOQU/CF54SXaJ08=;
        b=Ix0eOlQkTjS77UI0ek71K7zekz4j25WFvSLdyVaGbqYc6SbyZgwOVAUQRt+gKgwmvH
         kkYmsYn9I1V0b9HkhSD7gb4IN1/9RA3rBbXSNqIcUMny5ks6y5fUyT0U9yGSvNb5dfq1
         RSYHgLpA3OudOwW5NdfZzZpfKeU3kelDe799RqVX92gihqPPJKb4D3y2k65a2m1FzVEt
         tgJARs7WuEWGwql840OzAbq+bd4Tt5MW6XIiKRdZ7c9+PAH4G/c6PAu7zSaEMIRwvF6y
         55v5suRSCWydoOt+yZHifJQTBLvlbeEDOmMfq6fPQDRmGMZREBiuoYzUIUc6kDmDd601
         md9g==
X-Gm-Message-State: AOJu0YyW1Vgk5kmxNqrpTppbve8oJPnTsZ6vKzxKyOrfAhJnCb/d5GBN
	10rXyiJ1kjhvYYn5q+bzawCI5/Ql90oay2TKUNo9PO7lNbLNxPT3xOGdEeEb1bzrlqOsXujeGr1
	WglpSMrAATlqnDqxJ/xp96Kt7zMuW8f0=
X-Gm-Gg: AR+sD10Zg3Q2OHIguVD0RFp+yn+z0uBZhPUM1hfewGY99d1xTc3S0OOY6NfnBSlgDZe
	MDFbyKDMomE3eyD9h/W4d9LC9cBGScrcED9kI6cupcvIAdLQlh5xlQKNrnEK5Leej8o4CgYs2Qj
	FWFKivFH0vdFCsHZMabOgt52RCBTJsY5OwHM91SOjNijQgFjUHpQ5Uep66a9DruyQDFzHbI5Y2c
	q9wTdQCSDHxQCZDSDciEY3hlQDrHeM229dh1U5M4G/xIrg0AN8EaLuyZFaAVYZzJmaHbVYFkthC
	nqFAvnd9LQ808TJW3MIUKufrOFT0ggbqG6om+Haj/GeZyQpx/9lP4Qq3xTproq4Mv0B5KwdoXUb
	QprAl4s6tpJhIJm/m+78LuTxjZ+CE5p1dCWTZZVoU2QHZrHhC0j1v5YKdTJ2xZdg=
X-Received: by 2002:a05:6808:1785:b0:496:11f1:f2b3 with SMTP id
 5614622812f47-4b1a107dfc1mr5912030b6e.20.1786173934836; Sat, 08 Aug 2026
 00:25:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716165517.433849-1-christian.couder@gmail.com>
 <20260804100355.1299498-1-christian.couder@gmail.com> <20260804100355.1299498-3-christian.couder@gmail.com>
In-Reply-To: <20260804100355.1299498-3-christian.couder@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 8 Aug 2026 00:25:22 -0700
X-Gm-Features: AUfX_mx93AL9fG8rIb4MwYzZe2uhAB7-tMsAAZ17jWXLf-6LwUxoxasWuAzYJgw
Message-ID: <CABPp-BGfeF1t+siEUuYgTtDG5LtfL5iskSHferbGwFj8axA+tA@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] api-parse-options.adoc: document per-option flags
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Justin Tobler <jltobler@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 3:04=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> The "Flags" section in "Documentation/technical/api-parse-options.adoc"
> documents the flags that can be passed to parse_options() itself. It
> does not, however, document the flags that can be set on individual
> options through the `flags` member of `struct option` (and through the
> `OPT_*_F()` macro variants).
>
> These per-option flags are used throughout the codebase (for example
> `PARSE_OPT_HIDDEN` is used to hide an option from `-h` while still
> showing it with `--help-all`), but a reader currently has to dig into
> "parse-options.h" to find them.
>
> To remediate that, let's add an "Option flags" subsection to the
> "Data Structure" section, just before the list of option macros.
>
> Let's also make it explicit that these are distinct from the
> parse_options() flags described earlier, and let's describe the `-h`
> versus `--help-all` behavior for `PARSE_OPT_HIDDEN`.
>
> Signed-off-by: Christian Couder <christian.couder@gmail.com>
> ---
>  .../technical/api-parse-options.adoc          | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>
> diff --git a/Documentation/technical/api-parse-options.adoc b/Documentati=
on/technical/api-parse-options.adoc
> index 880eb94642..fb4580e755 100644
> --- a/Documentation/technical/api-parse-options.adoc
> +++ b/Documentation/technical/api-parse-options.adoc
> @@ -150,6 +150,67 @@ Data Structure
>
>  The main data structure is an array of the `option` struct,
>  say `static struct option builtin_add_options[]`.
> +
> +Option flags
> +~~~~~~~~~~~~
> +
> +Each option can carry flags in the `flags` field of its `option`
> +struct. These are per-option flags and are distinct from the
> +`parse_options()` flags described above; they are usually set through
> +the `OPT_*_F()` macro variants (see below) rather than by hand. They
> +are the bitwise-or of:
> +
> +`PARSE_OPT_OPTARG`::
> +       The option's argument is optional, i.e. both `--option` and
> +       `--option=3D<value>` are accepted.
> +
> +`PARSE_OPT_NOARG`::
> +       The option takes no argument at all. Using `--option=3D<value>`
> +       is rejected.
> +
> +`PARSE_OPT_NONEG`::
> +       Disable the automatically generated negated `--no-option`
> +       form.
> +
> +`PARSE_OPT_HIDDEN`::
> +       Hide the option: it is omitted from the usage shown by
> +       `git <cmd> -h`, but is still shown by `git <cmd> --help-all`.
> +       The option is parsed as usual either way. This is meant for
> +       deprecated, advanced or otherwise uncommon options.
> +
> +`PARSE_OPT_LASTARG_DEFAULT`::
> +       Use the default value (`defval`) when the option is used
> +       without an argument, even for an option that normally requires
> +       one. Only the last argument on the command line takes effect.

Is this accurate?  Sufficiently precise?  parse-options.h says

 *   PARSE_OPT_LASTARG_DEFAULT: says that this option will take the default
 *                value if no argument is given when the option
 *                is last on the command line. If the option is
 *                not last it will require an argument.
 *                Should not be used with PARSE_OPT_OPTARG.

If you want to reword that, maybe something like:

        The no-argument form is only accepted when the option is the
        last token on the command line; used earlier, it still
        requires an argument. Should not be combined with
        `PARSE_OPT_OPTARG`.

?

> +
> +`PARSE_OPT_NODASH`::
> +       The option is a single character without a leading dash, such
> +       as the `+` used by some commands.
> +
> +`PARSE_OPT_LITERAL_ARGHELP`::
> +       Use the argument help string (`argh`) verbatim in the usage
> +       output instead of surrounding it with `<>` or `[]`. Useful when
> +       `argh` already contains a hand-formatted description.
> +
> +`PARSE_OPT_FROM_ALIAS`::
> +       Internal flag, set on options that were expanded from a
> +       configured alias. It should not be set by callers.
> +
> +`PARSE_OPT_NOCOMPLETE`::
> +       Do not offer this option for completion.
> +
> +`PARSE_OPT_COMP_ARG`::
> +       The option's argument, rather than the option itself, is what
> +       should be completed.
> +
> +`PARSE_OPT_CMDMODE`::
> +       The option is one of several mutually exclusive "command mode"
> +       options that share the same variable. Using more than one of
> +       them at once is rejected.

Thanks for adding this table; looks helpful.
