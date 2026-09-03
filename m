Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E844DBD9B
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 16:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788451937; cv=pass; b=f5z7eOw+r+2QnR3Z0Hi+5H1WQgPTEyMSMR9WilPS4Mpy0/1BURc7v3YmMW/Y7qoF2nZ1TBvDQV2Mha9cyfDgZZ4OE8nzdLEh6sOf8ptfIyhCrEYwxBPMGO+EC/4YOhJJIC3VPwoFnWcLIj0BPWK4XI1RSnmDg+ej8wECDGID+9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788451937; c=relaxed/simple;
	bh=yFkMaYvdj6bmtbvPhrcp5hiqFmcGMWI8Zmof37xVTLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BbEMB51lI0b6ozrZnKaB8qJv2cu1uSwsQnn7Fn894stOoMLYUd9KvogrpG4/QB1Ic21buPMQfRlDAJao+H66q5AfLAs/zUbKBoQJd+v7qZ40ByZ2SkhSHh0UmX8L6k3MMbigtbvyzx+HsGlSeIZiOAePm3u/yp7KjBH44wRXf7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQUQpoPA; arc=pass smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQUQpoPA"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7eb6573bd52so2280095a34.3
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 09:12:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788451934; cv=none;
        d=google.com; s=arc-20260327;
        b=E5Ofd/d7jEEMov9n9x1lPJNYdwUU9ccm1Um3XZR5urtVFdDew03efppceSXm5sUJux
         WpTm9PlZPw3y44kYiVakojpaHVXAwbEtuqUdNnXpYDcsY0OqIpaqZq3OsX7d3jkrR1qT
         U7IzGAugvpBJzWO2/QL2f/uX4pi4oYVmCJZIZaxk5tqgSF51RqTeiFFGOsLlyLpw1aZv
         QoVtjCmWEifW1r4NvTYPCngW7H3622tBHfHvDZau4dD8cn30yqw4eH4VDuMtvNSEBK65
         1Z3/z8/Yla4KFq8kJ6y7YPQRph3iPlgGwyLHW45UDnO9nibXxy14sHLdAxy07x4cJdhL
         W0Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LwY1KMVPRZedaDHT97Ln/vKqkPJzTSxwPXr6vAtWKfk=;
        fh=7tcC/rT4asnTF9kaxyy82X0amnDtj1RYL0UsK2El0aA=;
        b=aZKOAidxg40ywJHHe71h2qE58ZWI20U7F+z0/oJEGFEQHBxvDDsCmSIgfIIxxTJTcN
         +ZamojHTNt42JIL8j0IscxBDaA8yTqG76qcI8roL34eWAkzCmmb4A4M6FPd3Rh6hKI6P
         a4oYRUVcPck26YA1SBMVLRTneDLviVn098O7nKq8JCRadJZGcmXD+zcn/QbqIvOf4K6r
         h0PE3kKoPctRPS/oIzoz1MRS9IeoEOhblmBvcJapk8i/uafc26XOCMoFDZbXYX+rTAQI
         Dj/Rl7m6XNtrFNlnOiXUbYDm4jsDWGyOk/RcPczr9vOn4P7XDEea7pjHlM27yHv7Q6JA
         pYWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788451934; x=1789056734; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LwY1KMVPRZedaDHT97Ln/vKqkPJzTSxwPXr6vAtWKfk=;
        b=VQUQpoPAksysdB3BrSXfJ4rPL5CZw8b/fAeeLnXrhAmy9jsSRcVeS4BewAClgKDPqu
         jGIJFmOdpfDKtqD1eLQ6KmpBT2fKZafoXcmwiB9W/4aV1O0VA8w9t6/DDenzV3easi+7
         M5g5UWqTjv4MKrQZ/+NA1waYOjenHtaVeY+PSz0tWLD+iJ9oR7aCq387hWcB3OHxF/tY
         QhoaArszIP/bUI6AULCnt3ximeKUTil/UyQtavmNwX/zExJN0CfEU731aYD1Qf92RQIS
         zcscMsXlcTX+oQVdN2uoAepU/OlbMwNPXVyORrzllLalwx70OnQgLIANLr5jgQiANDtB
         ouiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788451934; x=1789056734;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LwY1KMVPRZedaDHT97Ln/vKqkPJzTSxwPXr6vAtWKfk=;
        b=H1Iz6CXQnLNDXynCEUD1AF7LtXY1XSPBQ6pmZ7v9lftLSG3iGhjC4wOvlznrVE1fmY
         1N2+2EcBysZpZOaFxB8LopLR1C1lGrEGWPZmIT7D1fiWrq05jZuyoeijmJBqh1m/tJkd
         d30kl6onfkKtr9e/LhNBJJX9Yb0/3UecW4Hqc4AjmMKgdyymd7Ow0u+/fxSLEOgT8xCy
         6lMqBxLUDZgjoS7kJuELBc/MlcsP0roOZ7VeF6X/VqjM5xGAINKpHYN1FmXnOWWP3vpj
         17zvR92615yT5cbizsZyXovj6MrVZmDno1uU608wJryLEG7eSLTDHh1K4c8CshjGl1EK
         i2lA==
