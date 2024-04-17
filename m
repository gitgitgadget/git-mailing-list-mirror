Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612317EF1B
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 08:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713343010; cv=none; b=rNHUgRI2PHbs8A3wFk3U9MMniq1Xy91GVQNhppuyRofQorgs00b5nAdatN0ZieBmjAHWlbmROmxtDiVWyeIPbpD2d6IFayiuEJA/yk5mw1+MxynbrkNMwbfmoJBXOWrjWV24aWgnndqtbYFBjqReWw2lL689DYv1p/cpaLKLIvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713343010; c=relaxed/simple;
	bh=zxC6pDEPQDOgvP1lpIBSI91OSw2c7tTcxy6Me7M3bOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C9BB8ExIJf1AlED+vHp+PLX+KzOc0qztH3roEdmBOOsEnRrLEYQg/gMQOuVARVg1C5ZD292jvS1D+cSRiIYRO4pGrG305eYMAm2dIP4ylqw6Zy4mXX2u6Es1RtAlH/om8sJ1ViU0IBHVk4lL/Z10wcE+LK15saV17Wn8FngfT7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-78a26aaefc8so306906385a.1
        for <git@vger.kernel.org>; Wed, 17 Apr 2024 01:36:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713343007; x=1713947807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cfIjEwnqEDXeqAN6cyme2vqoVC5SRQQMQrYoS1NiX4U=;
        b=PFXWVU1WkxWrlTe+xsUZkdVQKpN/RSQC6POgMvU3vHpKngM4Bw+684+1hR4YwMKdc+
         3dKIbVuMw/bSLI3hzt+MLVIUv/Gf6xJoPZC9A80dMWunSZ7as7aEEbLPwoO0AgNO7Iir
         GjeEiR/1QMNB9PpdlhKGrDZCP4n9SzAyVG38DDNpW9aG0ku1QG92UIGuMfdSHku7nZ71
         kpZn2hiaRg2ufkkMh+tKHcAcAf2APQBXO7NvGWGwPwhvSRv9Q7wrgsIuNKxLkCcFLjsF
         gk2PsU2IhuqEIt+l3/Oi9LlS4nlDTGQXvHe85FBKErrjD7OoIF/pVNNZADi5mm4uyKTv
         DROw==
X-Gm-Message-State: AOJu0Yz+SNh7JrL0tjRGqvITq/1EKQ1OCwfi/b8yVxtKIcRTTFeJUXZe
	4Iv/kHtwu3nIQ3SlRLthKpx+KrSj3Wy3b1VP512MDwXmnmZ6zJpj/WxShOevc68JF/oufzmidbT
	Tk5USvIabYaAvg22FEXOTwc5PeeE=
X-Google-Smtp-Source: AGHT+IGwQwYzrVaKXKmxZb+rU+BoEIopZtgFVn8iTK/1KkF/kbQjqFXinj2awd1U9KywEeSq3i6Wu7+yvPg65CSzA80=
X-Received: by 2002:a0c:f84a:0:b0:69b:7ac8:4144 with SMTP id
 g10-20020a0cf84a000000b0069b7ac84144mr8710494qvo.48.1713343007218; Wed, 17
 Apr 2024 01:36:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1719.git.1713342535.gitgitgadget@gmail.com> <6721e3ada5d125bd6c33561c694acb986b17b38f.1713342535.git.gitgitgadget@gmail.com>
In-Reply-To: <6721e3ada5d125bd6c33561c694acb986b17b38f.1713342535.git.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 17 Apr 2024 04:36:36 -0400
Message-ID: <CAPig+cSjoGe7Eeynz=jGSaNYWXQ-VkvWv7mv1NDeCXPFEtdqOA@mail.gmail.com>
Subject: Re: [PATCH 1/2] for-each-repo: optionally keep going on an error
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 4:29=E2=80=AFAM Johannes Schindelin via GitGitGadge=
t
<gitgitgadget@gmail.com> wrote:
> In https://github.com/microsoft/git/issues/623, it was reported that
> the regularly scheduled maintenance stops if one repo in the middle of
> the list was found to be missing.
>
> This is undesirable, and points out a gap in the design of `git
> for-each-repo`: We need a mode where that command does not stop on an
> error, but continues to try the running the specified command with the
> other repositories.

s/try the running/try running/

> Imitating the `--keep-going` option of GNU make, this commit teaches
> `for-each-repo` the same trick: to continue with the operation on all
> the remaining repositories in case there was a problem with one
> repository, still setting the exit code to indicate an error occurred.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
> @@ -39,6 +40,8 @@ int cmd_for_each_repo(int argc, const char **argv, cons=
t char *prefix)
> +               OPT_BOOL(0, "keep-going", &keep_going,
> +                        N_("stop at the first repository where the opera=
tion failed")),

Isn't this help string opposite the intended meaning? Taking a hint
from GNU "make --help", should it instead by something like:

    N_("keep going even if command fails in a repository")),
