Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88936366562
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 23:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773702329; cv=pass; b=RncTNRB09ReSIADgPYGK1PtjGlSA6DBAfeVjkXAddiYd8ZHTxI9PkAiBD8tRaR/ueJfOp+K2yDsXgXb7m+20lmeBDyB0ueX0hDlEpfWgJ6rPCdfyz8B1+juIL68LtE0de5INRUAS6eY9xSjFiVj6VJdUP5KgPJbkkWVryOrX7Cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773702329; c=relaxed/simple;
	bh=JmOwc8o7nNzrTUuzy21ny/OJdNl4/7BxNUMmW+ALmXQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kx6ik0JLV45xKPGrPS8Sdc3mrhxl8H90JtRIc2r8RDwx8bhVGQ7QFp+UJBH44Q+gP4U9NLBiWFz46a/0qBr9Fns3qvVJIi8BlwaFsrnIS+ME+8TLOF/S6y1gfBu2VLhv8tS2kZkQKfSw9D2grAivZNbyfHNMsseeGVt1BJxSJts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhXdOeOA; arc=pass smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhXdOeOA"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-94abd52b274so1189133241.3
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 16:05:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773702326; cv=none;
        d=google.com; s=arc-20240605;
        b=aAlQiUE2o1WTMIGmT89QRbxBSoeGA6Bv1jYkBI3whRVGyjaj1XFxN7H4wBnVQDWC3+
         y+Owth0NdwKJP6dnGBM/+riYc1F+A2BrY8z/KIjCrNMwKi9GyxuZawTvpH6VCbtuGfat
         3D4ZCz4RDy7xcoHVT+xa/2w1jEWz3zohG+d7AqW5KETLQSmaqUpVCw4Zv3YAC78JMbza
         FM43WTWnXYsZ8fHHlspf1yu2KTOhXJ9zM3pqPFrRVbv8uJxoz3NODecU5GeRrLqgmtY3
         fW8W86w3nKEmQGzT2ly3Fd8FSL1moG36kyliGQDDSlpa89HG8y8oR6krtVWo5Eq7X7G/
         m82g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=+tCCuBf891FsfGTewUCQkw1sSqUEYpJ3EXgspzJKNv0=;
        fh=Ovs8+4Ym6ccsQbJVIHB7w1u+R9QZHrseFNko/F7r8B4=;
        b=UCZp8CbQgwF3m4WhD5dP6GHyo8VnmGKJHWZ3WLvkqfqmB3oYyLr6vprtr6ZDQbnSTG
         2bxryD4FPk1oPMTZVrRYu5iIU1L/Dh/knw4Lrch3whu6EvvUuaTR1I6++rC//0Dm/itu
         1sgZ7nIrqIqcIwklmdV2cmv2dFKeuuCzd4TxIOwpwU9FVy7hDh2+f7rXcfwchWRWcHF5
         g3NQvHJrqLYeDrrQKRKP9hvRUG4EJ+q7tjTbVoypCbPNQ6i7ul2W0iPXTfh0Ie2gboQ5
         p8D2IY8KxFPchZqZvmJTWXUwbMhAUOKvWM67Mp1CzdQ9Yzg4uSzsPJMzaOd0VvZDVUhD
         hN7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773702326; x=1774307126; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+tCCuBf891FsfGTewUCQkw1sSqUEYpJ3EXgspzJKNv0=;
        b=PhXdOeOASuzW/Qvw4jjptMzL08zjaJ3awLSWvvP0+ABqVwqK1bIT4nn5hooUeAmB2R
         5cdChduXQ+7IVqOLkBtsxlEZlJUnoLXYRPuFBpR+sunkXU3lopJiQp+b3tJKXUqRKrkA
         FFfpdas1R3rVcbmEGVWlKWVLIjMNDVyu1HvSa+TRgwwEMwv9HXiMdqSkmn0f9eFfO8Vv
         V01AVRQfBPPngJMyRPgYQxW++OXW9b558jE1WiQZVJTCkRez+kRnPGT1hW3Yo3kY+yC3
         z11BNsVE5U2sw0N7WnKXc50mL1QAJ4qmIj3gTj4RzdQqp1sfUbXwrt5UXlZtL2u1L+3P
         me/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773702326; x=1774307126;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+tCCuBf891FsfGTewUCQkw1sSqUEYpJ3EXgspzJKNv0=;
        b=XqW8tFnc1tnRwF79Yn+GGr/bhrARbSYWPxPs7kCOTCdLfrk6RV4wTSuIVzLd0voFv2
         6QQacgqMwyD20WNENVoC4L4N1Sjil2azSj92RqmmDr2kLOkjIwZkoFaukrn4+N63j9lF
         +6pdSYK/WfxKl2eePg7phAA49OBIWBehkgsUxqr6FCx6yUnbvocHAEru3BOwjU/TavlY
         We6N93yXYJD3WSuGwm0lHDBv0zFBoiZ1/gkQXQ4JjiCR7b0FDuUdWGJN6m3WxwWXwIvy
         PCmkU5vq0wAz9FrYBFvK+IDnsdM6Ph7VS3X6i6/HFwlrrxIBxq45exeenbSrlYbvIKyz
         xzUA==
