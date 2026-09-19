Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C565B257827
	for <git@vger.kernel.org>; Sat, 19 Sep 2026 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789826669; cv=none; b=MZKQILW463AWY9dWDZe1KaebahPjLLFvwXrimGbOXYFaO34FFALo0+bM7rnw8kpWihuSQqV8HH7+lW2mtRDhi8OnO7IHbzqIsTSjUa2inBuPe1x80zZTY7Wyli88ah86iIrf6seQ4p1XFOwROS1vjgBO94UL9q0JDhVeW2P72LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789826669; c=relaxed/simple;
	bh=gQaBw/hc5PZJV3ycwKfKkCdH8JK6Xa7mDA6vUKnzIQY=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Tjb1gZSdfjYJj30T86yD2EN5z9qo8dipw4pOc474jqUaxfr8xhi4vc2cZc6F5hB9Kqzo6icl4HUeWxn9fHzK0lIUt7PYu17jB1FfEgsgGZqIziX2bt+Xe0aIyNamf7r7BC5Sh9YbDBvNJWu+nhxXY6EcJAPhRzp5gpsDtINpWpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kn9fo/vo; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kn9fo/vo"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd88a115ebso13998515ad.2
        for <git@vger.kernel.org>; Sat, 19 Sep 2026 07:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789826667; x=1790431467; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8F+qScInsztD3H0Vdg3CiMOQWlnEK+Q77pq1lWhii9Y=;
        b=Kn9fo/vo5MSwndC9eg+sBKuHXmtaXCYnxYd/Qn+GiRwjZDp+UMYkA0K91A4rCslnqt
         vFaeE4BQED28d52eCGLsIkasFo9irP1+V6ZoXTcx814iciHT5sflk0YcZccSakEsMjOW
         jyFZKHpE2IhLpb0ZWwPuCi0nHIUWvU0FUJgCLHX0qrBv36J7FXlm5jGFUhCA53BEOMEn
         nMUcStzDj8ncvypjwz2N/AnMBJPjhECnnPOXbue+eBktp/JIdTjxv1+7DKA08Nz7JnkG
         ReyOiRxOLdsgp+ycleSyagnrE/8msBRLQcDjRaEuvYERVhjvqBAeeWezY2slcm3KU/UJ
         cYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789826667; x=1790431467;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8F+qScInsztD3H0Vdg3CiMOQWlnEK+Q77pq1lWhii9Y=;
        b=nHPAGLu/KAGkF2qSy9wTr11voSXjPISmLp52+X3J8UXVvFm+nsloW+07czDbl3ALXo
         W+WVek5am6M1NyqsmnxLa94xQTO0Jz5SJ5q8JlkyzPEWsKYeLqkbFuVuewdk6SfslCLS
         kfPA+9WFeViB1K+TyQnFwBLoyrQsZWGP6UcWjAyMmo7cm47pmduZoyKxPwJRHSbNCooy
         IMx8vAXVfqAz7sj+Es1qq407bNuFjar5BlBExnK5jKdHyvEpMkChSRRcuiag/dbLw+OD
         MA+X+TmB4FviZkolhYkL/rDQxMYxV74fc0/047qM3cL33/K1LCgyUIX6RpgFCpjjwCDj
         i3qQ==
X-Gm-Message-State: AFuF++l2nZSxCr5IqYnyDldlBXMq9J2OPbKIllpUlmdxK0vrlcpYZnOb
	H3doOArygmeqSu05eG4Vwd4smh2a9qI0f5lentc4HjJrv1Ufd/P7epMmyWkCOw==
X-Gm-Gg: AYBFou1T/uzyYFqhw+4SooSFbjqaN2+Y32yn7MoZ6D1yhmnTWeSzHvA1M5TEaSQXP1N
	6lFVZiAmGX/tfItmPgpcl2mBTb9031FdwcOgRWcrdVud0Xh/+LymOJopXRVAS92/5I8IhiB/eJu
	YRdQLM4VOFvExYWjbDef2RmcbbGEuYYSVrKyB26REGL7c5a3CDoObWc9EnnZCnIjan2tM3t/hRT
	gxF93ySaWw+NQ58iSDNWfuZnD7/yYRQ+0Lst8taMjCktAmTcHq36peK5XMCfXcxf127fu2MWYtI
	yOTv7hBPKuaUSxEuwCRoZxWRtn9QqIrUwBBMJ5gS8TsLCUpg1giDwaYUhGJIdWLJb8jK6B26JZX
	SBmyNLm/W/TMOnzqM4zBtlh1O8s8LzZJ0/FZtniKaR5LwJZ2S54iXPFUT5t46GXY/ZsW7g5OJZZ
	CUUdf/s0QGi+KwnPHdvFi90Gvp2p4LaDAboJNflLMQx0flhULzj7v90mBP3odRXwFyb4nAcAs3
