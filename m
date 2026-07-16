Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1A9280318
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 03:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784174048; cv=pass; b=lDQCzzyz+DzZZ5yf/cBMNKLp3GCnc2cSzj25sX+1fVMFXiJ6f558udbX8cWGsjk03PpVmLn7gidF40d9bbdE5k2irY8+LSarAP3fZ+FFQphCAKumJuovnd3a/QlG8adTcceXujObKYiNKVaUdqPto0eGzd/Uxo27soLCM8J+8lE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784174048; c=relaxed/simple;
	bh=NRuYJZygf7WI12KnKJ+kA+lAkpseROd48t8IslUt8F0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NuvKpGFRFIKOlGUjKte4gekopiZu5oWKBqvA89u8bfk6oV8yO23ldWQuvDwcen/0/YSf9dfg4QlbjHrtjfDArrY71WESPGgjxQfWdKOmbuXsoMaWX6h8mq06nLL2CiZ9HbvAz5kK+Yg1qEWvoDFVuZnggIVBtw35AestKYfMoY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ld8u/Vp4; arc=pass smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ld8u/Vp4"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-497e6956acfso164533b6e.1
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 20:54:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784174046; cv=none;
        d=google.com; s=arc-20260327;
        b=jWg/zfhq64dSjrK2T6w+uWrgnuYqyB0DYg3ZfMkD2l9I6rWcFiKoxavx+K4l28ukR/
         PhY0pAI0QxgE+l+OyRoAO8Me0UC1K7VQe86lLCvNWFD8d+T5xd+rbC9cnhkxfB5I36tW
         rDWRvm3ycG5WEFTugS/77RHHCeI0i1iLWqF2FX9nk3rX/igQB3NCN8+eH3U90rtQg0XC
         M1A1NQF1lkfUvjawV6y1/JmlFPAPhqag4e0R85GGX/izBsqW3jZ/UpToeoMIstJbnOR/
         v6BOyTfFKrJNuyE9J1OB6dS5HJhIGiSJjl3B2YNFaIQ6/qCXsAWEXwLtwxm2Zh6Su8R2
         eNGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JpL5ua7lVKbAISwOjk5f+UxqOuQG8nURc7AqAxlk0aM=;
        fh=r2NXz3giMgv0B+ZmD7kvqRNh28ihlJDhrJRewyxPZqI=;
        b=Q90AS0wx0gTj/7NtTSMYzuZzjJ67+pb2+jxTd6iFrCGlK0fsP49CecjD6z5x5U/ChU
         I4dbQPOSv6vU7auZ0HCLIV7lFeWYlTRricGknzKur82X8kfwsDgNrVPQLIa+VsIjqd7g
         2+xv2XoMzC1BhJGW/JKxko99/VVQb6hSf1Ono18BMFeA3dAYg9bNn/Aijw3WNFS+lMF9
         dKWG0ey8gPYnNlLQB9RLzSvgsnggrA9+BH9NnWH0zcM/aXJntLf308P/2kZ3LTXEbqNf
         vKPzVnNrtFESds75mGxsQI7DZqMhYdXocoSVL0p4D5sp+iY+hetJl9OSPbnmMaaucEc1
         VDSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784174046; x=1784778846; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JpL5ua7lVKbAISwOjk5f+UxqOuQG8nURc7AqAxlk0aM=;
        b=ld8u/Vp4xNkGjUYxsSrZDDHIDllBEHAC9TxDPd2Bh2W1WcqdaRLEPKSZt5cdhB/7Tq
         1GPYEaKWlAUlbZEQ3TkCH24z7WXjZ4K0p8jVhO7eDFeWC6GKM8zpk/6am91wtD/rvDAp
         8HQDrT3L3eecobH4eaHwwQlsctQ//FjMcK+6AP55tudboZHJQs1MMUHt2acsaTbKlrSB
         RJAyZl/8x8mjCaFUzYvYNa0lFXXD7oCncUwHXHrnxRuFN8WiDxIbOhfxbxhXbsvbEmiQ
         N3BXmLMn+FZOTenYUVo4KyusvgAlr87QTw9+IfDTERnYU8LALBtTYRYSWnS0SeDWEIm3
         S1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784174046; x=1784778846;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JpL5ua7lVKbAISwOjk5f+UxqOuQG8nURc7AqAxlk0aM=;
        b=ebk1mK/gnf1MLTRZ21/4jet0nDOBvqCVFjZBB7Re5osQNg57HCYvZcstumU/hknuCD
         /ZBX5R4SuEP4EC2Y0wJh9g0i0lUGPLhh0WhLeE802kemGIxqjXmPmOZAGbaJVxvO5TM1
         YhC3vmrhEOTs2pC+l3rrgrB6GQweS9ua47kmHAQHfhZBaaP7+dUmNwvYkbYPbBK9B/rw
         ZotbBGYSPnDQjNcTA8h91fTQAcroUmw8MQZ8Y2S756bhhLn4IojfFZgeug+owbVmknAI
         kDOuhc0eTUfcVOLK45KwCdGD+2plUlg4LmPNlRTVZi3BX5fsAzuQkKwvzzNIV0yxAcxQ
         nP8Q==
X-Forwarded-Encrypted: i=1; AHgh+RrqqLOZcNTeCSZ3XNbmyPPe+tqnbUHVJNbU/cd5TXQ6MaVlWXllADFsnz6tbFkPl0SBvdk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Qw4WauSNLycm7RFq6eMM5mq1eNFtMlQaI6m4A06AlrOtAESj
	IaJN74N4XWcCPztrKSs4VXhSBRzrRDrcsIZ4V46vrpYBN5TCU2cettUBdkOuUtefa5p7/2V5PGv
	hBhokTK/eCejP1M4MH3avbQhVJFuU/BA=
