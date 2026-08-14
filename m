Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F4318FDDE
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 05:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786683697; cv=pass; b=jASJE9rhQ+FOwN9arFt9pnWyqox+W/kg1OaUrrGcqtd32E+VRAYrUCH/YJXp83/EprdTrI1sf94JSYfuBN3NICMSY+EduWuQWT9AyptUSKj2AnreQU4dACMMjqipLpqo+4cIm63pzfAlIVZ4trBFs9OLb08aEN44PVX5bGglcDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786683697; c=relaxed/simple;
	bh=4gHojv9V3RdeDxvdPJ76AtrAeeCBi0uWc7mAV7wPfeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qQaSN5+u2GkRX9fc2yjaRlZaOwy9/9V8zcJZElrpmBLEQW/AczLUad40qfvLii+Fft3VE4q8eRk8ooWB71q/8yJHm43wAuXaHCIx32nM8mXWcoNWs75iWx5Zl5jeDinsB1honTitXAmyz5Kr2I8K+JLPyIox/qg/CBoIcJipMPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHNmaUKa; arc=pass smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHNmaUKa"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7e6b5737bb2so884584a34.1
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 22:01:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786683694; cv=none;
        d=google.com; s=arc-20260327;
        b=oIOhkmUU99aWAZ9vejoeCBXVlSgEal2BL/mGl/LQ2z2nsJvHo+kc3rofNT/ohVIREZ
         J67KXUwaTbyQQrzA+bOrZQOrzLjkb8wvi2baJ1FKq4TdYfkA1thMm3ESoUosfU/9isjr
         Xv2PiwdJxtymUuDD6QCKHsctb6hmZkD5z8+pCY5j+SbD92Czc4X9jOskdftz0o4vTNdi
         pH3eCKTpjw5yS4FTCjkzkK3uTesW3xKNIyD/abGT2GlUrKC59T99YxoSGNRKg1SXntg2
         HRc2nJN91pamMaMIGGUmOSkohyn838Tq6p/WM2Lu6/+cbUPFpuSNcguBzpyQm/B9eMXi
         zLWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hy2Ko8Dc2NgfGBxV5PGqL5zFvYfhHphTvuwc+uzHYCg=;
        fh=KcLPyDvuDtNuvCF6EykC90rZjs1iwQxKqbXL14Ti280=;
        b=VdOPPbLL6ebSyxV0L4VNE9OEavghG6CwhlD3IZDXxSfFI2p0gxzy1+BlYqZU7aFvP4
         1p1nNUsSDGSFEBJZDmdGSzFcA22IoDsc1Vo7vrdWTPiF2mE44vq2CSuB5zanDRi7YfL7
         7MwiwS7hEfelhVnR1HMERYE9ecc8WpSFpQj354gms7XJ9dkYF06NusWBpl2eSaKKPV2y
         kp/4Fe0A0Ehrn9qQftPSfe1Vfu1F/f8mYXQ7/m8SmJjpFLZV5VURWX5Fd0XyIHou9s+8
         apDvE9b1K/OYPYxH9ANkWNyqYIYIIShJfY6s6dRFLnSvsDkBLhS971td5tU7cMHLm/9U
         4+gA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786683694; x=1787288494; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Hy2Ko8Dc2NgfGBxV5PGqL5zFvYfhHphTvuwc+uzHYCg=;
        b=iHNmaUKa64DdZs0eCwgaRYi6fAcIauM1VhWSZw/gYLuWpvz4SrP6d2xJtTNLak/xvu
         6SlOxwILkS/Ce38CoQX0NV4Sm84dWJuzkCgBWR1ybt4oad6Eqz8qZSuxIh/ie6TdvLRn
         cmC4GT2X7boJ0ZGzJkJDBgGWIDvRFbUhMsed1CK57wPTg7/NQL+va5tWHQLvMJzhOPUY
         GUxwI2E9ORs7uwLccI/DpJUQAdCcIaerxK0Vc9q6MMUoToOyGiT6q0UR/WJmUMp9L8eu
         Yy93Qat1qYwAODfcrAf72alg5HeuDkWsgHjd3n2iDkhL1G1aTLgBH3O+urbO03Y4h/Wh
         HlBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786683694; x=1787288494;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hy2Ko8Dc2NgfGBxV5PGqL5zFvYfhHphTvuwc+uzHYCg=;
        b=OrI9jFa9aSSmdRsCMY6b7tF6gtKbdhbPmQoCjVubhyveSjA2D4yuGmJd7X08GlyK4I
         EEf00E28pLnYus+emzPMin5WFRpKUXNQJv2KACFVGlTCC88xRmmKcYhza2kpF23afAOV
         DSoKp94oVcECqkSlDtraHiP8jUzt+mPew6cnVisLVJaj84cngI8QJvfH/jQmItzq2SiQ
         TL2oP3Hluq8zgEy5RWHItstEclkFKvAEmUZuu3VsfbQoNd6X1jcCXt46wK+INWSIf7Xa
         6oW6rHeMZnB4Wcpd903ZyvVIeX4Yx8QzHHFSxsJq21vwdzS7Lknib+XprzxqUJUZtQiC
         pYZw==
