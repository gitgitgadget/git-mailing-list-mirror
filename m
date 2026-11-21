Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795269707;
	b=qteMUPLvABAuKm4KcN3NBJ0tMwXWrWstKdJ4bbMXf3mrRi4+Bj7GnHxAgX5ILU2p+mzV
	 E/nl42nFpmolVfw7UB+pmZkYszsxCLn5Nf2Facd/rpvUM573UPbqrZaSGD75lAANrjrgy
	 P6RU5bmL58VufQwJejMXbuLkcNQs7zi0sr9LP4kHttZoqfNtouFdwTWIzImOFbSJfkFFn
	 J4qfCyFTr9GxkbuEMFTd8gNXpQv2qQwAykxi05hqbMHDJScujZiKAhCYvV6p2Mlf7jK95
	 RGkY1xyOfs02RhNi/L/phzIBEqM/Ipel0C/9vI2nM25O9Y+njyw4CSCNlw4roYoDxlQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795269707;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=aUpAALCORlS2PYCDj7tAyQaUCcWZuzb/AmbCOxjRoUI=;
	b=qPf7ql3mugAN0y+Qd4xM6OHZZqp5rZVb9xDz+1jpInsM4rPU52XRjPY/mUj4AP/CMTS9
	 t6QglfGi5iIEvzBxwPW7ClRtNHDdfIOp2Pc+bXYDvzAEyonZFZgSbOIohQpXJ9rDZ5vDN
	 /afWCPiMHB/JKtbBLOqgpDooLnfKDw6fIiWkGvEdQGaRe+fxSaW7C18Np1I5sbCPLUtdS
	 b+gTazsYw9iVAZfbW1WoewjAWMSyBM7VutbJIcVetDUNRDKH746u/ING1kQMim1cWgMzs
	 ygycJmM3l1M/bfPC//Tq2PEe73Vw8MTqsVkOz+Szm/QTMku9Ny/7fTgZYaUxn2s9acw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YvurMDbr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DEB606A330
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 14:01:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79DEB606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YvurMDbr
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2f048476ab9so11969675ad.0
        for <git@vger.kernel.org>; Sat, 21 Nov 2026 06:01:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795269706; cv=none;
        d=google.com; s=arc-20260327;
        b=jjqAUZtqDMfnK1+RMo9DTuGlO9YnCfiOH8f4MQeDYKDnoHBxjA76E6toMV8T89ciIN
         owlGGPIVFEXD7UFiuAf9T7FTg9hy3RrEO8eQPWmF/xC3DIdv9EqzLkFwg2LmuKeEFy96
         IHRA6UWTf37L5U3JKHkpmMJjv1nOQtxP0fLi1Z52PPjPdOL6LQXRYkPFyZoyOW0/9JeT
         WJXzxO4Lr1syhd0ygMa7TYy78B9cTq62S8GfriWC06aieu1sgaQQlrVw3Kr2xwH2Y+DS
         pCH3xBoAG0Kn3UKaCuWMLOrGvo3lyjeBR3XV5bzcoqHtySs/TsJq+GMVvjLybKD4GGzD
         GT9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=aUpAALCORlS2PYCDj7tAyQaUCcWZuzb/AmbCOxjRoUI=;
        fh=UWhsyynGaklnja/LJItJYSfbVKtcFOjUNSfReackNqc=;
        b=BU9aAWWbRt5zlBpXGVxHpowwpz+plZgW8CM2NfPSWJzSdVcNKACPpIrQk6jkRTrCHZ
         tcGfBqOPUuhoNtdLs+qkxXEGKlXPoOthT9yOvl2kiFX7FsLWcwFjFjBSx4QZ7B3hPMU8
         7Kpcymvaz0A6BRSUInxJolGWLoxS/Z80YfczfJ/cgeoDzcayx5nM6DuQ7YDmDu6lLZo9
         v+Xjr+7FVsuz2Q3dzuuBKS0GLjoIT5RTbDpHdM626/brCDR8SP7xUhntL4TEVg8jGzDy
         5zBK6wOFEc/3BPFFDIVrhtMQrVZ/25Dopt1AmfA1zRcklEePEB5q3o5ABQGMefv/Xlnl
         yIgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795269706; x=1795874506; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aUpAALCORlS2PYCDj7tAyQaUCcWZuzb/AmbCOxjRoUI=;
        b=YvurMDbruo3eXy6Agc4uAQ6Yiuj/XR2Y+U5M1N+iklCoL9luTLZ/s54ksTpIBM30kX
         M+0NgFg09njIAdPDaxNXmdWUgJHWedbNRgoD4r8a5QemJYKw2SezePw/vJKrIf27DL6n
         tmBDumbiYbmVE+gOLpFNYsO1YF8+4yVERgsLVcc5aNLhzD6SW8I4n06NimdWpmTv+hBe
         D8cj5Zz6frPJti5YHCSrUzo+guwD42N8OskmhQoWe06ExT012Mo7t+DxthusRWZ+NK2K
         WmbQS5Mq+gskzIP6HLec5poN2q3Gv7uFxFoW/BdaXIWqrKRw8T5quleagkGBGSLqC28C
         Ts8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795269706; x=1795874506;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aUpAALCORlS2PYCDj7tAyQaUCcWZuzb/AmbCOxjRoUI=;
        b=mmzzWqaTYW+nlCxvAQR/Jm/728Np9kf3tFP7vhugdrxzfc6KJFOyfi9ecsE60DkWLr
         NkiBuprLOLnfdWKmXpQu4U3IFKC7ha6Sfvc2QRx3ney/y7hsTuWbjo5D3Osn7bsqpJa0
         QIb6Zj3BlpzCs3DXAI2zpr22mKmtM7UelI+7nZYlfRag9a8AMoGoMEALBSPSVeHJgxBA
         HxaoL/ovu5Xe2zBhSQ6WAJOmMBRXqppK+hXHYa4TnhQammIgCkkEO/zn8gtJT+fi6cuS
         ZfpVa7T5P/6SmlnTpm5XAYtPXKyvUO9bq71bTHDbEsHI34KFc501hsmWaOSuEL9poYtM
         goiQ==
