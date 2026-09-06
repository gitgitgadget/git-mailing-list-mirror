Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E850351C2F
	for <git@vger.kernel.org>; Sun,  6 Sep 2026 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788717474; cv=pass; b=Gg8ATO77AzkeZyn0T3oqpSsnrQUUAIuFeRGL5DQL7ji/+aEb0pqo+v8NU2TEeb6JMOyi7rB7RNvJ/Y4EyFvWOh3VAiSflgFu6+hssb/D5TLYuz4QpeFRTtfs99nKsTm2o+ABkEWIs8Rz3HW+UcF2zniUaGcIRayN9YzFoqAT/64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788717474; c=relaxed/simple;
	bh=JoDFY0taeZHy1gUhBi2+xrpIp9Xse7usXUuapNNycpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eKtW29+zoHvUrIq+L7WTbA0wUL9BEnpaaM97aGuwunfoBzIG0RsT0cbJ4MzyS2yQhQTmvYUoTZt29EUeYgHLL+1S7D/z3Dou/hNcORO6uB2CQfpOms6w083oruC4qej88TvcpMbMBWDVZ3Hb6uinn/QYged5ChimwHP9iYoLM4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJSSdZxB; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJSSdZxB"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc1c3c90074so2242572a12.2
        for <git@vger.kernel.org>; Sun, 06 Sep 2026 10:57:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788717472; cv=none;
        d=google.com; s=arc-20260327;
        b=Unlufd0NExrVGSc5q/nnwCrE24HPUJe2ubgIYe8yK+jmPUJSJxcP0yxdyD4kNL76xG
         4MtZ5/DTIfjqrrN0bIPZ8aKq7Dvbe7FZuesd4ABFJ6g/UElQdj0/U9GAoVpa0OpGqUIm
         AY0gOqu+QQF6tTJNIV6+zLD4CrpL8Hh8oefJU1lSdp6XtxqITp+RwvZpp8djYulpGPXf
         UEssHfGo+Uxt038DPN0dPQvwYkcrZaG+yuiWIpMO/3g1LJskdkHnaAWJ2DRnPxkNAuxK
         wNGoCWgJHOhR5PTWu2JdM1wggoQVQg+/jDLXXvxHc+BSZ+PGYhY/9Ob1gZtvK4bdth8y
         JK2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BlYf9KRwJFPetGpNRitGfT5AmOnfCVAfVjL8Yf8y5cw=;
        fh=ok5pCOHGc7Aq9u2rLGj0YGc5NEdZnJP6tG/KRMQmPCA=;
        b=FhMzeWyO1NPA6Iny9c+3mlzkqPoIFj27tsvpYOR9NQvB5B2rt8wot3ts7v7RXKAL+2
         AUGev0tJAUgvHK3Qf7MOrdVzIHLB3X9+0J4NmfisR2HCGFarD8xgby9/FmuUHbwPtaIo
         QOW91gB8r2KQb/lp5SI69W7WyK0Eq0vcYk1NpdBVHbzn55Q3c+HLjJIJWT3pYbUCQwrd
         /H4EkM3H90xtYbVKDHpmgtxqtSScUeyOKL2DzZ9cxK8nUNxZTYnNS8vZyZyKSzIMt6Ax
         oLmXhymxQBLuW0uxizycby2VEDt5LVMCaTdxfjJBxUauUqNZeQcMFDVdY2dN7KWJMnJ3
         Eqew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788717472; x=1789322272; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BlYf9KRwJFPetGpNRitGfT5AmOnfCVAfVjL8Yf8y5cw=;
        b=ZJSSdZxBr+20nOdvt6V6OJ55hDxGg/ykzcpk1TFjLziijoKB7VcnBVdeHTqawKtDUT
         mwTkDdgbvQT0eO8xR3aoSeu8I/TINKYWKzqMs/uQyX6FKrbiHtL256oXJf1VndNrNq6J
         2XOogjf8izONa3sGHOE7HAFC6uQxrwP5d5EM+GTRKEFL35Wfhw08hrHbrpppB9NZ7u3m
         hw3LTx+VNNHcSZ/8KSbuRuPo4m4HL/KoHXv6E9pRe4+ArENzDsge2hmNYCqKbPqo13O/
         h6JAShqg42CdL7szz8B6GGsk8kUbHNeEK2GT2s5SiixeI0Z2RuUSj6VIVq2Tl2qEK78U
         YAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788717472; x=1789322272;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BlYf9KRwJFPetGpNRitGfT5AmOnfCVAfVjL8Yf8y5cw=;
        b=dhhroEk28KwSpTREJolQcB0eWplsEOoPlAIDN9SV5gpPrHWBT5g85AvwGMmsyA5HaQ
         vqw3y8SPgLvCS6lueh2VDUDVgMmxLF5l4TbSrJwWuAh235t81L9dR+jhSwZusETM+vdv
         M9uen3NbqABJvX0i0veLdM/4UochYKWIUzqEnwlnpghXCk+0tDrfK7TFkXGE5RSwramL
         NB3FNc2xZAls6WBYHRnWQcGnekAkUbA5hdaO0K/c9+f864qFoHH90PQqkvZVTAfd2jWp
         vzfgKBZkeeze8YG8KztblWdVhQiPJAxhhHIHY8957FOsRSVdkMTtrB/KWlCo4Cy2n0JD
         bqSA==