X-Forwarded-Encrypted: i=1; AJvYcCUShPf8QOq+oU0Vi0N4DRIXfY8d4/bheUEqWulhqJH9g8o0Dqt20Zu9a4IIc8nuZLsie7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAvRtsc8XNAY+lDE+WeTWpNwwpj7uQppaeEP/YJNcfp8Jf8RWz
	9aQCW2inx1wZeAwLnJuqH00FFfAENn9Fp8vTl2q3EWhXbk++jXPCG3eMi+uHoylrR5gEHSg9dzS
	gXGgUaJBfOHptVLLKZyfiS1xneGZKdQA=
X-Gm-Gg: ATEYQzyP0qn+pS3DfHwmSGgll+i7m6nySCD3EB93bOCpncwlWGOcoyqihi6VHynH+ew
	FVDlTecunANo5KA1rHxgFaRO1zD9qbh/Oh/Cbkhl5xTS/thICzsgdJv0c9pUHtRt+ulO1AXepEp
	mVn8bf5DgClZ1Tt/DDrfTVZBirkJV4QH2epDW5gFhUPT5LyM/bNHFj59O1hLwxutwfwqr/+yePs
	eb7duncyr1+pQ9UxikKEzdfia7FV1nB+bo+aG5QfRXuB0A/uW2LTlTkBSV2MuKEojMNSqk0hFew
	BaFnjW6YR129au1VHw0BQqAshBy9ktTSEx28j4O0iA==
X-Received: by 2002:a05:6102:162a:b0:600:a2:138d with SMTP id
 ada2fe7eead31-6020e58555cmr4866962137.19.1773702326183; Mon, 16 Mar 2026
 16:05:26 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Mar 2026 16:05:25 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Mar 2026 16:05:25 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAGWgyh-NASOa+6NPhQHCte2_A7OkNm1r2qAov3Kn1+r1d25hYw@mail.gmail.com>
References: <CAGWgyh-NASOa+6NPhQHCte2_A7OkNm1r2qAov3Kn1+r1d25hYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 16 Mar 2026 16:05:25 -0700
X-Gm-Features: AaiRm50rb8BzhpsYMmPtoH2GknzmF9GALvaYpMV-nV2hecrrjWBwPQLbVb8gKAg
Message-ID: <CAOLa=ZSqQ=w8EVFMUwn5EUfMmNBgzGzG458Ex1ixiBSTiWnWYg@mail.gmail.com>
Subject: Re: [GSoC Proposal] Improve Disk Space Recovery for Partial Clones
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>, git@vger.kernel.org
Cc: christian.couder@gmail.com, jltobler@gmail.com, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, Ayush Chandekar <ayu.chandekar@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000170a4a064d2c419a"

