Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925D13D3331
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 11:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774439249; cv=pass; b=Qy7QJ2akfET3FAC/fZBO8rJWgSh+B45LFnEzQVn4QeC3ewRFcXJu0JFc5SmpE5lpmCsOHPZkffwrdLG4kGntOfSD8he51kzVPRvfiUzit6rKOcFV2/FSKbMvishrIA+gsAifil7C8WOQ4+GR/QkwkPx8UlMqA8wQYOjtbelxumo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774439249; c=relaxed/simple;
	bh=ouS+ZyRa642m9S3PViLcL35eCjQF5qseU7pH8IQdMMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nsenVJB2eeGSuDg5lsG3K7UzjFjSqU4BoNc/5+cQVSWEypcD01ztDXh2xCifChR8liLWGI8K/YDh3u4awEVcdUrjDd+/pp8c3qomhNVKe/rqzMW24nmtn+uubzqJ/tk/A/217TauZYaqhXcco193noCgWfHLTm5q+D42LpCCai4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPvpZJ2s; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPvpZJ2s"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-829781b2b01so1523090b3a.2
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 04:47:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774439247; cv=none;
        d=google.com; s=arc-20240605;
        b=fJZwmS6bSdD+VBvVm5SL9zdAZx7hyfmFPNnw0prk3Fa2n90G8NXD0Qg6Dlc6sgQW1c
         r2kyE+PRyBa+IZtP4vW5HQMd6aT98XGe5/ahils2xQ2QU0gsras5KWP944Xr8pMsS4jZ
         thwUIhwZfTReVAQNlJg07houZMS2Y2DES6PLHAFAGcivmU5lBzDHNMhlgfxh0MThnFUr
         KMNZhgwmNuVejQHoV8nOL96lvjCTpDIb4KJxHTd7BPj9qPBwnDezo8eM92hmM5CNhiT7
         w3gLx3qR0wGNZMrtgJFZPn1RPErPrW/rQWNzoV41wqyF4hmoKclmlznOGbzrGGc3KERN
         1hyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=nNASNc9cRD8dLLXTM8gx3cqeafXNfmXDSjiQJP2KklQ=;
        fh=1257yDTh098c2BEtV0Oxwdc3EQkwSxfmEbAaN88ZqcM=;
        b=SICvhEbEF8UNaCFutEx5frLT2FMCej8Wkq5wLBACVFxgqUsMoON79oXC1qbD/w+Sbi
         qv/ZAm6zn4A6LA0d+l0bXR2D6y70dzieVQxVLFda/ewvoiJy+fZIkkmo7qZn7XwhwBl/
         knj+nKN2JJwi99u1fqPbfpGprXWi7rojAwX9qvJVATZDmT/jscRysZAFNNFLkmlKm0zh
         GQOFK1Tfbjm6CWNJVCUeNq6TyEkyBp1DZaTB0ooQn3NKIrEbBMIhzNDz4dRDZJBNyI/f
         v7+wzFEUmdvupsXPVn9m4AIlTAVps04FqnR9KgxFlvCsTEyhCx6ADced83YID4ZYf8nX
         kaBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774439247; x=1775044047; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nNASNc9cRD8dLLXTM8gx3cqeafXNfmXDSjiQJP2KklQ=;
        b=iPvpZJ2suhzC+zgUMEle6CUzHv+BKYO/l7+9zNcbRrXRGoPvtowhYrqwvH2qS/dHBC
         yEPBpXmtXLwxGd3Klh4McTyRegJ0moUgqs6gsX6772AKKdtqeBBul1WHZW2N1T8Ld0QP
         gJdgG758nCzOyWzA8BhrbtlYfGpn204Mlof8Ve6V8l+hKmmb8jzO9LFA3P7C0T4tP/vJ
         3/Rm+QiCzvyYcQ8kurMj8SUuAOShOJr4Vvb5mKBOwv2VLtx4rZWGpLtJc58kol/vv/nn
         egGIapfyXS+FCX+QxsykYiPoEWzaRs1v5wGefg8hsELnhtlcAf2v5fMKfpVnU1Jv5jdU
         +hfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774439247; x=1775044047;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNASNc9cRD8dLLXTM8gx3cqeafXNfmXDSjiQJP2KklQ=;
        b=QRolFhyVvCOOWccDTT1bmT5TFMNMQrYw0SQiFVSUdPdCAEkqd9Mima+EA8N2L2g2CZ
         PX1/Kmrj8hOIQl9+uano+rRQ8wvalKOAaTR4QtEw/k3EQC/iM5cTlxxAHDsw5dXUGweR
         J1Yx/67/bVpaP7L6NDZqlzhrbmObr1a+C3tNTv+J4bADa/ebhmpOSWZ7L7M5OyEN9ghk
         9Kyx6YPs17ouYoZgJ/hVEuevZYuV+UHB5Ag0zkqlIVmd9XzfkJjmki+iud/9GHZz9hDr
         oIRMf1pJwb9A9ETepwU/yjx4MfexUz74wzD9uUWuI3OYhOrmkPzpgvrnMSKVVOYd25zJ
         gM6w==
