Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793907737;
	b=K43W5+UHWefiLM185jNnc1RawDgmKkkjMeqVXIU/uJ6pt6KbmexwkIerM3SypxFhYihu
	 qTK8UYd+aYFTIFQPutkAWmCbRlDv8RFpe0qj/7svy1Ux6dVsIuqpPGElGmMxPz6gdeNWM
	 AIPvvsyDIbLIuZiIiu9qWt44xPC61Dk61U83VTCkK9CPlSw26A85prdf3mFpyFISLLDM1
	 DwI59SNrwLk+AgeHsgOM2k7cCTdzeTcz1DnLf2rFdcvBRx817ugrc+Px26W04XGVuCnRS
	 vECrUj4pFKTEHf1QyUD26q7HIcOC6HP6rXkVO4MqetCOTtxvvv93HCrLq2Z4OOHiZ6g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907737;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Vj/o2UH4DrzLJBTI3x/RnZeNQDKlle0fo1AOXdyRB5w=;
	b=lD2syokwGUk0IoujatIYz2X8V/k4RPsXv15InviN9WRa559rXXCOLyQ1dXuS07aN7Hrj
	 REEpzXNOWcknKRDSqzbmjQesXCRIRLGtceViSthQFHegCKf+u4RPKC4JuJw5BcU3GVPr/
	 UkpA5GvhK2ZANbdpD6aqqkKmYxPfjVhbPJ9Afh8xSOeOaDIaLtMbCthVBvxUZf0WI9Fj2
	 F8BMyi67OudjLRZPArZKS4SxcqvpMIKpSA4OdtOL/Anu0Nzl5TcHyO3iJTxhdZQ97yOcJ
	 nvPLnHlD14qNwgJGYUXMopKV3HomQrybHQcPmGsUmjYMwVoa5olf5XkFRMZo14oEOJg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YQe1F2cT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.49
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BC2606A33A
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 19:42:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7BC2606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YQe1F2cT
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-7d06ecaf709so1219664137.1
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 11:42:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793907735; cv=none;
        d=google.com; s=arc-20260327;
        b=etx4iasjY6P3nVJF4rcBKBa/JFljMra5qbeKnGA160P/2N6gDrtSwBiqcVgADW7JCr
         ItCdKV2FYOdWBONSxkpKI/TT/qU9W/9XlwaPsG/9yQgy7vUzpHiWLj6TTAPXcFZS5dJw
         o8e/VB07QvbtXeCYkBncQvD/hZGZV8IpytAjwzUrZqNRVoAfG8ke1CWf697pV2lklRX2
         IjJHFbckST59bE2lX7o7f9yb/0V+0XzMxtaFj+JkrEDELdvEXlAkIqyozRryKwbwC+Ss
         lIAUS5kXYpnVCkvL/zMZ3kkmv6PIh0c3mts613ihtN+tIgSNYDE0Y0VpL2ecc3uFJOjZ
         NJoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Vj/o2UH4DrzLJBTI3x/RnZeNQDKlle0fo1AOXdyRB5w=;
        fh=oTqOgLCFqaxKzggvcHWRoGGQZTP5AgfaOx7rGU36fEY=;
        b=fOY4Ves0z/T4CIoWRVaffvwtu77dQQY6dt5TxiAISR4BbFgd9G8dL52k35tU2KycR5
         weW7A6lT0KQgi8Xp7gXxmkzASUQI9Wlf0tcdUfYSjAU6M+oY2VRJSCj3ajpWCE6WhmZT
         me8MAE6iOiI21Tw/iORrawgDObPyjcotxkfL3iLdEzyCTGSj9DLG1jgM7LhnZh8BNQb4
         BO7yKYCCjEYDO+AakKxbzTnoAfG1CbaFAbo3RWyT6YxlYUSg98i+JIgXnoRY+D8qK50n
         Y5KgFtIvikkHJox9N86NPzhtdX3TrPtOhNxbV1k+eJh3InoXqUah31zQTE/3vnD7dwt8
         c0gQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793907735; x=1794512535; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vj/o2UH4DrzLJBTI3x/RnZeNQDKlle0fo1AOXdyRB5w=;
        b=YQe1F2cTCoC0THL70ulaCgQuikTnv5IaTlvPuk+vK9YOwvrmsx8oRoyRGvJG5GWIkp
         A63HBfzZJbrGRgLmznCWEUpwWmhA+me3I8VvDCSJ+BxKcoQihmYrPXv60nKHHVuyzi5v
         UJov3DAGZucoXf5f3pRwigz17NkakEBJN0Xk6nCc7llU8NZjJbTk/cfMUuZa2CToyKw2
         sTIPSa5R7DhL2Nar2vrIER+UA/A0F+Ngi6x7kEEDqAt8eNYCH5snmbuaMO47Czl55fX+
         VnC/d2JOPYSLpDUrV4nXitIGEx6gJd31+gQnXkqhtFf03QpBULGdKHd0yn6JZQmhW0HA
         N1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793907735; x=1794512535;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vj/o2UH4DrzLJBTI3x/RnZeNQDKlle0fo1AOXdyRB5w=;
        b=PFvA2GxSUTOcJFjm/02SKkeanAj5fLDt7NYO5Xkxn87tu6raE6hX0lwIapzBDoxN/+
         9mTf7wT9/2tAKALXdafjYv9WopeqpAiWv6cWPZzzNlY8qleFMjN2KRVFaslsb1jivSRU
         yE+4WZeFOuDPOkB1tHR/8+Ixqlvk7WCyd3MtabJUoOhReBVIpBoUMyfXFFReaWj6sPeE
         Jz3JoozB2+RzTcEBPpkffc0LrL4ae+nJeTpBcMwtwDrqlmHOWD+6speQURmtEtN+8AUt
         PIM15pebd8ckBgNgMee7wSYS/E4c9Wv8ZsSr2mL8C/j2ZIEBpkFSrygX7NClOmnaA0dw
         0wlw==
