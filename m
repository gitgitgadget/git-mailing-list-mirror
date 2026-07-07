Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8343C3DC4DE
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 16:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783440625; cv=pass; b=ZfO3O3f6PNL9aowPCqSo+z2IIoS1Npa7vTRdgBNn1rguf/Iu2B74gOcaYgnzMZ61p3bd6E5GSYEYzuIexQpnKTqw0zVmNeZIhTXxvUwbH/QhUDAKIZOeRz7SHGgJ+dE//yfo17ulVVJ2ty0ScMaFPUwhPCagkeOSRgCChPusDKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783440625; c=relaxed/simple;
	bh=WNXuT0C1CHJBEUrXi1fSoFKCLN9Iq80cwr4xBOhdNcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hn6762bFlR04yVCbM/ian4TRGjIhUdRREAjed6Ua/yP33uyJaTL+abHA9nOkLyPGpwKSAfoKAGuuRhQLpQ3eeymta3U8XL2m2D7aAMAigdvemZUxPFLs5erSLON+kPYOU+AD7Qb3hnZR3Co28ta/MBejSY6xguPxgWTl3gt/kQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZXekY17; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZXekY17"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8478fe07f0fso4994465b3a.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 09:10:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783440624; cv=none;
        d=google.com; s=arc-20260327;
        b=fAOntLj/eaSZ81esJQ7PToEvxn4C3+WFNeBCrSQ87L7vIjP6X+CL1LbftPVE4ZBRHr
         sM9v9d2qgfrzHpPiFV2qqFBzxIWlWLm/5HDb4Fpy7R2q7r8bJUvjd80BEFmMwAy2CMPS
         a/8vuOntyAjAyk2LdsBOF/nJhGLThsazUOif9GE7K8JROcWIIbwbld6xXY0+epblB0L5
         iAPtM5f/2+jmefYydwfF2n8zf1XihbqqxS2qyyMdMB+bOt3QFnoh2AwOUEqq5yoxABI4
         Qi/3P4nPzyMUJ4TQh7w7LqI2+nCBpONXPeqWMwnUOf4cIRcorB70U95HFqUY6SRsASKu
         gKeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8edAF1PW24/fCMh9lAeXON7m3iqsD7W2QxmyWTdQFus=;
        fh=c2bBvNzak7TLhxcVst/QJj59vLHl/o9vKgKkCLWatQ4=;
        b=SRMVxTQyZy0XDQZwhsX6UG4XnBT1NL4VhAEkyklPGXcoTyb+KzuLHS5s1hp9JDn/hT
         NW+1INkzFxB7syR2w/hJRnLn5H2Oz6E1xayTiXssBHjdBSZy53D9jIrrfLMHdaPZ9vsR
         6nqH2/S7L17hNvlFci9NPTtgW8L2fQghRD7Oa21yfz95EN4xBxF7j4nLmbFQnA3HV9lZ
         42hDW11CiY+dxlTU1YL67OIRHaLY7Grn5IvBt0XPHTBzvRiJhdWiaYrPz/uw8mofSo31
         +5+sXxzQX4vsVkPufxmBAZLJ3nTa8dfPsN8460Pa2Bm3Ky/YClfXTa74kSHUNtSXydl3
         dMnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783440624; x=1784045424; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8edAF1PW24/fCMh9lAeXON7m3iqsD7W2QxmyWTdQFus=;
        b=mZXekY17j1TA/y9mDWWcI7y2Lopu9i0/pFgBv/tY4yYSNAiVfNCiJY7Ed2BAgvc8t5
         0KPcYSKfW7OWotjYVxT9zPimimeeMneNEBQGSl2bbc2XGY90cJRmZGYVrLmhFmYAz8Kg
         vubOwfBl7/q6mHhj/GH+JovVeXS2FU2cGLJcsONLwOe25lw3t6yGGR0CWjvccVgEYuy7
         RBLCmlbYKzr70cR7JJZgWK26tEeu+tlM4HPF8P9/iyMzU7HVy1g7KHI0d4b7PNMPUk3E
         Sc/GyO2Zsnn0++CvXgPhOKwJ7bazpC7BqtJuk7NjkzLphkuV4hiUeDfGWFB1xvr+lxZ/
         zaGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783440624; x=1784045424;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8edAF1PW24/fCMh9lAeXON7m3iqsD7W2QxmyWTdQFus=;
        b=ELRnPFG0LCSZAIGefGkPS4ozKiZ070nu2zDatL9O8gsFLAKe36rJs5dpFPU+PL+sHw
         zQaEdR+cuC8vZgHmFcDOAY+irKoBmb3xqG+3c5i3mE37kAR9/A4Ze/TXS/b25EBLOFeF
         hL8xn9Hip1Xoq0ahO1DTerezYMEY4dH0gnKN9cj6Jz8Vhn5PXgXCfq90u1eww6mIKGUL
         0PVw5Eji/rWMgjPdVyn8rdkMnLtWvQIfUg/cNbHnEnxUZUs877slvcefZcA14XAxewmW
         MgZpyRHpTAH98MhC5AXvaqQ+Z31xyoK7ONRDkfQENf1a9XmQk13zJxiO7kBVTRlIdWYf
         VyAw==
