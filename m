Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792618528;
	b=eG7SGtCJu+B1VtqzSRdvwsN1+voch1ao80uIIXfLvFhX6iJoQtrTcQ2ywpp2uLyXISvF
	 HFY0l1XHrSYlScMbIdS1AciZblZQid9riFapF34MeznhiqAeC/quoUIqEQGc0oeYs0rOP
	 C53Cg9jIU99nN4HUrwGRWpcdZDDBUlc9Xi2Ryeu57LtVNANvLm4fMBHvhlLMVseHyWE6B
	 7iGUen/Zn6/byDtnrh3eTaYzL4K4Vqjy/3SIf2/+O2j4tmi4byGet+ViTRSEND1MK0s2j
	 rxOw2xyblw9JarCZowWRQw5P83msGH0u+1xifq3Tvawr3Jf5BwNJaStPoduHVoWwS9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792618528;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=pLEuAz/QbPTYBdHooVKnI0+3sIAEAA6ML+6W1W/5CB0=;
	b=1mFs6yJ/vtfKqESxH4ANULdseDSK4YtFB46WL6ksgDhpUpLirDkD3RHyznnQmJeTfGZO
	 6XJA4xcdr6GGuhH/C+Qvo9sk96J5BKgr07Rd/4iaR03HvZGfmSm3ZyKE5d+lpqyA5pHxb
	 w4NB3om75OUbyuJiA4/LF14z8obD6M/LgCdyxBTWGaXMZg38PmL77SVzI++j7WrD5g7Jl
	 v2AYF/f9zN13lpug3Zw79/X2A6ADhwQDzQpuhwomUDDZ1Zo4TB5BEyOw2AO3uN4VD+6sa
	 mlNfpnDjgTtMQzJSMUmsrOWEc9w+nu2iJGjSsUEMnHARB/kFD1O0gzFUjkCk+Gieqyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=U14kuxvH;
	arc=none smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA6C606A31A
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 21:35:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BA6C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=U14kuxvH
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-84e513874f8so59526a34.2
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 14:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792618526; x=1793223326; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pLEuAz/QbPTYBdHooVKnI0+3sIAEAA6ML+6W1W/5CB0=;
        b=U14kuxvHthUUXeLKsm442QvTVOhksZbAd04e3gm+SyZR6TTBX7600fWRCNNyVBj/Dt
         /SZnmhwcZiO68md8BiMrobKsuQnvIlF4wv/SINrUcHwSlYY6ik+0cJ7NNVSZHI3qebRx
         9WMfO8fh5JY2j+MaoNmM/q50k2qd/EHnGiZc8SPwu15qjd0+4IeNl/JS61+C/fzItxBv
         G9pPbO5UZUAs/7Z8SX2RfMfutSqpDg/mW+8edbYMGCoiVvR68U8a92ASDx7ItlXSBjjy
         EEsaL6Lk3Yv2SWRLeEJkL3anfcN9UbJzhga3AAZpTO1bh2Jl661DsUUeVl6yek9eMoot
         nOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792618526; x=1793223326;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pLEuAz/QbPTYBdHooVKnI0+3sIAEAA6ML+6W1W/5CB0=;
        b=DbVe0kddSMHB9M/XkUVJ6xvhzhQwgqdNwYbF7ArQl1MYUDi+8hrU1QlMGv3wNeLjTR
         ykHKYvId6ZXgW3rJTtnaPpeKX4/IOEz+OXyoIUMmLI7sg/ICLSPUlG93Sdl04RnFIDi/
         xyvDUzVQ0eUXpdGOsmfWuBvmycd+wVaLz479JDsTS67mgZf6DvI+yg7YRSzaCo6EByZS
         QNI4i0ndZQioUuLtcX0KzuvXtmCG4yd0tUWIeY/ZaF5Y8/uXGSFZDl5G2rFB8ItyGIA1
         ux3EB/xVYSyLCTGdSkk3mV8A7VGBndyMq8jjOQfsnKFn9ZKqC35H6vx8/tpcZEgHRV/h
         /ndw==
X-Gm-Message-State: AFq9FYLPAZOPSQ9j8uG7Gzk006Bi7RbsfiP8tPUy1nTrTJJhIUvGnf5a
	TPUGJATc+3MJ3yHUuZrg8k34DirqxRqhAjmNTreARbAJvV9ycXcjFlBM8Uftcw==
X-Gm-Gg: AYBFou2gMM108O772G0PFWn3Zq8a+KODcP2Mb+wWT+f7m+6J9hvi4BwJKovzeMn5Iqg
	GMrWqIOxP2zC9dlXNIB0s9WM7Az3oD6tOk2HNIQowiOTtm6cyZuEaZU1mZgafANx//bBXA0Tnvf
	AO/CjlGLqpUhkWrREU9yBJZTlulAA9XRwNqjHuT9pz/hiD6dzN+jIU+3l/UJWGtJjPsnBrovWQq
	oDQVe9WWf9tyrIwBHMf3FPsxlTrNbuP3lY+b4X4yEcTnVZ2SPEJcUlIMMop8ZfW7gri/lxlCTTX
	bVRRcbzlJs3IB+aUGZzASxxtquRCHNpOZ0P0+re72l4sgbPO1BsMO6bTyOGtCXr1U+3234V0BmM
	zkmXF1T+3auSaC+bnaGdE6zKGqdpq6mcKsWD4AYQ01fL13Q/azmP4+lDZIBui80Tpysat/6LuOR
	6FPtyQbJQ/CiSPOmrEsXoKxNzBjZnjzXSfo6InxwvbGqUBE4pNKTV09fpZo6oHQJDgkOfZ0I+bz
	2VI2Owlp+1UeNOSn/brXYCAkyuer3U1JcqEH+j86Bx0zR6rKC91Sr7mOMQ=
