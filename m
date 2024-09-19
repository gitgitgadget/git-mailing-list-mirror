Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9992E1991C8
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 08:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726736321; cv=none; b=Du8bIHbxCAT4l6FJphioZ78tyhiPwKX7bb8i2p6a7qpvBcuHSAKP3FDcaRkCX1ERdwrLejijteIJcxfKQdaeNoZd4i/4ANp/Crg8Tc+jKeQyveCbRkmEGM0JeAzG8RgTckAj8IYBmeBNhvOPQRt6RUXXyeH6PDK/nCd5DiKzjO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726736321; c=relaxed/simple;
	bh=krfyhyqklLljKbVs9vfGszRGpdUn/VxnbQ4hgknHdVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h9GC/jXTy6zSZu5XnvGtdwCLT8PBHFNl4YD+e/YhwBzXKn1r6SwAVSYwb3phMJJ2HSQLLWhDmpwZ6a3Vp/jrvP2HVvwAZSwUUdDtPe/0UmqhkuoXlJzAwcOFAFFYW30A/8s8g9GgQsm9IvhvlgvvE/QHgXdluatXqMAWyKpK+/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-846c6eb4055so21826241.0
        for <git@vger.kernel.org>; Thu, 19 Sep 2024 01:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726736317; x=1727341117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgT9xRjQbHBrnUxADFrQakt8lIpcQapMPF96v4dDtwc=;
        b=a/O8VDDQEgp/e5P0PPrt1hSOKl5ZitVL4RTaJescaGo55aWzKoDsSIGHao5V62fiY/
         ivHMwwsr8MH5boGOY7+U3ncOwXV3mAA6ZqihArPCeRWQzzhsvWz5D08IIo9VS/4dO8BR
         UN2xAMxwHfud9648cCAT4hOWT6P8x2kFoY+vpeAobbVY2BBjJUwPKxUeh8U8JifVyZYp
         L3/59ZYSIHfibeFsyYnxgQ8V1DFEyptuMMM0Z+I5XHJ/pl1dEr3B3+IxWSoz5wFes1P0
         1fzkffA4ND6gWX5ZpesOCqoK3YmcSnPARDKw3n/vWo5mS0d9XPBUZ+Ct1xWDlH6ou7vI
         Lj2g==
X-Gm-Message-State: AOJu0Yw2O9GYnzPeLxLmk8Cmb8zb71irAqEM/gbU9/w1MivbrzcGWdvv
	9V+q+hNckMHVWab/6230BKYnZyhvmMxsTwXFBXiOuAVPCeoEsDkrXRgKAqf1DeHq9Tf4CFey5Zq
	iROdr76KIDdBlqxNiZ1csDEYLTsBQOA7O3vs=
X-Google-Smtp-Source: AGHT+IHSdAKIFflrf9gOdKNhqwR+qBMB4CqcPz+nWubiIP81WCRpaf6/zw8GYBAdJyNx8UkBSGFozsaDE0895gcF+R4=
X-Received: by 2002:a05:6102:3e84:b0:493:216f:eb7a with SMTP id
 ada2fe7eead31-49d415a8446mr8769216137.5.1726736317398; Thu, 19 Sep 2024
 01:58:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <E1sr5iF-0007zV-2k@binarylane-bailey.stuart.id.au>
In-Reply-To: <E1sr5iF-0007zV-2k@binarylane-bailey.stuart.id.au>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 19 Sep 2024 04:58:26 -0400
Message-ID: <CAPig+cQ8=Y6sVvN_dBo_GQ5nLkQ4GJ7AM6mE2kt_2QV7CR0omg@mail.gmail.com>
Subject: Re: "git worktree repair" modifies the wrong repository
To: Russell Stuart <russell+git.vger.kernel.org@stuart.id.au>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2024 at 9:27=E2=80=AFPM Russell Stuart
<russell+git.vger.kernel.org@stuart.id.au> wrote:
> What did you do before the bug happened? (Steps to reproduce your issue)
>     /tmp/gb/a$ git init r
>     /tmp/gb/a/r$ git worktree add ../r.foo

Had you run `git worktree list` at this point in /tmp/gb/a/r/, you
would have seen:

    /tmp/gb/a/r      3699610 [main]
    /tmp/gb/a/r.foo  3699610 [r.foo]

>     /tmp/gb/a/r$ cp -a ../* ../../b/.
>     /tmp/gb/a/r$ cd ../../b/r

Had you run `git worktree list` at this point in /tmp/gb/b/r/, you
would have seen:

    /tmp/gb/b/r      3699610 [main]
    /tmp/gb/a/r.foo  3699610 [r.foo]

from which it can be seen that /tmp/gb/b/r/.git/worktree/r.foo/gitdir
is pointing at /tmp/gb/a/r.foo, which makes sense since that gitdir
file is an exact copy of /tmp/gb/a/r/.git/worktree/r.foo/gitdir. So
/tmp/gb/a/r.foo is being shared by both repositories, /tmp/gb/a/ and
/tmp/gb/b/, and neither one knows about /tmp/gb/b/r.foo.

>     /tmp/gb/b/r$ git worktree repair ../r.foo
>     repair: gitdir incorrect: /tmp/gb/a/r/.git/worktrees/r.foo/gitdir
>     repair: .git file incorrect: /tmp/gb/a/r.foo
>     /tmp/gb/b/r$ cat .git/worktrees/r.foo/gitdir
>     /tmp/gb/a/r.foo/.git
>     /tmp/gb/b/r$ cat ../r.foo/.git
>     gitdir: /tmp/gb/a/r/.git/worktrees/r.foo
>     /tmp/gb/b/r$ cat ../../a/r/.git/worktrees/r.foo/gitdir
>     /tmp/gb/b/r.foo/.git
>     /tmp/gb/b/r$ cat ../../a/r.foo/.git
>     gitdir: /tmp/gb/b/r/.git/worktrees/r.foo

The implementation of `git worktree repair` started out (relatively)
simple, handling the most common cases, and has been extended to
handle additional cases when identified and reported. The case of
merely copying a repository and its worktrees (and leaving the
originals intact) is not yet implemented, so the above all makes sense
given the current implementation.

> What did you expect to happen? (Expected behavior)
>     I expected "/tmp/gb/b/r$ git worktree repair ../r.foo" to alter the
>     repositories it was run from, ie those under the directory "/tmp/gb/b=
".
>
> What happened instead? (Actual behavior)
>     "/tmp/gb/b/r$ git worktree repair ../r.foo" modified the repositories
>     under the directory "/tmp/gb/a".

I have a tentative fix implemented which seems to handle this case
correctly. Once I've finished polishing it and formalizing the related
test, I'll send out a patch.
