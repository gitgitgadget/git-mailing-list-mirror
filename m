Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5028D33B6D0
	for <git@vger.kernel.org>; Sat,  7 Mar 2026 07:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772867267; cv=pass; b=mJLcEiIjmhWoK90KgK5mdjTBEivItJp2JBLyaUtVhjC1JJ9uyDWeWnGiYMM+XAf6HFVO9W9v+W5swk5FETxgvXjof5nt9OZn5C+IGqaUcZmaEM2CDZnbuVksh1n181X9sU/n6wTOueQuLwHnYXkzoGwh2sEofJX8SithR7UgjGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772867267; c=relaxed/simple;
	bh=2gSFOlMaXXxEsZP9CSPWqc5bEU4xu1F9b1dZR13z3kE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZMBIki/GFfKyAMpTjiYsAjQkFUDafuiZGTM9xmingFVtaVad44+gZ6xpz5Pm5564NjDTwe09hBuSwnteL3ytmKBXPnVQNYCvnXhX/YYqqTW4gJ2uyTIiXHxUCv4386Ci5gfdBFzo0JnXJZypxC82nimK2oDq+yjIgPfPB1f4rh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2bda3b4318dso820016eec.1
        for <git@vger.kernel.org>; Fri, 06 Mar 2026 23:07:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772867265; cv=none;
        d=google.com; s=arc-20240605;
        b=BGLN7w5LZMU2UNFrEFuIgLUOFNX6WmWMxZj+PPZIceN7+zS6bWYMP9GlqyLdDZ2UzX
         GOpyF0lmEjvmPGgrpbClewjNw0ixz6NnvqICWWbKM/8HId1WNoCDN5ZhCx2SNCl7Y57c
         6t172HQKP3XMmHruzAX4Oq4dyeWYN3y3dcvP0t+lI7ANGaxRLHTEes1YiYV7P3dw9aU1
         peo9qM80NZ43s9I42zeNmvtixYUzUomptv63bCY/mP/2aqr1Ls3SoaU6nTHaU4kwjXDr
         cBW7ZGZzUTD5ZBr0NCtC1gwjczBMhA3h8Y0cVRawbYY8XGQLDAV3sxZ89XVra2Q7WXqb
         A92g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=+UN2zOsHEpzOU3PUhtiCR3Udl3ihhamCHRkCzlvylFU=;
        fh=psYHFFYHSKXTPxPY2sBmRg0Oym4Zo0Y/5dcRg5T3CAs=;
        b=eXnw1/2txrhJMq7UMOfUo77rBQebFaQSjRxmrgU5FKA6KaGH18nnamYCm0x51kyllH
         wLR8KNsYpKkC9XfMdoJxYOpCThN+lTqI3B7X8QfHkEBn+yL+irPVVq6DLjx6/3B53yOf
         JdsAYnAfi/GfIyRhbOmjup8HuDf7zBBqHC/mhrdn8qXNNgH4XNWxbcfV2I5b14cCsYBU
         dhD/x7PEy+GOEB8DKilHMd6jFanh6vaE1e1J8ZepPf1+cya88T5TzPTEsNDEURDZos8m
         yh5cHYhetCw7psWL+QeXiCFYEXmq448lwslrbi49D2FCXT19wEdeE/Eu78fa6oUhfyM3
         8d1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772867265; x=1773472065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+UN2zOsHEpzOU3PUhtiCR3Udl3ihhamCHRkCzlvylFU=;
        b=ibydohQE87R3cibxmvbKNk623sh+gYEDBSWa6eaQk2MHJdrPguiSUnd5K1jiBZXlO2
         pf77L3gXvDlBp29SScwXGAaXnbxmDUX+rMK5xIlwfTA6EqbM90/LeMrDelHa+kv1Y8Gz
         IvGOPY3Rkpu1Yx72HS1LPG+CdtUNDZFOQ6gmKiZvVJdKmC9wnzwDzvwRphAmuyb51pwQ
         Yod4QhknzpGe/UM1uOyv/lw+Amnr5flDsFxp0NGPYzg9UrQo0OD7ZVbmbDoQBLXA4Pux
         PPFeaDhSUXZ8STBDaM6+0BLEdiOEifys7VjC5a4ErZ4R09jC0jjFbM7ASMIbMlBWHt0E
         4YNQ==