X-Forwarded-Encrypted: i=1; AHgh+Rr/22S88/JMaZMBsCTApSyvcbRqH8Gxn7rKiK1cNa6s93CpT6cAhGgEaje1VyD23mAGGKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YztvjsozaOnLLpVlmrUUwFOQsjkeqbivxrLXtJ7ncE75agzPHw3
	1zxwg+GuNsPGJPgi5Q6uFUq3ljn9kRp6szwVFoQLIu4P6wvVmPVcCiYuqumfh10s+mpL18UgPJW
	4ndGB6IeIrxTEq4Sdo3lk91lwQ72fTrw=
X-Gm-Gg: AR+sD10rHDLhWadfURGwPfBZfwUHCccsjqCMHp22uJOyzsnZPJvJVVGDyu8Zj2MRWnP
	piS4KlNWNCgm7RXNQmFsa7Vwsq9cRMWvutL/lCrJE4HMCmkH+vM5etR9DxwtnsNM6HSKNj8PGVr
	2MTm9rx1gRKdyh4Rq5L8GJLJccQs07R5JRiJ5AXLNVj2q8k593j/hk4PuO1afsUOAylQy/IzivW
	97Whshn+Vj54UMKLcEo6QVzv4FZMag0feJT4oLS03O+fTnD4yE3rekLC6tADXjDZBgtYVv7tw+p
	vv82m+qnw1MKsfPPlQQVVZDbAbCDCSo6CWM3sauBvs4H+S6QqMy9gX+SBx4aWWxeA/7GkZIpVLr
	bYb8uagjnGC9if2uB1NkqspAte1JCrXI2feo4fnk2jHJMxCllCQ9ByfmHGAuRowQ=
X-Received: by 2002:a05:6830:398c:b0:7e6:f7fb:9678 with SMTP id
 46e09a7af769-7f3de419859mr2737178a34.1.1786683693885; Thu, 13 Aug 2026
 22:01:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701-pks-libgit-in-subdir-v3-0-5e4860056094@pks.im>
 <20260701-pks-libgit-in-subdir-v3-2-5e4860056094@pks.im> <alR9GDNTbdjWB4dq@szeder.dev>
 <2d455ecf-972e-e3ce-54bc-683050c04282@gmx.de> <xmqqjyqpb96n.fsf@gitster.g>
 <ansSg4qsPwh5FcR9@pks.im> <xmqqpkzo39d2.fsf@gitster.g> <antWRHPHHES4a1KT@pks.im>
 <693a61b6-e762-d864-d25b-348485ec039e@gmx.de> <xmqqqzk2t7sm.fsf@gitster.g> <CAC2QwmKs-TV2f=2BhBNQGtVA4vzciN-Vkh95RkGcVKe=6zwwRQ@mail.gmail.com>
In-Reply-To: <CAC2QwmKs-TV2f=2BhBNQGtVA4vzciN-Vkh95RkGcVKe=6zwwRQ@mail.gmail.com>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Thu, 13 Aug 2026 22:01:21 -0700
X-Gm-Features: AUfX_mzZQtVwt54pJBhPZopfSKBa44jAdxP5i9g0ic-cWtZYbMzyzHBnBhmS3as
Message-ID: <CAC2QwmKSrDN1s9a1dR3q165+6LxSrVksY+KWn284ehYrthZ98A@mail.gmail.com>
Subject: Re: [PATCH RFC v3 2/2] Move libgit.a sources into separate "lib/" directory
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, Patrick Steinhardt <ps@pks.im>, 
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, git@vger.kernel.org, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Elijah Newren <newren@gmail.com>, 
	Derrick Stolee <stolee@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 12:04=E2=80=AFPM Michael Montalbo <mmontalbo@gmail.=