X-Gm-Message-State: APuU4Z+Ab9es/ejfCJ1Nk+tdZ5tZmWlWtWXZIkfETzDA561Q9uVPVTB6
	VAjgRJKoHWbXG2UXvpmXTJNewJ/wbSVjYvc9a8WwSSiDYxFqGW4wcGHsYGIL0DNIPmcx6dbLVUD
	STgBekbMs1pO1TtEjohQUIfhq8617Qe4=
X-Gm-Gg: AYBFou2BdAMv0ITKZzUEPLKnpljyh/SurTtAnJSTThvnTvvLswwaPzKd1MqomiiYkFs
	h0S0efr9dvDhg0Qy63NuDGkewI0KrgAm0rFAmQbl/MxpWTcW2FamLiX1TzDawaXyZWVhvWhDFgk
	JTdwy0o+lKOpkcJQecvzgLhNvRaNACfxj+qZTcwwx+j9x6zJmoCfWVAnvEbM0mO+ke3NLhXDjwv
	iz21M95dpgni/9h6sR/OYuiXBIo8ikd+85Oq4hvFQaogWOe0+CxPtvLzcHiGzB4n+LLqmJTddYW
	NJ6KxsJTYdVVyKVIQeuQgmSWn8Ru42/vf+/+KyZsHk9QOOnJzcWdIzn4p3lDRHCcadoWmOaWiAd
	Z9sVJgfV8zrFxXpaQSr138cVkqy1Tk8C5zMnRSzTj/RfblCLaqvmQ9zGh9owfS08PLPAFXhTeEv
	6iuJy/da0nyYMFzsMtEV3vMwo56nF7ohAHE5eP9sc6C+KUiw==
X-Received: by 2002:a67:e118:0:b0:7cc:1b19:9258 with SMTP id
 ada2fe7eead31-7d2a12f2c6amr463105137.3.1793907735407; Thu, 05 Nov 2026
 11:42:15 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CANHmUQTDpwW7N7axexos32PxvPBPB10NFSpM1bUiKAbk3SMSyw@mail.gmail.com>
 <CANHmUQSBs=Mq1Y1GTY6P9FtyCQz58bDWFgJPgwv4r5rLP3C1Bg@mail.gmail.com>
 <CANHmUQSZqXtqXsiDQs+1unGcyEuaPhaF8__E_Cy4fWNqxapY5A@mail.gmail.com> <b818b1ed-5034-4588-8d48-64b7f9efa764@gmail.com>