X-Gm-Message-State: AFuF++lqsJKqWijex/W9kbfp0hdljSaP2GhKkplXcIxwjlHeqDYGoQC0
	DoIblU2bUsFzgHukS+GMdeoZCcSL1UFHxC3ofzYDuVh0UyMgHlwL7joQmMUNXxOT2/GN0wg9h2X
	6LXZ+d8e7DGJDmgmpRnT8JaDoR2/w6xk=
X-Gm-Gg: AYBFou3eEe0qeUNot1o0tyERoz/p+o1n+pNCLoWTzwvVU6hBfjcu9ihLrFo7taK/nxh
	Fbrf2eaLAp7uF3GRI7EQLRCcuhWmYKDRnRz7zgIokAK0ChIB9h4JzLAfbjJGvtlu2ClwlRFdYgc
	bhx8Z9mQrWSlak1L4weehqsyAsqSoKISLpX336rQifFr2m0xllrsLbsxfRJBFcpNjKPsgxnqDkO
	0bHgIBFGmtxHRSfBYcXd3AlAkslJfZh3mG0BLKRAYyLQHwE+j5sj8ysRiLFSzUjuHh7AEJo/jjj
	ComVbDlSITM84HEp/nrhPCcE/LnxrajSXxIuy18V/XfWU/nOhEigHCC5ySAc61mcSKqomuUDbMK
	EdHjC3S2sxivSiskzn1UPFN7YtnX+MJLeJMjp74xWrt3MCPMjZmjtzvHjHPa9CYuZM6EEh9c0gL
	s=
X-Received: by 2002:a05:6820:a0e:b0:6b1:4fe1:9464 with SMTP id
 006d021491bc7-6b47dfac321mr11189401eaf.22.1788451933778; Thu, 03 Sep 2026
 09:12:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903125531.68044-1-f@lex.la>
