Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E573B27F9
	for <git@vger.kernel.org>; Tue, 26 May 2026 08:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779782597; cv=none; b=qDpisnNc7q3V6ny+TT2DsdhWJ95Gv75/kNRyq/whP+GcrpuLUL/G+bluABFi+cL0E9EPfDa1YlU2duM3inhqye0eQtv/5x4ihXlULcRGFEGX9PcFcIQRuv+rYFlUTr9n2v0J3+wnr4kG+BOI0RUtwQf379IDkWe8Or9yclMu3pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779782597; c=relaxed/simple;
	bh=4JzzA/xEhKi8p5wbD77j+xn/4Emp71U3+371OjM43fY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PAM7SmxZe1VB1DS+wytwsreABMjt7w0NVdc51YzrYqmk/gjmsiekvjC3UB6Ab+gKp7UGouDXD/gemaPfPRLNGL8j9fEz7kmk4LQhBxj4MX3QrjFg8ilA7tyu5RoqfHUhBivCegLHHPtNWJEYhyVV1TZuxiZ//A8AGjEBp92lW/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKpizCMS; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKpizCMS"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50e97863425so111731131cf.0
        for <git@vger.kernel.org>; Tue, 26 May 2026 01:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779782595; x=1780387395; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+h1SegBBhacBwpylvcrSzEtDvC0Gcup+KHgZjwjLbp0=;
        b=NKpizCMSwtpcT+Ubf4DyJ45Q13ZaB8NBohbxGIQ2ESb219sgdvYWivNp8jitP+QHwn
         futRV+8nNcWBAVKHiAx16kusYHEsX/xwgmDzOWctX4I19DmxsIyKiSV6gW088yJr4oDp
         e9xGzvN/wydO4frAaDgBwgI5OjZzBKoR3rKXVUVU4eC2iiytf/9fyHMVAWzON66dIEfK
         RneZko1+btHV58kLKhp2XCH2YivfHrE5UmxvxYWsbVtquLVFqRyc9c+ciZhibiGjWjra
         9BN1eh9jRsf0YuB0hxI+LevnoWFsg0pTqoK8CgRiNfAR9bUGnhRzLNfPyn5VASSWaOOg
         zpGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779782595; x=1780387395;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+h1SegBBhacBwpylvcrSzEtDvC0Gcup+KHgZjwjLbp0=;
        b=kaTPVqOtownGDsedv4ynxIvRd/Qzz7IvqEspnt3UZTeXL7f32UkWWbapH/9mI1L7Ft
         J1/gNbFzTmOKHLhFoBmOkDw3QYSCkHzYGzLMqZjXnv1xZH+G+LMUVYIaNDZVGZ0X56ZU
         t/YOo7je472d65tfmA2i1+Dq9nTVRB1E57ghARFWw2M/Vgyy1Ds+L5GNH5EM5dtVvCYv
         codw5y/mC1VtfFSdJfwgoNMlEHYKAQuTC7C9cqpq5wL1XiCoFv60maqs0jVjDTAe5GWy
         N9ASSFrtl7PrbWfGfbbjY6XxPtbOd4oKfEleQ2hAcP1K8MALjkox7d5YlWhV6hW3feC6
         p8dg==
X-Gm-Message-State: AOJu0YyUDg3k1TN1fL8a0lccT99Sz4oD3oy6QlY8XWjKx4Gr7Q7/8NJt
	vvlZdS0PahzEloRFoKt+1GEWonyfOVcVXkcrsJabw+A+pavHTZJQj1v5ktPnV9c2
