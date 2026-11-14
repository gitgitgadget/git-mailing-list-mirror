Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794670245;
	b=AG9QtKZpYdyAH9//NNsj9RcfW2FpRIgBO2h0NACK/6FvwNNSVROpqMvcuun+VJlb2y6d
	 62tW5FoNjD2yfkM5akYv7sh4NXkEkqU2kDXGArg9J3cdxScIRDQNBvOTDCSU9WISoMGKS
	 u1qPyEOHqtvxEFReQfDHfbOo/At2Fowfn60BYp7ypGkeuSBiY45P9iUTPdrtoy3LVn7Lk
	 9tLEvHm1bBvqtDu7i9HPhlYjkYG0CulXqQJ7Um85NCQZhznzHsujnIomudpGS1Syj8ZD5
	 D0y0kTgWzgWJms8GOOVroEZaAG64NElzSnmDhgIATNZklJydIxbWUTmgPqxbOoMrHKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794670245;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=lIl0H5lMHm5AiayZ8jVgqYH2ilBMRGPkrKzB68zXoLU=;
	b=QcUhhklKwClrmar6ApZWQ7YQu1x2xXF1zzrlDynVY4uKGZsftwoZ2pV0OKLzltemml+8
	 58DsS59WHWFZ10C4g6RXlUhjloDsZ+zOnDQktLfpaQMXs9+wa0mpXCAd3H1mx0rn/rMoC
	 YwJyt63oTJfwHy6KAJ+BrnGDHZzNn9kyes5N4Nom3cscxa4iaImN5tuZ5DfIyb/LbCiA2
	 LpEUvz4Vf+zzlDs20n3WrsCHpNlPZjFILEY1b+w4kesjkDE32MetC05xaNusArl4HFIe6
	 rGeDD/oIkfKsXx44A6BYa3ptyJ4D3tNZRhrrLwC0yxiWPy03ZfU2N3BXOcLZugEqWPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G9vK0iBO;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A63606A32E
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 15:30:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19A63606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G9vK0iBO
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso2466792c88.1
        for <git@vger.kernel.org>; Sat, 14 Nov 2026 07:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794670244; x=1795275044; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lIl0H5lMHm5AiayZ8jVgqYH2ilBMRGPkrKzB68zXoLU=;
        b=G9vK0iBOWnKMAFaqjExXRKgWcEgipSx46w/Lq7sY4FMQDvzInl5nu324zUiDT8PUOW
         gkk62JrW8nP+wKVBbfEhmPRvLDLqgMjwxgQgKDDknF6NH3lJyP5yhQtACofjC5zBJ5VU
         uWoMNOdpqTYK540ppftX48HcXwm0K9HXYdpj3SerVDstRMtN7UUJLjeecgonDMzbx80J
         YHcaGjQUzC2myMJFrZdoCasqbSAkPnz5NQuGMitGzJIJfof4I2yKpxQCPvX/5E/2wqVC
         4SxF35hZCP8ZxkfXBIrPKpNDvMJQy8PEB+FpyJHwPpDMQDpdk2IyV2VlOMAkX/LmgiSU
         aXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794670244; x=1795275044;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lIl0H5lMHm5AiayZ8jVgqYH2ilBMRGPkrKzB68zXoLU=;
        b=jabEOXwbWIEsTkW40RUSzBmLXhsFF5W2s/4S1DFOm2b97qOi3GJBqZTz4Q9immIkiE
         ABeIyCK2sqOUwlJ2EgiIINoc4/3gCfnHha16uOobDV1D96YScGxgEx9UWSZAiBo+dztA
         Z/i0TdBQ72xkiLEwDD46xw3whfuE9Jt5BNkeAY9ajXaMEuRHjMshj7Sgeav1pdlZrrvW
         04+4Fef+d2IkAYi78FO8xsvcl+ds+vciD6YEQ4acPBOGuCt30eYVB+rzckKcsj/3QmfT
         1H/ow2yOdT/3QlS2I4XlPchZQZ4/ZekrFTk2XtBFvvR4oUY8TGCPzNo3fPtyuRjTSWm8
         4Baw==
