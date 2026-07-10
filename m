Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99813C7E0E
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 07:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783669311; cv=none; b=tloujOUce3IZkx6Jys6o3K8ulgd5Q6G4GMQUHazdUF4WjAJWzAc7felzQGyGT52m1fsDIskzC1naNOX21w3fzhIAQCT0EAWurHWkISc17RwUqmB/pRFO9z/KK5NMxnJKkwcwWbHoDp0+fKiphiGy4/bcvrzeNibhwKIg+wZcBKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783669311; c=relaxed/simple;
	bh=hS6uk6jAtZMuVWM9mg/J8I8ai+JR73gRVk5yonylmhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H/Jrr8/MfF+id7p1NeR9rdOmQ5V+L5uaz3dAFrnf8yHElvpSNAES+NBMNg04ROsepQZTXyHsn1i8DWlWol5fMm9aj7SdwsrDx7JXdrOlmY8q1jFIKD+k/MY34/lC/GDUX4PUhA5YbBSXkHvzNaS/tJDN33SlVCyVTcBDJRrLDPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLrDpqME; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLrDpqME"
Received: by mail-pj2-f1.google.com with SMTP id d9443c01a7336-2cac634f921so2306705ad.0
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 00:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783669309; x=1784274109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lvvMCwNjkl97pewu8xFfvc/ZaP9z2psOs5bbFGs9790=;
        b=YLrDpqMEFS2L2HLZxmk/h2ELh7tHsWjWG1b/8oOkd1y3A5qNu8Z0Oa3rxrI1zzQ4ij
         L6xHPdxxL2Zf+e4ZQ89ImpNQDErzdkavnTE0N0YBYFrR6ho4DdooN9Hg7oT1Xtnte7GX
         zrryS3WKN4WdBt9QhnpenBtD7NLMcnti4GBWR8385BpEdLm3DsWi9wq6ks0FT0W/wbla
         QT4lV8IzMlo54lWOR3zEQm7fmMCTpji0GlKZVlVxD2Zb8N46CPMkFr3ehfIXpTkTDbZs
         R4OpfVoNF38X3Hq1zFELuw/iV8rWuZQPRDO883d2KmNF2TBkkASZqXqh6ShaGvuFnPvk
         HD7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783669309; x=1784274109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lvvMCwNjkl97pewu8xFfvc/ZaP9z2psOs5bbFGs9790=;
        b=HKan0owbUhStSes2O4sA7B/cYeogeYLuSpTRCkWUmTHBs5gx9T+HJiwO8sW7ag9n+W
         O5V8qpbEysLKYJiOqh7s0Xoh0nIFsotzBFYjqVoPDwUQlfR7j8t3uNG7q21P8uG6AcJj
         PrAtITLVNNC0OQXT/AmBF3YNtYYABGQbiyr6h1Z03BFOupYAKmvKuaRjbNgPTtK/lQXP
         1tBuzdV+2N1aNZ9p4brqhskNikhVR1uWyGyiJTqFQQAbGkaDlQ65Sp8Ql9NDNuaJJImM
         a6+uR8Dkxb5+FLV5uOLDVWzLPkzOCEq0r4+XJSXtYSTN26y+2JXBO5hCN49X1VVQTYr/
         QsRQ==
X-Gm-Message-State: AOJu0Ywxqn7w8Mbsi43MbbppYV5XR+gKpfMYqErXZplu3XwHxC0W1b2u
	iXBOsucU08dmDeTrZsr0k2mto/WEM2cg9hiyVtyZBvEzyUAnzrtCNxKhFgkf22TJ2FQ=
X-Gm-Gg: AfdE7cmIrUKC8EipjCvW8JF4CN4SJNX3ofrlOP3OTcOtfvTXAckq+IZ/N56mtKDhk+Y
	4frP/t1rQbCYm8Tjvom1tj3djxD0D0IgtlaOWwH0JJT/xM+5Yjdr2Tt0mfs3kYuhIkR+fq7ASE9
	O6XP6aByq3iVaLJoVep8GT+JwBaj937l1KCdgbT3kbUwHH5+ZMskQI73InyMpmdSmRQ1QqOnp/7
	AmI7YRRY6BfQ0aY7TLysgaoouBdso8EEERjk9OfDzlWdJBKAnc/TiRpalhFPeukyfjcEmDXzmKq
	lfs1b55vowaDmqgWKrFiOQ/ufgR9Ju87x2QYpvDfqsGxEqMzA7T5rzsxSdWid1hncrlXUuINXoP
	BBoF+USB567vnD1lyNoV8vlna+FtvPqwCXVqhjjyXIHtQboh1tXs9o5oBJZ2GsySFqaHa3Bkp1+
	YsCAbfGwTHumb0iFF9uj5vip4ksg34w+bhLD0jdVEigHAKD+hMb49HDpnVRw==
X-Received: by 2002:a05:6a20:2d24:b0:3bf:836e:876e with SMTP id adf61e73a8af0-3c0bd0fa2d7mr13989149637.44.1783669308701;
        Fri, 10 Jul 2026 00:41:48 -0700 (PDT)
Received: from localhost.localdomain ([45.117.66.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311935fd091sm21628522eec.24.2026.07.10.00.41.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Jul 2026 00:41:48 -0700 (PDT)
From: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
To: git@vger.kernel.org
Cc: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Subject: [PATCH v2] builtin/add.c: replace run_command() with direct apply_all_patches() call
Date: Fri, 10 Jul 2026 13:02:06 +0530
Message-ID: <20260710074105.50737-1-gatlavishweshwarreddy26@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <xmqqmrvzfitd.fsf@gitster.g>
References: <xmqqmrvzfitd.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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

Changes in v2:
- Fixed commit message: "was done" -> "is done" (present tense)
- Added check_apply_state() call after setting state.cached = 1,
  which sets state.check_index = 1 required for index updates

In response to review:

- check_apply_state() with cached=1 correctly
  sets check_index=1, ensuring apply_all_patches() updates the index
  as intended. Verified by reading apply.c lines 172-175.

- Tested with t3700-add.sh: all 58 tests pass


 builtin/add.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index c859f66519..a7266020cd 100644
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
@@ -187,7 +186,6 @@ static int edit_patch(struct repository *repo,
 		      const char *prefix)
 {
 	char *file = repo_git_path(repo, "ADD_EDIT.patch");
-	struct child_process child = CHILD_PROCESS_INIT;
 	struct rev_info rev;
 	int out;
 	struct stat st;
@@ -217,11 +215,17 @@ static int edit_patch(struct repository *repo,
 	if (!st.st_size)
 		die(_("empty patch. aborted"));

-	child.git_cmd = 1;
-	strvec_pushl(&child.args, "apply", "--recount", "--cached", file,
-		     NULL);
-	if (run_command(&child))
+	struct apply_state state;
+	const char *apply_argv[] = { file, NULL };
+
+	if (init_apply_state(&state, repo, prefix))
+		die(_("could not initialize apply state"));
+	state.cached = 1;
+	if (check_apply_state(&state, 0))
+		die(_("could not check apply state"));
+	if (apply_all_patches(&state, 1, apply_argv, APPLY_OPT_RECOUNT))
 		die(_("could not apply '%s'"), file);
+	clear_apply_state(&state);

 	unlink(file);
 	free(file);
--
2.54.0

