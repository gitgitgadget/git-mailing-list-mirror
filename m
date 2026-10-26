Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793050986;
	b=gFOJ6RVTUjkfkFvyan4zwGf0R0j41ZZJgdP5+i2k2lbB9OaIwMw7Dtb67P/Gy/M1pCCg
	 WTOlRGU3iRWAp5mSGHxuV98qajSLO6Xmwl7USIkXK7CjwklvYOiRSoPc+AYwGOAy6Fs2Y
	 aa974t9VxJVM8UI2n/cy8Zg9OZLyUXaA3ZaBp/j5cTUYYg2e23NZOXqDhNCGWajf1xRaa
	 CG6BcAJDKKW4L9D3LLxOKOI7dtINyO2s7on14TECNWADsgvLBMe+nLk0W78Q2vmV9oqzS
	 8QyoBWv7VXTKElp+XJbNZSjlux9iMqhJ/IjiSdC4OLPVhKvIJo/0TRu/Wa2XdM5WS/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793050986;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=fOFwQnkxAxPMbz+Q202/A6CamrVAX66rtc8yxKYlnQc=;
	b=1xOTge/YwWjIEa0VRnxtoomQfpsyFzfRynCVp+bvHo/AJD0T8RV4DGVFmFD3zHaGaJkV
	 iXzl1WKc49PfYU5r/QvAssJLaN3stE5FcxEL0DJu920yPwocguEQxZNdA5OsqHVHfIB1q
	 13Emnont06HOg6ahEB5CwWLrxDT9+c8ahJWWfTipRLfAcXpNZvxxMx3GW4PkV3F3NOx2b
	 MdDF+3QWiHQ36scQuvnyX4MqJczpIPBtrpjf+k34N/jw4f7KRZsdap9E3e6VDH9gA2lvj
	 IKf54l+MEcr6C9xFilRtA3xvsTRC1n3ZTaWrz21ZjpYdEBZCjZ42HWK4+fH7+PSEEPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TxMk6Lpk;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070AB606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 21:43:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 070AB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TxMk6Lpk
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso22989095e9.1
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 14:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793050984; x=1793655784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fOFwQnkxAxPMbz+Q202/A6CamrVAX66rtc8yxKYlnQc=;
        b=TxMk6LpkgxUDUI7OJM6DLmQDd5ZgaACwM3mBXIAw4BQ+48e8JFXz7cfTDyZ4xFl2E5
         hNd+oGw9L2AI+e2K1a9WqURAWC3HpY7k9Ez+TNHo0WrHeRhfQOOL9kI3Iofx6Xa5VOVU
         PNyqCogq1efFfu59Q8OXBfull5BYX+XqJYr12YtL9fXeOzmyyw0CLxor+I3aflb8YhtP
         Y9VhIj/gBjHFwWy5FzhpN+vfxvmCVClBpRKsh5TH/daJv01y0gNvL69rtHCuh6HsmgTz
         sayz6K/wsxKhvZ1JsnY8t55/RdF4qCmL/0EzF4miDd0ehKSSvu0BqW7HNxg25FMnwGO1
         BdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793050984; x=1793655784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fOFwQnkxAxPMbz+Q202/A6CamrVAX66rtc8yxKYlnQc=;
        b=RzC6pCzAk/3ZNQDPEuz8if+yOUH9clCBSaGRLa/T7QckLG8mzG+r6cGFF3t2KYQEEr
         qmFhnVDC9O0RNPltlPDvjHtbaGVgmMc8U8b6rFUieDtlpWz6gQG4yL7rK9Jko6Ah9xxQ
         7yTeY79QFyU3vkvUCvE83b0WZbXwYhIoFMsvtIkwyZeonq2pjAM8wEhUfa1hRTKZcKSb
         s0jEpTBtDqZAbHym8gvfwKsv0iofAUszF0ON3hDx7WUxJsKQUb9EJfeV1dbT2U1LYnxg
         1SVWghn+83dQCpmlbT/6scaCvrZn/MXyzeQzjVjtL3OQJh2BMOS+MTezDDYDkVw9pQtO
         yxOg==