X-Gm-Gg: Acq92OEDRaImKBoN3uGwzOVM5ulTl2J5d4IPeOqirLt3uVoxf1456DG7TNat7v2xcYV
	2dni7a0ztahyLeLh75EXuQEKPpsfRSrQdG90oYgGSgWyAGVwS4YY+PgnSto/iGS0Zcy+Sn/EROs
	5NVX8DCTbZCnpooXlAzk1IYOmxpXdi+W3+fWBTEUgq3Wq0KdzZTQvjP5q3VaDaJyogTii87LM/F
	CjoVILzfxZNA9GDHp6JhvqB25D9FRqva03tJOUjXxRcS9NrTSGKyeCGbLOpwDTxqHeyt6coakSk
	8v7BWQ0hskK+LqmxrXiOpw+0bBxJP08ksFf8G9ADhiPaTeWxBspdgG3GzDkRk1E6rczYhtIxQkj
	UZdBlWxu+AZMPEFtLwSXVCqWpkyJqOHESlu9wb5GXZ3Ekix9WDoS6LJlcQuFKvhMNiWmQU+Ssnw
	l58UJV7Pt3mCWDVcS5RtT3BAQn1RQ=
X-Received: by 2002:a05:622a:182a:b0:516:df73:d67a with SMTP id d75a77b69052e-516df73d6admr181134401cf.33.1779782594689;
        Tue, 26 May 2026 01:03:14 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.122.145])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517069f2464sm12271951cf.2.2026.05.26.01.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 01:03:14 -0700 (PDT)
Message-Id: <a235b9e31d74a04c28701b11dee8e74ff7dc4d9e.1779782591.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2125.git.1779782591.gitgitgadget@gmail.com>
References: <pull.2125.git.1779782591.gitgitgadget@gmail.com>
From: "George Giorgidze via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 26 May 2026 08:03:10 +0000
Subject: [PATCH 2/2] update-index: add --refresh-stat-only
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
    George Giorgidze <giorgidze@meta.com>,
    George Giorgidze <giorgidze@meta.com>

From: George Giorgidze <giorgidze@meta.com>

When a working tree is copied from another machine, or restored from
a tarball, container image, or CI cache on the same machine, the
files may be byte-for-byte identical while cached stat data in the
index no longer matches. Backup and sync tools can preserve mtimes,
but fields like inode and device numbers are filesystem-local, so
large repositories can still end up paying for expensive refresh
checks on every "git status".

Git already has runtime configuration for reducing which stat fields
are checked, such as core.checkStat=<minimal|default>. That affects
how future checks interpret cached stat data, but it does not provide
a one-shot way to update the index's cached stat data to match the
current filesystem without also rehashing file contents. Setting
core.checkStat=minimal is "sticky": it weakens every subsequent
operation in the repository for the duration of the configuration,
rather than performing a single, bounded correction at a well-defined
point.

A similar idea was discussed on the list in January 2017 under the
name "--assume-content-unchanged"; see the thread starting at
<20170105112359.GN8116@chrystal.oracle.com>. The concern raised there
was that exposing a way to update cached stat data without content
comparison opens the index to abuse: an interactive user could skip a
slow refresh, lie to Git about the worktree, then file a bug after a
later merge corrupts a file. That concern is taken seriously here,
and this proposal is deliberately narrower than the 2017 one:

  * It is a one-shot action, not a sticky configuration or per-entry
    bit. The name --refresh-stat-only reflects that: it describes
    what the command does in a single invocation, not a trust state
    attached to entries (contrast with --assume-unchanged).

  * The trust assertion is intended for closed-loop callers (CI cache
    restore, container provisioning, backup/restore tooling) where
    the worktree and the index were produced or verified together by
    the same process. It is not a knob for interactive users to reach
    for when "git status" feels slow.

  * The failure mode is named directly in the documentation: if the
    worktree does not in fact match the index, affected entries will
    appear clean while the recorded object ID remains stale. The user
    must type the flag, having read the warning. This is a narrower
    contract than core.checkStat=minimal, which silently affects
    every subsequent operation.

Container-based CI has become the dominant deployment model in the
years since that 2017 discussion. The current workaround -- setting
core.checkStat=minimal in every job step, or accepting the cost of
full content rehashing -- is operationally fragile: it requires every
step in every pipeline to set and preserve the configuration, and it
permanently weakens stat semantics for every command those steps
run. A single explicit invocation at restore time is a tighter, more
local fix.