X-Gm-Message-State: AOJu0Yyl/m+Lm3AhPMj65nTRuv/j6qx3X2syUBF1RXL2nRYfRfgxy3uN
	Immb95oHwjbOJHW/bR5kcP1GhygiexBWk19SKe4TlxcFGpZKmyIBSyxlm2Q8/4Cr7xUoFOonV1v
	OrxICsngvN6ShlfXTnrcNSt3PGPTdp8w=
X-Gm-Gg: ATEYQzw5VcC+re3NlwvVqntH7564/P5Kmvo1Ovqzu95OTC0y4Jsm+2UtUMGI6HBveuK
	ZmZXWeZD14g3ImfBcXOqqvotSea7esxIrU0Xh+v/FNQMNwSKMe9+LuxZP6flu7AD34n5p01+d9L
	DIpkx4tzYOrMFxeqHv7pnWtTDozdtCRTZ76GK5D/mfrneftb3A/fVYLBV3oQ0Yhsm34UAzaKcoY
	ObgwM+a9sF14QFAg0+WIJWb0lODZ2b74DnxWZAivGdIQDS3MuwnWvnjS0u5SCAngFpkpQ4hM3lZ
	ihBAR6RtjzZ/fIL+Er0iYYPS32ejG923V30P14S+FPrErSoByeU=
X-Received: by 2002:a05:7300:d51b:b0:2be:2b8a:9523 with SMTP id
 5a478bee46e88-2be4dd701camr848017eec.0.1772867265471; Fri, 06 Mar 2026
 23:07:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2202.v2.git.git.1772207333.gitgitgadget@gmail.com>
 <pull.2202.v3.git.git.1772802872.gitgitgadget@gmail.com> <d51f71708ceb0263c8e10b6d7915f7a426c88f2e.1772802872.git.gitgitgadget@gmail.com>
In-Reply-To: <d51f71708ceb0263c8e10b6d7915f7a426c88f2e.1772802872.git.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 7 Mar 2026 02:07:30 -0500
X-Gm-Features: AaiRm53xq5NVapY3VFcn6ECZNfrdVWZVZXHRWvokCQ4YLcx0zum7LOXGxyNvDp8
Message-ID: <CAPig+cQ_jY8ofigbbtcdakaijS0XhzJFvEkOCPdZpdkt=qMTow@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] branch: add 'branch.namePrefix' config param
To: VALERI Yoann via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	Yoann Valeri <yoann.valeri@cea.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 8:15=E2=80=AFAM VALERI Yoann via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> This patch adds a new configuration parameter for the branch creation
> feature: 'branch.namePrefix'. It corresponds to the '--name-prefix'
> option of 'git branch' made as configuration parameter, and behaves
> exactly like it.
>
> Signed-off-by: VALERI Yoann <yoann.valeri@cea.fr>
> ---
> diff --git a/Documentation/config/branch.adoc b/Documentation/config/bran=
ch.adoc
> @@ -35,6 +35,11 @@ This option defaults to `never`.
> +`branch.namePrefix`::
> +       When a new branch is created with `git branch`, use the provided =
value as
> +       prefix for its name. Can be '@{current}' to use the current branc=
h's name
> +       as prefix.

This probably ought to mention --[no]-name-prefix to let the user know
that the configuration value can be overridden.

> diff --git a/branch.c b/branch.c
> @@ -368,18 +368,22 @@ int read_branch_desc(struct strbuf *buf, const char=
 *branch_name)
>  void add_branch_prefix(const char *name_prefix,
>                                            const char *current_branch, st=
ruct strbuf *buf)
>  {
> -       int value =3D 0;
> +       char *config_prefix =3D NULL;
>
> -       if (!name_prefix)
> -               return;
> +       if (!name_prefix) {
> +               if (repo_config_get_string(the_repository, "branch.namePr=
efix",
> +                                                                  &confi=
g_prefix))
> +                       return;
>
> -       if (name_prefix[0] !=3D '@') {
> -               strbuf_addstr(buf, name_prefix);
> -               return;
> +               name_prefix =3D config_prefix;
>         }
>
> -       if (strcmp(name_prefix, "@{current}") =3D=3D 0)
> +       if (name_prefix[0] !=3D '@')
> +               strbuf_addstr(buf, name_prefix);
> +       else if (strcmp(name_prefix, "@{current}") =3D=3D 0)
>                 strbuf_addstr(buf, current_branch);
> +
> +    free(config_prefix);
>  }

This "diff" is very difficult to read because it's rewriting much of
the logic which was first introduced in patch [1/3]. When you reroll,
it would be a good idea to get the overall logic straight in patch
[1/3] so that subsequent patches only make small changes to it to
improve it (if necessary).