X-Received: by 2002:a05:6808:1817:b0:4cb:f21b:6f8e with SMTP id 5614622812f47-5535a28b85amr2288941b6e.33.1792618526388;
        Wed, 21 Oct 2026 14:35:26 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.201.57])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-552b5b2b254sm2845972b6e.10.2026.10.21.14.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 14:35:25 -0700 (PDT)
Message-Id: <4d2cbaf17032a60aac15c081303f13e1d8eb87e5.1792618518.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2268.v2.git.1792618518.gitgitgadget@gmail.com>
References: <pull.2268.git.1792458904027.gitgitgadget@gmail.com>
	<pull.2268.v2.git.1792618518.gitgitgadget@gmail.com>
From: "tsukasa inoue via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 Oct 2026 21:35:17 +0000
Subject: [PATCH v2 2/3] branch: return an error from setup_tracking()
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    tsukasa-ino <inoue.tsukasa.4@gmail.com>,
    tsukasa inoue <inoue.tsukasa.4@gmail.com>

From: tsukasa inoue <inoue.tsukasa.4@gmail.com>

setup_tracking() calls exit(1) when it cannot write the tracking
configuration. This exit was introduced in 27852b2c53 (branch: report
errors in tracking branch setup, 2016-02-22). Because of it, callers
cannot continue after a tracking failure, even though the ref has
already been created.

Change setup_tracking() to return an error instead of exiting, and make
create_branch() and dwim_and_setup_tracking() return that value too.

This does not change behavior. Callers still exit with status 1 on
failure, as before. Changing checkout

Signed-off-by: tsukasa inoue <inoue.tsukasa.4@gmail.com>
---
 branch.c           | 35 +++++++++++++++++++++--------------
 branch.h           | 21 +++++++++++++--------
 builtin/branch.c   | 17 ++++++++++++-----
 builtin/checkout.c | 17 +++++++++--------
 4 files changed, 55 insertions(+), 35 deletions(-)

diff --git a/branch.c b/branch.c
index bb07846911..7876892cc5 100644
--- a/branch.c
+++ b/branch.c
@@ -251,12 +251,13 @@ static int inherit_tracking(struct tracking *tracking, const char *orig_ref)
  * will not be expanded to "refs/remotes/origin/main", so it is not safe
  * for 'orig_ref' to be raw user input.
  */