X-Received: by 2002:a17:90b:4d09:b0:39e:6a81:f349 with SMTP id 98e67ed59e1d1-39e6a81fd25mr4196766a91.35.1789826666808;
        Sat, 19 Sep 2026 07:04:26 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.244.0])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144d55bf843sm10008279c88.8.2026.09.19.07.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 07:04:25 -0700 (PDT)
Message-Id: <pull.2226.git.1789826665188.gitgitgadget@gmail.com>
From: "Yashwanth Sai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 19 Sep 2026 14:04:25 +0000
Subject: [PATCH/RFC] commit: warn when a new commit is dated before its parent
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
Cc: Yashwanth Sai <ysaimuppineni789@gmail.com>,
    Yashwanth Sai <ysaimuppineni789@gmail.com>

From: Yashwanth Sai <ysaimuppineni789@gmail.com>

Git writes whatever the clock says into the commit object and validates
nothing: a commit dated years in the future, or earlier than its own
parent, is accepted silently. "git fsck --strict" does not object either,
since fsck's badDate and badDateOverflow checks are purely syntactic.

That would be harmless if history traversal did not assume commit dates
are non-decreasing, but it does. "git log --since" stops walking at the
first commit older than the cutoff, so a single out-of-order date hides
every commit behind it:

	$ git log --pretty='%cd %s' --date=short
	2026-09-25 C3 - inside the window
	2026-09-01 C2 - outside the window
	2026-09-20 C1 - inside the window

	$ git log --pretty='%cd %s' --date=short --since=2026-09-13
	2026-09-25 C3 - inside the window

C1 is inside the window and silently missing. This is understood --
96697781e0 (revision: add "--since-as-filter" option, 2022-07-19) added
an opt-in traversal mode for it -- but nothing tells the person whose
clock caused it, at the moment they could still fix it cheaply.

Warn at commit time when the new commit's date precedes a parent's, gated
on a new advice.clockSkew setting. Warning rather than refusing is
deliberate: only the committer can tell whether their clock or the
parent's is the wrong one. Once the commit is published the date is part
of its object name, and correcting it means rewriting every descendant,
so the warning is worth little later and quite a lot now.

The check looks at the commit being created and its parents and nothing
else. Skew between different machines is ordinary in a distributed system
and is not something to complain about; this fires only when one
repository's own history steps backwards. It is limited to git commit --
merges and replayed history go through other paths, where non-monotonic
dates are often legitimate.

A warning along these lines has been suggested more than once without
landing; see for instance the discussion around clock skew in
<CA+55aFw_XjWm+4XwsN6CRJnsrcEu5YEChOHSHN51UUBN6PynWw@mail.gmail.com>.

