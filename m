Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2E43B637E
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 21:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787002036; cv=pass; b=LJBR/NSTZqtI3nc8KkONZnc3GIAj3+hn6KqheP92G6tgBqauZXlR/SOEbq5S/D8gI2QLLFEws5RXmAeneCsdUPhM/Q5NY5iq3zc/I0kxE8yIOVpNfskfV0A2R7snAsf1jPXLjveTZUE/CEoEXJSVaKqGVZI+skxIsCr/fTgk+Fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787002036; c=relaxed/simple;
	bh=+CVDgJSzP4W62Qytgkcm5X4eKOrmOfAoA7o6pXLUeIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mvXHzDf0iYYF5YL7wMt93xNJqqKTpZJ4NxQsraK2wQeLF0BXiT7erO6aacgXcA2t1MtehHQ2ldb+GJR5rNU6iQSc6eRf4bIcqK9t9HvJybmktFOVF7Y3VHpvIw3ajHd0vj6mKByKYZvJB/9mIhfvxSRLOKTx3d9mJf5JGRiquYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoQQkuKM; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoQQkuKM"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8fcc43c48f7so38009246d6.2
        for <git@vger.kernel.org>; Mon, 17 Aug 2026 14:27:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787002033; cv=none;
        d=google.com; s=arc-20260327;
        b=QacAPiKAGghoWlTH4Zw1qZbjvOAwkxUZrgc56j+jfl5W/ueh/y/cKvPAssZps8B6NY
         v5C3HGN1Cu2j+i2IB0FbZCwGtiYylPATOU3yRALhABkkIxUWOtd9Tr9J//+R32OaoD7d
         oDCZ5kfRephwHCpAOzDwpzAPEA4zum6OrbnN/VzB32+cei19ONR+Snjgek0aEjsrKRU/
         5diiiLohJojJN17+HneSw1BGcRY0htdNJO4pAWQFc/ymD8M+D5tJgIXAWStIa34qImTj
         hcgB8k1PbrmTsGSlwbJdRhoc1f5RZm1KCBqejh3ws8yXS8UHgUcabp+FNfkSeB225m9T
         00Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t01ZmxYU0GokxxjPy5SbFvQQYwe42lh37o4xx3SrMyU=;
        fh=NTy4HJ/AJZ3E5vxsEh+jABi5oDorDVRyl2916t6T59I=;
        b=XVc8uMMTgu7DA3WTidvPr63oFhjM1rO/nq24XMvXd+OrlAcBOEnrabq+U0UWtonqk8
         QoMnO+QVFWrx7h8DNQQT7G63tB0BS/mM/f0Tu9jy/UjNr2S+ksgMVOopjTvdQr2YETYC
         fP1GOPAg21Dp6Bd57OdRxsXZUv2BUkJ9FyXg0CLU4N1RWDrMMzQ+f6Yl1RcLy5Hi1wPX
         YWPRIMRmbo4QuLkuaEbgUlH09x9h770rXBpZmzfMDRvKWGAJ+ZP7ig6vINpKpKckUvxJ
         PiMwu9tqwu2jWE7yS/gLAwerj3SNmG0zBsLA9nt4SFodHUbkyW5wo0lo0uiF2yKiNpuz
         bWDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787002033; x=1787606833; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t01ZmxYU0GokxxjPy5SbFvQQYwe42lh37o4xx3SrMyU=;
        b=FoQQkuKMRd7A1XIyP5Bq3pMpWIFHtHj7rELWkhsBSnUoiZXy5xQUL9+5rL6wLwIIRf
         HsEQBM9evwuCErQQGiqVc4SBtZq/T5BT1/ujOwFTgc4H/VucE+9UmF5SAdnBvM7eNxLJ
         QBZXXBDBwp/e9GsjQsUMGoKFspcDQbTJMINJu7ePAzQ09gri2RjOtmMmgQr6JWt+vBp2
         InjhoU1zqzPtgyY+mMi3w8QT6+PK/jqCl8q6SOxC15hSWFyA4FV3z8OiEJhjqT3l2THk
         RsEcVXtp5a7QHvzplmXeMOMzu/rXzi26Gp/CZHsslygddNMs7eQz1GFAkA4ovO+QhTBQ
         tf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787002033; x=1787606833;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t01ZmxYU0GokxxjPy5SbFvQQYwe42lh37o4xx3SrMyU=;
        b=EekmjPIIhsg4vVsnthWS9pYw54ghf69JbTc2TEmtmjJdIWeLRvmC4ghpK2LLAi48hM
         w3odhInBIvGdptvtRnY5+irq91xS9QhbR4PDR2HL9hhRX5gUpPlWj7Pnx2seuzBWzRdM
         7el2NfKjVMSfCXnbsA/TmyRe0caiyIitNsExhwOxchaPRLp4FSv+v5GVqC6fx3Xlvu6E
         Er2WG4Sq/L5BS/COrT13Dt1Qw8ksKXrmQ5Gf+mIorzbDnuMx2ogm3OJLyNK/KcRrX0v7
         ZJ+evT2uwjB+xOvPPLgX8okEE8m1c3FD3OTbhWiSrj1X18BaqVLEKEY1LKBZX2CNKPom
         xWVQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr6J2uC1jOME5kJG/vUg+OY2x3giWzqR9/7lf3aW+lGyNYfti1cZraYD+Rn/rhQudOIeEM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2sWzkEjjj0/YbJ8QvsZWB1b7+0c4MwgHkg+RKBz5mNI+2mE3k
	58cNMcqGxslJ7xDQtd9qgcfuuiJBIwrMn3cv2DU/T9Eo/CyaiEUUNGljuV0SbX1nYeGMdJdVcXs
	i1ins1gEclDOorQmUK6pb24m/IthQNys=
