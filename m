Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F7C81E
	for <git@vger.kernel.org>; Sat, 29 Mar 2025 00:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743207833; cv=none; b=L20v00r+MDin1GlPg4InMxG9kZo3CBsfIpZeHKp2No0l0BNdDKBzFHEwTdYhLjRlSauQnOxdsk17Qb9QcKeCz0OxaO/wZCv6DN92klx9AIjJ5Ps/M7F9PMlSLUpzuP/cUxUiy+jLH2OisOVba+FDmAQ6wYEGLHICjycd1oQyckk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743207833; c=relaxed/simple;
	bh=c/8NsZ14AjC7qFi3wkFGJFSnTKegeLSl7lIfSvAzkz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ucvE9+XjtFIxeoqHzbcThr6GxX3ef9GvKsYDH6P12LlrUBhEaI7HoUHh0a5bVZlVinoc4J+vA+VkjRIZZJbCM1Z9K+zEgP9WhSkHuLUbpIsh9T+jFZUjTT2OAcCS8yBLjFb6K2tKoZFCbNrt018k9lCxnvjftwm2xvBR8W5l7yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXt1RHSE; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXt1RHSE"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5ed43460d6bso4594251a12.0
        for <git@vger.kernel.org>; Fri, 28 Mar 2025 17:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743207830; x=1743812630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfGROJGm6FpCmEuXxxyC7br72ftRQW5DNgfYZh2nKx4=;
        b=aXt1RHSEnzS1XgmUVQQhQI6tl2immfrkeJpyVKWL1ytd0fK3wY0eeP+BAgstwOR4H1
         GaJzjB7e+GX2ukPl4N4/8nRSMkq/qsQbTAVdMBIIX/f1+bw5UW4EUHUbRnwlgHwL/W9W
         sayg7lsVECpqu1yKuUrMKuQXWrWlyJnOGFK+1/4zVBkkL1itFNaV2UHWv5+zDGj6+rts
         wyAHZ02ePg8KvcUBTAFjQowV6d3yp/v2M7iffDzQDxauatW1+9d/xlVnavd5BbIbfAy4
         RDRDb6Amn+NQvsYb3+KQbyT5Sw0zEjMlm3b4l+DkpLTg/Yi9iBPxVI3299BbPwIvJsCU
         tEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743207830; x=1743812630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OfGROJGm6FpCmEuXxxyC7br72ftRQW5DNgfYZh2nKx4=;
        b=kIih5mLSOSyo0ZgvMGkP65Hj9x5TLziUozRF7zOx82qQ678o5Aj5Y35nfpNTEDgOkf
         Uu8UyQD6evDktmFjaNfSssVwO2sASHJXdBvFpFVo6KWv6ccGFY25GoMd66FV8CB4GudX
         3sPcQm9AjVdr+MzCKSZhwGpK9EC1Vi1EYlvEm+S7kFUuWLuNdKj1ZkgRYhJTZtkam3hL
         w7uy0H0eK/VkgcDPCy9WHnT+a5wzgiIS6wvcu5adl/U95XmrIRr4cSkDLNAz+sWpbUHj
         dHZ68EU6MLMIxWzClNgW7Zf2iHY+JhoHx5S0d33vP9ZQHw6q+D3ZROHVxQOlrw4zC/+d
         prKQ==
X-Gm-Message-State: AOJu0YyITSjxqaZpYbg3G+wid+0mjlsRdjrqs85VeePtq/iFBy6IZMhe
	COhLPON4cVGH19tkZI0zIT9id/lEku8qHaIh0SKJPN5iJdrN8hVVxAX1ULW+C/Q08YVL1KakoE1
	2cq+Y1xD0zfld4+lOM6ahDGoUrGIJ8g==
X-Gm-Gg: ASbGncsBgmA2lP52AxbHYLwGsuElZN8mpzO3xhN7Mr4veRtyvNulh0dVehZJpBZpFcp
	PccS4HSSa3AmeoVb+IPEBDvyPRr/x4LSgEnwm0NTvlKcdTnXiEVWHjTBFqu6FhSRtMMpd3CQpbz
	rASz7iftv5x1LexZgZT+nS1gT7s3kcRfpT39GHUf+hFpCm1EF8WDGKgKBBElx3