X-Gm-Message-State: AFq9FYJGWW/9+tKjI/bnmn5vMz9v0VR6YeBEkGcbJydy5FnPSaPD7pTo
	xDiMxXjl+JDpWiZaT0QqRyKWjqvR8U7GDLj4nj/xdKhcwalmByCqMNoeMBAW+g==
X-Gm-Gg: AYBFou0MaCkOsl7cydLlmE4CDFnbDPn3ygSudC0U4gynNOzSz5+njRMCp+8cydpYSL+
	TrTPhokOQfiNWWPQVf6YT/MGRdr9qeS+/nozHMCAQusbVDK6k9+IV8Ap+BhkBM0tyujx1X5UDUV
	kzvjP1Qdd7KhLK+NsYFi1mGWgFx5gusseD+uy34cBUj724vhPqV5hzjg9bVQvIzmaKw0ea1Nl+K
	WaUkb4kjnMbiLkg1Ktonbmj7I0p1Bi/yXcg6uaEMnfaBtEK+2gpzVqp5LWpOv4z+g2iRbKVNLMl
	jmGUvNOyanlc7uEq+Yt80vyBKvRF/ad8RoTdit6DMshpm/0yk59Ms9X7hqPYpShDRakJ2nyUFGg
	V41uRwRTC3YqSmTkXONOb+J9xBzIupPlVBM/8ZX41BGCtHTqq2DrebOGKJjhOKlNj1m42LekWl0
	I2+S/CT6TtBft2mrrftNYwTpTRf2Bg/NO1X7WSf3A6TbK7V5+fQqaHwWokL6h3QY/ELg3x0caQX
	lAq34MBtBXJHui0Vn1X4jdw+1lc/LFeJbY2Hyd5cUdCXbZm8Zz8XCjJsJW8fFDUvceJMoqIjsPs
	yc6YdPHzi18tJaaYmetaxH3az+HRxi2vBnR1fUPEjkPT0ntU1ak=
X-Received: by 2002:a05:600c:5285:b0:4a1:fb23:68f0 with SMTP id 5b1f17b1804b1-4a35ac3b26fmr145866215e9.3.1793050983846;
        Mon, 26 Oct 2026 14:43:03 -0700 (PDT)