Co-authored-by: Claude Opus 5 (1M context) <noreply@anthropic.com>
Signed-off-by: Yashwanth Sai <ysaimuppineni789@gmail.com>
---
    commit: warn when a new commit is dated before its parent
    
    This is an RFC: a warning of this shape has been suggested more than
    once over the years without landing, so I would rather learn whether it
    is wanted at all before polishing it.
    
    The reproduction that motivated it -- a commit inside the window is
    silently skipped because traversal stops at an out-of-order parent:
    
    $ git log --pretty='%cd %s' --date=short
    2026-09-25 C3 - inside the window
    2026-09-01 C2 - outside the window
    2026-09-20 C1 - inside the window
    
    $ git log --pretty='%cd %s' --date=short --since=2026-09-13
    2026-09-25 C3 - inside the window
    
    
    C1 is inside the window and missing. This is understood -- 96697781e0
    (revision: add "--since-as-filter" option, 2022-07-19) added an opt-in
    traversal mode for exactly it -- but nothing tells the person whose
    clock caused it, at the point where it is still cheap to fix. I hit this
    on a repository of my own after moving the system clock to test
    date-dependent behaviour; by the time I noticed, the dates were part of
    the object names.
    
    What the warning looks like:
    
    hint: the new commit is dated 2026-09-13 06:00:00 +0530,
    hint: which is earlier than its parent, dated 2026-09-25 10:00:00 +0000.
    hint: This usually means the system clock is wrong.
    hint: Commands that walk history in date order, such as
    hint: "git log --since", may skip commits as a result.
    hint: Disable this message with "git config set advice.clockSkew false"
    
    
    The scope is deliberately narrow:
    
     * Warn, never refuse. Only the committer can tell whether their clock
       or the parent's is the wrong one.
     * The commit being created and its parents, nothing else. Skew between
       machines is ordinary in a distributed system; this fires only when
       one repository's own history steps backwards.
     * git commit only. Merges and replayed history go through other paths,
       where non-monotonic dates are frequently legitimate.
    
    Questions I would most like answered:
    
     1. Is this wanted at all? Both conclusions -- that it is a good idea,
        and that it may not be worth the effort -- appear in the archives.
    
     2. Is advice the right channel? There is a fair objection that hints on
        stderr get buried among other output.
    
     3. Should fsck grow an INFO-tier check for the "far ahead of now" case
        too? That cannot compare against parents, since fsck_commit()
        deliberately never loads parent objects, so it would be a separate
        and weaker check.
    
    t7502 gains three tests; t7502, t7501, t7500 and t0018 all pass.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2226%2Fysai258%2Fadvice-clock-skew-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2226/ysai258/advice-clock-skew-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2226

 Documentation/config/advice.adoc |  7 ++++
 advice.c                         |  1 +
 advice.h                         |  1 +
 builtin/commit.c                 | 61 ++++++++++++++++++++++++++++++++
 t/t7502-commit-porcelain.sh      | 27 ++++++++++++++
 5 files changed, 97 insertions(+)

diff --git a/Documentation/config/advice.adoc b/Documentation/config/advice.adoc
index 81f80a9274..59b643d9d0 100644
--- a/Documentation/config/advice.adoc
+++ b/Documentation/config/advice.adoc
@@ -38,6 +38,13 @@ all advice messages.
 		configuration variable for how to set a given remote
 		to be used by default in some situations where this
 		advice would be printed.
+	clockSkew::
+		Shown by linkgit:git-commit[1] when the commit being
+		created is dated earlier than one of its parents, which
+		usually means the system clock is wrong. History
+		traversal assumes commit dates do not decrease, so such
+		a commit can cause commands like `git log --since` to
+		skip the commits behind it.
 	commitBeforeMerge::
 		Shown when linkgit:git-merge[1] refuses to
 		merge to avoid overwriting local changes.
diff --git a/advice.c b/advice.c
index 63bf8b0c5f..3e14859de4 100644
--- a/advice.c
+++ b/advice.c
@@ -50,6 +50,7 @@ static struct {
 	[ADVICE_AMBIGUOUS_FETCH_REFSPEC]		= { "ambiguousFetchRefspec" },
 	[ADVICE_AM_WORK_DIR] 				= { "amWorkDir" },
 	[ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME] 	= { "checkoutAmbiguousRemoteBranchName" },
+	[ADVICE_CLOCK_SKEW]				= { "clockSkew" },
 	[ADVICE_COMMIT_BEFORE_MERGE]			= { "commitBeforeMerge" },
 	[ADVICE_DEFAULT_BRANCH_NAME]			= { "defaultBranchName" },
 	[ADVICE_DETACHED_HEAD]				= { "detachedHead" },
diff --git a/advice.h b/advice.h
index 66f6cd6a77..43de2b19a2 100644
--- a/advice.h
+++ b/advice.h
@@ -17,6 +17,7 @@ enum advice_type {
 	ADVICE_AMBIGUOUS_FETCH_REFSPEC,
 	ADVICE_AM_WORK_DIR,
 	ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME,
+	ADVICE_CLOCK_SKEW,
 	ADVICE_COMMIT_BEFORE_MERGE,
 	ADVICE_DEFAULT_BRANCH_NAME, /* To be retired sometime after Git 3.0 */
 	ADVICE_DETACHED_HEAD,
diff --git a/builtin/commit.c b/builtin/commit.c
index 28f6174503..70b9aa5ec5 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -11,6 +11,7 @@
 #include "builtin.h"
 #include "advice.h"
 #include "config.h"
+#include "date.h"
 #include "lockfile.h"
 #include "cache-tree.h"
 #include "color.h"
@@ -21,6 +22,7 @@
 #include "commit.h"
 #include "add-interactive.h"
 #include "gettext.h"
+#include "ident.h"
 #include "revision.h"
 #include "wt-status.h"
 #include "run-command.h"
@@ -1666,6 +1668,63 @@ struct repository *repo UNUSED)
 	return 0;
 }
 