--000000000000170a4a064d2c419a
Content-Type: text/plain; charset="UTF-8"

Siddharth Shrimali <r.siddharth.shrimali@gmail.com> writes:

Hello Siddharth,

> Hello Git Community,
>
> I am Siddharth Shrimali, a contributor currently focused on the
> partial clone subsystem and test modernization (most recently the
> t0410 series). I would like to submit my proposal for GSoC 2026:
> 'Improve Disk Space Recovery for Partial Clones.'
>
> I've had a great experience collaborating with the community so far
> and would appreciate any feedback or suggestions on the technical
> approach outlined below.
>
> ---
>
> 1. PERSONAL INFORMATION
>
> Name:       Siddharth Shrimali
> Email:        r.siddharth.shrimali@gmail.com
> GitHub:      https://github.com/siddharthshrimali
> LinkedIn:    https://www.linkedin.com/in/siddharthshrimali/
> University:  Walchand College of Engineering, India
> Degree:      B.Tech, Computer Science and Engineering
>              (2nd year, 4th semester)
> Timezone:  IST (UTC+5:30)
>
> ---
>
> 2. PROJECT ABSTRACT
>
> Git's partial clone feature lets clients work with large repositories
> without downloading all objects upfront. Objects are fetched lazily from
> promisor remotes as needed, and git backfill can proactively fill them
> in. But the reverse does not exist: once blobs have been fetched, there
> is no way to drop them back to a promised-but-absent state. Over time,
> clients accumulate large locally-held blobs they no longer need, with no
> path to reclaim that space short of a full re-clone.
>
> This project implements that missing direction: a mechanism to safely
> identify blobs that are available on a promisor remote, remove them from
> local storage, and re-enter them into the promisor contract so that the
> existing lazy-fetch infrastructure re-fetches them transparently on next
> access. The result is a reversible partial clone lifecycle.
>
> Project size: 175 hours. Difficulty: Medium to Hard.
> Languages: C, shell (bash/POSIX sh).
> Mentors: Christian Couder, Karthik Nayak, Justin Tobler,
>          Siddharth Asthana, Ayush Chandekar.
>
> ---
>
> 3. PROBLEM STATEMENT
>
> When a user clones with --filter=blob:none, Git records the remote as a
> promisor remote and fetches blobs lazily on demand via
> promisor_remote_get_direct(). Over months of work, through lazy fetches,
> explicit backfills, and day-to-day operations, the local repository
> accumulates blobs that may no longer be needed. There is currently no
> mechanism to drop these blobs back to a promised-but-absent state. The
> only option is a fresh re-clone, which is disruptive and expensive.
>
> The gap is the reverse of git backfill: backfill moves objects from
> promisor-promised to locally-present and this project moves them back.
>
> ---
>
> 4. GETTING STARTED PROGRESS
>
> The project ideas page listed specific steps to get started. I have
> completed all of them:
>
>   - Built Git from source and ran the full test suite.
>
>   - Set up a partial clone experiment: created a local promisor remote
>     via file://, cloned with --filter=blob:none, triggered lazy fetches,
>     and inspected the resulting .promisor sidecar files to understand
>     how the promisor contract works at the file level.
>
>   - Studied builtin/backfill.c end to end, along with
>     promisor-remote.c, list-objects-filter.c, and
>     Documentation/technical/partial-clone.txt.
>
>   - Submitted a micro-patch series (see Section 6) that was accepted
>     and merged to master.
>
>   - Read the partial clone and Protocol v2 documentation thoroughly.
>
> ---
>
> 5. TECHNICAL APPROACH
>
> The full flow, at a high level:
>
>   1. Enumerate locally-held blobs above a size threshold.
>   2. Verify each candidate is available on the promisor remote.
>   3. Write a .promisor sidecar registering dropped OIDs as promised.
>      (This must happen before removal. See Section 5.3.)
>   4. Remove confirmed blobs from local storage.
>   5. Enforce safety guards.
>
> ---
>
> 5.1 Blob Enumeration
>
> Walk the object graph from all local refs using traverse_commit_list()
> in list-objects.c, with a size-based filter consistent with the existing
> blob:limit=N syntax from list-objects-filter.c. The goal is to collect
> blob OIDs that exceed the threshold and are currently locally present,
> meaning they resolve via find_pack_entry() or as a loose object, and are
> not already in a promised/missing state.