com> wrote:
>
> One mechanical signal is how tightly a set of files shares the same
> internal headers: if two .c files include many of the same project
> headers (dropping the plumbing everything includes), they lean on the
> same machinery. Averaged over every pair in the group, that gives one
> cohesion number.
>

I spent some time trying to think about a stronger approach. I think the
following script[2] is a more promising approach to criticize:

- Read the Makefile. Collect the C files that it compiles into the git
  library. The count is 231.
- Read every non-merge commit in the history, up to HEAD. For each
  one, take its area name (the subject prefix, such as "diff:" or
  "refs:") and the library files it changed.
- Give each commit a weight of one divided by the number of library
  files it changed. A commit that changed two files counts more than a
  commit that changed forty.
- For each file, take the area name with the largest total weight. If
  that weight is small, the file has no area name.
- Read a 14-line table that groups area names into directories. Put
  each file into the directory for its area name, or, if it has none,
  the directory for its filename. A file that matches no directory
  stays ungrouped.
- Build a call graph with cscope, a cross-reference database that
  records which file uses functions defined in another file[1]. This is
  based on the code, not on file or commit names, so it is a second
  check independent of the first.
- Print each directory with its files, then the ungrouped files. Last,
  compare the call groups with the directories and show the groups
  that fall across more than one directory. Those mark the boundary
  files to check.

The 14-entry table that maps area names to directories is the
CHARTER block in the script below. Its output:

git library source files by directory  (HEAD c0c95f3229; 231 files)

odb/   21 files  (21 by commit label)
   blob commit fsck hash loose match-trees object object-file
   object-file-convert object-name odb oid-array oidmap oidset oidtree
   replace-object sha1dc_git tag tmp-objdir tree tree-walk

refs/   8 files  (7 by commit label)
   ls-refs pack-refs ref-filter reflog reflog-walk refs refspec
   worktree

pack/   27 files  (18 by commit label)
   bloom chunk-format commit-graph delta-islands diff-delta midx
   midx-write pack-bitmap pack-bitmap-write pack-check pack-mtimes
   pack-objects pack-revindex pack-write packfile packfile-list
   patch-delta prune-packed pseudo-merge reachable repack repack-cruft
   repack-filtered repack-geometry repack-midx repack-promisor
   server-info

diff/   16 files  (14 by commit label)
   combine-diff diff diff-lib diff-merges diff-no-index diffcore-break
   diffcore-delta diffcore-order diffcore-pickaxe diffcore-rename
   diffcore-rotate patch-ids range-diff tree-diff userdiff
   xdiff-interface

merge/   7 files  (7 by commit label)
   fmt-merge-msg merge merge-blobs merge-ll merge-ort
   merge-ort-wrappers rerere

revision/   14 files  (12 by commit label)
   bisect blame commit-reach decorate graph line-log line-range
   list-objects list-objects-filter list-objects-filter-options
   log-tree pretty revision shallow

index/   19 files  (18 by commit label)
   cache-tree checkout dir entry fsmonitor fsmonitor-ipc
   fsmonitor-settings name-hash parallel-checkout pathspec
   preload-index read-cache resolve-undo sparse-index split-index
   statinfo symlinks unpack-trees wt-status

setup/   9 files  (9 by commit label)
   alias config environment hook ident repo-settings repository setup
   version

convert/   3 files  (3 by commit label)
   attr convert ws

transport/   19 files  (17 by commit label)
   bundle bundle-uri connect connected fetch-negotiator
   fetch-object-info fetch-pack pkt-line promisor-remote protocol
   protocol-caps remote send-pack serve sideband transport
   transport-helper upload-pack walker

notes/   4 files  (3 by commit label)
   notes notes-cache notes-merge notes-utils

submodule/   2 files  (2 by commit label)
   submodule submodule-config

archive/   3 files  (3 by commit label)
   archive archive-tar archive-zip

sequencer/   11 files  (11 by commit label)
   add-interactive add-patch apply branch mailinfo mailmap rebase
   rebase-interactive replay reset sequencer

placed 163 files in 14 directories: 145 by commit label,
12 by filename, 6 by override. The table is 14 lines.

