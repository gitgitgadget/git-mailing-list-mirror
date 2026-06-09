Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DB923BCF7
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 02:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780972645; cv=none; b=YcnHieCH/dSgMMNQODHlfQ+nbCwaC7O3oeHEXfFiyopHLkZ2i8mEg5At07GLlwMlWiYpJL5zM9/io8QSG4ezHCX0VLaCKOR55OuRaOVJ0094Qz1P7/kk9skpWyN6jtEWsbDfLT2pn0UZJNt/cJDpyLTXp/CrWdFuKNAILuj/7sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780972645; c=relaxed/simple;
	bh=/OwglieMgxTozS7yhxJdhB6/SoRLsyaRL45jmkWJVP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XFwKjnFis3HM54cNgkXokPVk0M7RZx3Sgr81cTSYvilSmtkbaKZ3UeXkiw2X+Lt+ZUSShtcuOHbgUFmNOumTtdMw8foWAbR38hlwy13i/Ret+vv9+j1Yyw+gcvpfekm7ON9Vqp8XiV/UbU8S/ysIShh22K1DoxYlfpzDjA165H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFAqa3Bk; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFAqa3Bk"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51784eb2ba0so38033531cf.2
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 19:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780972643; x=1781577443; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iv7jCkqGTyaTLDCh8e1ahEGawV7GTJpyd49v5UlIhYM=;
        b=mFAqa3BkmEPMjY3O4RrCOSVCcKNTXSrXh7YK8slY8wOV7H+06/WJwR1tsQD8PZb34+
         7uYsgO9ffWlw3pEy7u+GD/FUK3ruUb8ZtSwSgAtl5GKTbQcf6EK9+0T6zc2mKz5NTVWP
         CHTE3SWebZelYUPHS3VS91Q0fJkMeTGsAhQ6EGpD/1FLIVWEWKwQisIta93b0xa5jOTh
         OeZ8mM5BPf7thOKdmaVAvtJfHA0tm10r+PLN8QDfJtOKwXePF4x5eoSfoZkRPvMNeeiC
         DGZcy8Qzk+pOQVoqal1DWkNtDEQZLhV5Eg/BzMG2BbMhSAv86+0CPtYjABjH6XfJRSzO
         8v4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780972643; x=1781577443;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iv7jCkqGTyaTLDCh8e1ahEGawV7GTJpyd49v5UlIhYM=;
        b=aJtaFP5k+xE+5dmQiPJf+9WEJf1W7iABEtGVqW0EQUwFqdVNWr3z5GiUx8pewZFjU9
         4ph1PEVy4svAlECCGocRFkxFhYMkYIs5Gvg/NKt/T41Wsk1Qm34fKK/v5bycs8r2j3O3
         KtnnldD3jNA8rvP5sNBDgaQqkAx8mJc0wz+6P7apb0u5MaavJGx2lMV70JrFwguoEJ1W
         /dSp43nhtK/ZbnLrYdqkiFdNa/5PecABqUWNdrOehc9zHAbcGJ80dw/71guJ3eTJln47
         wBR3P5j4a3jr2K5v3mW03wip7nR96Yncd2PMjNKnKlZ1o+B6noWn2pDU2io9LRkACUje
         sozQ==
X-Gm-Message-State: AOJu0YxBxZX9x8MWg0p/dK4TA95Gh4JIv3K+QN6CZWhhh4dA+ozZf48u
	6KruIdmgGT/miz+j64RrWVMEgeyc1Tyy9urQ4R8huUPbOqGlI5Cixm7yNLqcAonn
X-Gm-Gg: Acq92OFoZ+Z0Fajn5tU6t+P3OOh0TAInN6iXtWKhSo4W8P/5gizt/+EFXqN9R2CKh+l
	vMgsDJOtlj92rqjku73jNsC5BKflcvgdBQWBvlKvKPdxMiy8zR1QJW1qC2n8rp9XBmOeAtChWj8
	FywJf0MJxs4orbWWrY4opQRHKLrE1oImvBCCbWhoDCOj1VZEHO+Llfia0gfbKvSyP+Q1X9EcO9B
	efWFA7SflLTowzT5zxdSX8hnlOKwp+0kDVKgzWmI7c5x/wpjgufUx+F9KoEfyobkXuateFKk1at
	o1elY+BtZIZpqP6E+atgP67bI4e7QOsRxPvbkkY1p9+YAeQiKW/kEDbuHKpXYTZtpqUcHF14puR
	tAgM+30Q3kF7KPuLrYiAmg5LVOayUsXUVgCawLeDS9tJLJ6YM5h2y+YDFmrySEa/CjCgxOrEdnx
	fCLHX+asjreVN17ATXA/R4RQN59Q9C9xj03DcNUf/YOd7F0nYQ+JoLqN8o7jOLnr/tP1xP9m7se
	bacDw9tOH0uhXaqRkvGK9ORxiZE9tljbZ3JYKaex3J0SujBQ0QuSeQn6vx0+HG5zlZ20HhX/p/m
	4SdIL4wHi4Fc+QzzZ5gIH4XKzbWUR8WZgBx8IaEHujXtfnQb2/bWLcgwUBiv
