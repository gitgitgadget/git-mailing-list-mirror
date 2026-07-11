Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FC830E0EE
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 06:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783750385; cv=none; b=ee55k0DUdaBgXyz+mm6LDN+Y1j3S5tyUG6+qiIsNCCLo1yiZGF/gIeEv+tsIv8kLB8imh5ZnFw/ZCsIUcmMgZLHWsSaWnN2sjwdTIKRN98oX3fJ2aA3r053RdrZ++RGwEH3kdo9pANRN52UKIcxvdXuJ7Iqtgx1PpIMpGlVlQ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783750385; c=relaxed/simple;
	bh=Z0D/NsD0hgLDTAl/P2DvK+CIEgSMRyIJ818P8YFw9Io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dmku409dFfQ7vlcclNqyinrvOQ4jEmlLRVx8jFoxpFJvELC8JgwZsDGuiz1xZApevHw6xCAtFq2qoMqGU31mQmM01DIsRWs4NvLbO0gMbzWHX8YpIcTO59aKj0/VyqjjeIwFLkActyAktm/XwIZ3c6W5f5tivw9mM2btFkJWpzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nzjLJ+VK; arc=none smtp.client-ip=74.125.227.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nzjLJ+VK"
Received: by mail-pj2-f2.google.com with SMTP id 98e67ed59e1d1-37fb1883f59so592702a91.1
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 23:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783750383; x=1784355183; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xtH1cDeyyY26xaxcdz6RJ+I12a1LDaL/1Og9UO9998w=;
        b=nzjLJ+VKN7cnLFcgQ/72emDjQVa1zCnzcgXX1i6camjRXBBbt+zhGsSKPNjn0pCtmw
         ovKLH8dbAbO5WshCjRJ28g/5tPR2McXIywJpb04KLiKH/BKM6z+W2MjHstukXOVqPlB1
         nZO130T5dnsMzLQh//rbDIvAFIxRBsx6/aq3t4BlfRg9NJE8oLtEYing78WHVpz/7fBW
         nXWbHgwEE608+bYsDk5qUq4VU5AF0pL6vIFX9THUSU5iqzC03BbupW9emadsChmaa+3S
         8weV1dew3jSHkmu4CB6MwpQczCGKvGXg4VoyzIZxiGMX2nqWjfkOfmxhVVfBO+ZUICl8
         gqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783750383; x=1784355183;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xtH1cDeyyY26xaxcdz6RJ+I12a1LDaL/1Og9UO9998w=;
        b=AFPTHVVvANW4HF0yx49UIMdBB7uPzR/k0nlPZlCqV0Mjs/jwiDFAqfVIDB3wU1fQXx
         iiUqwfOBkuVK+eskkyjhhBtl+1REYY0eK2pP/wOFGuhfETXqXFVJF8Uyry1wk8eMs+tL
         mY1bIU0mjVwgXps1Z6nQXhooWrsXcq98GV85buLsuxs7AT5wvPwr1wZSui3BIQ0IPunT
         pSow87Hdggld6U6d4uP1qhbG02Ad4ZQUbS68D/QOssdZGHmC7D5ViBPK49AsXRqWYNsH
         brb7xRQ8D14Lf69fqlIT3E/nZw+xFTeChmzeFMRyJVgY759HJyBkXlELoMSxUsSpmrs0
         /IPg==
X-Gm-Message-State: AOJu0YxaZkcoAxsfrV/tGNvAPmpPUCBsFreDa9JSEoFLVAPFlSSVG11h
	VNIViImT/hCs8CP7s2SprTXFjJh5Cgf7FbU/40ssd2WBPL0HU8vlHcU+Coy57le7nFo=
X-Gm-Gg: AfdE7cleestl571U9LyeueYrNe5t5ArhrkNIjHf3u8niNbjLWhgCCDumdEde03x51LX
	jsb0TatlBkL7MIhCZQEtA54imhP8EeYQcnPNCCpTBiCR92Q8Rlz+afvxyql0tQHrgqLsOce2W0s
	YAZ2KbW9PS91BQewobMJsXSzVXVRammMjCq+V2PspqMsMGzd1hGCO77lcF1NOEwPPnfYizFzwuB
	gFWT/2Y/X+20RCLdKXmjfNrYdZ7xHritm7DaRVo4SosHJMFsFZ4zt4Tq1RAPCopfokw/ej3p0hp
	yIdy5FXRXpeiS/qgyVa1X3Hu+kS3tNE9zA+rLqmtFQ87t25FKkzTDujN/IIYrwX9g193Uq73yPf
	o4KLVflgTNan/sMXg4TYJCnNOVF9XYRQEqWMeR6PVUaIWxos9RagSRotzZFYZIEpxeWfPrrSQgS
	gXqhOK2dhOkR4fIhACZIGI6XMq6aguchCxDOgT9uCl9649PwdmixRc250Jc+epy6coY44=
X-Received: by 2002:a17:90b:2d4d:b0:381:6466:7160 with SMTP id 98e67ed59e1d1-38dc7b38895mr2030386a91.26.1783750382742;
        Fri, 10 Jul 2026 23:13:02 -0700 (PDT)