68 files match no subsystem and are left ungrouped:
   abspath advice alloc base85 cbtree chdir-notify color column
   common-exit common-init copy credential csum-file ctype date
   diagnose dir-iterator editor exec-cmd gettext git-zlib
   gpg-interface grep hash-lookup hashmap help hex hex-ll json-writer
   kwset levenshtein linear-assignment lockfile mem-pool pager parse
   parse-options parse-options-cb path path-walk prio-queue progress
   prompt quote run-command sigchain stable-qsort strbuf string-list
   strmap strvec sub-process tempfile thread-utils trace trace2
   trailer unix-socket unix-stream-server url urlmatch usage utf8
   varint versioncmp wildmatch wrapper write-or-die

[1] Detail: the call-graph check and the label-vs-filename comparison:

Second check. The call graph records which file uses functions from
another file, so it does not use names. Group the files that call each
other, then compare each group with the directories above. 57 files
fall into 12 call groups. The 12 sort into three kinds:
  5 groups: all placed files land in one directory (call graph agrees).
  6 groups: most files in one directory, plus one or two
     from another (the boundary cases to check).
  1 group: shared helpers that many files call (not shown).

Boundary groups, largest directory first. Each line is one
directory and its files in the group. Example: shallow is in
revision, but the call graph groups it with the transport files.

  transport (5): connect fetch-pack pkt-line send-pack upload-pack
  revision (1): shallow

  transport (3): remote transport transport-helper
  refs (1): refspec

  odb (2): hash object-file
  pack (1): pack-write

  pack (2): chunk-format commit-graph
  revision (2): commit-reach revision
  odb (1): commit

  sequencer (2): add-interactive add-patch
  index (1): wt-status

  setup (2): config setup
  refs (1): worktree

Commit label vs filename: both point to the same directory for 151 files
and disagree for 0 (the 8 overrides are separate). The commit
label and the filename follow the same naming rule, so the label
confirms the naming, not the grouping. Only the call graph is an
independent check.

[2] The script:

#!/usr/bin/env python3
"""subsystems.py: group git's libgit.a source files into directories.

Steps:
  membership : the Makefile lists the library source files (LIB_OBJS).
  label      : each file's directory is the area name used most often
               in its commit messages, weighted toward small commits.
  table      : 14 lines say which area names share a directory.
  check      : the call graph is a second, independent signal; it
               lists the files where the two signals disagree.

Run from a git.git checkout (uses HEAD).
"""
import re
import os
import shutil
import tempfile
import subprocess
import math
import textwrap
from collections import defaultdict, Counter

TOP =3D subprocess.check_output(
    ["git", "rev-parse", "--show-toplevel"], text=3DTrue).strip()
HEAD =3D subprocess.check_output(
    ["git", "-C", TOP, "rev-parse", "--short", "HEAD"],
    text=3DTrue).strip()


def git(*a):
    return subprocess.run(["git", "-C", TOP, *a],
                          capture_output=3DTrue, text=3DTrue).stdout


# membership: exactly what libgit.a archives (authoritative)
LIB =3D set()
for line in open(TOP + "/Makefile"):
    m =3D re.match(r"LIB_OBJS \+=3D ([\w-]+)\.o$", line.strip())
    if m and "/" not in m.group(1):
        LIB.add(m.group(1) + ".c")

# charter: the only hand input, which fine areas share a directory
CHARTER =3D {
    "odb": "object odb oid oidmap oidset oidtree loose blob tag "
           "commit tree replace match tmp fsck hash sha1dc",
    "refs": "refs refspec reflog ref ls worktree",
    "pack": "pack packfile midx delta prune reachable server bloom "
            "chunk pseudo repack",
    "diff": "diff diffcore combine range userdiff xdiff patch pickaxe",
    "merge": "merge rerere fmt",
    "revision": "revision log bisect shallow blame line graph "
                "decorate list pretty",
    "index": "read cache split sparse unpack name preload resolve "
             "statinfo entry parallel dir pathspec checkout symlinks "
             "fsmonitor wt",
    "setup": "config setup environment repository repo ident alias "
             "version hook",
    "convert": "attr convert ws whitespace",
    "transport": "transport remote connect connected send fetch "
                 "upload walker http protocol serve pkt sideband "
                 "bundle promisor",
    "notes": "notes", "submodule": "submodule", "archive": "archive",
    "sequencer": "sequencer rebase replay apply add reset branch "
                 "mailinfo mailmap",
}
OWNER =3D {t: s for s, toks in CHARTER.items() for t in toks.split()}
# per-file exceptions where the name or label points at the wrong dir
OVERRIDE =3D {"pack-refs.c": "refs", "commit-graph.c": "pack",
            "commit-reach.c": "revision", "tree-diff.c": "diff",
            "diff-delta.c": "pack", "patch-delta.c": "pack",
            "dir-iterator.c": "lib", "hash-lookup.c": "lib"}