X-Gm-Message-State: APuU4Z8IlR7J/ilGh1A9WKse3UfMnD6eSQIozDIduKOdjCxmE02tgytM
	i42QP1ZWwJYjp+HfAsax6Zp/Fwc4upPAUOWsfEqagu2tsREf1Gfc12QBD7npWNZiyDGxVVd3e1m
	oU7e/U5pgRQQ3lXd0g+vdjol0DJ9PJzM=
X-Gm-Gg: AZFdTZflhwSMJb06vHLlmmvDE28RPX/IWfnRrD7DP1de1j45B70tSqAjMVUpW50zzCm
	kZPTqEDgfL2ycF0MIMxcmmZgZhS6L1goP3jsiO4OloAsXpox16p7oBQejPHOqt3D3Q1EjEKnlfC
	TldaytVLT3MwqQpStvxOFePUqUnzP8ZH/hAK56K+zC5YOCact/3q60MuIBF66SeoQu0bD4JvdZ0
	qicfupqqj0XTU4br6rabEDA0OW2C+sjVfVCyacysGn2mfgBfcyg8BZaRSRUgisa86ojRqAxYZWo
	PNIjmV60/MkMmlzhLdfjZAQvaPXgM5TqDFtgQf0wMT4pHXZqCK6Ovs4tBf/pwiWZC/UIHBUyU7S
	hRJ9k7NmyLyRQXAmbuOEFSi+mYXLuD1QM2w+KWJF2T/8o4evA3iBEJbTzZlcssOd7a7pJadM=
X-Received: by 2002:a17:903:298c:b0:2ed:3f47:9699 with SMTP id
 d9443c01a7336-2f03f14a43emr66441815ad.38.1795269705358; Sat, 21 Nov 2026
 06:01:45 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109113515.198671-1-husainsitamuwala21@gmail.com>
 <a7ea1ac5-bb63-4bd1-b3b8-a6c36d675988@gmail.com> <CANRKfoASdPus9ODkdAqCY+zF7gOh7-paunZf1ze0TFGM1z9kfQ@mail.gmail.com>
