Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE3723D7DC
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 11:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773399862; cv=pass; b=AW5ImcWXft/maoBHCNxzll2JgPdfwb3bIsbh3DX2FpeY4QslSzF0IRrGkmoy29deYrUqc0s57ZbCRDDnsIV8PGqaKIH6dWMfyPQWvtq+F221zBdzzBR6qbZL8zJ3fAlSG1CovK+Q3ODfBOmksuqlaSnS/nwujg/bFlkLEZgoqtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773399862; c=relaxed/simple;
	bh=734v+qRxxSkOPTSBHXPd6BVZuxII1poJQQVijPvl5iA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NzlG8UseEWywbpL5g9elsF1yRH1a9lWkNVMiY3eDVx5/ZCuA7Wr9GMniKKY8QmDoF++Gdv+4kDLzuzAhefqrBRNJM1YUJg8O5OUZ+ONDEVaBaGbdIirGvRubys54zqNwLJtt5HLn3Mguk5aPiXPttpFiDZUGdzq9KmSRJ9pAKXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUrkgrBX; arc=pass smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUrkgrBX"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-94acd026e45so433473241.3
        for <git@vger.kernel.org>; Fri, 13 Mar 2026 04:04:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773399860; cv=none;
        d=google.com; s=arc-20240605;
        b=byO/BMsb8gXkRgCQOmApT3HO8gdqkFV6u57v/XkmB05hhQNQ08qdKfV0nYYv08WNvw
         bwygJp5wUBvu7irZJgg1L5rW/dwjMgJR2Xlzibx6n7s0D5vusnTY2+v/JpCUzkEdZA5b
         M7rE7jzTtIkGrUu61tFFMumMZREQHKfpRlcNIpehVe4XS4ust6AvwNt9Vj5PFN4MBrjA
         BhdtiURjMPNwJSxd47JMZZMsgETip7PoQChPmK/0xEWqOOtdVfGVnE5cMKGooT1R22Pj
         Hx/BCRBeWagrPU5XOrmtTBgQpfU3ta3DseaRZHlZw//Jn5qYHOmL9gzMax2G7+fPcvTd
         tUjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pfVJ4R0994cIHhvqx4K4oYJCJCPcV1mn95wIcN25V1o=;
        fh=33pJO00qlrOaWF9SJejH9gi3FS10eGOhQ8l7eai5Q2k=;
        b=IcCxh/d8E7+Z5KI6oTnlwPA8dw58/wqsg7fWN3aud32o7e1t8CeWKqncKPwQG3aeNe
         U9ltSlEA/IAffAbEFBlY9Iue5fzCpre+5vwP3DrY3e43/ZqnS+gY6GoTXYs8NUSFsjXS
         JalatxSMAINaUPnLomnzo/KobUZGGN92CPEfWRQr1OveMbtNkL12kQolbbioevNsiVUt
         ZHXC6w6oiCnCPItBbHSitTXI7IqUcPgjQ0/FxiP1CbTkaO+LO4t5DRn4/Xu11lbU9JRc
         GT4Zo0px7tr0U74bJ6cdn2TKb6Nze9aEv3OTTuW+08BIQLWM32qJ2U5VyfbkchbomCTn
         Qj5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773399860; x=1774004660; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pfVJ4R0994cIHhvqx4K4oYJCJCPcV1mn95wIcN25V1o=;
        b=ZUrkgrBX6V7qky9M8WrT+h2E+doTzLbP060rCY10etd3hOjZE5iH8WADtMln8BtyHe
         RwVL5qd9txqHKdybjTAkJB44r+y+pTRxMhIoRlbIj74/l2TiniONIr3UZQXKtyt4waai
         JZr90pIBVtknjDs1N2d8TkHjDKXJeLCtj0Do4Rkyb6wLo4b5Lqo9fJtIHgvEoV4IDy9B
         0rRl5P3stWYD086et2sdzPxapDA6rXVNTFQWrbA4VwQLfMHMPb1KVXD9kRzA6b3v8aKj
         I6cGi2PBvF4kpPewvDyDu7BRqrEPnVXcSNYI8goEUqK/5sasXtlr4uUGulQIDhcoCsLK
         YHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773399860; x=1774004660;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfVJ4R0994cIHhvqx4K4oYJCJCPcV1mn95wIcN25V1o=;
        b=VXe1rzWDQspsoPII3O524A4OwTi3K0m2AKDLnfE+wLgYH1d22wGU6/8ZJlSmI9km7F
         SQovqpJfzjB1jdVl0fTC9lXjHC0iPfQ37Lv03USpCVtWIbHaqSjeS6O6IfEPWB3JUEE1
         mMbghsnot0eKzUBnn0rVnnM9slKBGTmpAqAWOn7pb/YZQZoJu0wOxUSTcFcI5nX4dzA+
         fWKuZVPrtYRMNV58xAXiSIXCr9KyxiAzg+jebK4M/00J9q8K8XQ/fv0n89QDCZxpT5PV
         IwjdaO0ffboVL6I1vEmXS7C8n0Y/1SO3MAEiOT1Iw6g0vTVI4GZjqPAXANkX3tmgkYAO
         ej4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUd/dJf/DcL615ohxY8uk1KaCOp2k7td1HHWjB/4yPvkaWF8qt8sGFdvAM+WYcozcV5lSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YytyfBh3wqzjDa31VGlBFTDro3R/iaWjuKmISv+IMTO0OPm3B4h
	bV/WUzA5A2FNdssbEjCeCqLHwqwHQSawqdU/QAYKKeJTayg6EMCXa161DO0iwC03g+WibOt7DOM
	v2ZJnY+W2eOqNZg9PhfSmwXY84jOnvC0=