X-Gm-Gg: AfdE7clWE5UqZplO637iOP6O19nMllyE4wUTlizUUP9QLlUmhHcaKlmFGV701WZcFAR
	QmRQqimoLA58yLQd1loV7HzEm1GRFVJ4Q//Y8+IJU1eBetv6/s2ZmER77GdLuHlF9rfpETVDidf
	WfzaqxDm4xDzCjFZeRJLFEBmorY0ET9keH+50xUcwMMHbHyyslBlm4vtkmGy+Ch8pnzjsypMuUf
	5vInRrRUoDuZ6j4QxA2UXX01f41/dIag+Smi1bmIPjfrndxaJbMoSB3sQ/CNYr5UCzHXJkhKO2E
	R5zcR6TNdF2bi+LznWze5QtoDc/6xTDW95QEBGAryJN1iyvR4kHXM+8F9JE/2vNsJvzso0STj5s
	pLpWg
X-Received: by 2002:a05:6808:4fcb:b0:495:fd92:841f with SMTP id
 5614622812f47-4a4b236b435mr711225b6e.23.1784174046155; Wed, 15 Jul 2026
 20:54:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707-toon-git-replay-drop-merges-v7-0-808ab9b4afa6@iotcl.com>
 <20260707-toon-git-replay-drop-merges-v7-3-808ab9b4afa6@iotcl.com>
 <CABPp-BGzU9KHGF1nipi2HZaa1AiikMKGGaapQzHVH06wO4V1ww@mail.gmail.com>
 <xmqqbjcawnhp.fsf@gitster.g> <CABPp-BGxO0bd3UzDYNnhNUgDSKYwcFVCFsJ9rCzmNX7Q0xBrow@mail.gmail.com>
 <xmqqse5km6lc.fsf@gitster.g>
In-Reply-To: <xmqqse5km6lc.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 15 Jul 2026 20:53:54 -0700
X-Gm-Features: AUfX_mxwmqlbh2F18kz22SFkAAUXB1iQdrhxYXcJQaJXGt5GLZ5WE5gzYHFEz4Q
Message-ID: <CABPp-BGdK8v8Qk5XB=QL_yJDPTNjSb2rN08GiPpK50V2gAj1QQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] replay: offer an option to linearize the commit topology
To: Junio C Hamano <gitster@pobox.com>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 11:49=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Concretely: I have three branches to rebase onto master; one of them
> > happens to contain a merge I'd like flattened. I add  --linearize  for
> > that one merge =E2=80=94 and now all three branches are silently concat=
enated
> > into a single chain.  That makes no sense to me, and I think won't to
> > most users.
>
> But if that is not the outcome they wanted, I fail to see why they
> would feed all three branches to a single invocation of --linearize
> in the first place.  After all, the command is only doing what it
> was asked to do.

Passing several branches isn't the user asking for concatenation; it's
the user asking for replay's core feature: update many branches at
once. Adding --linearize  to flatten a merge does have to join the
lines which that merge combined, but it shouldn't also weld together
branches that were never merged in the first place.  The user is
combining two intended features, and the concatenation is an emergent
third behavior that neither of them implies.

(Also, please note that I'm aware of the bug you raised earlier about
dropped lines of history; my suggestion(s) don't reintroduce that
bug.)

> If that breaks because by the time you feed branchC to the machinery
> nobody remembers that A1 and A2 were already handled, _that_ is the
> problem the command needs to solve, no?  I am confused.

Yes, precisely!  That is the problem I want to be able to solve:
updating multiple branches which may have shared history.  The current
proposed behavior feels hostile towards that.  Concretely, I want to
be able to update this history:

M1  M2  M3  M4  M5
*---*---*---*---* <- main
    |   \
    |    \  A1  A2  A4  A6  A7  A8
    |     \-*---*---*---*---*---* <- branchA
    \            \     /    \
     \            *---*      -*---* <- branchC
      \           A3  A5      C1  C2
       \
        \-*---* <- branchB
          B1  B2

via `git replay --linearize --onto main branchA branchB branchC` to
(depending on where A4 is ordered relative to A3 & A5):

M1  M2  M3  M4  M5
*---*---*---*---* <- main
                |
                |   A1  A2  A4  A3  A5  A7  A8
                |---*---*---*---*---*---*---* <- branchA
                |                       \
                |                        -*---* <- branchC
                |                         C1  C2
                |
                \-*---* <- branchB
                  B1  B2

(note that both branchA and branchC become linear with the merge
commit A6 being dropped)

In this graph:
  * branchA and branchC cannot easily be replayed with separate
commands (it requires tracking starting and stopping points and
figuring out shared history).
  * branchB could be done with a separate command from replaying the
other two, but _only if_ the user first verifies that it has no common
history with the other branches, and I think that's not useful
cognitive load to place on the user.

If concatenation really is the intended behavior for this patch
series, then --linearize  seems like the wrong name for it: the
surprising part isn't that each branch becomes linear, it's that the
option also chains together branches that were never related.

> Or do you want to be able to tell "linearlize B, A, and C in this
> turn on top of 'master'" and M1..M5..B1'..B3'..A1'..A4'..C1'..C2' as
> the result?

No, ordered-concatenation is not something I'm interested in.  I want
separate branches to stay separate, as in the second graph above.  I
almost wish I hadn't even mentioned ordering, even though I labelled
it a "minor" point in my last email, because it seems to have
distracted from the real issue.

As I proposed last time, I'd be fine with erroring on multiple
positive refs as an interim step (plus associated documentation and
commit message updates) so this series lands, with per-branch
linearization as the real fix later.
