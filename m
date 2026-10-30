Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793377860;
	b=LQaYM+6fxklNarGiapP8l8J42GDNbqPNlOe4am3aoSc/k7ZfTgiLsBawYRW504fsA9B1
	 wg9YFRlac9AF6HtdTj7ug2EsgDOnwYkjUxfg/01IPid46jqUSBc676l34fFfi4D8vtrKl
	 0DHtPPu2AaDxZGrxS0DxPuHWMq+hBHt4InrpqWsRJXgj/LQuOg4jJs56spvtE/gfG31Pw
	 cXb+xjm4tpRfd+bm6gZEuec0yBu7Sxe+dJJEwDoVgunkecyOssbQtMygHbTF/NB6tvNlt
	 uPq1VCJqGu0Nxvjq70ffDEMo6BY2LqxOf9AhlPpTIrGSem9fjpP1uYgG72V07EnRQVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793377860;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=MpVtJSyzb4FKXd9yFzt2y/5mHI44Qd9bzQmJ4ghr+2E=;
	b=FGqh2awQzSJ/gvvMlU7cOrs1ga3QW9AY5zTbPCoNKm6ICMWZlQzlwiBBYoUroKKMFupf
	 sNiee+8KNOlCobbcI/9bB7WVm5dAeAVdzPyHzSXw6rOMxg4aFkl9HN442FrMEukAvjaWt
	 OxLwZmY0wEcdwuT4wMIVy9IqTwlCRtBCEYFUfFLSIfqRazlubGzF7CDDy2cWG3+EQ1lUi
	 rkLZuvRrwjsPU/tEXGK9MZU3WfZx42hP5QlBCSFLrx7pVCOhYDwPecH0geRvJ+YS4vUGJ
	 TvnuvLAxOx0uKXJPD8loEHKYdeoywMZCDqC4glYMF8SP6RojntlSwJQQg4ll76QIn/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=llEzDtN9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA7F606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 16:31:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DA7F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=llEzDtN9
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-533202fe429so393091cf.0
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 09:31:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793377859; cv=none;
        d=google.com; s=arc-20260327;
        b=HbhefiQaYc30O43WFbeyhFAlt4xbB7uwRh70CEgOqvgIFQXm6ZeD5WiGhPE2RFyL9n
         Hu1CsVU5O82EwhCfcE6AHokX2ozbtx1JMmAZmsF6tME8qc440boCkLK/5fZXbGxR2UvO
         DfsbI6ZsBNCUo/2eqWJiDkerNeQWwvD8HS0ZYPkkQ4eDzyNRT/PMn8bQGCova2nDWdLN
         g0GzQfCTadwQkDv29Hs6CxTG0GstZFFbopzZqCmo1SjMtOs+iLwJsF5U/6b7wwomNy8G
         ZksWjD/I211kpSLXX3T0EX+9ZFQy9RKtJPvzaZNkmw3AS+2r7Pt53/DoyZ2o+yj2XPWn
         0SbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MpVtJSyzb4FKXd9yFzt2y/5mHI44Qd9bzQmJ4ghr+2E=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=jFfUOnV35SWLcf5GpYZg3tsC1tXF9h6mc3LPlfwlLas6X0+6nnSKMcXw1r9NwBp2u0
         Kz7cl25K5KP65fKIPJw4+iRNRnEEnSDHHBJGxtg5vFjRTxGDScuNXKAGdZ0H6oIt5kAX
         fChZ860BF9GSFjzmzl3JFQFqLijcy3JAgCiMcQ3+524pohLmZkRC+qpsQZ3gbkgt/6F2
         Yt/b83TpLb7nlrFaQK1bWT4IXFFj2IGXsdicdixrF0fx4/j5Rakvqew5f9r7rqIC3xNP
         sP07Kwn6qpuCEeWPGw3262infXPKdSJo9GkgwTwGtnUSnJ8s/48Pg66ihOrZQHGrWdF3
         DuCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793377859; x=1793982659; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MpVtJSyzb4FKXd9yFzt2y/5mHI44Qd9bzQmJ4ghr+2E=;
        b=llEzDtN9lQJYxKsWlGWs5GMrvyMauzwHziPNHr6pqvoo6EYLn+4bOstb+q3uci6A5s
         KIsYBb+IzkF2Iaw42clLKHGoAVJteJxL/pIQurEGchx3rpS+S2Q15+p0/IZCl7/KpW6y
         GSaL8NyeGo7D99L4YnnFwOwUdXXKVkb+fYylTkHpjOp2ocO9ZrRKccm+8pXYhtWj+/SN
         u7D1z+9CMdIsdcQJJewvT/naq6C529Dyesb0OMbtNTYrzmaKolcn32KUxj6536/zytS4
         562pfUyH5TF5WTglUrMXHymIjhJPFvpbuG1jqyVIgLrb0NwPZldAShSPbhg/3msCBfej
         +/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793377859; x=1793982659;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MpVtJSyzb4FKXd9yFzt2y/5mHI44Qd9bzQmJ4ghr+2E=;
        b=WiI/NKnd3F7u4dUvwGV+WvVQjWakyPvSibC3iMVx2MihrhZF8U84YL2oOM2Fs1AF4h
         av0bVnDXNyco5ZlQtqGveBMwCJ854O6+NlZ0spjqt/R51hmVk2WiFgYhmK4C0fA0YB+n
         OCEsxcTVL6rtFkwKoGQDYR9HEWlaH+bptECZ6FuhVM96lG4mJXx0b3O4VQOhV2nCmbj9
         erQSiYUQvXByKY84tvC5LpaNpBKl3V7BZQ5dFA5NVXCzIGkYiUa6JbjL50VScDY2IzQ/
         gqsctDN1XZ4Ya0NP+81zx5Te2RnB4KWzBI4U4OXr+BZm8jtRa0F4/FpoQwE5tuucweDU
         zGRw==
