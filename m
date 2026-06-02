Received: from esa6.hc3812-35.iphmx.com (esa6.hc3812-35.iphmx.com [139.138.46.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A3425A354
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 21:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.46.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780436462; cv=none; b=iv/jD02c+pe/CaNf3KVoN9ZrLxn8zIB8KEVm3i6c//NA/bZjs228w0M9AHgzF4hMpVsvZ25ebSoPtaeII5hGnruQuQR706OqXrQpdyed01Yo36i16GZ5FCOd9WflEYGbB2MiWvfaLDlONAmYhnVEvq8K1fkP6UU2ucb0vF7WbmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780436462; c=relaxed/simple;
	bh=24WhXYsTmqjD6DQlpaDHeAjuvrqLpOq+MwRRw1hftYE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=idLR+f/7xebFRbZeRmRmuy+jph8b4ERPb62iOcfUc6O5ZeUhG4RCAc7tLOIO/N5cGO8x7QtGjW3/SbzQeu5L2LwVEduLCoOhHVi+aLVqT4d+wyyv0cf4aywKclCFfWZX7bcsIcAcKtpsr18PWQ5MQbNub2Om3M41fobcy19pnCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=creditkarma.com; spf=fail smtp.mailfrom=creditkarma.com; dkim=pass (2048-bit key) header.d=creditkarma.com header.i=@creditkarma.com header.b=t763rdhJ; dkim=pass (2048-bit key) header.d=creditkarma.com header.i=@creditkarma.com header.b=vhDV1t0a; arc=none smtp.client-ip=139.138.46.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=creditkarma.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=creditkarma.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=creditkarma.com header.i=@creditkarma.com header.b="t763rdhJ";
	dkim=pass (2048-bit key) header.d=creditkarma.com header.i=@creditkarma.com header.b="vhDV1t0a"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=creditkarma.com; i=@creditkarma.com; q=dns/txt; s=2;
  t=1780436460; x=1811972460;
  h=mime-version:from:date:message-id:subject:to;
  bh=24WhXYsTmqjD6DQlpaDHeAjuvrqLpOq+MwRRw1hftYE=;
  b=t763rdhJb94SQDH1Frgy0OzR6tr8y9s7BKAirjsvwzo4dZ38nJ0OMGpE
   a9Z9aPOelHzlkqu74xenneq+LmIYx64t45pXTWRh/uIbYjf4jXF84/iyv
   Zca6x9WwdbDbxO+ecSyj0PfU6uMyb+uPZBdo6bVBkKKHR3vJ53x1llvmz
   FwX9vuYZohWNbI6wLR7lCajSnJVLa1PZn7GLFZtXWGxgakWGMTbX+0Zf6
   DYm98KYLR8a4c8kttWJpw3/H4TdTv+EKSzKGQQDvD5Gk9BZXxvR9GAbKN
   A26ZJ2EGMmaMyiqlHZEJwBmy/yCjn+FIhurIdTh/j3HsR4zWt98vQ+WZ+
   A==;
X-CSE-ConnectionGUID: 3AIYohQRRReLuHKpueqXLw==
X-CSE-MsgGUID: 55OLomUOQte8eDvO0kVmug==
X-SBRS: None
X-ThreatScanner-Verdict: Negative
IronPort-Data: A9a23:boP70K6B12m9jmo39omDMgxRtGXGchMFZxGqfqrLsTDasY5as4F+v
 mQYCGiAb6mCNmfyc9t2aY+3phtX6J/Qn4VnHVZprXg1Eysa+MHIO4+Ufxz6V8+wwmwvb67FA
 +E2MISowBUcFyeEzvuVGuG/6yE6iefQH+SU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCkaGt
 MiaT/f3YDdJ4BYqdDhIg06/gEk35qqq5mtC5gVWic1j5zcyqVFEVfrzGonhdxMUcqEMdsamS
 uDKyq2O/2+x138FFtO/n7/nRVYBS7jUMBLmoiI+t3+K20UqSoQai87XBdJEAatlo2zhc+NZk
 b2hgaeNpTIBZcUgrgi/vy5wSEmSNYUekFPOzOPWXca7lyUqeFO0qxli4d1f0ST1NY+bDEkXn
 cH0JgzhYTjYrsOHx7KCcNNWi+A+DOrzIY4GilV/mGSx4fYOGfgvQo3P7N5cmSkr34VAQ6eYa
 M0eZj5iKh/HZnWjOH9NUMN4zLru3CCgNWMJwL6WjfNfD2z7ygtr2rX3LJzWe9GRSMF9lVyVq
 mPa/G3jBxhcP9uaodaA2i7927eSzX6lMG4UPODl0dpthWC0/3AeWBA6S3zjose8l0HrDrqzL
 GRRoELCt5Ma+023ZsfyUgf+o3OeuBMYHd1KHIUHBBqlz6PV50OHHTFBQGAQLtMhs8AySHoh0
 Vrhc87VOAGDeYa9ERq1nop4ZxvrUcTJBQfuvRM5cDY=
IronPort-HdrOrdr: A9a23:B+OLz6uKDNEtKSKvODJJ+B+u7skDTNV00zEX/kB9WHVpm6uj5q
 aTdZUgpHjJYVMqM03I9urtBEDtexzhHP1OgbX5X43NYOCOggLBRuxfBO3Zsl7d8kbFl9K1u5
 0QFpRWOZndCkV7kNa/wCTQKadF/DBfytHLudvj
X-Talos-CUID: 9a23:rsyAKWA0T2zR4RL6E3JO1X8TGvkfSEfQ6GrwAFelBH9ZbKLAHA==
X-Talos-MUID: 9a23:3r+Eqwjf7fyYjvzXBWSwCcMpaZpPx6OrNWc0jZhWtuWaEnRzBTKAg2Hi
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208,223";a="49505856"
Received: from mail-vs1-f69.google.com ([209.85.217.69])
  by ob1.hc3812-35.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jun 2026 14:40:59 -0700
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-6cfd441619aso1337382137.3
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 14:40:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780436458; x=1781041258;
        h=to:subject:message-id:date:from:mime-version:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9FUxXU3wAKeZRMZ7CINQe0xDczSNFTYK86tOFtLJf8E=;
        b=A+WhM7ZP9oSr6lzoVSeb45PV8VqIrhgC5rNryZG1y5Bs6lFlpJfoQHIqS4WMk54QNl
         6gwO/4Dg7lhuU+Ysylz1ZEyZMOlKNIBjMxQxJZKp8lb5s+Gh7qP3SkfH0FIA97OFnXkb
         Miu1KvY4dCWMn247lv7YKCX3cDTAvKYmKsTLdaUsY11+VdtXHbgWLmV7yBbRl6ZGdmzW
         C60r/lLneWl0MpbJwDvbNNiNVQ+mM/IJ1t3m6s0XofDp5oJWt/HBraVBiNq7brJKDG11
         IQfgVgfJ0ZWqGshv8SS18llpqyZ+kYyqcd8TRdv3yy+NWJSjQPv64FDL/QM1salKKFqA
         FpKQ==
X-Gm-Message-State: AOJu0YwcvIikO55g/FsZOe+GKxqX661CanqwVDMb5zWxFh4117ST7kM5
	Ryd2Kyw7eQZvRlP43iB+WfIcjzYn7PYPTes2JKJLF2vF57VX32gml0gjV46d4UAjL0PmiRkIOF0
	1CkboZ5bxJWfhUFYTA8rkF0D6muHNynHNeOa04vpqN1OHolnyj6KNHNwW73vMh/ZS7OMkjKRUnp
	4uJ6u4xQtC5oJXPTcfAjxlBadfLiyspTiYCWlFVdCxtgppPE5pStSWAmaYJwW5GikfOyahw2qpx
	nKfHVFrBIAEoRrnHhUdu1CPCXpScWGNuFulc4sTnw==
X-Gm-Gg: Acq92OHFFFyw+4sCKXvVg/yAZmcolOhDXCnhUiv7HrOW/o5IQgD12a8ex8FIDv1w7GW
	+z31MxgXsDay6Wm5sFGmsa9+25yARzAiEui+hTdnIaVfbCZXOUZXdbLKE6NepP7pdt9JESCKpDX
	yWB6/wNKkqC7gljPbzPmjO1YQvyf3R3KbUHYV5l62hYVvYswpYzRM+FHtZw8xYNhe0DoE5yyctC
	/obglFRVBBVwLmdRotfiMPP84+2gdy9i/psOdPBnH3NYExwi1Bdq0hrL9llqdL+wiCDTQVTa5Ns
	GZDXn7Fzqe6VnBZEZq1bz/eRyQqV+x7qFEQGW51LVAiXiXy3T/j2PYWqCLRlSQIZTr+/sxhlFBT
	+xsagjmVyKvE1SrnyoHAgeADVzxt8l1doVDhCAE53oeK/EGXf03gWSaStWKM5VOXidab5gaY+4V
	KDU6I8QEIQ/Y5k3Q==
X-Received: by 2002:a05:6102:5091:b0:6d6:c2ca:1c20 with SMTP id ada2fe7eead31-6ec4504f3a1mr234541137.14.1780436458492;
        Tue, 02 Jun 2026 14:40:58 -0700 (PDT)
X-Received: by 2002:a05:6102:5091:b0:6d6:c2ca:1c20 with SMTP id ada2fe7eead31-6ec4504f3a1mr234532137.14.1780436458041;
        Tue, 02 Jun 2026 14:40:58 -0700 (PDT)
Received: from was11a4.mail.zscalertwo.net (was11a4.mail.zscalertwo.net. [136.226.152.56])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-6eb5414f411sm41524137.1.2026.06.02.14.40.57
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 14:40:58 -0700 (PDT)
X-Relaying-Domain: creditkarma.com
Received: from mail-ot1-f69.google.com ([209.85.210.69])
	by was11a4.mail.zscalertwo.net ([136.226.152.43])
	with ESMTPS id 6A1F4DE908F60000;
	Tue, 02 Jun 2026 17:40:57 -0400
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e5e92fbe1fso17689518a34.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 14:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=creditkarma.com; s=google; t=1780436456; x=1781041256; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9FUxXU3wAKeZRMZ7CINQe0xDczSNFTYK86tOFtLJf8E=;
        b=vhDV1t0atev1risV2OESyBAdGwQSQoFMf9cgGihdcw9mScAMC3V4t/EqaBB3U5QrCW
         LMqjV4JeCU+eXjzWxzlE5AqKyEnra7XEqP9MXzK151tFSA/e4aqmKcqNPopm/I9zAEFp
         Vww14wxotk4BRB0I6oqS2c0edhBoZXjb4HRNZKmHYSDtzm6kdZKtP6fYBbUTCcYcx70B
         2K3e47ffvpTVmwDx0xzjExKdCrPedcROvRiV9Ec42dXdX8T+fMHOX3Ac9oAkGzHoWH3d
         9PJsLzbDZOsb7yvPhpYMNi6auryGjToUJWyl183uRLsTDg/F/hiQqdkuigOkWbtOGJnR
         atSQ==
X-Received: by 2002:a05:6830:719e:b0:7dc:d2ad:fb29 with SMTP id 46e09a7af769-7e6e9e0e53amr187677a34.24.1780436456498;
        Tue, 02 Jun 2026 14:40:56 -0700 (PDT)
X-Received: by 2002:a05:6830:719e:b0:7dc:d2ad:fb29 with SMTP id
 46e09a7af769-7e6e9e0e53amr187659a34.24.1780436455950; Tue, 02 Jun 2026
 14:40:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Kiesel, Norbert" <norbert.kiesel@creditkarma.com>
Date: Tue, 2 Jun 2026 14:40:44 -0700
X-Gm-Features: AVHnY4IPHlVrYbnuuTkkhboAudSNnuT0Sy-i4Sovfdrv-6zUG_EXEzbY9KgDLzs
Message-ID: <CAPGaHku+RAV+FA3C0md0xHiavfdB_anoqcMM06MAiU1VyMAdLA@mail.gmail.com>
Subject: [PATCH] worktree: record creation time and free-form note
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Zscaler-Block: 0

From 130cd5e4a25e6672b2a97268e1100b6ef03fa552 Mon Sep 17 00:00:00 2001
From: Norbert Kiesel <norbert.kiesel@creditkarma.com>
Date: Mon, 1 Jun 2026 17:03:39 -0700
Subject: [PATCH] worktree: record creation time and free-form note

Add per-worktree metadata so users can answer "what is this worktree
for, and when did I make it?" without resorting to external notes.

When `git worktree add` creates a linked worktree, it now writes a
`created` file containing the unix timestamp. A new `--note <string>`
option to `add`, and a new `git worktree annotate <worktree> [<note>]`
subcommand, store an optional free-form description in a `note` file
next to the other administrative files. Passing `annotate` without a
note clears it. The main worktree carries no metadata and cannot be
annotated.

`git worktree list` learns `--show-created` and `--show-note` for
human-readable output, and `--sort=<key>` (path or created, optionally
prefixed with `-` to reverse) for ordering linked worktrees; the main
worktree always stays first. Worktrees without a recorded timestamp
(those created before this change) display as `created: unknown` and
sort after timestamped ones. Porcelain output unconditionally emits
`created` and `note` lines when the corresponding metadata is present.

Tests cover add/annotate/list behaviour and the legacy-worktree case.
The two existing porcelain assertions in t2402 are taught to strip the
new `created` line so they continue to pass.

Signed-off-by: Norbert Kiesel <norbert.kiesel@creditkarma.com>
---
 Documentation/git-worktree.adoc |  61 ++++++++++++-
 builtin/worktree.c              | 152 +++++++++++++++++++++++++++++++-
 t/meson.build                   |   1 +
 t/t2402-worktree-list.sh        |  10 ++-
 t/t2410-worktree-metadata.sh    | 143 ++++++++++++++++++++++++++++++
 worktree.c                      |  78 ++++++++++++++++
 worktree.h                      |  23 +++++
 7 files changed, 459 insertions(+), 9 deletions(-)
 create mode 100755 t/t2410-worktree-metadata.sh

diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree.adoc
index fbf8426cd9..200f3d7772 100644
--- a/Documentation/git-worktree.adoc
+++ b/Documentation/git-worktree.adoc
@@ -10,8 +10,11 @@ SYNOPSIS
 --------
 [synopsis]
 git worktree add [-f] [--detach] [--checkout] [--lock [--reason <string>]]
+ [--note <string>]
  [--orphan] [(-b | -B) <new-branch>] <path> [<commit-ish>]
-git worktree list [-v | --porcelain [-z]]
+git worktree annotate <worktree> [<note>]
+git worktree list [-v | --porcelain [-z]] [--show-created] [--show-note]
+ [--sort=<key>]
 git worktree lock [--reason <string>] <worktree>
 git worktree move <worktree> <new-path>
 git worktree prune [-n] [-v] [--expire <expire>]
@@ -106,6 +109,15 @@ passed to the command. In the event the
repository has a remote and
 command fails with a warning reminding the user to fetch from their remote
 first (or override by using `-f`/`--force`).

+`annotate <worktree> [<note>]`::
+
+Set, replace, or clear a free-form note (description) on a linked worktree.
+Useful for recording what a worktree was created for so it can be identified
+later. With _<note>_, the worktree's note is set or replaced; without a note
+argument, the existing note is cleared. The note for a worktree may also be
+set at creation time with `git worktree add --note <note>`. The main
+worktree cannot be annotated.
+
 `list`::

 List details of each worktree.  The main worktree is listed first,
@@ -114,6 +126,20 @@ whether the worktree is bare, the revision
currently checked out, the
 branch currently checked out (or "detached HEAD" if none), "locked" if
 the worktree is locked, "prunable" if the worktree can be pruned by the
 `prune` command.
++
+Each worktree's creation timestamp is recorded when it is created with
+`git worktree add`. Worktrees created before this feature existed have no
+recorded creation timestamp; for them, `list` reports `created: unknown`
+in human output and omits the `created` line in `--porcelain` output. Pass
+`--show-created` to include creation timestamps in human output. Worktrees
+without a recorded timestamp sort last (or first when reversed) with
+`--sort=created`.
++
+Pass `--show-note` to include any user-provided note in human output. In
+`--porcelain` output, both `created` and `note` lines are emitted whenever
+present. Use `--sort=<key>` (where _<key>_ is `path` or `created`,
+optionally prefixed with `-` to reverse) to order the linked worktrees;
+the main worktree always remains first.

 `lock`::

@@ -286,6 +312,32 @@ _<time>_.
  With `lock` or with `add --lock`, an explanation why the worktree
  is locked.

+`--note <string>`::
+ With `add`, attach a free-form note (description) to the new worktree.
+ The note is stored alongside the worktree's administrative files and
+ can be displayed with `git worktree list --show-note` or in
+ `--porcelain` output. It can be changed later with
+ `git worktree annotate`.
+
+`--show-created`::
+ With `list`, include each worktree's creation timestamp in the
+ human-readable output. Worktrees with no recorded creation time are
+ shown as `created: unknown`. In `--porcelain` output, the creation
+ timestamp is always included (when available) on a `created` line.
+
+`--show-note`::
+ With `list`, include each worktree's note (if set) in the
+ human-readable output. In `--porcelain` output, the note is always
+ included (when set) on a `note` line.
+
+`--sort=<key>`::
+ With `list`, sort linked worktrees by _<key>_, which is one of
+ `path` or `created`. Prefix with `-` to reverse the order, e.g.
+ `--sort=-created` lists newest first. The main worktree is always
+ listed first regardless of sort order. Worktrees with no recorded
+ creation timestamp sort after those that have one (or before, when
+ reversed).
+
 _<worktree>_::
  Worktrees can be identified by path, either relative or absolute.
 +
@@ -462,7 +514,9 @@ are terminated with NUL rather than a newline.
Attributes are listed with a
 label and value separated by a single space.  Boolean attributes (like `bare`
 and `detached`) are listed as a label only, and are present only
 if the value is true.  Some attributes (like `locked`) can be listed as a label
-only or with a value depending upon whether a reason is available.  The first
+only or with a value depending upon whether a reason is available.  Optional
+valued attributes (like `created` and `note`) appear only when the
+corresponding metadata has been recorded for that worktree.  The first
 attribute of a worktree is always `worktree`, an empty line indicates the
 end of the record.  For example:

@@ -474,10 +528,13 @@ bare
 worktree /path/to/linked-worktree
 HEAD abcd1234abcd1234abcd1234abcd1234abcd1234
 branch refs/heads/master
+created 2026-06-01T12:34:56Z
+note investigating login bug

 worktree /path/to/other-linked-worktree
 HEAD 1234abc1234abc1234abc1234abc1234abc1234a
 detached
+created 2026-05-28T08:15:00Z

 worktree /path/to/linked-worktree-locked-no-reason
 HEAD 5678abc5678abc5678abc5678abc5678abc5678c
diff --git a/builtin/worktree.c b/builtin/worktree.c
index d21c43fde3..ac22277d6c 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -27,13 +27,16 @@
 #include "utf8.h"
 #include "worktree.h"
 #include "quote.h"
+#include "date.h"

 #define BUILTIN_WORKTREE_ADD_USAGE \
  N_("git worktree add [-f] [--detach] [--checkout] [--lock [--reason
<string>]]\n" \
+    "                 [--note <string>]\n" \
     "                 [--orphan] [(-b | -B) <new-branch>] <path>
[<commit-ish>]")

 #define BUILTIN_WORKTREE_LIST_USAGE \
- N_("git worktree list [-v | --porcelain [-z]]")
+ N_("git worktree list [-v | --porcelain [-z]] [--show-created]
[--show-note]\n" \
+    "                  [--sort=<key>]")
 #define BUILTIN_WORKTREE_LOCK_USAGE \
  N_("git worktree lock [--reason <string>] <worktree>")
 #define BUILTIN_WORKTREE_MOVE_USAGE \
@@ -46,6 +49,8 @@
  N_("git worktree repair [<path>...]")
 #define BUILTIN_WORKTREE_UNLOCK_USAGE \
  N_("git worktree unlock <worktree>")
+#define BUILTIN_WORKTREE_ANNOTATE_USAGE \
+ N_("git worktree annotate <worktree> [<note>]")

 #define WORKTREE_ADD_DWIM_ORPHAN_INFER_TEXT \
  _("No possible source branch, inferring '--orphan'")
@@ -66,6 +71,7 @@

 static const char * const git_worktree_usage[] = {
  BUILTIN_WORKTREE_ADD_USAGE,
+ BUILTIN_WORKTREE_ANNOTATE_USAGE,
  BUILTIN_WORKTREE_LIST_USAGE,
  BUILTIN_WORKTREE_LOCK_USAGE,
  BUILTIN_WORKTREE_MOVE_USAGE,
@@ -116,6 +122,11 @@ static const char * const git_worktree_unlock_usage[] = {
  NULL
 };

+static const char * const git_worktree_annotate_usage[] = {
+ BUILTIN_WORKTREE_ANNOTATE_USAGE,
+ NULL
+};
+
 struct add_opts {
  int force;
  int detach;
@@ -124,6 +135,7 @@ struct add_opts {
  int orphan;
  int relative_paths;
  const char *keep_locked;
+ const char *note;
 };

 static int show_only;
@@ -131,6 +143,8 @@ static int verbose;
 static int guess_remote;
 static int use_relative_paths;
 static timestamp_t expire;
+static int show_created;
+static int show_note;

 static int git_worktree_config(const char *var, const char *value,
         const struct config_context *ctx, void *cb)
@@ -544,6 +558,16 @@ static int add_worktree(const char *path, const
char *refname,
  strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
  write_file(sb.buf, "../..");

+ strbuf_reset(&sb);
+ strbuf_addf(&sb, "%s/created", sb_repo.buf);
+ write_file(sb.buf, "%"PRItime, (timestamp_t) time(NULL));
+
+ if (opts->note && *opts->note) {
+ strbuf_reset(&sb);
+ strbuf_addf(&sb, "%s/note", sb_repo.buf);
+ write_file(sb.buf, "%s", opts->note);
+ }
+
  /*
  * Set up the ref store of the worktree and create the HEAD reference.
  */
@@ -815,6 +839,8 @@ static int add(int ac, const char **av, const char *prefix,
  OPT_BOOL(0, "lock", &keep_locked, N_("keep the new working tree locked")),
  OPT_STRING(0, "reason", &lock_reason, N_("string"),
     N_("reason for locking")),
+ OPT_STRING(0, "note", &opts.note, N_("string"),
+    N_("attach a free-form note/description to the worktree")),
  OPT__QUIET(&opts.quiet, N_("suppress progress reporting")),
  OPT_PASSTHRU(0, "track", &opt_track, NULL,
       N_("set up tracking mode (see git-branch(1))"),
@@ -963,6 +989,8 @@ static int add(int ac, const char **av, const char *prefix,
 static void show_worktree_porcelain(struct worktree *wt, int line_terminator)
 {
  const char *reason;
+ const char *note;
+ timestamp_t created;

  printf("worktree %s%c", wt->path, line_terminator);
  if (wt->is_bare)
@@ -975,6 +1003,18 @@ static void show_worktree_porcelain(struct
worktree *wt, int line_terminator)
  printf("branch %s%c", wt->head_ref, line_terminator);
  }

+ created = worktree_created_at(wt);
+ if (created)
+ printf("created %s%c",
+        show_date(created, 0, DATE_MODE(ISO8601_STRICT)),
+        line_terminator);
+
+ note = worktree_note(wt);
+ if (note && *note) {
+ fputs("note ", stdout);
+ write_name_quoted(note, stdout, line_terminator);
+ }
+
  reason = worktree_lock_reason(wt);
  if (reason) {
  fputs("locked", stdout);
@@ -1034,6 +1074,21 @@ static void show_worktree(struct worktree *wt,
struct worktree_display *display,
  else if (reason)
  strbuf_addstr(&sb, " prunable");

+ if (show_created || verbose) {
+ timestamp_t created = worktree_created_at(wt);
+ if (created)
+ strbuf_addf(&sb, "\n\tcreated: %s",
+     show_date(created, 0, DATE_MODE(ISO8601)));
+ else if (show_created && !is_main_worktree(wt))
+ strbuf_addstr(&sb, "\n\tcreated: unknown");
+ }
+
+ if (show_note || verbose) {
+ const char *note = worktree_note(wt);
+ if (note && *note)
+ strbuf_addf(&sb, "\n\tnote: %s", note);
+ }
+
  printf("%s\n", sb.buf);
  strbuf_release(&sb);
 }
@@ -1068,6 +1123,27 @@ static int pathcmp(const void *a_, const void *b_)
  return fspathcmp((*a)->path, (*b)->path);
 }

+static int createdcmp(const void *a_, const void *b_)
+{
+ struct worktree *const *a = a_;
+ struct worktree *const *b = b_;
+ timestamp_t ta = worktree_created_at(*a);
+ timestamp_t tb = worktree_created_at(*b);
+
+ /* Worktrees without a recorded timestamp (legacy) sort after those
with one. */
+ if (!ta && !tb)
+ return fspathcmp((*a)->path, (*b)->path);
+ if (!ta)
+ return 1;
+ if (!tb)
+ return -1;
+ if (ta < tb)
+ return -1;
+ if (ta > tb)
+ return 1;
+ return 0;
+}
+
 static void pathsort(struct worktree **wt)
 {
  int n = 0;
@@ -1078,11 +1154,43 @@ static void pathsort(struct worktree **wt)
  QSORT(wt, n, pathcmp);
 }

+static int sort_worktrees(struct worktree **wt, const char *key)
+{
+ int n = 0, reverse = 0;
+ struct worktree **p = wt;
+ int (*cmp)(const void *, const void *);
+
+ if (*key == '-') {
+ reverse = 1;
+ key++;
+ }
+ if (!strcmp(key, "path"))
+ cmp = pathcmp;
+ else if (!strcmp(key, "created"))
+ cmp = createdcmp;
+ else
+ return -1;
+
+ while (*p++)
+ n++;
+ QSORT(wt, n, cmp);
+ if (reverse) {
+ int i;
+ for (i = 0; i < n / 2; i++) {
+ struct worktree *tmp = wt[i];
+ wt[i] = wt[n - 1 - i];
+ wt[n - 1 - i] = tmp;
+ }
+ }
+ return 0;
+}
+
 static int list(int ac, const char **av, const char *prefix,
  struct repository *repo UNUSED)
 {
  int porcelain = 0;
  int line_terminator = '\n';
+ const char *sort_key = NULL;

  struct option options[] = {
  OPT_BOOL(0, "porcelain", &porcelain, N_("machine-readable output")),
@@ -1091,6 +1199,12 @@ static int list(int ac, const char **av, const
char *prefix,
  N_("add 'prunable' annotation to missing worktrees older than <time>")),
  OPT_SET_INT('z', NULL, &line_terminator,
      N_("terminate records with a NUL character"), '\0'),
+ OPT_BOOL(0, "show-created", &show_created,
+ N_("show worktree creation timestamps")),
+ OPT_BOOL(0, "show-note", &show_note,
+ N_("show worktree notes")),
+ OPT_STRING(0, "sort", &sort_key, N_("key"),
+    N_("sort worktrees by key (path, created); prefix with - to reverse")),
  OPT_END()
  };

@@ -1107,8 +1221,13 @@ static int list(int ac, const char **av, const
char *prefix,
  int path_maxwidth = 0, abbrev = DEFAULT_ABBREV, i;
  struct worktree_display *display = NULL;

- /* sort worktrees by path but keep main worktree at top */
- pathsort(worktrees + 1);
+ /* sort worktrees but keep main worktree at top */
+ if (sort_key) {
+ if (sort_worktrees(worktrees + 1, sort_key))
+ die(_("unknown sort key '%s'"), sort_key);
+ } else {
+ pathsort(worktrees + 1);
+ }

  if (!porcelain)
  measure_widths(worktrees, &abbrev,
@@ -1200,6 +1319,32 @@ static int unlock_worktree(int ac, const char
**av, const char *prefix,
  return ret;
 }

+static int annotate_worktree(int ac, const char **av, const char *prefix,
+      struct repository *repo UNUSED)
+{
+ struct option options[] = {
+ OPT_END()
+ };
+ struct worktree **worktrees, *wt;
+ int ret;
+
+ ac = parse_options(ac, av, prefix, options, git_worktree_annotate_usage, 0);
+ if (ac < 1 || ac > 2)
+ usage_with_options(git_worktree_annotate_usage, options);
+
+ worktrees = get_worktrees();
+ wt = find_worktree(worktrees, prefix, av[0]);
+ if (!wt)
+ die(_("'%s' is not a working tree"), av[0]);
+ if (is_main_worktree(wt))
+ die(_("The main working tree cannot be annotated"));
+
+ ret = set_worktree_note(wt, ac == 2 ? av[1] : NULL);
+
+ free_worktrees(worktrees);
+ return ret;
+}
+
 static void validate_no_submodules(const struct worktree *wt)
 {
  struct index_state istate = INDEX_STATE_INIT(the_repository);
@@ -1469,6 +1614,7 @@ int cmd_worktree(int ac,
  parse_opt_subcommand_fn *fn = NULL;
  struct option options[] = {
  OPT_SUBCOMMAND("add", &fn, add),
+ OPT_SUBCOMMAND("annotate", &fn, annotate_worktree),
  OPT_SUBCOMMAND("prune", &fn, prune),
  OPT_SUBCOMMAND("list", &fn, list),
  OPT_SUBCOMMAND("lock", &fn, lock_worktree),
diff --git a/t/meson.build b/t/meson.build
index 2af8d01279..7b6e8435d7 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -308,6 +308,7 @@ integration_tests = [
   't2405-worktree-submodule.sh',
   't2406-worktree-repair.sh',
   't2407-worktree-heads.sh',
+  't2410-worktree-metadata.sh',
   't2500-untracked-overwriting.sh',
   't2501-cwd-empty.sh',
   't3000-ls-files-others.sh',
diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
index e0c6abd2f5..8422340443 100755
--- a/t/t2402-worktree-list.sh
+++ b/t/t2402-worktree-list.sh
@@ -71,7 +71,8 @@ test_expect_success '"list" all worktrees --porcelain' '
  echo "HEAD $(git rev-parse HEAD)" >>expect &&
  echo "detached" >>expect &&
  echo >>expect &&
- git worktree list --porcelain >actual &&
+ git worktree list --porcelain >actual.raw &&
+ grep -v "^created " actual.raw >actual &&
  test_cmp expect actual
 '

@@ -86,7 +87,7 @@ test_expect_success '"list" all worktrees --porcelain -z' '
  "$(git -C here rev-parse --show-toplevel)" \
  "$(git rev-parse HEAD)" >>expect &&
  git worktree list --porcelain -z >_actual &&
- nul_to_q <_actual >actual &&
+ nul_to_q <_actual | tr Q "\n" | grep -v "^created " | tr "\n" Q >actual &&
  test_cmp expect actual
 '

@@ -220,7 +221,7 @@ test_expect_success '"list" all worktrees from bare main' '
 '

 test_expect_success '"list" all worktrees --porcelain from bare main' '
- test_when_finished "rm -rf there actual expect && git -C bare1
worktree prune" &&
+ test_when_finished "rm -rf there actual actual.raw expect && git -C
bare1 worktree prune" &&
  git -C bare1 worktree add --detach ../there main &&
  echo "worktree $(pwd)/bare1" >expect &&
  echo "bare" >>expect &&
@@ -229,7 +230,8 @@ test_expect_success '"list" all worktrees
--porcelain from bare main' '
  echo "HEAD $(git -C there rev-parse HEAD)" >>expect &&
  echo "detached" >>expect &&
  echo >>expect &&
- git -C bare1 worktree list --porcelain >actual &&
+ git -C bare1 worktree list --porcelain >actual.raw &&
+ grep -v "^created " actual.raw >actual &&
  test_cmp expect actual
 '

diff --git a/t/t2410-worktree-metadata.sh b/t/t2410-worktree-metadata.sh
new file mode 100755
index 0000000000..3f8b508593
--- /dev/null
+++ b/t/t2410-worktree-metadata.sh
@@ -0,0 +1,143 @@
+#!/bin/sh
+
+test_description='git worktree creation timestamp and note metadata'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+ test_commit init
+'
+
+test_expect_success 'add writes created file' '
+ test_when_finished "git worktree remove -f wt1 && git worktree prune" &&
+ git worktree add wt1 &&
+ test_path_is_file .git/worktrees/wt1/created &&
+ # contents should be a positive integer (unix timestamp)
+ created=$(cat .git/worktrees/wt1/created) &&
+ test "$created" -gt 0
+'
+
+test_expect_success 'add --note writes note file' '
+ test_when_finished "git worktree remove -f wt2 && git worktree prune" &&
+ git worktree add --note "investigating bug" wt2 &&
+ test_path_is_file .git/worktrees/wt2/note &&
+ echo "investigating bug" >expect &&
+ test_cmp expect .git/worktrees/wt2/note
+'
+
+test_expect_success 'add without --note does not create note file' '
+ test_when_finished "git worktree remove -f wt3 && git worktree prune" &&
+ git worktree add wt3 &&
+ test_path_is_missing .git/worktrees/wt3/note
+'
+
+test_expect_success 'annotate sets a note on an existing worktree' '
+ test_when_finished "git worktree remove -f wt4 && git worktree prune" &&
+ git worktree add wt4 &&
+ git worktree annotate wt4 "later note" &&
+ echo "later note" >expect &&
+ test_cmp expect .git/worktrees/wt4/note
+'
+
+test_expect_success 'annotate replaces an existing note' '
+ test_when_finished "git worktree remove -f wt5 && git worktree prune" &&
+ git worktree add --note "old" wt5 &&
+ git worktree annotate wt5 "new" &&
+ echo "new" >expect &&
+ test_cmp expect .git/worktrees/wt5/note
+'
+
+test_expect_success 'annotate with no text clears the note' '
+ test_when_finished "git worktree remove -f wt6 && git worktree prune" &&
+ git worktree add --note "to delete" wt6 &&
+ test_path_is_file .git/worktrees/wt6/note &&
+ git worktree annotate wt6 &&
+ test_path_is_missing .git/worktrees/wt6/note
+'
+
+test_expect_success 'annotate refuses to operate on the main worktree' '
+ test_must_fail git worktree annotate . "should fail" 2>err &&
+ grep -i "main working tree" err
+'
+
+test_expect_success 'list --show-note displays note in human output' '
+ test_when_finished "git worktree remove -f wt7 && git worktree prune" &&
+ git worktree add --note "release branch" wt7 &&
+ git worktree list --show-note >actual &&
+ grep "note: release branch" actual
+'
+
+test_expect_success 'list --show-created displays created timestamp' '
+ test_when_finished "git worktree remove -f wt8 && git worktree prune" &&
+ git worktree add wt8 &&
+ git worktree list --show-created >actual &&
+ grep "created: " actual
+'
+
+test_expect_success 'list --show-created shows unknown for legacy worktrees' '
+ test_when_finished "git worktree remove -f wt9 && git worktree prune" &&
+ git worktree add wt9 &&
+ rm .git/worktrees/wt9/created &&
+ git worktree list --show-created >actual &&
+ grep "created: unknown" actual
+'
+
+test_expect_success 'list --porcelain always includes created and note' '
+ test_when_finished "git worktree remove -f wtp && git worktree prune" &&
+ git worktree add --note "porcelain test" wtp &&
+ git worktree list --porcelain >actual &&
+ grep "^created " actual &&
+ grep "^note porcelain test" actual
+'
+
+test_expect_success 'list --sort=created orders by creation time' '
+ test_when_finished "git worktree remove -f a && git worktree remove
-f b && git worktree remove -f c && git worktree prune" &&
+ git worktree add a &&
+ git worktree add b &&
+ git worktree add c &&
+ echo 1000 >.git/worktrees/a/created &&
+ echo 2000 >.git/worktrees/b/created &&
+ echo 3000 >.git/worktrees/c/created &&
+ git worktree list --sort=created --porcelain >actual &&
+ grep "^worktree " actual | sed -n "2,4p" >linked &&
+ awk "NR==1" linked | grep -q "/a$" &&
+ awk "NR==2" linked | grep -q "/b$" &&
+ awk "NR==3" linked | grep -q "/c$"
+'
+
+test_expect_success 'list --sort=-created reverses order' '
+ test_when_finished "git worktree remove -f a && git worktree remove
-f b && git worktree remove -f c && git worktree prune" &&
+ git worktree add a &&
+ git worktree add b &&
+ git worktree add c &&
+ echo 1000 >.git/worktrees/a/created &&
+ echo 2000 >.git/worktrees/b/created &&
+ echo 3000 >.git/worktrees/c/created &&
+ git worktree list --sort=-created --porcelain >actual &&
+ grep "^worktree " actual | sed -n "2,4p" >linked &&
+ awk "NR==1" linked | grep -q "/c$" &&
+ awk "NR==2" linked | grep -q "/b$" &&
+ awk "NR==3" linked | grep -q "/a$"
+'
+
+test_expect_success 'list --sort=created places legacy worktrees last' '
+ test_when_finished "git worktree remove -f early && git worktree
remove -f legacy && git worktree prune" &&
+ git worktree add early &&
+ echo 1000 >.git/worktrees/early/created &&
+ git worktree add legacy &&
+ rm .git/worktrees/legacy/created &&
+ git worktree list --sort=created --porcelain >actual &&
+ grep "^worktree " actual | sed -n "2,3p" >linked &&
+ awk "NR==1" linked | grep -q "/early$" &&
+ awk "NR==2" linked | grep -q "/legacy$"
+'
+
+test_expect_success 'list --sort with unknown key fails' '
+ test_must_fail git worktree list --sort=bogus 2>err &&
+ grep -i "unknown sort key" err
+'
+
+test_done
diff --git a/worktree.c b/worktree.c
index 97eddc3916..7989e694b7 100644
--- a/worktree.c
+++ b/worktree.c
@@ -14,6 +14,8 @@
 #include "dir.h"
 #include "wt-status.h"
 #include "config.h"
+#include "date.h"
+#include "wrapper.h"

 void free_worktree(struct worktree *worktree)
 {
@@ -24,6 +26,7 @@ void free_worktree(struct worktree *worktree)
  free(worktree->head_ref);
  free(worktree->lock_reason);
  free(worktree->prune_reason);
+ free(worktree->note);
  free(worktree);
 }

@@ -324,6 +327,81 @@ const char *worktree_lock_reason(struct worktree *wt)
  return wt->lock_reason;
 }

+timestamp_t worktree_created_at(struct worktree *wt)
+{
+ if (is_main_worktree(wt))
+ return 0;
+
+ if (!wt->created_at_valid) {
+ struct strbuf path = STRBUF_INIT;
+ struct strbuf buf = STRBUF_INIT;
+
+ strbuf_addstr(&path, worktree_git_path(wt, "created"));
+ if (file_exists(path.buf) &&
+     strbuf_read_file(&buf, path.buf, 0) >= 0) {
+ char *end;
+ timestamp_t t;
+ strbuf_trim(&buf);
+ t = parse_timestamp(buf.buf, &end, 10);
+ if (end != buf.buf && *end == '\0')
+ wt->created_at = t;
+ }
+ wt->created_at_valid = 1;
+ strbuf_release(&path);
+ strbuf_release(&buf);
+ }
+
+ return wt->created_at;
+}
+
+const char *worktree_note(struct worktree *wt)
+{
+ if (is_main_worktree(wt))
+ return NULL;
+
+ if (!wt->note_valid) {
+ struct strbuf path = STRBUF_INIT;
+
+ strbuf_addstr(&path, worktree_git_path(wt, "note"));
+ if (file_exists(path.buf)) {
+ struct strbuf note = STRBUF_INIT;
+ if (strbuf_read_file(&note, path.buf, 0) < 0)
+ die_errno(_("failed to read '%s'"), path.buf);
+ strbuf_trim_trailing_newline(&note);
+ wt->note = strbuf_detach(&note, NULL);
+ } else
+ wt->note = NULL;
+ wt->note_valid = 1;
+ strbuf_release(&path);
+ }
+
+ return wt->note;
+}
+
+int set_worktree_note(struct worktree *wt, const char *text)
+{
+ char *path;
+ int ret = 0;
+
+ if (is_main_worktree(wt))
+ return error(_("cannot set note on the main worktree"));
+
+ path = repo_common_path(wt->repo, "worktrees/%s/note", wt->id);
+ if (!text || !*text) {
+ if (file_exists(path) && unlink(path))
+ ret = error_errno(_("failed to remove '%s'"), path);
+ } else {
+ write_file(path, "%s", text);
+ }
+
+ /* invalidate cache so a follow-up worktree_note() re-reads */
+ FREE_AND_NULL(wt->note);
+ wt->note_valid = 0;
+
+ free(path);
+ return ret;
+}
+
 const char *worktree_prune_reason(struct worktree *wt, timestamp_t expire)
 {
  struct strbuf reason = STRBUF_INIT;
diff --git a/worktree.h b/worktree.h
index 1075409f9a..0fcdb8bd1b 100644
--- a/worktree.h
+++ b/worktree.h
@@ -13,12 +13,16 @@ struct worktree {
  char *head_ref; /* NULL if HEAD is broken or detached */
  char *lock_reason; /* private - use worktree_lock_reason */
  char *prune_reason;     /* private - use worktree_prune_reason */
+ char *note; /* private - use worktree_note */
  struct object_id head_oid;
+ timestamp_t created_at; /* private - use worktree_created_at; 0 if unknown */
  int is_detached;
  int is_bare;
  int is_current; /* does `path` match `repo->worktree` */
  int lock_reason_valid; /* private */
  int prune_reason_valid; /* private */
+ int note_valid;        /* private */
+ int created_at_valid;  /* private */
 };

 /*
@@ -96,6 +100,25 @@ int is_main_worktree(const struct worktree *wt);
  */
 const char *worktree_lock_reason(struct worktree *wt);

+/*
+ * Return the worktree's recorded creation timestamp, or 0 if no timestamp
+ * was recorded (e.g. a worktree created before this metadata existed, or
+ * the main worktree which never carries the file).
+ */
+timestamp_t worktree_created_at(struct worktree *wt);
+
+/*
+ * Return the user-supplied note/description for the given worktree, or NULL
+ * if none was set.
+ */
+const char *worktree_note(struct worktree *wt);
+
+/*
+ * Write or replace the worktree's note. Pass NULL or "" to delete the note.
+ * Returns 0 on success, -1 on failure. Not valid for the main worktree.
+ */
+int set_worktree_note(struct worktree *wt, const char *text);
+
 /*
  * Return the reason string if the given worktree should be pruned, otherwise
  * NULL if it should not be pruned. `expire` defines a grace period to prune
--