X-Forwarded-Encrypted: i=1; AKwUvBxIi475ircPoP+Hv1bcRVhVyyiSq5c9qZOC0UyexrKvFAqniPBchA2EqiFpYhU9DHO5CLY=@vger.kernel.org
X-Gm-Message-State: AFuF++kvHaTvRNHCc6sfDUbhyBQc2aKXmsLKn9t0geoYYcIYaJKMb/yw
	Xfy2Tl4vmBi/UoQeKHA0Bdo8Z7vwUl5LLB5AjlfW74s8/6sdqtXWVIG8f4Bc1V64Ic90700VQIh
	IgjOgsaJ04qoMpkxd/5VWILH9u+ehFQA=
X-Gm-Gg: AYBFou3BuiFCMQxjujLyGtM8YB7OfeX7trYsLP2Lm87mNECJmYSaPMQZuGxRRZ9Bzxg
	lxm6mKIJLxpji8u6TzRXVEyBmT3tBq7xpbPhi2hxdjN+4PS5awJMg8ZcMwulV3utqw3xK1xWGnb
	CnvrvAIHfsYhx4oLh1rHuN4kWfXlgGvjtmVL0lBQndHGS7NjRuOMXSlQG5/BoZEbzfvzb3GIyqW
	B1C9uUN8sOxO1vZaAHg0LB9yrZ+NS0eqGBaWFHXtxoqfwNsTqIvCOEHtNf52TQRTFHqQ++PPbBG
	H4fbr6zmv90zatEZRn/kWN7BtoWwAfiz2Xnq0rXhhE1T+j0wHuvR5hMRb7pIyQKCsxdrFPHzNnS
	nNDBvbJt1PheMzUn40NcaVL3xEW4JBkR377ZAx5LNm0SS92HhbaQ0Qgj4ViJNVcRhKJdo6Cw5
X-Received: by 2002:a05:6a20:5681:b0:3cd:8bba:824f with SMTP id
 adf61e73a8af0-3da39eacde1mr29952962637.4.1788717472417; Sun, 06 Sep 2026
 10:57:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz>
 <format-patch_learn_--range-diff-notes.c5a@msgid.xyz> <xmqqjypfp2vl.fsf@gitster.g>
 <16315616-097a-4fe2-8665-010e424afd8b@app.fastmail.com> <xmqqbjan6q7l.fsf@gitster.g>
 <9335a35f-e9c0-4e62-812c-e5855c201003@app.fastmail.com> <xmqqpkz24193.fsf@gitster.g>
 <b3c66de3-0ced-446f-9bd6-73412a8c92b5@app.fastmail.com> <e3b7ef75-08e6-4529-ac75-56f800d2f4a4@app.fastmail.com>
 <CALnO6CA-6m58sJCf=5_GwK3GE8=EfhzgsheWBqMQjc0r+N7+Xg@mail.gmail.com> <392dc2b3-59cf-4fd4-8c73-38a57c8d0423@app.fastmail.com>
In-Reply-To: <392dc2b3-59cf-4fd4-8c73-38a57c8d0423@app.fastmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sun, 6 Sep 2026 13:57:40 -0400
X-Gm-Features: AcwNN1X6TX3VSsqdchh7e8k97JarEnOVtcI7ynqN9NxcghpZ-RjBGpEmjrjOBwM
Message-ID: <CALnO6CDhFNozhFSM74fpGX68tGGw=eMeyJ-5K=4XVCC2Fi4AsA@mail.gmail.com>
Subject: Re: [PATCH 3/3] format-patch: learn --[no-]range-diff-notes
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 12:45=E2=80=AFPM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Sun, Sep 6, 2026, at 15:37, D. Ben Knoble wrote:
> > On Sun, Sep 6, 2026 at 3:23=E2=80=AFAM Kristoffer Haugsbakk
> >> >[snip]
> >> > That this wasn=E2=80=99t clear is the fault of the doc here.
> >>
> >> Seeing as how the doc was unclear and did not spell out how you can
> >> build two separate list of notes, here=E2=80=99s a draft of a rewrite:
> >>
> >>     `--range-diff-notes[=3D<ref>]`::
> >>     `--no-range-diff-notes`::
> >>             Used with `--range-diff`, tweak what notes to display in t=
he
> >>             range diff.
> >>     +
> >>     The default behavior is to display the same notes in the range dif=
f as
> >>     on the patches; see `--notes`. But you can use these options to us=
e a
> >>     different list of notes. For example, say you have given three not=
es
> >>     refs to `--notes`. At this point those same three notes will be
> >>     displayed in the range diff. But then you pass
> >>     `--range-diff-notes=3D<ref>`. Now the range diff will only display
> >>     _<ref>_. You can of course pass more refs to this option, just lik=
e
> >>     `--notes`. And you can also turn off all notes with
> >>     `--no-range-diff-notes`.
> >>     +
> >>     You may want to turn off this notes override behavior after it has=
 been