In-Reply-To: <b818b1ed-5034-4588-8d48-64b7f9efa764@gmail.com>
From: Shashank S <shashu8660@gmail.com>
Date: Fri, 6 Nov 2026 01:12:03 +0530
X-Gm-Features: AclHuK81pA5uePEtzwJObQ8gb9Q6S_TfI_iiV6TZeg9_hMmJzx8Fd1pLJJoTojE
Message-ID: <CANHmUQTnOkunfkSiDS4uVQHxKHvGruG=F7__Wed75QDt9pF-Jw@mail.gmail.com>
Subject: Re: [Outreachy] Project Proposal [v2] : Implement promisor remote
 fetch ordering
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>, 
	Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Nov 2026 at 21:53, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:

Hi Kaartic,

Thank you for the detailed review. I appreciate the questions; they
made me realize that I had repeated the task list too closely instead
of showing my own reasoning and technical judgment.



> > 3.  prune-packed: remove USE_THE_REPOSITORY_VARIABLE
> >     Status: Reviewed and marked ready for integration by Patrick Steinh=
ardt.
>
> I think the appropriate status per What's cooking is "Will merge to maste=
r".
>
> I'm not sure why you removed the link to the mailing list patch. You
> could keep it.
>

> > 4.  test-chmtime: use parse_options() to parse command-line flags
> >     Status: v2 submitted.
>
> Ditto.
>
Thank you. I will use =E2=80=9CWill merge to master=E2=80=9D for the prune-=
packed
series and restore the mailing-list link. I will also restore the
mailing-list link for my test-chmtime series and state its current
review status precisely

> > Internship Plan and 13-Week Timeline
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > The internship runs from 7 December 2026 to 8 March 2027.
> >
> > Weeks 1=E2=80=932 (Dec 7 =E2=80=93 Dec 20): Phase 1 - Visibility and Ba=
seline
>
> I'm a little unsure if this needs 2 weeks...
>
I initially allocated two weeks because I expected that making the
current behavior observable in tests=E2=80=94potentially through Trace2 or =
a
test helper=E2=80=94would require substantial setup. I agree that this shou=
ld
not be treated as two weeks of isolated work. I will aim to establish
the baseline and send any small documentation or test patch early in
the first week, while reserving the remaining time for review, active
upstream changes, and the initial design/RFC discussion. The tests are
important as a safety net for subsequent refactoring, but their scope
should remain focused on the existing behavior.

> > - Goal: Document and lock in Git's current behavior to act as a safety =
net.
> > - Tasks: Submit a docs-only upstream patch defining the current
> > fallback rules (accepted before configured, extensions.partialClone
> > last, fallback on failure). Develop automated tests utilizing
> > GIT_TRACE2 to definitively lock in and prove the current sequential
> > fetch order.
> >
> > Weeks 3=E2=80=935 (Dec 21 =E2=80=93 Jan 10): Phase 2 - Client-Side Orde=
ring
> > - Goal: Implement local configuration for promisor remote priorities.
> > - Tasks: Introduce the promisor.fetchOrder configuration list. A list
> > is preferred over per-remote integers as it composes cleanly across
> > config files.
>
> I think choosing between list vs. per-remote is not in scope of this
> application. It is better done in a separate RFC in the mailing either
> as a small patch or as a discussion that covers pros and cons of either.
>
> Also, I think you do intend to send this change to the list during this
> week but it may be worth mentioning that explicitly for clarity.

I completely agree. My proposal wrongly treated promisor.fetchOrder as
a chosen design. I will not pre-select a list over numeric per-remote
priorities. Instead my first step will be to begin an RFC on the
mailing list to compare the two approaches. the discussion will cover
configuration layering, duplicate or unknown remote names, unlisted
remotes, interactions with "accepted" remotes, and whether explicit
local configuration may override the current extensions.partialClone
fallback rule.

after reaching an agreement, I will send an initial implementation
series early in the client-side phase rather than waiting until the
end.



> > - Tasks: Draft an RFC proposing the protocol v2 explicit priority=3D<n>
> > fields. Implement server-side advertisement gated by a new
> > promisor.sendFields configuration.
>
> It is a bit interesting that just drafting the RFC is covered in this
> phase and not discussing this on the list (like how it is mentioned
> below). May be you intend to but haven't communicated it clearly?
>
> Also, isn't `promisor.sendFields` already exist? Do you mean to say a
> new field that the server sends when the promisor-remote is advertised?
>

Yes, I intended to discuss the RFC on the list, but I did not
communicate that clearly. I will correct the timeline so that the
protocol RFC and mailing-list discussions happen before and during
implementation.

