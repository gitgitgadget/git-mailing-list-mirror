Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD5F47765
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 16:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQOV7VS6"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e34a72660so4950409e87.1
        for <git@vger.kernel.org>; Wed, 20 Dec 2023 08:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703091001; x=1703695801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDSK3oOTfn+axqzVuMQuDs/Ly1S8adY6x2s67e6/vZI=;
        b=WQOV7VS6VgBztcPokX089uV2WEx1ZNJzIw1wlnqp0hvazL0V9IXoW8puB4Hs1YuVZ4
         VwqWJYP/MhTfl4loiD0PTP8Z4milJLAXosfg2PmfXk+F+d5jpm7n2qV6KUCGT7cM93RE
         oS03PmrT1j72ioppTb23viG4EAr1GWnHf+GVh5y6F0R3kEi5kYqPwrjNTdevCLc07eBW
         9YkKx14ieM6thTiidV71UViREVc36JoTsh333+hA/ThL4+ttOo87mU5+JrfERKc2CWq1
         ELjQVprSNicLWAxJ6FShdaS8rHUBo54zKOOYKVAwYB2Eor4zC1EdvbafQdwkxBLIlFde
         JCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703091001; x=1703695801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDSK3oOTfn+axqzVuMQuDs/Ly1S8adY6x2s67e6/vZI=;
        b=GvK6i9uKi0PG3iK+SMxbThKp8l1tHMsIeWVTc8qmx7gg2rFXoAofVdiu+lV8mJGPmn
         NZpPECUY7m33A0AHalueqEH8OmJCdBnQ9BzFAJzdntXzdY8yje1i3qmm3XSfKRr5M5IE
         233furcFwYix/CyNATU/BLVal9LHQ/S8fSHjsOg0Yt9HFrrcqzqYSJpB10XJ/RkMZF0O
         clfISvzUdFcrSClW3T0bVbe7FUpe4lsF+lNnV0Xz/sxuSDsMqWw81+bwvZUKV4viUmcP
         IzyFI3naBfl5HUQN+fyss9TIIe+/E3fgs1692KdMsJVGW7AeKUU0z5quhSeTJqQ/1KaN
         gigg==
X-Gm-Message-State: AOJu0YzVoMj9e6y8sKMZNdN/D0usSwXVw4H+AP+tS8/N48JGBdxzIcEY
	ag/7zZ5n7G1Dw3qaQ2V+KANx+0060Vdj9Cy8OEMGEvjc45s=
X-Google-Smtp-Source: AGHT+IGmlu6hulPEUxzC2TuakAc8YMPDH9YTyn73x3KUJLr/EM6bAyoozaJTVBSTVLC/KzmLThRU2MFMgkFVm77MJLw=
X-Received: by 2002:a05:6512:3e0f:b0:50e:54aa:750d with SMTP id
 i15-20020a0565123e0f00b0050e54aa750dmr828475lfv.85.1703091000545; Wed, 20 Dec
 2023 08:50:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
 <e5c7f29af439c48f59b2f35af93a7972e66a5b6b.1702975320.git.gitgitgadget@gmail.com>
 <35fc350d-018a-49cf-a28e-e5ce21fe7dec@gmail.com> <CABPp-BH_iP2KjPi-5kW8ROQWfy8XoUmbGhyT-Y1dZGtCtZXQGQ@mail.gmail.com>
 <CACZqfqAiSpGP5ABN7MZ50Za=-vAEKnqE0ravzEMbLJCByfRd8w@mail.gmail.com>
In-Reply-To: <CACZqfqAiSpGP5ABN7MZ50Za=-vAEKnqE0ravzEMbLJCByfRd8w@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 20 Dec 2023 08:49:48 -0800
Message-ID: <CABPp-BFjotLN4sCe+6uHAU7qhr1COM0B4EdW0f0-X-xf5qXinA@mail.gmail.com>
Subject: Re: [PATCH 4/8] SubmittingPatches: update extra tags list
To: Josh Soref <jsoref@gmail.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 8:09=E2=80=AFAM Josh Soref <jsoref@gmail.com> wrote=
:
>
> On Wed, Dec 20, 2023 at 10:30=E2=80=AFAM Elijah Newren <newren@gmail.com>=
 wrote:
