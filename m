Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF19140D594
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 12:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791290217; cv=pass; b=OePsGOdX59dIlvz086eHmkSuRTzyI5INcjzAu7byvey7L4eO502McvMNacPoxUWUfo0gzYS90S3/xefB6oVRXZZUcbG4A5dzKNpF9SqbenDsV/grcpLUY7Xk0yilgh0oZQV5v1Z1exSy0MuXHOYu9uBog+4I/8rUa3jkqsN5pEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791290217; c=relaxed/simple;
	bh=KE4PCX1EVUcelZoHgTETd1QGAbSGk6TS6wvPjNLRjm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rkPCHz4binsZVODxVH9qYx4CTTWR9byKyMDyuZqkhzv4ONuuE9jD7ixKqt4WRSwEk+O5ikdlXTxTe1EXxHFn7AHnkGSVfrBttdZtQGyrO/+8wcgBLRHJKWP3itnLz6nCfCMh5NQPdNAzs4OLbwnAv7UQ8KiOjNALXkLB2q+8jBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=L/aX4ccZ; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="L/aX4ccZ"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8b056d58f2aso464637b3.2
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 05:36:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791290200; cv=none;
        d=google.com; s=arc-20260327;
        b=OKL2Rc19f0+nnKS/qUo8VB83pkOYf/2aamLKEkLgrCMHQdaw/NJDVydRC+haTILyyx
         ehb7NtPlbcrVgR3HO2JAtyfacxu8o2RsvyQd/ODJVyZC/JE3pBfeylNPyk8ZA+0V/dW4
         Lug5um3j6feOvNYBVcir/3o4xElc0DGRHi/YzX0z7pKHwvYVJYibTggWQ/E+5xZ9PMXB
         jYsZDJw8Wczid6jadL45Url/iukOIw8T4YUSacRSh1pa8vJUnwYhwkHVKoTkV0OuZohH
         Ay5mtE1ZjcvTJoaPkpAcLZhu0W5e9wrDdB9fwoo+ZAoB7F4PbmtokyKWWDMnct7zjseA
         dZrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qUgS+3cbU+A/9ALhhAJODyOr0Xf8ZZEvF4xBGAIrHPs=;
        fh=OJApakPN8vYE4NXkSranaX+DQuTMbsHo+nN46QoenqU=;
        b=HWuaNI0zaCkdNoPwyTmk9Muc5vyZLExuLMDBdHuBvaWSQ/u8dnSEq0+AL6go6qAsBy
         /Z5xSx5RaklOcNWSgrX1++jUMiHGymr6JapURsNzKdPcMN5yFRjgYGLkbHYJpatv6RqD
         VIcn0/MgVMsb9BNr6e+pvU0QiaeQp/btLcenvHTcowHZiv2KRrxuJthxbu1nme2gY+Ha
         E8N4RgNi0PdRCK254GVY9w2jU3GQRA6QWXivEvr7VAhlKfZY7ZaY4weBtbKY329NrQt9
         sSD1pXP/RFmfY6qpa5D32VYUQykGjuUzt3R2dIwpSBFQHooqNE0V86ps8hL1TUN8P0Oa
         5oHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1791290200; x=1791895000; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qUgS+3cbU+A/9ALhhAJODyOr0Xf8ZZEvF4xBGAIrHPs=;
        b=L/aX4ccZm2L0b2RUprsJ4bHn5P9LDntlgeVwiRNvz1OYsGvDLmqNaGA43zUyhIlGf7
         2WL0qdVvWPyeD8vQi3ZSKmuxqbyy4/POq2EgL4Jda9LN4Ql/yQ/UjNi7+QeKx2/ma1zW
         GHQDS9geN9S2ZOIDhB09uVtfZrKxSYJVdhDv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791290200; x=1791895000;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qUgS+3cbU+A/9ALhhAJODyOr0Xf8ZZEvF4xBGAIrHPs=;
        b=wEQDL16lpxDI2lh2wctXjkYbbiRBb6hBbOMOsGODyNIV5ouJcEYfo7wrImvG8SuQr7
         jyCZjdWQzmDW0SZk5vJv0ItiRwxAy0QeqJ5INu+Ry54UPuxKcJe4HSfjnr95S9Ovby88
         Jbmpc6ejISCwSf4vTaRWngTCsvD8ZtUpB8BPNppn9I+ISgvu4FsaqaJUmXib2OSqK+oH
         S764iM8FiuOPR8KSZtvLJm9WBUx/4UwHkNmP0FGu/iC8PRY9HkN6HDlGsXniiwRe1fyv
         0hUEQ/wwPMhaNkfVRGiniMU/o3VSRCjqgL1mAr49mI8coVl5sVwzPy/xKsgQsMxh03HI
         W2ag==
X-Forwarded-Encrypted: i=1; AKwUvBzPQF8QkqczBXNdCL+1g/S6y3YYtIjJEG3osDnI3+bvg/X/8ltF10nVvu2VGJ2CJnkP9hY=@vger.kernel.org
X-Gm-Message-State: AFq9FYK0BZ4PuWg1OYtWDuX3sIwwT81OpODmNe/09mE/FIaoxofR8lxe
	n23wmXh9/L5zlmro6HeLvFWgMmAJ/rXyEjY+RmPUMjeM4h/bl7t5FTkqzK3F5ypui+uoYF42rvj
	OPtG0SaNXIwTv452GI57ywewcafsgWLdaPgFbk0hnbw==