+/*
+ * Warn when the commit we are about to write is dated earlier than a parent.
+ *
+ * Git stores whatever the clock says, and history traversal assumes commit
+ * dates do not decrease: "git log --since", for one, stops walking at the
+ * first commit older than the cutoff, so an out-of-order date silently hides
+ * the commits behind it. Only the person committing can tell whether their
+ * clock or the parent's is the wrong one, so warn rather than refuse.
+ *
+ * This deliberately looks at nothing but the commit being created and its
+ * parents. Skew between machines is normal in a distributed system and is not
+ * something to complain about at commit time.
+ */
+static void warn_if_dated_before_parents(struct commit_list *parents)
+{
+	struct ident_split committer;
+	struct strbuf ours = STRBUF_INIT;
+	const char *info;
+	timestamp_t date, newest = 0;
+
+	if (!advice_enabled(ADVICE_CLOCK_SKEW))
+		return;
+
+	info = git_committer_info(IDENT_STRICT);
+	if (split_ident_line(&committer, info, strlen(info)) ||
+	    !committer.date_begin)
+		return;
+	date = parse_timestamp(committer.date_begin, NULL, 10);
+
+	for (; parents; parents = parents->next) {
+		struct commit *parent = parents->item;
+
+		if (repo_parse_commit(the_repository, parent))
+			continue;
+		if (parent->date > newest)
+			newest = parent->date;
+	}
+
+	if (!newest || date >= newest)
+		return;
+
+	/* show_date() reuses one buffer, so keep a copy of the first result. */
+	strbuf_addstr(&ours, show_date(date, atoi(committer.date_end + 1),
+				       DATE_MODE(ISO8601)));
+
+	advise_if_enabled(ADVICE_CLOCK_SKEW,
+			  _("the new commit is dated %s,\n"
+			    "which is earlier than its parent, dated %s.\n"
+			    "This usually means the system clock is wrong.\n"
+			    "Commands that walk history in date order, such as\n"
+			    "\"git log --since\", may skip commits as a result."),
+			  ours.buf,
+			  /* A parsed commit keeps no timezone, so show UTC. */
+			  show_date(newest, 0, DATE_MODE(ISO8601)));
+	strbuf_release(&ours);
+}
+
 static int git_commit_config(const char *k, const char *v,
 			     const struct config_context *ctx, void *cb)
 {
@@ -1935,6 +1994,8 @@ int cmd_commit(int argc,
 		append_merge_tag_headers(parents, &tail);
 	}
 
+	warn_if_dated_before_parents(parents);
+
 	if (commit_tree_extended(sb.buf, sb.len, &the_repository->index->cache_tree->oid,
 				 parents, &oid, author_ident.buf, NULL,
 				 sign_commit, extra)) {
diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
index 2adfe70b3d..fb611b191b 100755
--- a/t/t7502-commit-porcelain.sh
+++ b/t/t7502-commit-porcelain.sh
@@ -1003,4 +1003,31 @@ test_expect_success WITH_BREAKING_CHANGES 'core.commentChar=auto is rejected' '
 	test_cmp expect actual
 '
 
+test_expect_success 'warn when a commit is dated before its parent' '
+	test_when_finished "git checkout main 2>/dev/null || git checkout master" &&
+	git checkout -b clock-skew &&
+	test_commit --date "2026-09-25T10:00:00+0000" skew-parent &&
+	echo skew >skew-child &&
+	git add skew-child &&
+	GIT_COMMITTER_DATE="2026-09-13T06:00:00+0000" \
+		git commit -m "behind its parent" 2>actual &&
+	test_grep "earlier than its parent" actual
+'
+
+test_expect_success 'no warning when commit dates increase' '
+	echo forward >skew-forward &&
+	git add skew-forward &&
+	GIT_COMMITTER_DATE="2026-09-26T06:00:00+0000" \
+		git commit -m "after its parent" 2>actual &&
+	test_grep ! "earlier than its parent" actual
+'
+
+test_expect_success 'advice.clockSkew silences the warning' '
+	echo quiet >skew-quiet &&
+	git add skew-quiet &&
+	GIT_COMMITTER_DATE="2026-09-14T06:00:00+0000" \
+		git -c advice.clockSkew=false commit -m quiet 2>actual &&
+	test_grep ! "earlier than its parent" actual
+'
+
 test_done

base-commit: 47ce80527c56f462cb97db4ca8125342204d3783
-- 
gitgitgadget
