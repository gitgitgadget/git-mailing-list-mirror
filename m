Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794224133;
	b=n4m5yBLPii3CodZj7X27+kZBV5mIB1EZ3dVPYFeRARH6hKWOZxjSsO6p71dh2ThY32Qy
	 poEMu+zm87bAOuR+wBshSRxcOtmqjHHU5+U5cSp5IMTmXsrjFhUuYB7Nc7U3BKhHxywNy
	 NynumNJRCyVlpHhzCwbEWjyEVfDi9AQl/Gi7ZvpbRd7iiTmp2pc68Knv4xfkEyBrbtxb3
	 amPcd+H22i/1g0K6DZGNLbhO2qwF1BkpnGJfihMLO0EHbP1sfzSb0SbNSgjcOhC/lxCaO
	 lbl0kb51rsW4fQeWWtZzi4sBBFmKiUDkpRGM/08qFOq60vMe5qzdDL8CsgcJ955iayA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794224133;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GIlBuqOny1gGEKxlNw/Qwq40A5Pe8GUQM0b3PZ+rkt8=;
	b=ppgerGYECezX6FBCl1iMRFrhuMG0MaUG6qK3udKIjKBW+s9hD7zqShv+m9NgPPe679Wz
	 1EEWY048TBWRhEx/gaK5JNd2UIENWTahtwtDkIjO3OoXxvyuLFeNWkHJA1tvlCSAdpJMa
	 QXSM/jdJKzKUiLRz1hNZDlpgB/XjR7eu9F7o3qqrPMlYVBmdJ0nxb51rETT1l7hmoP2Z5
	 1Cu7NDaAdmzrQNEy0C8Niv5N30u92NHJ+CpYYYgHwW8ZuBxUB5uNGqLwlRcwfwHgWqgfS
	 jA6PWL/Bixj+1UnOv0rOlEldribI2CHKXGve0I/zIGYQ80betFhHls+Draq6O5ptVvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zIPUVQ4W;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D99606A322
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 11:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77D99606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zIPUVQ4W
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-37071c0f42aso1462922eec.0
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 03:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794224131; x=1794828931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GIlBuqOny1gGEKxlNw/Qwq40A5Pe8GUQM0b3PZ+rkt8=;
        b=zIPUVQ4WH/oOprlVJH4jD+WQGDywF/+L2dnZcG91OiCXTHko5ruaNbY/wNrSneinD2
         7vgUTlWfpZFZkz0fwuQorlaIn+gOKcdbxxZXbqo0VXctieYqg0QMlDb+S4RkmHIIqUaH
         FD16rOUkWHvuwK9xX+cGgh8mLKLz+9bZHWvzf7b+MDNZLWpRlHhgAfkqH/jWXu8g/VTd
         LiP1PfKFn5E+okhZrFVeIDGimp200RDIjHYWLGz7b/KC4cOSZLM1sMUCM0qtrHJXhQSg
         vtRFUvlzxAv6Ku1Mk5+pQrmWVdnb+1nYWxB3h4VHF+okQ3wKll9eNDA48R4ViENUIRrc
         Q3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794224131; x=1794828931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GIlBuqOny1gGEKxlNw/Qwq40A5Pe8GUQM0b3PZ+rkt8=;
        b=EIwyCFiqbMZRQqtvMsIEsYQh75eCVmbG9v0g1ZMCKHDVZQ2KgUFbEy0wVi4Tt9Jx/Q
         SZOW6bJQZRntneS63d0cjizKPq0xK8gla0Ki5jaq9kkT4/NsuEegFCMkQQNZpI8+Tf0S
         VUWbbH8y+dYxjCY4VxF72dvALcDK0QHN9jksCUxbKrCabM8FIiZNrGTftC5/KRVL1vP4
         /FI1+4n2izxG4h+WemwrV3tHuz1UX7I9sc9I+oH9DoHSBCzgck+WlWXKlm63hIVPAppM
         kh+I3xxgsTl653kgVkoEUye+EMEJ7TB4VHsqdr8gpWvSxp0d53Vg45SmvSWRm2+61iwT
         q4qA==
X-Forwarded-Encrypted: i=1; AL+hErFO3yO+gFGNPum64fnNHbCRE0u+1ghC0y9RlgdBbxkZHc0hgJqo8uvr4ziOtEqkvbdBO5s=@vger.kernel.org
X-Gm-Message-State: APuU4Z+NG4fTGw41xgSUISUKuXRQ0VD9NDojLgIqP5UlcyLmFUMDqWYw
	khiHVQTNNoENONZS3DqaILjZn1JEOYwVa8e6jJ3DXNgvxzf7GoJknRn1
