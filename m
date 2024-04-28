Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ADD17736
	for <git@vger.kernel.org>; Sun, 28 Apr 2024 18:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714327742; cv=none; b=PTftK9acbghLpiJxEeKTTtkSZpBg3/C0VC+xRgpckWELB+dPV8322XdrZjgb8QvZuYDBKzF9OnGg7iLgaWTJPwDM7aSecoL8rNJ8YXwOmuCAwFhra98qrjqKcx/xWgIYC4IlwiHgdE9ML8SMhNaZj94gGZMnHPMA8EYJRhEZeWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714327742; c=relaxed/simple;
	bh=D52MWSCf9zeDZN1aT55lwD10mJKpPLoysFliFfn6HNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rz3ssLA/F/BJrXqR/w9LBMv7aiAK8Da3BWwmkGpQgBshd8SwzmdrRdOgq0krxTSJAcPB19mqt0whIrG46hEjds197yV+hKFg3J8lQHNg+GKyiWWjSngZO80VH3f1A2IEdmoNOIOLvC6W+Q0NuG85A7u+p+qB6lQ3k81kRnom3/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6a0b68733f5so12500936d6.1
        for <git@vger.kernel.org>; Sun, 28 Apr 2024 11:09:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714327739; x=1714932539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IIUc2tG8wmtL6hksmRjx5M3q0dEF5wLXju8XKKzT2mc=;
        b=RaSedS9E7ychhJ2fUbFLVtd3XuT/hurxwzuUBVY2MQs2jHh6Ioumlmrq8BOG30JbpB
         I1H5FavUymSKgc6Za0FPGt0H5999PY2JdjtRkN5lvNYrHGNGbrvUpRp4gqTj0VWs6h+E
         bbD6xB5mzdSAmvcCi4Th4lg1ypFZGU2NkBGJjusOTiDaPfjfqDbYQy4kXmbqkkHMhVV2
         speqseS8bwddtV1rM0xy7QT+O2gollGHXY+druxhsMKdtEYgwud0+iWk2bQodAZYZUDC
         DFNOZ4QM6ta7Br9jZx/otXPCiQ1UElTYQGKyALGeYOsJJHofP0mxlDi7kUioC66bP7QL
         hoIg==
X-Gm-Message-State: AOJu0YxNeP27kViN3WNSMBGCHdulJXYNwQqNB2iUj7gbS/oT48XBQrrR
	iXB2Ur/6ws27YDoSR84T4gKid06YnUn21MX5eL0uOGwKesdHzWqLMaD3Z0FiMuDTp01jI2tyUdM
	wRge21ItKTPqkjdFtdCFEqOJ0x+oxeEcZ
X-Google-Smtp-Source: AGHT+IH4d8GG0I2eLJYUOHN+viH+ngHJWKHQ0zus2jR1GlT0EsFjLyIv4RS4Eqrn6LeQFZJqjsQ7NI6VzgxNd6DXRbA=
X-Received: by 2002:a05:6214:12d1:b0:6a0:ad56:375b with SMTP id
 s17-20020a05621412d100b006a0ad56375bmr6383309qvv.0.1714327739044; Sun, 28 Apr
 2024 11:08:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANHPH1-6mbWdt_FLsrDEB_XVb4r3yTYMLLPUyDrL6tmS7jZgqQ@mail.gmail.com>
In-Reply-To: <CANHPH1-6mbWdt_FLsrDEB_XVb4r3yTYMLLPUyDrL6tmS7jZgqQ@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 28 Apr 2024 14:08:47 -0400
Message-ID: <CAPig+cQ39Z+WjThqkxCKgOUfkZyB6PG-6RhHBYhinp-ZY4dxKA@mail.gmail.com>
Subject: Re: Unexpected behavior with the rev-parse operation
To: Toru Okugawa <castor.4bit@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 9:58=E2=80=AFAM Toru Okugawa <castor.4bit@gmail.com=
> wrote:
> I have encountered some unexpected behavior with the rev-parse operation.
> ---
> $ ls -a
> .  ..
> $ git rev-parse --is-inside-work-tree
> fatal: not a git repository (or any of the parent directories): .git
>
> What did you expect to happen? (Expected behavior)
>
> If the current working directory is outside the work tree, the
> documentation says that `git rev-parse --is-inside-work-tree` will
> output false.
> https://git-scm.com/docs/git-rev-parse#Documentation/git-rev-parse.txt---=
is-inside-work-tree

I think this is working as intended, but the documentation is lacking
or misleading. With very few exceptions[1], `git rev-parse` expects to
be run either within a Git working tree or within a Git repository
(i.e. the .git/ directory or a bare repository). Options such as
--is-inside-work-tree, --is-bare-repository, etc. are meant to report
upon aspects of the worktree or repository in which the command is
invoked.

Looking at the source code for `git rev-parse`, it does appear that it
has explicit support for the case of checking whether or not the
current directory is a Git worktree or repository. The way to do that
is to run `git rev-parse` without any arguments. However, even in that
case, it will print the "fatal: not a git repository" error. This
means it is your responsibility, as a script writer, to suppress or
capture the error message (whichever is appropriate for your case).
For instance:

    if test git rev-parse >/dev/null 2>&1
    then
        echo "in a Git directory or repository"
    else
        echo "not in a Git directory or repository"
    fi

[1]: --sh-quote, --parse-opt, --local-env-vars, --resolve-git-dir
