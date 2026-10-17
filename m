Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9B33F58E0
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 22:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792277636; cv=none; b=eLpOpdvSeSXLhhgzCjTzzveOEuPsPx7FpYGsk7vEEUTdzKPj7zIg9KWhzBoKuc55qCzLTul/6WDvMx1oKwfQoV3uTPGQea16BpO/l7rTEEaXZWtbyhXXZ6aDis8QaH3EIPrdCj2kG5XWq29KYDOWuMP4qVNjOPK8bHpfuoSD/C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792277636; c=relaxed/simple;
	bh=LVvaymBoU2J5eIRSJSvnsCSXozfjhbiOvRQcEz6tSxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lpkRxUiDdp6j5BCxDH2mFFoRYEOPGvUEx38rDQ9vNCfVB5SvpI7atm6/ixfFZ4biw+u/tUvnl6QrCiqKUs7NB94Ki3LoxihWAIPRf/ZBcqTg7EkX5ZSnCdYp6VBdfpuWTN1k+QDmkqqna9xI7UJdWSvIS3NW16UzUO9x+nudfhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SicdpfX3; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SicdpfX3"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b170129413so1456333a12.1
        for <git@vger.kernel.org>; Sat, 17 Oct 2026 15:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792277633; x=1792882433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gaxv0bm44572ORE8tU+8zLjs0RIP8vAPeczN1fHya3Y=;
        b=SicdpfX3t99RqrlAGgDufGrTl85t+6CyeXqVW5GA5PKvvuKS81H16lxvu7XEu+A1G2
         +rNtrLefPWqTsENeG2Y413wyMOdbzbTacX1cygSBX14VW4GzjrH4wl0CwV+hspevzUeJ
         yvZVcyd23noixOoboryphSlf3rdJTObcIwn7TCfZZpmjhPitqZH1/+yl9fGUfa7w1UI1
         2aelZemr/Ew2Voif5uADnHPUCVA5SPEdc7NjZwPQv4Yr7ZoEYJUBn2fzy17xLHvpHR/s
         A/IDcgHZWnGAPNL9Lulu+qCWD8wdzo3KQcxk+AgCXIzJ6YdNi/8v8r5T8LU039r/FCSF
         D3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792277633; x=1792882433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gaxv0bm44572ORE8tU+8zLjs0RIP8vAPeczN1fHya3Y=;
        b=z4eK5htF8jsytPSZLYDt0Ga5DE9IhIFC1ldo1X7oZOtL/vt07gnhZ5MU1a2geFa+s9
         Bi177lThWl+PLdpsO1aHoLJA4J1MyhroM8SbAiO2YujEMotpntndfEGlJsP6ha+JoMdO
         zbITc9sSsP3blsB5VErgJJdtQ0sw2BOtfzJ2kq44M4QRHcr0gWDs0cXMpqpsGhWKpIMW
         cnQg2ns18UCee6AdFu/ZHs4klK+lgMq5VeraniBKd6FAAQkjG/xaWF67hP61WD7swQTR
         jPe/FdTW48nIzlpau3k5vXcErHBdiweoBofwkOKW1CL/+t5CsV0VXeQ+I7ptOXmKM2Cd
         voAw==
X-Gm-Message-State: AFq9FYKnC2ikK7gfMaGOqsPsDTlReZRNb9DWTQKNnrARRAa3PM1Ieb5k
	S3hb+kRDpQ3yUVLvhdZJhaJXoI5F+U7JJQyKwcGAk4zV4l65VOcsxqmA/RBj7RoolPk=
X-Gm-Gg: AYBFou0ZQaOEGOaFDmfqQenwa77me9COp2o9X8evcvWue0Mw6nafAYmKp2oYfYvbvJk
	y1tve2JCTUJ50NDFgp5VMrHhgOvPwZwW2eT/HpJc4qz3IHwUJUUrsS4xZCojxFbZUJtpLBIKqLk
	vGZDTULHPu3B0tsBPJ4c+i2TIOWIluEUnuPMO4Tl6vpHBLdZBf+yT/7r5nf0WriBOCFKw01PKEn
	OTk48mm+QQIVpa49pAKA+c+pe96IAb1wh5DnKAhUA1ySe9Nt28stIK6U299gDfmstmjq9fWiJq+
	8KeGgG1qa3Gqi4hVe8du83sUO6kBvsygeGpQoRx/mzc28HXjIUGZf6DEAM34Z/+CyhUzS5bBy9p
	O6E6CnheygnD1GSJpYKzUnFBquoEY4ZDBKR4A+odtY44BiSVGt7+AsJ6UAROf0T4RP2Z6T1zqaN
	KgM68462S457tHFkHHoEjXDUOqF6KN1gnkbT/A/FeLNX+lm4u5oYu0vupIlizDJUAnHRPmsc3bA
	G0yUD31JD14TyHhMDSRzAUa6vdXe4KuZoFMTJbdAanbUbWXh8uzqQjzHP3xAM829V1icBGK9dJp
	n2yecL/Y8+csrWVEqNkCAXNUKqIWo4oT25AoIOLn9a4uwTk5z0ELE43RLeolxic9PSfksZx5Nw=
	=