How does this work when used on a partial clone with 'blob:none'?

> ---
>
> 5.2 Remote Availability Verification
>
> Before removing anything, we confirm the promisor remote holds each
> candidate blob. The cleanest way to do this is the Protocol v2
> "object-info" capability, which lets us query the remote for object
> metadata without downloading the object bodies, in a single batched
> round trip

Makes sense.

>
> For remotes that do not advertise object-info, a conservative fallback
> applies: if a blob is reachable from a commit the remote has, and the
> remote's advertised filter covers that object, its presence on the
> remote is implied.

How do we know a blob is reachable from a commit that the remote
advertises?

>
> ---
>
> 5.3 Re-entering the Promisor Contract (write before delete)
>
> After removal, any access to a dropped blob must trigger a lazy fetch
> via promisor_remote_get_direct() rather than a hard "object missing"
> error. To achieve this, we write a new (possibly empty) packfile with a
> .promisor sidecar that lists the dropped OIDs.
>
> The write-before-delete ordering is the most critical part of the
> implementation. The .promisor sidecar must be written and fsynced before
> any object is physically removed. If a crash or interrupt happens in a
> window where an object is neither locally present nor promised, the
> repository ends up in an unrecoverable state.
>

Yeah, this makes sense too.

> ---
>
> 5.4 Object Removal
>
> Two cases must be handled:
>
>   a) Loose objects: compute the path via oid_to_path() (correct for
>      both SHA-1 and SHA-256) and unlink it.
>
>   b) Packed objects: a single object cannot be surgically removed from
>      a packfile. Instead, we drive the repack machinery in
>      builtin/repack.c to produce a new pack that excludes the target
>      OIDs. The --filter mechanism on git pack-objects already supports
>      object exclusion and can be driven with an explicit OID list.
>
> ---
>
> 5.5 Safety Guards
>
>   - No in-progress operation: refuse if MERGE_HEAD, CHERRY_PICK_HEAD,
>     REVERT_HEAD, or rebase-merge/ is present under .git/. Removing
>     objects mid-operation could corrupt an otherwise-recoverable state.
>

But couldn't one of these operations start after we start the process of
cleanup?

>   - Index safety: by default, refuse to drop blobs referenced by the
>     current index (read via read_cache()). An explicit flag can override
>     this for users who understand the implications.
>
>   - Remote reachability: refuse if the promisor remote is not reachable
>     at invocation time. Objects should not be dropped if they cannot be
>     immediately re-fetched when needed.
>
>   - Dry-run (--dry-run): enumerate and verify candidates, print what
>     would be removed and the estimated space reclaimed, without touching
>     any objects.
>

Nice.

> ---
>
> 5.6 Command Placement
>
> The project description explicitly leaves placement as an open design
> question. I will send a design email to the list during the bonding
> period and defer to community feedback before writing any code. My
> current thinking is:
>
>   - A new option on git backfill (e.g., --drop-blobs): backfill fills
>     objects in; this flag drains them back out. The symmetry is clean
>     and the command is already familiar to users working with partial
>     clones.
>

I'm not sure if 'git backfill --drop-blobs' makes sense, since the
command talks about filling in data and the flag talks about cleaning up
data. But this seems to be the closest relative.