Received: from jarvis (dynamic-adsl-84-221-219-11.clienti.tiscali.it. [84.221.219.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a30e11bsm262340465e9.1.2026.10.26.14.43.03
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 14:43:03 -0700 (PDT)
From: Massimiliano Cialdi <cialdi@gmail.com>
To: git@vger.kernel.org
Subject: [Question] Shared object store for many clones and submodules
Date: Mon, 26 Oct 2026 22:42:56 +0100
Message-ID: <20261026214256.87554-1-cialdi@gmail.com>
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

Hi all,

I would like advice on a use case before we build anything. We are
open to any approach, including a change to Git itself if that is
the right place. Below I describe the problem, what we verified in
the documentation, the source and with tests, the options we see
(in no particular order), and our questions.

In short, we would like to know:
- how to keep GC of a shared alternate from deleting objects that
  borrowers still reach (question 1);
- how to keep in a borrower local copies of selected objects, which
  "git gc" (repack -l) drops because the alternate has them (3);
- whether a remote helper with the "fetch" capability that adds the
  alternate is a sound way to make all this transparent (2);
- how to apply versioned sparse rules to submodules at clone time
  (5);
- whether changes to Git in these areas would be welcome (7).

The problem
-----------
We are a small embedded team. Every project is a superproject with
many submodules: vendor HALs and SDKs, CMSIS, FreeRTOS, lwIP, mbedTLS,
and Zephyr with its modules through west. Each developer keeps many
persistent workspaces at the same time (one per product, per branch,
per review). So the same upstream history is stored many times on
the same machine.

Measured on one developer machine (Git 2.53.0): 250 object stores
(repositories and submodule git dirs, nested up to 4 levels), 17.9 GiB
of .git in total, of which 15.1 GiB are Git objects (the rest is
mostly git-lfs, which alternates do not share). Examples: 4 clones of
zephyr (3.4 GiB of objects, 0.9 GiB if stored once), 9 copies of
CMSIS_5 (2.2 GiB, 0.25 GiB once), 9 copies of an NXP SDK (1.3 GiB,
0.2 GiB once). Estimates of the Git objects, from the pack sizes:
- today:                     15.1 GiB;
- one store per remote URL:  about 5.1 GiB;
- one object database:       about 2.7 GiB.
The single database saves more because forks have different URLs
(about 1.3 GiB) and because unrelated histories contain identical
files (about 1.1 GiB).

The core of the problem, in short: with alternates, neither side's
GC knows about the other. GC in the shared store deletes objects that
the borrowers still need (F1 below). GC in a borrower deletes the
local copies that it would need to survive the loss of the store
(F2 below). We want both to be safe, and the borrowers to stay small.

What we need, as precisely as we can say it:

R1. Each published object is stored once per machine, in a shared
    store, and workspaces borrow from it.

R2. The .git of a workspace stays small over time, not only right
    after clone. A workspace borrows only history that upstream does
    not rewrite (for us: protected branches such as the default
    branch; whether tags count is still open, because our server
    does not protect them). It keeps locally everything that
    upstream may rewrite or delete (feature branches, forced updates)
    and all local work (unpushed commits, stash, reflog, index, other
    worktrees). For all 250 stores we estimated about 0.6 GiB of such
    local objects (with tags and main/master/develop/release* counted
    as stable, reflogs not counted).

R3. Maintenance of the shared store must never delete an object that
    a workspace still reaches.

R4. The shared store must always be rebuildable. If it is deleted or
    corrupted, we must be able to rebuild it from upstream and from
    the workspaces, and afterwards every workspace must be consistent
    (fsck clean, local work intact). Only remote-tracking refs and
    reflog entries that point to history that upstream no longer has
    may be dropped. R2 exists to make R4 possible.

R5. "Push succeeded" keeps its meaning: a push goes only to upstream.
    The shared store is a derived mirror, filled only by fetching
    from upstream. Pushes are never written to it.

R6. Clone and fetch work offline from the shared store when it is
    recent enough. Push offline fails at once, as today.

R7. Transparency. A user enables the store in their own config, per
    URL prefix, and then keeps using plain "git clone", "git fetch",
    "git submodule update" and "west update". With the config
    removed, Git behaves exactly as today. Occasional administrative
    commands (enable, migrate existing workspaces, clean up, make a
    workspace independent again, status) may be acceptable; this is
    still open for us.

R8. It covers submodules, nested submodules, and repositories that
    west creates (west runs "git init", "git remote add" and
    "git fetch <url>"; it uses refs/heads/manifest-rev, not
    refs/remotes/*).

R9. Sparse checkout rules are versioned in the superproject, for the
    superproject and for its submodules (a project needs only one MCU
    family of a vendor SDK). The clone should come out sparse in one
    step, without a full checkout first.

R10. CI runners (GitLab Runner, shell and docker executors) share the
    same kind of store for ephemeral jobs, fetch by commit id, with
    concurrent jobs.

R11. It works with the Git of common distributions. The oldest in our
    team is Ubuntu 24.04 (Git 2.43.0); the GitLab runner helper image
    (ubuntu flavour) is also 2.43.0.

Ruled out, and why:
- git worktree: does not cover submodules and independent projects;
- hardlinked local clones: the store may be on another filesystem;
- partial or shallow clones: conflict with offline use and full
  history;
- writing pushes also to the store (write-through or write-back):
  not atomic, and offline the user may believe a push was published.

What we verified (Git 2.53.0 man pages and source)
--------------------------------------------------
F1. GC of the store breaks borrowers. The script at the end shows it:
    with "gc --prune=now", and with an explicit "repack -a -d" even
    with gc.pruneExpire=never, the workspace loses commit B, the base
    of its local branch. Plain "git gc" with gc.pruneExpire=never
    kept B in the cruft pack. Same result on two machines.

F2. GC of the workspace removes local copies. "git gc" always runs
    "repack -d -l": pack-objects --local leaves out every object that
    an alternate has, even if a local copy exists, and prune-packed
    removes local loose objects that an alternate has in a pack. The
    same happens with "gc --auto" after fetch, commit, merge, am and
    rebase, once its thresholds are exceeded. The second script at
    the end shows the effect on R2/R4: the user publishes commit C,
    the store fetches it, a plain "git gc" in the workspace drops
    the local copy of C, upstream force-pushes C away, the store
    follows and is GC'd, and the workspace loses the user's own
    commit. (If C is still loose in the store, the local copy stays.)

F3. extensions.preciousObjects makes "prune" and "repack -d" refuse
    and makes "gc" skip them in the store. It also stops pack
    consolidation, so packs accumulate.

F4. Nothing tells a repository that others use it as an alternate.
    core.alternateRefsCommand and core.alternateRefsPrefixes work in
    the other direction.

F5. Remote helpers: "connect" and "fetch" are documented capabilities;
    "stateless-connect" is "Experimental; for internal use only".
    After a helper's "fetch", Git calls odb_reprepare(), which
    re-reads objects/info/alternates. The call is explicit since
    2.44, with fba732c462 (transport-helper: re-examine object dir
    after fetching, 2024-01-24); the lazy re-read of alternates is
    there since 2.41, with e2d003dbed (object-file: reprepare
    alternates when necessary, 2023-03-08). So, reading the source,
    a helper should be able to add the store as alternate during the
    first clone. We have not tested this yet.

F6. URL rewriting: the longest insteadOf wins; "git clone" stores the
    URL as typed in remote.origin.url; without a pushurl, the push
    URL is computed from the original URL with pushInsteadOf, so an
    identity pushInsteadOf rule keeps pushes away from the helper.
    A "<scheme>::" helper is blocked inside "git submodule" unless
    protocol.<scheme>.allow=always.

F7. git sparse-checkout is still marked experimental. There is no
    in-tree file or .gitmodules key for sparse rules, and
    clone.filterSubmodules passes only --filter. Submodules are
    cloned with --no-checkout and then checked out separately.

F8. The reference-transaction hook fires on fetch and push ref
    updates. Before 2.54 (hooks defined in config) it can be enabled
    for all repositories only with core.hooksPath in the user's
    config, which replaces the hooks directory of every repository.

F9. With protocol v2, upload-pack accepts a want for any object it
    has; uploadpack.allow*SHA1InWant apply only to v0/v1.

Options we see (in no particular order)
---------------------------------------
Without changes to Git:
- Store layout: one bare mirror per remote URL (O1), one object
  database for all remotes (O2), or per URL with forks grouped by
  common root commits (O3).
- Transparency (R7): a remote helper "git-remote-<x>" selected by
  url.<x>::<prefix>.insteadOf, with an identity pushInsteadOf (O4).
  It updates the mirror under a lock, adds it as alternate of
  $GIT_DIR, and then either (a) uses the "fetch" capability and
  writes locally only the objects that R2 wants local, or (b) uses
  "connect" and runs upload-pack on the mirror. The alternative is
  plain alternates set up at creation time, without a helper (O5).
- R2 against F2: the alternate holds only stable refs (O6); objects
  that must stay local go into local .keep packs (O7); or two
  mirrors per URL, a stable one used as alternate and a full one
  from which non-stable objects are copied into the workspace (O8).
- R3: an append-only store (preciousObjects, gc.auto=0, maintenance
  off, multi-pack-index for lookups) (O9), plus a rare cleanup that
  keeps the union of the roots computed in every registered
  workspace, under a lock (O10).
- R9: write the versioned rules between the submodule clone
  (--no-checkout) and its checkout (O11), or use a dedicated command
  to create the workspace (O12).

Changes to Git itself (also an option for us):
O13. A repository used as alternate knows its borrowers (a registry),
    and gc, repack and maintenance keep the borrowers' roots.
O14. A way for "repack -l" / prune-packed to keep local copies of
    objects reachable from selected refs, even if an alternate has
    them.
O15. Sparse rules versioned in the superproject and applied to
    submodules during clone and submodule update.

Questions
---------
1. GC of the store. Is there a supported way to make a repository
   that serves as an alternate respect the reachability of its
   borrowers? If not, in a repository with preciousObjects, can any
   command or maintenance task still delete objects? We found only
   "multi-pack-index expire", which does not check the extension.
   Is a root set of "--all --reflog --indexed-objects" in each
   borrower, plus its other worktrees, complete?

2. Remote helper. Is a helper with the "fetch" capability that only
   adds an alternate and writes a chosen subset of objects a correct
   use of the protocol? Can we rely on the re-read of alternates after
   the helper's fetch (F5), and what should we expect on 2.43? Is
   "connect" a better choice, also with protocol v2? Known pitfalls
   with submodules, credentials, or the helper's own fetch from
   upstream? (One idea against recursion is a longer identity
   insteadOf rule passed through GIT_CONFIG_COUNT.)

3. Small borrowers, selectively (F2). Is there a supported way to keep
   in a borrower the local copies of objects reachable from some refs,
   although the alternate has them? Or to copy objects back from the
   alternate for a given set of refs, other than pack-objects with our
   own object list?

4. Rebuild (R4). What is the recommended way to rebuild a deleted or
   corrupted alternate from upstream plus the borrowers' local
   objects, and to find out which objects each borrower is missing?
   fsck in a borrower checks the alternate too and does not tell
   local from borrowed objects; a normal fetch does not re-send
   missing objects, and "fetch --refetch" copies everything locally.

5. Sparse (R9). Is git sparse-checkout expected to leave the
   experimental state? Is there a native way, or ongoing work, to
   apply versioned sparse rules at clone time, also to submodules?

6. CI (R10). Any concern with serving fetches by commit id from one
   store over protocol v2 (F9), for example when one store holds
   objects of many projects?

7. Changes to Git. Would any of O13, O14 or O15 be welcome upstream,
   and in which shape? Or is one of them already possible and we
   missed it?

8. Prior art. Pointers to similar work are welcome (for example
   the shared object cache of Scalar in microsoft/git, or the caches
   of repo or depot_tools).

Reproduction of F1
------------------
Usage: sh repro-gc-alternates.sh [prune-now|gc-never|repack-ad]
Expected on 2.53.0: BROKEN, intact, BROKEN.

---8<---
#!/bin/sh
# A repo used as alternate is GC'd and breaks a borrower.
# Usage: sh repro-gc-alternates.sh [prune-now|gc-never|repack-ad]
set -e
mode=${1:-prune-now}
export GIT_CONFIG_GLOBAL=/dev/null GIT_CONFIG_NOSYSTEM=1
export GIT_AUTHOR_NAME=A GIT_AUTHOR_EMAIL=a@example.com
export GIT_COMMITTER_NAME=A GIT_COMMITTER_EMAIL=a@example.com
cd "$(mktemp -d)"
git --version

# "upstream" plus a colleague's clone
git init -q --bare -b main upstream.git
git clone -q upstream.git dev 2>/dev/null
git -C dev commit -q --allow-empty -m base
git -C dev push -q origin HEAD:main
git -C dev switch -q -c feature-x
git -C dev commit -q --allow-empty -m B
git -C dev push -q origin feature-x
B=$(git -C dev rev-parse feature-x)

# shared cache (mirror) and a workspace borrowing from it
git clone -q --mirror upstream.git cache.git
git -C cache.git repack -q -a -d   # long-lived cache: all packed
# file:// avoids the local-clone shortcut that copies all objects
git clone -q --reference cache.git "file://$PWD/upstream.git" ws
git -C ws switch -q -c mine origin/feature-x
git -C ws commit -q --allow-empty -m C

# precondition: B is NOT in the workspace's own object store
git -C ws count-objects -v | grep -E '^(count|in-pack):'
mv ws/.git/objects/info/alternates alt.save
if git -C ws cat-file -e "$B" 2>/dev/null; then
  echo "setup error: B is local"; exit 2
fi
mv alt.save ws/.git/objects/info/alternates

# upstream drops feature-x, the cache follows and is GC'd
git -C dev push -q origin --delete feature-x
git -C cache.git fetch -q --prune
case $mode in
  prune-now) git -C cache.git gc -q --prune=now ;;
  gc-never)  git -C cache.git config gc.pruneExpire never
             git -C cache.git gc -q ;;
  repack-ad) git -C cache.git config gc.pruneExpire never
             git -C cache.git repack -q -a -d ;;
esac

echo "--- fsck in the workspace:"
if git -C ws fsck --connectivity-only; then
  echo "RESULT: workspace intact"
else
  echo "RESULT: workspace BROKEN (B=$B lost)"
fi
---8<---

Reproduction of F2
------------------
Usage: sh repro-gc-borrower.sh
Expected on 2.53.0: "C is no longer local", then BROKEN.

---8<---
#!/bin/sh
# gc in the borrower drops the local copy of the user's own commit;
# a later forced update plus GC of the alternate breaks the borrower.
set -e
export GIT_CONFIG_GLOBAL=/dev/null GIT_CONFIG_NOSYSTEM=1
export GIT_AUTHOR_NAME=A GIT_AUTHOR_EMAIL=a@example.com
export GIT_COMMITTER_NAME=A GIT_COMMITTER_EMAIL=a@example.com
cd "$(mktemp -d)"
git --version

git init -q --bare -b main upstream.git
git clone -q upstream.git dev 2>/dev/null
git -C dev commit -q --allow-empty -m base
git -C dev push -q origin HEAD:main
git clone -q --mirror upstream.git cache.git
git clone -q --reference cache.git "file://$PWD/upstream.git" ws

# the user publishes C; the cache fetches it and packs it
git -C ws switch -q -c topic
echo c >ws/c.txt && git -C ws add c.txt && git -C ws commit -q -m C
C=$(git -C ws rev-parse HEAD)
git -C ws push -q origin topic
git -C cache.git fetch -q
git -C cache.git repack -q -a -d

# plain gc in the workspace (repack -d -l) drops the local copy of C
git -C ws gc -q
mv ws/.git/objects/info/alternates alt.save
if git -C ws cat-file -e "$C" 2>/dev/null; then
  echo "C is still local"
else
  echo "C is no longer local"
fi
mv alt.save ws/.git/objects/info/alternates

# upstream rewrites topic; the cache follows and is GC'd
git clone -q upstream.git dev2 2>/dev/null
git -C dev2 switch -q -c topic main
git -C dev2 commit -q --allow-empty -m C2
git -C dev2 push -q -f origin topic
git -C cache.git fetch -q --prune
git -C cache.git gc -q --prune=now

if git -C ws fsck --connectivity-only >/dev/null 2>&1; then
  echo "RESULT: workspace intact"
else
  echo "RESULT: workspace BROKEN (own commit C=$C lost)"
fi
---8<---

Thanks for any feedback,
Massimiliano Cialdi
