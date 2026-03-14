Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098D02FD660
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 20:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773520525; cv=pass; b=e/JyavUXHEV0esEFdZW8IA+HbF1LeVjQjNbG9yt3B2g3qtUcfUAT8LqLmdkW76T0vjmu6Zp7e1KVxd056eh5QRweb00ytdHoUM3wwWXfxfRNwnT4B5xKhePSap42P4ST7a1E8PsFmuEV492WJpthBuYCI5FHSsq4nSHhROjMemg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773520525; c=relaxed/simple;
	bh=c0Gcyv6F/zgRG0MeYGPNt0eW4Jwu+qlHirlouHN0Dwk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=SkzE5Uec5TfgRKvzMB+KSEN2O046p0eM1k+oq9BiehsCF84r+5war070V2p0je1nOE+MFBEtVgRuSiDmk0ViO3kUfdjQosReNM5eJyQPhdf2/biie/mLpCEr5L5eM5LCsxr2HQR5ckcjnS+44k33I1BJNAOWx51esUVAj5thkW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lP2m+2dy; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lP2m+2dy"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82748257f5fso2515919b3a.1
        for <git@vger.kernel.org>; Sat, 14 Mar 2026 13:35:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773520522; cv=none;
        d=google.com; s=arc-20240605;
        b=N99ZBLfx0aajDuuJXYmSuqWGWq6hQMA6WkiUQ9yBfdiMmfe5/7E8n/frYOPgqawrRf
         EBhBfqNvJHQjvyagcf59kSHFxDprESHzRtEgeNqowcUyMe11NqSbm93YiaIpTbd6Gg3w
         DF7P5Z73y2YemeGVesE3vPTDEaIFQzuWQzB8RVHaWYL62PgQ/kHJdUWvaofOWArCLlKS
         NbIJozB7S8J77kGZgAb93GwqfEeNbOI8G4qWwWbOIw4CWyseHcZCtd0raPS7SJBHfvF+
         j8yvHdBilNHColBNaUMaRklpnVt6+ADIWaYch2bRyt/9fEe0Uulhsmzr+yQw9HoZGHlY
         66Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=vhmaHmdxENshQfrEx7+r+CvZcOYESlf1OqcUVpexvkU=;
        fh=eIy4VeAwN6tlopRkgkUzk/6xxMToduklJG0Df4w4k48=;
        b=j+r2W5yw1EBXq3pAuuBvh2ef1/UlM3Tj8wNUdMDK5ppqbgIXjCHRyNyUfMVmNMorS2
         E+uguffKQpCh7gXZ3K2ar3xQ3t8K03EgWOtsYJCO7DVxpp44xhT4LZpCjFHng7PLkHbQ
         bIAQn91zF/k+bdyxj/u62uJ3sEMARyhXSwJ5ZFxTj1afsg6aOT4Em5n+DKZEkFoR1V/j
         igpTddQpxMBk5+VgtZ1IPSg77GG/GzGeCUwOJLEwP7jmFb9CNVWhU4n8LNfur62yXJPg
         Ogudl7dQUSzdgI9mJEETZj1icByZRfo2/bS1+raGZfZMvtEU+XW0WYT9t284oTMwbZCx
         kxEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773520522; x=1774125322; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vhmaHmdxENshQfrEx7+r+CvZcOYESlf1OqcUVpexvkU=;
        b=lP2m+2dyaQHTZEgoMN85d3ARgPypYe7U1N7t+bnkkPulyvlxOilMknmzjS4JDmeRE6
         wNznVfnhQqT7Ov2ujYiRnEVmRJPmfo/anhiY7QcaHvYcYrhpi0YQbNzQOdaqx2+mmFvw
         yirb/mw+XeLWb1d18O1KJl8L8i4OhggpF0AviNmTIrZwmcpATfGUW8BydxQQQfHWTgHW
         5qXZZFDXcmSLhXhmFs+QigTf5J9e2hc7iEhnuJPuDFT3yKiHuV9QGB8cbRdqvt7OlOSs
         UHb/JSMLSLwv68XhU1PPe1GY2rTfzysG/qr987vluuZIWHphwX4RvYYyJcwN3gI8+OE/
         hvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773520522; x=1774125322;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vhmaHmdxENshQfrEx7+r+CvZcOYESlf1OqcUVpexvkU=;
        b=PtJKfsgT+xlhaPvWKr04YiF8uWbHXAsCHO2QN/ACwRDMbWCvBPYkkwMyk0KIrJCZN0
         0KAUnr3GN5tv5YOZlN3+eM9Y2t9IkJ/r/MyLTAG4jNiVRHuYyFne6QGouzsLG9JnbVeT
         rTKqYXJlTM2GkZ2VePTskmwMmlwO2W+XTYruACp9+UYnQB8tm9MamQzcZpjFap0pYU3B
         cbHDNNlI9TitqTg7RlDO0NICbSj0ElKQLDJS2tVNDnxLJBLg+Erl1zvuKHiH0IjWlYLH
         ZRkSyq7HIPQN6R6VqJHvLg+i/4DQS9iwxZ5XrbahVwrWjgDAwsPsAxjJ1/fgDOvL/GCN
         Zjaw==