X-Gm-Gg: AYBFou1mR9zdFgnpUNIjYQqNXzdluuOXk7PZFNG18T+PdCHM+mBSvM/AjEXDlLZzXJ3
	HPR8+YeC+iSNGj2BNe9lI0v+bCqZXxWiQK7vwt6CukudpFcFZYBFV92HWMGSfEgrPt1KGAri+rW
	XbgvGdCHR1Lv6ei9ErTW/tmia/cvrE+hcBqTjfkcJWgJHSKaEuArQ3Z2L3D0WBMzIkBYwJGlVu1
	bIKeXoQlbUS+fwO61VTmIDAVOIkKCIYgd3Gag5XnHj6soZampiLZNNFJkAE7eIAZ/+80UVftepj
	hDG0mcvlvrc1ErklpWeVel/OKStwkJWQUTjlVUIXP7htqYDzU9YmgYXt0P9FL+fGPVjkqaraCw1
	x/zq5OQOb7+sLOhFYnxfsvD2qT5y2vDA9cVbV8/Y/wAPjUQZuSI/GiLK71+/PZogz2tTorG3JWh
	vNhqJBRsKPl2XUkO8HSrEBeYL6BHgGVNmupNYI/ocSUogLtn+5W4VwGTpqYQdsGvpAbcnZflP/a
	e6a4GJwmrYuRCpThlxGmKx2pf2bcXKJJFRCEtsGRGASet6WirDc09uIhityqDMEUmiE0B6RTheo
	/W/NTWVs7glku/fqNFaLe9wYhVz9N2HOQIZNZQrIVWmLFSQ1Z/EYYu4=
X-Received: by 2002:a05:7301:707:b0:371:7ecc:b82a with SMTP id 5a478bee46e88-3725da6ed90mr6944066eec.21.1794224131175;
        Mon, 09 Nov 2026 03:35:31 -0800 (PST)
