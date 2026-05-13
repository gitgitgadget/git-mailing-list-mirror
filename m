Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8F81B4138
	for <git@vger.kernel.org>; Wed, 13 May 2026 23:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778714264; cv=pass; b=BtxkfJvXLIBt85oMQgidvFNfNaJ0kNxX+8RuIS9cCWn4MsUH4obgiczIWHpfaTOXGbPaMWgEyq3e1laeyifmgr08jg5n/FJo6xL2vEmqkn6q/UZgD+9vHF1/B/DxTy86ud1EqrxgrdGb2mZnWw0cGtb971ETULK7zV72fjU/bzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778714264; c=relaxed/simple;
	bh=mluHKmfkHOAAbLMe/2N/G7oUmNmbI8gPphcQUpiJXD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KgGBnWtNJt6Wx9Z+oHrdEt8BAkd4uGw22X8YTV2L2ejgkZiAalOFCEdFxWLIQuNGUnPeYRKxorgLQuZP2/SPE31UUpZ36wcS1IzxQ8t1AeedbfxALdba/F69izthT5iBh5V0hbK/KjgaKfz55SaSEZksrb15HECl3qwIqwOgOf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEiIMGPv; arc=pass smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEiIMGPv"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-479fc1fc048so5388968b6e.1
        for <git@vger.kernel.org>; Wed, 13 May 2026 16:17:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778714260; cv=none;
        d=google.com; s=arc-20240605;
        b=kxb2urQnOAgel2WG7vs3O0C0o/wHRP7rJ+OS4W6A5r49TYQBrcGTWkO0NnzHwqFIJQ
         YIlu0txQlmxlLPwzrsDtHi8cwrAGDfy2Az7bHeO3YMAuYhJWJ9iKI3E2BWqCDDJKEEXo
         ndc45a8T5uu3zkaQKoDHcDjPsPdJx5o1ByidYJY/hB7XMiVFZBIY0x/g622fYVjI1lJE
         59HBnAS9m/MBNdNOPlbf5svbC8sbHZjzwq4tdPOKFZP9sfEN9XSBvGlo/F60yMNfQeG+
         0qM9gnOWaUhpi0jWCN7spfi4x9DQUSZcFCIOkeYBvfAdTTPjNzhxIaiCv9rTg3HdjYIw
         7/xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WigeAC3W7kEWuR72A5RAlzEzILO/vTBKmPMZWB4XLaI=;
        fh=oBixFgkPEMl2rc+nVMaypIMfduCICYfiXAuXd6PhqP4=;
        b=bc8v1RhH5F7n3V0ELyoLJLUH4klwCCuzcbbkfReie9uuHGP4tjK9MT9tOVzmBKK997
         tgzFLhODimh/iOGz7pHB7+7/b2ZRyfD2Edun8ZModlWff3Nq8W/IePQp3lrD7eYbd1MP
         19JJGl1ZgCEfYt5JfNfes7sCBPHPqee9Ueknmv7rxt9gbctIEmAag/wJC6Dc/jRD61Il
         AiHUG51zahQEG9ONO3nyu6Xjz8Y5LzJXmGiLjXugy5ug74LUmDP8URoggCzRdFm8IRWk
         DsY9UXqWAYGo83FA5RbN78qWab8z0wmpYZ8eWuLNjLV2gKR/RDLW4IKOZtUP8octPzEg
         gYQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778714260; x=1779319060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WigeAC3W7kEWuR72A5RAlzEzILO/vTBKmPMZWB4XLaI=;
        b=SEiIMGPv5VvMLjYFzZRaq2XIRnLe67ngS24DxGr7dH7OUYxSP3E+9emsE4iFQ8EjWI
         ZtEMfivyo0eL4tKNd8TOgjXmm5kN5AejRA619wCsxSbY7bRXmOD9pCiRhQ33unMgaLK+
         TJm+4FGVsglSIxGLlKe6jAn2PL4h5oIJ4+hPLtKoBtXnWMIq9ZPBmMK7Wpt+3hqWO3Ih
         6dcIrOcz9duq9QmsFFBgpxIAU3vjcXBW8TO+7hxlRVWEWTHjJjUXvospYrz6uqj1McxO
         g/+lPvmargBE69oWQjkQZ0Y9SYIs4ZGL8b6vsPToGM3L0hyO0MV9sTQRoaaAKl8norRN
         N/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778714260; x=1779319060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WigeAC3W7kEWuR72A5RAlzEzILO/vTBKmPMZWB4XLaI=;
        b=ZkeDhaYMWRxhP2YwHnV0XQTFUWfC+cDepQl20vvk2YFbrF9sybDJs9I9E+h+OS/1U9
         vcllqb+Rt6dyx4IoYNzOK95EstylFVE1o2GX+tvdLO8hlYJ05zQdDc/QsC+ZgEHaqWIj
         yo2ONCI2xmoA4/wypkFcINKQ0fVsiMHeaQjAH2YhwuuzPZ8ivO15FKzd8nJcYkhbz9FX
         WlX/06xAhJF3i4KDfdeb0yzmcuw2/oBKJoH6wAH/GOKTVvIOXkO943tY5xArgduYxXaI
         GXQ2IYm2ly3W3vSZwGH4SCEDA6cavD4DlC46ttqWlVlwDj+DTfmsspaTiwAY4wWSGZlM
         qIIQ==