In-Reply-To: <20260903125531.68044-1-f@lex.la>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 3 Sep 2026 09:12:02 -0700
X-Gm-Features: AcwNN1UBgKF-NveExijjQOtYbqygYYm4QkhkZoXDZrYOQ2y1jDEdt-_Fg7eQOzQ
Message-ID: <CABPp-BGW4XBB6+2X=02ZDcXo2bz3iZ7D-30w_cV_51mD7j7htw@mail.gmail.com>
Subject: Re: [PATCH] technical/partial-clone: narrow the one-at-a-time fetch limitation
To: Aleksei Sviridkin <f@lex.la>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 6:17=E2=80=AFAM Aleksei Sviridkin <f@lex.la> wrote:
>
> The design doc says that dynamic object fetching invokes fetch-pack once
> for each item, and that it tends to be slow because objects are fetched
> one at a time.  Neither passage says which code paths this applies to.
>
> promisor_remote_get_direct() takes an array of object IDs and hands the
> whole array to a single fetch subprocess per promisor remote it tries.
> Ten of its eleven call sites pass a collected list: builtin/backfill.c,
> builtin/grep.c, builtin/index-pack.c, builtin/log.c,
> builtin/pack-objects.c, diff.c, diffcore-rename.c twice, merge-ort.c
> and read-cache.c.  The eleventh, in odb.c, passes a single object and is
> the fallback taken when a lookup fails with no batch fetch in front of
> it.  Through builtin/pack-objects.c, a push out of a blobless clone into
> a destination with no shared history issues one fetch carrying every
> missing blob.
>
> The bullet describes that fallback, and the commit that added it records
> checkout as an exception in the same file.  v2.17.0, the first release
> with dynamic fetching, had one batching caller beside the fallback, and
> nine more were added over the following releases, the last two in
> v2.55.0.  7ca3c0ac37 (promisor-remote: lazy-fetch objects in subprocess,
> 2020-08-17) is why that bullet still names fetch-pack: it moved the fetch
> into a "git fetch" subprocess and rewrote the "Fetching Missing Objects"
> section to match, without touching the limitation.
>
> Scope the limitation to the fallback, describe the batch path where the
> fallback is introduced, and name the subprocess the code actually forks,
> as this file already does where it describes fetching.
>
> Assisted-by: LLM
> Signed-off-by: Aleksei Sviridkin <f@lex.la>

Commit message makes sense.  It could probably be a bit shorter, but it's f=
ine.