You are also correct that promisor.sendFields already exists. I had
misunderstood the phrase =E2=80=9CServer advertises it, gated by
promisor.sendFields=E2=80=9D: =E2=80=9Cit=E2=80=9D refers to the proposed o=
rdering
information, not to promisor.sendFields itself. The work would not
introduce that configuration variable. Subject to agreement on the
RFC, it would use the existing promisor-remote mechanism to support an
ordering-related field that a server can advertise, together with the
required protocol documentation, validation, tests, and
backward-compatible handling of unknown fields.

> > Implement the client-side parser,
> > strictly adhering to the "ignore unknown fields" rule to maintain
> > backward compatibility.
> >
> > Weeks 10=E2=80=9312 (Feb 8 =E2=80=93 Feb 28): Phase 4 - Upstreaming & P=
recedence
> > - Goal: Secure mailing list approval and resolve precedence rules.
> > - Tasks: Settle precedence conflicts (Recommendation: local client
> > config maintains absolute authority, while the server's advertised
> > order sorts unranked remotes). Split Phase 2 and Phase 3 into a clean,
> > reviewable patch series. Route through at least two rounds of mailing
> > list review.
> >
> > Week 13 (Mar 1 =E2=80=93 Mar 8): Polish & Stretch Goals
> > - Goal: Finalize documentation and explore dynamic caching.
> > - Tasks: Write final release notes and user-facing documentation.
> > Stretch Goal: Implement runtime memory of failed remotes within a
> > single process to skip them on subsequent lazy fetches to reduce
> > latency. Submit final Outreachy report.
> >
>
> To be honest, this plans seems mostly reiterating the "tasks" section of
> the project. I would love to see you dive a bit more deeply into the
> nuances with your own judgement. While discussion is necessary to
> achieve consensus, knowing your thought process helps us understand how
> much you've understood about the project.
>
> Also, it may be worth mentioning what kinds of potential difficulties
> you expect while implementing the plan? What open questions do you
> expect to settle in the RFC discussions? etc
>
This is great feedback. In my revision, I will focus on the questions
that drive the design rather than repeating the project phases.

My current understanding is that Git has deterministic baseline
behavior but no separately user-configurable priority mechanism:
accepted remotes are tried before other configured remotes, configured
remotes follow configuration order, and the extensions.partialClone
remote is moved to the end.

The important open questions I expect to settle on the list are:

- Whether a list or numeric priorities compose more predictably across
configuration files.
-The behavior for duplicated, unknown, and unlisted remote names.
- Whether accepted remotes retain priority over a client=E2=80=99s locally
specified order.
- Whether extensions.partialClone must always remain last.
- whether server preference can order only remotes without a local
ranking, or if it can override local policy.
- whether advertised ordering data should be stored after the operation.

The main implementation risk is preserving the current two-pass
behavior for accepted and unaccepted remotes while introducing an
ordering mechanism. The protocol risk is defining a field that older
clients safely ignore and that malformed values cannot make fatal. I
will include these judgments and risks in the revised proposal.

> > Availability
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > I can commit 40 hours a week to the project during the internship. I
> > am based in India (IST, UTC+5:30) and can adjust my hours for
> > synchronous calls, pair programming, and mailing list reviews to
> > overlap with my mentors' timezones.
> >
>
> That's good. If you have any other commitments like exams / planned
> vacation etc., kindly share them upfront.
>

I will add my confirmed availability and disclose any known exams,
travel, or other commitments

Since sending the previous proposal, I have also completed further
Phase 0 work. I built Git from source and ran the relevant test
scripts: t5710-promisor-remote-capability.sh passed all 33 tests, and
t0410-partial-clone.sh passed its 39 reported tests. I then built a
local blob:none playground with origin, cache-a, and cache-b promisor
remotes. Trace2 showed Git fetching a missing blob from cache-a before
origin when extensions.partialClone=3Dorigin was set. In a separate run,
I intentionally made cache-a unavailable and observed Git cleanly fall
back to cache-b. I will state carefully that my manual test verifies
configured-remote ordering and fallback; the accepted-remotes rule is
being studied separately through t5710, protocol documentation, and
promisor-remote.c.

Thank you again for your guidance. I will post a revised proposal
shortly that reflects these corrections and explains the design
questions, risks, and mailing-list discussion plan more clearly.

Shashank S Mogaveera
