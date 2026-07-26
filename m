Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CEE3BFE5D
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 18:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785091907; cv=none; b=eKKFYkMoSYNDiqNU5yfn5WzYxK0uQWYEgQyeSrbNYavWatMcohhDsYidENaK+7fDglX5iJmAaboI2Tbu2Q7p5RYqQZQSeJ90SYwKIz7XK8jkkU+CEW50z+XM7XaPiYeLIvVVnXgzTnu8Izumg9toI4JKO2MlCulU0unABQ9eWro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785091907; c=relaxed/simple;
	bh=aUvduz7JpVbsR0JZbbwNiFs3GFH6B9z6gyaT0jK85fg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JfIlI88JWIGrEAZgRbBu5ZG/YqqWQS1qWFbjJtSMRqIGeH7/WivtQeGhvqSIA2hgD+ySylvar8P+J+lxwpCnzfy2uXU9IHx+Zc1wp8eARxR5QVRS/C5Q+B9ZW8hV+zzYihSElF+01a//deD0EdTnyBADhloQZgINIlfWlnt4Z/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6RjGggM; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6RjGggM"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cf452def93so24116685ad.1
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 11:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785091905; x=1785696705; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=F6juJvzmVgEQKMS259q/zT0jflQDbDOk0p0jv9qxhmU=;
        b=V6RjGggMe7dcE/Tj0hE3LG+xm3ek0/2ghMVX0uVGWYH0yK0BL8xmixBIQxoPmNxq36
         cAXiDylZ1+HWDZNA1XOU4qcuUquizZRIsL1i+0V0RkkCqRL2+tRtXgdeGVMbAZFEyyRo
         NnAbZcoMLCeWKSl2DGwXBCiVRxA/5EYOYq3gNOPnsRlEF4pg/wY5zY/PsAIse1mM8vB6
         nZXPpdzMg5T9x84+FRDWMxOYF9ErospBp1VOu6KJ0prSV127pK7eroA2OKoeRT1lIAsO
         RckN9n+/lt04UWy7lbdJjgDJw3hJbk/RO6xB6fhtC9rbLiWg+XI2h7zz6WyuVmnqHjLh
         9YNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785091905; x=1785696705;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F6juJvzmVgEQKMS259q/zT0jflQDbDOk0p0jv9qxhmU=;
        b=DudhNFu3L0eA4ea+05MiZSD3YSUmROwbN3DoMEPHlVL/8B/+5uQuePP7bu5VobMf6H
         AtL6c0P7QG6V6/p7XGFQpEsVqz+7Tt+njSrZeW5r8X8l8Zd2pg0T0CuBvZAGVz2dYE+k
         2ZOQEfJuFmNceBNw30KPsXpbrxHlAusKTJopkduAeDueTBub/7jH8ifnSbvShpaiLLcN
         73RwvVpwAQN3Z2ZONeEx9pbk2oo/HwzhjfRR67toxWWB81SclK4OIiyjZ4n85mEgdPSW
         HLiyiQJuCAZbMGklFzsR1oUMOYXtublrBcM5G8BNPgE+O8stYJiHVcZuHqEl0W0jfYNQ
         qAPg==
X-Gm-Message-State: AOJu0YzcMqhns0tNRK0R8QunqKQJdb4h55MMgkj5oqOjj6TwnFyqEU/I
	2K1CFp8rw2Rq0nhETU7BMgp/a/vxRCNfnXN9F0BO1avfznk1GioS8dhp8oK7iQ==
X-Gm-Gg: AR+sD127+tzTEDSnfk4CTpu9aOFT2PxBSYmlEHB/hSpPKc8A1M4/TuKoIt6LxFk3DdM
	Y7AMilqct6EBRgXdSlyB7CYURhVAAm/AQMdw8tYYdEKHyvMVp+uTbCi24LmsT/joqk3ZS1xgYX4
	J5G7spHZGZxE2FQNEwGRIRRmzpjHsaFZeEi/zExv7itgqkgBQ6+k9r2ivQn4w+WbaL6HDFsScJG
	poAvykTcyKj2x0Nm0/vh/UNuovFzHj4WF3kFc1j6+Mhq+HseYdr/+4n6OSLM4Z5yuwCSCnVn3UN
	5gDdJ9/7/1RfjulLjan3Sz2tFVgyQ53YB8l3fY4r4kECOFKdqv2xq8sv0zWd/eV6A4QGdM/IRjQ
	Iocf20Y8R3zEOQFa4Cj2xwW2tDZhn3sq/vaDENusR2mFJ62jQTBil6J7QCT199aprah2O/YegCb
	1INSph