X-Forwarded-Encrypted: i=1; AL+hErGUzIDPOxmGj4iROaEKC8gDLER32/pVmkPfGv4j10vHJgegZw4NxCmOQxBZ0GFTksvUPuc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/O38IiqNr4p314XZzd7wQtwCvxAVRAx+QWal+kJC4ucdstetUF
	0eUQxYK9ZKxfou55MtiP8lWnsZ1bfWGaN1a1NEXO0J+wZ4p5z+9AxEd8
X-Gm-Gg: AYBFou0J/DaWW/z2qSe6tiNDytcM6p+q7g4ssw6jTzv9mteabo2YuOJNqXBzEH1HpaC
	fBvx8bHyNqU22z1YwKqkmlAgOScLuezk74LuazQy+tiZ7JP3gBNZLJvXpbrCWgDCl4NnjsS/iQC
	K5esvvkltVl40eZ4zGBUJWNkUZ/hQZWlwIP0/N/1t+Jg4653DIe9vDTYIqhtFBEPPwWulS/vFss
	3C+eRxetdyP5qfqkS4+tSvE/aTIWhDuXD0ZvJ2LGa1EDsFw0YQQEbKPKgbsl+n72pHl5rRWQND3
	bdTtqlqxvnNtVQxUU8g4co7aZAYu6MIj/p9MZnZj8YRpf6yiJ9Tce0swoja2Gea8TeIfPw+I8fi
	S1UxCINVAcDZBjpy+zs3cD4oUtZt0J2B1fsAiq+sk+95WpW8Wh1by7rvTUjzyGoZUlJMVZsvI+7
	8ANvU/bBsMf/cwLDPSH/RZDpHfBfcDFxy1hKvukigDZA8RVd2hEEN5QtT7q87JAwKHMtmRcjX4b
	BEWxuUjzZDQTV4TkYHyUkk04ml8HpfrTYq9rERWsQ6yLnX66MXZFZfr6fxxB09qrgTnjQn/JTsW
	3j9Id5fGM/c2HZzwapVxVSgA3omg404/LK+Rltd1Idz4J019VR0hM0ND6l7cXlnX24p4dSr0jSf
	6hWlgpODy
X-Received: by 2002:a05:701a:844a:20b0:1b5:1a41:f3b6 with SMTP id a92af1059eb24-1b51a41f403mr1965252c88.4.1794670243694;
        Sat, 14 Nov 2026 07:30:43 -0800 (PST)
