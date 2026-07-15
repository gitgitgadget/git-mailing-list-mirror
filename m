Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06BA30674C
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 07:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784100857; cv=pass; b=BUAxryjrVTM2OsqtNNvKYC67HP8jHCeU+MQtt7+TyPTSk0jlAWhNkgSijuby2CUQm8nXMLwXzMP2WO7ORA69sMC0ij29qhddqVNLmzd/ZmVIbz2bTod1L5/ym0kX5ERR+bDp9Fr/p+h12YInlv/2LoE0LvlNzuxGcuAqcp6bfmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784100857; c=relaxed/simple;
	bh=nkqX/3iBc1QJchto2ToaD+90dLviy7OLoaSJcgZStb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dUJCYnu6jAelecX5lDMnTM9GybI1YfmFv74fn1ELhHUXe45CAaKYpf6Rhh5JXbzRzxP6Rbgm09BOSbXp8WB0RuV2HPt1OfySocGROYaZWQsdgEyAgaHmfa7NEKlaiSHgQAXaydMyYjEAyoT456daPxZeGuFcAxacNYh0LuvCeS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZThw5aC0; arc=pass smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZThw5aC0"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4a496b6cc3dso200444b6e.0
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 00:34:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784100854; cv=none;
        d=google.com; s=arc-20260327;
        b=A/AaQkp6kuGDhXri4sjGtNv2R7F7YZ+AFARoLygZdx6rkpdNwX4kqSbEqcWnl0eAOk
         v9AJEOAxs0bqAyelOc+ShD9IjdAJCSDT4fO4cx+Twamj1t7ypMOHEwLSkojp8wWs2zZn
         FjST3p++n1vQ+882pW2KTUDQh1d1MOy0J8D4UqMQFN5TvHdhNpbu9ayBDJeKXFf4Isp1
         NI3NXyodfkLIPj5sbXcmQjdICc0KH0Te6Ca6orA2UZAS8aHVkQTjj/6O/Xp2CN3NjXub
         JSx52frjbCX0amEY++THheJehNUPTun0/EM86UcMoCvZmrs1SHnJx3fjJykK40pK7B9B
         IKmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3RxiEP3r8smoGLg/67CggFzsOc2L6kcaTcIpDDCscDQ=;
        fh=2Dele137u37qXXeFCCIikMNeufKjrNFBHGs2HZtAyEI=;
        b=P6J655Qa9CMsAwJub+0hKIL9esW/wlRkEyRFpk7oCMhw4ZBHH3QN20vcU/6mtz06DM
         hDA57kjolcToTzDzNfqMuxDRaMgdiW1BKJQOagIBgDRmqHrwQ0HwI+s2UxJ7lELwx7Fs
         exK55HLvyTINpxF4Hq5eQIoZi+fByiT91glMncwPB0phWg+7mqoPkV9mUlfGPNosn6mw
         IERRGQugDxFi3Z3lJChXoTvLiHAn5UzDUlcqR+VgX873Ly2D8nARBOJX3Z3wn4f7AL2H
         YIiesSDOk2BtaWyr37jiHtA9hjjI7IaaSgietV2Rs4Dr6AhA4V+FV4vPOrAMl5xeRjCB
         mpQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784100854; x=1784705654; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3RxiEP3r8smoGLg/67CggFzsOc2L6kcaTcIpDDCscDQ=;
        b=ZThw5aC0wIgsLv1+nJniE7UBM4aleey6dYF7MxGqEo+K1hbXby0YSoRU+MryFE8CHm
         svOS+Th0BWMJotY+lSSGvQWZ7vdBYftmHMxQbl0EWqKqTZ/wvNmVL3zSVzXaIfFvjLyh
         f2vZj4Qmr0hv+idSbtl1Zrfxvi6t4JNcXcEI5nZo0y8lJ+eGmDIy3zkDphD45h7Np9Tp
         oI5ClA3a5ltuJSEQF/i4CzAeCR2pmbUcqjXAuqQv0dtc6TKlEf7dDw1lA4tRQtbBNrdA
         7brjl5jN12FUxEjPPakyeJfFTfK3O2IJ3G6ICarrRNI4MR8v2FLF2c159QBv3pajV98h
         QaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784100854; x=1784705654;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3RxiEP3r8smoGLg/67CggFzsOc2L6kcaTcIpDDCscDQ=;
        b=UsMUJg8Hfl0I7iJm7LNFlM+TR4YoFyGylOi5ty2OftREhkRNNpS+1mU9wdT7s45hE/
         MKY+9f3RT7vwpfVK1st7rpAJO/yLz8UHc9UcnXGreF/OELeEuemAxjN6+fK85b4/n5bK
         /jBzSWvNpRGez/5uUNJedDiCMl3h4vEUHfTweOkYbF1AT73b7126+4C91WMQXFmZzp7T
         dcVGa37LFfPLVoy5+z99xU0iQFYM3Oy9qzWM6s4KW49beIpC9URIpXo5ZTGDzNI228Ju
         Vp6tYQxS0t7qHe3yxL9VT0/7HGpVPTF5WNTr6Hb9qCz0ytzrmhs5fW+8cVWaI+8CBs2i
         m0kg==