>   - An opt-in git maintenance task for scheduled periodic space
>     reclamation, wrapping the same core logic.
>

This would be my top pick, seems like data cleanup is definitely a
maintenance task.

> ---
>
> 6. MICRO-PROJECT
>
> As the required GSoC qualification task, I submitted a two-patch series
> to modernize t/t3700-add.sh:
>
>   [PATCH v3 1/2] t3700: avoid suppressing git's exit code
>   [PATCH v3 2/2] t3700: use test_grep helper for better diagnostics
>
>   Message-ID: <20260303204029.52952-1-r.siddharth.shrimali@gmail.com>
>   Link: https://lore.kernel.org/git/20260303204029.52952-1-r.siddharth.shrimali@gmail.com/
>
> Patch 1 breaks pipelines of the form "git foo | grep bar" that silently
> swallows git's exit code, by redirecting git output to a temp file and
> grepping that. Patch 2 replaces all plain grep / ! grep calls with the
> test_grep helper for better failure diagnostics. The series was iterated
> to v3 incorporating structural feedback from Junio C Hamano.
>
> Status: Merged to master.
>
> I have also contributed several other patches to Git since February
> 2026, including a C code fix in builtin/submodule--helper.c, test
> modernizations in t3200 and t9123, and notably in
> t/t0410-partial-clone.sh which is directly relevant to this project.
> Full details are in Section 9.
>
> ---
>
> 7. DELIVERABLES
>
> The deliverables section lists the concrete outputs I commit to
> producing by the end of the project. This is what both the mentors and
> I can use to track progress and evaluate success.
>
>   1. A design email to git@vger.kernel.org during the bonding period
>      covering interface, command placement, safety model, and
>      write-before-delete ordering, with community sign-off before any
>      implementation begins.
>
>   2. Core logic: blob enumeration, remote availability verification
>      (Protocol v2 object-info + fallback), .promisor sidecar write, and
>      safe removal of loose and packed objects.
>
>   3. Command integration: wired into the agreed-upon command surface
>      (git backfill option and/or git maintenance task).
>
>   4. A comprehensive test suite covering: basic drop and re-fetch,
>      dry-run, size filtering, safety guard rejections, SHA-256
>      compatibility, loose and packed object cases, and
>      write-before-delete crash safety.
>
>   5. Documentation: man page updates for the modified command(s) and
>      updates to Documentation/technical/partial-clone.txt describing the
>      new object lifecycle (fetch -> hold -> drop -> re-fetch).
>
> ---
>
> 8. TIMELINE (175 hours)
>
> In Progress (Now - May 1)
>
>   - Continue submitting patches to the list while selections are pending.
>   - Read builtin/repack.c and the Protocol v2 object-info code so the
>     bonding period can focus on design rather than catching up on reading.
>   - Experiment with .promisor sidecar files hands-on and draft the design
>     email early so it is ready to send on day one of bonding.
>
> Community Bonding Period (May 1 - May 26)
>
>   - Go deeper into promisor-remote.c, builtin/backfill.c,
>     builtin/repack.c, and list-objects-filter.c with the specific goal
>     of understanding the exact call chains relevant to this project.
>   - Trace the full lazy-fetch path in a debugger end to end.
>   - Send the design proposal to the list and incorporate feedback before
>     writing any implementation code.
>
> Week 1-2 (May 27 - June 9) | Blob enumeration
>
>   - Implement blob enumeration via traverse_commit_list() with a size
>     filter, collecting locally-present blob OIDs above the threshold.
>   - Tests: correct OIDs collected, size filter respected, already-missing
>     blobs excluded.
>
> Week 3-4 (June 10 - June 23) | Remote verification
>
>   - Implement remote availability check via Protocol v2 object-info,
>     batched for efficiency.
>   - Implement the conservative reachability-implies-presence fallback.
>   - Tests: mock promisor remote, batch query correctness, fallback path.
>
> Week 5-6 (June 24 - July 7) | Removal and re-promisor
>
>   - Implement .promisor sidecar write for candidate OIDs (before removal).
>   - Implement loose object removal (oid_to_path + unlink).
>   - Implement packed object removal by driving repack with an OID
>     exclusion list.
>   - Tests: loose drop + re-fetch, packed drop + re-fetch, lazy fetch
>     triggers correctly after drop, write-before-delete ordering safety.
>   - Send an interim patch series to the list for early review.
>
> Week 7-8 (July 8 - July 21) | Safety checks and command wiring
>
>   - Implement all safety guards: in-progress operation detection, index
>     blob check, remote reachability check.
>   - Implement --dry-run.
>   - Wire core logic into the agreed command surface with flags:
>     --filter, --dry-run, --verbose.
>   - Midterm evaluation: working prototype, tests passing, docs draft.
>
> Week 9-10 (July 22 - August 4) | Edge cases and review
>
>   - Handle edge cases: multiple worktrees, alternates, submodules with
>     their own promisor remotes, SHA-256 repositories.
>   - Address mailing list review feedback from the interim series.
>   - Performance testing on a repository with many locally-held blobs.
>
> Week 11-12 (August 5 - August 18) | Documentation and cleanup
>
>   - Write and finalize man page documentation.
>   - Update Documentation/technical/partial-clone.txt.
>   - Final patch series submission incorporating all review feedback.
>
> Buffer (August 19 - August 25)
>
>   - Address any remaining review comments.
>   - Ensure all tests pass on CI for both SHA-1 and SHA-256.
>   - Final evaluation submission.
>
> ---
>
> 9. MY CONTRIBUTIONS TO GIT
>
> I have been contributing to Git since early March 2026. All patches
> were submitted to git@vger.kernel.org and iterated through review with
> Junio C Hamano, Jeff King, and Patrick Steinhardt.
>
> Merged to master:
>
>   1. [PATCH v3] t3700: avoid suppressing git's exit code (2-patch series)
>      <20260303204029.52952-1-r.siddharth.shrimali@gmail.com>
>      (See Section 6 for full description. This is my micro-project.)
>      https://lore.kernel.org/git/20260303204029.52952-1-r.siddharth.shrimali@gmail.com/
>      Status: Merged to master.
>
>   2. [PATCH] t9123: use test_when_finished for cleanup
>      <20260305125408.16958-1-r.siddharth.shrimali@gmail.com>
>      Moved bare setup code in t9123 that ran outside any test block into
>      a proper test_expect_success block. Used test_when_finished to
>      register cleanup of the 'import' directory, ensuring it runs even
>      if the test fails, replacing a manual rm -rf that could be skipped
>      on failure.
>      https://lore.kernel.org/git/20260305125408.16958-1-r.siddharth.shrimali@gmail.com/
>      Status: Merged to master.
>
>   3. [PATCH v2] t: fix "that that" typo in lib-unicode-nfc-nfd.sh
>      <20260302192627.83631-1-r.siddharth.shrimali@gmail.com>
>      Fixed an unintentional repeated-word typo in t/lib-unicode-nfc-nfd.sh.
>      v1 over-reached by also fixing "that that" in two other files where
>      the phrasing was grammatically intentional; v2 correctly scoped the
>      change after re-reading the context.
>      https://lore.kernel.org/git/20260302192627.83631-1-r.siddharth.shrimali@gmail.com/
>      Status: Merged to master.
>
> Queued for master / next:
>
>   4. [PATCH v2] submodule--helper: replace malloc with xmalloc
>      <20260310164412.47403-1-r.siddharth.shrimali@gmail.com>
>      Replaced a raw malloc() in submodule_summary_callback() with
>      xmalloc(), which calls die() on allocation failure rather than
>      returning NULL and risking a NULL dereference. Also used sizeof(*temp)
>      instead of the explicit struct name, and dropped the redundant C cast
>      on the xmalloc() return. Improved the commit message in v2 to explain
>      the reasoning behind removing the cast, as requested by Junio.
>      https://lore.kernel.org/git/20260310164412.47403-1-r.siddharth.shrimali@gmail.com/
>      Status: Will merge to next.
>
>   5. [PATCH v2] t3200: replace hardcoded null OID with $ZERO_OID
>      <20260311174120.76871-1-r.siddharth.shrimali@gmail.com>
>      Replaced a hardcoded 40-zero string in t/t3200-branch.sh with
>      $ZERO_OID to make the test hash-algorithm independent. The 40-char
>      string caused premature failure under SHA-256 because Git reports
>      "malformed object name" (40 vs 64 chars) before reaching the actual
>      object-type check. Using $ZERO_OID with test_grep for the "must
>      point to a commit" error ensures the test validates the right failure
>      mode. Suggested-by Patrick Steinhardt.
>      https://lore.kernel.org/git/20260311174120.76871-1-r.siddharth.shrimali@gmail.com/
>      Status: Will merge to master.
>
>   6. [PATCH v3] t0410: modernize delete_object helper
>      <20260313053159.36492-1-r.siddharth.shrimali@gmail.com>
>      Modernized the delete_object helper in t/t0410-partial-clone.sh,
>      the primary test file for partial clones and directly relevant to
>      this project, by replacing a fragile manual sed-based object path
>      calculation with test_oid_to_path, making the helper correct for
>      both SHA-1 and SHA-256. Added 'local' variable declarations with
>      proper quoting for shell portability. Suggested-by Jeff King, who
>      also caught that unquoted 'local' assignments are flagged by
>      check-non-portable-shell. This patch prompted Junio to add a note
>      to Documentation/SubmittingPatches reminding contributors to run
>      'make test' from the top level.
>      Helped-by: Pushkar Singh.
>      https://lore.kernel.org/git/20260313053159.36492-1-r.siddharth.shrimali@gmail.com/
>      Status: Good to go to next.
>
> Collaboration:
>
>   7. Helped with [PATCH v5] help: cleanup the construction of keys_uniq
>      <20260311192453.62213-1-amishhhaaaa@gmail.com>
>      (patch by Amisha Chhajed). Suggested moving strbuf initialization
>      and release out of the inner loop to reuse the same buffer across
>      iterations, avoiding repeated alloc/free overhead. Listed as
>      Suggested-by in the patch.
>      https://lore.kernel.org/git/20260311192453.62213-1-amishhhaaaa@gmail.com/
>      Status: Will merge to next.
>
> Patch #6 is worth highlighting separately: working on
> t0410-partial-clone.sh required reading the entire file carefully,
> understanding how promisor remote tests are structured, and reasoning
> about hash-algorithm independence in the partial clone context. That
> work gives me a direct head start on the test infrastructure for this
> project.
>
> ---
>
> 10. RELEVANT EXPERIENCE
>
> C and shell (bash/POSIX sh) are my primary languages for this project.
> My submodule--helper patch (patch #4 above) demonstrates comfort with C
> memory management patterns in Git's codebase (xmalloc/die() convention,
> sizeof(*ptr) idiom, implicit void* promotion). My test patches
> demonstrate hands-on familiarity with Git's shell test framework:
> test_grep, test_oid_to_path, test_must_fail, test_when_finished, and the
> portability rules enforced by check-non-portable-shell. I am also
> familiar with Go, which gives me a general systems programming background.
>
> I have submitted patches through multiple review cycles on the mailing
> list, incorporated feedback from senior maintainers, and am comfortable
> with the in-reply-to threading conventions and interdiff-based review
> process.
>
> You can find all my patches at:
> https://lore.kernel.org/git/?q=Siddharth+Shrimali
>
> ---
>
> 11. AVAILABILITY
>
> I can commit 25-30 hours per week to GSoC during the coding period
> (May-August). My 4th semester exams conclude by mid-May, so I will be
> partly available at the start and fully available from mid-May onward
> with no academic conflicts through the end of summer. I have no
> internships, part-time work, or other commitments planned for this
> period.
>
> I will send a brief weekly status update to my mentors and post
> questions or design discussions to the mailing list as they come up, to
> stay unblocked and keep the community informed of progress.
>
> ---
>
> 12. WHY THIS PROJECT
>
> I have been using Git for a while, but it was only when I started
> contributing patches that I actually began reading its internals. Partial
> clone was one of the first areas I looked at carefully, partly because of
> the t0410 patch and partly out of genuine curiosity. As I read
> promisor-remote.c and backfill.c, the missing reverse direction became
> clear. Backfill exists, but its counterpart does not. That felt like an
> unfinished thought.
>
> I find the write-before-delete ordering problem genuinely interesting. It
> is one of those situations where the obvious implementation is wrong, and
> getting it right requires careful reasoning about crash recovery. The same
> is true for packed object removal, where you cannot simply delete one
> object and call it done. These are exactly the kinds of problems I enjoy
> thinking through.
>
> I also want to be candid that I do not yet know every corner of this
> codebase. There will be parts of the implementation where I will need
> guidance. That is exactly why I want to use the bonding period to read,
> experiment, and deepen my understanding before writing any implementation
> code, and why the design discussion on the list matters to me. I would
> much rather understand the problem thoroughly than rush into code that
> later has to be thrown away.
>
> ---
>
> Thank you for your time and for considering my proposal. I have genuinely
> enjoyed contributing to Git over the past few weeks and I am looking
> forward to doing more of it, with or without GSoC.
> If you have any questions or if there is anything missing from this
> proposal, I am happy to follow up on the list.
>
> ---
>