Teach git update-index --refresh-stat-only to refresh only cached
stat information. It follows the existing refresh machinery, but
skips ie_modified() and treats racy entries as dirty by stat instead
of resolving them by content. Like --really-refresh, it ignores the
"assume unchanged" setting, so stale stat data on those entries is
still updated; that behaviour is documented alongside the flag.

The preload pass is extended to recognise REFRESH_STAT_ONLY (on top
of REFRESH_REALLY, which was wired up in the preceding commit) so
that assume-unchanged entries are not marked uptodate before the main
refresh path can update them.

Add tests covering object ID preservation, missing-file handling with
and without --ignore-missing, assume-unchanged override, and quiet
output.

Signed-off-by: George Giorgidze <giorgidze@meta.com>
---
 Documentation/git-update-index.adoc       | 19 ++++++++
 builtin/update-index.c                    | 12 +++++
 preload-index.c                           |  2 +-
 read-cache-ll.h                           |  3 ++
 read-cache.c                              | 24 +++++----
 t/meson.build                             |  1 +
 t/t2109-update-index-refresh-stat-only.sh | 59 +++++++++++++++++++++++
 7 files changed, 110 insertions(+), 10 deletions(-)
 create mode 100755 t/t2109-update-index-refresh-stat-only.sh

diff --git a/Documentation/git-update-index.adoc b/Documentation/git-update-index.adoc
index 9bea9fab9a..2840a52ae4 100644
--- a/Documentation/git-update-index.adoc
+++ b/Documentation/git-update-index.adoc
@@ -109,6 +109,25 @@ you will need to handle the situation manually.
 	Like `--refresh`, but checks stat information unconditionally,
 	without regard to the "assume unchanged" setting.
 
+--refresh-stat-only::
+	Like `--refresh`, but updates only the stat information
+	in the index, without rehashing the file contents. This is
+	useful for large repositories after a working tree has been
+	produced or restored by means other than a normal checkout --
+	for example, a CI cache restore, container provisioning, or
+	copying a working tree from another machine -- when the file
+	contents are known to be correct but the cached stat
+	information no longer matches. Some backup and syncing tools
+	preserve mtimes, but inode numbers, device identifiers, and
+	other filesystem-specific stat fields generally cannot be
+	preserved across machines or even across mounts on the same
+	machine. Like `--really-refresh`, this option disregards the
+	"assume unchanged" setting so that stale stat data on those
+	entries is still updated. Use with care: if the worktree
+	content does not actually match what the index records, the
+	affected entries will appear clean while the recorded object
+	ID remains stale.
+
 --skip-worktree::
 --no-skip-worktree::
 	When one of these flags is specified, the object names recorded
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 8a5907767b..5e5d2e77c9 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -766,6 +766,14 @@ static int really_refresh_callback(const struct option *opt,
 	return refresh(opt->value, REFRESH_REALLY);
 }
 
