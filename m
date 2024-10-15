Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CD11714B4
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 07:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728976303; cv=none; b=CpL7wxVfS9bl6kgIxUf96VcZrrKaA1Qx3YweDIoY3VvL8rRP32KC1ZTXJzz3CxePlPhh33eFhsLF8GnntWlXQlgUbmCvNdG5N9rchivtyDpen0GrLxzYl6+3b/HGWGL9Tu05wupOc6owR0TgpuZK5LnAg+p2ztdU++kcs/eygzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728976303; c=relaxed/simple;
	bh=qsxCs5Gub6mehjAZx5kYpT12+jq3lvUJuCnWbZy13us=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YgiA9Z5YckDcgUVUo5lBHbK/DlhIQdKNDlwOJMouONSd94o21lkz/GcPzWAjk5bupa8CvVmBxvRhTcpR7Xvc/mUro0Vj9f2r+lpulxXQciBahjksBtRmqDrwVz2bJyMwECuNkEtRrLnXOMXxnm21DCsm7/NlWvIqJQz2V5cre6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e2b71fd16fso899396a91.3
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 00:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728976301; x=1729581101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwChYTy/fA8ZcNdM1PJ4qTmlR2c3XKIYKYj59YdPYI0=;
        b=XxObiRkxEDAVXG2W+q6sLzB1nJKT3UBpLNJ3/gOKR+21N6IeRgp1kB0asabmw2jIp8
         tE6HWHyhaFx8R9J0mBRSGYEFh9WvJQNMgqxNBVdeym19d5D2uJ8uDxRngoW++nuGhOyp
         pKaGum+kuf5lfTaH0Bj5vAIeHsotXhovNOjkJiWLY2dz4f2tEySakM/pkUm6sNw46wAZ
         zqPDYqlJvNIKJnUv7oa20mvhOpS7S1OryaWoHI6tpH+i7zVUmqc6xlco+xRsSZSpRIvN
         lvkPuP0jhnYVwi/tigMHVcDRuhmUfo8+3R1v26cqli+YuPG6UBdnqrBcUJDz41A45Rx8
         Gs8w==
X-Forwarded-Encrypted: i=1; AJvYcCVBcoUfkxzYPdJaqvB/iQ7tMnWAEQYBSzitPay9pgLj2Gl8UvEA4HpmunY/XNvezO+m1SA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbeOmiQ23yQ6fWemfjVxJXoWEbqNjkMHVHIM7KdUCQyjy2eYJr
	KR2tfwEdZyCqZBlYnNl2pR42PvsYHJNiB99M2U2KyDU2ON5ZXQixGqsAmnk0o/5cKrWbtoaFGne
	CBe/ObPAr36oVGK8u1y2Slm3gcHnbvEhN
X-Google-Smtp-Source: AGHT+IFbuWo3crhTrqV68VsByH2QOWpssLXApy8OfnlCrlFbjgdrO1cstwWcGY+VNceHd0bDrdlQtr03oFQsM12x9Ak=
X-Received: by 2002:a05:6214:76f:b0:6cb:4fad:5215 with SMTP id
 6a1803df08f44-6cbeff37f40mr91347956d6.2.1728976290094; Tue, 15 Oct 2024
 00:11:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL2+Miudq0UXAb=R24v+ftZVkHy2We1CFsFAt__tCYMWtCfOow@mail.gmail.com>
 <Zw2K5xJAOGWitfXr@nand.local>
In-Reply-To: <Zw2K5xJAOGWitfXr@nand.local>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 15 Oct 2024 03:11:18 -0400
Message-ID: <CAPig+cQZoO8tMZ1Gip-at8-9n_tk4axctkX=WbaO1==JRru39A@mail.gmail.com>
Subject: Re: git rebase exec make -C in worktree confuses repo root dir
To: Taylor Blau <me@ttaylorr.com>
Cc: David Moberg <kaddkaka@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 5:19=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
> On Mon, Oct 14, 2024 at 10:46:45PM +0200, David Moberg wrote:
> > 1. This command should return the worktree toplevel, not a subdirectory
> >   $ git rev-parse --show-toplevel
> >   /tmp/tmp.DUUAVQCIKe/repo2
> >
> > 2. And the git grep command should return the match from dir/Makefile,
> > not Fatal Error
> >   $ git grep banana
> >   Makefile:       git grep "banana" -- "$$BANANA"
>
> I am not sure if this is expected behavior or not, but it feels
> unintentional to me. Perhaps I am missing something funky in your
> example that is causing it to behave this way.

This looks like unintentional behavior; probably a bug. It seems to be
triggered by `git rebase -i` setting GIT_DIR. Here's an even simpler
reproduction recipe:

    % git init foo
    % cd foo
    % mkdir dir
    % echo foo >dir/file
    % git add dir/file
    % git commit -m foo
    % git worktree add ../bar
    % cd ../bar
    % git -C dir rev-parse --show-toplevel
    /.../bar
    % GIT_DIR=3D../../foo/.git/worktrees/bar \
        git -C dir rev-parse --show-toplevel
    /.../bar/dir

The `git rev-parse --show-toplevel` invocation with GIT_DIR set is
incorrectly returning `/.../bar/dir` rather than `/.../bar`.