Received: from localhost.localdomain ([2409:40f0:17:596c:45f9:bde5:f24f:9f57])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174ac14f2sm49937237eec.27.2026.07.10.23.12.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Jul 2026 23:13:02 -0700 (PDT)
From: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
To: git@vger.kernel.org
Cc: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Subject: [PATCH v4] builtin/add.c: replace run_command() with direct apply_all_patches() call
Date: Sat, 11 Jul 2026 11:36:15 +0530
Message-ID: <20260711061246.58079-1-gatlavishweshwarreddy26@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <xmqqechab03t.fsf@gitster.g>
References: <xmqqechab03t.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When the user runs "git add -e", the diff of the working tree changes
is written to a temporary file, opened in an editor, and then applied
back to the index. The application step is done by spawning a child
process running "git apply --recount --cached <file>", which is an
unnecessary subprocess since the apply machinery is available as a
native C API.

Replace the run_command() call with a direct call to apply_all_patches()
using an initialized apply_state with the cached and recount options set
appropriately. This avoids the overhead of forking a subprocess, keeps
the operation within the same process, and makes the intent of the code
clearer to the reader.

Remove the now-unused includes of "run-command.h" and "strvec.h" since
no other code in this file requires them after this change.

Signed-off-by: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
---

---
Changes in v4:
- Pass NULL instead of prefix to init_apply_state() since the file
  path from repo_git_path() is a git-internal path that should not
  be prefixed. This is safe regardless of whether repo->gitdir is
  absolute or relative, as prefix_filename(NULL, arg) returns the
  path unchanged (abspath.c line 269).
- Add a test in t3702-add-edit.sh verifying that "git add -e" works
  correctly when run from a subdirectory.
- Tested with t3702-add-edit.sh: all 4 tests pass.

In response to review:
- You are right that repo->gitdir may not always be absolute
  (setup.c line 1109). Passing NULL as prefix to init_apply_state()
  avoids the issue entirely — prefix_filename(NULL, arg) sets
  pfx_len=0 and returns the path unchanged regardless of whether
  it is absolute or relative.

- t3702-add-edit.sh was found via "git grep -e 'add -e' t/" as
  suggested. A new test using GIT_EDITOR=cat verifies that
  "git add -e" works correctly from a subdirectory.

 builtin/add.c       | 19 ++++++++++++-------
 t/t3702-add-edit.sh | 10 ++++++++++
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index c859f66519..20a86a1611 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -13,7 +13,6 @@
 #include "dir.h"
 #include "gettext.h"
 #include "pathspec.h"
-#include "run-command.h"
 #include "object-file.h"
 #include "odb.h"
 #include "odb/transaction.h"
@@ -23,9 +22,9 @@
 #include "diff.h"
 #include "read-cache.h"
 #include "revision.h"
-#include "strvec.h"
 #include "submodule.h"
 #include "add-interactive.h"
+#include "apply.h"

 static const char * const builtin_add_usage[] = {
 	N_("git add [<options>] [--] <pathspec>..."),
@@ -187,7 +186,8 @@ static int edit_patch(struct repository *repo,
 		      const char *prefix)
 {
 	char *file = repo_git_path(repo, "ADD_EDIT.patch");
-	struct child_process child = CHILD_PROCESS_INIT;
+	struct apply_state state;
+	const char *apply_argv[2];
 	struct rev_info rev;
 	int out;
 	struct stat st;
@@ -217,11 +217,16 @@ static int edit_patch(struct repository *repo,
 	if (!st.st_size)
 		die(_("empty patch. aborted"));

-	child.git_cmd = 1;
-	strvec_pushl(&child.args, "apply", "--recount", "--cached", file,
-		     NULL);
-	if (run_command(&child))
+	apply_argv[0] = file;
+	apply_argv[1] = NULL;
+	if (init_apply_state(&state, repo, NULL))
+		die(_("could not initialize apply state"));
+	state.cached = 1;
+	if (check_apply_state(&state, 0))
+		die(_("could not check apply state"));
+	if (apply_all_patches(&state, 1, apply_argv, APPLY_OPT_RECOUNT))
 		die(_("could not apply '%s'"), file);
+	clear_apply_state(&state);

 	unlink(file);
 	free(file);
diff --git a/t/t3702-add-edit.sh b/t/t3702-add-edit.sh
index 8bacacbac6..f628564005 100755
--- a/t/t3702-add-edit.sh
+++ b/t/t3702-add-edit.sh
@@ -124,5 +124,15 @@ test_expect_success 'add -e notices editor failure' '
 	test_must_fail env GIT_EDITOR=false git add -e &&
 	test_expect_code 1 git diff --exit-code
 '
+test_expect_success 'add -e works from a subdirectory' '
+	git reset --hard &&
+	echo change >>file &&
+	mkdir -p subdir &&
+	(
+		cd subdir &&
+		GIT_EDITOR=cat git add -e ../file
+	) &&
+	git diff --cached | grep -q "^+change"
+'

 test_done
--
2.54.0

