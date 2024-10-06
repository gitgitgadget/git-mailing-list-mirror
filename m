Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B41DA29
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 05:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728193732; cv=none; b=sMURTiBFeT5pc0BQOXveN2m/kEFYFZsgN/qJf/RMuuB3psjzJOZTw6/jvIquGtINaUn8sGU/fSmoMBInz9oqYj5yNlV4peMDrCHU+oHtrRG7nEzQf6/MuR7t6Uhtyk0CfzuwEFrrWXnb9ROMY66rrDoIF4AGpcZPFTWDS7lNkJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728193732; c=relaxed/simple;
	bh=fH5/RMzN6HyGBsnvIabaZI8DU0Qy8NUqfYroPm7DWfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nhiMoP3uPgA8vL2qiFefMuJ8gSjT2PeNwU/23A3R00gvfp/0plddSkwDqEr6HrBIrjtSwcPnU0tPcqZtuURUdXwrTdpVDEvIeJnAyfD+84zzAreM96lWlLufd6kgf6SqsekzXT5j5FJKfOUiUq4qTMdM+IaF4VmwTz2s2/FI8Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-45834fc2345so5512911cf.0
        for <git@vger.kernel.org>; Sat, 05 Oct 2024 22:48:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728193729; x=1728798529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDlcrf+jKTec1T0fmPNj4GOCb2fGvPRRLDfFk6w5Oc8=;
        b=GJ1x8R1SYXkDwHBkSOEOBFOjDO4/3FKVrI5YA62EC5SJTqOfMlejYtTO7iH+QjquPJ
         lN/Mj79Z9HgPE1ByL8mdzuufRJ65j+UzZ7s/OXTRmJ3MoRd5tjqqJVsyPRNm110Aqb24
         LxAk2sXWLHG9zuGNESuWd342FvhSeWItUHVzoVjEFACKg36HoY8wUxISI+2HWlQ8A1YM
         roXiNW1MfqR+OhKfBKvKTiN99UwnmyhFOtOY0DFpoui7DA51oah0Ad2enh1vmnXK2xsA
         I35T78hnLxWGGsP/+8VaC6QpOj/a3DZp9V35yxw1+bjefuns17VsGhHGG8UZcfSs+mXF
         EI0w==
X-Gm-Message-State: AOJu0YwvxDVc29qeXKO7JCtj+uCTKD9QO3nqul8xhYklPdAnRdmVx6ZV
	cCjGr4l2WJUUnWOUVCVYTe+qpf9CHiS4HQnf9WLP3XlumLdwG4urHQNhZrelmSpGbJUiXLsrUor
	1eVumKk4XzlS6hP/SOmHKUPBYt6+gEA==
X-Google-Smtp-Source: AGHT+IF0M79eGSxhmxv2UHq1+f7qaJWdUNotcjK3m7Dc0sMtnwosD2mpmao6+PimviLiW2Q4wQHuhqft/nehI6oKwEA=
X-Received: by 2002:ad4:4ee3:0:b0:6cb:2cdc:957e with SMTP id
 6a1803df08f44-6cb9a30faacmr60223506d6.6.1728193729244; Sat, 05 Oct 2024
 22:48:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1805.git.git.1728192814.gitgitgadget@gmail.com> <4199434bd6ef2142192d1c720ccd877b1a80536b.1728192815.git.gitgitgadget@gmail.com>
In-Reply-To: <4199434bd6ef2142192d1c720ccd877b1a80536b.1728192815.git.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 6 Oct 2024 01:48:38 -0400
Message-ID: <CAPig+cTb4mgpXnN79UrXvjvCnqGZhaR51oZX_Ds=HwdqQYFN9w@mail.gmail.com>
Subject: Re: [PATCH 2/2] [Outreachy][Patch v2] t3404: avoid losing exit status
 to pipes
To: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 1:33=E2=80=AFAM Usman Akinyemi via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Changes since v1:
> - Added "tr -d '[:space:]'" to handle whitespace on macOS
>
> Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> ---

Thanks for the submission. A few comments...

This second patch fixes problems with the first patch, but since this
is an entirely new submission, you should instead "squash" these two
patches together and then force-push them to the same branch that you
used when submitting them via GitGitGadget, and re-submit them as a
single patch. When you squash them, keep the commit message from the
first patch.

Reviewers do appreciate that you explained what changed since the
previous version, but we'd like to see that information as commentary
in the patch cover letter, not as the commit message of the patch
itself. In GitGitGadget, the way you would do so is to write this as
the "Description" of the pull-request (possibly replacing or amending
the previous description).

Some more observations below...

> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.s=
h
> @@ -401,7 +401,7 @@ test_expect_success 'multi-squash only fires up edito=
r once' '
>         git show >output &&
> -       count=3D$(grep ONCE output | wc -l) &&
> +       count=3D$(grep ONCE output | wc -l | tr -d '[:space:]') &&
>         test 1 =3D "$count"
>  '

The reason this was failing for you was because you quoted $count. Had
you instead written:

    test 1 =3D $count

when it would have worked as expected. In other words, you don't need `tr`.

These days, instead of manually using `wc -l` and `test`, we would
instead write:

    grep ONCE output >actual &&
    test_line_count 1 actual

However, that sort of change is independent of the purpose of this
patch, so you probably should not make such a change in this patch. If
you're up to it, you could instead turn this into a two-patch series
in which patch [1/2] fixes the "Git upstream of a pipe" problem, and
then patch [2/2] converts these cases to use test_line_count().
