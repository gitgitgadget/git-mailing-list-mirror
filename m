Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB89383
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 03:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752722892; cv=none; b=dHr/fu7iBu0fqPACxrUHunUsrYof7+gLY+FfM6n8jfxzbRQNG9UylBqDx5A9CXGJ1DsRUZJVETAQnQWnrYWkBofBrAhVBp8XCc9dfc4gEg+Ebnn/K6WBj9fzeUBPPQUGZH31R67VTDfIsAXCRtms5ygWVYAbxidY1o44ahzcwdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752722892; c=relaxed/simple;
	bh=3KsM7VYFIsZy8GnaPQayiBW2BG339tHuhhPDFH78eFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YkWxN6zR7SDSML9tf0wlBMVxSWQWxjxa7XfRcs2BnFFl16IgS0RtMqErfW2zYpcCuk+f2q41uN+SYFdW/FTmPHfCY13LFp+FNA5xxR9kWka8wkwAUW4GS+mM6QgX6vZ+2A4WPDrU52eWTkDKGcYst/lnImn4y+QTAtCY+a5VfrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6fac4e2fcd1so903246d6.0
        for <git@vger.kernel.org>; Wed, 16 Jul 2025 20:28:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752722889; x=1753327689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qw5oFebABsxnJH5SVpZeJHAtz0giBiz4OiFSjjCPaKk=;
        b=m8+432ISO8ly3rjnquR6pysN3ujfHDDyBD+jqSUtiCCDKS8jO8nbuGzrPa6k6cXC8u
         NkQYD/oV3itnpGdkR07Y/wdUVNsvjb5L5IE6CEILvW7RXItojpZ8eLV/ym6SME3WrV4F
         W49xtdYsslktRH/v+KYGThDtgewbT3eR4Fs8U7Zo2bGnSVakouRNekH7GZQOd0Xnqsgr
         NKf+sKrpLw/CM1z2dkipqCzmAZTBgC4PGMhUcgQUHokE8nKYeIOZt2XT2ljZG9v9Zex9
         VdPhqFKjK4BAdhK/tgz4s3oquxQoNS0jKJ0OOm7KK0hVqdIhrC6F6Q3qr7scdhujqbWJ
         eNrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdpwTMSUrY6eSnGufc+uRFxiZB9RjYdZ7pHQaFJU6f7pfRTcjQY2HMhhrKxj/IbvFcovY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0kdvXKSvX2Aky2cj1vaivkmM7hR7WlYY6iIt0AZIaGIZVrQQr
	Z6RDls8Yvu1EwgnXQD2nm8YpOG0/cTFPol0+jZ+3izY+3pWAQGG+HkZ7gcVMoGm1/Lj7pRc5wSA
	gTbYkjmwAjKhCk+OoHNWjewneNuhPWjY=
X-Gm-Gg: ASbGncsU9oiqVtbupqzASZnPs7dg7pgdpRZ7SLlix1aAEOEPFS44Bkwq0VgImklPInt
	RkPbJfBi8K4Q8d4tjz095YHuyAxv9pzQt7h2DV9flIwP8cC5q5tMpqkZWL8GTNX/xRNItB0Thyy
	YT2rmjZYMYUMPzy1aAPUvN8d/hG+D2aQ+g67b8QP6UGhnnVG6FrMrJltk/ZK5qjsL52ogSeKHP6
	ZAJlYwize/M4a87f5C151KfQG44z5q0VciAo0ELBhguYm87fUU=
X-Google-Smtp-Source: AGHT+IGY3ZjOBAN0JVMNIbq3LEVrNuKK0o/iNZy0XzPorpda7whnrEg5ZS4qBMgGR3hYbfCRC9gVEkY4vlDik8I+W5w=
X-Received: by 2002:a05:6214:2465:b0:702:d3c5:2bef with SMTP id
 6a1803df08f44-704f48158b4mr40078436d6.3.1752722889278; Wed, 16 Jul 2025
 20:28:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqq5xfsdv3w.fsf@gitster.g> <20250717030732.75106-1-yldhome2d2@gmail.com>
In-Reply-To: <20250717030732.75106-1-yldhome2d2@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 16 Jul 2025 23:27:57 -0400
X-Gm-Features: Ac12FXwHQ1tYYSVX9dgP-hR5a11mJFbKuxxF4bd7h3fwhkh9cqKId0FDfFnP9V0
Message-ID: <CAPig+cTQ017qGK_Qx04+R_0rCXEOirW+oLEjeaDoCFJiQbnsGw@mail.gmail.com>
Subject: Re: [PATCH] pull: add pull.autoStash config option
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: gitster@pobox.com, git@vger.kernel.org, hi@looping.me, j6t@kdbg.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 11:07=E2=80=AFPM Lidong Yan <yldhome2d2@gmail.com> =
wrote:
> Git uses the `rebase.autoStash` option to decide if git-pull is allowed
> when the working tree has uncommitted changes. However, since the
> documentation does not explicitly state this, users may find it difficult
> to associate `rebase.autoStash` with the git-pull command. Add
> `pull.autoStash` option along with its documentation.

I have no opinion as to whether this is a good path forward.

> `pull.autoStash` provides the same functionality as `rebase.autoStash`
> but is more user-friendly because its prefix clearly associates it
> with git-pull commands.

Rather than "user-friendly", perhaps a better way to phrase it would
be to say that `pull.autoStash` is more *discoverable*.

> Additionally, when both options are set,
> `pull.autoStash` takes precedence and overrides the value of
> `rebase.autoStash`.

This was a question which immediately popped into my head, so it's
nice to see that you considered it and discussed it in the commit
message.

> Signed-off-by: Lidong Yan <yldhome2d2@gmail.com>
> ---
>  Documentation/config/pull.adoc |  9 +++++++++
>  builtin/pull.c                 | 10 +++++++---
>  2 files changed, 16 insertions(+), 3 deletions(-)

You will want to add one or more new tests to a test script to verify
that this new configuration works as expected, and probably also to
verify that `pull.autoStash` takes precedence over `rebase.autoStash`.

> diff --git a/Documentation/config/pull.adoc b/Documentation/config/pull.a=
doc
> @@ -13,6 +13,15 @@ pull.rebase::
> +pull.autoStash::
> +       When true, Git will automatically perform a `git stash` before th=
e
> +       operation and then restore the local changes with `git stash pop`
> +       after the merge or rebase is complete. This means that you can ru=
n

I wonder if you meant "pull" instead of "merge or rebase".

> +       pull on a dirty worktree. Noticed that `rebase.autoStash` provide=
s

s/Noticed/Notice/

> +       the same functionality, but `pull.autoStash` overrides its behavi=
or

Rather: "...same functionality as `pull.autoStash` but overrides the
latter when..."

> +       when both are set. This option can be overridden by the `--no-aut=
ostash`
> +       and `--autostash` options of linkgit:git-pull[1]. Defaults to fal=
se.
> diff --git a/builtin/pull.c b/builtin/pull.c
> @@ -1052,7 +1056,7 @@ int cmd_pull(int argc,
>         if (opt_rebase) {
>                 if (opt_autostash =3D=3D -1)
> -                       opt_autostash =3D config_autostash;
> +                       opt_autostash =3D config_pull_autostash =3D=3D -1=
 ? config_rebase_autostash : config_pull_autostash;

You may want to wrap this over-long line. Perhaps:

    opt_autostash =3D config_pull_autostash =3D=3D -1 ?
        config_rebase_autostash : config_pull_autostash;
