Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792637503;
	b=sVxlHLPalR4f6edp0She6SG9EB66oCElfczW23COiXKbV9bhtnB41WrpOiVmfuwkJt1J
	 EoF9Qrm+3IfH9UTVdbfNmTGUyAF9K+1v4j5Aop16MFCUQVAwFjb7r4gCvyx/tZ+b3xUZL
	 2ZDva1qkDVmfVoEk0Oi3hIowwxW9cr1+aenHoye5nS0M3q8mIJvKix0qX9UgAAt1pGZRf
	 NMRkKaHiD4Ip3L80lsDHtSmllPL7GtmbSKhxvnHpq6Kk2iJJHcwQGZ3OWAsdJXuTBNAVr
	 0ksSoH5ViKMGzGbyLuiH3/rZvcLSCMi0Eylmi9PnKroZsEQw6wDLG1Uodkc5wseco9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792637503;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=lP5D6jy+M4s0RsZwh0bNAZ+RnkcuYcW0Y96faUPCWSg=;
	b=0pQKmMUkP1tptprVlNpX+cuvsTIywekQdNC/7SSL2+K4Qhijm9EsrA7NmTInvkfwSy9C
	 bXG9WiKtf7VTZndycwuJdqDwUTtBM16Vh928U+OCcottRCvMnB/Xx6l3Ke5gahP00iHtf
	 1w54w95/WADuKKEBEgcicmXj3YBm1yHgtAcCrRu3NWUkyd7BH7I4qYjew3H9iQSUzvVb0
	 /B2sk7x1AoI5Z0GXOjrni4IkPQtCGPHlfqrTFMFvHsrp77bA1uqReI6CzlyayE4SuPm0y
	 fbCcRbQvaNMrm9MJIjxXUkNFa3zR1ftUlYRop6Oc4W/udqVFpQZrOHgXd/WOflg747w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OtzKuK2e;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3128F606A328
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 02:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3128F606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OtzKuK2e
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a06e79e152so604987b3a.0
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 19:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792637502; x=1793242302; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lP5D6jy+M4s0RsZwh0bNAZ+RnkcuYcW0Y96faUPCWSg=;
        b=OtzKuK2eUNUwkcQzrMNiFyQMV64MkvQoLV3usErAU/7W7mo9WCDRDXtsy8xXx72S94
         R6ZITmNKUwTgprIMc5SVLvYXWc2NgJm5ygUzz86dxwEdVnhhmF5AoE7jxZg144L+RLmW
         lbyhqcBSnIxwCp+fDIJxE7K5ext6FlQr0CYmva61XS+NFD48bXp7Ol3y6c9jym+mycC3
         HSqwSxWu+cuTzYh1vpDTEFNz3cFcbid5eS0noNCJQv/JBBNQtYJlcaRFZBrXL/4fbucV
         S1V19Ry9TBHt2Fsk8sAHfsS6YHrXppBar/tnwYueZtyt/adlUN8iIGmDIfgKF8FPWyBe
         vMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792637502; x=1793242302;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lP5D6jy+M4s0RsZwh0bNAZ+RnkcuYcW0Y96faUPCWSg=;
        b=seZaxNYxgwZFvYLfTjhOfWVNE05OlilN42mgvpp3wRMPhePm5j14Ykjq8l+yEnLYOQ
         oGN4hLnKqHYcEvcOcuBj80Tua66GD1v5LU8y/7K8lwP9bcxc3Z+cm61rrdeeT6pY4+aJ
         h0Yl3vlMFA/Yg0QdGV3VV74rVfKqiN0wISNrTM/5epidJFLpFEpyR8IHD6s3t8javRF3
         pE4I+0Hthm2F6+0mNBPH0ajAl93pUckLXK/5Y/Pt17Z1ksnodzr3mfWpTEmaBZDYDoPK
         FJzBC+XgS7OOVmSvI3aO3xT591YN44+ntgj4BLkQyZGNXa3UxYTOGXDadF73NTPTC7Xb
         t6ZQ==
X-Gm-Message-State: AFq9FYKISCr2272v1qumzDxDEj6Yx1QjQv5tpAbjscQsv3vuAjnNr+ny
	wTyb0ABE1Hzu7u7nt5/F8eOKCY61AHDtBpC7rq7PVj+IpDN6at7Di+32hw8GfA==
X-Gm-Gg: AYBFou0lHi3YEp8u0V3gIcfHbQJCy8xEFnBBk6JKZPpB9z/FGCJ8qKB0sTVsKCLRKHM
	NMGUIQBsVU6e+gIcICvf4tzNC8BJnCtuJ/WS4IAjtMz678gVgsE0+bIS0d+t8XFLGyBncTdKg3e
	TneQnpqBQQmSqoMkAGbtXs+XYaUEczUhavz6bVuV4gYsBaYkXVR7wYUb7lbcqdFnylPm/e2O4Dn
	wrqgKz/58SQrzkUpNBa8Ghb+bdGPaZ4zhml0zJmaI4KDqOCiecmItyt1760N2eUvQRqLHQQI0bI
	Fc/bjFqdQqp87uMBzIMCSHqVys1DpMB5a6UfGyh6WKyDPi66xQKwK0Q9Xg4RC8GJWuhuqLblGya
	Cs+vkwQWBb8//T0aBw+daGDnV/V1GdIK4XhfjJzYoE5vCyOVhHIiCtS0n+f73RGyIXBNQbEeyu3
	aUZGGXkKHD4NXh0leoAy3hxVWGj4/Ust3m/hmEbkJ+9CXMAGBPeM2O09D6wxQ7EeNHR+vtDaCpy
	boZ/WKNWaIaAVq7hV/sotCkUmLABFtlEI3mZ+Ztq5JruGDpwieLtDHOkw==
X-Received: by 2002:a05:6a00:e17:b0:8a0:3172:bd86 with SMTP id d2e1a72fcca58-8a089f2736dmr2839835b3a.14.1792637502522;
        Wed, 21 Oct 2026 19:51:42 -0700 (PDT)
Received: from [127.0.0.1] ([52.157.2.246])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0895e9c33sm1422845b3a.44.2026.10.21.19.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 19:51:40 -0700 (PDT)
Message-Id: <a9865116582860d7d5191af2dcca9e6d742008c4.1792637495.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2275.git.1792637495.gitgitgadget@gmail.com>
References: <pull.2275.git.1792637495.gitgitgadget@gmail.com>
From: "tsukasa inoue via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 22 Oct 2026 02:51:34 +0000
Subject: [PATCH 1/2] branch: return an error from setup_tracking()
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
index 22f4f46b96..27be5ecc3e 100644
--- a/branch.c
+++ b/branch.c
@@ -249,12 +249,13 @@ static int inherit_tracking(struct tracking *tracking, const char *orig_ref)
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
@@ -343,11 +344,12 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
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
@@ -627,10 +629,10 @@ static void dwim_branch_start(struct repository *r, const char *start_name,
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
@@ -639,6 +641,7 @@ void create_branch(struct repository *r,
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
 	int flags = 0;
+	int ret = 0;
 	char *msg;
 
 	if (track == BRANCH_TRACK_OVERRIDE)
@@ -676,21 +679,25 @@ void create_branch(struct repository *r,
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
@@ -840,8 +847,8 @@ void create_branches_recursively(struct repository *r, const char *name,
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
index 2d575a4f57..13a2938b42 100644
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