def to_dir(token):
    return OWNER.get(token)


# signal A: focus-weighted modal commit "area:" label
# No noise list. A sweep label such as treewide or global appears only
# on commits that change many files. Small commit weight keeps those
# commits low, so a sweep label is never a file's top label; 0 seen.
PRE =3D re.compile(r"^([A-Za-z0-9][\w./-]*):")


def norm(p):
    p =3D p.lower()
    return p[:-2] if p.endswith((".c", ".h")) else p


# One pass over the log. A commit touching k libgit.a files adds 1/k to
# each file's tally for that commit's area label, so a 2-file commit is
# stronger evidence than a 40-file sweep. (History before a rename is
# under the old name; a --follow pass is a known refinement.)
commits =3D []
lab, files =3D None, []
log =3D git("log", "--no-merges", "--name-only", "--format=3D%x00%s")
for line in log.split("\n"):
    if line.startswith("\x00"):
        if lab and files:
            commits.append((lab, files))
        m =3D PRE.match(line[1:])
        lab =3D norm(m.group(1)) if m else None
        files =3D []
    elif line.endswith(".c") and "/" not in line and line in LIB:
        files.append(line)
if lab and files:
    commits.append((lab, files))

wt =3D defaultdict(lambda: defaultdict(float))
for lab, files in commits:
    w =3D 1.0 / len(files)
    for f in set(files):
        wt[f][lab] +=3D w


def modal(f):
    """The top focus-weighted label, or None if history is thin."""
    c =3D wt.get(f)
    if not c:
        return None
    l, w =3D max(c.items(), key=3Dlambda kv: (kv[1], kv[0]))  # tie: name
    tot =3D sum(c.values())
    if tot < 2.0 or w / tot < 0.34:   # <2 commits, or under 34%
        return None
    return l


def place(f):
    """(dir, how) for a file, or (None, ...) if it joins no subsystem.
    Precedence: override, commit label, filename."""
    if f in OVERRIDE:
        d =3D OVERRIDE[f]
        return (None if d =3D=3D "lib" else d), "override"
    lab =3D modal(f)
    if lab:
        d =3D to_dir(lab.split("/")[0].split("-")[0])
        if d:
            return d, "label"
    d =3D to_dir(f[:-2].split("-")[0])     # fallback: filename token
    if d:
        return d, "name"
    return None, "ungrouped"


# signal B: the call graph. cscope, a cross-reference database, gives
# the call edges, so calls in comments, strings, and macros are not
# counted. The coding style gives the definitions: a column-0 line that
# names a function defines it; it is exported if it lacks "static".
CTRL =3D {"if", "for", "while", "switch", "return", "sizeof", "do",
        "else", "case", "typedef", "struct", "union", "enum", "extern",
        "static"}
text =3D {f: open(TOP + "/" + f, encoding=3D"utf-8",
                errors=3D"replace").read() for f in LIB}


def scan_defs(t):
    """(exported, all) function names a file defines at column 0."""
    exported, everything =3D set(), set()
    for ln in t.split("\n"):
        if not ln or ln[0] in " \t#}/*{)":
            continue
        if ("(" not in ln or ln.rstrip().endswith(";")
                or "=3D" in ln.split("(")[0]):
            continue
        m =3D re.match(r"^(static\b)?.*?([A-Za-z_]\w*)\s*\(", ln)
        if not m or m.group(2) in CTRL:
            continue
        everything.add(m.group(2))
        if not m.group(1):
            exported.add(m.group(2))
    return exported, everything


owner_fn, dup, allnames =3D {}, set(), set()
for f in LIB:
    exported, everything =3D scan_defs(text[f])
    allnames |=3D everything
    for name in exported:
        if name in owner_fn:
            dup.add(name)
        owner_fn[name] =3D f
