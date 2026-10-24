Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792855832;
	b=f9mFrLrfGWhnucBPe3g2I7g6WEfV9ebjWz295Duh01GWfKmcRRVfOsItVfUX7xOCMlYU
	 UCn/++tLJDxLZIGpeNZJ5EVAXLPsFynw4a4Jz77XFiGKRiaWg4OoBcns11PNUofMQC6F1
	 xH2CpxPgsEFg3xNul23kX482Vu5VUxCaDziWnVP9VqtQs6m7MJyPeyGCdiiQkrQavhWGk
	 OwHHBFsGpYDxfpMaAORAgKWqQYSEtpVR/36bxBNGBJzPL7JrTdsXA0+IcYulTQuwkADzf
	 D6osZEfDuXgLH1vIgoveYQzxU/QtclEY16QTyfXYxOnN/6k+g/pAOHzTAU16mmWnruw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792855832;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=clD5Yd95NlWrqqaOywdVYLY9Z7mIiJbzsbMpp9u8KMw=;
	b=hUq7E7yC58txQM5gFvu8BUfcbCS9oxfomJ7J6BMl+4VL8uXFHD41sEnV5Cp3YSdUGZkL
	 MTYsFLUWys6bITdLkXA87S4eqf/w356vYCTiR6SbwVVWnVl2JSu8hYsUL+7kxYa9kkfFP
	 von2pL/fSMp6d6HgHVFdg303h6u+7FLUMJAlRNZlnJTMDTzeKejUOZ8/NsXupHkk0X+V5
	 I5Rr3LDRm4Zvh+Z0kJ5zvT2jTai3sIOknRR6CIAdCVrzThP+gn/A6+HzVi3tnsADIQzks
	 CbnPeSYO0J/hXZ6Q66duAynyzvOmi0woNvxOalnrUB/vdSuHrd1WtioiKhN10kMpigg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IhMQvVZ4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08227606A31B
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 15:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08227606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IhMQvVZ4
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e987a2ba0cso11115265ad.3
        for <git@vger.kernel.org>; Sat, 24 Oct 2026 08:30:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792855831; cv=none;
        d=google.com; s=arc-20260327;
        b=dVct155vJXw5FCIu4dvi4fopOuAol01w43kvbZYhtHNPgJgVECN6nbJT7JvGxG6ohr
         bj23umDo/D7Mlbe953flcCYbiasS0j9WRezwHzQraV/MbvC0KKccca8mi25ldmO20NOv
         xsVlQKCTymGB9fFR3A18KQ8df8QdLwMP7su+BjUFzHxIyU/GomvwsCRyfdw6HvAvTN/F
         7VwjNoenwFfAmeTRcr9fccXzq0resMXEpS2ZI7ZUzC255n/prklgEYCF0rYPDtOIGc26
         v1Yvhddr9RuBbMkxelN02vHPz6JlFPARo+aJ2X2nqTRVaMJX9IhaFslwUUUWAeXtvRem
         9t0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=clD5Yd95NlWrqqaOywdVYLY9Z7mIiJbzsbMpp9u8KMw=;
        fh=WyyrkwkKYXOn4UC64K4UCL/mulOcc8qvVQUiLXBG2kI=;
        b=EzFcXPp00dozXCrRN61cUKMrickYzl3yIaqJuerznKtd/eR2AEdmgHhjJphYzrfopj
         S9wjrjhtxD0RSXtBKMtTMjNJKbTGBU3lMSLw7+QhNgXKy5UMcC1sbjuVbLjfzFbJRmwK
         lzOivISMAjwUOxZAeTd2VG/z3S0CEFP42dfzl5aTzuftzgdy5prE4eTQS50VrnIwZwJB
         hWUL+RDMC+MBqI4aQfQPAIIJP5VyfYLk7/b2SIR8wNeuCyQF9XS5DJEmNNcXJuZ+hPeg
         lA3ShAi8w93npw3hn5gb8ABeGLrg49d9A5zJlSWC8m8tHJhItdVW72OL7xE/OQ/wtcBH
         OQrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792855831; x=1793460631; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=clD5Yd95NlWrqqaOywdVYLY9Z7mIiJbzsbMpp9u8KMw=;
        b=IhMQvVZ4E4WlFfP1HyoOw/zWrZKopIMno5ridwxbJfLYOegTiHBCUmFWSFCf0zQTTe
         j5HTrII0ySf0B5MAiEQzc5raXt7Su18bjx4ehUui3EMoN+hdGslXCBNDW+q53WW68tu0
         K581pnLbE/7TNPDaD9uas7Qv6BC1LricXRasSEawgDgdLtkENGESqpUkYt4npll+0Qi2
         /SlxKb4SaN1zg3sUEHFdKEaPUl2S3JCCocyq5KEgOKf417NMqnFOf/+b53PzJ2xPDIZL
         uEZyW7OFHvneKbN6IR0evA/ivTMtHZI4mdkyKOcKYicJx1zlalrG8tgjA7P/+V5IGYPA
         c8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792855831; x=1793460631;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=clD5Yd95NlWrqqaOywdVYLY9Z7mIiJbzsbMpp9u8KMw=;
        b=2f4demo0GJkkBcVICxtJzYlSuhUWNiO+yVDw90fH+T4phBfGnINcDFTIzPCH0mZL0c
         SNU8qGDKkcKYqiQhyD/kgI/G5pMPW31zlgYpxBwPvXRksQtbezHz8ztmME8MZHjXFL++
         7w68gjnludK3Zp2+MSmGNTp/2X7DU0o6mKS9W4lWBceM69M8hQOb9mVK+ta1hDtFoloe
         15RVA6iA6nDcJQHMo4VLEi1GUb5kDwayipO4QPt2OGj4xsNggrWTva91QP7RTaqKmx+e
         ERNBIi7XBV/Pjq+Mx1XVIsWZZw2xw2t7Fb0fc5W27/7OUZES+mNXNLNXpZUK3SI0+De1
         4h3Q==
