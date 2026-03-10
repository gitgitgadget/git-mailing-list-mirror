Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CB7374171
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 10:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773139377; cv=pass; b=lLNZ5SFn/SuZJKGVKGE89Dbi8mPBDPmBXVNZ0Z/PCWzUJSAZ8y/4p1D3bgiAKOXA68fdaHvqwCFPTCDHs+hgmDs3LRytQQy/5H5qffzP1CHKG5jRpyphOFUjISveA9ampnbTA4RJuG83D5opUyzuCZznpSka4D9Um8DyImlMeEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773139377; c=relaxed/simple;
	bh=CZV6Ex+DWN0D8v/9RIJd54AdAyIJJ/kSWfqYnRLTqfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UV0uyFhDxtOEFkucqYaMs1z+iZe7ZNfpWEXb+1PMDrwUz+x3ts8Fz3cOOh6LZofi3vszMjiysH6BOsEZkZA1P70FHWZ7DvL3CGZqUGw3OJZYNMJLdY8PhXDnThlkZ3effp6DTQ1Hn3fALlwupnK4cfDOhPw0C8EhFx8fk5Xu/tM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqpkkVfN; arc=pass smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqpkkVfN"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5ffe0a56b29so1177522137.2
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 03:42:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773139375; cv=none;
        d=google.com; s=arc-20240605;
        b=Iyd1mZPaGGy8zRwrr4J0u/StKrz9eOvMFFpDP7QdzpFbIMuf+Z754ih7Na6gbRNPen
         u5e8JUKHyG9gRz59UVA0GprDo1NTqnjCHjhI/YogCUALMkQv3OGr6N8Co72LoR8DxXM5
         /8ZqUdc/OQnS2f8uZCMg7Jrlsfu0M6MY19kaYlZZR5Xan/dguLTViVLRnjqeuRX5SoNk
         N1CNOSE8dsjWnlD5G0UMs4SIS3BPfcrewNDhnK0b5n9BwBRZKvWMPQ/XceQY+VJqqcVM
         EyX+FE8wkKjUUwDMlo5u2plD9MEA/FpBcGXi6LaGzAIv4xBTA54sReS8sauLQxnlTq4X
         obHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=InaYn0iaqBCFHnP0IEdRc3v+I74qiGkX0irhHjSKTuI=;
        fh=xPC0/u4coVEKo1KGGyga0mNptdvwTVXi+q1OlEq6yRQ=;
        b=F5x2AQPvpGQkp+c9lXEAXyCs16wmCRq/VcUB4BXdTshzkHRjk+bJN7wkPmuS0S0RpO
         waNGv7hauwrJfWH6sQO1DA6cKR6WHA+nsILv2e0iD4SSr0REK4KsEB4NuzP4sSaj3Cs5
         HpcWkyc2wUgL4LsXG9eLM9FgrXpTr8pmDwE/AZtDdMafnMZL5RgVIs563MTmMPeb/7Vd
         by7+5n+6ItXN4Byvw05bWIs9LCAOS+WyOk6Z3HcGYvz/ekwwppiBWi4z0Du7vXtbwSk8
         xyF8NJp5b7NS+qbaLjLkwB41H0zes+MRrIGtn5nBFnVhftZcLwKAEa4YImwV0xqyKM0m
         pgJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773139375; x=1773744175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InaYn0iaqBCFHnP0IEdRc3v+I74qiGkX0irhHjSKTuI=;
        b=SqpkkVfN6RTzqZcISpkLr/fPLHiJJ311WTy47PawL4TQzwdE4eAstAnc1ko7N3q/Rq
         Ga8k0eNDZ3/+D9qkApmZXsF7l3349tIYb6ipEdWwgMiDnSoFEnxTc6cXwIqqhVaNPIWS
         zto+51nFFIGbdp4Ie1itCetqnCue3IlIdRGLaFBUSoyEUrS9tNtyzt2haAEYRy8ySwa4
         OjONYIjE+uxx7H4etZbxzvQzzdHbP+MlcpaLA/np4Uvqkg2+uUrihzOVy/+R8veDwnBc
         SU7JNhqjpBek5NcyKbYVy0nPEcqRUTu/xvxcj7r45L/7Pc81jKePCwZzcihGTLNrXYej
         4RYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773139375; x=1773744175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=InaYn0iaqBCFHnP0IEdRc3v+I74qiGkX0irhHjSKTuI=;
        b=uFuect9hrwlmBBeo5i4djVzJzzbmtsy+hvRG8RSSxBFkE24NtJlZG8NpXJEHVExDHs
         XAwq9+2yxXpgYqFqrpZqAWauYzNgl/WBcF49LdROjlhsflkebORVHzaPVHM3tOpBMfR9
         q2tWGLhf6CWGTLHn9jkZ38MC+xqcxtUb/qe0Pl6NtSS7rnV5OoRvcG0U4Q7hbqepak06
         b1T5XVIKEEj/7j1bc7hUUZYNHisSYkuN0Mk4SFtNCFz5i00HSJKOh7yq2zufCjOhGLvZ
         6/PKuqvJuVhasX6uDQIXW/KNEbModJeMQDCOaN7rUTkxPipUHNfCJfG+Uxy92B+deRnq
         h8qQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYAw4KcF/+chgMBeBjqS51oPLer+zq6UeL+gT0+U4CRgzyOwmSuGBsx+cQZy6VXJIVGkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC/3i9umFxixy78LXb4/S/Cb4iWvT/x3ufBFkdMWklnXXzwvHK
	jPrqUku5YMKPX/f0t1YMJ1oy62sdUyWRkcSgEwACuuyanmiIWjl1UdSCGgGxSYLFVoHDW6nE2v4
	PyyXw/N7KuObNp4kDGgPFY6lyutAyNtncaSF63W0=