X-Gm-Message-State: AOJu0YxXw6HE27BxvygN6H7cKt0QnirjSCCYghsv81kr1zP5aUWcAyCW
	OSBzKj4XufqDtCn3YIjUza7APnRsdlia2K3keDrSy249xMKg0FpT4P/K06yH5T4fo4Tv09jQOWr
	lAOIhUyYCgsRzxDV5lHMLCBax3Yh5w74=
X-Gm-Gg: ATEYQzwlPC+bi5fo3hK57eiwX1Opmfh6qIUwhz9h15fV6nNCOOmwZWSy30Hc6UeCYNH
	jY5fzxVf4T1gh2/0MOKc98JY38PQ/4F4Jbh64HaepmsKZZlHDqBr3V8xwOe1ItYIxzFCjj5ebTs
	E4O8Cv0QhvYSK1RKvQwIhfDx3NW0gsJWYzqNsRVws403N6TyBe7jxDmLenbr4RCYWsKddE4X0Su
	Ax4vta+tdvn+YZNhny+P/BKLjESKAC7XhtPTt8JULL4TKqbBSYqHRzPYTP03eLzVlHqh7hhK6pX
	ZrjQB38DUBObg4N3fc9deXCcUrugs9zCYeeHQfo24ki/FxtCu6MKhKzjFo/0GdFxtTxlZl8YIH+
	48rolHDIXJhYof/NM5AW8eHf8XQ7+mocgErOLPA==
X-Received: by 2002:a05:6a00:414b:b0:822:6830:5900 with SMTP id
 d2e1a72fcca58-82c6de927e1mr2980820b3a.6.1774439246370; Wed, 25 Mar 2026
 04:47:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGWgyh-NASOa+6NPhQHCte2_A7OkNm1r2qAov3Kn1+r1d25hYw@mail.gmail.com>
 <CAOLa=ZSqQ=w8EVFMUwn5EUfMmNBgzGzG458Ex1ixiBSTiWnWYg@mail.gmail.com> <CAGWgyh_VmcNuay3AjsZ9zj9mP4g-c3Y9uDfuO5=kP9ix7Kdi3g@mail.gmail.com>
In-Reply-To: <CAGWgyh_VmcNuay3AjsZ9zj9mP4g-c3Y9uDfuO5=kP9ix7Kdi3g@mail.gmail.com>
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Date: Wed, 25 Mar 2026 17:16:48 +0530
X-Gm-Features: AQROBzAxjaQfpfBjJUvLlWcnmDtJUkaphZk_XUw7_iZaUg-frh-VKmWZTvD6sUs
Message-ID: <CAGWgyh8bpiC2vmRS2X_v1KKxd1g8_qAnbWd+rLRoBxpfmmZtPg@mail.gmail.com>
Subject: Re: [GSoC Proposal] Improve Disk Space Recovery for Partial Clones
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, jltobler@gmail.com, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, Ayush Chandekar <ayu.chandekar@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hello Git Community,

I am Siddharth Shrimali, a contributor currently focused on the
partial clone subsystem and test modernization (most recently the
t0410 series). I would like to submit my updated proposal for GSoC
2026: 'Improve Disk Space Recovery for Partial Clones.'

This is a revised version incorporating feedback from Karthik Nayak.
I would appreciate any further feedback or suggestions on the
technical approach outlined below.