X-Received: by 2002:ac8:7f01:0:b0:517:82a1:351f with SMTP id d75a77b69052e-51795ad2ae6mr261214611cf.16.1780972642817;
        Mon, 08 Jun 2026 19:37:22 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([209.249.37.132])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775c4d7absm169108881cf.11.2026.06.08.19.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 19:37:22 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 08 Jun 2026 19:37:15 -0700
Subject: [PATCH v2] ls-files: filter pathspec before lstat
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-ls-files-pathspec-lstat-v2-1-fb734b28422e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ6CMBBFr0K6dkxbSyGuvIdhUcoAY0BIpxIN4
 e4WPIDL9/P/f6tgDIQsrtkqAi7END0T6FMmfO+eHQI1iYWW2korCxgYWhqQYXax5xl9SqKLUJa
 50rnLG2uMSOs5YEvv4/le/Zhf9QN93O/2Rk8cp/A51Ivae/8tiwIFpW+NrIuLVMbeutHRcPbTK
 Kpt277sJjxD0AAAAA==
X-Change-ID: 20260607-ls-files-pathspec-lstat-885125a5d644
To: git@vger.kernel.org
Cc: =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
 Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1780972641; l=7961;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=/OwglieMgxTozS7yhxJdhB6/SoRLsyaRL45jmkWJVP4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLeb/RIDoMlQtAczctRzBvzTPUhjr8OYnKC2lHQil3NS4DXoW+Y/4dHQnSZgK5Cv8aEmmOQew3b
 C4cFtBBM7EQI=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

show_files() checks whether each index entry is deleted or modified
before show_ce() applies the pathspec. prune_index() avoids most of this
work for pathspecs with a common directory prefix, but a top-level name
or leading wildcard leaves every entry to be checked.

For a single pathspec, match it before lstat() in the deleted and
modified modes. Keep the later match in show_ce() so --error-unmatch is
satisfied only by entries that are actually shown.

match_pathspec() is linear in the number of pathspec items. Applying it
early for every item can therefore multiply the work for commands with
many pathspecs, especially when lstat() shows that no entries are
modified. Restrict the early check to one pathspec. Callers with
multiple pathspecs retain the existing lstat()-first order.

On a repository with 859,211 index entries, a 19,931,862-byte index,
and 25,303,439 packed objects occupying 21.13 GiB, I exported $parent
and $this to binaries built from the parent and this commit, then ran:

    hyperfine --warmup 0 --runs 3 \
        --command-name parent \
        '$parent -c core.fsmonitor=false ls-files --deleted -- README.md' \
        --command-name 'this commit' \
        '$this -c core.fsmonitor=false ls-files --deleted -- README.md'

The results were:

             parent       this commit
  elapsed    60.742 s     1.061 s
  user        1.117 s     0.963 s
  system     10.740 s     0.042 s

For an all-matching pathspec, I used a checkout with 859,940 index
entries and ran:

    hyperfine --warmup 0 --runs 3 \
        --command-name parent \
        '$parent -c core.fsmonitor=false ls-files --deleted -- "*"' \
        --command-name 'this commit' \
        '$this -c core.fsmonitor=false ls-files --deleted -- "*"'

I repeated the benchmark with the commands reversed. The results were:

                         parent          this commit
  parent first elapsed    56.807 s        64.618 s
               user        1.256 s         1.270 s
               system     10.633 s        11.068 s
  patched first elapsed   63.361 s        64.316 s
                user       1.238 s         1.280 s
                system    10.296 s        11.864 s

The patched user-time means were 14 ms and 42 ms higher in the two
orderings. Elapsed time changed by several seconds when the order was
reversed, so those results do not show a stable wall-time ordering.

Jeff King pointed out that a preliminary match for each of many literal
pathspecs can be much more expensive. On a generated repository with
10,000 clean files, I recorded the paths with "git ls-files >paths".
With $v1 exported to a binary built from the implementation sent in v1,
I ran:

    hyperfine --warmup 2 --runs 10 \
        --command-name parent \
        '$parent ls-files -m -- $(cat paths) >/dev/null' \
        --command-name 'this commit' \
        '$this ls-files -m -- $(cat paths) >/dev/null'

I replaced $this with $v1 in a second invocation. The wall-clock means
and standard deviations were:

                         mean          standard deviation
  parent, final run     110.1 ms              4.1 ms
  this commit           104.9 ms              2.2 ms
  parent, v1 run        112.5 ms              6.6 ms
  unguarded v1          494.1 ms             17.2 ms

The guarded result matches the parent within the observed variation,
while avoiding the regression in v1.