X-Gm-Message-State: AFq9FYIyayb2e619JLwG04KUKgWkN6/ndpqaWhUJ7kW2GfRwIYtvwWDQ
	ZXUl3nZLNr5otWTWD/eLjS7vSRUBUAaDtyMYWAOz9mjqZfSQ70mgVbW5KkB5mRF8uxrlUkA7Ggb
	GinRumxqpeKTdh3Z9nvZraymhUyOWQXy3lCTXVbPL
X-Gm-Gg: AYBFou1oCBY9Diu4nPYQ+Jyb66K2BDouM61FQcJKaPu9Lft61EnNdpFNhOUvjvuf/UW
	Qo8jffJFdEXtQOtO0MuDKDiYzforVtqQtI6BGiF7+u28vpQO/nTFR+aJ3E+tVHDxjbk2gf5FnIa
	QBjY3cCD3DSLM5fHzl1+RsQzbBGjhnEKe1Z/EQpmHCHaWudXp8vLj2aXmy7UYJLRQTa6RchaXta
	SBQ9imt3DcYMiKA6jQqDlNSCktFofad4xaJ29JClW73paTWyFWbwWMVLnYi+++lKy48KlNFdgXz
	zpgYLkHGp9pf7APy0xkyEQeZtK3i6ayyLncCRkCTAl5SzOB4WVG1jJSYMpTUMGMWsJn7o58PFde
	wJZ//UDC8ei9wKPdOhzgIoPBC7iM8dfqup//stBS/F6Er++RaQSLS6iM4m9GHF33R5fudoWsFIV
	h9gldiJRSORpWYKi0Y1WeH6g==
X-Received: by 2002:a05:622a:400d:b0:533:9746:9a86 with SMTP id
 d75a77b69052e-5412d80f80bmr43607081cf.5.1793377858241; Fri, 30 Oct 2026
 09:30:58 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021200341.378978-1-emilyshaffer@google.com> <xmqqfqxylnct.fsf@gitster.g>
In-Reply-To: <xmqqfqxylnct.fsf@gitster.g>
From: Emily Shaffer <nasamuffin@google.com>
Date: Fri, 30 Oct 2026 09:30:45 -0700
X-Gm-Features: AclHuK_M4gcLPcxsuju69sCpjka8q0eCWmaM8o5TxiluU5KwiNSmPyyIF3M8abg
Message-ID: <CAJoAoZmdu5zdUAjNi7d89CH4jYTMmLDa8e7cd2nKwTEk7oO1jA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: propose community voting process
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 3:07=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Emily Shaffer <emilyshaffer@google.com> writes:
>
> Emily Shaffer <emilyshaffer@google.com> writes:
>
> > +Voting in the Git Project
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > +
> > +For the most part, technical concerns in Git should be resolved by com=
munity
> > +consensus - either on the mailing list or in one of the annual-ish Con=
tributor
> > +Summits. Voting should be used as a last resort when the community rea=
lly and
> > +truly cannot come to a compromise on a policy decision. As such, the i=
nitiation
> > +of a vote should be generally agreed on by the mailto:git@sfconservanc=
y.org[Git
> > +PLC] or primary maintainer.
>
> Nicely described.  I particularly like that this prevents us from
> putting technical decisions to a vote, reserving voting strictly for
> policy decisions.
>
>
> > +Phase 2: Voting window
> > +----------------------
> > +
> > +The final version of each seconded proposal will be collected into a b=
allot at
> > +the end of Phase 1. When the ballot is prepared, eligible voters will =
be able
> > +to vote by mail for two weeks, to make space for contributors' individ=
ual
> > +timezone and availability differences. During this time the proposals =
may no
> > +longer be altered; the ballot should refer to a specific version of th=
e
> > +proposal (e.g. `[PROPOSAL v4] Require emojis in commit subjects`) and =
any later
> > +version of the proposal will be ignored.
>
> Or any earlier ones for that matter.  Perhaps there should be a way
> to uniquely identify the version.  By the time the proposal is so
> solidified, it is likely to be in my tree, so we can use the commit
> object name that adds such a proposal document (or the blob ID).
>
> Then we can tell people that
>
>     $ git fetch https://git.kernel.org/pub/scm/git/git.git/ seen
>     $ git cat-file blob $BLOB_OBJECT_NAME
>
> would give them the exact thing they are voting on.
>
> I presume that this can be used for multiple-choice votes easily,
> and can be adjusted for a proposal with multiple things to vote on
> independently (i.e., "allow emojis in commit titles?" and "require
> CamelCase in commit titles?" can be asked at the same time and
> voters can give answers to each question separately).
>
>
> > +Votes will be decided using <mechanism TBD>.
> > +
> > +Phase 3: Implementation
> > +-----------------------
> > +
> > +When the voting window ends, the winning proposal should be merged to =
`main`
> > +without delay by the maintainer. The commit message should be appended=
 to