---

1. PERSONAL INFORMATION

Name:       Siddharth Shrimali
Email:      r.siddharth.shrimali@gmail.com
GitHub:     https://github.com/siddharthshrimali
LinkedIn:   https://www.linkedin.com/in/siddharthshrimali/
University: Walchand College of Engineering, India
Degree:     B.Tech, Computer Science and Engineering
            (2nd year, 4th semester)
Timezone:   IST (UTC+5:30)

---

2. PROJECT ABSTRACT

Git's partial clone feature lets clients work with large repositories
without downloading all objects upfront. Objects are fetched lazily from
promisor remotes as needed, and git backfill can proactively fill them
in. But the reverse does not exist: once blobs have been fetched, there
is no way to drop them back to a promised-but-absent state. Over time,
clients accumulate large locally-held blobs they no longer need, with no
path to reclaim that space short of a full re-clone.

This project implements that missing direction: a mechanism to safely
identify blobs that are available on a promisor remote, remove them from
local storage, and re-enter them into the promisor contract so that the
existing lazy-fetch infrastructure re-fetches them transparently on next
access. The result is a reversible partial clone lifecycle.

Project size: 175 hours. Difficulty: Medium to Hard.
Languages: C, Shell (bash/POSIX sh).
Mentors: Christian Couder, Karthik Nayak, Justin Tobler,
         Siddharth Asthana, Ayush Chandekar.

---

3. PROBLEM STATEMENT

When a user clones with --filter=blob:none, Git records the remote as a
promisor remote and fetches blobs lazily on demand via
promisor_remote_get_direct(). Over months of work, through lazy fetches,
explicit backfills, and day-to-day operations, the local repository
accumulates blobs that may no longer be needed. There is currently no
mechanism to drop these blobs back to a promised-but-absent state. The
only option is a fresh re-clone, which is disruptive and expensive.

The gap is the reverse of git backfill: backfill moves objects from
promisor-promised to locally-present and this project moves them back.

---

4. GETTING STARTED PROGRESS

The project ideas page listed specific steps to get started. I have
completed all of them:

  - Built Git from source and ran the full test suite.

  - Set up a partial clone experiment: created a local promisor remote
    via file://, cloned with --filter=blob:none, triggered lazy fetches,
    and inspected the resulting .promisor sidecar files to understand
    how the promisor contract works at the file level.

  - Studied builtin/backfill.c end to end, along with
    promisor-remote.c, list-objects-filter.c, and
    Documentation/technical/partial-clone.txt.

  - Submitted a micro-patch series (see Section 6) that was accepted
    and merged to master.

  - Read the partial clone and Protocol v2 documentation thoroughly.

---

5. TECHNICAL APPROACH

The full flow, at a high level:

  1. Enumerate locally-held blobs above a size threshold.
  2. Verify each candidate is available on the promisor remote.
  3. Write a .promisor sidecar registering dropped OIDs as promised.
     (This must happen before removal. See Section 5.3.)
  4. Remove confirmed blobs from local storage.
  5. Enforce safety guards.

---

5.1 Blob Enumeration

A naive object walk using traverse_commit_list() on a partial clone
would hit missing trees and blobs and trigger a lazy-fetch storm, which
is the opposite of what we want. The enumeration must stay strictly
local.

We achieve this by passing OBJECT_INFO_SKIP_FETCH_OBJECT to
oid_object_info_extended(), the same approach used by
remove_fetched_oids() in promisor-remote.c. This ensures we only
evaluate blobs that are physically present on disk and never touch the
promisor machinery during enumeration.

The goal is to collect blob OIDs that exceed a configurable size
threshold and are currently locally present, meaning they are not
already in a promised/missing state.

---

5.2 Remote Availability Verification

Before removing anything, we confirm the promisor remote holds each
candidate blob. We use the Protocol v2 "object-info" capability, which
lets us query the remote for object metadata without downloading the
object bodies, in a single batched round trip.

For v1, Protocol v2 object-info will be a hard requirement. The
conservative local-graph fallback considered in earlier drafts is
brittle in a partial clone context -- walking trees we do not have
locally would either fail or trigger fetches -- and the safety
guarantee it provides is weaker. Making object-info mandatory ensures
we only drop what we can explicitly confirm the remote has.