X-Received: by 2002:a05:6a20:c90a:b0:3a8:800:bdf4 with SMTP id adf61e73a8af0-3c6726b42cfmr7476105637.33.1785091905238;
        Sun, 26 Jul 2026 11:51:45 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.229.50])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d2d1d0d1esm23753586c88.0.2026.07.26.11.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 11:51:44 -0700 (PDT)
Message-Id: <ffa6954d67a0c29dd1e9218042c15570cbe19212.1785091889.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2120.v6.git.1785091889.gitgitgadget@gmail.com>
References: <pull.2120.v5.git.1784149323.gitgitgadget@gmail.com>
	<pull.2120.v6.git.1785091889.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 26 Jul 2026 18:51:28 +0000
Subject: [PATCH v6 9/9] line-log: consult diff process for range tracking
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
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

git log -L tracks line ranges by diffing each commit against its
parent in collect_diff().  This pass used the builtin diff while the
displayed diff (builtin_diff()) consults a configured
diff.<driver>.process, so the two could disagree: a reformat-only
commit selected by builtin tracking was then rendered with an empty
diff because the tool reported the files equivalent.

Consult the process in collect_diff() too, mirroring the blame
integration.  When the tool reports the files equivalent, collect no
ranges; the tracked range then maps across unchanged and the commit
drops out of the log, matching what is displayed.  Like the summary
formats, the tracking pass diffs raw content, so the tool is consulted
on the raw blobs here.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 Documentation/gitattributes.adoc | 20 ++++++++++---------
 line-log.c                       | 33 ++++++++++++++++++++++++++++----
 t/t4080-diff-process.sh          | 33 ++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 13 deletions(-)

diff --git a/Documentation/gitattributes.adoc b/Documentation/gitattributes.adoc
index 7cdede6b21..8021dc8e39 100644
--- a/Documentation/gitattributes.adoc
+++ b/Documentation/gitattributes.adoc
@@ -1037,12 +1037,16 @@ Features that ask "which lines changed" use the tool's hunks in place
 of the builtin algorithm:
 
 - `git diff` patch output, together with everything layered on it:
-  word diff, function context (`-W`), `--color-moved`, the `@@` hunk
-  headers, and the `-L` line-range display.  These operate on the
-  lines the patch step already emitted, so they reflect the tool's
-  hunks without any further negotiation.
+  word diff, function context (`-W`), `--color-moved`, and the `@@`
+  hunk headers.  These operate on the lines the patch step already
+  emitted, so they reflect the tool's hunks without any further
+  negotiation.
 - `git blame`: a commit whose change the tool reports as equivalent is
   skipped, and its lines are attributed to an earlier commit.
+- `git log -L`: both the line-range display and the underlying range
+  tracking consult the tool, so a commit it reports as equivalent is
+  dropped from the log (its tracked range maps across unchanged)
+  rather than selected and then shown with an empty diff.
 - `--stat`, `--numstat`, and `--shortstat`: the inserted and deleted
   counts come from the tool's hunks, so a file the tool calls
   equivalent contributes no stat line, matching the empty patch that
@@ -1079,11 +1083,9 @@ design:
 - `--raw`, `--name-only`, and `--name-status` compare object ids at
   the tree level and never run a line-level diff at all.
 
-Two cases ask "which lines changed" but still use the builtin
-algorithm, and may consult the process in a later change: `git log
--L`'s commit selection and parent range propagation (as distinct from
-its display, which is covered above), and combined diffs (`--cc` and
-merge diffs), whose protocol would have to be extended from a single
+Combined diffs (`--cc` and merge diffs) ask "which lines changed" but
+still use the builtin algorithm, and may consult the process in a
+later change; their protocol would have to be extended from a single
 old/new pair to one comparison per merge parent.
 
 `--no-ext-diff` and `--diff-algorithm` bypass the process entirely,
diff --git a/line-log.c b/line-log.c
index 5fc75ae275..97b3e0a31d 100644
--- a/line-log.c
+++ b/line-log.c
@@ -7,11 +7,11 @@
 #include "tag.h"
 #include "tree.h"
 #include "diff.h"
+#include "diff-process.h"
 #include "commit.h"
 #include "decorate.h"
 #include "repository.h"
 #include "revision.h"
