Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794224363;
	b=rfXBmkQqu66g1wu57fUmiD0FYvgDoCv4KKRyV+2g/r/RNqqeZ09XN+eYbWaeRjO4KL5m
	 7ttAPQR4WeJecMzoTbly3nG2/gQZVonWGerUI/z6huqvj9/WKNm4I4MlQ9ZzRSC2W5A96
	 /j/NNV8HNi5QAVEFyOehgYmtLSAZk6Yzsy6wLneFR+4LXFPNdKJby/a0vUY8G6lMeoi+E
	 9NfITwEOC3iTdkmm+o/c7utGBzU6u9Gz4ySKTe5pZr6FTcT/XhaTPsNRGIXb9AymFVy+i
	 Un91d43d+A8nav4El5DIeyBUeRW9bh6cN3fdFgZ7WpvIGMYlwRW0x8yra6UfJ9wTZOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794224363;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=GIlBuqOny1gGEKxlNw/Qwq40A5Pe8GUQM0b3PZ+rkt8=;
	b=R7SwmtGFSKbJ/KyFPZ3ekZj6FtrNnHWKf00VMX8wQA/E70XiuOvHBlPhc25ODG30uv4m
	 SKxcWWectVx58PNP1pgE50z6Yg2EybHaBtVFWz5L/9uf8aZ3fC7wDn1q6S97Cu4xHCMyD
	 JNLv8wfDAe9G/gl1hRzacyN8Za0mxfiYLZ4WZtFKz21xjIOZ+Q73HqBL2I92ydwblZQWr
	 Z4hY0iCxsambNBolIqKUSMxrt65i5dfl+8jp9XJafhNk5oda7ZymJGoZzlDsfnxe0hvr1
	 gSpfTPpAJws6yIMPk+DvdGhe9MF5p3UKDDHIQJLX+OsIO7KgXyOCgZH9CBfwgCGzoKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ucvLEWzO;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF16A606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 11:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF16A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ucvLEWzO
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1ae58d17cd9so351746c88.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 03:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794224362; x=1794829162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GIlBuqOny1gGEKxlNw/Qwq40A5Pe8GUQM0b3PZ+rkt8=;
        b=ucvLEWzOEqAn91/aVzpAjIK5jQPx4lHbLOVJ08uqQ8n/be6TW6QKIPAdNGr4HjMctQ
         w6x0zBTwyDnJ1dDG0Pnnse3QxiBXv63AzQokZiPtDsKR/hR+NxEo9vmhC5Ve09S+hZJy
         Q1mj/LJyB6ochlsfWQxDg95hEm9shD+iBvOqgv/sRgBbNwc1HRsDw5RNjTSYrFDQm+4+
         ndvZeiqtDfOIIn0h4r7DJOZpdnNhe6Haf4oglvHQvO4uNbA8hp0WQ+qn7EYbn3B5jst7
         zhpIPRVf0ict9lLwRUPbA4H7fqsH2DoBDJzAxuceAX3BECIrGoWhriD6YQ2Is6yvf7Lj
         WJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794224362; x=1794829162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GIlBuqOny1gGEKxlNw/Qwq40A5Pe8GUQM0b3PZ+rkt8=;
        b=LP5hkrxAgupcQt+3ml1APAlpQ8Mp163gkB8k42xdSEK55h8O/zRiL8Z/Y62ZH7Z6YR
         QYfqHYEWzalrcWsVv1DMfr5AWfCc73M5wOAATMOpisacu/X46a70cGhjUO+VVXkHUQkf
         7yIWHK4IssSl4O/uXLnLeRADHdGhECMMc5eveOmaJBvggYkOQdNz9i4zQXzELj/BmjBM
         auX/Qipn5+4tYNnrXHA3M8tsmlWkumzEIgex6OGN5o8TQMeuD9sTLRjIGBjeJk5AQAJ2
         iRgwY4D8iWgt6tWu4ptRPR33YQfYwk0CQxEdLgkJHVcegTh1w9LeGROP14DMh7dLTbL0
         djvw==
X-Gm-Message-State: APuU4Z9al3Z3qAynGq1yq6JG7leuC8M0cfiZA152V1zSJz8eSgZZXbqc
	PPv+P7JtLJ8v3ZYLsQ2WeCFLDoVqNGWj/Zd0Tp47MBRb7uq5dESsLWLQP0jebw==
X-Gm-Gg: AYBFou23jrhqUFUiBKB+Z7URIB6O1iU1bjIk8WPPCvKOiLA4FYHtzdLSD25liI6wszH
	xugpWSWiYSI+0TX4nQhgGxKlSQDkp2aAjyt4Z7S9GL4rySS20HcrRsHxAG5nxAVlbpuDGIFb6qI
	zZC2LUpAQqxkJFnOyrJ9Mj32FPTWXn1V3azWfGNEmu3ccrlvylMhlWYkq6/2Nxj8+W7b6G3kXGN
	K/laNDUZJ4LWEenQoiecuDwCrtdCB1sNfm3h1PLJ1X5L8mlS8b6WqV7dxeqmKTd2ca1j5POWoRo
	yAFxVZZFJeYKfu7d8XWt9bCf0G4SvNalEiveIkgd3Xvoppwajvm5Y5zFcuN/4+FEQtrkLcFLw3R
	fckrGKjG8H5eUsOAMBuB/i/18bgV5y1edqAhctzdFpVWUFwLiSB0KYZH+c6G+mTAvIEvWKcuePh
	Xw+v18DMFjaoEy01p8FDl3hwF93E+VFGmZUhvY6T9lk7VrL2cVHGul2uxeeMuJBgdL5uWT33u+A
	z9cjka6wwN3OBWnLGEc6qKoxnsUIJr5vzOKYNSETOi66WUrlcn6FBsEerJkalAYOvXe50ZJY8Tv
	AtGpQ/qUSgXrsfHk3QKtI4GYLEJAqB3NyQ6LSVArcn88UAJz0cfCxATZfVDl9R3IxFyqtKTXXDc
	=
X-Received: by 2002:a05:7022:1505:b0:1af:16c4:d06b with SMTP id a92af1059eb24-1b39fecab8dmr7064202c88.10.1794224361291;
        Mon, 09 Nov 2026 03:39:21 -0800 (PST)
Received: from Anonymous.localdomain ([152.58.29.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b375728f8bsm11635050c88.15.2026.11.09.03.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 03:39:20 -0800 (PST)
From: Hussain Sitamouwala <husainsitamuwala21@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [Outreachy] Proposal draft v1: Implement promisor remote fetch ordering
Date: Mon,  9 Nov 2026 11:39:09 +0000
Message-ID: <20261109113909.199326-1-husainsitamuwala21@gmail.com>
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