X-Gm-Gg: AR+sD10E6IZys+VVRMD/TLL/F3jDeNcqXIKjqui79YbJnnGZoqbY/KnrwhZMPbnEA0+
	0ZQcKAT/xy3BBtTeEedYawmO9HpiQe28kGYwmL1swQJZfCqp5J2blB6MykF5u7RDkvjlDgteSd8
	MbpORsCRTcNTSOPCpPgxkP4Zz0tkpny9FMBBVcKJK09xfbvIzCx+5r8abqWS+YjbVphURl9YMtt
	fELhg1z1aR4XqzYpSo/z1Gr5NoP1UpycG3TFzkiL4pGZe6LRdb7VQnE8kTBEn0dKdADrcPMp1il
	ErnFwu0vD8EVTzKegYPRyZCmdfLnTuTRSt7QkGIC1cDWOj10lN0YVjeHjOAYRy9W8J8W6zzpvbg
	+Vw==
X-Received: by 2002:a05:6214:212c:b0:908:2369:df1c with SMTP id
 6a1803df08f44-90a91de32famr335630366d6.20.1787002033441; Mon, 17 Aug 2026
 14:27:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2205.git.1786799480344.gitgitgadget@gmail.com> <xmqqwlto4q9a.fsf@gitster.g>
In-Reply-To: <xmqqwlto4q9a.fsf@gitster.g>
From: Yoichi Nakayama <yoichi.nakayama@gmail.com>
Date: Tue, 18 Aug 2026 06:27:01 +0900
X-Gm-Features: AcwNN1U6WANw-M-dQ-7iNFh30kOaFczMd_2Zgm6c71ptb37XwT_a2CI4DAQNRCA
Message-ID: <CAF5D8-sLL+OAqrQG4ZWkxxNbsmtGPv_Y6GgEt6ULb3EqLHcNvA@mail.gmail.com>
Subject: Re: [PATCH] worktree repair: detect relative path in .git file correctly
To: Junio C Hamano <gitster@pobox.com>
Cc: Yoichi NAKAYAMA via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 2:21=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
> >
> > Since read_gitfile_gently() always returns an absolute path, the
> > conversion from a relative path to an absolute path was not
> > functioning and dead code existed.
>
> This is ugly.  What problem is this really fixing?  What "conversion
> from a relative path to an absolute path" does the above refer to?
> What "dead code"?  Where in what file and what function?  Why does
> the caller even care if it is absolute or relative?  Shouldn't they
> work equally well as long as they point at the right location?
>
> The proposed log message hides so many details to evaluate the claim
> that this is a good change, and raises many unanswered questions.

I'm sorry, the commit message lacked an explanation.
Let me explain the details of the issue I want to resolve.