The rest of this proposal looks good to me!



> Siddharth Shrimali
> r.siddharth.shrimali@gmail.com

Regards,
Karthik

--000000000000170a4a064d2c419a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: dcb94b091c2fb7b6_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tNGpMTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN3pJQy8wU1FLOVlLM0E5UVQxdml5WHEvTVlIeEpyZQpjd2J6NmJyN1dK
WVBDYnR3b2dkbEEvSFNocmVhbTF1Z09xY3F0cVcrTnJzeDJubTRwMUlqUStlaDdCYzFzT2tsCjlu
UjlSMTRsMHpQMmJTNUliUWJ3VllBYlN5UktXMlpWbjQ2UDlVTUVhYzI3MEExOWU1WXowSVo2Zlpx
blZjZ3cKaWdUV0huUnRjQmlHdzhKNU55aENkRmVPd2tNYktyZmI0aTNCb2loaFpoNFVYcWVKTUZM
Vm12a1NxeHdOVDVPdgpIR1gzMlhvNi9mTzNZaTdySklYSzh4Ymt0NnRJT2xOZWd4S0JHaThiL1Q5
ZkhmTnNmYUZxcFMybG5MQm1MdzhDCkhFTnpWUzZCV0haZ0JCaHE2S2dGcHlRZnFSeVkyM2VLSUZj
OHp0djBlOFI0NTA0L3crb3BZWnlGUUd3K0JsUzAKTHB6cmdGSENTQkxUY2NGMmlxVTVkUkxFMTRP
K25xMWUyT2lKc0RvOUx2L1N3VmxZVmRtRkJKbzRmU3lLVHMyRQpIUDRjdzFzVUcydDM2V1Yxc2F1
Ym9WWFlZZVpVL2pkK2xoNjdmYjFJK25PUnl3WmVUTk45N1I0ampTZ01kVjJUCkxoN2dteFFMTk9w
OXUwMG56TTlEcEIvempEM3lEcHV6Wk80VTBmaz0KPTIyaTgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000170a4a064d2c419a--