X-Forwarded-Encrypted: i=1; AHgh+RqPAMwx2lAadOlH2lW3h/ikEJUCe40gRPolSdAkhOsNqxfNGSVLakluof9Bv0nVpjHCrgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFUr0mR2NUQ3m/eNxQsfyk03nL/PTvWfwG3/vcUz27Gy2s6ab/
	92ZpDngHSCZRNtuteNuiMLSI6l1J2e+t99ZEK1LUimHv11fr1gH+0pDmDJdE4mtTO2M1jPTPnvv
	b/YG3W2R6AQpMTK4RmOm11bSZZpGTMfY=
X-Gm-Gg: AfdE7cnPV8cyMwVeyyBq+PBq+kj0S++GnKI1ytbOB5ei5yVpKFVCPqdVIOjpetLfu8R
	2NLdLKyh/uG2uTnapgd2hjuHruVPTX/1nuB+6iw5eZOgNUqV8qN+nH1GdqYRyZvNMjFEeDswMM/
	L91zqN4RFYOOikJGpqV+0LBr8relNP8ID5idoAzSRID82nth9FFS4iJmHFgMAkBAFKdsh5vKMng
	zEqQe8Is32ib21pM3rvk0DhqOiWZYMM918x33H66tO9XUf9I3xdxp2cj9U9StAyH4JBVgsc1cUd
	6tDio0XJ5D+ez2Ju5MpA/CS5T16LQIDEafvuSaDdsFBBvt5cdpv1VUyE+BKu3H/2rmI7C1/5YUr
	61lbF/eiaNk+oWVvN7a8BvyfgHDz4ufjwSW6Piz1/ThpPhF8=
X-Received: by 2002:a05:6a00:3d08:b0:841:58b0:82bb with SMTP id
 d2e1a72fcca58-84826b8d0f7mr5281913b3a.9.1783440623611; Tue, 07 Jul 2026
 09:10:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN5EUNQNj86Q+hi6PouOZNWo1T4QTQ6sE5Hs9USZXWpkTedTcw@mail.gmail.com>
 <9C91B027-C24A-4D7B-A3BC-5CF3B04D990C@gmail.com> <akyKDtuHTHZGEpFx@codewreck.org>
