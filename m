Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075203FDBFE
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 10:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927467; cv=pass; b=mV1a1f+MjkxU363fnvkaHmXRNbZXvEmLGwijcGOHUMAi3fBVBGlqPmPsC9Z7rIAP0nF3QqFedbJj2LsfDFD9zj3mjIg5yxveVVTO0ZS3xVPoY3cwXk0evQ9IltGVhIkjuNUDGYthigDr3pPBf4FBq1jtzQ5jlL3VKyHBsb3SD18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927467; c=relaxed/simple;
	bh=c0zKt2ACNrB5kLVSUpcadjom8r43D8KonU8EwiPCf/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FTMWeyIPx4nrx1h6lcR7hMx5STSPbD8dZTrC/k6CV44BV5K/qBI4zNzWplr3bDcEsLM5agjfVW2RuIMk7iIZmXzWFAWn1oA67jfRc65ZBmwFQLq+jCno8QAd6PKRGWFblqyjPC2U7vqBiHCthFT6n0mcC4/ANRS7CFdWcZ8JeN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByOQlJs4; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByOQlJs4"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-529a1ee0e62so4949211cf.2
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 03:57:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785927461; cv=none;
        d=google.com; s=arc-20260327;
        b=qWjDWeKT4Ncj7ttmMvprhEFMRYksCdiK/34MSJZ6Vl3DS0oLjdGrQG2nQBNSNMkHwr
         TU/DXpASS/U3Equ8zxyWfyuw4khhZdKqH3nLLSNXHEebaLUCcCsun0D6WBZx+19XKBsC
         y3ty16zJrmrpynVQfzpc5HIOJoqruMq8ML1OS152TM3cRLkj3DNl+5Raq0di3LjdNVOW
         mN7ijBj5skhRP8+hD/fnTJD3H/Kbde4nkz9h860gy6u8Tr/bF6oS+lKVn5A28TDurARc
         4HLN07AjXAX91WuiGOct3Wst/MmVzbSEV/BabFXaBO1bYpJt65Qog32dvdxo4tugUPoc
         wnmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1o30DVFYNCYXr0FepZD2HgTemNWIBIVcNbV+DFujM4w=;
        fh=OiwiDBuOhoc4LNcMS3PVt1Pit4GXz4r0C/oyZTDORUw=;
        b=F/4SSMU/smgGivwQtU2e77CfLxlV4FJl2y0tiA/iVO/SZKXqAAgNmNyTKMtEhFkYDN
         1nXBjetMwwyOxvTyYZAFz9eVZc3wUTA5+sUThjlHX6ZAXgB8I1UHAWvBizEVj6QngeSc
         XLH/RfLQo6FqYTV3XIM4JQFGHBqqmJAWTniLIv51OuTxA6yAa5XPi1WUKG0OI/9yTThf
         nfKGvT0haUsgoOze3dHppGCP0wOgkcH+jlTA/CnU3fgKvGkr8dKsRhisGjuiEKqPB8hG
         a+In6/Xps0WOPnqEzlPds/I9+nWvzU178sO5igOe1MJUhrAlpBqFezYGlDYAZEmd7iI+
         HuvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785927461; x=1786532261; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1o30DVFYNCYXr0FepZD2HgTemNWIBIVcNbV+DFujM4w=;
        b=ByOQlJs4Io+Ebh+rag/2MUn++74hsluojvv/WcdKFhum3GSgy6NNlRVQW/3NmhlhU3
         aXBp2lQ5Ag50Q7V7/J5sCmRKlI4lBfRmV4VrlrFqmcWdLhvTUZFg8yahgcKnAIFDC84p
         oiyAGSK8F+2vlu+uiQVtLQbjzbKxtOWjVKIjW9NY+QTurcJr2T18ooCzZvFOTNGoFCRl
         G33pY0dC3qR+0frQRYTUOMZRWia5ve5R5RmsDOZ+ESrNGDhiR3XzDiK53J37lDplFXyC
         QFDQM58FlWWD12Sgyb3Nuxqerbl6QzfQpNs5VQuE+0DhV92CZjpjNwLkiG9hHoHmS95/
         HPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785927461; x=1786532261;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1o30DVFYNCYXr0FepZD2HgTemNWIBIVcNbV+DFujM4w=;
        b=ZaPXtv4rPuQAmdSspEs3woeIZxVkdzQQFuO2KDyCBjqlisFryY86L5oHT2NHYD1vOB
         shZtU4PaY8LD6u1d0DUoyu1w1EhWhzoxoVoBo3bo7y0AvaXRZmCTMpJgBwpNu/6Kl1CG
         gu0Qw13wY7mRfzPNuZvNZSjY8uvGOeclK7T5AQ2a/HQZ0zv7l27AUU0rtaMUYa2czxvT
         WxJRpgShehNHUb2oGfTbpmKLKWfWWJyRqciVqXUadgiAgsRQgF7smhF/5uu1668vc76Y
         qjTaY3aP1v+5oSRr13WiCYCvtaiBXxAcQ/ZpLWFedOYKdSR83tKDfRIKSU41k7JzTDnj
         707g==