X-Received: by 2002:a05:6402:1ccf:b0:6b1:a647:981e with SMTP id 4fb4d7f45d1cf-6b3a81c1c47mr2050483a12.24.1792277632918;
        Sat, 17 Oct 2026 15:53:52 -0700 (PDT)
Received: from localhost.localdomain ([104.28.251.98])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b38a1d5262sm2322108a12.22.2026.10.17.15.53.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 15:53:51 -0700 (PDT)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	okhuomonajayi54@gmail.com
Subject: [Outreachy PATCH] checkout: use repository parameter in unique_tracking_name
Date: Sat, 17 Oct 2026 23:53:26 +0100
Message-ID: <20261017225326.7827-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function uses the_repository to read configuration and look up
the object ID of a tracking reference.

Pass the repository to unique_tracking_name() and through
tracking_name_data. Callers pass the_repository for now.

This removes the need for USE_THE_REPOSITORY_VARIABLE in checkout.c.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
 builtin/checkout.c |  3 ++-
 builtin/worktree.c |  6 ++++--
 checkout.c         | 11 ++++++-----
 checkout.h         |  4 +++-
 4 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2d575a4f57..bad49368b9 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1389,7 +1389,8 @@ static char *parse_remote_branch(const char *arg,
 	int num_matches = 0;
 	struct string_list matched_remote_names = STRING_LIST_INIT_DUP;
 
-	char *remote = unique_tracking_name(arg, rev, &num_matches,
+	char *remote = unique_tracking_name(the_repository, arg, rev,
+					    &num_matches,
 					    &matched_remote_names);
 
 	if (remote && could_be_checkout_paths) {
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 77ecd0f71f..203456bd23 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -802,7 +802,8 @@ static char *dwim_branch(const struct add_opts *opts, const char *path, char **n
 		int num_matches = 0;
 		struct string_list matched_remote_names = STRING_LIST_INIT_DUP;
 
-		remote = unique_tracking_name(*new_branch, &oid, &num_matches,
+		remote = unique_tracking_name(the_repository, *new_branch,
+					      &oid, &num_matches,
 					      &matched_remote_names);
 		if (!remote && num_matches > 1) {
 			if (!opts->quiet &&
@@ -938,7 +939,8 @@ static int add(int ac, const char **av, const char *prefix,
 			int num_matches = 0;
 			struct string_list matched_remote_names = STRING_LIST_INIT_DUP;
 
-			remote = unique_tracking_name(branch, &oid, &num_matches,
+			remote = unique_tracking_name(the_repository, branch,
+						      &oid, &num_matches,
 						      &matched_remote_names);
 			if (remote) {
 				new_branch = branch;
diff --git a/checkout.c b/checkout.c
index a0d0229435..f0fb40d48e 100644
--- a/checkout.c
+++ b/checkout.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "object-name.h"
 #include "remote.h"
@@ -11,6 +9,7 @@
 #include "string-list.h"
 
 struct tracking_name_data {
+	struct repository *repo;
 	/* const */ char *src_ref;
 	char *dst_ref;
 	struct object_id *dst_oid;
@@ -30,7 +29,7 @@ static int check_tracking_name(struct remote *remote, void *cb_data)
 	memset(&query, 0, sizeof(struct refspec_item));
 	query.src = cb->src_ref;
 	if (remote_find_tracking(remote, &query) ||
-	    repo_get_oid(the_repository, query.dst, cb->dst_oid)) {
+	    repo_get_oid(cb->repo, query.dst, cb->dst_oid)) {
 		free(query.dst);
 		return 0;
 	}
@@ -51,17 +50,19 @@ static int check_tracking_name(struct remote *remote, void *cb_data)
 	return 0;
 }
 
-char *unique_tracking_name(const char *name, struct object_id *oid,
+char *unique_tracking_name(struct repository *repo,
+			   const char *name, struct object_id *oid,
 			   int *dwim_remotes_matched,
 			   struct string_list *dwim_remote_names)
 {
 	struct tracking_name_data cb_data = TRACKING_NAME_DATA_INIT;
 	const char *default_remote = NULL;
 
-	if (!repo_config_get_string_tmp(the_repository,
+	if (!repo_config_get_string_tmp(repo,
 					"checkout.defaultremote",
 					&default_remote))
 		cb_data.default_remote = default_remote;
+	cb_data.repo = repo;
 	cb_data.src_ref = xstrfmt("refs/heads/%s", name);
 	cb_data.dst_oid = oid;
 	cb_data.remote_names = dwim_remote_names;
diff --git a/checkout.h b/checkout.h
index 0b185a0fc9..25fe7dfb7c 100644
--- a/checkout.h
+++ b/checkout.h
@@ -3,6 +3,7 @@
 
 #include "hash.h"
 
+struct repository;
 struct string_list;
 
 /*
@@ -10,7 +11,8 @@ struct string_list;
  * tracking branch.  Return the name of the remote if such a branch
  * exists, NULL otherwise.
  */
-char *unique_tracking_name(const char *name,
+char *unique_tracking_name(struct repository *repo,
+			   const char *name,
 			   struct object_id *oid,
 			   int *dwim_remotes_matched,
 			   struct string_list *dwim_remote_names);
-- 
2.54.0