-static void setup_tracking(const char *new_ref, const char *orig_ref,
-			   enum branch_track track, int quiet)
+static int setup_tracking(const char *new_ref, const char *orig_ref,
+			  enum branch_track track, int quiet)
 {
 	struct tracking tracking;
 	struct string_list tracking_srcs = STRING_LIST_INIT_DUP;
 	int config_flags = quiet ? 0 : BRANCH_CONFIG_VERBOSE;
+	int ret = 0;
 	struct find_tracked_branch_cb ftb_cb = {
 		.tracking = &tracking,
 		.ambiguous_remotes = STRING_LIST_INIT_DUP,
@@ -345,11 +346,12 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 		string_list_append(tracking.srcs, orig_ref);
 	if (install_branch_config_multiple_remotes(config_flags, new_ref,
 				tracking.remote, tracking.srcs) < 0)
-		exit(1);
+		ret = -1;
 
 cleanup:
 	string_list_clear(&tracking_srcs, 0);
 	string_list_clear(&ftb_cb.ambiguous_remotes, 0);
+	return ret;
 }
 
 int read_branch_desc(struct strbuf *buf, const char *branch_name)
@@ -629,10 +631,10 @@ static void dwim_branch_start(struct repository *r, const char *start_name,
 	FREE_AND_NULL(real_ref);
 }
 
-void create_branch(struct repository *r,
-		   const char *name, const char *start_name,
-		   int force, int clobber_head_ok, int reflog,
-		   int quiet, enum branch_track track, int dry_run)
+int create_branch(struct repository *r,
+		  const char *name, const char *start_name,
+		  int force, int clobber_head_ok, int reflog,
+		  int quiet, enum branch_track track, int dry_run)
 {
 	struct object_id oid;
 	char *real_ref;
@@ -641,6 +643,7 @@ void create_branch(struct repository *r,
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
 	int flags = 0;
+	int ret = 0;
 	char *msg;
 
 	if (track == BRANCH_TRACK_OVERRIDE)
@@ -678,21 +681,25 @@ void create_branch(struct repository *r,
 	free(msg);
 
 	if (real_ref && track)
-		setup_tracking(ref.buf + 11, real_ref, track, quiet);
+		ret = setup_tracking(ref.buf + 11, real_ref, track, quiet);
 
 cleanup:
 	strbuf_release(&ref);
 	free(real_ref);
+	return ret;
 }
 
-void dwim_and_setup_tracking(struct repository *r, const char *new_ref,
-			     const char *orig_ref, enum branch_track track,
-			     int quiet)
+int dwim_and_setup_tracking(struct repository *r, const char *new_ref,
+			    const char *orig_ref, enum branch_track track,
+			    int quiet)
 {
 	char *real_orig_ref = NULL;
+	int ret;
+
 	dwim_branch_start(r, orig_ref, track, &real_orig_ref, NULL);
-	setup_tracking(new_ref, real_orig_ref, track, quiet);
+	ret = setup_tracking(new_ref, real_orig_ref, track, quiet);
 	free(real_orig_ref);
+	return ret;
 }
 
 /**
@@ -842,8 +849,8 @@ void create_branches_recursively(struct repository *r, const char *name,
 	 * tedious to determine whether or not tracking was set up in the
 	 * superproject.
 	 */
-	if (track)
-		setup_tracking(name, tracking_name, track, quiet);
+	if (track && setup_tracking(name, tracking_name, track, quiet))
+		exit(1);
 
 	for (i = 0; i < submodule_entry_list.entry_nr; i++) {
 		if (submodule_create_branch(
diff --git a/branch.h b/branch.h
index e9b1f7b37d..4bc4527284 100644
--- a/branch.h
+++ b/branch.h
@@ -34,10 +34,13 @@ enum branch_track {
  *     causes new_ref to track whatever orig_ref tracks.
  *
  *   - quiet suppresses tracking information.
+ *
+ * Returns 0 on success, or -1 if the tracking configuration could not be
+ * written.
  */
-void dwim_and_setup_tracking(struct repository *r, const char *new_ref,
-			     const char *orig_ref, enum branch_track track,
-			     int quiet);
+int dwim_and_setup_tracking(struct repository *r, const char *new_ref,
+			    const char *orig_ref, enum branch_track track,
+			    int quiet);
 
 /*
  * Creates a new branch, where:
@@ -63,12 +66,14 @@ void dwim_and_setup_tracking(struct repository *r, const char *new_ref,
  *
  *   - dry_run causes the branch to be validated but not created.
  *
+ * Returns 0 on success, or -1 if the tracking configuration could not be
+ * written.
  */
-void create_branch(struct repository *r,
-		   const char *name, const char *start_name,
-		   int force, int clobber_head_ok,
-		   int reflog, int quiet, enum branch_track track,
-		   int dry_run);
+int create_branch(struct repository *r,
+		  const char *name, const char *start_name,
+		  int force, int clobber_head_ok,
+		  int reflog, int quiet, enum branch_track track,
+		  int dry_run);
 
 /*
  * Creates a new branch in a repository and its submodules (and its
diff --git a/builtin/branch.c b/builtin/branch.c
index a613148fc7..b536b619bb 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -1253,9 +1253,13 @@ int cmd_branch(int argc,
 			die(_("branch '%s' does not exist"), branch->name);
 		}
 
-		dwim_and_setup_tracking(the_repository, branch->name,
-					new_upstream, BRANCH_TRACK_OVERRIDE,
-					quiet);
+		if (dwim_and_setup_tracking(the_repository, branch->name,
+					    new_upstream, BRANCH_TRACK_OVERRIDE,
+					    quiet)) {
+			strbuf_release(&buf);
+			ret = 1;
+			goto out;
+		}
 		strbuf_release(&buf);
 	} else if (unset_upstream) {
 		struct branch *branch;
@@ -1305,8 +1309,11 @@ int cmd_branch(int argc,
 			ret = 0;
 			goto out;
 		}
-		create_branch(the_repository, branch_name, start_name, force, 0,
-			      reflog, quiet, track, 0);
+		if (create_branch(the_repository, branch_name, start_name,
+				  force, 0, reflog, quiet, track, 0)) {
+			ret = 1;
+			goto out;
+		}
 	} else
 		usage_with_options(builtin_branch_usage, options);
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index c0f0d2c700..87e067b45b 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -979,14 +979,15 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 			free(refname);
 		}
 		else
-			create_branch(the_repository,
-				      opts->new_branch, new_branch_info->name,
-				      opts->new_branch_force ? 1 : 0,
-				      opts->new_branch_force ? 1 : 0,
-				      opts->new_branch_log,
-				      opts->quiet,
-				      opts->track,
-				      0);
+			if (create_branch(the_repository,
+					  opts->new_branch, new_branch_info->name,
+					  opts->new_branch_force ? 1 : 0,
+					  opts->new_branch_force ? 1 : 0,
+					  opts->new_branch_log,
+					  opts->quiet,
+					  opts->track,
+					  0))
+				exit(1);
 		free(new_branch_info->name);
 		free(new_branch_info->refname);
 		new_branch_info->name = xstrdup(opts->new_branch);
-- 
gitgitgadget