X-Forwarded-Encrypted: i=1; AFNElJ9hDMY1cUWjPVLGct+Vo3akXc5NdJ1UsMmVIFfEyLFUjAHB9DR49GIavR9pPOoMIfnf9Fk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCIdoo49jTMBnwSAidWLtavza0EIUGtxeAJxTJhL/7BFS2tme5
	NXgmNpGD08Mp4eAGWm6NUDvNGupVXIuBmldsp/Ig1U14FN/+QI/VbXurdBHPSJrY5la1gSRb5eu
	fTkMiTgdp85+dXuUWYb/W6IOBvDMpawE=
X-Gm-Gg: Acq92OE0qsZ9nt60Lj4B3+eNMt+FVCYse/kW9CcrjxWnLYGxRb5zIC4J87ngE789g2U
	Oz+48rljUbfoONGjgXbhnTQ6rspauLXi5DeMWbKR+ZzZnpe5ldqy3ODZzYDro9iyEQAybVwvh0c
	mlXB78wqvKtQmEm1xFltathnEDnJMgMW0EiszzRlZZvjGPKMhzX1mFt5ipAdmatC/dTM7mLo85i
	cW4k5m4bybrVtPvFO77GPVf6nmDuwbvDcIxUleTFGCNvNHoGjJ5ylaEMBDR2NeGXRO62LyG5bJk
	+OM+UarQ9HrvAjikkJ/7DD1mlRCLHlJ6GV1jH72pBNYe5IJRI6olwKCn2ApTrzRIQ9OJ0cP9RvA
	wZmbkgpRdtUoD9ap556PJiUvpAw==
X-Received: by 2002:a05:6820:4d08:b0:695:a86:91a1 with SMTP id
 006d021491bc7-69b78dc0af9mr2888656eaf.24.1778714259883; Wed, 13 May 2026
 16:17:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2089.git.1776379694.gitgitgadget@gmail.com>
 <pull.2089.v2.git.1776472347.gitgitgadget@gmail.com> <a705852723fbe88e94ad3de1daba548dbce32211.1776472347.git.gitgitgadget@gmail.com>
 <a2fbb23d-0809-4a9d-8bf9-8ac0dc8ee054@gmail.com>
In-Reply-To: <a2fbb23d-0809-4a9d-8bf9-8ac0dc8ee054@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 13 May 2026 16:17:28 -0700
X-Gm-Features: AVHnY4LzCKU8S_wNHR-2jA6a4QsBSb2ekQKW77CLX8cxC7rxLP-dnX8dcE7PVQs
Message-ID: <CABPp-BGpXgDfJeDEB91U-h092-8L6Q_MLrzSLFg9HotPDZ-m-g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] builtin/log: prefetch necessary blobs for `git cherry`
To: Derrick Stolee <stolee@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Sorry for the long delay.  Lots of firefighting of incidents kept me
away for a bit...

On Mon, Apr 27, 2026 at 6:17=E2=80=AFAM Derrick Stolee <stolee@gmail.com> w=
rote:
>
> On 4/17/2026 8:32 PM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
>
> (I'm sorry that I'm reviewing out of order. This reply includes my
> feelings about patch 3 after reading both.)

Thanks for taking a look!  And I have no problems with reviewing out
of order (unless the comments on later patches don't make sense due to
the reviewer being unaware of previous patches, which isn't the case
here).

> > +/*
> > + * Enumerate blob OIDs from a single commit's diff, inserting them int=
o blobs.
> > + * Skips files whose userdiff driver explicitly declares binary status
> > + * (drv->binary > 0), since patch-ID uses oid_to_hex() for those and
> > + * never reads blob content.  Use userdiff_find_by_path() since
> > + * diff_filespec_load_driver() is static in diff.c.
> > + *
> > + * Clean up with diff_queue_clear() (from diffcore.h).
> > + */
> > +static void collect_diff_blob_oids(struct commit *commit,
> > +                                struct diff_options *opts,
> > +                                struct oidset *blobs)
>
> I think that this is generally a good idea, though I worry that
> having this hidden in builtin/log.c may not be the right long-
> term home.
>
> I expect that we'll find more and more examples where we want to
> prefetch blobs in different operations, those that exist now and
> those that may be created in the future. It would be preferred if
> they could automatically take advantage of the logic already in
> diff_queued_diff_prefetch() within diffcore_std() in diff.c.
>
> Ultimately, _this_ patch cares about a diff.