X-Gm-Message-State: AOJu0YzdYeqtFrQMTdxJbW/rH4vXq9UrAT/01CIup0bfk2KcvNo5pOPQ
	GX2AEV80xSJ62A732GoIINapewtxK9WgadUL5XRyaoK3GYWqNISzdwWFEuD9Etlfu7pZCfuMFUc
	IveWYq+kWaz2s7VB15essvwoDLos+mP6ZOw7oF554cA==
X-Gm-Gg: ATEYQzz8sM8JwR+iWFPlIUCy+Z2s0DcoO6FAZTVPzjFlJss3/yodn+f18FPHG32f9C1
	rSqkJAWcqzIPdf9L9Y4nhmZnzvsmOQuYP5+4ahdTAkaLNaH1yDC3t1WSFe3t7DNJAcgVZf/ZTCQ
	pEHhWmjkmkN3qrM9EJvLlV0BiyttBx23y2ecLSYJvdPGuDwlPczuhFLV7WEDMhTfOxcYHZN41nv
	N3dd620xmN0DTIi5DxG884fLIOGUoeMCrO4UPSzk71H/uB8C21IWH1zgAvoKsgSIUf81GJY/CsK
	0AOfPC+hRLGhR/N3z0QOBk5gEckmG2Be2Kp1g1pDpfSOzW0+PPC6vQO7qdKCdkytfK5CxBbhrlA
	Q2XBA16JC+4h/cnbuF0bl0LIx3Q==
X-Received: by 2002:a05:6a00:c90:b0:827:26b6:c11f with SMTP id
 d2e1a72fcca58-82a072febb1mr11535828b3a.31.1773520521694; Sat, 14 Mar 2026
 13:35:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Date: Sun, 15 Mar 2026 02:04:44 +0530
X-Gm-Features: AaiRm53XER9Cfe7wdFNxre-4Nj5k9hehNU-9uISmNEuFpPa5XAz9J_hsJvIZPbk
Message-ID: <CAGWgyh-NASOa+6NPhQHCte2_A7OkNm1r2qAov3Kn1+r1d25hYw@mail.gmail.com>
Subject: [GSoC Proposal] Improve Disk Space Recovery for Partial Clones
To: git@vger.kernel.org
Cc: christian.couder@gmail.com, karthik nayak <karthik.188@gmail.com>, jltobler@gmail.com, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, Ayush Chandekar <ayu.chandekar@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hello Git Community,

I am Siddharth Shrimali, a contributor currently focused on the
partial clone subsystem and test modernization (most recently the
t0410 series). I would like to submit my proposal for GSoC 2026:
'Improve Disk Space Recovery for Partial Clones.'

