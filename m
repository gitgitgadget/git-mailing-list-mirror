Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E411F03EF
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 22:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818980; cv=none; b=VRW3NQBpjxNpfCT/tWMOwDwxmuDUo+AePzKSbZXqWfFUhxKbmVdjbdtYaOmjBcA3JtoX2Z77C4l87kgm12ZPim/XDVfxmiaM0xOSPYIbyQ0P9VZKm0/kn7VefsnD1u0pRjE+aP/Ne6NXvceu53q2V7t3exQHJXj0OWiwo1xpClE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818980; c=relaxed/simple;
	bh=DagoZDQjknERo+BQ/S0k9468NNAYkDCLRIRq7Cj+8Yo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oYOde5Umqs2v+C31h5Fz3Yf7c6T0muU4ztRIUhl3pw9yuLN947ktEmA+jQOijStEmgE8zIjUiRDPjDD8q17Fj+isCwpWpfAMVAp0JbE0DAJPFbd38vBziuvWMTifJRxq+Ep0F7HQmb7C/Km4llKMBfnJCSsqbtf+3TAL5c8/O60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnUdJfiW; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnUdJfiW"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-85b3f92c8f8so23262139f.1
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 15:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741818978; x=1742423778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rjy1RPDw6hS3v6Yf0tD+xPWz0n/xZnVy/jNkoi9GhW4=;
        b=bnUdJfiW4l33vbcol1qYiv+HGOHuip+rsd9cu6JNWGOO7MUB2P1oE6s0LLs824aWHB
         pe3t5LkzzuORg2ANJtuOnl9HSCcfntSlxcCf8X5dicsfVP3qoi9a3Ndun9NXsrUzdwEn
         hZBKNi19azidA9DwMIY9os9c9+Xll9nbUDsJ4mVDLjH5Ymab4uz0TQfDRBPlyqLS8Dgg
         LuK8UF6p+5TlJi+/freODTq06XlTwa2kfxGBbPmQwpqEJtPSxGwZ/GDz8d2t7TqZeQNN
         DuqpqGdfSYm9MqiB7olJATr5mNfoZt1uTWmKiOyosw6LgPViS/kMg0CgO29cCyRTEvEq
         ZuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741818978; x=1742423778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rjy1RPDw6hS3v6Yf0tD+xPWz0n/xZnVy/jNkoi9GhW4=;
        b=dEUddwzWgKuy3BOxOgLpDTzOwU3bN3iaLi2AutWS4Nm/AGgEuLlFEtL26Z7xxtk7iN
         rN5jfPQR1iFvboJcfPsESC7IyMSorjPYMF35uCEpdtZiIVI9YXemq3W3Mx9Z2ibzLMFp
         wRPyTH3YgJB2/U308T8W+N9JzGiFO4Eqk47uVd4sd4R+dLEsqm46NETTd+R+jVwcpb5a
         BpAgfW2SiGNhWovbIDUO4I/BjfP7v4SLN6hQiPMZDl0ibHugghWXRMGQrIJNOV+CFFfq
         q13NmoVJbsK8yi8C7uiaAYd0zFewgoSd/AYcL0IEY4YvzPfcIq/uL3Mn861QC91rRimo
         zECw==
X-Forwarded-Encrypted: i=1; AJvYcCWqIolWVTaNf/IjSHkmXwruLpb1HyGGUee8kBrkZmiPEE7DScxY0W+PVUPmGRVk/fXzEJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoilRSx6ZC3gfl9UuJu2hjO4LGrg4gfO+ozVTaRcQR2jrHzFVt
	igagxVDmJ4LiMZhrDOSTG2W9Q1Aa8p/8vG2PsH0HHIslPCtCAMDCXByP9uQQw9Qe22jaXFAloHs
	/TQM8UQcYKf/+XET4Gs2ceJmHfVs=
X-Gm-Gg: ASbGncuFxPAuGtLj16iwPeW9EHl08H8z8qNvLJlZauu/DAMVhI5jVTKf683Y5GvXdxS
	LPtw2zmJXma3M8DIam8AEMD4hWcDnBBdm8VKFRbFQ7QMWwm9JGxoHoEotdt0b+HuspdutRMCOwb
	7ryw4pcb8rztl2bhfCJW/t6WpE7b63ZcWT3I0cYHYj+5aKMdMqPerr5tHVruYHhv1Nopx34w==
X-Google-Smtp-Source: AGHT+IExKDTfJ6cKDCcF9lq+Fwn24ZWzTo/MMVGsGQ6yUaXfRdvI/1O7JU4/Z/ABI5nwtXlS9r5lqqu3vK41m6T7MwM=
X-Received: by 2002:a05:6602:3819:b0:85b:43a3:66b2 with SMTP id
 ca18e2360f4ac-85d8e2234c6mr1145100739f.7.1741818978264; Wed, 12 Mar 2025
 15:36:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1873.git.1741275027.gitgitgadget@gmail.com>
 <f48b3310d4ae8d05780fd25e467083c4dc9852cc.1741275027.git.gitgitgadget@gmail.com>
 <Z9ID/2zx25qesuJs@nand.local>