X-Forwarded-Encrypted: i=1; AHgh+RpLEhhWc5ZyVg82bC+o+f0OWtLZIJd1jMZK7s89yYgIDtOFHkUdRcS5p7XNWbX5ZHavL20=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWxLhQrGt0VqSnrHvB3Teu1scqX7rTIsPLM5uHtEY7eKAZU6XB
	46znbHJPihrmL2uI7vya+mnE975s46wvuoCqdBiAGzp/iWU7S9APx+vPVNM4JjGQKH5bsDCg/om
	SG9ZmaNxkC/N2VXEgpvm4fzWNua2Z1y5/XSPR
X-Gm-Gg: AfdE7clBFf3KcZYDpCcSM3SXafnWuqu8T3hRqv3R7LbTsBVzL8JTEH8p+2C6GZEZDVH
	fyVrB+eTmRa/w7/hX46lC9fFg0GXw5jVOM7cWC5QGJiambdZISmH/XrkL+bane/fsD2zVap535O
	0lccGpZwjmzIbxGN7hGjewGC3af56gg9OZBwCFiDhL4LKIr7LxJUVjLFy0PbodMmo7nwGYFwrqJ
	pArf6u544it/v08aRVPM6ShxUwvnA9pegbsPZod/ta3k5Qib7zCyTfQdN61UqYCJDueq6cihEne
	YxLKtV8G7BVbLHFFyxCCwKDfE/oLUL2ZXkGHL6caOxhR1GESPPv1Sgbw4NlpDQm2zUYdlHJY+Cj
	2sd6xixeTrV6nVjc=
X-Received: by 2002:a05:6808:3083:b0:48a:bb5d:292b with SMTP id
 5614622812f47-4a47a73238cmr4004342b6e.32.1784100854452; Wed, 15 Jul 2026
 00:34:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707-toon-git-replay-drop-merges-v7-0-808ab9b4afa6@iotcl.com>
 <20260707-toon-git-replay-drop-merges-v7-3-808ab9b4afa6@iotcl.com>
 <CABPp-BGzU9KHGF1nipi2HZaa1AiikMKGGaapQzHVH06wO4V1ww@mail.gmail.com> <xmqqbjcawnhp.fsf@gitster.g>