> > On Wed, Dec 20, 2023 at 7:18=E2=80=AFAM Phillip Wood <phillip.wood123@g=
mail.com> wrote:
> > > Thanks for adding these, they are widely used and should be documente=
d.
> > > The patch also adds a mention for "Noticed-by:" - I'm less convinced =
by
> > > the need for that as I explain below.
> > >
> > > > Updating the create suggestion to something less commonly used.
> > >
> > > I'm not quite sure I understand what you mean by this sentence.
>
> Tentatively rewritten as:
>     Updating the "create your own tag" suggestion as 'Mentored-by' has be=
en
>     promoted.
>
> This commit is adding bulleted items including promoting 'Mentored-by',
> which means that the suggestion of "invent your own" would really need
> a new suggestion.
>
> Personally I'm not a fan of "invent your own", but I'm trying to
> follow "when in Rome" (which is a big thing in the Git process
> documentation covered by the two files subject to this series). More
> on this later.

Yeah, well it appears that those of us who have been here in Rome for
a while aren't a fan of it anymore either; see also Junio's response
in this thread about that.

> > > > diff --git a/Documentation/SubmittingPatches b/Documentation/Submit=
tingPatches
> > > > index 32e90238777..694a7bafb68 100644
> > > > @@ -348,6 +348,8 @@ If you like, you can put extra tags at the end:
> > > >
> > > >   . `Reported-by:` is used to credit someone who found the bug that
> > > >     the patch attempts to fix.
> > > > +. `Noticed-by:` liked `Reported-by:` indicates someone who noticed
> > > > +  the item being fixed.
> > >
> > > I wonder if we really need a separate "Noticed-by" footer in addition=
 to
> > > "Reported-by". Personally I use the latter to acknowledge the person =
who
> > > reported the issue being fix regards of weather I'm fixing a bug or s=
ome
> > > other issue.
> >
> > I'm not sure I'd mention both either; feels like we're making it hard
> > for users to choose.  Also, I think there's a minor distinction
> > between them, but it's hard to convey simply: To me, Reported-by
> > suggests someone sent a mail to the list specifically about the bug or
> > issue in question.  Also, to me, Noticed-by suggests that during a
> > back-and-forth discussion of some sort on another topic, a fellow Git
> > contributor noticed an issue and mentioned it as an aside.  But,
> > that's how _I_ would have used them, I didn't do any digging to find
> > out if that's really how they are used.
>
> Given that Noticed-by is more common than Co-authored-by, I have a
> hard time arguing that it shouldn't be included.

Not if you look at the last three years; there Co-authored-by is more
than 17 times more common than Noticed-by.

> You could see that I struggled with it based on my lousy first drafts [1]=
.
>
> Anyway, tentatively:
>
> . `Noticed-by:` like `Reported-by:` indicates a Git contributor who
> called the item (being fixed) out as an aside.
>
> Here, I'm struggling with the tension between "noticed-by probably
> hints that something is being fixed" and "noticed-by is addressing who
> suggested it and why we're attributing it to them"
>
> "as an aside" is itself an ellipsis for something like "as an aside to
> some unrelated discussion and didn't really circle back to it as a top
> level discussion point, but here we're closing the loop" -- but this
> is obviously way too long-winded to be the written form

Given the large drop-off in usage of the Noticed-by trailer, I'd
suggest just leaving it out.

> > Either way, if we're going to define them as synonyms, I'd rather we
> > just left the less common one out.  If there's a distinction, and it's
> > not a pain to describe, then maybe it'd be worth adding both.
> >
> > If we do add both, though, we at least need to fix "liked" to "like"
> > in your description.
>
> Right, it's a "first draft" [1]...

:-)

[...]

> I personally agree. I think encouraging non-core contributors to
> invent their own is not a good idea. It leads to various things
> (including inconsistently cased items because users fail to review the
> current set / understand them/their-construction).
>
> Saying that it's ok for core contributors to suggest a new tag and
> that if a core contributor suggests a new tag that the person writing
> the current series should just accept the tag and trust that it'll be
> ok.
>
> Note: I'm not going to draft wording to this effect on my own, and if
> I were to provide such a change, it'd be its own commit prior to the
> one here, because it's a significant process change as opposed to
> clarifying the list of recommended tags.

Perhaps replace

   You can also create your own tag or use one that's in common usage
   such as "Thanks-to:", "Based-on-patch-by:", or "Mentored-by:".

with

   While you can also create your own trailer if the situation warrants it,=
 we
   encourage you to instead use one of the common trailers in this project
   highlighted above.

?
