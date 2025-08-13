Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8630330E827
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 17:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755104567; cv=none; b=YUUJZS08f3ZH6aB8A90F+PX0uiJwkALKVMvfpDULj/TOOc5XcAf4c9/hIRPvYvdl9z0EPK0+eulEveQ4hwtEDZEQ9j3i2ok32h839iL1jzrgoYCn3Qaoed9OP3dnPMwx3R9TlLnWr+iU9BDqVS3pXoDltyjcmFyv7m2m5S68bVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755104567; c=relaxed/simple;
	bh=6EKl4RjgNJHutXp7dZRZo0LNfMo0E70sTSYn/vF4w34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5tcG+90bolRY/9lwhDw+LG8zQlgtpctK1Ejz64Gdoo8uBWjWPCeLMbXvSXmihZ0zc/4zA7PFYzbC3UAVIkqWMnbWXJT93iTlUh77+zAFFaK/0kZq1MSb1X3tGUIkSIH398J4s9/SXHCngxbdV8lXNpDP470fqeXpi7ksMJ7EpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGjr+Eti; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGjr+Eti"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb79db329so7155566b.2
        for <git@vger.kernel.org>; Wed, 13 Aug 2025 10:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755104564; x=1755709364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OY+xUW2n8mxMLkuJ+CF/2oraoelZyVog5sKoew+eWYI=;
        b=CGjr+EticWVH8grAIu/Er+EgGi9wcFbookZ7s3ZOg4SjLlhPJUbfqAvQSvp4WPzara
         6b4Gg7ynSMG3rjhMpURHf7ZwM6Ew6KjUYMVs5vxreV4dyjMYPRQP5On1RTAbzeuMgZq3
         D7uV9DggqKuP9JddGPTVXzqJZkXl3IV3vnXONdJHrKmCTl4IvGs+pGv/aEGonVXuNhFb
         JiiYhnJc9REUGsvRlOkvjJbRoBuosQS+muIQ69sH1+XljTo6KY0D6bxzxn/fqbe1U4MC
         FYc2GjxwCmYpfTxNExdoDMFx5eFAFVUiPifTnLkLpS9LxsQOs+zFyXuhfWQd2KuUuiCK
         00ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755104564; x=1755709364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OY+xUW2n8mxMLkuJ+CF/2oraoelZyVog5sKoew+eWYI=;
        b=mQpzttEZVraTvEPFvzS9Tw21d+yMBBG+M+7QTcLeLGkb/CPairbCGHtagqaM//AUfq
         CghoB883cbp8JYTN+GYY1NfRJNt6HNxlX77TBt6S0N7crGmsH4owv/fPp2vR4H8VPLim
         xN9wfkj1iyrX43tarW/J58cxV5AlrQjxcsmCvdKwu3bap5iqVJTS8gmwwkujjhqXh4j/
         7Fi912tWUXFHeJdm6k7dGtnwfzVVZUGD8GhMFtLZ8mUX46TGGaVVqxo7IbC2IduWvdhx
         wiiCJtQ9pthYv7K1kJPdeh5dZKOxQycWUN6x/SXYQvmlis5oEO03oF/wJNKRIwADf5dB
         w2BQ==
X-Gm-Message-State: AOJu0YzjMRki73HRf4sw8qHBgbDV4KueueeAe29cn1bY5aSp80mhh3Gd
	OLnDLbj7iV/qFFOovuMvPGe1rPjeeJlsx9n1QTmet/9snRlOLj/r08E9i9ZZ4f+iC2fvKR1LsQK
	S7KA4Had639JCYBbD0xqJNGEVQz+waFNg+5ZA1RM=
X-Gm-Gg: ASbGnctgoHyFhZ+y1AVENWRL6iv6SfJ2A5ajfWeimMzcCv6A/j17rnh/zKyB6fVjeVN
	Z5K2lYjL9hdt6OFPBZrQI9LqWd4rKqpnnMGjrDZwZ4QgyMNJrKPYqqbqzWdELVUkD9eyBfBWGWr
	2kz/IaxefPENqJS/Do24sepWW9FxK+Tg9/RTNz5dFGYb4YCdhn2E/kWyDeAJhY7/t5zhlpMQi1F
	pdLi1Sg/YFIhEXQdCaHPRCGzv1zzVea6BJTYrhXAMDxfU7VD1UN
