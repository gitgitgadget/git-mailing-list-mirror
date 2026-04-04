Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC26372EC5
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 16:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775318919; cv=pass; b=L/nZH6cFjy+umDnbLYvQZhwRIO81zG64rEKYiv3c8uslSYV8sCw18H+4hZEqFJzmAcMMxQQpCyiRc57noV+sHAUlk8IxFrCl+6+YMLbVXRPdqJMhO56Vd72bJe3uJmCHtGzjzAsXXtGVnnOxCBwTrUwuRf/Bp9jXsZhHC637QKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775318919; c=relaxed/simple;
	bh=KsDXWeWBgS+43FQ6/oITPjnje8D9FMv/hv+mSa5bHgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HOpKiQAVIbLY8HCFxLlzyIPFrzopskh1LxLT4Zb5gyUgBEpVuWixJKG6eShXeWqxszILR9TKVWYxQ2va4p7r3eedUx85/B8FiJBt8aJR+2dCHsIP1WFo4SV+Cxh8KoxoyqRcDrNxZ7dZ4ZgW4SSCwssa0gjqI2X4v7yG5bw+Ut4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RiVS3AcS; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiVS3AcS"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79ee5037d44so35999817b3.0
        for <git@vger.kernel.org>; Sat, 04 Apr 2026 09:08:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775318917; cv=none;
        d=google.com; s=arc-20240605;
        b=bRnWN1p4Pdif8IDqsrvn/ycw91cQ6n5GdhPAaB153hjAS9oG7z3x0axHVsRpALi6GT
         tMM5CZNL2YbBQoGRgMGaxrACgRrEVBx6rMXlDsLXeGDu/asOnaiCe908f6o7RnokGJzQ
         4h3X+7fvPuWeci3w4gsCIFgjSvKlScJ47El6ewJQ8DK2Ln9uKUvEdqAzIIfs9M1878Mm
         WB6yGCMKbE8I2u6VA1ZcOIML6Z4zRx57eORpKgKwo0Y3Nod0gFLoMWFyu1Da7AXOS/mQ
         L11StRc8e2Ljeu4Eean9we/ybB8hZ4R4WP5u87jyM15qRZmERWxj+foMqZlOTsKMsO9i
         ZP4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f5SvHHIQ8Ailf8lJjQuDJ61+ZIDufGbjcK/Bd51nUdc=;
        fh=UHNRS8Vb6y6646peOuqpS2HLp2NdD/g21LPA1XnA4o0=;
        b=B6G304vRv+QVbT1IFC7rr0DM6OhZpERp1oFKxzS+lghxFvF/1azZC3JKjHoIHIBrO9
         6+YtbZINQxh07xYpW7ZJQxbzXj5EHOY7aKDRtYyidIYwVIFtw26ZTNIWqRO8G3sNiofl
         FVurJcbL1FurL6pegFg65Dygi4/Eu/lPC0XYaskoK7XfcjE1IWCWDWPLZUe2ZJEPUUpy
         YZLyBQ4xo8emya+FQ730ij2dbzsaVMZEsGfLv0wWmmyaLqKC7IRe3Rz08etmwjxnut6p
         +4sn+EmlsaTTaYomuhIVgApi0QzSs9bAKzDAK0kJHO6vb25h79OkRg0IM4AxZrx/14BN
         WCww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775318917; x=1775923717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5SvHHIQ8Ailf8lJjQuDJ61+ZIDufGbjcK/Bd51nUdc=;
        b=RiVS3AcSYAa0Agu4RM6MxK50Y/peH1TMpvCzek4506641Dn4/VVXsComoWImC3TwUW
         cT2/YUXWHG28x8EV4fk94uLVmTMhl1pbgdv2tGMAhyBzLQ4pqED5MTB8luap6F4HgW/z
         T3Vw+ShrAEmBbE7sLA7irx0x65IBYoiqUQuGWbptu5RrMQ0nuhOY1N+dpSoYkyKx37+Y
         rbOQQURcrSf5f0I2WyBCSYstIhQxGnqPJwNpFEqAJcSaLSBL1npDvFJTX7dpfENmgQO6
         lDw42xSGxiO+6+4xrLNkcdlMj59lgAJwgCpSMQX42IMjX77X9+ZM3WbXpEy2pPf6nhnz
         GaJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775318917; x=1775923717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f5SvHHIQ8Ailf8lJjQuDJ61+ZIDufGbjcK/Bd51nUdc=;
        b=g8yu4zK/87jeri93faxG0ypHgY0vbqjTBYibq/EHzQvCa3arTpC8xUFqdQrHjMAHam
         o8JiDdi+F92oeaH0bloCrtH5QoVgQEl+HH7EPQWngNw5ucErM4yyS05LRRT1UwU9qqsM
         AEfX1d5GU4vQ3TmxWqG+Fw168kp1ubfttnGGdPwnqhLW/NYAMaZEV+EiDoNtCVA4f2TK
         jD1akKx1m27szE+pSnN8Ad7YylBbnHHmLez42/W+v9EP6tehufowrT2AL6szZBVwYltY
         RKqIHLcHEJTTM7Dm2weCKMUClTKUux9ZD3ET+dKvaubZNIIUqg7W9F3zGCLStfSf1jeJ
         tqrQ==
