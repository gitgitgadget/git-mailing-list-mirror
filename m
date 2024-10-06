Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073F054F95
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 07:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728199718; cv=none; b=CnnY41QdypO8Mofx+FE7ntYW7wx+WgDDJic0E5gGzvhBoqMgkqBihMkF7NTeQUrtR+Rkc/BrHsbFyrYx5Fy7cEwZuebm6HvsrwOA747nnmKdxSohCmw9Ry8Nd+s/Zmj841i4JaA+284C85tAucnC4HufUNTKFCJh5CVyKIVTkgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728199718; c=relaxed/simple;
	bh=n4l5UYnWrNmEiPX+HXvJJ6TpZei0pa8fN00zCTnGkVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GxN0uVoiJ3hAfKksD/2BT5I+aK8jc3S79yri4wOj+PiAuIRB72ltJMdY/arHpsnzLA125gzkycVdPWrbZxrKgp5wNT1RZ3H6AOyCjMT6hZl9bX+hbAkfm142mx4JD4zo4r0Zia+RmF5sRmOqzBvNxNRJykZllpOtIYTV2o1RZVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6c567b2e81fso2665756d6.3
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 00:28:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728199716; x=1728804516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wbXTa2ipuuFLwZpqMYs+BKz+Q4D+Zu6GhiNS54FE+4U=;
        b=vJQciFcbtbexsE+c0XONjvz//D1dj2PQuyhGLHjNQvpkd0Pi/h57bNsb3P5g+6H+JB
         dQV6p9P9RXGtbJlBp6MV7r1cLCY4It66bOAwYC7G+aWphlZf1XsQ6P222LYWFiYkMyyv
         5pn9+lEF+czf0VhdoSX3k43xTNqgyazj9iIJeq3Y4ytb6o+Jjbu08thXOOgUD7PjCwrU
         lMWcFHZysKislTbvKJTJa8vKwpp7xrq6kf2niJzKbfMvMZhcI8LwRoV5jiEbrU44MMsy
         i90qtrlBzTdkIiJOiUt1DR45e6vk4GTLYiU6QQs5vwSe3PsJ/woedhrtcy7lTkg2t0Sp
         FsWA==
X-Forwarded-Encrypted: i=1; AJvYcCVWeIAWDYLNTi7xseODQovnusds/9Ov1eyQpZl9uY1hlzOUDAFkvnnOxDdUe+RyzdamFPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhQWSrAxS9/2lywDlpwZVVnDZ/emedGQ3vIoo0t14iCIEkYYh3
	+cHVBJjNiBVU6qcYfSDC0I7wEfaFoPz64qlQ++pUDmrZFd+3GoOmY1lD/FveR/MXCgJbYAVJLRU
	zxbFgqSESbQTGk+bJR2CaM8yl8FMxCQ==
X-Google-Smtp-Source: AGHT+IFA+kuBaaQwNhDOE7uxqRXj7xYofWvaBVEisEO9BoEk7UZLeGoqjsn2q9GG8xtbDXQxcLydNoa4ViQqpMST1DI=
X-Received: by 2002:a05:6214:ca6:b0:6c3:5dbd:449c with SMTP id
 6a1803df08f44-6cb9a2eea34mr56719276d6.1.1728199715807; Sun, 06 Oct 2024
 00:28:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1805.git.git.1728192814.gitgitgadget@gmail.com>
 <4199434bd6ef2142192d1c720ccd877b1a80536b.1728192815.git.gitgitgadget@gmail.com>
 <CAPig+cTb4mgpXnN79UrXvjvCnqGZhaR51oZX_Ds=HwdqQYFN9w@mail.gmail.com> <CAPSxiM_RKpp2_Y7HqhhFJqnavKpToViAjE3s6AiwCwUjGa8H4g@mail.gmail.com>