In-Reply-To: <CANRKfoASdPus9ODkdAqCY+zF7gOh7-paunZf1ze0TFGM1z9kfQ@mail.gmail.com>
From: Hussain Sitamouwala <husainsitamuwala21@gmail.com>
Date: Sat, 21 Nov 2026 19:31:33 +0530
X-Gm-Features: Aa3M54ql1BJ-7Q5-m28p2ktEbXXd07jDNTQvD0Ev8hfY5rF0bQk83eG6Ne6Y12c
Message-ID: <CANRKfoDjkYSiX4eM0Le1DenAP-=rfJ_QfQUgT=sB=phP6jT7eQ@mail.gmail.com>
Subject: Re: [Outreachy] Proposal draft v1: Implement promisor remote fetch ordering
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi team,

This is the second draft of my proposal for "Implement promisor
remote fetch ordering" for the December 2026 Outreachy round. Thank
you, Kaartic, for the feedback on v1. I would appreciate more
feedback, especially on the config shape (6.1), the precedence rule
(6.4), the protocol field (7) and the timeline (12).

In short
--------
When a partial clone has several promisor remotes, Git chooses which
one to ask for a missing object by a fixed rule that neither the user
nor the server can change. I will (1) lock today's order in tests,
(2) add a local way to set it, and (3) let a server advertise a
preferred order through the existing "promisor-remote" capability,
with a stated precedence rule, defensive parsing of untrusted input
and proof that nothing changes unless someone opts in. The design
goes to the list in week 2 because it needs the longest review.

Summary of deliverables
-----------------------
 D1. A way to observe the fetch order in tests, and tests that lock
     in today's behaviour.
 D2. A local setting that orders promisor remotes.
 D3. A server-advertised priority with documented precedence.
 D4. Documentation updated; the "order cannot be set" limitation
     removed.
 D5. A final report listing what remains.

1. About me and logistics
-------------------------
Name:     Hussain Sitamouwala
Email:    husainsitamuwala21@gmail.com
GitHub:   https://github.com/CodeWithHusain
Blog:     https://husain-git-blog.vercel.app/
Location: Mumbai, India (IST, UTC+5:30)

I have read the Outreachy eligibility rules and I meet them.

I learned C through CS50 and use it with C++ on Linux (WSL). I build
Git from source, and I send and revise patches with git send-email,
threading versions with --in-reply-to and answering every review
comment before sending the next version. I also wrote a Python
network vulnerability scanner on top of Nmap, where I learned to
treat anything that arrives over a network as hostile until checked.
That habit matters here, because a server-advertised fetch order is
data the client does not control.

2. My Git work
--------------
Patch 1: doc: describe promisor remote fetch order (v1 to v3)
  Thread: https://lore.kernel.org/git/20261108195518.943-1-husainsitamuwala21@gmail.com/t/#u
  What it does: documents that remotes accepted from a server's
  advertisement are tried before other promisor remotes. This is the
  exact behaviour the project will make configurable, so I had to read
  the fetch path before writing it.
  Review: Junio reviewed v3 ("This iteration looks good. Will
  queue.") and asked Christian for an Ack.
  Status: merged to 'next' on 2026-11-12; Junio's note says it will
  merge to 'master'.

Patch 2: check-ref-format: use parse-options API (v1, v2)
  Cover letter:
https://lore.kernel.org/git/pull.2470.git.git.1793298807397.gitgitgadget@gmail.com/
  PR: https://github.com/git/git/pull/2470
  What it does: replaces a hand-written option loop with
  parse_options(). The commit message states the behaviour changes.
  Status: under review (v2); waiting for feedback before v3.

Experiments I ran:
  - A partial clone with three local promisor remotes, reading the
    order of the "git fetch <remote>" subprocesses from
    GIT_TRACE2_EVENT
  - Read t5710 and t0410 and ran them: 40 out of 40 tests pass

How this relates to the project: patch 1 documents the behaviour I
will change, and patch 2 shows I can take a change that alters
behaviour through review: state the change openly, keep it small,
rework after comments.

3. How it works today (checked against master at 6200d284e9, 2026-11-08)
-------------------------------------------------------------------------
 - promisor_remote_get_direct() calls lazy_fetch_objects(), which
   calls try_promisor_remotes() twice: first with accepted_only=true,
   then with accepted_only=false.
 - Within each pass, remotes come in config-file order, and the
   extensions.partialClone remote comes last.
 - Protocol: each advertised remote is a list of fields. "name" and
   "url" come first and are mandatory; optional fields follow in any
   order (today partialCloneFilter and token). Unknown fields are
   ignored. The server sends what promisor.sendFields lists, the
   client validates with promisor.checkFields and can save with
   promisor.storeFields into remote.<name>.<field>.
 - The partial-clone technical documentation lists as a limitation
   that the order cannot be set except by position in the config
   file.

Worked example of today's behaviour (config order A, B, C; C is
extensions.partialClone; the server advertised B):

   pass 1 (accepted only):   B
   pass 2 (the rest):        A, then C