for name in dup:
    owner_fn.pop(name, None)


def cscope_calls():
    """calls[a][b] =3D call sites in root .c file a that call a non-static
    function defined in root .c file b, using cscope. cscope type 2
    lists, per queried function, the functions it calls, one line per
    call site as 'caller_file callee_name line text'. The caller file
    and callee name are on each line, so no bookkeeping is needed."""
    if not shutil.which("cscope"):
        raise SystemExit("cscope not found on PATH; run under "
                         "'nix-shell -p cscope'.")
    tmp =3D tempfile.mkdtemp(prefix=3D"subsys-cs-")
    try:
        flist =3D os.path.join(tmp, "files")
        out =3D os.path.join(tmp, "cscope.out")
        with open(flist, "w") as fh:
            fh.write("\n".join(sorted(LIB)) + "\n")
        subprocess.run(
            ["cscope", "-b", "-q", "-k", "-i", flist, "-f", out],
            cwd=3DTOP, check=3DTrue, stdout=3Dsubprocess.DEVNULL,
            stderr=3Dsubprocess.DEVNULL)
        query =3D "".join(f"2{n}\n" for n in sorted(allnames))
        res =3D subprocess.run(
            ["cscope", "-d", "-l", "-f", out], cwd=3DTOP, input=3Dquery,
            capture_output=3DTrue, text=3DTrue).stdout
    finally:
        shutil.rmtree(tmp, ignore_errors=3DTrue)
    calls =3D defaultdict(lambda: defaultdict(int))
    for line in res.split("\n"):
        if not line or line.startswith(">>"):   # blank or prompt line
            continue
        parts =3D line.split(" ", 3)   # caller_file callee line text
        if len(parts) < 4 or not parts[2].isdigit():
            continue   # marker or malformed line
        caller, callee =3D parts[0], parts[1]
        cf =3D owner_fn.get(callee)
        if caller in LIB and cf and cf !=3D caller:
            calls[caller][cf] +=3D 1
    return calls


calls =3D cscope_calls()
fanin =3D defaultdict(set)
for a in calls:
    for b in calls[a]:
        fanin[b].add(a)
N =3D len(LIB)
idf =3D {b: math.log(N / len(s)) for b, s in fanin.items()}
aff =3D defaultdict(dict)
for a in calls:
    for b in calls[a]:
        w =3D (calls[a].get(b, 0) * idf.get(b, 0)
             + calls.get(b, {}).get(a, 0) * idf.get(a, 0))
        if w > 0:
            aff[a][b] =3D aff[b][a] =3D w
idx =3D {f: i for i, f in enumerate(sorted(LIB))}
mem =3D {i: [f] for f, i in idx.items()}
size =3D {i: 1 for i in mem}
link =3D defaultdict(dict)
for a in aff:
    for b, w in aff[a].items():
        if idx[a] < idx[b]:
            link[idx[a]][idx[b]] =3D link[idx[b]][idx[a]] =3D w
act, nid =3D set(mem), len(LIB)
while True:
    best, bv =3D None, 15.0
    for i in act:
        for j, w in link[i].items():
            if i < j and w / (size[i] * size[j]) >=3D bv:
                bv, best =3D w / (size[i] * size[j]), (i, j)
    if not best:
        break
    i, j =3D best
    c =3D nid
    nid +=3D 1
    mem[c], size[c] =3D mem[i] + mem[j], size[i] + size[j]
    for x in (set(link[i]) | set(link[j])) - {i, j}:
        link[c][x] =3D link[x][c] =3D link[i].get(x, 0) + link[j].get(x, 0)
    for x in list(link[i]):
        link[x].pop(i, None)
    for x in list(link[j]):
        link[x].pop(j, None)
    link.pop(i, None)
    link.pop(j, None)
    act.discard(i)
    act.discard(j)
    act.add(c)
clusters =3D [mem[c] for c in act if size[c] >=3D 3]

# report
pl =3D {f: place(f) for f in sorted(LIB)}
by_dir =3D defaultdict(list)
for f, (d, _how) in pl.items():
    by_dir[d].append(f)


def wrapped(names):
    return textwrap.wrap(" ".join(sorted(n[:-2] for n in names)), 70,
                         initial_indent=3D"   ", subsequent_indent=3D"   ",
                         break_long_words=3DFalse, break_on_hyphens=3DFalse=
)