X-Forwarded-Encrypted: i=1; AKwUvBztZ92qVViByxmIfN0eTmob2tIVjOnakoC0IQYrlAvfohWBskzUhm91I3rDonh4v2PiUoY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIxbZ2WcYMj5Xuw6cEiC/CDYAidpKAbLGBh7CeaCMpHekvqTdmV
	oCiFEAd+734l8y2hgLA7Aj6b08hi1KS6vDJKRHn8DL5ED8iUdoQENvqc5eIWngvNkQbd/65EmDn
	EZKGCrOl4UbBjNketW5VFCdjs8jt+m2M=
X-Gm-Gg: AYBFou0Ktw1DOz7ykWDfup86ZpZYKhCHTxJVM1irrA/KJKPhQ0fp3Y7aOpmlE1CG2LR
	tzUDFvGnR94N84SLJo8SWabLYjmAtloJAUYO0kXRA0fgHHtxcUhl1Ktq7bT11UabpnfqzQmikLf
	bQEsQ6NyRsWo6w5fkOiB2O014BK1VFLO3JkPiSK95ZVmZMhkL4rMwMVBJ+RnXsx6YIQ2FyDpHIb
	IMy0uiyg2vQuEDK7zTvDunyzRHQ/GW7wTZWtylopmSFt39KCa7oqdZFu1XQJK48vx7dAW6mKlc8
	AhpF8rAJmmHQPXHzAyVmiaUV1xhTwZI0bjglyL3YFa9Ad1t3LLQqWs8l2Gi3sZesZCLCIZGDPO0
	FH+I28q+lE352+rTx/iZGcqmWxDUhJAvQR8iRqjKDyLVSxVBIF2KeK78/yrKcsoVAJFpIFlggdq
	FCmjwz3enoB5t4zqtwNGh+mQ/CzHhUdDPRhKG69Wn6EQsy7CXCtccV
