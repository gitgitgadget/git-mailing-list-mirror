Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72E72F6910
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 10:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773399003; cv=pass; b=EkjywDZS22K+uQiKiUaoXv17fgfaKPWHvNSD/1frtCOVLEiyJVsCNRg4pWUQ0iGLvkNqNCbx0Iuu4zRTiehNZK/LT8SOx2nyJ+L/B1Vpwpal9pP/IhTpDfhEWVQ9C80uXs73TvZYerbMCoTQS/ptStCRP2JZ1mvhHJv20qqteng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773399003; c=relaxed/simple;
	bh=9p/XXL2whtuiL9l1YTgfQyMCD+dn8wL6KLdOV4eerGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r7wTcbaFeEthDT8LL4GCNHNymhBlMiPVChb8vXZA+ARrrUCHS4kNa3NmhJLhQusglKPAtlR06mZv3SAtF6+led2a+5ourM2SETuRhrNlOTNJVwDPAmw4b+IB9SNZrKKcAqxdLsX6yE9yR8FxK0idUEQeyBz2Sewljf+OT+UZm+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbcZeSpY; arc=pass smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbcZeSpY"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-56b49b943c1so883767e0c.2
        for <git@vger.kernel.org>; Fri, 13 Mar 2026 03:50:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773399001; cv=none;
        d=google.com; s=arc-20240605;
        b=GiIRQMWa/3zvwK2Ka+28fPRSrhxWDw27fgKjh5xogeT2BK7ko4ZbnDGlL9Apb5RXzf
         1CnZM/P4jUSnX9qbLH50QgHNA4rQMzrvgsri6udJ6A9OPt7341zOUt0TOAHe7qgxLqFq
         1T7lzRXTuSOfPLOMfvXMXxT+6motULxfRa1V3Zgo3hYvFRd3N4Gvm2pfsoUTMol94og5
         bmMc+x7ymedfkiwGmv6Ji8ey5btVYnzz2WHlCQ+zEdyR512RyzmLa+QGiJl7LRRXdtX/
         ZSVez846ZnLiNN3XThuEF01Elf52tYwOJfzZ5MMkzusAXQuscKMs/TVr5DksiC9RMKWj
         R3eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vZZ9jIBhbwAxKuLjXx/i04d3dvJb1F9jigUvFCumsp8=;
        fh=gzyP+ULzKazWAib4OQDNmJpFqUygw1QUbVlywCX5CH4=;
        b=GgzJlbbAnw5urcB2V26lf+Z+N4POwXsJbXVRqgOo8zDJdL59BX3x4c/L1+38z4BdsB
         gWxIFTUVhJHXFW5zPK28SFJCaCIPxHNBPwL1v1wzJmYU1mrbbKEVYdIv4y/rhgdj12PL
         pbKdBS/V/BGmkxqlqkzrSjTg57tpMHqkfCV/BB7IXXSnukmx6kKeSP6OJVwISJXBQJxM
         NfsYC2eDNPz70B7mjTbTo7jkblviIONtzpOdtpvrx8GGz+hGaEB94t+3VcwvcTeQ5qSp
         B74nhDkxazS738/v16Ok8ry3nELp6HDEY3jOPzbYTZI95b1nMEGhaLjBdy/HTBAIAGvX
         TQoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773399001; x=1774003801; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vZZ9jIBhbwAxKuLjXx/i04d3dvJb1F9jigUvFCumsp8=;
        b=cbcZeSpYvhFQzSjIOKmPPG6uUlLzIrv7Vt41HlsVLb8lnFEhaLvMFtz59fqbOR1FZX
         ZiwFT1temoZqt9INulRF186b8p4V8F7T2CXumHIen2j7U++mD14uOweA0KmC07DMhcgB
         +GTQMIjTldhoQnpK9zgcWYqhmV16DpQDUuuubGQZMYN3/JQcHd6UikgTEde93JgUq23Q
         dW91LyVNq+xhfwS2uZTNZ86rFh1AIG+IEJGxQvBKE6ugEhEQzNCu8Z0o3C9crDdRHqpa
         a+wiGRXdamUS5P2Wq5Q+SzuwOExQY/8hXhjxJyDrGo2lLQRMIbq1u+IIo8TnlpVWyGtH
         aLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773399001; x=1774003801;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZZ9jIBhbwAxKuLjXx/i04d3dvJb1F9jigUvFCumsp8=;
        b=gJyVc4XiMvBQpeP5YUvw2Mv3WU4NVss8AXzgpExC425KgBpFGSy68F5NxkGU4DpCqJ
         6+ofZOfFUJZZVcZwAOmz2v33Rv11GNnMa0rFtL4eMnJmgr8JnwKkaUYHRehP+gWNgiVr
         Lfv9u5Slb5bImAncrdj4Sq3WKhvG6duLflW7pcL9rTB1/dnh3PQYOkZ1qYLHmjS+Htqi
         WjuyPyMmq3D6PZwiTyC/zr6L7bTmPSKpekss6CNc2/Xin52oevMktkNg7UlFQDHv4JUK
         E/KOlBG+7bInLgo/Ce7aUM6nX18gTPYDUk4CPLi9gtkrsUaP5P5M+rQ1Df4qa8xwHaGk
         0RpA==