mod =3D git("status", "--porcelain", "--",
          "*.c", "*.h", "Makefile").strip()
dirty =3D " plus local changes" if mod else ""
print(f"git library source files by directory  "
      f"(HEAD {HEAD}{dirty}; {len(LIB)} files)\n")
for d in list(CHARTER):
    fs =3D by_dir.get(d, [])
    if not fs:
        continue
    lab_n =3D sum(1 for f in fs if pl[f][1] =3D=3D "label")
    print(f"{d}/   {len(fs)} files  ({lab_n} by commit label)")
    for w in wrapped(fs):
        print(w)
    print()

ung =3D by_dir.get(None, [])
placed =3D len(LIB) - len(ung)
how =3D Counter(pl[f][1] for f in LIB if pl[f][0] is not None)
print(f"placed {placed} files in {len(CHARTER)} directories: "
      f"{how['label']} by commit label,\n{how['name']} by filename, "
      f"{how['override']} by override. The table is 14 lines.")
print(f"\n{len(ung)} files match no subsystem and are left ungrouped:")
for w in wrapped(ung):
    print(w)

# Second check with the call graph. It records which file uses
# functions from which other file, so it does not use names and is
# independent of the labels. Group files that call each other, then
# compare each group with the directories. Leave ungrouped helpers out.
agree =3D loose =3D 0
boundary =3D []
for c in clusters:
    by =3D defaultdict(list)
    for f in c:
        if pl[f][0]:
            by[pl[f][0]].append(f[:-2])
    dirs =3D sorted(by, key=3Dlambda d: (-len(by[d]), d))
    if len(dirs) <=3D 1:
        agree +=3D 1
    elif len(by[dirs[0]]) >=3D 2:
        boundary.append((dirs, by))
    else:
        loose +=3D 1
boundary.sort(key=3Dlambda x: (-len(x[1][x[0][0]]), x[0][0]))
covered =3D sum(len(c) for c in clusters)


def plural(n):
    return "group" if n =3D=3D 1 else "groups"


print("\nSecond check. The call graph records which file uses "
      "functions from")
print("another file, so it does not use names. Group the files that "
      "call each")
print(f"other, then compare each group with the directories above. "
      f"{covered} files\nfall into {len(clusters)} call groups. The "
      f"{len(clusters)} sort into three kinds:")
print(f"  {agree} {plural(agree)}: all placed files land in one "
      "directory (call graph agrees).")
print(f"  {len(boundary)} {plural(len(boundary))}: most files in one "
      "directory, plus one or two\n     from another (the boundary "
      "cases to check).")
print(f"  {loose} {plural(loose)}: shared helpers that many files call "
      "(not shown).")
if boundary:
    print("\nBoundary groups, largest directory first. Each line "
          "is one")
    print("directory and its files in the group. Example: shallow "
          "is in")
    print("revision, but the call graph groups it with the transport "
          "files.")
    for dirs, by in boundary:
        print()
        for d in dirs:
            label =3D f"  {d} ({len(by[d])}): "
            for w in textwrap.wrap(" ".join(sorted(by[d])), 70,
                                   initial_indent=3Dlabel,
                                   subsequent_indent=3D" " * len(label),
                                   break_long_words=3DFalse,
                                   break_on_hyphens=3DFalse):
                print(w)

# Label vs filename: the honest circularity check.
same, diff =3D 0, []
for f in sorted(LIB):
    lab =3D modal(f)
    if not lab:
        continue
    dl =3D to_dir(lab.split("/")[0].split("-")[0])
    dn =3D to_dir(f[:-2].split("-")[0])
    if dl and dn:
        if dl =3D=3D dn:
            same +=3D 1
        elif f not in OVERRIDE:
            diff.append((f, dl, dn, lab))
print(f"\nCommit label vs filename: both point to the same directory "
      f"for {same} files\nand disagree for {len(diff)} (the "
      f"{len(OVERRIDE)} overrides are separate). The commit\nlabel and "
      "the filename follow the same naming rule, so the "
      "label\nconfirms the naming, not the grouping. Only the call "
      "graph is an\nindependent check.")
for f, dl, dn, lab in diff:
    print(f"  {f[:-2]:20} label->{dl:10} name->{dn:10} ('{lab}:')")