All three revisions were built with -O3, -mcpu=native, and ThinLTO
using Apple clang 21.0.0 on macOS 26.5. The machine was a MacBook Pro
(Mac16,6) with a 16-core Apple M4 Max (12 performance and four
efficiency cores) and 128 GB RAM.

Link: https://lore.kernel.org/r/20260607-ls-files-pathspec-lstat-v1-1-8cf40b730146@gmail.com
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
A selective pathspec should let ls-files --deleted and --modified avoid
statting entries that cannot be shown. Match a single pathspec before
accessing the worktree, while preserving the existing lstat-first order
for multiple pathspecs whose matching cost grows linearly.
---
Changes in v2:
- Restrict early matching to one pathspec, avoiding the regression Jeff
  demonstrated with many pathspecs.
- Add all-matching and many-pathspec performance results.
- Drop the Assisted-by trailer.
- Link to v1: https://patch.msgid.link/20260607-ls-files-pathspec-lstat-v1-1-8cf40b730146@gmail.com
---
 builtin/ls-files.c                  | 11 +++++++++++
 t/meson.build                       |  1 +
 t/perf/p3010-ls-files.sh            | 31 +++++++++++++++++++++++++++++++
 t/t3010-ls-files-killed-modified.sh | 18 ++++++++++++++++++
 4 files changed, 61 insertions(+)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index e1a22b41b9..8d7158652b 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -450,6 +450,17 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 			continue;
 		if (ce_skip_worktree(ce))
 			continue;
+		/*
+		 * match_pathspec() is linear in pathspec.nr, so prefilter only
+		 * the single-pathspec case. Only entries shown by show_ce()
+		 * satisfy --error-unmatch.
+		 */
+		if (pathspec.nr == 1 &&
+		    !match_pathspec(repo->index, &pathspec, fullname.buf,
+				    fullname.len, max_prefix_len, NULL,
+				    S_ISDIR(ce->ce_mode) ||
+				    S_ISGITLINK(ce->ce_mode)))
+			continue;
 		stat_err = lstat(fullname.buf, &st);
 		if (stat_err && (errno != ENOENT && errno != ENOTDIR))
 			error_errno("cannot lstat '%s'", fullname.buf);
diff --git a/t/meson.build b/t/meson.build
index 2af8d01279..ee8086e6ef 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -1140,6 +1140,7 @@ benchmarks = [
   'perf/p1500-graph-walks.sh',
   'perf/p1501-rev-parse-oneline.sh',
   'perf/p2000-sparse-operations.sh',
+  'perf/p3010-ls-files.sh',
   'perf/p3400-rebase.sh',
   'perf/p3404-rebase-interactive.sh',
   'perf/p4000-diff-algorithms.sh',
diff --git a/t/perf/p3010-ls-files.sh b/t/perf/p3010-ls-files.sh
new file mode 100755
index 0000000000..ae14449432
--- /dev/null
+++ b/t/perf/p3010-ls-files.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+
+test_description='Tests ls-files worktree performance'
+
+. ./perf-lib.sh
+
+test_perf_large_repo
+test_checkout_worktree
+
+test_expect_success 'select a zero-prefix pathspec' '
+	tracked_file=$(git ls-files | sed -n 1p) &&
+	test -n "$tracked_file" &&
+	pathspec="?${tracked_file#?}" &&
+	test_export pathspec
+'
+
+test_perf 'ls-files --deleted with pathspec' '
+	git -c core.fsmonitor=false ls-files --deleted \
+		-- "$pathspec" >/dev/null
+'
+
+test_perf 'ls-files --deleted with all-matching pathspec' '
+	git -c core.fsmonitor=false ls-files --deleted -- "*" >/dev/null
+'
+
+test_perf 'ls-files --modified with pathspec' '
+	git -c core.fsmonitor=false ls-files --modified \
+		-- "$pathspec" >/dev/null
+'
+
+test_done
diff --git a/t/t3010-ls-files-killed-modified.sh b/t/t3010-ls-files-killed-modified.sh
index 7af4532cd1..6e38e10219 100755
--- a/t/t3010-ls-files-killed-modified.sh
+++ b/t/t3010-ls-files-killed-modified.sh
@@ -124,4 +124,22 @@ test_expect_success 'validate git ls-files -m output.' '
 	test_cmp .expected .output
 '
 
+test_expect_success 'worktree modes honor wildcard pathspecs' '
+	cat >.expected <<-\EOF &&
+	path2/file2
+	path3/file3
+	EOF
+	git ls-files --deleted -- "path?/file?" >.output &&
+	test_cmp .expected .output &&
+
+	cat >.expected <<-\EOF &&
+	path7
+	path8
+	EOF
+	git ls-files --modified --error-unmatch -- "path[78]" >.output &&
+	test_cmp .expected .output &&
+
+	test_must_fail git ls-files --modified --error-unmatch -- path10
+'
+
 test_done

---
base-commit: 9ac3f193c05c2237e2b14ebaa1149e9fc8a1abe0
change-id: 20260607-ls-files-pathspec-lstat-885125a5d644

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>