In-Reply-To: <akyKDtuHTHZGEpFx@codewreck.org>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 7 Jul 2026 12:10:12 -0400
X-Gm-Features: AVVi8CcLcByyK8Fe5229WDCR4XwjpXHji_pDmpWnmTO6iQs-uAOUQsacA9Pa-Ks
Message-ID: <CALnO6CAjZfK3hPWn1vOxgw=4=cjRYEHabYJmJrpVVDU8yyQn_g@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] builtin/history: print feedback after successful reword
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 1:09=E2=80=AFAM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> [context: I just played with git history reword/fixup and dug through
> archives for anything like this, so chiming in.
> First, thanks for the new git history commands, they all look promising!]
>
> Ben Knoble wrote on Mon, Jun 08, 2026 at 12:47:41PM -0400:
[snip]
> >> They do not, they are thought with the rule of silence in mind.
> >> However I think that this output is valuable information I might have
> >> explained myself better at [1] but my thought is:
> >>
> >> git history reword aabb
> >>
> >> Now that I have my commit aabb rewritten I want to check it again just
> >> to make sure I did what I wanted correctly,
> >
> > Some thoughts:
> >
> > - If the rewritten commit is an ancestor of HEAD, look at the log of HE=
AD@{1} or the log between HEAD and the aforementioned reflog entry. (git-ra=
nge-diff may also be helpful there.)
> > - Similarly, if the rewritten commit is reachable from some ref R, chec=
k R@{1} etc.
>
> During my quick tests I was surprised with how git history reword/fixup
> behave with commits that aren't ancestors of HEAD/any branch (that can
> happen for example if you print `git log --oneline` once and refer to it
> after editing.

Indeed, this is a bit of a "trap":

> This transcript is a bit ugly but should illustrate the issue:
> ```
> $ git init
> Initialized empty Git repository in ...test/.git/
> $ echo a > aa
> $ git add aa
> $ git commit -m init
> [master (root-commit) 62884dc4d43c] init
>  1 file changed, 1 insertion(+)
>  create mode 100644 aa
> $ echo b > b
> $ git add b
> $ git commit -m b
> [master 058294f87a36] b
>  1 file changed, 1 insertion(+)
>  create mode 100644 b
> $ echo c > c
> $ git add c
> $ git commit -m c
> [master 0c4ad0c9337c] c
>  1 file changed, 1 insertion(+)
>  create mode 100644 c
> $ git log --oneline --graph
> * 0c4ad0c9337c (HEAD -> master) c
> * 058294f87a36 b
> * 62884dc4d43c init
> $ echo d > d
> $ git add d
> $ git history fixup HEAD^
> $ echo e > e
> $ git add e
> $ git history fixup 058294f87a36
> $ git status
> On branch master
> Changes to be committed:
>   (use "git restore --staged <file>..." to unstage)
>         new file:   e
> $ git history reword 058294f87a36
> (editor showed up, commit message modified and saved)
> $ git log --oneline --graph
> * 5cc5551381a3 (HEAD -> master) c
> * 0b7ab36bf167 b
> * 62884dc4d43c init
> ```
> -> fixup didn't show any message (and exited with 0), but didn't unstage
> the hunk either and didn't do anything, so one cannot differentiate with
> the fixup actually happening
> -> reword showed up editor but didn't actually do anything visible
> (probably did create a new commit somewhere that's unreachable?)

I think what probably happened here (and what you might find with `git
fsck` for example) is that you have new commit objects in chains
corresponding to those operations, but no refs were rewritten.

> So I agree with Pablo's suggestion: printing old/new short hash on
> success would help visualy confirming something worked.

I think we have the machinery for this (see --update-refs=3Dprint for
git-replay, for example), but I'm surprised to learn that we don't
accept --update-refs=3Dprint for history.

In any case, I second the "we should emit something"=E2=80=94I wonder what,=
 though.

- In the case of rewritten refs, we might like to emit the list of
rewrites, a bit like a fetch or push will do: "+ $old...$new $ref
(forced update)" or something
- For new objects that aren't pointed to=E2=80=A6 maybe silence is a better
indicator that "we didn't do what you intended"? Or we could just
print the new commit objects "$new [unreferenced object]" or something

> ... But it might be worth to ensure that the commit has any ref we can
> handle (if --update-refs is set then the commit we edit is ancestor to
> some branch, if not set then it must be an ancestor of HEAD)
>
> What do you think?

I don't think it's worth restricting the operation (I can imagine a
use case where someone creates an unpointed-to object and later makes
the ref, even if that's a bit weird), but

- we could have a "strict" mode that ensured inputs are pointed to
- we could warn when only unreferenced objects are rewritten

? I see git-history as very "porcelain"/user-focused, so I think it's
feasible to add output niceties (and optionally a quiet mode to
suppress the messages).

--=20
D. Ben Knoble