X-Received: by 2002:a17:902:ecc6:b0:2e4:9fbe:f72 with SMTP id
 d9443c01a7336-2ea9c923837mr19585875ad.44.1792855831233; Sat, 24 Oct 2026
 08:30:31 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <a8561fb7c2da446e7f7acc7e2a443991@donquinleone.com>
 <CALnO6CAsCvJRywkw0WpO1nEhL+yU2-r_4Z2AHdJch1m=NK8=TA@mail.gmail.com>
 <CAHwyqnWi3MCvAw-sNrn6k3ht1tpUfmNg18BAvEThKthen5Dwmw@mail.gmail.com>
 <CALnO6CAxzo5gxpWkfjtvskTVjmWWD4oFE2QKyFMMo7JZUCkBmg@mail.gmail.com> <CAHwyqnVV86Satk=_on=oG6ZVnSF5GdUWmpP0_wE74HRKGpKfSg@mail.gmail.com>
In-Reply-To: <CAHwyqnVV86Satk=_on=oG6ZVnSF5GdUWmpP0_wE74HRKGpKfSg@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 24 Oct 2026 11:30:19 -0400
X-Gm-Features: AclHuK-qMh5pMptzSD8g3yKnutvdANtwo1A0Y0MyhMCWvyLuf0Rk5LmvUd_ZFrM
Message-ID: <CALnO6CCCHAG5UZi5w3znr5Uiruk8RvF2QZYu+QcVRzenyesu-w@mail.gmail.com>
Subject: Re: [RFC] branch: delete gone-upstream branches only when proven
 merged into a named ref
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: DonQuinleone <don@donquinleone.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 24, 2026 at 10:52=E2=80=AFAM Harald Nordgren
<haraldnordgren@gmail.com> wrote:
>
> > > But what we can and should do is to make git itself clearer, so they
> > > have a chance of intuiting it. I think for example that
> > >
> > >     push.default=3Dcurrent
> > >
> > > should likely be the default.
> >
> > IIUC, the last change in this area was controversial. I worry that
> > changes here now would have to get through "scar tissue" (both of Git
> > contributors *and* users). At any rate, it would probably want to be a
> > major version release, and I understand it's probably too late to
> > discuss flipping that in 3.0?
>
> Would be interesting to switch to "current" as default for 3.0.
>
> But I don't know all the history there. "Simple" does feel like a
> compromise in that it's not really good for anyone :)

I can certainly agree it doesn't seem that way to me! OTOH, it's being
used by presumably most of our users today=E2=80=A6 so=E2=80=A6 "good" is p=
erhaps a
matter of how you define it ;)

You and I see "good" as "helping folks take advantage of all Git has
to offer", while some of our users are content "as simple as possible
without learning more that lets me get the job done." Neither is
better than the other, so even if I too wish push.default=3Dsimple were
not the default, I can't say it isn't good for anyone :/

> > > And many people would have a better time with
> > >
> > >     branch.autosetupmerge=3Dinherit
> > >
> > > which gives you upstream/master as @{u} from the beginning, and then
> > > you likely never abandon that if you are a regular GitHub user.
> >
> > Hm. Since I mostly do
> >
> >     git switch -c topic origin
>
> Me too (or it least I used to before I started experimenting with
> inherit) although for currying purposes I always spell it
>
>     git switch origin -c topic
>
> since I want to have the most variable part last, so e.g. "git sw..."
> auto-completes by pressing the up key in zsh to give me almost the
> right thing and I can just erase and re-fill the last part of the
> command. (This whole paragraph is a complete side-note.)

Continuing the tangent, then, that's now "git help cli" describes Git
working, and one day someone might make things stricter and break you
;)

> > or similar, I'm ok with the default (=3Dtrue). With inherit, the primar=
y
> > help is to folks who do
> >
> >     git switch -c topic main
> >
> > or something, right? But the documentation doesn't say what happens
> > when inherit is used with a remote-tracking branch as a starting point
> > (which has no upstream to copy from).
>
> It's simpler than that, since you can skip the "main" part, which by
> the way I don't think is well understood by regular users.

Ah, I also didn't understand that. But that only works if (a) you're
already on a branch whose upstream is main, a reasonable assumption,
and (b) you don't care if you have to type "git reset --hard
@{upstream}" afterwards, right? If I am on some topic branch that's
ahead of upstream, then my new branch is at the same commit, which is
not usually what I want. In some projects and workflows that's a
reasonable thing to do, though!

One advantage for me of specifying origin or w/e is that I get to
start with a clean slate/known good starting point, since the reset
happens automatically.

--=20
D. Ben Knoble