Received: from ?IPV6:2406:7400:12b:37cf:a789:a247:8b8a:69a4? ([2406:7400:12b:37cf:a789:a247:8b8a:69a4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031918c7sm23707974c88.9.2026.11.14.07.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2026 07:30:43 -0800 (PST)
Message-ID: <a7ea1ac5-bb63-4bd1-b3b8-a6c36d675988@gmail.com>
Date: Sat, 14 Nov 2026 21:00:38 +0530
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [Outreachy] Proposal draft v1: Implement promisor remote fetch
 ordering
To: Hussain Sitamouwala <husainsitamuwala21@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 Christian Couder <christian.couder@gmail.com>
References: <20261109113515.198671-1-husainsitamuwala21@gmail.com>
Content-Language: en-US
In-Reply-To: <20261109113515.198671-1-husainsitamuwala21@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Hussain,

Thank you for submitting a careful proposal!

On 11/9/26 17:05, Hussain Sitamouwala wrote:
> 
> This is the first draft of my proposal for "Implement promisor
> remote fetch ordering" for the December 2026 Outreachy round. I would
> appreciate feedback, especially on the config shape (6.1), the
> precedence rule (6.4), the protocol field (7) and the timeline (10).
> 

Nice. Thank you for being explicit about the areas that you need inputs in.

> In short
> --------
> When a partial clone has several promisor remotes, Git chooses which
> one to ask for a missing object by a fixed rule that neither the user
> nor the server can change. I will (1) lock today's order in tests,
> (2) add a local way to set it, and (3) let a server advertise a
> preferred order through the existing "promisor-remote" capability,
> with a stated precedence rule, defensive parsing of untrusted input
> and proof that nothing changes unless someone opts in. The design
> goes to the list in week 2 because it needs the longest review.
> 

Concise and clear.

> Summary of deliverables
> -----------------------
>   D1. A way to observe the fetch order in tests, and tests that lock
>       in today's behaviour.
>   D2. A local setting that orders promisor remotes.
>   D3. A server-advertised priority with documented precedence.
>   D4. Documentation updated; the "order cannot be set" limitation
>       removed.
>   D5. A final report listing what remains.
> 

Neat.

> 1. About me and logistics
> -------------------------
> Name:     Hussain Sitamouwala
> Email:    husainsitamuwala21@gmail.com
> GitHub:   https://github.com/CodeWithHusain
> Blog:     https://husain-git-blog.vercel.app/
> Location: Mumbai, India (IST, UTC+5:30)
> 
> I have read the Outreachy eligibility rules and I meet them.
>

Thank you for mentioning this. It is helpful.

> I learned C through CS50 and use it with C++ on Linux (WSL). I build
> Git from source, and I send and revise patches with git send-email,
> threading versions with --in-reply-to and answering every review
> comment before sending the next version. I also wrote a Python
> network vulnerability scanner on top of Nmap, where I learned to
> treat anything that arrives over a network as hostile until checked.
> That habit matters here, because a server-advertised fetch order is
> data the client does not control.
> 

Good to know.

> 2. My Git work
> --------------
> Patch 1: doc: describe promisor remote fetch order (v1 to v3)
>    Thread: https://lore.kernel.org/git/20261108195518.943-1-husainsitamuwala21@gmail.com/t/#u
>    What it does: documents that remotes accepted from a server's
>    advertisement are tried before other promisor remotes. This is the
>    exact behaviour the project will make configurable, so I had to read
>    the fetch path before writing it.
>    Review: Junio reviewed v3 ("This iteration looks good. Will
>    queue.") and asked Christian for an Ack.
>    Status: accepted
> 

It's in 'next', not in 'master' yet. The application page asks you to 
give the status the way "What's cooking" reports it.

> Patch 2: check-ref-format: use parse-options API (v1, v2)
>    Thread:https://lore.kernel.org/git/20261109074352.163019-1-husainsitamuwala21@gmail.com/T/#me7e8cc9786a5a023d6c028b93185b3c6aa0d1d50

Just a suggestion. I think linking to the permalink of the cover letter 
would be sufficient in place of a thread link.

> 
> 3. How it works today (checked against master at 6200d284e9, 2026-11-08))
> ---------------------------------------------------------------
>   - promisor_remote_get_direct() calls try_promisor_remotes() twice:
>     first with accepted_only=true, then with accepted_only=false.

I think these are in lazy_fetch_objects()

>   - Within each pass, remotes come in config-file order, and the
>     extensions.partialClone remote comes last.
>   - Protocol: each advertised remote is a list of fields. "name" and
>     "url" come first and are mandatory; optional fields follow in any
>     order (today partialCloneFilter and token). Unknown fields are
>     ignored. The server sends what promisor.sendFields lists, the
>     client validates with promisor.checkFields and can save with
>     promisor.storeFields into remote.<name>.<field>.
>   - The partial-clone technical documentation lists as a limitation
>     that the order cannot be set except by position in the config
>     file.
>

Thank you for sharing your understanding!

> 
> 4. Problem
> ----------
> A user cannot say "try the cheap mirror first and the expensive
> origin last", and a server operator who knows which remote is
> cheapest or nearest cannot tell clients. The existing rules are only
> partly documented and not fully covered by tests, so any change risks
> altering them silently.
>

Concisely captured.

> 5. Goals and acceptance criteria
> --------------------------------

I would've appreciated a hint here clarifying that D1-D4 here were 
referring to Deliverables mentioned above. Took me sometime to grok that.

>   G1 (D1) Done when: a test can observe the order in which promisor
>      remotes are tried, and tests for accepted-first, partialClone-last
>      and fallback-on-failure pass on unmodified master.
>   G2 (D2) Done when: with remote.<name>.priority set, remotes are
>      tried in the documented order; with it unset, every G1 test
>      passes unchanged.
>   G3 (D3) Done when: a server can advertise a priority, a client that
>      opts in uses it under the documented precedence, and every
>      malformed or hostile case in section 8 is tested.
>   G4 (D4) Done when: the limitation is removed, the new settings and
>      protocol field are documented, and the docs build.
> 

This kind of reads as if the way in which these are implemented are 
already concluded. But that discussion will be a good share of this 
project. Anyways, good that you mention goals explicitly.

> 6.2 Semantics, with proposed defaults to settle on the list
>   - Accepted remotes stay in the first pass, as documented. Priority
>     orders remotes within each pass. I will ask whether an explicit
>     local priority should be able to override accepted-first.
>   - Remotes without a priority go after prioritized ones, in today's
>     order. The extensions.partialClone remote stays last among them.
>   - A bad local value is a clear config error. A bad advertised value
>     is ignored.
> 
> Worked example with the proposal (priorities: A=20, B unset, C unset,
> D=10; the server advertised B and D):
> 

Nice that you mentioned these.

> 6.4 Precedence between local and server values
>   Recommendation: local config wins outright; the server's value
>   orders only remotes with no local setting. Operators who pay for
>   bandwidth may prefer the opposite. I will put both arguments on the
>   list. Early check: storeFields must never overwrite a priority the
>   user already set.
>

This has a conflict with your preference for Shape A, doesn't it? To 
avoid it, I think you may want to work out where a stored server value 
lives, separately from the user's value, and how the two are ranked.

>   Draft user-facing text (for the config documentation):
>

The discussion about this is rather premature for a Outreachy proposal, 
I would say.

> 
> 7. Server advertisement (protocol)
> ----------------------------------
> An optional field "priority=<n>". I prefer it to "advertisement
> order is preference order" because it survives any reordering of the
> list and, since unknown fields are already ignored, old clients are
> unaffected. I will write the protocol wording first, as an RFC.
> 
>   Server: sends the field only if promisor.sendFields includes
>     priority, taking the value from remote.<name>.priority. An earlier
>     review noted that one global sendFields is inflexible for
>     per-remote values; I will check whether per-remote gating is
>     needed.

It would've been helpful to include a reference for which "earlier 
review" you refer to.

>   Compatibility: old client with new server, new client with old
>     server, and a value outside the supported range all behave as
>     "no priority".
>

Good that you mention this. It is a good thing to mention and discuss in 
the RFC too.
> 8. Threat model
> ---------------
> An advertised priority comes from a server the client may not trust.
> 
>   Input                      Attack or failure       Expected result
>   -------------------------  ----------------------  -----------------
>   priority=abc               non-numeric             ignored
>   priority= (empty)          empty value             ignored
>   priority=99999999999999    integer overflow        ignored, no crash
>   priority twice             duplicate field
>   priority for a remote the  push an unaccepted      remote not tried;
>   client rejected            remote                  no effect
>   priority for a remote with local value set        local value kept
>   server sends many remotes  resource use            existing limits
>                                                      apply
>   client without storeFields no persistence          order unchanged
> 
> Each row becomes a test. I will also avoid in-place string splitting
> on lists that own their strings; I saw such a crash reported on the
> competing patch.
> 

Good to see this being thought through.

> 9. If the competing patch lands first
> -------------------------------------
> Plan A (not merged by the start): I deliver G1, then G2 in the shape
> the maintainers choose.
> Plan B (in next or master): I skip G2's implementation, keep the G1
> tests and the docs, and spend the time on G3, building on its config.
> In both plans G1 and G3 are mine, and the G1 patches do not depend on
> any design decision. I will review tha-t patch and tell its author
> what I find, because I will need to understand it well either way.
>

Interesting to see contingency plans.
> 10. Testing
> -----------
> Follow t5710 and t0410.
> 
> Observation mechanism: first choice is a trace2 event naming each
> promisor remote as it is tried (a small patch of its own). If the
> maintainers prefer no new event, fall back to a test helper that
> wraps the fetch and logs remote names.
> 
> Test matrix:
>   Area         Cases
>   -----------  ---------------------------------------------------
>   Baseline     accepted before others; partialClone last; fallback
>                after a failing remote
>   Local        priority respected; ties keep config order; unset
>                after set; bad value errors; per-scope override
>   Server       value honoured when stored; ignored when not stored;
>                malformed values (section 8); duplicate field
>   Precedence   local beats server; storeFields does not overwrite
>   Compat       old client with new server; new client with old
>                server
> 

Nicely captured.

> Every new branch must make a test fail when I break it on purpose,
> and the G1 tests must pass unchanged after the refactor.
> 

Not really sure what you were trying to convey here.

> 11. Series plan
> ---------------------------------------------------------
>   1. Trace2 event or test helper to observe the order. No behaviour
>      change.
>   2. Tests that lock today's order. No behaviour change.
>   3. Refactor so the remote list can be sorted. No behaviour change,
>      proven by patch 2.
>   4. remote.<name>.priority, with tests and documentation.

I suppose we expect this to also involve an RFC rather than being 
something that we already concluded.

> 12. Timeline
> ------------------------------------------------------------------
>   Before:  Follow up on the docs patch; review the other patch; run
>            the experiments in section 2.
>   Wk 1:    Baseline write-up of today's order with traces.
>   Wk 2:    Trade-off note AND protocol RFC to the list, so design
>            review runs while I code.
>   Wk 2-3:  Series patches 1 and 2 sent.
>   Wk 4-5:  Patch 3 (refactor); patch 4 started.
>   Wk 6:    Patch 4 finished; first review round. Milestone: G2 sent.
>   Wk 7-9:  Patch 5: server field, defensive parsing, precedence.
>   Wk 10:   Decide storeFields persistence; section 8 tests complete.
>   Wk 11:   Final reviewable series; second review round.
>            Milestone: G3 sent.
>   Wk 12:   Patch 6, release notes, final report (D5).
>   Stretch: Remember failed remotes within a process; measure latency
>            or cost.
>   Weekly:  Blog post and written update.
> 

I wonder where the patch 1, 2, 3, etc. are coming from. I couldn't find 
any references above. Did I miss something?

> 
> 13. Risks
> ---------
>   Risk                         Mitigation
>   ---------------------------  ---------------------------------------
>   Surrounding code moving      Rebase often; check master before
>                                writing tests; talk to the other
>                                author
>   Design disagreement          Raise early; keep patches 1-3 and docs
>                                independent of the design
>   Slow review                  Small patches; next piece in parallel
>   Silent regressions           G1 lands before any change
>   Scope too large              Cut order in section 12
> 

Nice to see these thought through.

> 14. Communication
> -----------------
> Weekly blog post, published at https://husain-git-blog.vercel.app/
> and linked on the list, and a weekly written update to the mentors.
> Design questions go to the list before code. I answer every review
> comment before sending a new version, as Junio asked me to, and
> reply within 1-2 days.
> 

Cool.

> 15. After the internship
> ------------------------
> I will keep following review of anything still open and keep
> contributing to the partial-clone and promisor-remote code, starting
> with the stretch items.
> 

That's great!

> 16. References
> --------------
> Your patches

Whose patches?

> [1] doc: describe promisor remote fetch order, v1 to v3:
>      v1: https://lore.kernel.org/git/xmqq5wy89rq6.fsf@gitster.g/
>      v2: https://lore.kernel.org/git/20261108071933.6586-1-husainsitamuwala21@gmail.com/
>      v3: https://lore.kernel.org/git/20261108195518.943-1-husainsitamuwala21@gmail.com/
> [2] Junio's review of v3 ("Will queue.") and the request for an Ack:
>      https://lore.kernel.org/git/xmqqse1a1th8.fsf@gitster.g/
> [3] check-ref-format: use parse-options API, v1 and v2:
>      https://github.com/git/git/pull/2470
>      https://lore.kernel.org/git/pull.2470.git.git.1793298807397.gitgitgadget@gmail.com/
> [4] Reviews of other people's patches:
>      https://lore.kernel.org/git/CAP8UFD0uA+zF4x8WBRA6sGxSGX52Nw=GFBznzdFnX3SptHDUcw@mail.gmail.com/
> 

Hmm. This should point to a review that you did. But it doesn't.

-- 
Sivaraam