> ---
>
> Notes:
>     Verified against origin/maint (e9019fcafe, Git 2.55).
>
>     Call sites of promisor_remote_get_direct(), with the last argument
>     shown, from a grep over *.c with the definition excluded:
>
>         builtin/backfill.c:49        ctx->current_batch.nr
>         builtin/grep.c:829           to_fetch.nr
>         builtin/index-pack.c:1509    to_fetch.nr
>         builtin/log.c:2726           to_fetch.nr
>         builtin/pack-objects.c:2244  to_fetch.nr
>         diff.c:7471                  to_fetch.nr
>         diffcore-rename.c:128        to_fetch.nr
>         diffcore-rename.c:899        to_fetch.nr
>         merge-ort.c:4484             to_fetch.nr
>         read-cache.c:3736            to_fetch.nr
>         odb.c:601                    1
>
>     The batch entry point.  promisor_remote_get_direct() calls
>     fetch_objects() once per promisor remote it tries, and fetch_objects(=
)
>     spawns one `git fetch --stdin` and writes the whole array to it.  A
>     second request happens only when a remote fails, and carries the
>     objects still missing.  The function returns void, and when every
>     remote has failed it die()s only for oids that is_promisor_object()
>     confirms, otherwise returning with nothing fetched -- so a batch
>     having asked for an object does not mean the object arrived.
>
>     Why the text states no count and names no callers.  The batching call
>     sites do not partition by mechanism, so no "N of them do X" sentence
>     is true.  diff.c:7471 is reached both directly from diffcore_std
>     (diff.c:7502) and as missing_object_cb (diff.c:7362,
>     diffcore-break.c:73), the latter firing from diff.c:4615 only after a
>     lookup carrying OBJECT_INFO_SKIP_FETCH_OBJECT has failed.
>     diffcore-rename.c's two are that same callback mechanism.
>     builtin/pack-objects.c:2244 is neither: prefetch_to_pack() is a direc=
t
>     call from the miss branch of check_object() (:2392) and collects from
>     the pack list rather than from the misses.  builtin/backfill.c:49
>     fires from the path walk whenever current_batch.nr reaches
>     min_batch_size.  A timing claim fails too: only checkout collects
>     before the work starts.  builtin/grep.c:829 fires after
>     collect_blob_oids_for_treeish() has walked the treeish,
>     merge-ort.c:4537 calls prefetch_for_content_merges() from inside
>     process_entries(), and builtin/index-pack.c:1509 sits in
>     fix_unresolved_deltas() (reached at :1391 after the pack is parsed)
>     and prefetches delta bases rather than the objects being indexed.
>
>     Reproduction.  Server: 20 commits x 100 files, every file rewritten
>     each commit, 2000 distinct blobs, uploadpack.allowFilter=3Dtrue.
>     Client: git clone --filter=3Dblob:none --no-local --no-checkout, then
>     the trace2 event fetch_objects() already emits, so one event is one
>     subprocess and its value is the request size:
>
>         git checkout main                      1 request   100 objects
>         git grep -e unique main -- .           1 request   100 objects
>         git log --patch main                  19 requests  200 then 100 x=
18
>         git push <empty dest> main             1 request  2000 objects
>         git cat-file --batch < 200 oids      200 requests    1 object eac=
h
>         git checkout-index --all             100 requests    1 object eac=
h
>
>     Second server, one file grown by a line per commit over 30 commits, t=
o
>     make blame walk the whole history:
>
>         git blame main -- grow.txt            30 requests    1 object eac=
h
>         git log --patch main -- grow.txt      29 requests   28x1 and 1x2
>
>     Two things follow.  blame is porcelain and reaches the fallback one
>     object at a time, faulting in one object per revision it walks --
>     neither blame.c nor builtin/blame.c contains a prefetch,
>     fill_origin_blob() goes straight to odb_read_object(), and
>     diffcore_std()'s prefetch gate never fires for blame's internal
>     diff_opts because it needs one of DIFF_FORMAT_{DIFFSTAT,NUMSTAT,PATCH=
,
>     SHORTSTAT,DIRSTAT} or a pickaxe.  So the remaining limitation is not
>     confined to plumbing.  Do not state a total for it: the run above use=
d
>     --no-checkout and saw 30, while the same 30-commit history in a
>     default `git clone --filter=3Dblob:none` sees 29, because the clone's
>     own checkout batch-prefetches the HEAD blob.  The rate is the durable
>     fact, not the count -- which is why the commit message asserts
>     neither.
>
>     And a batching call site is routinely reached with a one-element list=
:
>     pathspec-limited `log --patch` diffs one file per commit, so diff.c's
>     to_fetch.nr is 1 almost every time.  The per-request size a batching
>     caller achieves depends on how much work the command has in front of
>     it, not on the call site, which is why the text keys on whether a
>     batch fetch covers the object rather than on how many objects it
>     carries.
>
>     Release in which each batching call site first shipped:
>
>         v2.17.0  unpack-trees (c0c578b33c), today read-cache.c
>         v2.22.0  diff.c (7fbbcb21b1)
>         v2.23.0  builtin/index-pack.c (8a30a1efd1)
>         v2.27.0  diffcore-rename.c inexact_prefetch (95acf11a3d)
>         v2.29.0  builtin/pack-objects.c (e00549aa9b)
>         v2.33.0  diffcore-rename.c basename prefetch (1aedd03afb)
>         v2.33.0  merge-ort.c (2bff554b23)
>         v2.49.0  builtin/backfill.c (1e72e889e7)
>         v2.55.0  builtin/grep.c (854061ea54)
>         v2.55.0  builtin/log.c for `git cherry` (463c1bfc2b)
>
>     The design doc commit 637fc4467e shipped in v2.16.0, one release
>     before the lazy-fetch machinery itself (88e2f9ed8e, v2.17.0), and
>     already recorded checkout as an exception to the bullet it added.
>
>     Pre-existing, each wanting its own patch, none touched here.
>
>     - The V0 bullet's premise and its consequence are both stale, and the
>       consequence is false on two independent grounds.  Premise:
>       protocol.c:46 returns protocol_v2 when protocol.version is unset
>       (eb049759fb, v2.29.0) and fetch_objects() sets no override.
>       Consequence: under protocol_v2, handshake() in transport.c calls
>       get_remote_refs() only `if (must_list_refs)`, and
>       fetch_refs_via_pack() leaves must_list_refs at 0 when every
>       to_fetch entry has exact_oid (transport.c:472-480) -- which the
>       lazy fetch always does, because its hex-oid refspecs set exact_sha1
>       (refspec.c:105) and so exact_oid (remote.c:2093).  Measured it:
>       GIT_TRACE_PACKET on a blame that triggers 30 lazy fetches shows 60
>       `command=3Dfetch` packets, zero `command=3Dls-refs`, and zero refs/
>       advertisement lines.  So no ref advertisement happens at all on thi=
s
>       path, let alone a full one.  One release invalidated both halves of
>       that bullet: 7ca3c0ac37 and eb049759fb are both v2.29.0.
>     - The Future Work item at line 291, "Investigate pack protocol V2 to
>       avoid the info/refs broadcast on each connection", was done by
>       eb049759fb.
>     - protocol.h:34-35 documents the opposite of the code: "If
>       unconfigured, a value of 'protocol_v0' is returned" against
>       protocol.c:46 returning protocol_v2.
>     - The `rev-list --missing=3Dprint` bullet suggests `git log -p A..B` =
may
>       want to prefetch in bulk itself; diffcore_std() has done that since
>       7fbbcb21b1 (v2.22.0) whenever the output format needs blob data.
>     - prefetch_to_pack() is reached with an index into the wrong array.
>       get_object_details() fills sorted_by_offset[i] with to_pack.objects
>       + i, QSORTs by pack_offset_sort, then calls check_object(entry, i)
>       with the sorted counter, which prefetch_to_pack() uses to index
>       to_pack.objects.  The correct index is entry - to_pack.objects.  Th=
e
>       push measurement above survives this only because pack_offset_sort
>       compares IN_PACK() pointers, so objects in no local pack sort first
>       and the first miss lands at index 0.  No reproducer built, so read
>       it as "the batch can miss objects it meant to cover".
>     - "once *for each item*", kept from the base text, is strictly at
>       least once per item: a failing remote sends the same single oid on
>       to the next remote (promisor-remote.c:280).
>     - The push sentence in the commit message is scenario-specific, not a
>       statement of the code's condition.  prefetch_to_pack() fires on any
>       failed odb_read_object_info_extended() for an object being packed,
>       with no shared-history test, and it collects the pack list from the
>       trigger index onward rather than "every missing blob".  The upstrea=
m
>       test 'prefetch objects' in t/t5300-pack-object.sh, added by
>       e00549aa9b, is the same scenario with a single-batch assertion and
>       would be the firmer anchor.
>
>     Declined, with reasons.  Restoring "without having asked for it in
>     advance" to the limitation bullet is refuted, not merely declined:
>     builtin/pack-objects.c and diffcore-rename.c's two callbacks both
>     discover their misses mid-flight and still batch, so that clause is
>     the exact false discriminator earlier rounds removed.  Shortening the
>     ten-path list in the commit message is declined because a "ten of
>     eleven" count without its evidence is the set claim a reviewer asks t=
o
>     see verified.  Double-quoting "git fetch" rather than backticking it
>     follows the two pre-existing occurrences in this same file, at lines
>     176 and 332, under CodingGuidelines' instruction to imitate existing
>     conventions.
>
>     On the claim that the V0 rot predates 7ca3c0ac37, which is wrong and
>     worth recording because of how easy it is to reach.  A `git log -S` o=
n
>     a feature name finds where it landed and not where it was reverted, s=
o
>     a feature that landed, was reverted and re-landed reads as
>     continuously present.  Reading the tagged trees is what shows it.
>     684ceae32d did default
>     fetch to v2 in v2.26.0, but 11c7f2a30b reverted it in v2.27.0.  Read
>     straight off the tagged trees, get_protocol_version_config() returns
>     protocol_v2 in v2.26.0, protocol_v0 in v2.27.0 and v2.28.0, and
>     protocol_v2 again in v2.29.0 via eb049759fb (2020-09-25).  So when
>     7ca3c0ac37 landed on 2020-08-17 the default was v0 and the bullet's
>     premise was still true; eb049759fb falsified it five weeks later in
>     the same release.  The citation in the commit message attributes only
>     the fetch-pack naming to 7ca3c0ac37, never the V0 premise.
>
>     Base branch: maint, deliberately.  SubmittingPatches' "Choose a
>     starting point" splits on fixing bugs in the released version against
>     adding features, not on regression against clarification, and a
>     documented statement that misdescribes released behaviour is a bug in
>     the released version.  For a maintainer who prefers master,
>     retargeting is free: the patch applies cleanly there (git apply
>     --check --3way), and master's one newer change to this file,
>     508ec9837c (repository: move fetch_if_missing into struct
>     repository), touches a single line in a different bullet.
>
>     The V0 bullet admits no in-scope fix, and the two states are worth
>     recording because reviewers have asked for each in turn.  With the
>     bullet reworded, the two sentences left standing become this patch's
>     own and both are false, so that state is out.  With it untouched, thi=
s
>     patch scopes the bullet above it to the fallback while the V0 bullet
>     keeps saying "each object is requested via fetch-pack" unscoped -- at
>     the merge base both bullets were equally broad, so the asymmetry is
>     this patch's doing.  Neither state is clean, and no third state is
>     reachable without correcting the protocol version and the info/refs
>     sentence, which is a separate claim needing its own justification.
>     Chose the untouched state: every sentence this patch asserts is true,
>     and what is left is an adjacent pre-existing error rather than a new
>     one.
>
>     Why the V0 bullet is left exactly as upstream has it.  An earlier
>     revision of this patch deleted its "which means that each object is
>     requested via fetch-pack" clause, to remove a contradiction with the
>     new paragraph above.  That made the two remaining sentences this
>     patch's own, and both are false, so the clause was restored: editing =
a
>     sentence makes the author answerable for the sentence left behind.  V=
0
>     is therefore untouched here and stays a pre-existing problem, recorde=
d
>     above.
>
>     Checks: `git show --check` clean, no commit-message line over 75
>     columns, `make -C Documentation lint-docs` exits 0.  No manpage rende=
r
>     was attempted: asciidoctor, asciidoc, xmlto, docbook2x-texi and
>     dblatex are all absent here.

