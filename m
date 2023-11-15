Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAA52EB06
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAYCS58j"
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EF41B9
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 06:46:36 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9e623356e59so797032266b.0
        for <git@vger.kernel.org>; Wed, 15 Nov 2023 06:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700059595; x=1700664395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfCHMYNPTulvY6FcoqU4RAXU6eKEEtfsvvti8w6lelg=;
        b=UAYCS58jNQhjPghshYSoH+PEhPX2ue2g4+DRrYmhQZ/oTZrGD+q2CgmW3CkRPf/6E7
         /X+KgdYgxOn+i3A1IWmygaUHZxiFzUR/SIjFmURUfke8fOz/A2FUG0c1ZtOLbKMzgAUL
         PJCW7FJalVCukRVQEXhBKb4vKNCn1SfAdJa4daSswcbiSM+4Omgt6TnGpjGjZPmQBV3a
         +0bofPjidXFX+qQxfkEZ+RobbxTblIz5Qv3nNVub5ZMBojYRQoMkKsCkKKAPtnaUSkMw
         J18MGhlcdrMQE/a5zLQL36h8YatHxX5ETiDiZ9jpRc439fiK3Y+ZN/7GrZ2wy4UTpMfB
         sQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700059595; x=1700664395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dfCHMYNPTulvY6FcoqU4RAXU6eKEEtfsvvti8w6lelg=;
        b=GYZlPO21wg3gPmGdaphtw+5aYap61iI/aTi9UIxFtj4l4lF4ivIvydAke4FfdJOouD
         zRWTjmkqDJZI1KNCcgXGpbK9hKlwLwFkhexTU+cKSOwioTpcbSHY1Cn9vZYkcp3THyaQ
         7EEFA40RZYeYHQ/ZKU3Avh3acOjiixBGwRZ00jLHig0Ug8DHRxZwpA0oWWjp0hHlpTFk
         NuZJ71zkpr4xjRmKA6Nx7y9WA5ix6sONq9u7lGYi3bG+s1ND140KAQ31a/wM0EEpfcp4
         INlvOI3ETWOC0/x1LBuBtHwyuLT1OZt/s7CYvXpWW3NddkMOhXvS7y4w9WZfyqb6WViG
         VLVg==
X-Gm-Message-State: AOJu0Yw4jQCJKZUywR71lghLng0ja8D2D1ugwo3SwOPMHy6XeSHVt+nr
	f/tMxJt95Zf3gpfEAKv2yEppofvadV3s0yyyXYY=
X-Google-Smtp-Source: AGHT+IFX1mFollqTjMVT+zvY8iLOJvoihDn63N0VW3Eint3Nz/MVivKr1PhDZ0hstfXILTMmNPeh5/l4jD79HUPbyNA=
X-Received: by 2002:a17:906:dc9:b0:9c7:db3:8b31 with SMTP id
 p9-20020a1709060dc900b009c70db38b31mr10130068eji.59.1700059594969; Wed, 15
 Nov 2023 06:46:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231010123847.2777056-1-christian.couder@gmail.com>
 <20231102135151.843758-1-christian.couder@gmail.com> <fcfacd1a-cf5a-a393-d2e0-3c0388ae3529@gmx.de>
In-Reply-To: <fcfacd1a-cf5a-a393-d2e0-3c0388ae3529@gmx.de>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 15 Nov 2023 15:46:22 +0100
Message-ID: <CAP8UFD0Es4qai98WB6bpykisBT628JndPXG8jg1=_uUbn4zogA@mail.gmail.com>
Subject: Re: [PATCH v6 00/14] Introduce new `git replay` command
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Elijah Newren <newren@gmail.com>, John Cai <johncai86@gmail.com>, 
	Derrick Stolee <stolee@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>, Dragan Simic <dsimic@manjaro.org>, 
	Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dscho,

On Wed, Nov 8, 2023 at 1:47=E2=80=AFPM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Thu, 2 Nov 2023, Christian Couder wrote:

> >     + ## Documentation/git-replay.txt (new) ##
> >     +@@
> >     ++git-replay(1)
> >     ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >     ++
> >     ++NAME
> >     ++----
> >     ++git-replay - EXPERIMENTAL: Replay commits on a new base, works wi=
th bare repos too
> >     ++
> >     ++
> >     ++SYNOPSIS
> >     ++--------
> >     ++[verse]
> >     ++'git replay' --onto <newbase> <revision-range>... # EXPERIMENTAL
>
> Technically, at this stage `git replay` requires precisely 5 arguments, s=
o
> the `<revision>...` is incorrect and should be `<upstream> <branch>`
> instead. But it's not worth a new iteration to fix this.

It was actually:

'git replay' --onto <newbase> <oldbase> <branch> # EXPERIMENTAL

(you can see it there:
https://lore.kernel.org/git/20231102135151.843758-3-christian.couder@gmail.=
com/)

But I made a mistake in the range-diff command as I ran it against a
previous development version instead of the current one.

> >     ++
> >     ++DESCRIPTION
> >     ++-----------
> >     ++
> >     ++Takes a range of commits and replays them onto a new location.
> >     ++
> >     ++THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
> >     ++
> >     ++OPTIONS
> >     ++-------
> >     ++
> >     ++--onto <newbase>::
> >     ++  Starting point at which to create the new commits.  May be any
> >     ++  valid commit, and not just an existing branch name.
> >     ++
>
> Traditionally, this would be a place to describe the `<revision>` argumen=
t
> (or, in this patch, to reflect the current state of `builtin/replay.c`,
> the `<upstream> <branch>` arguments instead).

I have fixed that in the v7 I just sent with the following:

+SYNOPSIS
+--------
+[verse]
+'git replay' --onto <newbase> <oldbase> <branch> # EXPERIMENTAL
+
+DESCRIPTION
+-----------
+
+Takes a range of commits, specified by <oldbase> and <branch>, and
+replays them onto a new location (see `--onto` option below).
+
+THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
+

Thanks for your review!