I will confirm this with the trace experiment in section 2 before
building on it.

4. Problem
----------
A user cannot say "try the cheap mirror first and the expensive
origin last", and a server operator who knows which remote is
cheapest or nearest cannot tell clients. The existing rules are only
partly documented and not fully covered by tests, so any change risks
altering them silently.

5. Goals and acceptance criteria
--------------------------------
Each goal belongs to the deliverable of the same number above (G1 to
D1, and so on). The goals describe outcomes only. How G2 and G3 are
built (config shape, protocol field) is open; sections 6 and 7 are
my current proposal for discussion.

 G1 (D1) Done when: a test can observe the order in which promisor
    remotes are tried, and tests for accepted-first, partialClone-last
    and fallback-on-failure pass on unmodified master.
 G2 (D2) Done when: a user can set the order locally, in the
    documented way, and with nothing set every G1 test passes
    unchanged.
 G3 (D3) Done when: a server can advertise an order, a client that
    opts in uses it under the documented precedence, and every
    malformed or hostile case in section 8 is tested.
 G4 (D4) Done when: the limitation is removed, the new settings and
    protocol field are documented, and the docs build.

6. Design
---------
6.1 Local setting: three candidate shapes

 Shape A: remote.<name>.priority (integer, lower first)
   + each remote is overridable per config file scope
   + no dangling names
   - order is spread over several keys; harder to read at a glance
   - a value stored from the server would land in the same key as
     the user's own value unless stored separately (see 6.4)
 Shape B: promisor.fetchOrder (one list of names)
   + reads well and is easy to explain
   - the last config file that sets it replaces it whole
   - needs a rule for names that do not exist
   - a server value cannot be stored into one key per remote
 Shape C: remote.<name>.fetchPosition or a named group
   + explicit
   - adds a new concept for little gain

My proposal is A, with stable sorting so that equal or unset
priorities keep today's relative order. Another contributor has a
public patch for shape B. I do not want to duplicate
it or compete with it. In week 2 I will send a short trade-off note
and implement whichever shape the maintainers prefer. Section 9
explains how the plan adapts.

6.2 Semantics, with proposed defaults to settle on the list
 - Accepted remotes stay in the first pass, as documented. Priority
   orders remotes within each pass. I will ask whether an explicit
   local priority should be able to override accepted-first.
 - Remotes without a priority go after prioritized ones, in today's
   order. The extensions.partialClone remote stays last among them.
 - A bad local value is a clear config error. A bad advertised value
   is ignored.

Worked example with the proposal (priorities: A=20, B unset, C unset,
D=10; the server advertised B and D):

   pass 1 (accepted only):   D(10), B(unset)
   pass 2 (the rest):        A(20), C(partialClone, unset)

6.3 Algorithm sketch (the refactor patch)
 1. Collect the candidate remotes for the pass.
 2. Sort with a stable comparison: prioritized remotes by ascending
    value, then unprioritized remotes in today's order; the
    partialClone remote last among the unprioritized.
 3. Try them in that order, as today, falling back on failure.
 With no priorities set, step 2 must produce exactly today's order.
 That equivalence is what the G1 tests check.

