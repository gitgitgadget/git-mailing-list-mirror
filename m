Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588483054EC
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 03:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773371609; cv=pass; b=jWKhpR2VoPSNOffj2QIPYxnSYocUeK7xPbLXXn67ZCIR6Gw23Pt/Q7mZZ9ZGLqS6IxpD/Q+uqzx4o1OPlZ/Rdneu9qd4ZGS6OQ15L06xft45cLat5C3ut66UIO+bHmd4hxqOtFFRIgHar7JZrzQc1qB9lZtYyY+xdDUXKFX4P28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773371609; c=relaxed/simple;
	bh=HjKsSaz+OSGtgfaVIvQ4TSJX2PUPJltnNxmocIdWuEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WVpSUc2ALDG1WVNmtky+Y3ehJhqOjihrOgPgcKC2PB4Ds/mYy9cCqIeY+/AX5JEHIiWp3CV9FAbLTGlGHyag1chi41SlJWUtEJqgPJdULMQ7bpWjEpmtLVmhDELZ2rK8AIys77+9+UqmKd89TQnlPTFCipoYLIc/STPihENac3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPpjNoFH; arc=pass smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPpjNoFH"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5fff13d5a19so2075744137.0
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 20:13:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773371607; cv=none;
        d=google.com; s=arc-20240605;
        b=HHUuwN+dedxEIsDXqYI2XX33NmlWYQTXVfAZQf825+Z04md77LZER/RySQSmyW3198
         ALgW8f9YEKYEKGsn5CYPvFA6wE1+xICOLeKBUM3+Lh10yfqUAepo/00st2d8nyAzzmok
         ouCfzD+uKANxBnTywNQWzgkd1l3VriEtLVaAmGilWyqm/NOKAM6VhD5Yh5g9fZUjhdZb
         dOfjBpueFhefiGLA2zQ9rGDfrV55nKFtFh37FQKYUNI4vOdixbfvbSnnuy9nS1HAQIHy
         OaCBT74GM55ltiNMp7Fq4vR6judXopbq4ccbNrw3Hv3tES0uzKOI/syl3ku+wddxfGmw
         EppA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3wyQs/H1aCRWDX1RU7c30OLMh8Haf3Fj/knb/q5csrg=;
        fh=uir88SuOPkx983BsGtP3TofSW+GQcmtlvNI/8fYfNU4=;
        b=FsidzhLTEVO8f/kJvXFuO1RgQkqC6/yvhvl9dB961v7i/ZKH10sMMYaYpdZej52iEp
         86I4BVMTcO8+M5sHJyKmJSRp9OlQmMLY3VtY5xNtNYuVxjIFYLXr6aVo9EPEsBpLCJpb
         D/LzcKS9Ov8a/FS7Yx2M+mjZpGk+hjrpfsORSJJ8JZ9CEmtLZ4gPirVA1Fp9qDdtB8QG
         U4oCpmraTaFOIXaAHfCY+0iwdLPhwLDVxrGaTYy+xnw5rUN/yWucdXD4MdORfpvqsTcy
         2+Zmf8mzwwsP+xoo+QmKV0wxxT4zs1ZPHMNtNFAyTyMUDNkUi3vIxcFA0thYpAlhtCwH
         rcww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773371607; x=1773976407; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3wyQs/H1aCRWDX1RU7c30OLMh8Haf3Fj/knb/q5csrg=;
        b=UPpjNoFHtIrPOYMwOW1t716mi/qysldZhJ+9MWVcCVOfB+RAoFjq9ipvaNLD6A5etu
         pNaw9s2kZD1+KYvSSZTTacmDYqLu2FQ+PA1MGPxff4SFRdPSWGnejBbOOOy5Dd6WOzoB
         a2W8C5eVxbyE/BhIVSKW2BdVkS4dnbJb0H/WDvzeCHW0O/3i0UR1Rds3dvCkcT4Ia8ra
         gqdEXzp4zwQ3AnxkIu4erU7T7HRW4mZk6u3o70qO6/giBSDP+5eYz0IZJY7vkL4zme7r
         TuENpzPcKIBbZuBlI5wnAPp5zvNRL1XwQHGqJeJfp/eNKKS5ifkSm36DDg+N6UDqH57o
         Nz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773371607; x=1773976407;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wyQs/H1aCRWDX1RU7c30OLMh8Haf3Fj/knb/q5csrg=;
        b=icOAXjlc7XjV21AuFplkiOO6tQTIa+nFKchBqLpqCeEj57lxC0bKUwgg+L9/KJt8dO
         142pYEp62wlfgmF90+gFsD1ZN0wxk7bDHLvufoqg46YpbH3iQsUmWq3eI5QcrCA9WJKq
         IlEzGEhsvzNc58W/9DQ/0UF9cmgfQN6xl6AHFD6ddkPKSrn6p/XrfSMk1kdg1L5ERUyU
         FDEPQEgiGXuPa73x8NuZkl585MuKLU4vSC8m1e7Nj3loo1ZIToggUQiN5Rm55UE8I/ap
         bMdf1XtbbXQxjttAtvhWVST0HjaBF2bBLe6Dm6fZTBzDou7788K8TOMrh4y+bOErGCiX
         gogg==