> > +include a link to the top of the voting discussion thread so that the
> > +discussion can be revisited by history divers in the future, as well a=
s a brief
> > +summary of the result of the vote (% in favor out of total number of
> > +proposals).
>
> Do you mean "number of votes"?  Or are we envisioning that there
> will be N competing proposals and we vote to find out which one is
> the most favored?

I read the rest of the replies to my proposal this morning and didn't
see anybody else clarify it. Yes, I am envisioning N competing
proposals. In some cases they could be as simple as the following:

Question: Should the project adopt the policy outlined at
git.kernel.org/pub/scm/git.git/commit?id=3D12345 ?
Proposal 1: Yes
Proposal 2: No

But in cases like the AI policy I think it's more likely that we will
have a number of competing proposals, because the community feels more
than two ways about AI use. I'll stick with my silly example about
commit messages to avoid inviting criticism for throwaway AI proposal
lines here:

Question: How should we format our commit messages?
Proposal 1: Anything goes. No more length restrictions, wrap anywhere
you like or not at all, use special characters if you want. If it's
covered by Unicode it's fair game. In fact, if we can figure out how
to include bitmap images in the commit message, let's do that.
Proposal 2: All commit messages should be written in lojban (despite
that this proposal is not written in lojban).
Proposal 3: Conventional commits, but make it fun: indicate which type
of commit it is using an emoji. Emoji use is mandatory.
Proposal 4: using the shift key is unnecessary energy expenditure and
should be strictly banned, this applies to punctuation that requires
the shift key also.

In this case some might agree with one proposal more than the other,
or be okay with a third even if it's not their favorite - both CIVS
and devotee use a form of ranked choice voting and solve for the most
popular proposal based on voters' ranked choices.

>
> > +Voting Eligibility
> > +------------------
> > +
> > +Votes are welcome from contributors who have authored a commit which h=
as been
> > +merged to next, or who have provided 2 or more code reviews, and who h=
ave not
> > +been banned from participation in the project. All eligible contributo=
r votes
> > +are weighed equally, regardless of the overall number of contributions=
 they
> > +have landed.
>
> That is a fairly low bar to cross, especially the code review count,
> as it will not be easy to define and enforce some rule that rejects
> a response to a patch that only says "thanks, I like the feature
> this proposes" without reading any parts of the message.
>
> As it is hard to track patches that as in 'next' a few release
> cycles ago without graduating in the end and the authors of such a
> patch should have the same voting power as those whose patch is in
> 'next' in the current cycle, I would suggest strongly against using
> 'next' as a yardstick.
>
> I would have expected to see something like "two or more topics that
> appear in any released versions" instead.  Note that I said "topics"
> here and not "commits", so your topic that consists of 17-patch
> still counts as one.

It seems like Peff's matrix along total commit count and recency of
contribution[1] also was quite popular. I tend to agree with you about
not wanting to restrict votes to people who have been active X number
of years ago, but to be honest, it's for selfish reasons: I haven't
been able to write code actively for quite some time because of my
role at Google and I still feel invested in (and a welcome member of)
the Git community. However, if the eligibility criteria that the
community agrees on prevents me from voting, I understand, because I
know I have not been contributing as much as the community would have
liked :)

I'll continue the discussion in reply to Peff's thread as well. Thanks.

>
> > +To prevent dogpiling, contributions are only eligible for a given vote=
 if they
> > +landed before the beginning of the voting process (the kickoff email m=
entioned
> > +above). That is, the code reviews must have been sent or the patch mus=
t have
> > +been accepted before the initial email is sent. The intention is to en=
sure the
> > +mailing list isn't spammed with low-quality reviews during the voting =
process
> > +solely to increase the number of eligible voters on one side of the is=
sue.
>
> Hopefully the "in released versions" criteria makes the above a
> non-issue.
