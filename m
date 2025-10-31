Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33128199931
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 18:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761936445; cv=none; b=gLTiRg1ml8+pvy+kXwd5OECor1f50QACw0yif2BbdQWONbSPT59HqFIvlz5mRZyoKkSp38r+zYjG8Ai5I/R5FSeQblz0DgQqpSMaKWORKA/VoEqH/X7URTtahmEX4ZmINQNZqzKq4gwW/ZLs8qBdCwN8V+RZVbzb1McIuSulV2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761936445; c=relaxed/simple;
	bh=+NTQfbVT2hPHQStXhKmRCdl8vMx3HqlNOW5XIBdVM4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y6DeeWyT83NmqabAHKuYbS+wPQqRc8FyU7HvR2Pcr8pMFrkhdqBugdKFl2Y/93sOqt/ANBZgnLgIsU7Ssbwa2jzSn8sKJNInFiMezoWU45qm46xggPFQykAFUlwPTqApUOEtsZHpePEkrFP4jM/eeqoUFDQrE/RgfI4csJcr2JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+sIaiPS; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+sIaiPS"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-433100c59dcso4795655ab.0
        for <git@vger.kernel.org>; Fri, 31 Oct 2025 11:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761936443; x=1762541243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjQ0j2vLQ7iSiUPBfbVlVLsSMFzMTZCLj1jAGJbS1Ts=;
        b=J+sIaiPSMmNtFROjWzTWU5eRxGQswxYLu/MpfPJA7Sc3TVgKlSpdza/0qbeAfNjg/B
         JzqRrmfEtFIu8F146mdghu74QLkT4rCgnqXRnDAYULMhlg+AIUTsrU8YRImp5OX72KoJ
         K8x0kKNa+I61rUjfSv1qMkBLkUm+0Y1jGZRTAGu5GZCjGiG4Q8VtM0CGMob0MAOj7zT3
         hJgXju3ZzIPlk0lFYm6LF5KThWJHFY2EtUyJ3A8fh4HKUlB1vEnFzeOgjLmS7CJNqxFn
         ABiTPoiLce1jkTGx8cwbYHtKvmy9m5YGwiwfQid4HxfGPAR403/Eu820RqJXtxvEzF3S
         oj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761936443; x=1762541243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MjQ0j2vLQ7iSiUPBfbVlVLsSMFzMTZCLj1jAGJbS1Ts=;
        b=FkRJP9Yk/PKG6XGpNASBEQ+m6kWJ3hvJMOXasR5BMBc9nqI++uGVtWZtJzJgCohDFa
         AIMzMsKabaw8794OqRbD7ivqVktL4ZiIGiIMdA1ng+ktRVWB905Gb80GfrYkYRz2lS8N
         S7OZtnAveU4w1tkuQ3chPj1NJWtxUwpkGaqFTwqbbsxnVI1MMSaC8/W1s1fMs4K127TY
         EabnGGIPsDDSjHUA56fiLOXgqhrW64a4hV7N6REcb+M79sXuvBaWKWHv5u0wfHjqa6Cp
         L6vhEmNBoAhyxE7bSKI/ffjgRykiYcfIw6nqYS7UgilLWBoFNvAXMAJXlMJI9fiPEuQp
         cOlw==
X-Gm-Message-State: AOJu0YzVQSRK6kFJsrfv5YpBd2l1yY2khAV5P0RkH/5U/q/Bu9GidLKG
	35bNqMcy1Hdu1+/E1xwQ8LiCz/6PeJMLYcEwWmS2XZohvi6t6Ri/3lftZCU+YUgOjqhCMyso85I
	JbSU+dDTWd8BJmVetjHE+7Ni6eO0t9W0=
X-Gm-Gg: ASbGncuwezEqC3xAg+IEurTWTw65/eDq8apLD7eFnffNj0TSZGiFr6PuhLMOKX1GCvj
	JG8TLUZmKDdc8CsvzUcXRsol0YPQsu7hNd87Y5Rr491f0JPSYmCvuaBvyT89gLDssCPa8EmZm2E
	4HnLty6ZI7DMNzy2kIwD0Hm6wI7IRhSR79l3cgej1hgucLLXVZgIqRbTzOgbAm4skoEzrdsVh85
	11yPG0+HZqRPbsvnZ5n9k/gJhwKPZKrMlotKPOniKX4Htt1UE+DbdbQ6arcyloP9dBx3b7J1sJO
	uf6TT0qFSEFJEMu0
X-Google-Smtp-Source: AGHT+IE5PF7lK7xMCgXraOAZynSXtixwjjUXl+eScEhq9APIDXJNpf1a5DwWrVhj3jfWhmPSh/cKFLYn1eQTqDz6mMc=
X-Received: by 2002:a05:6e02:17ce:b0:430:d061:d9f7 with SMTP id
 e9e14a558f8ab-4330d1ea721mr73462405ab.23.1761936443140; Fri, 31 Oct 2025
 11:47:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028214609.10041-1-siddharthasthana31@gmail.com>
 <20251030191931.30837-1-siddharthasthana31@gmail.com> <20251030191931.30837-2-siddharthasthana31@gmail.com>
In-Reply-To: <20251030191931.30837-2-siddharthasthana31@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 31 Oct 2025 11:47:12 -0700
X-Gm-Features: AWmQ_bmJ6kpRjGI8wSPTDawKKX5za2XKfwdQatx3OeZIwSywJ2OJIMQ3rBY-RLk
Message-ID: <CABPp-BHyUFpFEK1YXSYQWEXSAa2fnUTsH9nsf=LgPs=GNQG2RQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] replay: use die_for_incompatible_opt2() for option validation
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, phillip.wood123@gmail.com, 
	phillip.wood@dunelm.org.uk, gitster@pobox.com, ps@pks.im, 
	karthik.188@gmail.com, code@khaugsbakk.name, rybak.a.v@gmail.com, 
	jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com, 
	johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 12:19=E2=80=AFPM Siddharth Asthana
<siddharthasthana31@gmail.com> wrote:
>
> In preparation for adding the --ref-action option, convert option
> validation to use die_for_incompatible_opt2(). This helper provides
> standardized error messages for mutually exclusive options.
>
> The following commit introduces --ref-action which will be incompatible
> with certain other options. Using die_for_incompatible_opt2() now means
> that commit can cleanly add its validation using the same pattern,
> keeping the validation logic consistent and maintainable.
>
> This also aligns git-replay's option handling with how other Git commands
> manage option conflicts, using the established die_for_incompatible_opt*(=
)
> helper family.
>
> Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
> ---
>  builtin/replay.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/replay.c b/builtin/replay.c
> index 6172c8aacc..b64fc72063 100644
> --- a/builtin/replay.c
> +++ b/builtin/replay.c
> @@ -330,9 +330,9 @@ int cmd_replay(int argc,
>                 usage_with_options(replay_usage, replay_options);
>         }
>
> -       if (advance_name_opt && contained)
> -               die(_("options '%s' and '%s' cannot be used together"),
> -                   "--advance", "--contained");
> +       die_for_incompatible_opt2(!!advance_name_opt, "--advance",
> +                                 contained, "--contained");
> +
>         advance_name =3D xstrdup_or_null(advance_name_opt);
>
>         repo_init_revisions(repo, &revs, prefix);
> --
> 2.51.0

Thanks for splitting this one out; looks good.