X-Forwarded-Encrypted: i=1; AJvYcCVh5LKbyGpRvj3GxtJZKrxcOdSSSXuftCPK96/kAb/42tWcSrmt4A7qa9XS7hAnPOywQLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqwP0qo/b18FYHy9u5t8bt/ZfrWaFv7dCQ2eYxeJNaC3TBrLSf
	ju3j0Z1zdB/MJgblep3TRbuWl+QQ+OdVjs63MCVHTmEBW8NDHVGAOqMCRhNrM/D1mJIwfoOaDkU
	hBJL9zladPwa78BLwnTJkV5jB8jmFrno=
X-Gm-Gg: ATEYQzyl3KyIIOgwfjIvhIctjXpcOe0pUSfDsW64DgN3krLqUkwnSAqxh8FlYy+ysOG
	4/PO2p6wbNNY7aai+ZWRHDaidIkgo86zM7woISlt8tZlKZIJa5xfO2L9CwdG+s5VNDrYc0NAhh/
	jy8TUgqJjFewClwBz68ZMFBizR10Ncs45UDmmiyGsN3Yl9caN7EJWs/wOcb2eZ95Jq6LkQ1sAt+
	BL7HuUsN/MRn3bD+QINCmEsNRdiMBKTqnK3Z2cpKuNLCBpPvGa9MBwhLIL0SV+sTpRT7hpwKf/Y
	JYBEnwwuMCoUGs30jwnBHT4oDXlzWaAd/JDcBMGjr6m2VDdGDSglAIvwuokzofBKoIwuNHz8onv
	NEYpSNpTtKGhVta4AakVS3/wxz7xHrJP3Vjaghi1Zezx1mq6aAtt9yrTFqNyXZ0VTiB8bVX2W3I
	xmFsRW
X-Received: by 2002:a05:6102:94c:b0:5dd:c53b:75cc with SMTP id
 ada2fe7eead31-6020d41c319mr954090137.13.1773371607282; Thu, 12 Mar 2026
 20:13:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2233.v6.git.git.1773288013936.gitgitgadget@gmail.com>
 <pull.2233.v7.git.git.1773345901659.gitgitgadget@gmail.com> <xmqqldfwacyw.fsf@gitster.g>
In-Reply-To: <xmqqldfwacyw.fsf@gitster.g>
From: Arsh Srivastava <arshsrivastava00@gmail.com>
Date: Fri, 13 Mar 2026 08:43:14 +0530
X-Gm-Features: AaiRm53aQ7AbpMvdqlXo0fwCxc7kZ1u0Olu6OJhHe1CoKmvyNlsu-o6OBiMIihM
Message-ID: <CAOAgETMCb++MnOC9YEN+y0TE9NeVC+-=Zez7UOVY3kt8vv7dRQ@mail.gmail.com>
Subject: Re: [PATCH v7] unpack-trees: suggest using 'git stash' when checkout fails
To: Junio C Hamano <gitster@pobox.com>
Cc: Arsh Srivastava via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes :

> The first paragraph is a bit of a run-on and has a misplaced "and";
> I cannot quite read and understand this overly long single sentence.
> Perhaps the early part can become a bit easier to read with
punctuations, and cutting the sentence into two, e.g.,

In my future commits I will remember to make it as easy to read as possible.
With less punctuations and shorter sentences which will in turn make it more
concise.

> Also it is misleading to say "previous" error message.  We talk
> about the current code in the present tense, to highlight what the
> problem in the current code is.

Understood I will in future not use previous because it is the
_current_ code.

> You may view it as a weakness (which
> may motivate this patch to be written).  But I personally am not so
> sure that adding words to the existing message would necessarily
> make it more clear.

I understand, git wants people to not explore the available
change options and help them make logical decisions rather
than pushing them with some unneeded commands.

> As Documentation/SubmittingPatches says, let's instruct the code to
> "be like so" in imperative mood.  E.g., "Enhance the error
> message..." instead of "This patch enhances...".

Understood that makes sense because nevertheless
it is given that I am writing the changes for this patch only.

> These were already overly long, but the updated one is way too long
> to be read on end-user's terminal.  The source lines are overly
> long, too.

That makes total sense.

> to those users who decline the advice, we now show "Please
> commit...".  That is not what !advice_enabled() should trigger, is
> it?

Thank you so much for your guidance the advice should not
trigger to those who have opted not to see.
My code might have misjudged this paradigm.

> Also "To move you" -> "To move your".

I thought I had fixed this typo. Seems like I didn't.
I will remember to be more cautious next time.

> Also the advice lost the other possiblity of first committing the
> work in progress on the original branch before switching, yet the
> new advice message is quite wordy.