When we create a worktree using default settings or with
`worktree.useRelativePaths=3Dfalse`,
the cross references between the worktree and the repository
(specifically `worktree/id/gitdir`
in the main repository and the `.git` file in the worktree) are
recorded using absolute paths.

% mkdir repo
% cd repo
repo % git init
Initialized empty Git repository in /private/tmp/repo/.git/
repo % git commit --allow-empty -m init
[master (root-commit) bb4f6a1] init
repo % git config worktree.useRelativePaths
repo % git worktree add ../foo --detach
Preparing worktree (detached HEAD bb4f6a1)
HEAD is now at bb4f6a1 init
repo % cat .git/worktrees/foo/gitdir
/private/tmp/foo/.git
repo % cat ../foo/.git
gitdir: /private/tmp/repo/.git/worktrees/foo

In this situation, if we change the setting to
`worktree.useRelativePaths=3Dtrue` and run
 `git worktree repair` within the main worktree, the cross references
are converted to
relative paths (this is an expected behavior).

repo % git config worktree.useRelativePaths true
repo % git worktree repair
repair: .git file absolute/relative path mismatch: /private/tmp/foo
repo % cat .git/worktrees/foo/gitdir
../../../../foo/.git
repo % cat ../foo/.git
gitdir: ../repo/.git/worktrees/foo

On the other hand, given a state where cross references are recorded
using relative paths,
one would expect (by symmetry) that changing
`worktree.useRelativePath` from `true` to `false`
and running `git worktree repair` would convert the cross references
to absolute paths. However,
no "absolute/relative path mismatch" is detected, and the cross
references remain as relative paths.
This is the problem I wanted to fix.

repo % cat .git/worktrees/foo/gitdir
../../../../foo/.git
repo % cat ../foo/.git
gitdir: ../repo/.git/worktrees/foo
repo % git config worktree.useRelativePaths false
repo % git worktree repair
repo % cat .git/worktrees/foo/gitdir
../../../../foo/.git
repo % cat ../foo/.git
gitdir: ../repo/.git/worktrees/foo

The issue has been present since the initial implementation:
717af916cd (worktree: link worktrees with relative paths, 2024-10-07)
Although `dotgit_contents` (retrieved via `read_gitfile_gently()`) is
always an absolute path,
the implementations of `repair_gitfile()` and
`repair_worktree_at_path()` treat it as if the
actual contents of the `.git` file had been returned.

I have confirmed that the above issue can be reproduced even in the
v2.48.0 tag, which was
the first release to include that change.

> Yes, read_gitfile_gently() always turns the gitfile it reads into an
> absolute form.  Is there a caller A that wants the underlying
> relative form, and if so why?  Is it to compare with some other path
> that is relative?  How did the code B obtained the other path to be
> compared that is relative?  If that code B used the helper that is
> different from read_gitfile_gently() to obtain the other path that
> is relative, perhaps the caller A can be changed to call it instead
> of calling read_gitfile_gently() and the fix can be done without
> churning so many existing call sites?
>
> Stepping back a bit, why does "repair" even care if it is relative?
> Is it considered a semi-error when a gitfile records its target as a
> relative path?  If so, I wonder if a cleaner way may be to add a new
> READ_GITFILE_ERR_RELATIVE_PATH constant that is treated as non-fatal
> error by the read_gitfile_error_die() function?  If that approach
> works, that may be the cleanest, as I suspect that "was it recorded
> as an absolute path?" will not stay to be the only special case in
> niche applications like "repair", but we need to audit callers of
> the _gently() function and make sure they do not barf with the new
> return code.
>
> If not, perhaps introduce a separate function that returns the path
> it read without any conversion, i.e.,
>
>     char *read_raw_gitfile(const char *path);
>
> that "repair" thing can use, and have it do the relateve-to-absolute
> converaion itself, perhaps?  That function would be created by moving
> most of the code from read_gitfile_gently() and read_gitfile_gently()
> would become a very thin wrapper around that function.  Wouldn't that
> be the least invasive and cleanest solution, if it works?

You're right; changing the signature of `read_gitfile_gently` for a niche u=
se
case like `worktree repair` isn't a good idea. I'll revise the
approach to introduce
something like the `read_raw_gitfile()` you suggested.

Thanks,
--=20
Yoichi NAKAYAMA