X-Google-Smtp-Source: AGHT+IEqRRUy9Gnht2jOpTd+0PzPNaMaPSAgoEz+N9ntDjo32ddENFmG1Dk8PnqUSXe9CKXPsDp702GdCgRdaihPtmY=
X-Received: by 2002:a05:6402:2350:b0:5e0:9252:3550 with SMTP id
 4fb4d7f45d1cf-5edfcc0796cmr1022118a12.2.1743207830232; Fri, 28 Mar 2025
 17:23:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325222311.400748-1-greenfoo@u92.eu> <20250325222311.400748-2-greenfoo@u92.eu>
In-Reply-To: <20250325222311.400748-2-greenfoo@u92.eu>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Fri, 28 Mar 2025 20:23:37 -0400
X-Gm-Features: AQ5f1JpnRERLZw8X9sye8DFR3XRMjLs6TQF7JxCQfpEPwW4vPtEsyf7boPVSamw
Message-ID: <CALnO6CC9M3nBoA-D7rLW_68VkKm9eZ_K7CZn1Z-BiPJWxgNYHQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mergetools: vimdiff: fix layout where REMOTE is the target
To: Fernando Ramos <greenfoo@u92.eu>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	kawarimidoll <kawarimidoll+git@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 6:24=E2=80=AFPM Fernando Ramos <greenfoo@u92.eu> wr=
ote:
>
> "mergetool.vimdiff.layout" is used to define the vim layout (ie. how
> windows, tabs and buffers are physically organized) when resolving
> conflicts.
>
> For example, if we set it to this:
>
>     "(LOCAL,BASE,REMOTE)/MERGED"
>
> ...vim will open and show this layout:
>
>     ------------------------------------------
>     |             |           |              |
>     |   LOCAL     |   BASE    |   REMOTE     |
>     |             |           |              |
>     ------------------------------------------
>     |                                        |
>     |                MERGED                  |
>     |                                        |
>     ------------------------------------------
>
> By default, whatever ends up been written to the "MERGED" window will
> become the file which conflict we are resolving.
>
> However, it is possible to use the "@" symbol to specify a different
> one.  For example, if we use this slightly different version of the
> previously used string:
>
>     "(LOCAL,BASE,@REMOTE)/MERGED"
>
> ...then the user should proceed to edit the contents of the top right
> window (instead of the bottom window) as *that* is what will become the
> conflicts free file once vim is closed.
>
> Before this commit, the "@" marker worked for all targets *except* for
> "REMOTE". In other words, these worked as expected:
>
>     "(@LOCAL,BASE,REMOTE)/MERGED"
>     "(LOCAL,@BASE,REMOTE)/MERGED"
>     "(LOCAL,BASE,REMOTE)/@MERGED"
>
> ...but this didn't:
>
>     "(LOCAL,BASE,@REMOTE)/MERGED"
>
> This commit fixes that.
>
> Reported-by: kawarimidoll <kawarimidoll+git@gmail.com>
> Suggested-by: D. Ben Knoble <ben.knoble@gmail.com>
> Signed-off-by: Fernando Ramos <greenfoo@u92.eu>
> ---
>  mergetools/vimdiff | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mergetools/vimdiff b/mergetools/vimdiff
> index ffc9be86c8..0e3785d230 100644
> --- a/mergetools/vimdiff
> +++ b/mergetools/vimdiff
> @@ -305,6 +305,9 @@ gen_cmd () {
>         elif echo "$LAYOUT" | grep @BASE >/dev/null
>         then
>                 FINAL_TARGET=3D"BASE"
> +       elif echo "$LAYOUT" | grep @REMOTE >/dev/null
> +       then
> +               FINAL_TARGET=3D"REMOTE"
>         else
>                 FINAL_TARGET=3D"MERGED"
>         fi
> --
> 2.49.0
>

This looks pretty obviously correct to me, thanks!