Absolutely correct this commit does narrow the users vision
for exploring.

> Also, using "for safe merge" when the user is performing a
> "checkout" might be slightly confusing, even if 'stash pop' involves
> a merge under the hood.

I don't want to sound like a programmed robot but I absolutely
agree with the recommendations.

> But as I already said, I think the current text may already strike
> the right balance between being clear and being concise.

Thank you so much for your valuable guidance.
If it's possible I want some guidance over the questions written below,
As it is well stated by you that the current
text is clear enough.
Should I still work on this PR from a purely GSoC
perspective. Or should I start making my proposal or
still work on this PR until my micro project is merged?
Because I have already shown I can navigate git project which
was the goal of micro projects in the first place.

On Fri, 13 Mar 2026 at 04:10, Junio C Hamano <gitster@pobox.com> wrote:
>
> "Arsh Srivastava via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > When a branch switch fails due to local changes and
> > new users who are not familiar with the error message often
> > get confused about how to move ahead and resolve the issue as
> > the previous error message only suggests to commit or stash the changes
> > but doesn't explain how to do that or what the next steps are.
>
> The first paragraph is a bit of a run-on and has a misplaced "and";
> I cannot quite read and understand this overly long single sentence.
>
> Perhaps the early part can become a bit easier to read with
> punctuations, and cutting the sentence into two, e.g.,
>
>   When a branch switch fails due to local changes, new users who
>   are unfamiliar with the error message often get confused about how
>   to move ahead and resolve the issue.
>
> Also it is misleading to say "previous" error message.  We talk
> about the current code in the present tense, to highlight what the
> problem in the current code is.  The _current_ message stops at
> hinting the commands to be used without giving wordy instructions
> that are best left to manuals.  You may view it as a weakness (which
> may motivate this patch to be written).  But I personally am not so
> sure that adding words to the existing message would necessarily
> make it more clear.
>
> > This patch enhances the error message with more specific
> > instructions in a concise manner to help users understand
> > how to resolve the issue and move their local changes
> > safely to the other branch using stash.
>
> As Documentation/SubmittingPatches says, let's instruct the code to
> "be like so" in imperative mood.  E.g., "Enhance the error
> message..." instead of "This patch enhances...".
>
> By the way, the updated message seems much less concise than the
> original.
>
> >       msg = advice_enabled(ADVICE_COMMIT_BEFORE_MERGE)
> >             ? _("Your local changes to the following files would be overwritten by checkout:\n%%s"
> > -               "Please commit your changes or stash them before you switch branches.")
> > -           : _("Your local changes to the following files would be overwritten by checkout:\n%%s");
> > +               "To move you local changes safely to the other branch,\n"
> > +               "Please try 'git stash' followed by 'git checkout <branch>' followed by 'git stash pop' for safe merge."
> > +               )
> > +           : _("Your local changes to the following files would be overwritten by checkout:\n%%s"
> > +               "Please commit your changes or stash them before you switch branches.");
>
> These were already overly long, but the updated one is way too long
> to be read on end-user's terminal.  The source lines are overly
> long, too.
>
> The original was this:
>
>         msg = advice_enabled(ADVICE_COMMIT_BEFORE_MERGE)
>               ? _("Your local changes to the following files would be overwritten by checkout:\n%%s"
>                   "Please commit your changes or stash them before you switch branches.")
>               : _("Your local changes to the following files would be overwritten by checkout:\n%%s");
>
> Note that when advice is *NOT* enabled, we only gave
>
> _("Your local changes to the following files would be overwritten by checkout:\n%%s");
>
> without any "advise" in the output.  That is what !advice_enabled() means.
>
> The updated code does this:
>
>         msg = advice_enabled(ADVICE_COMMIT_BEFORE_MERGE)
>               ? _("Your local changes to the following files would be overwritten by checkout:\n%%s"
>                   "To move you local changes safely to the other branch,\n"
>                   "Please try 'git stash' followed by 'git checkout <branch>' followed by 'git stash pop' for safe merge."
>                   )
>               : _("Your local changes to the following files would be overwritten by checkout:\n%%s"
>                   "Please commit your changes or stash them before you switch branches.");
>
> to those users who decline the advice, we now show "Please
> commit...".  That is not what !advice_enabled() should trigger, is
> it?
>
> Also "To move you" -> "To move your".
>
> Also the advice lost the other possiblity of first committing the
> work in progress on the original branch before switching, yet the
> new advice message is quite wordy.
>
> Also, using "for safe merge" when the user is performing a
> "checkout" might be slightly confusing, even if 'stash pop' involves
> a merge under the hood.
>
> A more concise version might say:
>
>   Try 'git stash && git checkout <branch> && git stash pop' to carry
>   your changes to the new branch, or commit your work before switching.
>
> But as I already said, I think the current text may already strike
> the right balance between being clear and being concise.
>
> Thanks.
>