-#include "xdiff-interface.h"
 #include "strbuf.h"
 #include "line-log.h"
 #include "setup.h"
@@ -330,12 +330,15 @@ static int collect_diff_cb(long start_a, long count_a,
 	return 0;
 }
 
-static int collect_diff(mmfile_t *parent, mmfile_t *target, struct diff_ranges *out)
+static int collect_diff(struct diff_options *diffopt, const char *path,
+			mmfile_t *parent, mmfile_t *target,
+			struct diff_ranges *out)
 {
 	struct collect_diff_cbdata cbdata = {NULL};
 	xpparam_t xpp;
 	xdemitconf_t xecfg;
 	xdemitcb_t ecb;
+	int ret = 0;
 
 	memset(&xpp, 0, sizeof(xpp));
 	memset(&xecfg, 0, sizeof(xecfg));
@@ -345,7 +348,23 @@ static int collect_diff(mmfile_t *parent, mmfile_t *target, struct diff_ranges *
 	xecfg.hunk_func = collect_diff_cb;
 	memset(&ecb, 0, sizeof(ecb));
 	ecb.priv = &cbdata;
-	return xdi_diff(parent, target, &xpp, &xecfg, &ecb);
+
+	/*
+	 * Consult the diff process so range tracking agrees with the
+	 * diff that will be shown.  When the tool reports the files as
+	 * equivalent we collect no ranges, so the tracked range maps
+	 * across unchanged and the commit drops out of the log, rather
+	 * than being selected here but rendered with an empty diff by
+	 * the process-aware builtin_diff().  Blob oids are not threaded to
+	 * this path yet, so pass NULL and send no old-oid/new-oid (a later
+	 * change can supply the pair, where they would let the tool cache
+	 * across the range-tracking and display passes over the same
+	 * commit).
+	 */
+	if (xdi_diff_process(diffopt, path, parent, target,
+			     NULL, NULL, &xpp, &xecfg, &ecb) == DIFF_PROCESS_ERROR)
+		ret = -1;
+	return ret;
 }
 
 /*
@@ -927,7 +946,13 @@ static int process_diff_filepair(struct rev_info *rev,
 	}
 
 	diff_ranges_init(&diff);
-	if (collect_diff(&file_parent, &file_target, &diff))
+	/*
+	 * Select the driver by the old (parent) path, as builtin_diff() does
+	 * with name_a, so a renamed file resolves to the same driver for
+	 * range tracking as for the diff that is shown.
+	 */
+	if (collect_diff(&rev->diffopt, pair->one->path,
+			 &file_parent, &file_target, &diff))
 		die("unable to generate diff for %s", pair->one->path);
 
 	/* NEEDSWORK should apply some heuristics to prevent mismatches */
diff --git a/t/t4080-diff-process.sh b/t/t4080-diff-process.sh
index 118d0f9464..9584a458b1 100755
--- a/t/t4080-diff-process.sh
+++ b/t/t4080-diff-process.sh
@@ -960,4 +960,37 @@ test_expect_success 'blame -w bypasses diff process' '
 	test_path_is_missing backend.log
 '
 
+#
+# Line-log (git log -L) range tracking.
+#
+
+test_expect_success 'diff process drops equivalent commit from log -L' '
+	test_when_finished "rm -f backend.log" &&
+	cat >linelog.c <<-\EOF &&
+	int tracked(void) { return 1; }
+	EOF
+	git add linelog.c &&
+	git commit -m "add linelog.c" &&
+
+	cat >linelog.c <<-\EOF &&
+	int tracked(void) { return 2; }
+	EOF
+	git commit -am "change tracked line" &&
+
+	# Builtin line tracking selects the change commit.
+	git log --no-ext-diff -L1,1:linelog.c --format="%s" >builtin &&
+	test_grep "change tracked line" builtin &&
+
+	# With the tool reporting the change as equivalent, tracking
+	# drops the commit (the range maps across unchanged) instead of
+	# selecting it and rendering an empty diff.
+	git -c diff.cdiff.process="$BACKEND --mode=no-hunks --log=backend.log" \
+		log -L1,1:linelog.c --format="%s" >actual &&
+	test_grep ! "change tracked line" actual &&
+	# The creating commit still appears, so the change commit was
+	# selectively dropped rather than the whole log going empty.
+	test_grep "add linelog.c" actual &&
+	test_grep "command=hunks pathname=linelog.c" backend.log
+'
+
 test_done
-- 
gitgitgadget