---

5.3 Re-entering the Promisor Contract (write before delete)

After removal, any access to a dropped blob must trigger a lazy fetch
via promisor_remote_get_direct() rather than a hard "object missing"
error. To achieve this, we write a new (possibly empty) packfile with a
.promisor sidecar that lists the dropped OIDs.

The write-before-delete ordering is the most critical part of the
implementation. The .promisor sidecar must be written and fsynced before
any object is physically removed. If a crash or interrupt happens in a
window where an object is neither locally present nor promised, the
repository ends up in an unrecoverable state.

This ordering also handles the race condition where a concurrent
operation (such as a merge or rebase) starts mid-cleanup and suddenly
needs a blob we just deleted. Because the OID is already in the
.promisor file before deletion, the concurrent operation will not hit a
fatal "object missing" error -- it will simply trigger the lazy-fetch
machinery and re-fetch the blob transparently. The repository stays in
a consistent state regardless of when the concurrent operation starts.

For packfile removal, the existing .keep and lock mechanisms in the
repack machinery provide protection against GC collisions.

---

5.4 Object Removal

Two cases must be handled:

  a) Loose objects: compute the path via oid_to_path() (correct for
     both SHA-1 and SHA-256) and unlink it.

  b) Packed objects: a single object cannot be surgically removed from
     a packfile. Instead, we drive the repack machinery in
     builtin/repack.c to produce a new pack that excludes the target
     OIDs. The --filter mechanism on git pack-objects already supports
     object exclusion and can be driven with an explicit OID list.

---

5.5 Safety Guards

  - No in-progress operation: refuse if MERGE_HEAD, CHERRY_PICK_HEAD,
    REVERT_HEAD, or rebase-merge/ is present under .git/. Removing
    objects mid-operation could corrupt an otherwise-recoverable state.
    Note that the write-before-delete ordering (Section 5.3) handles
    the case where such an operation starts after cleanup has begun.

  - Index safety: by default, refuse to drop blobs referenced by the
    current index (read via read_cache()). An explicit flag can override
    this for users who understand the implications.

  - Remote reachability: refuse if the promisor remote is not reachable
    at invocation time. Objects should not be dropped if they cannot be
    immediately re-fetched when needed.

  - Dry-run (--dry-run): enumerate and verify candidates, print what
    would be removed and the estimated space reclaimed, without touching
    any objects.

---

5.6 Command Placement

The project description explicitly leaves placement as an open design
question. I will send a design email to the list during the bonding
period and defer to community feedback before writing any code.

Based on the discussion with Karthik, git maintenance is the
primary candidate. Space reclamation is fundamentally a housekeeping
operation that fits naturally alongside existing maintenance tasks such
as loose-objects and incremental-repack. It can be registered as an
opt-in task (e.g., 'git maintenance run --task=drop-promisor-blobs')
and scheduled for periodic execution. The design discussion will
finalize the exact interface.

---

6. MICRO-PROJECT

As the required GSoC qualification task, I submitted a two-patch series
to modernize t/t3700-add.sh:

  [PATCH v3 1/2] t3700: avoid suppressing git's exit code
  [PATCH v3 2/2] t3700: use test_grep helper for better diagnostics

  Message-ID: <20260303204029.52952-1-r.siddharth.shrimali@gmail.com>
  Link: https://lore.kernel.org/git/20260303204029.52952-1-r.siddharth.shrimali@gmail.com/

Patch 1 breaks pipelines of the form "git foo | grep bar" that silently
swallow git's exit code, by redirecting git output to a temp file and
grepping that. Patch 2 replaces all plain grep / ! grep calls with the
test_grep helper for better failure diagnostics. The series was iterated
to v3 incorporating structural feedback from Junio C Hamano.

Status: Merged to master.

I have also contributed several other patches to Git since March 2026,
including a C code fix in builtin/submodule--helper.c, test
modernizations in t3200 and t9123, work on builtin/backfill.c, and
notably in t/t0410-partial-clone.sh which is directly relevant to this
project. Full details are in Section 9.

---

7. DELIVERABLES