In-Reply-To: <xmqqbjcawnhp.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 15 Jul 2026 00:34:02 -0700
X-Gm-Features: AUfX_mwHedr4EpqqYVzn0RU2tYP8iXvxrincvfaXY2Y3Bw5bwP5ZNHQh55RAJkU
Message-ID: <CABPp-BGxO0bd3UzDYNnhNUgDSKYwcFVCFsJ9rCzmNX7Q0xBrow@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] replay: offer an option to linearize the commit topology
To: Junio C Hamano <gitster@pobox.com>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 3:09=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > For what it's worth, looking back at the v5 thread, it seems the `base
> > =3D last_commit` rule came in to fix the real bug Junio and Phillip
> > pointed out there -- that without it, only one side of a linearized
> > merge survived.  That fix is clearly correct for the single-branch
> > case.  My worry is only that applying it unconditionally reintroduces
> > the multiple-positive-refs ordering problem we deliberately avoid
> > elsewhere.  Making `--linearize` reject multiple positive refs would
> > keep the merge-flattening fix while sidestepping this entirely.
> >
> >> A user
> >> who wants to linearize ranges independently is advised to use separate
> >> git-replay(1) invocations.
> >
> > Which, to me, is another argument for just disallowing multiple
> > positive refs under `--linearize`: if the recommended way to do it is
> > separate invocations anyway, we may as well require them.
>
> Hmph.  To me, this is slightly different.  It acts more like an
> escape hatch: "if you really do not want to mix unrelated things
> into a single linear history, you can do this other thing."
>
> Stepping back, the unpredictable order of multiple merged lines of
> history exists even without multiple positive refs.  If you have
> independent lines of development that were merged and you linearize
> them, someone must choose which line comes first.  If you let the
> machinery make that decision, the resulting commit order may not
> reflect your preferences.
>
> While I rarely perform octopus merges anymore, in situations where an
> octopus merge is appropriate (e.g., when you have N independent
> branches and their merge order does not matter), linearizing such
> a history into a random sequence of N segments, built on top of
> one another in an unspecified order, could actually be considered a
> feature.  You do not have to make a decision about something that is
> inconsequential.

You're right that when flattening merges within a single branch, the
machinery must pick an order, and that's fine =E2=80=94 unavoidable, even. =
 My
objection isn't that; it's primarily the concatenation of distinct
branches named on the command line into one chain, and, as a secondary
point, the ignoring of the order of branches explicitly specified by
the user on the command line.

Concretely: I have three branches to rebase onto master; one of them
happens to contain a merge I'd like flattened. I add  --linearize  for
that one merge =E2=80=94 and now all three branches are silently concatenat=
ed
into a single chain.  That makes no sense to me, and I think won't to
most users.

Anyway, I think I must have explained my position rather poorly; your
response suggests I buried my main points, so let me try to restate
them:

TL;DR version; my problems with the current implementation of
`--linearize` are that it:
  * Makes the rare usecase easy, and ignores the common usecase
  * Makes it asymmetrically difficult to recover for those that wanted
the common usecase instead of the easy
  * Makes `--linearize` mean something other than "remove non-linearity"
  * Turns multiple branches into one, but updates several branches anyway
  * Ignores order specified by the user on the command line
  * Introduces an inconsistency within git-replay between `--advance`
and `--linearize --onto`
(The last three items being minor compared to the first three.)

Longer version:

Consider the following history

M1  M2  M3  M4  M5
*---*---*---*---* <- master
    \   \
     \   \  A1  A2  A3  A4
      \   \-*---*---*---* <- branchA
       \        \
        \        -*---* <- branchC
         \        C1  C2
          \
           \-*---*---* <- branchB
            B1  B2  B3

git replay was designed to allow you to update all your branches at once.
For example, with this above history, running
    git replay --onto master branchA branchB branchC
will rebase all three branches onto master (and handles the shared portion
of history between branchA and branchC in the obvious way):

M1  M2  M3  M4  M5
*---*---*---*---* <- master
                |
                |  A1  A2  A3  A4
                |--*---*---*---* <- branchA
                |      \
                |       -*---* <- branchC
                |        C1  C2
                |
                \-*---*---* <- branchB
                  B1  B2  B3

With the current implementation of --linearize, adding that flag, i.e.
    git replay --linearize --onto master branchA branchB branchC
would instead give something like:

M1  M2  M3  M4  M5  B1  B2  B3  A1  A2  C1  C2  A3  A4
*---*---*---*---*---*---*---*---*---*---*---*---*---*
                ^           ^               ^       ^
                |           |               |       |
              master     branchB         branchC  branchA

This topology strikes me as something that users would very rarely ever
want.  Further, it:
  * Makes one question why branchB and branchC were kept instead of
    deleted; if the whole point is to concatenate the branches, then
    since whichever branch lands on top contains the other two, why not
    just get rid of the others?
  * Makes the command behave differently on *already linear* history
    when --linearize is added, which makes no sense to me.
  * (Minor point, but still confusing to me) Ignores the order of
    branches the user employed on the command line

Of course, the above involves no merges, so let's introduce one; consider
the following alternate initial history:

M1  M2  M3  M4  M5
*---*---*---*---* <- master
    |   \
    |    \  A1  A2  A4  A6  A7  A8
    |     \-*---*---*---*---*---* <- branchA
    \            \     /    \
     \            *---*      -*---* <- branchC
      \           A3  A5      C1  C2
       \
        \-*---* <- branchB
          B1  B2

Replaying the three branches,
    git replay --onto master branchA branchB branchC
we would expect the base of the branches to simply be updated to current
master:

M1  M2  M3  M4  M5
*---*---*---*---* <- master
                |
                |   A1  A2  A4  A6  A7  A8
                |---*---*---*---*---*---* <- branchA
                |        \     /    \
                |         *---*      -*---* <- branchC
                |         A3  A5      C1  C2
                |
                \-*---* <- branchB
                  B1  B2

If you were to add --linearize, i.e.
    git replay --linearize --onto master branchA branchB branchC
I personally would expect:

M1  M2  M3  M4  M5
*---*---*---*---* <- master
                |
                |   A1  A2  A4  A3  A5  A7  A8
                |---*---*---*---*---*---*---* <- branchA
                |                       \
                |                        -*---* <- branchC
                |                         C1  C2
                |
                \-*---* <- branchB
                  B1  B2

In other words, `--linearize` should remove the non-linearity in the graph.
Instead, the current implementation will return something like:

M1  M2  M3  M4  M5  A1  A2  A4  A3  A5  A7  C1  C2  B1  B2  A8
*---*---*---*---*---*---*---*---*---*---*---*---*---*---*---*
                ^                               ^       ^   ^
                |                               |       |    \
              master                         branchC branchB branchA

I can only imagine this rarely being useful to the user.

But to make it worse, please consider the difficulty of someone who
wanted the bottom graph but got the top one, vs. the difficulty of
someone who wanted the top graph but got the bottom one:
  * (wanted bottom, got top) Just rebase branchB and branchA again; easy
  * (wanted top, got bottom) You need to meticulously figure out the common
    points of history and which sets of commits belong to each branch in
    order to sequentially rebase each branch into the expected result.
In particular, the need to meticulously track start and endpoints with
individual
rebases was one of the reasons that led to `git replay` rather than improve=
ments
to `git rebase`; the latter was so focused on single branches, that it
wasn't really
possible to extend to multiple branches.  It's thus rather
disappointing to see new
flags for `git replay` that make handling multiple branches more painful.

There's actually one more (admittedly minor) issue as well: it creates
an inconsistency within git-replay itself.  The `--advance` flag has a
check to error out when multiple positive refs are specified solely
because I thought it was weird to override the order of branches the
user specified on the command line (and didn't want to implement
something that could force the ordering of the revision walk); the error
message even states "because the ordering would be ill-defined".  For
consistency, either both should be fine with ignoring the order of
revisions specified by the user, or neither should be.


So, what to do?

Both paths I have in mind end at the same place; the only real question
is whether the desired behavior lands in this series or as follow-up.

The minimal move is to make --linearize reject multiple positive refs for
now (exactly as --advance and --revert already do), unblocking this series
so it can merge down nearly as-is, and leave per-branch linearization as
future work.

The complete move is to implement that desired behavior now, by tracking a
last_commit per command-line branch so each branch is linearized
independently.

The reason I am comfortable with erroring out as a stopgap: turning an
error into working behavior later never breaks anyone, whereas letting the
current concatenation semantics reach 'master' risks users coming to
depend on them, which would make switching to the better behavior a
compatibility break.  Erroring now keeps our options open; merging as-is
quietly closes them.  (git-replay is still EXPERIMENTAL, so this is not
fatal either way, but it seems better not to paint ourselves into a
corner.)

For this series I would be perfectly happy with just the error; the
per-branch last_commit tracking can come later.