> >
> > [nit: should we call this "no notes" override behavior? Otherwise I
> > think we are referring to --range-diff-notes=3D<ref> overriding
> > --notes=3D=E2=80=A6]
>
> (I will shorten `range-diff` to `RD` for semi-brevity)
>
> What I mean here by =E2=80=9Cnotes override behavior=E2=80=9D is turning =
off all
> `--[no-]RD-notes` options. It means turning off `--RD-notes` as well as
> `--no-RD-notes`. And without the override you are back to the default
> behavior where `--notes` dictates the notes for the range diff.
>
> So that the utility is a bit more clear than these unmotivated examples,
> here=E2=80=99s an example alias (with forced linebreaks):
>
>     my-fp =3D format-patch --notes=3Dreview --notes=3Dtesting
>         --notes=3Dattribution --notes=3Dchangelog
>         --range-diff-notes=3Dchangelog
>
> The patches will have four notes while the range diff will have one.
>
> But you may want to disregard that last `--RD-notes` and in turn get all
> of the notes in the range diff. But without repeating yourself. Then you
> can do this:
>
>     my-fp --no-range-diff-notes --range-diff-notes
>
> The option (the negation) is not sufficient since it would turn off all
> range diff notes. But this special meaning of `--RD-notes` allows you to
> go back to just regular `--notes` behavior. That `--RD-notes` has a
> special meaning when the list of range diff notes is empty does not lose
> anything since `--range-diff-notes` would just be a no=C3=B6p otherwise.[=
1]

Aha! I _did_ misunderstand, then :) I thought this example in the
proposal was for the case where "my-fp" has "--no-RD-notes" and we
wanted to re-add them with "--RD-notes".

Heh, definitely a bit confusing, but spelled out it makes sense.

> But I should point out in this doc that bare `--RD-notes` does not use
> the default notes.
>
> Of course, there could be a dedicated option to turn these options off.

I thought about that, as well, after re-absorbing the examples. I'm
not sure what to call it, though. "disable-RD-notes" is a mouthful and
doesn't seem to have precedence from my (spotty!) memory of various
subcommands.

> Or to just not support it. ;)
>
> (my standard verbosity level might not be doing me any favors
> on this point.)
>
> ***
>
> That might seem like a lot of =E2=80=9Cpower=E2=80=9D for something as ni=
che as
> overriding-then-reverting patch contra range diff notes. But code
> wise I don=E2=80=99t think the price is high... :)

Reading from the sidelines, it seems we have often gotten ourselves in
trouble because the code was easy and too easily reflected in the user
interface. OTOH, I'm not sure what else to do here ;)

> =E2=80=A0 1: I just tested the behavior of `--notes` (no arg) on
>      `format-patch`. Yes, it does respect the default notes ref just
>      like git-log(1) does. So an alternative would be to have
>      `--RD-notes` do the same.
>
>      But I do not think some convenient default notes ref is good for a
>      command which is supposed to generate patches for email
>      sendout. For `log` you can make convenient notes to yourself and
>      conveniently display them. But `format-patch` should demand more
>      intentionality. (I also wrote about this on a bugfix for
>      `format-patch` behavior some years ago.)[2]
> =E2=80=A0 2: I suspect there is a bug-looking like behavior in that
>      `format-patch` seems to use `notes.displayRef` for the default
>      notes (not just /refs/notes/commits). It should just respect
>      `format.notes`, I think. But I can look at that later.

Huh, interesting. "git help format-patch" says format.notes turns on
"--notes", so I would guess without looking further that it is a
boolean.

Yet "git help config" says it can provide a ref.

So, yeah, I would expect format-patch should use format.notes over
notes.displayRef.

> > A bit long, but easy to follow and understand the interactions, I
> > think. The examples are helpful.
>
> Thanks. I noticed the lines kept creeping up, but it is more involved
> than most options; an option for passing on to another command which
> also overrides the behavior of another option.

The price of flexibility ;)

> Thanks for taking a look at this niche topic. Though I see that you are
> one of the dozen of us[3] who use Git notes on his submissions. ;)
>
> =F0=9F=94=97 3: https://lore.kernel.org/git/CV_format-patch_learn_--range=
-diff-notes.c57@msgid.xyz/T/#m6a7cbbe0fc456e7e62125d903b706ae5a547315b

<3

--=20
D. Ben Knoble