6.4 Precedence, and where a server-supplied value lives
 With Shape A there is a conflict to solve: storeFields writes a
 server value into remote.<name>.<field>, so a stored value could
 overwrite or be mistaken for the one the user set by hand. Open
 question for the RFC, with two candidates:
   (a) store the server's value in a separate key from the user's
       (name to be settled) and rank the two explicitly;
   (b) do not persist it, and use an advertised value only for the
       session in which it was received.
 Recommendation on precedence, whichever is chosen: the user's own
 value wins outright, and the server's value orders only remotes
 with no local setting. Operators who pay for bandwidth may prefer
 the opposite. I will put both arguments on the list. In every case
 storeFields must never overwrite a priority the user already set.

7. Server advertisement (protocol)
----------------------------------
An optional field, tentatively "priority=<n>". I prefer it to
"advertisement order is preference order" because it survives any
reordering of the list and, since unknown fields are already ignored,
old clients are unaffected. Because storeFields writes
remote.<name>.<field>, the field's name decides the key it is stored
under, so the RFC may choose a different name from the local
setting. I will write the protocol wording first, as an RFC.

 Server: sends the field only if promisor.sendFields includes it,
   taking the value from the local setting. An earlier review noted
   that one global sendFields is inflexible for per-remote values.
   I will check whether per-remote gating is needed.
 Client: parses defensively (malformed values ignored; the remote is
   accepted or rejected on its other fields) and saves the value only
   if promisor.storeFields includes it. A client that does nothing
   never follows a server's order.
 Compatibility: old client with new server, new client with old
   server, and a value outside the supported range all behave as
   "no priority". I will cover this in the RFC too.

8. Threat model
---------------
An advertised priority comes from a server the client may not trust.

 Input                      Attack or failure       Expected result
 -------------------------  ----------------------  -----------------
 priority=abc               non-numeric             ignored
 priority= (empty)          empty value             ignored
 priority=99999999999999    integer overflow        ignored, no crash
 priority twice             duplicate field         field ignored
                                                    (proposed)
 priority for a remote the  push an unaccepted      remote not tried;
 client rejected            remote                  no effect
 priority for a remote with local value set        local value kept
 server sends many remotes  resource use            existing limits
                                                    apply
 client without storeFields no persistence          order unchanged

Each row becomes a test. I will also avoid in-place string splitting
on lists that own their strings; I saw such a crash reported on the
competing patch.

9. If the competing patch lands first
-------------------------------------
Plan A (not merged by the start): I deliver G1, then G2 in the shape
the maintainers choose.
Plan B (in next or master): I skip G2's implementation, keep the G1
tests and the docs, and spend the time on G3, building on its config.
In both plans G1 and G3 are mine, and the G1 patches do not depend on
any design decision. I will review that patch and tell its author
what I find, because I will need to understand it well either way.

10. Testing
-----------
Follow t5710 and t0410.

Observation mechanism: first choice is a trace2 event naming each
promisor remote as it is tried (a small patch of its own). If the
maintainers prefer no new event, fall back to a test helper that
wraps the fetch and logs remote names.

Test matrix:
 Area         Cases
 -----------  ---------------------------------------------------
 Baseline     accepted before others; partialClone last; fallback
              after a failing remote
 Local        priority respected; ties keep config order; unset
              after set; bad value errors; per-scope override
 Server       value honoured when stored; ignored when not stored;
              malformed values (section 8); duplicate field
 Precedence   local beats server; storeFields does not overwrite
 Compat       old client with new server; new client with old
              server

To check that the tests really exercise the new code, I will
temporarily break each new branch on purpose and confirm that at
least one test fails. The G1 tests must pass unchanged after the
refactor.

