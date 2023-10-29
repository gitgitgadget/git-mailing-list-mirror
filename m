Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E3C80B
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 06:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIama3OC"
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99791C9
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 23:00:35 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c509d5ab43so50158321fa.0
        for <git@vger.kernel.org>; Sat, 28 Oct 2023 23:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698559234; x=1699164034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQE5umkieqPwnkPU42DRdrJ7lbdKFVxOoGYXGxnI6Qw=;
        b=LIama3OCIL1KDYeNWAuDbRWGw1gXJz3yNH3iyTuXp58xvmQSYxcivWQjVOnFOIicx8
         zYtO9RY4Gz4FsgLvI9RRXMtQV/P9dgWv/UwrgOH4CMqSCpwHWGTskxfpB1v5+9q/yeKQ
         sfDIBsTFFAgjAIzol5+NwklId4s/sY2+XW1zekNgPAHLJQLRaShJIV3B2SHFsrARO3Du
         jtv3WBVRekwyMromh9Ahb4gTDMIINptOdovZea0O7ncVhVp8P8meah2hnumRcCGGEDhu
         Ub+QyeQYQWitSrDt/u2bRo47IcuA5GOv7C9ybTh1lp2danH2bKEezWE5b9GEFoqp9q3V
         gT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698559234; x=1699164034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQE5umkieqPwnkPU42DRdrJ7lbdKFVxOoGYXGxnI6Qw=;
        b=ewXT5KyMp4V20jHnj0j/SRAICSQCoUUZnwXb8zsHdP3j//ozkj+UxkpjY+uhs+NYV6
         FRu+c7+6EjSY1N0OWWm/dAg3dz2cuZnGtKW23VrErQvvboAf+bIXCCaBp80qouFNfPvs
         YbsHXYiSmGZkBSaz0oCD6Jv/SxSbUhFVsXXzAbp9w0xpICWEEL3ATV65MfX9dhwr2W9K
         /UJYC2VE/BXXXu2fbr2G4yPMU+jBUjVT3Ew39eFr0ykl/2BgQJxVtmK11yR1BSUYpacA
         a1soyMhmZjcL9MOMa/AF+Bi70SY/ut5sEGyZDYDVP65AsfVYDihmFKXfeBVUK852o8/O
         EAMQ==
X-Gm-Message-State: AOJu0YwgEf5hi0uz3DNtaApeRaqDHyQMU6Z8XaNoP/qpuSdfmOem30+v
	U8gzrO8snIS8iZvovbGttRg1DEXJE6/BicRnCsE=
X-Google-Smtp-Source: AGHT+IHByKLpLgQcHoLMf5JMH2nqnMmEbTlB9AsDUyrreCcXLj2hdJ8J3kAgXpDCy/v7V1BhfJIwZxlhYGy2mf+Kh7k=
X-Received: by 2002:a05:651c:1032:b0:2be:54b4:ff90 with SMTP id
 w18-20020a05651c103200b002be54b4ff90mr5045083ljm.53.1698559232884; Sat, 28
 Oct 2023 23:00:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230907092521.733746-1-christian.couder@gmail.com> <20231010123847.2777056-1-christian.couder@gmail.com>
In-Reply-To: <20231010123847.2777056-1-christian.couder@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 28 Oct 2023 23:00:20 -0700
Message-ID: <CABPp-BGCzxL-kpOvZzWRTJcx2v18QHm5ev8bFv7bm0dyNqhKug@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] Introduce new `git replay` command
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, John Cai <johncai86@gmail.com>, 
	Derrick Stolee <stolee@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>, Dragan Simic <dsimic@manjaro.org>, 
	Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 10, 2023 at 5:39=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
> * Patch 12/15 (replay: disallow revision specific options and
>   pathspecs) in version 4 has been removed, so there are now only 14
>   patches instead of 15 in the series. This follows a suggestion by
>   Dscho, and goes in the direction Elijah initially wanted before
>   Derrick Stolee argued for disallowing revision specific options and
>   pathspecs.

That's too strongly worded; and may be misleading.  My primary goal in
that discussion was that setup_revisions() should not be a disallowed
API for future consumers such as git-replay.  My secondary thought, at
the time, was that although I agreed that setup_revisions() was a
problematic API, I didn't think fixing it should be a prerequisite for
new features to make use of it.

However, your paragraph here could easily be read that I think the
setup_revisions() API is fine.  I don't.  I actually think fixing the
setup_revisions() API and preventing not only git-replay but many
other commands from accepting non-sensical flags, as suggested by
Stolee, is a very good idea.  I even brought up the example
$ git stash show --graph --relative-date --min-parents=3D3
     --simplify-merges --cherry --show-pulls --unpacked -v -t -8
     --format=3Doneline --abbrev=3D12 --pretty=3Dfuller --show-notes
     --encode-email-headers --always --branches --indexed-objects stash@{0}
in the thread[1] along with the comment "guess which flags are ignored
and which aren't".  That's garbage.  This digging plus various things
Stolee said actually convinced me that perhaps prioritizing fixing the
setup_revisions() API over adding new consumers does make sense.

But, I don't feel nearly as strong about it as Stolee on
prioritization, so I'm not going to object too strongly with this
patch being tossed for now.  But I do want to note that I actually
like Stolee's suggestion that we should fix that API and tighten what
many commands accept.

[1] https://lore.kernel.org/git/f5dd91a7-ba11-917a-39e2-2737829558cb@github=
.com/

> * In patch 2/14 (replay: introduce new builtin) the command is now in
>   the "plumbingmanipulators" category instead of the "mainporcelain"
>   category. This is more in line with the goal of introducing it as a
>   plumbing command for now. Thanks to a suggestion from Dscho.

I do want to eventually make it a porcelain, but I think it's pretty
far from that in its current state, so this is a good change.

> * In patch 6/14 (replay: change rev walking options) the commit
>   message has been improved, including its subject, to better match
>   and explain what the patch does.

This (and multiple other changes I elided) are good; thanks for
pushing forward on this.

>   Also instead of forcing reverse
>   order we use the reverse order by default but allow it to be changed
>   using `--reverse`. Thanks to Dscho.

I can see why this might sometimes be useful for exclusively linear
history, but it seems to open a can of worms and possibly unfixable
corner cases for non-linear history.  I'd rather not do this, or at
least pull it out of this series and let us discuss it in some follow
up series.  There are some other alternatives that might handle such
usecases better.

>  6:  ec51351889 !  6:  37d545d5d6 replay: don't simplify history
...
>     +    We want the command to work from older commits to newer ones by =
default,
>     +    but we are Ok with letting users reverse that, using --reverse, =
if that's
>     +    what they really want.

As noted above, _I_ am not ok with this yet.  Given the patch
prominently bears my name, the "we" here at a minimum is wrong.  I
would rather leave this change out for now and discuss it for a
follow-on series.

>     @@ Documentation/git-replay.txt (new)
>      +
>      +NAME
>      +----
>     -+git-replay - Replay commits on a different base, without touching w=
orking tree
>     ++git-replay - Replay commits on a new base, works on bare repos too

really minor point: "works on" or "works in" or "works with" ?