I've had a great experience collaborating with the community so far
and would appreciate any feedback or suggestions on the technical
approach outlined below.

---

1. PERSONAL INFORMATION

Name:       Siddharth Shrimali
Email:        r.siddharth.shrimali@gmail.com
GitHub:      https://github.com/siddharthshrimali
LinkedIn:    https://www.linkedin.com/in/siddharthshrimali/
University:  Walchand College of Engineering, India
Degree:      B.Tech, Computer Science and Engineering
             (2nd year, 4th semester)
Timezone:  IST (UTC+5:30)

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
Languages: C, shell (bash/POSIX sh).
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

Walk the object graph from all local refs using traverse_commit_list()
in list-objects.c, with a size-based filter consistent with the existing
blob:limit=N syntax from list-objects-filter.c. The goal is to collect
blob OIDs that exceed the threshold and are currently locally present,
meaning they resolve via find_pack_entry() or as a loose object, and are
not already in a promised/missing state.

---

5.2 Remote Availability Verification

Before removing anything, we confirm the promisor remote holds each
candidate blob. The cleanest way to do this is the Protocol v2
"object-info" capability, which lets us query the remote for object
metadata without downloading the object bodies, in a single batched
round trip.

For remotes that do not advertise object-info, a conservative fallback
applies: if a blob is reachable from a commit the remote has, and the
remote's advertised filter covers that object, its presence on the
remote is implied.

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
period and defer to community feedback before writing any code. My
current thinking is:

  - A new option on git backfill (e.g., --drop-blobs): backfill fills
    objects in; this flag drains them back out. The symmetry is clean
    and the command is already familiar to users working with partial
    clones.

  - An opt-in git maintenance task for scheduled periodic space
    reclamation, wrapping the same core logic.

---

6. MICRO-PROJECT

As the required GSoC qualification task, I submitted a two-patch series
to modernize t/t3700-add.sh:

  [PATCH v3 1/2] t3700: avoid suppressing git's exit code
  [PATCH v3 2/2] t3700: use test_grep helper for better diagnostics

  Message-ID: <20260303204029.52952-1-r.siddharth.shrimali@gmail.com>
  Link: https://lore.kernel.org/git/20260303204029.52952-1-r.siddharth.shrimali@gmail.com/

Patch 1 breaks pipelines of the form "git foo | grep bar" that silently
swallows git's exit code, by redirecting git output to a temp file and
grepping that. Patch 2 replaces all plain grep / ! grep calls with the
test_grep helper for better failure diagnostics. The series was iterated
to v3 incorporating structural feedback from Junio C Hamano.

Status: Merged to master.

I have also contributed several other patches to Git since February
2026, including a C code fix in builtin/submodule--helper.c, test
modernizations in t3200 and t9123, and notably in
t/t0410-partial-clone.sh which is directly relevant to this project.
Full details are in Section 9.

---

7. DELIVERABLES

The deliverables section lists the concrete outputs I commit to
producing by the end of the project. This is what both the mentors and
I can use to track progress and evaluate success.

  1. A design email to git@vger.kernel.org during the bonding period
     covering interface, command placement, safety model, and
     write-before-delete ordering, with community sign-off before any
     implementation begins.

  2. Core logic: blob enumeration, remote availability verification
     (Protocol v2 object-info + fallback), .promisor sidecar write, and
     safe removal of loose and packed objects.

  3. Command integration: wired into the agreed-upon command surface
     (git backfill option and/or git maintenance task).

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

  - Implement blob enumeration via traverse_commit_list() with a size
    filter, collecting locally-present blob OIDs above the threshold.
  - Tests: correct OIDs collected, size filter respected, already-missing
    blobs excluded.

Week 3-4 (June 10 - June 23) | Remote verification

  - Implement remote availability check via Protocol v2 object-info,
    batched for efficiency.
  - Implement the conservative reachability-implies-presence fallback.
  - Tests: mock promisor remote, batch query correctness, fallback path.

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
Junio C Hamano, Jeff King, and Patrick Steinhardt.

