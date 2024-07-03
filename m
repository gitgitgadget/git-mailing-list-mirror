Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172951DA317
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 05:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719982839; cv=none; b=p/L+pPCUiJRtzDH1lEwRYSCt41n7bUhIOk8W9CcSYKxbchbfEqfPbRERjP696fKBAI1+qEWFxri393OPK33N2w/FGEah68d4SJoiH9DrYnYJG/MwddD8Tu3WJDT5Ab/H2Bog+T0nJ5UhFlAeaIDsoJfvBvf3lAk22ck0l95EHzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719982839; c=relaxed/simple;
	bh=azMzHbp2iiQ48mW6PbO/GFs/QbbFzlRFpvgXachHNU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HfqWp+8u2eoSzimfcRv0wKcu4QmF8d8YZJTSLs1mTipSfohN3fLPaKDhFBaXBzw4YGezeEqJqDP+gk4+RbUtyryPacZWwfwkW+5ag6msFMhuKXhYtdASL0OU3aRsupym7h4kMbgMrKIHwII2JAYHnWxJBPwpitWgjCPvPUAiMDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ced8p6sY; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ced8p6sY"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-58b5f7bf3edso1009873a12.0
        for <git@vger.kernel.org>; Tue, 02 Jul 2024 22:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719982836; x=1720587636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4ywSzWtid6xRvS+WDNinjoGsxE1aEu3vkfKaIMkXrQ=;
        b=ced8p6sYL3FIgsuz472XWDjYpZYEJhF5Y14IrwTPevLvRCRugCNejev8OVaCGbQUac
         kXXNB8I6L/E68P3M+3gPGfpruv5kAbVu5Dro6ykS4rF6jbQ/rkgCTTCiHfEpvHPjanz4
         NuxkI2jJM2TVFvZzWTFROUPEOCjG6CfOheNAyOPn8eVTxjnCTy59cRsqhnv/ArtwwwNF
         R+mAXeNJRd+opl7QwcmlYZ229kSXBRa8QDO8by4n43C9Dfecz+t5uf5NmF6frPiXGqeW
         gU+rAbSij1y/qGef5SHNju9zGvtn5KrtXIO9nIWWFNX1j6f2w2i5o+bf7MCjDy3Rtesd
         umaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719982836; x=1720587636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4ywSzWtid6xRvS+WDNinjoGsxE1aEu3vkfKaIMkXrQ=;
        b=UXQGU4mnk6j6SB9gfEdKr5BLUw1avJ5ll0U8/Kyh+mmIgAJekg+QsU5cD8u+7vhfs2
         C85Q7Bp+6A16ihKoxFbrd8RcrQNn6cMvVESYu6h3rXh1SRnBG+AFV8uhuxRrhodFDaEF
         +7Ls3tdQLmWHPyRX7mVRU10BDd1R1fwIz6ODTqjIPfEYij6ANXRHpfa8OYvNCPdCLa6q
         ++FszBov1P4/0hummo/cjNMcoCpSiieuv9ObEM+x9DsBNk0QhrSfJ+xaimHqoHc095Ss
         av+RMiCpuFuAJtehoQKPulXkv0Bv+qDIhASpXkDxJzbPJcq9x8c3RrpBT9nSbyN7Gd6H
         EI8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU0pJPXEHT1t71YQFRR/JPTNl6ZMZG7L0km7zm43Q8wKKcVRXJeCy64gBLZYwfDEhpWJR17fhgSlPjRXwo+7+hrIEMP
X-Gm-Message-State: AOJu0YwVI2cLY0GDgFDqRPqmcyLr+w0zjPsBm6AS66qtG0hxuLTRZnI7
	Qq21vtjy2agXXdgNtg41q6a6Fn2JOPb5Lvkk1heMc8mLgNsltDs3PZERYFquY9ZGvoPpY0MS3sB
	FPVOz7N3fiXApnzZ/szts2DndQMk=
X-Google-Smtp-Source: AGHT+IH3inQrZGRaPawPUj0W2MdzL3ODJN6IJJE0D6Fn57nNtDpUsTtzo1hTsVuVj4cEA7osO8pIKAgJQ9HzdxY8p+M=
X-Received: by 2002:a05:6402:5241:b0:57d:50c:e28d with SMTP id
 4fb4d7f45d1cf-5879f2b8042mr8855608a12.10.1719982836035; Tue, 02 Jul 2024
 22:00:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1740.git.git.1719947271.gitgitgadget@gmail.com> <07d801daccb3$c1de13e0$459a3ba0$@nexbridge.com>
In-Reply-To: <07d801daccb3$c1de13e0$459a3ba0$@nexbridge.com>
From: Bruce Perry <bruce.a.perry@gmail.com>
Date: Tue, 2 Jul 2024 23:00:10 -0600
Message-ID: <CAJ_CbHX5nyvMy3ZO+YYCWnPhUmS2QZJjTzsePqXT2TEy-LBQfQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] clone: shallow-submodules should be single-branch by default
To: rsbecker@nexbridge.com
Cc: Bruce Perry via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Stefan Beller <stefanbeller@gmail.com>, Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Randall,

Perhaps I was using imprecise terminology. This change should not
impact whether submodule clones land in a detached head state, so it
should not impact anything that assumes submodule clones are detached
head.

The change being made is this: "git clone --recurse-submodules
--shallow-submodules" currently gives you a submodule with a detached
head at the desired state, but also downloads data for the tips of all
branches in the remote being cloned (potentially a lot of unneeded
data as in my use case). The modification means the same command would
give you a detached head at the desired state, plus the tip of only
the default branch in the remote. The modified behavior matches the
current behavior for a simple "git clone" followed by "git submodule
update --init --recurse--submodules --depth=3D1".

Thanks,
Bruce

(Resent due to a formatting failure)

On Tue, Jul 2, 2024, 1:12=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
>
> On Tuesday, July 2, 2024 3:08 PM, Bruce Perry wrote:
> >I noticed a couple places where the behavior of recursive clones for sha=
llow
> >submodules does not match what is implied by the documentation. Shallow
> >submodules should be, but aren't, single branch by default. It would als=
o be useful
> >to allow users to override the shallow specification in gitmodules on th=
e command
> >line for clones as they can for submodule update. The modification here =
for the
> >former is a bit ugly, but hopefully at least gets the point across to st=
art a discussion.
> >First time submitting a patch here, hopefully I'm getting the process ri=
ght.
> >
> >Bruce Perry (2):
> >  clone: shallow-submodules should be single-branch by default
> >  clone: no-shallow-submodules clone overrides option in gitmodules
> >
> > Documentation/git-clone.txt         |  3 ++
> > Documentation/gitmodules.txt        |  4 +--
> > builtin/clone.c                     | 10 ++++--
> > t/t5614-clone-submodules-shallow.sh | 52 +++++++++++++++++++++++------
> > 4 files changed, 53 insertions(+), 16 deletions(-)
> >
> >
> >base-commit: daed0c68e94967bfbb3f87e15f7c9090dc1aa1e1
> >Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-
> >1740%2Fbaperry2%2Fsubmods-clone-bug-v1
> >Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-
> >1740/baperry2/submods-clone-bug-v1
> >Pull-Request: https://github.com/git/git/pull/1740
>
> I am concerned about this one. Many CI systems (including Jenkins GitSCM)=
 assume a detached head for submodule clone/checkout. Adding a branch to th=
e mix will change the expected semantics. Am I missing something?
> --Randall
>
