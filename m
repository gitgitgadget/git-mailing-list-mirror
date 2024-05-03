Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9689C158207
	for <git@vger.kernel.org>; Fri,  3 May 2024 19:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764422; cv=none; b=AlUpfIYadeZQgefL6ysnmkCnLp49D8u2IQ6mgXDwwhWIk+XAASpP0/WS1QEY73vzDtuph5tYzrTDK0WprW498lpamrBrQ0fJ05SsUrLggB9KYlwrDBIc3oPxaCZg5GNx6ePL/kyGQgDpDbsOzsbtzxHQNSj84NSFCyA0ZFydZio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764422; c=relaxed/simple;
	bh=Ip4bwgsLp25p9IOZiL3HJZdBCGgXP0GjqAOvT3LwcLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sRZArC5vI+/dvHfan91v+Z2a/NllSofJTupgWcCjbNryEUAY3a1Wd7GNP6TAsTzixlALsLLmHRQ8gvCpMxJq6bN8IvbiwIon2eMPBtkQtE+LDnggQ0PRIj/4BNV6SthB7t3a+Qj2xx4cgTkB3+PWyyho0TDgFfSloHyR27NvU7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c862c613fcso3826610b6e.3
        for <git@vger.kernel.org>; Fri, 03 May 2024 12:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714764420; x=1715369220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9nPWNv2SQYx3bcFDZx1ikKDfmm90b6UqEhQ10gnVX2E=;
        b=sBT6W6RDcBDSOfOLMGrRlMnRHDsVQKzAJvnhHU9GP1Z1whF898+rOtqgH4osBKvDYl
         eL6VHE+tk3Sju0v2aIK+KKzeC0NuFABkS1FRv18QRYW8xfvimhNFKsg3H8vtrFS/0NuA
         rn/CTflvKIQDou/Twioy0kG28xruyJ6UQ3wax7Sk7E1MFsJZQ2Q/CuYcESBuI1up89Pd
         WQ13mXdUMXhX+cADl2RB2rhmwPkCVhPv+WDFAZDLkjaVq8STGAi5mHmzkVuzfMHLund/
         XgZJyoc7P4A+DaQGMK2x+iXyhFR4RPXNkN9g1KP6D2Wh46YRapzHth1enj0djbg6zgmN
         Ksow==
X-Forwarded-Encrypted: i=1; AJvYcCXHdP8RGtIdlJBGS1UuniBdvuqJ9V62/LXs0+T0jPeIwZy9iUqeJo3GduZ7oY6tIlP9Umw8/wlG2WbEmNCC6yrB4037
X-Gm-Message-State: AOJu0YzpZFpSO4g2P6qxER2vTq7tFml8TZn7gbBskNGPMhL7EH6c42Zd
	T5sEukeoStqDT4FiO+XL3oDic8SamWIbCn96S3UM6sbJD25jXaQ/nDvOJ4mKJdeSZBF6oWov2+d
	JNedr4i6moiz8KB1MvawLwStQu0hAlwSj
X-Google-Smtp-Source: AGHT+IEZFVQ+zReCt8pdID8b20hEhX3FZIwqsvM+gbn4OjI6OmMX3vCiHWU1t3k98Mns0j8WYzBu89TVsnFk09a0zPo=
X-Received: by 2002:a05:6808:a9c:b0:3c7:534c:895d with SMTP id
 q28-20020a0568080a9c00b003c7534c895dmr3800555oij.35.1714764419810; Fri, 03
 May 2024 12:26:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430014724.83813-1-james@jamesliu.io> <20240503071706.78109-1-james@jamesliu.io>
 <ab604f4b73eab1d9aae4e2a20ba0630e@manjaro.org> <xmqqjzka7p2t.fsf_-_@gitster.g>
In-Reply-To: <xmqqjzka7p2t.fsf_-_@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 3 May 2024 15:26:48 -0400
Message-ID: <CAPig+cRZEQjwhnMYvQ_0BjvXaR=3x=LQeJHzFOxC+ZPyOy9yJQ@mail.gmail.com>
Subject: Re: Re* [PATCH v4 0/3] advice: add "all" option to disable all hints
To: Junio C Hamano <gitster@pobox.com>
Cc: Dragan Simic <dsimic@manjaro.org>, James Liu <james@jamesliu.io>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 2:00=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
> Dragan Simic <dsimic@manjaro.org> writes:
> > Just a small suggestion...  Perhaps the creation factor needs adjusting
> > for the range diff to actually be produced. [...]
>
> I see this happen to too many series I see on the list.  There are
> cases when the user knows that they are comparing an old and a new
> iterations of the same series, e.g. running it from format-patch.
> We probably should use a much higher creation factor than default to
> run range-diff in such a context.
>
> IOW, this shouldn't have to be done by individual users, but by the
> tool.
>
> Perhaps something along this line may not be a bad idea.
>
> ----- >8 --------- >8 --------- >8 --------- >8 -----
> Subject: [PATCH] format-patch: run range-diff with larger creation-factor
>
> We see too often that a range-diff added to format-patch output
> shows too many "unmatched" patches.  This is because the default
> value for creation-factor is set to a relatively low value.
>
> It may be justified for other uses (like you have a yet-to-be-sent
> new iteration of your series, and compare it against the 'seen'
> branch that has an older iteration, probably with the '--left-only'
> option, to pick out only your patches while ignoring the others) of
> "range-diff" command, but when the command is run as part of the
> format-patch, the user _knows_ and expects that the patches in the
> old and the new iterations roughly correspond to each other, so we
> can and should use a much higher default.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

=C3=86var had posted[1] pretty much the exact same patch a few years ago.
At the time, I had trouble understanding why `git range-diff` and `git
format-patch --range-dif` would need separate default creation
factors[2], and I still have trouble understanding why they should be
different. Aren't both commands addressing the same use-case of
comparing one version of a series against a subsequent version? In
your response[3], you seemed to agree with that observation and
suggested instead simply increasing the default creation factor for
both commands (which sounds reasonable to me).

[1]: https://lore.kernel.org/git/87y35g9l18.fsf@evledraar.gmail.com/
[2]: https://lore.kernel.org/git/CAPig+cRMiEcXVRYrgp+B3tcDreh41-a5_k0zABe+H=
Nce0G=3DCyw@mail.gmail.com/
[3]: https://lore.kernel.org/git/xmqqzhps4uyq.fsf@gitster-ct.c.googlers.com=
/

> ---
> diff --git c/builtin/log.c w/builtin/log.c
> index 4da7399905..7a019476c3 100644
> --- c/builtin/log.c
> +++ w/builtin/log.c
> @@ -2294,7 +2294,7 @@ int cmd_format_patch(int argc, const char **argv, c=
onst char *prefix)
>         if (creation_factor < 0)
> -               creation_factor =3D RANGE_DIFF_CREATION_FACTOR_DEFAULT;
> +               creation_factor =3D CREATION_FACTOR_FOR_THE_SAME_SERIES;
>         else if (!rdiff_prev)
>                 die(_("the option '%s' requires '%s'"), "--creation-facto=
r", "--range-diff");
> diff --git c/range-diff.h w/range-diff.h
> index 04ffe217be..2f69f6a434 100644
> --- c/range-diff.h
> +++ w/range-diff.h
> @@ -6,6 +6,12 @@
>  #define RANGE_DIFF_CREATION_FACTOR_DEFAULT 60
>
> +/*
> + * A much higher value than the default, when we KNOW we are comparing
> + * the same series (e.g., used when format-patch calls range-diff).
> + */
> +#define CREATION_FACTOR_FOR_THE_SAME_SERIES 999