X-Forwarded-Encrypted: i=1; AJvYcCX31Mab+M2hDG8HG4JG0Vw6bpoQ9z7mxQ2MmFv5alxIt1/e75JMIe8tEW7X90rpbFZ7zXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK5RCdKJ+RXhyaj5LaXx8vlgwv1jkYK5Ow032+UGh0AMP4Vt5E
	XQxe0ars5DpPwZRuG4sxAV03X2Ymx3uCTp+ofWzvAz5MhA0TmgOUS6LzPF1GeqBBa4wS5TOleld
	3GNqd6U9Ks+aFSEfvb1Z4dt+oOuUGZAY=
X-Gm-Gg: ATEYQzzUoVqcuQWG/S6QA7W4OfDPtREc1fQDmVmVM0tZyqsU6mg9VNK9iZsjvpFFqsA
	32fYv5hZZJgvaAaOO3suN7MWmj531vZE8cDasOGPp8I1gZosP6/68ptazOsqumtz1ipV5goZbO+
	gTvm1qPc00B27nrxM9OxA2J9pDkdSr5NHxOObBnA+6zpNrYg6PdDksCbGHw1KG5hKZlA7X1MyW6
	c+1Fuf5tokWFGfRAJ3i1njxYsOW4J6B1YhxaqKBlTWo/OhTNQN/scIaEHAqb2pBEBHgP9mxE4y7
	tSUlhSDDfKdXtU1pK7AlwsmrUWI9rJdHD9DWPGtnJvx237bBPg3cKbJFXhnUJKrgiSj/p38WQAS
	qqLAp6SsbB4nU3nza8mRqT1KbtY/AU5OfEAECOwaA72x/g3C4WvqyzqdtAdhsSqHfB8ddlWZi7l
	vJpAQeykTuBhOcXKg=
X-Received: by 2002:a05:6122:4219:b0:559:58a5:f6cc with SMTP id
 71dfb90a1353d-56b627f0c85mr959770e0c.4.1773399000485; Fri, 13 Mar 2026
 03:50:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2233.v6.git.git.1773288013936.gitgitgadget@gmail.com>
 <pull.2233.v7.git.git.1773345901659.gitgitgadget@gmail.com>
 <xmqqldfwacyw.fsf@gitster.g> <CAOAgETMCb++MnOC9YEN+y0TE9NeVC+-=Zez7UOVY3kt8vv7dRQ@mail.gmail.com>
