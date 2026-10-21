Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792577384;
	b=pVziBvEt6nY7dCnN30OA9Ft0lK5GaZC9hEqMZSGqYKrwJYn9hqE0KsJ9k+Hc35i6xFBD
	 c8aVXQr7Tx5A9WxNzCdYOm5cG6k8as73Kp89yT14ANih14LFTMnD5Z7kHQ0hZGfC//5+x
	 cIPIqGwbDzS9GuhDNsYJc8PO7HV7hp77fzbWBfAmkRtwmAef2fH7zwIWEJs5n33W3ORlh
	 GJIzZeO8JmTCvTn9tR4TGRQDl9K78gUxFNT+ZPmAwKnwfTNbdb7vfARSKNgx8UJi1MxaB
	 RHaIfK26aZgCH8u6hejQOZpiBELjVnEzSpkTKHYlychxUoOwdCIk+Io47qFYSO71p0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792577384;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=/K8Pt/RJNpvSPOe/CCp5utumwS2UTq37rh26Vdvewws=;
	b=XYz+CDn4uxqP48+EWtDdlI16J79owyZ/GfOYkQq4gcljnPJUP2qPyt1gE4ovcA5FOIKi
	 DIwpi1fO33pUCYE3EmlRtn9sE7O9xa+adYxwOqCZVoqntvPwUJvPvgty+q+EjnCQjfGDd
	 t7/yjNjMIBi/izAx6QVDD9mAdtSqiv+tNQlFLTycHGge1CCEW4lSMqWANk6eMvqAgjhWQ
	 QX0d0tkqZH/mD48weHxy6VG+ZgSG2t8RIIx5sqs/2hK+t1fhKsmFTpDcfHDpPr5mc90cB
	 6NHW/NNJyeBugppHpSWolyC/OzyGiFACF+JyEVKde4WjcTQczEBlij2ULl75cUkNoOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=moUkqtzr;
	arc=none smtp.remote-ip=209.85.167.179
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BD7606A31B
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 10:09:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81BD7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=moUkqtzr
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-53ec2cc397aso381155b6e.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 03:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792577383; x=1793182183; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/K8Pt/RJNpvSPOe/CCp5utumwS2UTq37rh26Vdvewws=;
        b=moUkqtzri8f9c9jVE3h755wvVnZkZ7lDMzgbE3M3cmxP5+EU8GGsrVG8b8jp4QjJtI
         RC6yAvxUzH9Jkr9bdEoG3yqPh4RfP/chfLsbuOvBV0mNKHydbzAr8XHyVsZzVgNh7sfI
         z/a+Z6ubEAa0nJREZh6jBUlBuIPwqTvFTWqDVZykjaK6aMl0MqW8cV6MdyxSdiDdo1ki
         T5j95GKe69BeByYjLj5U82PySaUyGWUSNA6p/DqfjneOV4MKey/3tPnG8f673PjiCN+v
         FGlNZnjn6lgzMhPA6KHocxCLJ+mpC2Q3KFrkkedQdhZrDfUOwiUyLFcC0dvLRmo+oAm/
         wIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792577383; x=1793182183;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/K8Pt/RJNpvSPOe/CCp5utumwS2UTq37rh26Vdvewws=;
        b=fK5KSIOnQ2bS8ixuDbcLcJ1j+6UODo1N1RzlDyYxeiZPMxGBKDVtNxhvKCGh4girde
         WIFzOiMmDPwlshkwjKUzF7hO0qW6kS92cCqgJknCUljUdS6wYHnl1RcuQ/WOBkhm5pYN
         K8q6s7l/1IHdR+78GJ1bs9omG9qMczz/7SkoOjQ2PmaSzT7uPvHxeQHuYdhmsRss7iGj
         PWMN3YcmOhWRfQxeQDmmx9WRa1g5hp0FguvggNsozsnvv9SIYVLXsrTiRZcgF7Y/avv/
         z7BFzO+yDlge2k7Oqfp7ohw5apmDhRnooepkHOXlJ1cyrU29O/iw/RdXV0XmoXae+qUJ
         pujA==
X-Gm-Message-State: AFq9FYKf7TR7qZuMORAqThPh7XLhQl/I5p0czmGMJG+/BytwqXWnaRpj
	MpR94WAODIUR9wNL5AeZSkpjYtTMkxK8Y2VxmX0VuIJrwqK1g1gFPR7dcBRK7g==