In-Reply-To: <CAPSxiM_RKpp2_Y7HqhhFJqnavKpToViAjE3s6AiwCwUjGa8H4g@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 6 Oct 2024 03:28:24 -0400
Message-ID: <CAPig+cTkj-wXqgLNM5hyKa9c3U3AT6L2oUpdbTg7nGUHpa=1Vg@mail.gmail.com>
Subject: Re: [PATCH 2/2] [Outreachy][Patch v2] t3404: avoid losing exit status
 to pipes
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 2:31=E2=80=AFAM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:
> On Sun, Oct 6, 2024 at 5:48=E2=80=AFAM Eric Sunshine <sunshine@sunshineco=
.com> wrote:
> > This second patch fixes problems with the first patch, but since this
> > is an entirely new submission, you should instead "squash" these two
> > patches together and then force-push them to the same branch that you
> > used when submitting them via GitGitGadget, and re-submit them as a
> > single patch. When you squash them, keep the commit message from the
> > first patch.
> >
> > Reviewers do appreciate that you explained what changed since the
> > previous version, but we'd like to see that information as commentary
> > in the patch cover letter, not as the commit message of the patch
> > itself. In GitGitGadget, the way you would do so is to write this as
> > the "Description" of the pull-request (possibly replacing or amending
> > the previous description).
> >
> > These days, instead of manually using `wc -l` and `test`, we would
> > instead write:
> >
> >     grep ONCE output >actual &&
> >     test_line_count 1 actual
> >
> > However, that sort of change is independent of the purpose of this
> > patch, so you probably should not make such a change in this patch. If
> > you're up to it, you could instead turn this into a two-patch series
> > in which patch [1/2] fixes the "Git upstream of a pipe" problem, and
> > then patch [2/2] converts these cases to use test_line_count().
>
> thanks for the review. I really appreciate it. I have a couple of
> doubts to clear.
>
> My next patch should be the squash of my three patches which include
> my first two patches and the new one on the same branch ?

I'm not sure which three patches you mean. Does the third patch, the
"new one on the same branch", fix problems from the earlier two
patches? Or does your third patch implement the suggestion regarding
test_line_count()?

> Two patch series means two different commits on different patches ?
> But, since they both depend on each other would not they lead to merge
> conflict ?

A patch series consists of one or more patches in sequence. Patches
within a series don't conflict with one another; later patches build
upon earlier patches. You create a series of commits on a single Git
branch. When you submit that branch as a pull-request via
GitGitGadget, it turns the commits on that branch into a series of
patch emails to the Git mailing list, one per commit.

Before submitting the patches via GitGitGadget, you polish them
locally to repair any problems before submitting them for review.
Rather than making subsequent commits fix problems with earlier
commits, you instead should fix the bad commits by using "git rebase
--interactive ..." to either "fixup", "squash", or otherwise edit the
bad commits. Once you are happy with the commits, submit them. This
way, reviewers only see your polished result, not the series of steps
you made to arrive at the polished results.

You do the same thing after reviewers point out problems or ask for
changes. Edit and re-polish the existing commits to address reviewer
comments rather than merely making new commits on top of the existing
commits, and then resubmit once all the fixes have been applied and
polished.

When I suggested squashing your two original commits it was for the
above reason. In your original submission, patch [1/2] had some
problems which you fixed in patch [2/2], but reviewers don't need or
want to see that; they just want to see the polished end-result, which
you can obtain by squashing the two patches together. (However, in
this case, as I pointed out in my review, you don't even need to use
`tr`; just use `test 1 =3D $count` instead of `test 1 =3D "$count"`.)

If you wanted to do the extra step of also updating the tests to use
test_line_count(), then that would be a separate patch, still on the
same branch, built on top of your "fix Git upstream of pipe" patch.
Thus, it would become a two-patch series: patch [1/2] fixing Git
upstream of a pipe, and [2/2] employing test_line_count().

> Also, to be clear, "Description" is the body of the commit message if
> I use the gitgitgadget while the "commit message" is the header ?

The commit message is separate from the patch-series commentary. The
commit message of each patch explains what that patch changes or does.

Once you have polished your commit(s), force-push them to the
GitGitGadget pull-request you already created. Then edit the very
first (topmost) comment in the pull-request to explain what the patch
series is about and what you changed since the previous version. That
comment becomes the "commentary" portion of the patch series.