X-Gm-Gg: ATEYQzxx9kCWqKu6qEI3IT7LASpWgkkYOS4F3lcxsGiXxgaKBtU1thvC5bUeAdDkuQt
	W7R0eZmuGhWTazgCfWYamm/YidiXq/VBib4s2GALQND+Hv/2ipm0LzeXsn3EFpmGNmbi8sHalv8
	iWcmZV5FcDvl2UpP3VuvArT4VLta54mjV9iHsmg7I8Gi+B66m+pVSXk8nLFwxebZxUh24B082iv
	YaHGEzryya7sSx/h833+p6KSs8IPyb9BR/2YNjw/o/9+yjN6wPoy6jxd9TNFyU1fsAFrn1GIK+X
	XJdhUCH0pHRwPY46CGMLrkJ0YoyBkB9O1/FKdm8L0evN8WYfOmcGQPtD8x7OnAewGWgv039Rgc4
	c+0/ew3iM9EIr05K7CYU=
X-Received: by 2002:a05:6102:d8c:b0:5ff:e139:c02 with SMTP id
 ada2fe7eead31-5ffe61226afmr4624558137.25.1773139375033; Tue, 10 Mar 2026
 03:42:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2233.git.git.1773132678.gitgitgadget@gmail.com> <5f100fe0-d601-4ee3-adb9-a2458203d10d@gmail.com>
In-Reply-To: <5f100fe0-d601-4ee3-adb9-a2458203d10d@gmail.com>
From: Arsh Srivastava <arshsrivastava00@gmail.com>
Date: Tue, 10 Mar 2026 16:12:43 +0530
X-Gm-Features: AaiRm53CcPY67D5dw5eNDlw1pdBV7m4Z_jSg9HahyNniw2HSgMLzZ6Fm414htYY
Message-ID: <CAOAgETPnZww2vB1zz37nRNEJnmnDjwWyEPDHjRFuijin3memyg@mail.gmail.com>
Subject: Re: [PATCH 0/5] Advice on checkout dirty files
To: phillip.wood@dunelm.org.uk
Cc: Arsh Srivastava via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you so much for the advice I will
> rebase my file=E2=80=99s pointer head
And just wanted to know what do you recommend should be my changed
approach for me over this pr to make that function useful


On Tue, 10 Mar 2026 at 4:03=E2=80=AFPM, Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Arsh
>
> On 10/03/2026 08:51, Arsh Srivastava via GitGitGadget wrote:
> > This is my submission for microproject [GSOC]
> >
> > This patch adds a new advice type ADVICE_STASH_BEFORE_CHECKOUT to help =
users
> > when they attempt to switch branches with local modifications that woul=
d be
> > overwritten by the operation.
>
> If the intent is for the user to carry over the changes to the new
> branch then recommending "git checkout -m" might be more convenient
> rather than having to stash, checkout and unstash as three separate steps=
.
>
> Something seems to have gone awry with your branch as there are other
> patches in this series. You should rebase your branch onto the upstream
> master branch with
>
>      git rebase --onto origin/master HEAD^
>
> and then when you push it double check how many commits there are in the
> summary of the pull request before submitting.
>
> Thanks
>
> Phillip
>
> > The new advice follows the same patterns established by existing advice
> > functions such as advise_on_updating_sparse_paths(). When triggered, it
> > lists the affected files and suggests using git stash push/pop to save =
and
> > restore local changes.
> >
> > The advice can be silenced with:
> >
> > git config set advice.stashBeforeCheckout false
> >
> > Changes:
> >
> >> advice.h: add ADVICE_STASH_BEFORE_CHECKOUT enum value advice.c: add
> >> "stashBeforeCheckout" to advice_setting[] and implement
> >> advise_on_checkout_dirty_files() function
> >> Documentation/config/advice.adoc: document the new advice key
> >
> > Signed-off-by: Arsh Srivastava arshsrivastava00@gmail.com
> >
> > Arsh Srivastava (1):
> >    advice: add stashBeforeCheckout advice for dirty branch switches
> >
> > Junio C Hamano (1):
> >    The 13th batch
> >
> > K Jayatheerth (1):
> >    repo: remove unnecessary variable shadow
> >
> > LorenzoPegorari (2):
> >    diff: handle ANSI escape codes in prefix when calculating diffstat
> >      width
> >    t4052: test for diffstat width when prefix contains ANSI escape code=
s
> >
> >   Documentation/RelNotes/2.54.0.adoc | 14 +++++++++++++
> >   Documentation/config/advice.adoc   |  5 +++++
> >   advice.c                           | 27 +++++++++++++++++++++++++
> >   advice.h                           |  2 ++
> >   builtin/repo.c                     |  1 -
> >   diff.c                             | 12 ++++-------
> >   t/t4052-stat-output.sh             | 32 +++++++++++++++++++++++++++++=
+
> >   7 files changed, 84 insertions(+), 9 deletions(-)
> >
> >
> > base-commit: 3fe08b8fd1f7731edabeab8138547ec88d6407de
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2=
233%2FArsh123344423%2Fadvice_on_checkout_dirty_files-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2233=
/Arsh123344423/advice_on_checkout_dirty_files-v1
> > Pull-Request: https://github.com/git/git/pull/2233
>