X-Gm-Gg: AYBFou3NTVDZo+D7KEb7TXTS0Z7omTisRNxtmX6t57oufMPH2JCGsESg4ItE3MARQAo
	wsW2LqURmFPKVkhJNCW3Kg44ewpitZookUbU/0gi4vw1spSqVmc1pnKMncgiBu6X6iV/MmZ5s6J
	Mm9UmN9WQMTXHPeefMcb+kgrKdecabomd/G9QAv91xQcB1crRychtFvCoRC3PfmLaladWMtSOOB
	to+7nOOEoZ3Vy1HM9mT7TqzAphOADh4+X95Yh6NA2NK4u1Tt/Ca0yucDrs6w2qx+/8qZrntnNRe
	YhyGaawibetzOu1j5WriymQrLEHFDjBIdA8Eb84A0UL+5KDoWpqDwgFC+19HcEYkKaeLke+KRfq
	Cr1cCwhd9CQQdB5fFuoF2hxAnX3SSloHnTOWofQIICmww8j/MPe2sD+Wdv81YnBNlIW4milpKsY
	EBLYNUTN97yyvuM4N3bYYHoNKW5e2sr4RZNWD+irYEp4X8Usirlx6NapZWZGP/cyjb5WabECxbL
	3NDqM3ByEg1mYIzYwbVwbvbYhyC2bOXqBoq5+h1mrQTnn3YmQ92brb+OUs=
X-Received: by 2002:a05:6808:1990:b0:4f6:1ef7:6cd9 with SMTP id 5614622812f47-553611f50c5mr1126805b6e.64.1792577383195;
        Wed, 21 Oct 2026 03:09:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.86.110.219])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-552b7454fe5sm1689591b6e.13.2026.10.21.03.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 03:09:41 -0700 (PDT)
Message-Id: <pull.2273.git.1792577381142.gitgitgadget@gmail.com>
From: "Nakul V S via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 Oct 2026 10:09:41 +0000
Subject: [PATCH] sequencer: refuse to revert shallow boundary commits by
 default
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Junio C Hamano <gitster@pobox.com>,
    Nakul V S <vsnakul@gmail.com>,
    Nakul V S <vsnakul@gmail.com>

From: Nakul V S <vsnakul@gmail.com>

When a repository is cloned with --depth=1, Git records the boundary
commit in .git/shallow and rewrites its parent links via the graft
mechanism, making it appear as a root commit. Reverting such a commit
will therefore delete all tracked files, which is almost always
unintended by the user.

Add a check in do_pick_commit() that detects when the target commit is
a shallow boundary (nr_parent < 0 in the commit graft) and refuses the
operation by default. A new --allow-shallow-boundary flag is provided
for the rare cases where the user genuinely intends this behavior.

Signed-off-by: Nakul V S <vsnakul@gmail.com>
---
    sequencer: refuse to revert shallow boundary commits by default

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2273%2Fvsnakul%2Fsequencer-shallow-boundary-check-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2273/vsnakul/sequencer-shallow-boundary-check-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2273

 Documentation/git-revert.adoc | 12 +++++++++++-
 builtin/revert.c              |  4 +++-
 sequencer.c                   | 14 ++++++++++++++
 sequencer.h                   |  1 +
 t/t3501-revert-cherry-pick.sh | 25 +++++++++++++++++++++++++
 5 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-revert.adoc b/Documentation/git-revert.adoc
index ffba365e63..4395df62e2 100644
--- a/Documentation/git-revert.adoc
+++ b/Documentation/git-revert.adoc
@@ -8,7 +8,7 @@ git-revert - Revert some existing commits
 SYNOPSIS
 --------
 [verse]
-'git revert' [--[no-]edit] [-n] [-m <parent-number>] [-s] [-S[<keyid>]] <commit>...
+'git revert' [--[no-]edit] [-n] [-m <parent-number>] [-s] [-S[<keyid>]] [--allow-shallow-boundary] <commit>...
 'git revert' (--continue | --skip | --abort | --quit)
 
 DESCRIPTION
@@ -122,6 +122,16 @@ include::rerere-options.adoc[]
 	configuration variable can be used to enable this option by
 	default.
 