The deliverables section lists the concrete outputs I commit to
producing by the end of the project. This is what both the mentors and
I can use to track progress and evaluate success.

  1. A design email to git@vger.kernel.org during the bonding period
     covering interface, command placement, safety model, and
     write-before-delete ordering, with community sign-off before any
     implementation begins.

  2. Core logic: blob enumeration using OBJECT_INFO_SKIP_FETCH_OBJECT,
     remote availability verification via Protocol v2 object-info,
     .promisor sidecar write, and safe removal of loose and packed
     objects.

  3. Command integration: wired into the agreed-upon command surface
     (git maintenance task as primary candidate).

  4. A comprehensive test suite covering: basic drop and re-fetch,
     dry-run, size filtering, safety guard rejections, SHA-256
     compatibility, loose and packed object cases, and
     write-before-delete crash safety.

  5. Documentation: man page updates for the modified command(s) and
     updates to Documentation/technical/partial-clone.txt describing the
     new object lifecycle (fetch -> hold -> drop -> re-fetch).

---

8. TIMELINE (175 hours)

In Progress (Now - May 1)

  - Continue submitting patches to the list while selections are pending.
  - Read builtin/repack.c and the Protocol v2 object-info code so the
    bonding period can focus on design rather than catching up on reading.
  - Experiment with .promisor sidecar files hands-on and draft the design
    email early so it is ready to send on day one of bonding.

Community Bonding Period (May 1 - May 26)

  - Go deeper into promisor-remote.c, builtin/backfill.c,
    builtin/repack.c, and list-objects-filter.c with the specific goal
    of understanding the exact call chains relevant to this project.
  - Trace the full lazy-fetch path in a debugger end to end.
  - Send the design proposal to the list and incorporate feedback before
    writing any implementation code.

Week 1-2 (May 27 - June 9) | Blob enumeration

  - Implement blob enumeration using oid_object_info_extended() with
    OBJECT_INFO_SKIP_FETCH_OBJECT, collecting locally-present blob OIDs
    above the size threshold without triggering lazy fetches.
  - Tests: correct OIDs collected, size filter respected, already-missing
    blobs excluded, no lazy fetches triggered during enumeration.

Week 3-4 (June 10 - June 23) | Remote verification

  - Implement remote availability check via Protocol v2 object-info,
    batched for efficiency.
  - Tests: mock promisor remote, batch query correctness, rejection of
    candidates the remote does not have.

Week 5-6 (June 24 - July 7) | Removal and re-promisor

  - Implement .promisor sidecar write for candidate OIDs (before removal).
  - Implement loose object removal (oid_to_path + unlink).
  - Implement packed object removal by driving repack with an OID
    exclusion list.
  - Tests: loose drop + re-fetch, packed drop + re-fetch, lazy fetch
    triggers correctly after drop, write-before-delete ordering safety.
  - Send an interim patch series to the list for early review.

Week 7-8 (July 8 - July 21) | Safety checks and command wiring

  - Implement all safety guards: in-progress operation detection, index
    blob check, remote reachability check.
  - Implement --dry-run.
  - Wire core logic into the agreed command surface with flags:
    --filter, --dry-run, --verbose.
  - Midterm evaluation: working prototype, tests passing, docs draft.

Week 9-10 (July 22 - August 4) | Edge cases and review

  - Handle edge cases: multiple worktrees, alternates, submodules with
    their own promisor remotes, SHA-256 repositories.
  - Address mailing list review feedback from the interim series.
  - Performance testing on a repository with many locally-held blobs.

Week 11-12 (August 5 - August 18) | Documentation and cleanup

  - Write and finalize man page documentation.
  - Update Documentation/technical/partial-clone.txt.
  - Final patch series submission incorporating all review feedback.

Buffer (August 19 - August 25)

  - Address any remaining review comments.
  - Ensure all tests pass on CI for both SHA-1 and SHA-256.
  - Final evaluation submission.

---

9. MY CONTRIBUTIONS TO GIT

I have been contributing to Git since early March 2026. All patches
were submitted to git@vger.kernel.org and iterated through review with
Junio C Hamano, Jeff King, Patrick Steinhardt, Derrick Stolee, and
Phillip Wood.

