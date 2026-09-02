Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0C2485505
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 18:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788373748; cv=none; b=RQl68foiUu/pNa022vu70lHJKz7/+KgKIUedl4Lmh6+D5Dw1lvVH7v//uKGk5HLZDqnLoW2fAUVsEM3K7h45fCMOY6Jy01zmltXJHwnhO78ozK7z8lyA2T9jdQGTPuULpRF2myG0Kmhq7aX/pP+Kwrd7jQfqxrqnerzve8zZTb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788373748; c=relaxed/simple;
	bh=N+ZJT7bWpSMRZMwhOtJOk4fufzo2NHtgJv27kkjOE/A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NztJJWh4ys61ZWVlHfxxSVnaQ7wavDvjGIEhep3vOTmjMdAHrII3AzjM2B7cWPLrNACr5PxVU0I8ZzDJT229zVw76jFVqB0yvnITGipCNC66jMitbepGdTA4Q/a05L83tcrc0NPTUgTp8h8iV9VKnYgAD7lKPHHenEe5hUpkiLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nujjy2kL; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nujjy2kL"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8534d507f59so1810370b3a.0
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 11:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788373745; x=1788978545; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tXS92OQKerbxEMHxIv9uzaOsApt3e3dfUrmrwpCFiqw=;
        b=nujjy2kLCCwz+KWdaWtgOSZswQNRx+XJsYY7qVLCwB27P1O5we/NJGE7qFXW2QqNCS
         krZPofRs3LehhXagkac08UGjZdsoK/LFcCRFZb30M09OuYee++h3Wd0l/JKgb66m1x6g
         dvQ+P8vwRKFXFkona1sYkTb7Qortz6cTyLZsPzzgpjXyTNIEziGRJb4PjafoWdiwJLhb
         nhVzZpSVqpAS3MjG/LK41J+eAYH00nDWDnTHvOcdJXAFMYXRiv53Diq4KtnHWq9ntKba
         8tPXn4key9tjvd+ND0V1SpmcFr6qwKluYngY8ABmkWBEyx/fKQtc8jdpQrfRNVBn0VYS
         wtCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788373745; x=1788978545;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tXS92OQKerbxEMHxIv9uzaOsApt3e3dfUrmrwpCFiqw=;
        b=oJLw0pY8gheyfAh42qPVWb1YOqQ5/4c/sk/r1b1c2SGBTqNx5RGqtyRONUiHG1vBOf
         GpOr9fvS2lcB7vjrln8Gv+N4T7l9Cqy4nJN/LaWIQdwQLvlgKHbCevEX5kPBLHtFJ+Oh
         IrpfoVE2WQ2OxVEKGQZ84ml9r2VqNysFCCYpCyJ1KLxRvMbDqwxPesJxc12imUZC1XQV
         Y7wJWJlUrcrl23L2Q3g2QknH2Hq3BrhIafowfbS797+IKWD+lXP2aFOw7snB7RnemScN
         WJ7j70CGQC9ZQbjSEq5GgL2Cty+hEm+hWbG2LJ5KK5yU+eAq95IqF3ve4rHIZjzVyCrP
         8yoA==
X-Gm-Message-State: AFuF++nkkIxxMoG+r9B93nK1eq1y82N5NHyH9jbPvbjVZRjZ5o+p4l5O
	hPD5AFRjAZinVskpsD+U6tDCTFDhhuIa0jhPdnatuS1I28yixd1rJjDWJCXuSA==
X-Gm-Gg: AYBFou3NWSDmDGJx3WXZAbFxkVg9mhE/DN3EtRgzPJi7n3ESNelqUsI8Lp38qdmqWnO
	JYnEEL9upJQWWtUhLW5LRzsBUQzSlv5iMbWRO7a+uO3DvpNKb4mfKgSGcsG09xkmINXvBuydRlg
	HbWLQfZ++9JFmTlc0SdsxmdZwQEBaDWA0MEM5c+diYIeBrnUTvDVhN4toUpGWimpGIbsvZ1XRTY
	XRGptIYUIBDzU94262FyCsoHYPo72A0DRo46Rme8E7I6UmybE+a4z1/owDedVr1rpS8AXZEzEuv
	HKuTLMXB6OB8A6wReNsbD6+4RysLRj48Qa+wDsnjO9ADAURhZTfvSf8lOpuv6BHGenvdRrnHyHz
	oJljrezgir2SOWPh8HgTrWiCMxaGSZFqQpdw4Ci5Z9AXKGFsQ/RWWTCoofDRq+bxsdMXVmifT0x
	vwq+qu3pFzcf5TMU0YX6Goir5V03I+VcGgwwBfg+sNkNcZBZDSOls9rLxvRUY77A==