X-Gm-Message-State: AOJu0YzU1HE7dsZMyC0EDLgJiD+BIFHWYb34chOQVKdjNv8RDWR7FrhF
	JyuzRC3AnGwQdt8bZUPl+wk9WwnUVPWFz+HGkhPx+hFivkHBJx7ZeYs3h/rELZNg09X6mrUKQiF
	6iLU5OQfHuWFTcX715II+Yx1h6vsZFvY=
X-Gm-Gg: AeBDiesGom6X62MEWF7+J5QWvZSVlFiwDdO/c7XOBtgGQyI28ZnBu7/RGt5cLPJFWQk
	fa9XVb/cJWrYQAlp5yygOEk0BetKEfFGXkCht2Ht7sWYCSB4t/U/Y7AVDzbWgTfTaU3DlMqQa3w
	5ZE12JWFeF19CKuRh5k8IGV8Dyi3ynz/Hdn+vEbZwqrgBEmf6j9ebi7AhQWLyxIScI5n/1iNvk1
	WOdwdltRb8xnEP0yPTEAoOtDAzH/Hog9/Ed0QZymhKpMg49i5wTJWvB5GPm7EbhkYKJozsGj1+O
	gJ30Mua+QXIApdWQGdelIJPjuWrhcoYl6RxdSA+egvGc8XJ84vyqvB10QENXmJtGGhTbJAZ5wK8
	QjTyA752kJKdXNQn+ZP9G5w==
X-Received: by 2002:a05:690c:7203:b0:79c:a09a:e580 with SMTP id
 00721157ae682-7a3bc20875fmr81106737b3.9.1775318917167; Sat, 04 Apr 2026
 09:08:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <adErl-EdiaXopVx-@x395.localdomain>
In-Reply-To: <adErl-EdiaXopVx-@x395.localdomain>
From: Pablo <pabloosabaterr@gmail.com>
Date: Sat, 4 Apr 2026 18:08:25 +0200
X-Gm-Features: AQROBzBVZYDQR66KyHuprZjxcFPaiFJa6MFJ86XMOIwca8iWmbXXrMDtlLYRCb4
Message-ID: <CAN5EUNTUDT7FMNYTOnTA_GJJXa2eZZL=RhJHfA6PfJvFSSHL-g@mail.gmail.com>
Subject: Re: [RFC] Show empty root commits when using --simplify-by-decoration
To: Fernando Ramos <greenfoo@u92.eu>
Cc: git@vger.kernel.org, me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El s=C3=A1b, 4 abr 2026 a las 17:18, Fernando Ramos (<greenfoo@u92.eu>) esc=
ribi=C3=B3:

Hi Fernando,
I think I can bring some clarity to your second issue.

>
> Regarding "--simplify-by-decoration", I found a somewhat unexpected behav=
ior.
>
> Let's say we have a repository with two branches ("master" and "branch") =
and
> this history structure:
>
>          a * <master>       b * <branch>
>            |                  |
>          2 *------------------'
>            |
>          1 *
>            |
>     start  *
>
> If I now run this...
>
>     $ git log --graph --all --oneline --simplify-by-decoration
>
> ...I get this (which is expected and ok):
>
>     * 0f3892d (branch) b
>     | * 0c37d8c (master) a
>     |/
>     * d783631 Start
>
> HOWEVER, if the root commit ("start") is an empty commit, then the same c=
ommand
> will print this instead:
>
>     * 7abc10a (branch) b
>     * 14d51e1 (master) a
>
> ...which is confusing for two reasons:
>
> 1. The graph is not showing a common origin.
> 2. Because "root" commits use an "*", it looks like "a" is the parent of =
"b",
>    when the reality is that the graph is showing two independen origins.
>
> Issue (1) seems to be caused by the fact that empty root commits are mark=
ed as
> TREESAME and thus discarded when showing the graph.  This can be fixed wi=
th
> patch #1 at the end of this email.  Note, however, that this patch partia=
lly
> breaks what Taylor did on 1343c893138 (I say "partially" because it only =
happens
> when using "--simplify-by-decoration").  I have CC'ed Taylor in case he h=
as any
> comments about it.
>
> Issue (2) can be "fixed" by using a diferent character (for example "I") =
for
> root commits (ie. those without parents), which can be done with patch #2=
 at the
> end of this email.

This has actually been discussed before and it was ruled out some years ago=
.
  https://lore.kernel.org/git/xmqqwnwajbuj.fsf@gitster.c.googlers.com/

You would need more symbols for different roots, --boundary, --left-right a=
nd
what if a commit that is not a root has its parents excluded, would you
change the symbol even tho it is not a root?

You might find interesting a patch I'm working on that tackles that
confusing look when two "parentless" commits are stacked.
  https://lore.kernel.org/git/20260404092425.550346-1-pabloosabaterr@gmail.=
com/

This answer from junio might be helpful as well:
  https://lore.kernel.org/git/xmqqbjfzn6ku.fsf@gitster.g/

>
> With those two patches applied, this is what the output looks like in bot=
h cases
> (with the root commit being empty or not):
>
>     * 7abc10a (branch) b
>     | * 14d51e1 (master) a
>     |/
>     I c0db521 Start
>
> Let me know what you think and whether you want me to send a proper patch=
 that
> includes (1) or (2) or (1)+(2).
>
> Thanks!
>
> PS: Path #3 at the end of this emails includes a dummy script to quickly
> recreate the two scenarios described above.
>
>
>
> -------------------------------------------------------------------------=
-------
> Patch #1
> -------------------------------------------------------------------------=
-------
>
> diff --git a/revision.c b/revision.c
> index c9b8bfd09f..0e7bf2ed3c 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -978,15 +978,17 @@ static void try_to_simplify_commit(struct rev_info =
*revs, struct commit *commit)
>                 return;
>
>         if (!commit->parents) {
> -               /*
> -                * Pretend as if we are comparing ourselves to the
> -                * (non-existent) first parent of this commit object. Eve=
n
> -                * though no such parent exists, its changed-path Bloom f=
ilter
> -                * (if one exists) is relative to the empty tree, using B=
loom
> -                * filters is allowed here.
> -                */
> -               if (rev_same_tree_as_empty(revs, commit, 0))
> -                       commit->object.flags |=3D TREESAME;
> +               if (!revs->simplify_by_decoration) {
> +                       /*
> +                        * Pretend as if we are comparing ourselves to th=
e
> +                        * (non-existent) first parent of this commit obj=
ect. Even
> +                        * though no such parent exists, its changed-path=
 Bloom filter
> +                        * (if one exists) is relative to the empty tree,=
 using Bloom
> +                        * filters is allowed here.
> +                        */
> +                       if (rev_same_tree_as_empty(revs, commit, 0))
> +                               commit->object.flags |=3D TREESAME;
> +               }
>                 return;
>         }
>
>
> -------------------------------------------------------------------------=
-------
> Patch #2
> -------------------------------------------------------------------------=
-------
>
> diff --git a/revision.c b/revision.c
> index 31808e3df0..c9b8bfd09f 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -4565,7 +4565,7 @@ const char *get_revision_mark(const struct rev_info=
 *revs, const struct commit *
>                 else
>                         return ">";
>         } else if (revs->graph)
> -               return "*";
> +               return commit->parents ? "*" : "I";

