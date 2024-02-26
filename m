Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC926DF4D
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 03:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708918356; cv=none; b=SCwuU6nWmyHodcYJsKKnwT1Ldb6LnZ8AgvH+sU7ztxcvhXqwqI7UlmMhdHhfAePcmlh35/4Q+KQVIetaH6Hi/jUyft3kMc6cQvg47XZuFihhPib05kZfkYdFjG00NafwlM7RUxt58b2oznJ15RoiOsc4MAJMsJEmz+5QfJAWcdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708918356; c=relaxed/simple;
	bh=qcydO+lTir4QZMcfyspKCilhWxcQBTvYksGirAWU4cY=;
	h=MIME-Version:From:To:In-Reply-To:Cc:Subject:Message-ID:Date:
	 Content-Type; b=cLzb6KbLBljEUy8lhmrtSV+u5fnABquazLSlO6vIGYcsxa9Aon+cGHW/ZLVFwaSOqrpGwSUi2R55Y+FD6OZWVv4dPb2Qqfpwg6uUMZBO1XO0siPn9TpSH2V5JxtDUMhnjaWeIcEFzPaew8SXivmD8j9GgTQxT/34o/lCYXVu48k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpGnRl1g; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpGnRl1g"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6900e209df4so1555626d6.0
        for <git@vger.kernel.org>; Sun, 25 Feb 2024 19:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708918353; x=1709523153; darn=vger.kernel.org;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6EIMIuETNfpGLYNkRBUZL73anykMixtsX0GuhR3SWww=;
        b=fpGnRl1gc9x7cwk03KD6vv1+bJgyx+nU9XGkJtRS5uaKcGytsPb831fYb13Y3RLyUK
         cTqbY6q3vhsBLxXDYU9Nehza8t+QYejN8gJO9i1vzadhSPeaz3rWdckKw/OxWpvvRYr4
         kC2Xu/9sYhBiY3Ze7AE9pyZo0G8xmmdiimAFUvU7jCIaUPARhhk3Cqd3XkQjJJamQ9iC
         4ER3QvaRYgu1cZzzVdvs5mCCIsXGykekq4Ci+zdi03BxqIRIUoU/gQfH3INyBez5NCaD
         X0imZFruK2FVaUNyn4TLfh8sVz3UtjCkTltN4NiC/agE5yNU2gvc316otcgol0/tib4X
         P2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708918353; x=1709523153;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6EIMIuETNfpGLYNkRBUZL73anykMixtsX0GuhR3SWww=;
        b=jyuwVyx71GarcHXVW2S+tP/g2MOBYVSgy7aESP4sbApsNf5GAIT6i+4EuLHktJgvLz
         AfZZO/bNTO20t7CimeYAdNrhZrI0HFF1430R42IWW65mEXZ1iqQUvLEVMP7fh6Kashft
         H7x5WrzXkwrQ5GwZ3EEK36B26z6JXgUNwZtbeLNpos483XGocrpSzpoyZFNr7hxF7Wal
         L4XoZ1vEPXNMD0WvIhxS/gTKuoilzPf/7oQy4A633ou6jPso6BFHzvy28T9Q0a/14hLC
         QsCl6jmD6CdtSJQmb1E3vKLQnYpzNWc7kLwwvYIJAroQr5y/kYAGIvZ30vb5P0qaN34l
         /Mnw==
X-Gm-Message-State: AOJu0YwaSDgMr2rlWtnCZk642yEl2e8BMGhBRWhYnN8tfk7GBiQ9dzpA
	5gkOtL/AH6kzHuTYlyY54mlTs4VcJVNpSFcQScb1SSKPf31mW8RMEz82oqXl
X-Google-Smtp-Source: AGHT+IHDwyA2Enbjf12HYwbPrDbjvLTYitFomwekMwTzDZ7cZEJUgikiA9S4LsQ7fzi058tbtT7hVQ==
X-Received: by 2002:a05:6214:418d:b0:68f:8927:ac6c with SMTP id ld13-20020a056214418d00b0068f8927ac6cmr8967818qvb.20.1708918353549;
        Sun, 25 Feb 2024 19:32:33 -0800 (PST)