X-Received: by 2002:a05:6a00:2e1e:b0:847:77e9:acbb with SMTP id d2e1a72fcca58-85ed93c110emr9433804b3a.13.1788373745457;
        Wed, 02 Sep 2026 11:29:05 -0700 (PDT)
Received: from [127.0.0.1] ([20.64.182.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85da342023asm1813643b3a.0.2026.09.02.11.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 11:29:04 -0700 (PDT)
Message-Id: <ff4322180294c784bcd5f4e92b35e4b334324ddc.1788373743.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2364.v4.git.git.1788373743.gitgitgadget@gmail.com>
References: <pull.2364.git.git.1784993669.gitgitgadget@gmail.com>
	<pull.2364.v4.git.git.1788373743.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 02 Sep 2026 18:29:02 +0000
Subject: [PATCH v4 1/2] stash: reserve exit status 1 for conflicts
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

"git stash apply", "pop" and "branch" exit with status 1 both when
applying the stash entry resulted in conflicts and when they fail for
other reasons, so callers cannot tell the two apart.

Follow the convention of "git merge-tree" and the merge strategies,
which exit with status 1 to indicate conflicts and with a different
non-zero status for errors: those subcommands now exit with status 1
only when applying the stash entry resulted in conflicts, in which
case the stash entry is left in place, and exit with status 128, the
status die() uses, when they fail for other reasons.  Document the
exit statuses.

cmd_stash() used to collapse the return values of the subcommand
implementations to a boolean.  It now maps negative values, which
signal a failure, to 128 and passes everything else through as-is.
The only implementations that return a positive value are "apply",
"pop" and "branch", which return the value of do_apply_stash():
"apply" returns it directly, and "pop" and "branch" drop the stash
entry, via do_drop_stash(), which always returns 0, only when the
application succeeded.  The positive value is always 1, as
do_apply_stash() only returns a positive value when the three-way
merge was unclean.

Make the convention explicit by introducing enum stash_apply_result
with the values STASH_APPLY_CLEAN, STASH_APPLY_CONFLICT and
STASH_APPLY_ERROR, and use it for the in-process autostash helpers,
too.  They spawn "git stash apply" and can now tell conflicts apart
from other failures, e.g. a crash or death by signal of the child,
which map to exit statuses above 1.  Since we know the stash entry
was saved, tell users so in the error message instead of leaving them
wondering what happened to their stashed changes.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-stash.adoc |  9 +++++
 builtin/stash.c              | 32 ++++++++++++-----
 sequencer.c                  | 66 ++++++++++++++++++++++--------------
 sequencer.h                  | 19 +++++++----
 stash.h                      | 21 ++++++++++++
 t/t3903-stash.sh             | 25 ++++++++++++--
 6 files changed, 128 insertions(+), 44 deletions(-)
 create mode 100644 stash.h

diff --git a/Documentation/git-stash.adoc b/Documentation/git-stash.adoc
index 50bb89f483..fc6a9a008c 100644
--- a/Documentation/git-stash.adoc
+++ b/Documentation/git-stash.adoc
@@ -426,6 +426,15 @@ include::includes/cmd-config-section-all.adoc[]
 :git-stash: 1
 include::config/stash.adoc[]
 
+EXIT STATUS
+-----------
+
+The `git stash` subcommands exit with status 0 on success.  The
+subcommands that apply a stash entry, i.e. `apply`, `pop` and `branch`,
+exit with status 1 when applying the stash entry resulted in conflicts,
+in which case the stash entry is left in place, and with a non-zero
+status other than 1 when they fail for other reasons.
+
 
 SEE ALSO
 --------
diff --git a/builtin/stash.c b/builtin/stash.c
index 72c52571f8..d858b7603f 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -10,6 +10,7 @@
 #include "object-name.h"
 #include "parse-options.h"
 #include "refs.h"
+#include "stash.h"
 #include "lockfile.h"
 #include "cache-tree.h"
 #include "unpack-trees.h"
@@ -640,10 +641,12 @@ static void unstage_changes_unless_new(struct object_id *orig_tree)
 		die(_("could not write index"));
 }
 
-static int do_apply_stash(const char *prefix, struct stash_info *info,
-			  int index, int quiet,
-			  const char *label_ours, const char *label_theirs,
-			  const char *label_base)
+static enum stash_apply_result do_apply_stash(const char *prefix,
+					      struct stash_info *info,
+					      int index, int quiet,
+					      const char *label_ours,
+					      const char *label_theirs,
+					      const char *label_base)
 {
 	int clean, ret;
 	int has_index = index;
@@ -717,8 +720,8 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 
 	/*
 	 * If 'clean' >= 0, reverse the value for 'ret' so 'ret' is 0 when the
-	 * merge was clean, and nonzero if the merge was unclean or encountered
-	 * an error.
+	 * merge was clean, and 1 if the merge was unclean or a negative value
+	 * if it encountered an error.
 	 */
 	ret = clean >= 0 ? !clean : clean;
 
@@ -2492,9 +2495,20 @@ int cmd_stash(int argc,
 	strbuf_addf(&stash_index_path, "%s.stash.%" PRIuMAX, index_file,
 		    (uintmax_t)pid);
 
-	if (fn)
-		return !!fn(argc, argv, prefix, repo);
-	else if (!argc)
+	if (fn) {
+		ret = fn(argc, argv, prefix, repo);
+
+		/*
+		 * The subcommand implementations return 0 on success, a
+		 * negative value on failure, and STASH_APPLY_CONFLICT
+		 * when applying a stash entry resulted in conflicts.
+		 * Map failures to 128, the status die() uses, so that
+		 * exit status 1 unambiguously indicates conflicts.
+		 */
+		if (ret < 0)
+			return 128;
+		return ret;
+	} else if (!argc)
 		return !!push_stash_unassumed(0, NULL, prefix, repo);
 
 	/* Assume 'stash push' */
diff --git a/sequencer.c b/sequencer.c
index 65afd100d9..b5dd855084 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -19,6 +19,7 @@
 #include "commit.h"
 #include "sequencer.h"
 #include "run-command.h"
+#include "stash.h"
 #include "hook.h"
 #include "utf8.h"
 #include "cache-tree.h"
@@ -4794,13 +4795,15 @@ void create_autostash_ref(struct repository *r, const char *refname,
 	create_autostash_internal(r, NULL, refname, message, silent);
 }
 
-static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
-				    const char *label_ours, const char *label_theirs,
-				    const char *label_base,
-				    const char *stash_msg)
+static enum stash_apply_result apply_save_autostash_oid(const char *stash_oid,
+							int attempt_apply,
+							const char *label_ours,
+							const char *label_theirs,
+							const char *label_base,
+							const char *stash_msg)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
-	int ret = 0;
+	enum stash_apply_result ret = STASH_APPLY_CLEAN;
 
 	if (attempt_apply) {
 		child.git_cmd = 1;
@@ -4816,9 +4819,11 @@ static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
 			strvec_pushf(&child.args, "--label-base=%s", label_base);
 		strvec_push(&child.args, stash_oid);
 		ret = run_command(&child);
+		if (ret > 1)
+			ret = STASH_APPLY_ERROR;
 	}
 
-	if (attempt_apply && !ret)
+	if (attempt_apply && ret == STASH_APPLY_CLEAN)
 		fprintf(stderr, _("Applied autostash.\n"));
 	else {
 		struct child_process store = CHILD_PROCESS_INIT;
@@ -4832,13 +4837,16 @@ static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
 		strvec_push(&store.args, stash_oid);
 		if (run_command(&store))
 			ret = error(_("cannot store %s"), stash_oid);
-		else if (attempt_apply)
+		else if (attempt_apply && ret == STASH_APPLY_CONFLICT)
 			fprintf(stderr,
 				_("Your local changes are stashed, however applying them\n"
 				  "resulted in conflicts.  You can either resolve the conflicts\n"
 				  "and then discard the stash with \"git stash drop\", or, if you\n"
 				  "do not want to resolve them now, run \"git reset --hard\" and\n"
 				  "apply the local changes later by running \"git stash pop\".\n"));
+		else if (attempt_apply)
+			ret = error(_("could not apply autostash; "
+				      "your changes are safe in the stash"));
 		else
 			fprintf(stderr,
 				_("Autostash exists; creating a new stash entry.\n"
@@ -4850,15 +4858,16 @@ static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
 	return ret;
 }
 
-static int apply_save_autostash(const char *path, int attempt_apply)
+static enum stash_apply_result apply_save_autostash(const char *path,
+						    int attempt_apply)
 {
 	struct strbuf stash_oid = STRBUF_INIT;
-	int ret = 0;
+	enum stash_apply_result ret = STASH_APPLY_CLEAN;
 
 	if (!read_oneliner(&stash_oid, path,
 			   READ_ONELINER_SKIP_IF_EMPTY)) {
 		strbuf_release(&stash_oid);
-		return 0;
+		return STASH_APPLY_CLEAN;
 	}
 	strbuf_trim(&stash_oid);
 
@@ -4870,37 +4879,40 @@ static int apply_save_autostash(const char *path, int attempt_apply)
 	return ret;
 }
 
-int save_autostash(const char *path)
+enum stash_apply_result save_autostash(const char *path)
 {
 	return apply_save_autostash(path, 0);
 }
 
-int apply_autostash(const char *path)
+enum stash_apply_result apply_autostash(const char *path)
 {
 	return apply_save_autostash(path, 1);
 }
 
-int apply_autostash_oid(const char *stash_oid)
+enum stash_apply_result apply_autostash_oid(const char *stash_oid)
 {
 	return apply_save_autostash_oid(stash_oid, 1, NULL, NULL, NULL, NULL);
 }
 
-static int apply_save_autostash_ref(struct repository *r, const char *refname,
-				    int attempt_apply,
-				    const char *label_ours, const char *label_theirs,
-				    const char *label_base,
-				    const char *stash_msg)
+static enum stash_apply_result apply_save_autostash_ref(struct repository *r,
+							const char *refname,
+							int attempt_apply,
+							const char *label_ours,
+							const char *label_theirs,
+							const char *label_base,
+							const char *stash_msg)
 {
 	struct object_id stash_oid;
 	char stash_oid_hex[GIT_MAX_HEXSZ + 1];
-	int flag, ret;
+	int flag;
+	enum stash_apply_result ret;
 
 	if (!refs_ref_exists(get_main_ref_store(r), refname))
-		return 0;
+		return STASH_APPLY_CLEAN;
 
 	if (!refs_resolve_ref_unsafe(get_main_ref_store(r), refname,
 				     RESOLVE_REF_READING, &stash_oid, &flag))
-		return -1;
+		return STASH_APPLY_ERROR;
 	if (flag & REF_ISSYMREF)
 		return error(_("autostash reference is a symref"));
 
@@ -4915,15 +4927,19 @@ static int apply_save_autostash_ref(struct repository *r, const char *refname,
 	return ret;
 }
 
-int save_autostash_ref(struct repository *r, const char *refname)
+enum stash_apply_result save_autostash_ref(struct repository *r,
+					   const char *refname)
 {
 	return apply_save_autostash_ref(r, refname, 0,
 					NULL, NULL, NULL, NULL);
 }
 
-int apply_autostash_ref(struct repository *r, const char *refname,
-			const char *label_ours, const char *label_theirs,
-			const char *label_base, const char *stash_msg)
+enum stash_apply_result apply_autostash_ref(struct repository *r,
+					    const char *refname,
+					    const char *label_ours,
+					    const char *label_theirs,
+					    const char *label_base,
+					    const char *stash_msg)
 {
 	return apply_save_autostash_ref(r, refname, 1,
 					label_ours, label_theirs, label_base,
diff --git a/sequencer.h b/sequencer.h
index 64a9c7fb1b..804501b64c 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -3,6 +3,7 @@
 
 #include "strbuf.h"
 #include "strvec.h"
+#include "stash.h"
 #include "wt-status.h"
 
 struct commit;
@@ -231,13 +232,17 @@ void commit_post_rewrite(struct repository *r,
 void create_autostash(struct repository *r, const char *path);
 void create_autostash_ref(struct repository *r, const char *refname,
 			  const char *message, bool silent);
-int save_autostash(const char *path);
-int save_autostash_ref(struct repository *r, const char *refname);
-int apply_autostash(const char *path);
-int apply_autostash_oid(const char *stash_oid);
-int apply_autostash_ref(struct repository *r, const char *refname,
-			const char *label_ours, const char *label_theirs,
-			const char *label_base, const char *stash_msg);
+enum stash_apply_result save_autostash(const char *path);
+enum stash_apply_result save_autostash_ref(struct repository *r,
+					   const char *refname);
+enum stash_apply_result apply_autostash(const char *path);
+enum stash_apply_result apply_autostash_oid(const char *stash_oid);
+enum stash_apply_result apply_autostash_ref(struct repository *r,
+					    const char *refname,
+					    const char *label_ours,
+					    const char *label_theirs,
+					    const char *label_base,
+					    const char *stash_msg);
 
 #define SUMMARY_INITIAL_COMMIT   (1 << 0)
 #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
diff --git a/stash.h b/stash.h
new file mode 100644
index 0000000000..14ba4f946d
--- /dev/null
+++ b/stash.h
@@ -0,0 +1,21 @@
+#ifndef STASH_H
+#define STASH_H
+
+enum stash_apply_result {
+	/* The stash was applied cleanly, or there was nothing to apply. */
+	STASH_APPLY_CLEAN = 0,
+
+	/*
+	 * The stash could not be applied because it resulted in
+	 * conflicts.  The stash entry is left in place.  The "git stash
+	 * apply", "pop" and "branch" subcommands exit with this status
+	 * in this case, mirroring the convention of "git merge-tree" and
+	 * the merge strategies.
+	 */
+	STASH_APPLY_CONFLICT = 1,
+
+	/* Something went wrong. */
+	STASH_APPLY_ERROR = -1,
+};
+
+#endif /* STASH_H */
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index da27a6599a..6529508b06 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1791,13 +1791,13 @@ test_expect_success 'stash.index=false overridden by --index' '
 	test_cmp expect file
 '
 
-test_expect_success 'apply with custom conflict labels' '
+test_expect_success 'apply exits 1 on conflicts' '
 	git reset --hard initial &&
 	test_commit label-base conflict-file base-content &&
 	echo stashed >conflict-file &&
 	git stash push -m "stashed" &&
 	test_commit label-upstream conflict-file upstream-content &&
-	test_must_fail git -c merge.conflictStyle=diff3 stash apply --label-ours=UP --label-theirs=STASH &&
+	test_expect_code 1 git -c merge.conflictStyle=diff3 stash apply --label-ours=UP --label-theirs=STASH &&
 	test_grep "^<<<<<<< UP" conflict-file &&
 	test_grep "^||||||| Stash base" conflict-file &&
 	test_grep "^>>>>>>> STASH" conflict-file
@@ -1809,11 +1809,30 @@ test_expect_success 'apply with empty conflict labels' '
 	echo stashed >conflict-file &&
 	git stash push -m "stashed" &&
 	test_commit empty-label-upstream conflict-file upstream-content &&
-	test_must_fail git stash apply --label-ours= --label-theirs= &&
+	test_expect_code 1 git stash apply --label-ours= --label-theirs= &&
 	test_grep "^<<<<<<<$" conflict-file &&
 	test_grep "^>>>>>>>$" conflict-file
 '
 
+test_expect_success 'pop exits 1 on conflicts and keeps the stash entry' '
+	git reset --hard initial &&
+	echo stashed >file &&
+	git stash push -m pop-stashed &&
+	test_commit pop-upstream file upstream-content &&
+	test_expect_code 1 git stash pop &&
+	git stash list >list &&
+	test_grep pop-stashed list
+'
+
+test_expect_success 'stash branch exits with a non-1 status on errors' '
+	git reset --hard initial &&
+	echo stashed >file &&
+	git stash push -m branch-stashed &&
+	test_expect_code 128 git stash branch conflicting-branch refs/heads/does-not-exist &&
+	git stash list >list &&
+	test_grep branch-stashed list
+'
+
 test_expect_success 'stash show --include-untracked includes untracked files' '
 	git reset --hard &&
 
-- 
gitgitgadget