X-Forwarded-Encrypted: i=1; AHgh+RpPUghrZFNuceYvCJNsSvyq1CnS75ifahRTPLiFvUwVPFBqGzd3rcz43EDOJ60T4LtjWXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHLQlWAineAW6GxhBH0s4SHRY7cZQFruyKwAWoIwV5+YESwegx
	Mcsw2WsdzD2LKkM7aNx69hfPRtEsHxlYzashNTiPJEQsbPgnKnIOXqeNbAHcQ2Nygrek6R6UX6J
	X3a/h6hVPfG/QNtVtpXplH4hbvtWc36s=
X-Gm-Gg: AR+sD12kaQQR52KkHKKzE8C+hNfwoJ7kCL+Qpm1X1yXS8Q6JscbcEASkl6b9TYZ9hdm
	jZnz1o5CgHP0vxBqE2kZ7uHzRAOUeEy2TPJxekA5+3B/PvFNcTQSX+JV8S4ifz/qTzqv+b/gMel
	Ak2K4ELSIr19/xdKzXdSH44M59uYL8yWLW1QhKgvZSOm1u5gPuDVzHSYosTMkD4ePlAnYMkKbs5
	GOI9aWZX25DOjPSJBBOsPfy4D+CZyTgpKxaIPhc54DMZUK5KPsKtbJN9U0t0MhqjpDUJdPy+t8B
	IUEyHc7/oUgG5y0FLoqrO9s8F1yaY5wsJQDzlSSJ4CbaoZ0TV6rZgu67mINqjIH+CNLnL2y92aQ
	WYDawdOwCJQPspL0a00dYLUeXywIQHX6p
X-Received: by 2002:ac8:5cc8:0:b0:51c:6e:ef23 with SMTP id d75a77b69052e-52ce61b5defmr56937571cf.32.1785927461487;
 Wed, 05 Aug 2026 03:57:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2192.git.1785852032626.gitgitgadget@gmail.com> <xmqq33wtx138.fsf@gitster.g>
In-Reply-To: <xmqq33wtx138.fsf@gitster.g>
From: Yoichi Nakayama <yoichi.nakayama@gmail.com>
Date: Wed, 5 Aug 2026 19:57:29 +0900
X-Gm-Features: AUfX_myn6AJOKfAZUkdCN5biKjOi3ZuXnbt6SPCy5Ory_jReFCHv4BKt8vw5axs
Message-ID: <CAF5D8-sYhrSP8D_TUPLqDUWci=GK4DNzOxJaVr_kd5c776NKyA@mail.gmail.com>
Subject: Re: [PATCH] worktree add: shouldn't dwim if -b or -B is given
To: Junio C Hamano <gitster@pobox.com>
Cc: Yoichi NAKAYAMA via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Jacob Abel <jacobabel@nullpo.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 2:11=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
> Stepping back a bit, though, does this change the behavior when
> 'branch' *does* resolve to a commit (hence, the DWIM is already
> bypassed and 'new_branch' or 'branch' are not nuked)?  When 'ac' is
> equal to 2 and 'new_branch' is supplied, we used to call:
>
>         if (!strcmp(branch, "HEAD"))
>                 can_use_local_refs(&opts);
>
> inside the block you are now skipping.  It looks to me that this
> patch also changes behavior when the user says:
>
>         $ git worktree add -b <new-branch> <path> HEAD
>
> by not calling can_use_local_refs(), whose only effect in this
> context is that it may issue a warning() to the user.  I do not know
> offhand what the ramifications of this difference are.

It is better to emit warnings for the given arguments whenever possible,
so I think we should not skip the step mentioned above.
I'll modify the condition.

> > diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
> > index 87b926728a..9cbf84861d 100755
> > --- a/t/t2400-worktree-add.sh
> > +++ b/t/t2400-worktree-add.sh
> > @@ -621,6 +621,16 @@ test_expect_success '"add" <path> <branch> dwims' =
'
> >       )
> >  '
> >
> > +test_expect_success '"add" <path> <branch> does not dwim with -b' '
> > +     test_when_finished rm -rf repo_upstream repo_dwim foo &&
> > +     setup_remote_repo repo_upstream repo_dwim &&
> > +     git init repo_dwim &&
> > +     (
> > +             cd repo_dwim &&
> > +             test_must_fail git worktree add -b branch ../foo foo
> > +     )
> > +'
>
> Two comments.
>
>  * You call setup_remote_repo(), which takes two names, runs
>    'git init' on each of them, and prepares those repositories.  Do
>    you need to run 'git init repo_dwim' to initialize it again?
>    What for?

'git init' was unnecessary.  It was included because I copied
an existing test; I'll remove it.

>  * Expecting a failure to create a worktree may be fine, but can we
>    say how we expect the command to fail as well?  Perhaps you can
>    capture the error message while ensuring that the command fails,
>    and then check the error message to make sure it failed in the
>    expected way, or something like that.

Expected error is 'fatal: invalid reference: foo'. I'll add test_grep.

Thanks,
--=20
Yoichi NAKAYAMA