This only focuses on real roots, what about commits with excluded parents.
for example:

    O---A

    X---Y

    If you'd run 'git log --graph O..A Y', it shows A, Y, X but
because it only look for roots it
    ends up looking like:

      * A <- not a root but O is excluded so it seems like one
      * Y
      I X

This would make A and Y look related, also the "I" makes it very
confusing because
the vertical edges are very similar "|".


>         else if (revs->cherry_mark)
>                 return "+";
>         return "";
>
>
> -------------------------------------------------------------------------=
-------
> Patch #3
> -------------------------------------------------------------------------=
-------
>
> diff --git a/build_example.sh b/build_example.sh
> new file mode 100755
> index 0000000000..60f63c5344
> --- /dev/null
> +++ b/build_example.sh
> @@ -0,0 +1,61 @@
> +#!/bin/bash
> +
> +########################################################################=
########
> +# Example #1
> +########################################################################=
########
> +#
> +# This will create this a repo with this history structure:
> +#
> +#       a * (master)       b * (branch)
> +#         |                  |
> +#       2 * -----------------'
> +#         |
> +#       1 *
> +#         |
> +#   start *
> +
> +rm -rf EXAMPLE1 || true; mkdir -p EXAMPLE1; cd EXAMPLE1
> +
> +touch start.txt; git init; git add start.txt; git commit -m 'Start'
> +touch 1.txt; git add 1.txt; git commit -m '1'
> +touch 2.txt; git add 2.txt; git commit -m '2'
> +touch a.txt; git add a.txt; git commit -m 'a'
> +git checkout -b branch HEAD^
> +touch b.txt; git add b.txt; git commit -m 'b'
> +
> +git log --graph --all --oneline --simplify-by-decoration
> +# The previous command will print this, which is what we expected:
> +#
> +#   * 0f3892d (HEAD -> branch) b
> +#   | * 0c37d8c (master) a
> +#   |/
> +#   * d783631 Start
> +
> +cd ..
> +
> +
> +
> +########################################################################=
########
> +# Example #2
> +########################################################################=
########
> +#
> +# This will create this a repo with the same structure as before, but th=
is time
> +# the root commit ("start") is an empty one.
> +
> +rm -rf EXAMPLE2 || true; mkdir -p EXAMPLE2; cd EXAMPLE2
> +
> +git init; git commit --allow-empty -m 'Start'
> +touch 1.txt; git add 1.txt; git commit -m '1'
> +touch 2.txt; git add 2.txt; git commit -m '2'
> +touch a.txt; git add a.txt; git commit -m 'a'
> +git checkout -b branch HEAD^
> +touch b.txt; git add b.txt; git commit -m 'b'
> +
> +git log --graph --all --oneline --simplify-by-decoration
> +# The previous command will print this, which is unexpected:
> +#
> +#   * 7abc10a (HEAD -> branch) b
> +#   * 14d51e1 (master) a
> +
> +cd ..
> +
>
>

One more thing, even if it's an RFC it would be much easier for reviewers i=
f the
patches were sent as git format-patch (one each email) with a cover letter,
discussing your RFC, so anyone can use git am and b4 to apply the patches.

Hope this helps,
Pablo