In-Reply-To: <CAOAgETMCb++MnOC9YEN+y0TE9NeVC+-=Zez7UOVY3kt8vv7dRQ@mail.gmail.com>
From: Arsh Srivastava <arshsrivastava00@gmail.com>
Date: Fri, 13 Mar 2026 16:19:47 +0530
X-Gm-Features: AaiRm53WdKfgN2LfIHFgu-e-ovRpI-aBiDJYLaQKxKgy6rEBccHJkvX_Unz_F6s
Message-ID: <CAOAgETMBnbhSYmHkc0sSTCCsZesxO0G8timU0yF22-PkMi_CsA@mail.gmail.com>
Subject: Re: [PATCH v7] unpack-trees: suggest using 'git stash' when checkout fails
To: Junio C Hamano <gitster@pobox.com>
Cc: Arsh Srivastava via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Arsh Srivastava <arshsrivastava00@gmail.com> writes:

> I understand, git wants people to not explore the available
> change options and help them make logical decisions rather
> than pushing them with some unneeded commands.

Actually the above text should be :-
I understand, git wants people to explore the available
change options and help them make logical decisions rather
than pushing them with some unneeded commands.

On Fri, 13 Mar 2026 at 08:43, Arsh Srivastava
<arshsrivastava00@gmail.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes :
>
> > The first paragraph is a bit of a run-on and has a misplaced "and";
> > I cannot quite read and understand this overly long single sentence.
> > Perhaps the early part can become a bit easier to read with
> punctuations, and cutting the sentence into two, e.g.,
>
> In my future commits I will remember to make it as easy to read as possible.
> With less punctuations and shorter sentences which will in turn make it more
> concise.
>
> > Also it is misleading to say "previous" error message.  We talk
> > about the current code in the present tense, to highlight what the
> > problem in the current code is.
>
> Understood I will in future not use previous because it is the
> _current_ code.
>
> > You may view it as a weakness (which
> > may motivate this patch to be written).  But I personally am not so
> > sure that adding words to the existing message would necessarily
> > make it more clear.
>
> I understand, git wants people to not explore the available
> change options and help them make logical decisions rather
> than pushing them with some unneeded commands.
>
> > As Documentation/SubmittingPatches says, let's instruct the code to
> > "be like so" in imperative mood.  E.g., "Enhance the error
> > message..." instead of "This patch enhances...".
>
> Understood that makes sense because nevertheless
> it is given that I am writing the changes for this patch only.
>
> > These were already overly long, but the updated one is way too long
> > to be read on end-user's terminal.  The source lines are overly
> > long, too.
>
> That makes total sense.
>
> > to those users who decline the advice, we now show "Please
> > commit...".  That is not what !advice_enabled() should trigger, is
> > it?
>
> Thank you so much for your guidance the advice should not
> trigger to those who have opted not to see.
> My code might have misjudged this paradigm.
>
> > Also "To move you" -> "To move your".
>
> I thought I had fixed this typo. Seems like I didn't.
> I will remember to be more cautious next time.
>
> > Also the advice lost the other possiblity of first committing the
> > work in progress on the original branch before switching, yet the
> > new advice message is quite wordy.
>
> Absolutely correct this commit does narrow the users vision
> for exploring.
>
> > Also, using "for safe merge" when the user is performing a
> > "checkout" might be slightly confusing, even if 'stash pop' involves
> > a merge under the hood.
>
> I don't want to sound like a programmed robot but I absolutely
> agree with the recommendations.
>
> > But as I already said, I think the current text may already strike
> > the right balance between being clear and being concise.
>
> Thank you so much for your valuable guidance.
> If it's possible I want some guidance over the questions written below,
> As it is well stated by you that the current
> text is clear enough.
> Should I still work on this PR from a purely GSoC
> perspective. Or should I start making my proposal or
> still work on this PR until my micro project is merged?
> Because I have already shown I can navigate git project which
> was the goal of micro projects in the first place.
>
> On Fri, 13 Mar 2026 at 04:10, Junio C Hamano <gitster@pobox.com> wrote:
> >
> > "Arsh Srivastava via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> > > When a branch switch fails due to local changes and
> > > new users who are not familiar with the error message often
> > > get confused about how to move ahead and resolve the issue as
> > > the previous error message only suggests to commit or stash the changes
> > > but doesn't explain how to do that or what the next steps are.
> >
> > The first paragraph is a bit of a run-on and has a misplaced "and";
> > I cannot quite read and understand this overly long single sentence.
> >
> > Perhaps the early part can become a bit easier to read with
> > punctuations, and cutting the sentence into two, e.g.,
> >
> >   When a branch switch fails due to local changes, new users who
> >   are unfamiliar with the error message often get confused about how
> >   to move ahead and resolve the issue.
> >
> > Also it is misleading to say "previous" error message.  We talk
> > about the current code in the present tense, to highlight what the
> > problem in the current code is.  The _current_ message stops at
> > hinting the commands to be used without giving wordy instructions
> > that are best left to manuals.  You may view it as a weakness (which
> > may motivate this patch to be written).  But I personally am not so
> > sure that adding words to the existing message would necessarily
> > make it more clear.
> >
> > > This patch enhances the error message with more specific
> > > instructions in a concise manner to help users understand
> > > how to resolve the issue and move their local changes
> > > safely to the other branch using stash.
> >
> > As Documentation/SubmittingPatches says, let's instruct the code to
> > "be like so" in imperative mood.  E.g., "Enhance the error
> > message..." instead of "This patch enhances...".
> >
> > By the way, the updated message seems much less concise than the
> > original.
> >
> > >       msg = advice_enabled(ADVICE_COMMIT_BEFORE_MERGE)
> > >             ? _("Your local changes to the following files would be overwritten by checkout:\n%%s"
> > > -               "Please commit your changes or stash them before you switch branches.")
> > > -           : _("Your local changes to the following files would be overwritten by checkout:\n%%s");
> > > +               "To move you local changes safely to the other branch,\n"
> > > +               "Please try 'git stash' followed by 'git checkout <branch>' followed by 'git stash pop' for safe merge."
> > > +               )
> > > +           : _("Your local changes to the following files would be overwritten by checkout:\n%%s"
> > > +               "Please commit your changes or stash them before you switch branches.");
> >
> > These were already overly long, but the updated one is way too long
> > to be read on end-user's terminal.  The source lines are overly
> > long, too.
> >
> > The original was this:
> >
> >         msg = advice_enabled(ADVICE_COMMIT_BEFORE_MERGE)
> >               ? _("Your local changes to the following files would be overwritten by checkout:\n%%s"
> >                   "Please commit your changes or stash them before you switch branches.")
> >               : _("Your local changes to the following files would be overwritten by checkout:\n%%s");
> >
> > Note that when advice is *NOT* enabled, we only gave
> >
> > _("Your local changes to the following files would be overwritten by checkout:\n%%s");
> >
> > without any "advise" in the output.  That is what !advice_enabled() means.
> >
> > The updated code does this:
> >
> >         msg = advice_enabled(ADVICE_COMMIT_BEFORE_MERGE)
> >               ? _("Your local changes to the following files would be overwritten by checkout:\n%%s"
> >                   "To move you local changes safely to the other branch,\n"
> >                   "Please try 'git stash' followed by 'git checkout <branch>' followed by 'git stash pop' for safe merge."
> >                   )
> >               : _("Your local changes to the following files would be overwritten by checkout:\n%%s"
> >                   "Please commit your changes or stash them before you switch branches.");
> >
> > to those users who decline the advice, we now show "Please
> > commit...".  That is not what !advice_enabled() should trigger, is
> > it?
> >
> > Also "To move you" -> "To move your".
> >
> > Also the advice lost the other possiblity of first committing the
> > work in progress on the original branch before switching, yet the
> > new advice message is quite wordy.
> >
> > Also, using "for safe merge" when the user is performing a
> > "checkout" might be slightly confusing, even if 'stash pop' involves
> > a merge under the hood.
> >
> > A more concise version might say:
> >
> >   Try 'git stash && git checkout <branch> && git stash pop' to carry
> >   your changes to the new branch, or commit your work before switching.
> >
> > But as I already said, I think the current text may already strike
> > the right balance between being clear and being concise.
> >
> > Thanks.
> >