Received: from Anonymous.localdomain ([152.58.29.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37265c06c61sm12081864eec.14.2026.11.09.03.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 03:35:30 -0800 (PST)
From: Hussain Sitamouwala <husainsitamuwala21@gmail.com>
To: husainsitamuwala21@gmail.com,
	git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [Outreachy] Proposal draft v1: Implement promisor remote fetch ordering
Date: Mon,  9 Nov 2026 11:35:15 +0000
Message-ID: <20261109113515.198671-1-husainsitamuwala21@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi team,

This is the first draft of my proposal for "Implement promisor
remote fetch ordering" for the December 2026 Outreachy round. I would
appreciate feedback, especially on the config shape (6.1), the
precedence rule (6.4), the protocol field (7) and the timeline (10).

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
  Status: accepted

Patch 2: check-ref-format: use parse-options API (v1, v2)
  Thread:https://lore.kernel.org/git/20261109074352.163019-1-husainsitamuwala21@gmail.com/T/#me7e8cc9786a5a023d6c028b93185b3c6aa0d1d50
  https://github.com/git/git/pull/2470
  What it does: replaces a hand-written option loop with
  parse_options(). The commit message states the behaviour changes

Experiments I ran:
  - A partial clone with three local promisor remotes, reading the
    order of the "git fetch <remote>" subprocesses from
    GIT_TRACE2_EVENT
  - Read t5710 and t0410 and ran them: 40 out of 40 test pass

How this relates to the project: patch 1 documents the behaviour I
will change, and patch 2 shows I can take a change that alters
behaviour through review: state the change openly, keep it small,
rework after comments.

3. How it works today (checked against master at 6200d284e9, 2026-11-08))
---------------------------------------------------------------
 - promisor_remote_get_direct() calls try_promisor_remotes() twice:
   first with accepted_only=true, then with accepted_only=false.
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
 G1 (D1) Done when: a test can observe the order in which promisor
    remotes are tried, and tests for accepted-first, partialClone-last
    and fallback-on-failure pass on unmodified master.
 G2 (D2) Done when: with remote.<name>.priority set, remotes are
    tried in the documented order; with it unset, every G1 test
    passes unchanged.
 G3 (D3) Done when: a server can advertise a priority, a client that
    opts in uses it under the documented precedence, and every
    malformed or hostile case in section 8 is tested.
 G4 (D4) Done when: the limitation is removed, the new settings and
    protocol field are documented, and the docs build.

6. Design
---------
6.1 Local setting: three candidate shapes

 Shape A: remote.<name>.priority (integer, lower first)
   + fits promisor.storeFields: a server value lands in the same key
     a user would write by hand
   + each remote is overridable per config file scope
   + no dangling names
   - order is spread over several keys; harder to read at a glance
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

6.4 Precedence between local and server values
 Recommendation: local config wins outright; the server's value
 orders only remotes with no local setting. Operators who pay for
 bandwidth may prefer the opposite. I will put both arguments on the
 list. Early check: storeFields must never overwrite a priority the
 user already set.

 Draft user-facing text (for the config documentation):
   remote.<name>.priority
     An integer. Promisor remotes with a lower value are tried first
     when Git fetches a missing object. Remotes without a value are
     tried after those that have one. Remotes with the same value
     keep their configuration order.
 Draft error text:
   error: invalid value '<value>' for remote.<name>.priority:
   expected an integer

7. Server advertisement (protocol)
----------------------------------
An optional field "priority=<n>". I prefer it to "advertisement
order is preference order" because it survives any reordering of the
list and, since unknown fields are already ignored, old clients are
unaffected. I will write the protocol wording first, as an RFC.

 Server: sends the field only if promisor.sendFields includes
   priority, taking the value from remote.<name>.priority. An earlier
   review noted that one global sendFields is inflexible for
   per-remote values; I will check whether per-remote gating is
   needed.
 Client: parses defensively (malformed values ignored; the remote is
   accepted or rejected on its other fields) and saves the value only
   if promisor.storeFields includes priority. A client that does
   nothing never follows a server's order.
 Compatibility: old client with new server, new client with old
   server, and a value outside the supported range all behave as
   "no priority".

8. Threat model
---------------
An advertised priority comes from a server the client may not trust.

 Input                      Attack or failure       Expected result
 -------------------------  ----------------------  -----------------
 priority=abc               non-numeric             ignored
 priority= (empty)          empty value             ignored
 priority=99999999999999    integer overflow        ignored, no crash
 priority twice             duplicate field         
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

Every new branch must make a test fail when I break it on purpose,
and the G1 tests must pass unchanged after the refactor.

11. Series plan 
---------------------------------------------------------
 1. Trace2 event or test helper to observe the order. No behaviour
    change.
 2. Tests that lock today's order. No behaviour change.
 3. Refactor so the remote list can be sorted. No behaviour change,
    proven by patch 2.
 4. remote.<name>.priority, with tests and documentation.
 5. Protocol wording (RFC), then the server and client changes,
    with the section 8 tests.
 6. Docs: remove the limitation, document the field.

12. Timeline
------------------------------------------------------------------
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
values (7), then the section 8 cases beyond the core ones; local
priority, the tests and the docs are protected.

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
Your patches
[1] doc: describe promisor remote fetch order, v1 to v3:
    v1: https://lore.kernel.org/git/xmqq5wy89rq6.fsf@gitster.g/
    v2: https://lore.kernel.org/git/20261108071933.6586-1-husainsitamuwala21@gmail.com/
    v3: https://lore.kernel.org/git/20261108195518.943-1-husainsitamuwala21@gmail.com/
[2] Junio's review of v3 ("Will queue.") and the request for an Ack:
    https://lore.kernel.org/git/xmqqse1a1th8.fsf@gitster.g/
[3] check-ref-format: use parse-options API, v1 and v2:
    https://github.com/git/git/pull/2470
    https://lore.kernel.org/git/pull.2470.git.git.1793298807397.gitgitgadget@gmail.com/
[4] Reviews of other people's patches:
    https://lore.kernel.org/git/CAP8UFD0uA+zF4x8WBRA6sGxSGX52Nw=GFBznzdFnX3SptHDUcw@mail.gmail.com/

Code and documentation (checked at master 6200d284e9, 2026-11-08)
[5] promisor-remote.c: try_promisor_remotes() (line 282) and its
    two calls (lines 351 and 353); the field lists for
    promisor.sendFields, checkFields and storeFields (lines
    465-481)
[6] Documentation/config/promisor.adoc: promisor.sendFields (line
    12), promisor.checkFields (line 166), promisor.storeFields
    (line 207)
[7] Documentation/technical/partial-clone.adoc: the limitation on
    ordering (lines 229-234) and the future work item (lines
    265-271)
[8] Tests: t/t5710-promisor-remote-capability.sh and
    t/t0410-partial-clone.sh

My own material
[9] Blog: https://husain-git-blog.vercel.app/

Thanks,
Hussain