11. Series plan
---------------
The patch numbers used in the timeline refer to this list. Patches 4
and 5 follow the design discussion on the list; their shape is not
decided here.
 1. Trace2 event or test helper to observe the order. No behaviour
    change.
 2. Tests that lock today's order. No behaviour change.
 3. Refactor so the remote list can be sorted. No behaviour change,
    proven by patch 2.
 4. Local setting for the order (shape decided after the trade-off
    note and RFC), with tests and documentation.
 5. Server field and client handling (after the protocol RFC), with
    the section 8 tests.
 6. Docs: remove the limitation, document the field.

12. Timeline (patch numbers refer to section 11)
------------------------------------------------
 Before:  Follow up on the docs patch; review the other patch; run
          the experiments in section 2.
 Wk 1:    Baseline write-up of today's order with traces.
 Wk 2:    Trade-off note AND protocol RFC to the list, so design
          review runs while I code.
 Wk 2-3:  Series patches 1 and 2 sent.
 Wk 4-5:  Patch 3 (refactor); patch 4 started.
 Wk 6:    Patch 4 finished; first review round. Milestone: G2 sent.
 Wk 7-9:  Patch 5: server field, defensive parsing, precedence.
 Wk 10:   Decide storeFields persistence; section 8 tests complete.
 Wk 11:   Final reviewable series; second review round.
          Milestone: G3 sent.
 Wk 12:   Patch 6, release notes, final report (D5).
 Stretch: Remember failed remotes within a process; measure latency
          or cost.
 Weekly:  Blog post and written update.

Ranges overlap because each series waits days for review. If I fall
behind I cut, in this order: the stretch, persistence of server
values (section 7), then the section 8 cases beyond the core ones;
local priority, the tests and the docs are protected.

13. Risks
---------
 Risk                         Mitigation
 ---------------------------  ---------------------------------------
 Surrounding code moving      Rebase often; check master before
                              writing tests; talk to the other
                              author
 Design disagreement          Raise early; keep patches 1-3 and docs
                              independent of the design
 Slow review                  Small patches; next piece in parallel
 Silent regressions           G1 lands before any change
 Scope too large              Cut order in section 12

14. Communication
-----------------
Weekly blog post, published at https://husain-git-blog.vercel.app/
and linked on the list, and a weekly written update to the mentors.
Design questions go to the list before code. I answer every review
comment before sending a new version, as Junio asked me to, and
reply within 1-2 days.

15. After the internship
------------------------
I will keep following review of anything still open and keep
contributing to the partial-clone and promisor-remote code, starting
with the stretch items.

16. References
--------------
My patches
[1] doc: describe promisor remote fetch order, v1 to v3:
    v1: https://lore.kernel.org/git/xmqq5wy89rq6.fsf@gitster.g/
    v2: https://lore.kernel.org/git/20261108071933.6586-1-husainsitamuwala21@gmail.com/
    v3: https://lore.kernel.org/git/20261108195518.943-1-husainsitamuwala21@gmail.com/
[2] Junio's review of v3 ("Will queue.") and the request for an Ack:
    https://lore.kernel.org/git/xmqqse1a1th8.fsf@gitster.g/
[3] check-ref-format: use parse-options API, cover letter and PR:
    https://lore.kernel.org/git/pull.2470.git.git.1793298807397.gitgitgadget@gmail.com/
    https://github.com/git/git/pull/2470

Code and documentation (checked at master 6200d284e9, 2026-11-08)
[4] promisor-remote.c: try_promisor_remotes() (line 282),
    lazy_fetch_objects() (line 321) with its two calls to it (lines
    351 and 353), and promisor_remote_get_direct() (line 357); the
    field lists for promisor.sendFields, checkFields and storeFields
    (lines 465-481)
[5] Documentation/config/promisor.adoc: promisor.sendFields (line
    12), promisor.checkFields (line 166), promisor.storeFields
    (line 207)
[6] Documentation/technical/partial-clone.adoc: the limitation on
    ordering (lines 229-234) and the future work item (lines
    265-271)
[7] Tests: t/t5710-promisor-remote-capability.sh and
    t/t0410-partial-clone.sh

My own material
[8] Blog: https://husain-git-blog.vercel.app/

Thanks,
Hussain