+static int refresh_stat_only_callback(const struct option *opt,
+				const char *arg, int unset)
+{
+	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(arg);
+	return refresh(opt->value, REFRESH_STAT_ONLY);
+}
+
 static int chmod_callback(const struct option *opt,
 				const char *arg, int unset)
 {
@@ -957,6 +965,10 @@ int cmd_update_index(int argc,
 			N_("like --refresh, but ignore assume-unchanged setting"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
 			really_refresh_callback),
+		OPT_CALLBACK_F(0, "refresh-stat-only", &refresh_args, NULL,
+			N_("refresh stat information without checking content"),
+			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
+			refresh_stat_only_callback),
 		{
 			.type = OPTION_LOWLEVEL_CALLBACK,
 			.long_name = "cacheinfo",
diff --git a/preload-index.c b/preload-index.c
index 88bb486329..9ecc6e4af0 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -89,7 +89,7 @@ static void *preload_thread(void *_data)
 		p->t2_nr_lstat++;
 		if (lstat(ce->name, &st))
 			continue;
-		if (p->refresh_flags & REFRESH_REALLY)
+		if (p->refresh_flags & (REFRESH_REALLY | REFRESH_STAT_ONLY))
 			ce_option |= CE_MATCH_IGNORE_VALID;
 		if (ie_match_stat(index, ce, &st, ce_option))
 			continue;
diff --git a/read-cache-ll.h b/read-cache-ll.h
index 2c8b4b21b1..7e4b555a31 100644
--- a/read-cache-ll.h
+++ b/read-cache-ll.h
@@ -425,6 +425,8 @@ void *read_blob_data_from_index(struct index_state *, const char *, unsigned lon
 #define CE_MATCH_REFRESH		0x10
 /* don't refresh_fsmonitor state or do stat comparison even if CE_FSMONITOR_VALID is true */
 #define CE_MATCH_IGNORE_FSMONITOR 0X20
+/* update stat info without checking content */
+#define CE_MATCH_STAT_ONLY		0x40
 int is_racy_timestamp(const struct index_state *istate,
 		      const struct cache_entry *ce);
 int has_racy_timestamp(struct index_state *istate);
@@ -452,6 +454,7 @@ int fake_lstat(const struct cache_entry *ce, struct stat *st);
 #define REFRESH_IN_PORCELAIN             (1 << 5) /* user friendly output, not "needs update" */
 #define REFRESH_PROGRESS                 (1 << 6) /* show progress bar if stderr is tty */
 #define REFRESH_IGNORE_SKIP_WORKTREE     (1 << 7) /* ignore skip_worktree entries */
+#define REFRESH_STAT_ONLY                (1 << 8) /* update stat info without checking content */
 int refresh_index(struct index_state *, unsigned int flags, const struct pathspec *pathspec, char *seen, const char *header_msg);
 /*
  * Refresh the index and write it to disk.
diff --git a/read-cache.c b/read-cache.c
index f5023b9a8b..ec9419cbe2 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1350,6 +1350,7 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 	int ignore_skip_worktree = options & CE_MATCH_IGNORE_SKIP_WORKTREE;
 	int ignore_missing = options & CE_MATCH_IGNORE_MISSING;
 	int ignore_fsmonitor = options & CE_MATCH_IGNORE_FSMONITOR;
+	int stat_only = options & CE_MATCH_STAT_ONLY;
 
 	if (!refresh || ce_uptodate(ce))
 		return ce;
@@ -1420,12 +1421,14 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 		}
 	}
 
-	if (t2_did_scan)
-		*t2_did_scan = 1;
-	if (ie_modified(istate, ce, &st, options)) {
-		if (err)
-			*err = EINVAL;
-		return NULL;
+	if (!stat_only) {
+		if (t2_did_scan)
+			*t2_did_scan = 1;
+		if (ie_modified(istate, ce, &st, options)) {
+			if (err)
+				*err = EINVAL;
+			return NULL;
+		}
 	}
 
 	updated = make_empty_cache_entry(istate, ce_namelen(ce));
@@ -1490,11 +1493,14 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	int not_new = (flags & REFRESH_IGNORE_MISSING) != 0;
 	int ignore_submodules = (flags & REFRESH_IGNORE_SUBMODULES) != 0;
 	int ignore_skip_worktree = (flags & REFRESH_IGNORE_SKIP_WORKTREE) != 0;
+	int stat_only = (flags & REFRESH_STAT_ONLY) != 0;
 	int first = 1;
 	int in_porcelain = (flags & REFRESH_IN_PORCELAIN);
 	unsigned int options = (CE_MATCH_REFRESH |
-				(really ? CE_MATCH_IGNORE_VALID : 0) |
-				(not_new ? CE_MATCH_IGNORE_MISSING : 0));
+				((really || stat_only) ? CE_MATCH_IGNORE_VALID : 0) |
+				(not_new ? CE_MATCH_IGNORE_MISSING : 0) |
+				(stat_only ? (CE_MATCH_STAT_ONLY |
+					      CE_MATCH_RACY_IS_DIRTY) : 0));
 	const char *modified_fmt;
 	const char *deleted_fmt;
 	const char *typechange_fmt;
@@ -1520,7 +1526,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	 * cache entries quickly then in the single threaded loop below,
 	 * we only have to do the special cases that are left.
 	 */
-	preload_index(istate, pathspec, flags & REFRESH_REALLY);
+	preload_index(istate, pathspec, flags & (REFRESH_REALLY | REFRESH_STAT_ONLY));
 	trace2_region_enter("index", "refresh", NULL);
 
 	for (i = 0; i < istate->cache_nr; i++) {
diff --git a/t/meson.build b/t/meson.build
index fd955f44ef..e1e68921b4 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -291,6 +291,7 @@ integration_tests = [
   't2106-update-index-assume-unchanged.sh',
   't2107-update-index-basic.sh',
   't2108-update-index-refresh-racy.sh',
+  't2109-update-index-refresh-stat-only.sh',
   't2200-add-update.sh',
   't2201-add-update-typechange.sh',
   't2202-add-addremove.sh',
diff --git a/t/t2109-update-index-refresh-stat-only.sh b/t/t2109-update-index-refresh-stat-only.sh
new file mode 100755
index 0000000000..404d2a6fb2
--- /dev/null
+++ b/t/t2109-update-index-refresh-stat-only.sh
@@ -0,0 +1,59 @@
+#!/bin/sh
+
+test_description='git update-index --refresh-stat-only'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit initial base-file base
+'
+
+test_expect_success '--refresh-stat-only updates stat info without rehashing' '
+	test_commit refresh-stat refresh-stat original &&
+	git ls-files --stage -- refresh-stat >expect &&
+	git ls-files --debug refresh-stat | grep mtime >before &&
+	printf "modified\n" >refresh-stat &&
+	test-tool chmtime -100000 refresh-stat &&
+	test_must_fail git diff-files --quiet -- refresh-stat &&
+	git update-index --refresh-stat-only &&
+	git ls-files --debug refresh-stat | grep mtime >after &&
+	! test_cmp before after &&
+	git ls-files --stage -- refresh-stat >actual &&
+	test_cmp expect actual &&
+	git diff-files --quiet -- refresh-stat
+'
+
+test_expect_success '--refresh-stat-only ignores assume-unchanged' '
+	test_commit assume-unchanged assume-unchanged old &&
+	git update-index --assume-unchanged assume-unchanged &&
+	printf "new\n" >assume-unchanged &&
+	test-tool chmtime -100000 assume-unchanged &&
+	GIT_TEST_PRELOAD_INDEX=1 git update-index --refresh-stat-only &&
+	git update-index --no-assume-unchanged assume-unchanged &&
+	git diff-files --quiet -- assume-unchanged
+'
+
+test_expect_success '--refresh-stat-only with missing file and --ignore-missing' '
+	test_commit missing-ignore missing-ignore content &&
+	rm missing-ignore &&
+	git update-index --ignore-missing --refresh-stat-only &&
+	git checkout -- missing-ignore
+'
+
+test_expect_success '--refresh-stat-only reports error on missing file without --ignore-missing' '
+	test_commit missing-error missing-error content &&
+	rm missing-error &&
+	test_must_fail git update-index --refresh-stat-only >out 2>err &&
+	test_grep "needs update" out &&
+	git checkout -- missing-error
+'
+
+test_expect_success '--refresh-stat-only with -q is quiet' '
+	test_commit missing-quiet missing-quiet content &&
+	rm missing-quiet &&
+	git update-index -q --ignore-missing --refresh-stat-only >out 2>err &&
+	test_must_be_empty out &&
+	test_must_be_empty err
+'
+
+test_done
-- 
gitgitgadget