Merged to master:

  1. [PATCH v3] t3700: avoid suppressing git's exit code (2-patch series)
     <20260303204029.52952-1-r.siddharth.shrimali@gmail.com>
     (See Section 6 for full description. This is my micro-project.)
     https://lore.kernel.org/git/20260303204029.52952-1-r.siddharth.shrimali@gmail.com/
     Status: Merged to master.

  2. [PATCH] t9123: use test_when_finished for cleanup
     <20260305125408.16958-1-r.siddharth.shrimali@gmail.com>
     Moved bare setup code in t9123 that ran outside any test block into
     a proper test_expect_success block. Used test_when_finished to
     register cleanup of the 'import' directory, ensuring it runs even
     if the test fails, replacing a manual rm -rf that could be skipped
     on failure.
     https://lore.kernel.org/git/20260305125408.16958-1-r.siddharth.shrimali@gmail.com/
     Status: Merged to master.

  3. [PATCH v2] t: fix "that that" typo in lib-unicode-nfc-nfd.sh
     <20260302192627.83631-1-r.siddharth.shrimali@gmail.com>
     Fixed an unintentional repeated-word typo in t/lib-unicode-nfc-nfd.sh.
     v1 over-reached by also fixing "that that" in two other files where
     the phrasing was grammatically intentional; v2 correctly scoped the
     change after re-reading the context.
     https://lore.kernel.org/git/20260302192627.83631-1-r.siddharth.shrimali@gmail.com/
     Status: Merged to master.

Queued for master / next:

  4. [PATCH v2] submodule--helper: replace malloc with xmalloc
     <20260310164412.47403-1-r.siddharth.shrimali@gmail.com>
     Replaced a raw malloc() in submodule_summary_callback() with
     xmalloc(), which calls die() on allocation failure rather than
     returning NULL and risking a NULL dereference. Also used sizeof(*temp)
     instead of the explicit struct name, and dropped the redundant C cast
     on the xmalloc() return. Improved the commit message in v2 to explain
     the reasoning behind removing the cast, as requested by Junio.
     https://lore.kernel.org/git/20260310164412.47403-1-r.siddharth.shrimali@gmail.com/
     Status: Will merge to next.

  5. [PATCH v2] t3200: replace hardcoded null OID with $ZERO_OID
     <20260311174120.76871-1-r.siddharth.shrimali@gmail.com>
     Replaced a hardcoded 40-zero string in t/t3200-branch.sh with
     $ZERO_OID to make the test hash-algorithm independent. The 40-char
     string caused premature failure under SHA-256 because Git reports
     "malformed object name" (40 vs 64 chars) before reaching the actual
     object-type check. Using $ZERO_OID with test_grep for the "must
     point to a commit" error ensures the test validates the right failure
     mode. Suggested-by Patrick Steinhardt.
     https://lore.kernel.org/git/20260311174120.76871-1-r.siddharth.shrimali@gmail.com/
     Status: Will merge to master.

  6. [PATCH v3] t0410: modernize delete_object helper
     <20260313053159.36492-1-r.siddharth.shrimali@gmail.com>
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
     https://lore.kernel.org/git/20260313053159.36492-1-r.siddharth.shrimali@gmail.com/
     Status: Good to go to next.

Collaboration:

  7. Helped with [PATCH v5] help: cleanup the construction of keys_uniq
     <20260311192453.62213-1-amishhhaaaa@gmail.com>
     (patch by Amisha Chhajed). Suggested moving strbuf initialization
     and release out of the inner loop to reuse the same buffer across
     iterations, avoiding repeated alloc/free overhead. Listed as
     Suggested-by in the patch.
     https://lore.kernel.org/git/20260311192453.62213-1-amishhhaaaa@gmail.com/
     Status: Will merge to next.

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
If you have any questions or if there is anything missing from this
proposal, I am happy to follow up on the list.

---

Siddharth Shrimali
r.siddharth.shrimali@gmail.com