Merged to master:

  1. [PATCH v3] t3700: avoid suppressing git's exit code (2-patch series)
     Message-ID: <20260303204029.52952-1-r.siddharth.shrimali@gmail.com>
     Link: https://lore.kernel.org/git/20260303204029.52952-1-r.siddharth.shrimali@gmail.com/
     (See Section 6 for full description. This is my micro-project.)
     Status: Merged to master.

  2. [PATCH] t9123: use test_when_finished for cleanup
     Message-ID: <20260305125408.16958-1-r.siddharth.shrimali@gmail.com>
     Link: https://lore.kernel.org/git/20260305125408.16958-1-r.siddharth.shrimali@gmail.com/
     Moved bare setup code in t9123 that ran outside any test block into
     a proper test_expect_success block. Used test_when_finished to
     register cleanup of the 'import' directory, ensuring it runs even
     if the test fails, replacing a manual rm -rf that could be skipped
     on failure.
     Status: Merged to master.

  3. [PATCH v2] t: fix "that that" typo in lib-unicode-nfc-nfd.sh
     Message-ID: <20260302192627.83631-1-r.siddharth.shrimali@gmail.com>
     Link: https://lore.kernel.org/git/20260302192627.83631-1-r.siddharth.shrimali@gmail.com/
     Fixed an unintentional repeated-word typo in t/lib-unicode-nfc-nfd.sh.
     v1 over-reached by also fixing "that that" in two other files where
     the phrasing was grammatically intentional; v2 correctly scoped the
     change after re-reading the context.
     Status: Merged to master.

  4. [PATCH v2] submodule--helper: replace malloc with xmalloc
     Message-ID: <20260310164412.47403-1-r.siddharth.shrimali@gmail.com>
     Link: https://lore.kernel.org/git/20260310164412.47403-1-r.siddharth.shrimali@gmail.com/
     Replaced a raw malloc() in submodule_summary_callback() with
     xmalloc(), which calls die() on allocation failure rather than
     returning NULL and risking a NULL dereference. Also used sizeof(*temp)
     instead of the explicit struct name, and dropped the redundant C cast
     on the xmalloc() return. Improved the commit message in v2 to explain
     the reasoning behind removing the cast, as requested by Junio.
     Status: Merged to master.

  5. [PATCH v2] t3200: replace hardcoded null OID with $ZERO_OID
     Message-ID: <20260311174120.76871-1-r.siddharth.shrimali@gmail.com>
     Link: https://lore.kernel.org/git/20260311174120.76871-1-r.siddharth.shrimali@gmail.com/
     Replaced a hardcoded 40-zero string in t/t3200-branch.sh with
     $ZERO_OID to make the test hash-algorithm independent. The 40-char
     string caused premature failure under SHA-256 because Git reports
     "malformed object name" (40 vs 64 chars) before reaching the actual
     object-type check. Using $ZERO_OID with test_grep for the "must
     point to a commit" error ensures the test validates the right failure
     mode. Suggested-by Patrick Steinhardt.
     Status: Merged to master.

  6. [PATCH v3] t0410: modernize delete_object helper
     Message-ID: <20260313053159.36492-1-r.siddharth.shrimali@gmail.com>
     Link: https://lore.kernel.org/git/20260313053159.36492-1-r.siddharth.shrimali@gmail.com/
     Modernized the delete_object helper in t/t0410-partial-clone.sh,
     the primary test file for partial clones and directly relevant to
     this project, by replacing a fragile manual sed-based object path
     calculation with test_oid_to_path, making the helper correct for
     both SHA-1 and SHA-256. Added 'local' variable declarations with
     proper quoting for shell portability. Suggested-by Jeff King, who
     also caught that unquoted 'local' assignments are flagged by
     check-non-portable-shell. This patch prompted Junio to add a note
     to Documentation/SubmittingPatches reminding contributors to run
     'make test' from the top level.
     Helped-by: Pushkar Singh.
     Status: Merged to master.

  7. [PATCH v3] backfill: handle unexpected arguments
     Message-ID: <20260321031643.5185-1-r.siddharth.shrimali@gmail.com>
     Link: https://lore.kernel.org/git/20260321031643.5185-1-r.siddharth.shrimali@gmail.com/
     Added a check in cmd_backfill() to report an error and print the
     short usage string if any unexpected non-option arguments are passed.
     Iterated to v3 incorporating feedback from Junio C Hamano (error
     message style, usage() vs usage_with_options()) and Phillip Wood
     (test_grep usage in tests). The patch was dropped after Derrick
     Stolee pointed out an in-flight series adding revision arguments to
     git backfill, making a hard rejection of positional arguments wrong.
     However, the report directly motivated Derrick to add a test for
     this behavior in his series, where I am credited as Reported-by.
     Status: Dropped, but credited as Reported-by in Derrick Stolee's
     series at:
     https://lore.kernel.org/git/9699650aa7dc04cf1cdc26803caa8304b29c1662.1774266019.git.gitgitgadget@gmail.com/