X-Google-Smtp-Source: AGHT+IH63Z19VmJF9Yx/+eK1Xo7AK+09NH4YMwuZnHB9sQ5w2at92ERofdvQRjZFfqHv6Jhx6H4cSY3OXues33/E5bM=
X-Received: by 2002:a17:907:97c4:b0:ae3:74be:4998 with SMTP id
 a640c23a62f3a-afca4cb5a7fmr233392266b.11.1755104563442; Wed, 13 Aug 2025
 10:02:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12fe17735317215aa0de58a20055193a@dettweb.de>
In-Reply-To: <12fe17735317215aa0de58a20055193a@dettweb.de>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 13 Aug 2025 13:02:31 -0400
X-Gm-Features: Ac12FXzyBem49kC14qZSn9kgJx5Vkvfmiu8bmZfYfWD9TV74MLp7A7tRwIxIUXc
Message-ID: <CALnO6CB-vg-t42OD57Dk5OX9S4v+HnH8BHj2gAozJWwmaLhAQw@mail.gmail.com>
Subject: Re: [FEATURE] Proposal: git stash --only-unstaged
To: "J. Dettweiler" <git.vger.kernel.org@dettweb.de>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 5:00=E2=80=AFAM J. Dettweiler
<git.vger.kernel.org@dettweb.de> wrote:
>
> Hi all,
>
> I=E2=80=99ve run into a recurring workflow problem when splitting commits=
 during
> an interactive rebase, and I think Git could benefit from an option to
> stash *only* the working tree (unstaged) changes, without saving or
> restoring the index (staged changes) at all.
>
> ---
>
> **Scenario:**
> - I have a commit that needs to be split.
> - I stage the part of the changes that will remain in the earlier commit
> (this becomes the new, fixed commit).
> - The rest of the changes (which belong in a later commit) remain
> unstaged in the working tree.
> - I want to test the staged commit in isolation before actually
> committing it, without losing or committing the later changes.
> - After testing, I want to bring back the unstaged changes exactly as
> they were.
>
> ---
>
> **Current limitations:**
> - `git stash --keep-index` still saves the index in the stash object.
> - When I later `git stash pop`, Git tries to restore those staged
> changes, often causing merge conflicts if I=E2=80=99ve modified them duri=
ng the
> test.
> - `git stash -p` and `git diff`+`git apply` can work as workarounds, but
> they are clunky and error-prone in longer rebases.
> - The goal is essentially:
>    > =E2=80=9Cstash the working tree only, leave the index untouched and
> unrecorded in the stash.=E2=80=9D

I can reproduce (2.50.1):

    git init
    echo a >a && echo b >b && git add .
    git commit -m.
    echo c >>a && echo d >>b && git add b
    git stash --keep-index
    echo f >>b && git add . && git commit -m.

Here, =E2=80=9Cgit stash pop=E2=80=9D creates conflicts for b, even with =
=E2=80=9C--no-index=E2=80=9D.
=E2=80=9Cgit stash branch foo=E2=80=9D is slightly more sensible, but also =
includes
the stashed index changes for b, which I thought were normally dropped
when applying stashes [1,2]. This also seems like exactly the use case
that =E2=80=9CTesting partial commits=E2=80=9D in =E2=80=9Cgit help stash=
=E2=80=9C is supposed to
cover.

Taking a closer look, though, the conflicts aren=E2=80=99t from the index? =
The
stash tree for the =E2=80=9CW=E2=80=9D commit (aka stash@{0}^{tree}) has th=
e changes
in a and has b in the state before more modifications were made (since
the version in the index and working tree were the same). Try =E2=80=9Cgit
diff @^{tree} stash@{0}^{tree}=E2=80=9D. Now, the I commit in the stash has
the same changes for b (git diff @^{tree} stash@{0}^2^{tree}), so that
explains why it seems like the conflicts are about the index!

I don=E2=80=99t see how to avoid this in general: =E2=80=9Cgit restore -W -=
s stash@{0}
a=E2=80=9D does what I want, but wouldn=E2=80=99t scale to many files easil=
y. If I do
a =E2=80=9Cgit restore -Ws @ b=E2=80=9D in the recipe above _before_ stashi=
ng, then I
get no conflicts on =E2=80=9Cgit stash pop=E2=80=9D (see tree diffs above f=
or why),
but that seems hard to remember to do (and isn=E2=80=99t documented in =E2=
=80=9Cgit
help stash=E2=80=9D as being necessary)?

[1]: https://lore.kernel.org/git/20250510183358.36806-1-ben.knoble+github@g=
mail.com/
[2]: https://lore.kernel.org/git/20250510183358.36806-4-ben.knoble+github@g=
mail.com/