Received: from zivdesk (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id em19-20020ad44f93000000b0068f0ff36defsm2415513qvb.47.2024.02.25.19.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:32:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Brian Lyles" <brianmlyles@gmail.com>
To: <phillip.wood@dunelm.org.uk>, <gitster@pobox.com>
In-Reply-To: <83070e02-8e6b-43d2-819d-2272fe895c75@gmail.com>
Cc: <git@vger.kernel.org>, <newren@gmail.com>, 
	<me@ttaylorr.com>
Subject: Re: [PATCH v2 8/8] cherry-pick: add `--empty` for more robust redundant
	 commit handling
Message-ID: <17b74c2ffa1884ed.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Date: Mon, 26 Feb 2024 03:32:32 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Phillip and Junio

On Sun, Feb 25, 2024 at 10:57=E2=80=AFAM <phillip.wood123@gmail.com> wrote:

> On 23/02/2024 06:58, Brian Lyles wrote:

>> I think I'm on board with leaving `--keep-redundant-commits` alone. I'm
>> on the fence about having `--empty=3Dkeep` imply `--allow-empty` after
>> seeing Junio's concerns. I laid out the options that I see in a reply to
>> patch 6/8[1] and would appreciate input there. I'll adjust the details
>> of this commit in v3 based on what we decide there.
>=20
> I'll take a look at that in the next couple of days
>
>> [1]: https://lore.kernel.org/git/17b666ca6c4b7561.70b1dd9aae081c6e.203dcd=
72f6563036@zivdesk/

I'm not quite sure what happened here, but it seems that:

- The above link is to the wrong email, and
- The email I meant to link to isn't showing up in the archive for some
  reason, despite clearly showing as sent in my mailbox

Apologies for the confusion -- I'm not sure what happened.

In an attempt to keep this conversation on track, I've copied my
original attempted reply to Phillip's[2] and Junio's[3] replies below.

[2]: https://lore.kernel.org/git/3f276e10-7b03-4480-a157-47a7648e7f19@gmail.=
com/
[3]: https://lore.kernel.org/git/xmqqwmqwcpf7.fsf@gitster.g/

On Fri, Feb 23, 2024 at 12:08=E2=80=AFAM Brian Lyles <brianmlyles@gmail.com>=
 wrote:
>
> On Thu, Feb 22, 2024 at 10:35=E2=80=AFAM Phillip Wood <phillip.wood123@gma=
il.com> wrote:
>
> > I agree that if we were starting from scratch there would be no reason
> > to tie --apply-empty and --keep-redundant-commits together but I'm not
> > sure it is worth the disruption of changing it now. We're about to add
> > empty=3Dkeep which won't imply --allow-empty for anyone who wants that
> > behavior and I still tend to think the practical effect of implying
> > --allow-empty with --keep-redundant-commits is largely beneficial as I'm
> > skeptical that users want to keep commits that become empty but not the
> > ones that started empty.
>
> I think that's fair. I am okay dropping this potentially disruptive
> change.
>
> It sounds like you are on board with `--empty=3Dkeep` not having the same
> implication?
>
> That said...
>
> On Thu, Feb 22, 2024 at 12:41=E2=80=AFPM Junio C Hamano <gitster@pobox.com=
> wrote:
>
> > I do not quite see a good reason to do the opposite, dropping
> > commits that started out as empty but keeping the ones that have
> > become empty.  Such a behaviour has additional downside that after
> > such a cherry-pick, when you cherry-pick the resulting history onto
> > yet another base, your precious "were not empty but have become so
> > during the initial cherry-pick" commits will appear as commits that
> > were empty from the start.  So I do not see much reason to allow the
> > decoupling, even with the new "empty=3Dkeep" thing that does not imply
> > "allow-empty".
>
> Junio -- can you clarify this part?
>
> > So I do not see much reason to allow the decoupling, even with the new
> > "empty=3Dkeep" thing that does not imply "allow-empty"
>
> I'm not 100% sure if you are saying that you want `--empty=3Dkeep` to
> *also* imply `--allow-empty`, or that you simply want
> `--keep-redundant-commits` to continue implying `--allow-empty`
> *despite* the new `--empty=3Dkeep` no implying the same.
>
> On the one hand, I agree with Phillip's sentiment of "if we were
> starting from scratch there would be no reason to tie --apply-empty and
> --keep-redundant-commits together" (though your points perhaps provide
> such a reason). On the other, if both `--keep-redundant-commits` and
> `--empty=3Dkeep` behave the same way, it makes sense to soft-deprecate
> `--keep-redundant-commits` as I have currently done later in this
> series. If they do not behave the same way, that deprecation makes less
> sense and we have two very similar (but not quite identical) options.
>
> Just to make sure we're on the same page, the options I see are:
>
> - (A): Neither `--keep-redundant-commits` nor `--empty=3Dkeep` imply
>   `--allow-empty`, `--keep-redundant-commits` is soft-deprecated
> - (B): Both `--keep-redundant-commits` and `--empty=3Dkeep` imply
>   `--allow-empty`, `--keep-redundant-commits` is soft-deprecated
> - (C): Both `--keep-redundant-commits` and `--empty=3Dkeep` imply
>   `--allow-empty`, `--keep-redundant-commits` is *not* soft-deprecated
>   as it is more descriptive as noted by Junio here[1]
> - (D): `--keep-redundant-commits` continues to imply `--allow-empty` but
>   `--empty=3Dkeep` does not. `--keep-redundant-commits` is *not*
>   soft-deprecated as it behaves differently.
>
> (A) represents this v2 of the patch.
>
> I'm coming around to (B) based on Junio's workflow concerns, but to be
> honest I am fine with any of these options. Junio, I *think* you're
> saying you'd prefer (B) or (C)? Phillip, it sounds like you are okay
> with (D) based on your response -- how do you feel about (B)?
>
> [1]: https://lore.kernel.org/git/xmqq8r4gnd3c.fsf@gitster.g/

Thank you both for your review and insight!

--=20
Thank you,
Brian Lyles