Collaboration:

  8. Helped with [PATCH v5] help: cleanup the construction of keys_uniq
     Message-ID: <20260311192453.62213-1-amishhhaaaa@gmail.com>
     Link: https://lore.kernel.org/git/20260311192453.62213-1-amishhhaaaa@gmail.com/
     (patch by Amisha Chhajed). Suggested moving strbuf initialization
     and release out of the inner loop to reuse the same buffer across
     iterations, avoiding repeated alloc/free overhead. Listed as
     Suggested-by in the patch.
     Status: Merged to master.

Patch #6 is worth highlighting separately: working on
t0410-partial-clone.sh required reading the entire file carefully,
understanding how promisor remote tests are structured, and reasoning
about hash-algorithm independence in the partial clone context. That
work gives me a direct head start on the test infrastructure for this
project.

---

10. RELEVANT EXPERIENCE

C and shell (bash/POSIX sh) are my primary languages for this project.
My submodule--helper patch (patch #4 above) demonstrates comfort with C
memory management patterns in Git's codebase (xmalloc/die() convention,
sizeof(*ptr) idiom, implicit void* promotion). My test patches
demonstrate hands-on familiarity with Git's shell test framework:
test_grep, test_oid_to_path, test_must_fail, test_when_finished, and the
portability rules enforced by check-non-portable-shell. I am also
familiar with Go, which gives me a general systems programming background.

I have submitted patches through multiple review cycles on the mailing
list, incorporated feedback from senior maintainers, and am comfortable
with the in-reply-to threading conventions and interdiff-based review
process.

You can find all my patches at:
https://lore.kernel.org/git/?q=Siddharth+Shrimali

---

11. AVAILABILITY

I can commit 25-30 hours per week to GSoC during the coding period
(May-August). My 4th semester exams conclude by mid-May, so I will be
partly available at the start and fully available from mid-May onward
with no academic conflicts through the end of summer. I have no
internships, part-time work, or other commitments planned for this
period.

I will send a brief weekly status update to my mentors and post
questions or design discussions to the mailing list as they come up, to
stay unblocked and keep the community informed of progress.

---

12. WHY THIS PROJECT

I have been using Git for a while, but it was only when I started
contributing patches that I actually began reading its internals. Partial
clone was one of the first areas I looked at carefully, partly because of
the t0410 patch and partly out of genuine curiosity. As I read
promisor-remote.c and backfill.c, the missing reverse direction became
clear. Backfill exists, but its counterpart does not. That felt like an
unfinished thought.

I find the write-before-delete ordering problem genuinely interesting. It
is one of those situations where the obvious implementation is wrong, and
getting it right requires careful reasoning about crash recovery. The same
is true for packed object removal, where you cannot simply delete one
object and call it done. These are exactly the kinds of problems I enjoy
thinking through.

I also want to be candid that I do not yet know every corner of this
codebase. There will be parts of the implementation where I will need
guidance. That is exactly why I want to use the bonding period to read,
experiment, and deepen my understanding before writing any implementation
code, and why the design discussion on the list matters to me. I would
much rather understand the problem thoroughly than rush into code that
later has to be thrown away.

---

Thank you for your time and for considering my proposal. I have genuinely
enjoyed contributing to Git over the past few weeks and I am looking
forward to doing more of it, with or without GSoC.
If you have any questions or if there is anything missing from this proposal,
I am happy to follow up on the list.

---

Siddharth Shrimali
r.siddharth.shrimali@gmail.com