X-Gm-Gg: AYBFou0jeHY6IspPxi0UcN94Vuinf1oSd3JXd0b3e4jylHjmRh1r3644XcBWfpnxp3U
	JNj5UY5vACbXPBJLNHah5HkP6w7SwzBLILdMZr+Qw2f6wYJCA3V7QAWJKKY1XOSVNoAxn/mnZF3
	jFdkJGhgeHut9y6ddrIJ+R6TTIiz5Iz+zElW8V7Ps8TkyTxEOeIr2G1TYeFvXluuScggia92VZI
	pQGfz7bNSPC6fmYa16rwWdKscp4Y1FB+09OraPe2r5qJfVARf9/R+zzaLKyue4+27EE5FMNyMhN
	xW2bWFjCSZRM4OdV9pDnlsRV2QSxXVdf8ku71UYgh4FDjTDtRIoC1l0=
X-Received: by 2002:a05:690c:16:b0:8ae:9448:14cf with SMTP id
 00721157ae682-8b04f492294mr3999977b3.88.1791290199907; Tue, 06 Oct 2026
 05:36:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
 <pull.2211.v2.git.1790600552.gitgitgadget@gmail.com> <6ad528f4bb42a960910eb4fe917a3766fa55d598.1790600552.git.gitgitgadget@gmail.com>
 <asNZD7AOC6QL9q1d@pks.im> <CAL71e4PFpMPoSxFdnscRFiMB3ozudr64TjeQc8VKcO_M_MfJ=w@mail.gmail.com>
 <asTkyiIZvX1ztMrH@pks.im>
In-Reply-To: <asTkyiIZvX1ztMrH@pks.im>
From: Kristofer Karlsson <krka@spotify.com>
Date: Tue, 6 Oct 2026 14:36:27 +0200
X-Gm-Features: AclHuK_3aM0aC5xK3f88ajwIblnKfw-7UZLgkq5qutX1mIQg_oLQH_N0JvALDdQ
Message-ID: <CAL71e4OCuwT=Wj8eMF0DJ3UXFocb24yssLf4buyFDGEnTR6mgw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] connected: add incremental connectivity check via rev-list
To: Patrick Steinhardt <ps@pks.im>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Oct 2026 at 14:08, Patrick Steinhardt <ps@pks.im> wrote:
> > Parent is always defined relative to the commit we are
> > currently verifying.  For example, a push may come with
> > 3 commits (let's call the tip T), and then we do the
> > following comparisons:
> >
> >     T   vs T^1, T^2
> >     T~1 vs T~1^1, T~1^2
> >     T~2 vs T~2^1, T~2^2
> >
> > T~2^1 and T~2^2 must already exist and be reachable and
> > so we can trust them to be connected.  And since this is
> > relying on memoizing already seen results, it's important
> > to run the checks bottom-up (reverse topological order).
>
> This is the part that still eludes me though. How do we know that T~2^1
> and T~2^2 must already exist and be reachable?

Since T~2 is the bottom of the incoming commits, its parent
commits must be part of the boundary -- by definition, since
otherwise they would instead by included by rev-list --not --all.

Here is a concrete example with a push of 3 commits, where N1
is a merge commit and we have two pre-existing refs R1 and R2
(T, T~1, T~2 maps to N3, N2 and N1 respectively here):

    B1---R1
     \
      N1---N2---N3
     /
    B2---R2

    --not --all produces: {N1, N2, N3}

    B1 and B2 are boundary (reachable from existing refs R1 and R2)

    Verification (bottom-up):
    N1: compare N1.tree vs B1.tree and B2.tree
        (B1, B2 are boundary -- not in incoming set,
         so connected by definition)
    N2: compare N2.tree vs N1.tree
        (N1 just verified, trusted inductively)
    N3:  compare N3.tree vs N2.tree
        (N2 just verified, trusted inductively)

We never walk B1 or B2's full trees to mark objects
uninteresting.  We only read their root trees as comparison
bases when they are direct parents of an incoming commit.
That is where the savings come from.

So to directly answer your question: we know T~2's parents
(B1 and B2 in this example) are connected because --not --all
told us so -- they were not produced by the commit walk, which
means they are reachable from existing refs.  This is the same
trust boundary the full check uses.  The only new idea is the
inductive step: once we verify a commit just above the boundary,
it itself becomes trusted and extends the boundary upward.

>
> I think I was coming in with a false expectation that we're somehow
> getting rid of marking preexistingrefs as uninteresting, and that is
> where my confusion comes from. Because ultimately, that does not seem to
> be the case -- we still mark reference tips as uninteresting, as far as
> I can see. And then we can of course easily determine whether a specific
> commit is preexisting because we marked the boundary as uninteresting.

Yes, precisely.

> I was probably primed by my own earlier patch series in this context
> that focussed on refs, and that may be the reason why I had skewed
> expectations.

Yes, I've noted a few other workstreams that are sort of
touching similar areas, though not directly the connectivity
check, so it's a lot of context to juggle at the same time
(and I will need to take that into account for the next steps).

Thanks,
Kristofer