I didn't even read the above; it's way too lengthy.  I read the commit
message, then looked at the actual changes and noticed they were
small, so I read them, then came back and decided the odds of this
cover letter being relevant were slim.  Maybe ask your LLM to make
this cover letter more pithy?  It's unfair to request humans to read
voluminous and likely irrelevant LLM output about its meandering
process of getting to the end result (or so I presume it represents
from some quick skimming).

>  Documentation/technical/partial-clone.adoc | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/technical/partial-clone.adoc b/Documentation/t=
echnical/partial-clone.adoc
> index e513e391ea..757a92eddf 100644
> --- a/Documentation/technical/partial-clone.adoc
> +++ b/Documentation/technical/partial-clone.adoc
> @@ -141,8 +141,10 @@ remote and then retry the object lookup.  This allow=
s objects to be
>  For efficiency reasons, no check as to whether the missing object is
>  actually a promisor object is performed.
>  +
> -Dynamic object fetching tends to be slow as objects are fetched one at
> -a time.
> +This fallback asks for a single object per request, so it is slow when
> +many objects are missing.  Code that can name several missing objects at
> +once passes the whole list to promisor_remote_get_direct(), which
> +requests the set rather than one object at a time.
>
>  - `checkout` (and any other command using `unpack-trees`) has been taugh=
t
>    to bulk pre-fetch all required missing blobs in a single batch.
> @@ -247,11 +249,11 @@ remote in a specific order.
>  - Repack essentially treats promisor and non-promisor packfiles as 2
>    distinct partitions and does not mix them.
>
> -- Dynamic object fetching invokes fetch-pack once *for each item*
> -  because most algorithms stumble upon a missing object and need to have
> -  it resolved before continuing their work.  This may incur significant
> -  overhead -- and multiple authentication requests -- if many objects ar=
e
> -  needed.
> +- Dynamic object fetching invokes a "git fetch" subprocess once *for
> +  each item* when it goes through the object lookup fallback, because
> +  the object has to be resolved before the work can continue.  This may
> +  incur significant overhead -- and multiple authentication requests --
> +  if many objects are needed.

Both paragraph changes read well.