In-Reply-To: <Z9ID/2zx25qesuJs@nand.local>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 12 Mar 2025 15:36:07 -0700
X-Gm-Features: AQ5f1Jq28Lgy4SuyPb1j8CvH5q3sSStYtLl3uUeHcHlYaT_0g0rmAmCrtk-TjMc
Message-ID: <CABPp-BH+9JcP6FDP6RFQzZbwW=XOWnWAR8PmrCS6hG4iyd2pPQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] merge-ort: fix slightly overzealous assertion for rename-to-self
To: Taylor Blau <me@ttaylorr.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Dmitry Goncharov <dgoncharov@users.sf.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 3:00=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Thu, Mar 06, 2025 at 03:30:27PM +0000, Elijah Newren via GitGitGadget =
wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > merge-ort has a number of sanity checks on the file it is processing in
> > process_renames().  One of these sanity checks was slightly overzealous
> > because it indirectly assumed that a renamed file always ended up at a
> > different path than where it started.  That is normally an entirely fai=
r
> > assumption, but directory rename detection can make things interesting.
> >
> > As a quick refresher, if one side of history renames directory A/ -> B/=
,
> > and the other side of history adds new files to A/, then directory
> > rename detection notices and suggests moving those new files to B/.  A
> > similar thing is done for paths renamed into A/, causing them to be
> > transitively renamed into B/.  But, if the file originally came from B/=
,
> > then this can end up causing a file to be renamed back to itself.
> >
> > It turns out the rest of the code following this assertion handled the
> > case fine; the assertion was just an extra sanity check, not a rigid
> > precondition.  Therefore, simply adjust the assertion to pass under thi=
s
> > special case as well.
>
> Wow, that is a very interesting edge case from Dmitry. The explanation
> and fix makes sense, and yeah, looks like just an over-zealous
> assertion.
>
> As a meta-comment, I vaguely remember past discussions on the list about
> when to assert() versus when to BUG(). I recall that where we landed was
> that:
>
>     if (foo)
>         BUG("something");
>
> was preferable to:
>
>     assert(foo);

I disagree that we landed on that; at least the last time it was
brought up to me there was no ending statement of such --
https://lore.kernel.org/git/CABPp-BFLyYTboiGkP=3Dsc7S+stRZvozAqnJPnza+M0q2n=
akvD2Q@mail.gmail.com/,
and then I proceeded to continue submitting and getting merged several
more assert statements.

If there was a project-wide directive to remove assert() statements,
then I'd quickly create something else (e.g. "BUG_ON(foo)") and
convert to that rather than "if (foo) BUG(bar)".  And I'd probably
make it depend on NDEBUG too...

> I know that we don't usually define NDEBUG, but I think there are a
> couple of cases where we do, like for nedmalloc stuff when building with
> USE_NED_ALLOCATOR, and in Windows builds if DEBUG is undefined.

If the statement is important to have in production builds, I have
used "if (foo) BUG(bar)", including in merge-ort.c.  But I think there
are different classes of notes-for-other-developers.  Code comments
for the lightest end, if (foo) BUG (bar) for the heavier end, and
assertions for somewhere in the middle.  I think I've used a higher
density of checks in merge-ort than tend to be used elsewhere, in part
because of the number of optimizations added to the code and the
difficulty of keeping track of all the preconditions and assumptions
with the extra data structures feeding those.  Lots of those checks
might have just been code comments somewhere else; they aren't
necessarily worth a real if-check.  They'd be fine to compile out
generally.  In some cases, they might go to the full "if (foo)
BUG(bar)", but I think there's a reasonable middle ground.  assert()
statements survive and are kept up-to-date better than a code comment,
they tend to be clearer than a code comment, and they catch more bugs
while refactoring (or originally developing the code) than code
comments.  And they are much more brief and ergonomic than the "if
(foo) BUG(bar)" construct (why do I have to come up with a separate
bar, when it's already embedded in foo?)

> So I don't think it makes a huge practical difference, but it might be
> nice to put in CodingGuidelines or similar.

Maybe I should put something in there so I don't have to look up the
old conversations and point out my disagreements with this suggestion
yet again...  ;-)

But it might be worth mentioning that having side-effects in
assertions is a huge no-no, and I understand that when folks have to
debug one of those (I had to in a separate project years ago which was
kind of nasty), that they sometimes jump to the conclusion that
assertions are bad.  I understand being bitten, but disagree with the
conclusion.