I read this patch a bit differently -- could you say more about what
you have in mind?

The body of collect_diff_blob_oids() really is just diff_tree_oid() +
diffcore_std() + process each pair, so at the per-commit level I am
already leaning on the diff library.  One of the things this patch
adds is accumulation across many commits: the containing loop (in
prefetch_cherry_blobs) is over a commit range, not over a single diff.

Concretely, the motivating case was a patch touching a few files where
upstream had tens of thousands of commits in <limit>..<head>, several
hundred of which modified the same set of files.  A per-diff prefetch
like diff.c uses would turn that into hundreds of small fetches of 1-3
blobs each; what this series gives you is one fetch.  So the win
really does live above the diff library, not inside it.

There are two further wrinkles in cherry that are filters layered on
top of the cross-commit accumulation, and they're cherry-specific in a
way that I don't think belongs in the diff library:

   1. For most commits in <limit>..<head>, cherry doesn't care about
the diff at all -- if the list of files modified doesn't exactly match
the commit of interest, the commit is skipped before patch-id is even
computed.  Prefetching for those would be wasted.

   2. We skip prefetching content for binary files (because patch-id
uses oid_to_hex() for such files instead of the diff contents).

> Could we compute a
> "diff prep" computation using the core diff library instead of
> inventing a second queue of results for diffing?

To check this concretely I looked at each of the existing
promisor_remote_get_direct() callsites for a similar producer.  The
closest cousin of collect_diff_blob_oids() (the only part of this
patch that looks like it might be close to the right shape to put in a
core diff library) is diff.c's diff_queued_diff_prefetch() -- but it
operates on the already-populated global diff_queued_diff and fetches
immediately, rather than setting up the diff itself and returning an
oidset for the caller to accumulate.  Reshaping it to match cherry's
needs would either break its current caller in diffcore_std() or
introduce a parallel function whose only consumer is cherry.  None of
the other sites (path-walk in backfill, index walk in read-cache,
three-way state in merge-ort, etc.) do anything resembling "diff two
trees and harvest oids."

And even if we did factor a helper out, cherry's filter is
patch-id-specific: commit_patch_id() substitutes oid_to_hex() for
files marked binary by their userdiff driver, so we deliberately skip
prefetching those.  That isn't a generic "diff prep" consideration --
it only makes sense because the caller is patch-id.  We could express
it as a predicate parameter, but with one caller that would feel to me
like it's just pushing cherry's policy across an API boundary for no
gain.

> Patch 3 cares about a "scan prep" which cares about loading all
> blobs for a given tree with respect to a pathspec. This is very
> similar to what a checkout would do, though it ultimately uses
> a form of diff to find out what change should be applied to the
> working directory. Perhaps 'git archive' is a better matching
> example.

Agreed that archive is the closer analog -- both grep and archive do a
pathspec-filtered single-tree walk, whereas checkout's prefetch is
tied to the index and optimizes to the subset of paths that are
different since the previous version checked out.  Retrofitting that
to grep would mean materializing an index for the target revision just
to throw it away, which feels like more machinery to bridge the
abstractions than the walk itself would take.

> By implementing things in a
> common location, then we can have later integrations add to the
> confidence in the feature through tests covering each user-facing
> use.

Sounds great...but what common user-facing uses exist?

Looking at the existing 11 callsites of promisor_remote_get_direct()
after this series [1], each has pretty specialized data needs --
index-driven (read-cache), index-pack & pack-objects internals,
path-walk batches (backfill), merge-ort's three-way logic,
diffcore-rename's two independent rename-detection paths, plain old
diffs, collection across a subset of commits (cherry),
pathspec-filtered tree walk (grep), and
on-demand-single-blob-at-a-time (odb.c) -- so I don't see a natural
shared layer above the primitive itself (which is already
promisor_remote_get_direct).

archive, if it had prefetch logic, would be the first match.  But it's
not clear where the shared logic between grep and archive would live,
if archive even had any prefetch logic to share.

So I'm inclined to leave both new producers local to their builtins
for now, and factor a tree-walk helper when archive (or a third
caller) actually wants one.  But I'm happy to be told I've missed the
boat.

Thanks,
Elijah

[1] builtin/backfill.c, builtin/grep.c, builtin/index-pack.c,
builtin/log.c, builtin/pack-objects.c, diff.c, diffcore-rename.c (two
callsites), merge-ort.c, odb.c, read-cache.c