+--allow-shallow-boundary::
+	By default, 'git revert' refuses to revert a commit that is a
+	shallow boundary (i.e. a commit listed in `.git/shallow`),
+	because its true parent history is absent from the clone and
+	reverting it would remove all tracked files. This option
+	overrides that safeguard and allows the revert to proceed.
++
+To restore full history before reverting, use
+`git fetch --unshallow` instead.
+
 
 SEQUENCER SUBCOMMANDS
 ---------------------
diff --git a/builtin/revert.c b/builtin/revert.c
index 52100a20cb..f27397fdec 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -24,7 +24,7 @@
  */
 
 static const char * const revert_usage[] = {
-	N_("git revert [--[no-]edit] [-n] [-m <parent-number>] [-s] [-S[<keyid>]] <commit>..."),
+	N_("git revert [--[no-]edit] [-n] [-m <parent-number>] [-s] [-S[<keyid>]] [--allow-shallow-boundary] <commit>..."),
 	N_("git revert (--continue | --skip | --abort | --quit)"),
 	NULL
 };
@@ -128,6 +128,8 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 		OPT_BOOL('e', "edit", &opts->edit, N_("edit the commit message")),
 		OPT_NOOP_NOARG('r', NULL),
 		OPT_BOOL('s', "signoff", &opts->signoff, N_("add a Signed-off-by trailer")),
+		OPT_BOOL(0, "allow-shallow-boundary", &opts->allow_shallow_boundary,
+			 N_("allow reverting a shallow boundary commit")),
 		OPT_CALLBACK('m', "mainline", opts, N_("parent-number"),
 			     N_("select mainline parent"), option_parse_m),
 		OPT_RERERE_AUTOUPDATE(&opts->allow_rerere_auto),
diff --git a/sequencer.c b/sequencer.c
index efbfd1315b..6de59bf6aa 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -49,6 +49,7 @@
 #include "rebase-interactive.h"
 #include "reset.h"
 #include "branch.h"
+#include "shallow.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -2366,6 +2367,19 @@ static enum pick_result do_pick_commit(struct repository *r,
 	}
 	discard_index(r->index);
 
+	if (is_repository_shallow(r)) {
+		struct commit_graft *graft = lookup_commit_graft(r, &commit->object.oid);
+		if (graft && graft->nr_parent < 0 && !opts->allow_shallow_boundary) {
+			return error(_("%s: commit %s is a shallow boundary commit.\n"
+				       "Reverting it will remove all tracked files because its\n"
+				       "true parent history is not present in this clone.\n"
+				       "Use --allow-shallow-boundary to override, or\n"
+				       "'git fetch --unshallow' to restore full history first."),
+				     command_to_string(command),
+				     oid_to_hex(&commit->object.oid));
+		}
+	}
+
 	if (!commit->parents)
 		parent = NULL;
 	else if (commit->parents->next) {
diff --git a/sequencer.h b/sequencer.h
index a5d12a1070..f334bc5357 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -57,6 +57,7 @@ struct replay_opts {
 	int committer_date_is_author_date;
 	int ignore_date;
 	int commit_use_reference;
+	int allow_shallow_boundary;
 
 	struct strvec trailer_args;
 
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 939e7a16a6..508464004f 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -256,4 +256,29 @@ test_expect_success 'cherry-pick is unaware of --reference (for now)' '
 	test_grep "^usage: git cherry-pick" actual
 '
 
+# Tests for shallow boundary safeguard
+
+test_expect_success 'setup shallow boundary tests' '
+	git init src &&
+	test_commit -C src A &&
+	test_commit -C src B &&
+	git clone --no-local --depth=1 src shallow-repo
+'
+
+test_expect_success 'revert of shallow boundary commit is refused by default' '
+	test_must_fail git -C shallow-repo revert --no-edit HEAD 2>err &&
+	test_grep "shallow boundary commit" err
+'
+
+test_expect_success 'revert of shallow boundary succeeds with --allow-shallow-boundary' '
+	git -C shallow-repo revert --no-edit --allow-shallow-boundary HEAD
+'
+
+test_expect_success 'revert in non-shallow repo is unaffected' '
+	git init non-shallow &&
+	test_commit -C non-shallow A &&
+	test_commit -C non-shallow B &&
+	git -C non-shallow revert --no-edit HEAD
+'
+
 test_done

base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926
-- 
gitgitgadget