X-Gm-Gg: ATEYQzzpQe39mxP4NLy/0S7jVych6DnFsAA1EU9mY4UQN6JVniTYhphJ+U36FRDPuVm
	+kry+UvSrcIF6jZ/en+tl8QpdFj91RxOQvN5xVGUux4v/mrkwYGm05Luw1UShuBvox+CYj2P8tv
	3uo1XhavM08pEMjuykdkZDuQIazHNe+oooMwZPT0tIowwpOPlQ+eDDtfAqU4TaRu6RrpYN/jRH1
	vy/RItBYnc6FSoV6/JSVn8Wx/w5hkIWZy/9oCG5g4VfPNqq4XM7a9RPKu+1IP9d45ovunmIRu+R
	kGVDNcKLKGELG4jXlQt4Zdf8jH9aOiIwblcdyp2IHJNstSkYJ8OGTgPl/bpsBpgfi9OTiDb8lq6
	8ehvoU9efznLHk+XpXcEMw0KyOm2CHqSudMMf+O5r7hlcC3LBfy+ioHNlAPfaoC2SbervCqYEkK
	1gyKYH
X-Received: by 2002:a05:6102:41a6:b0:5fc:9758:eae4 with SMTP id
 ada2fe7eead31-6020e4cbee8mr924507137.20.1773399859702; Fri, 13 Mar 2026
 04:04:19 -0700 (PDT)
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
Date: Fri, 13 Mar 2026 16:34:05 +0530
X-Gm-Features: AaiRm52EKALqGQewg_7GoNNM4ofpkqQFRlf-YCND4t6y2IdMsPjSPwkndHPMqwM
Message-ID: <CAOAgETM=TL1V2U-t3uLehfoQ2dJ=biwR9dw=33J_uHCqh9+mpg@mail.gmail.com>
Subject: Re: [PATCH v7] unpack-trees: suggest using 'git stash' when checkout fails
To: Junio C Hamano <gitster@pobox.com>
Cc: Arsh Srivastava via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Arsh Srivastava <arshsrivastava00@gmail.com> writes:

> I understand, git wants people to not explore the available

This was a typo the real text is :

I understand, git wants people to explore the available

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
