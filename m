Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9291A3E556D
	for <git@vger.kernel.org>; Mon, 18 May 2026 09:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779096715; cv=none; b=hPGnOwCjlI+WS6AoGBf5f6qNnFXJtg7I5PfPfC65a6dT80hxjxUlxT8irzytLL7GvtBw0e2TNHgsINe6bz6mrjzH5FKRsCwoWxepXd1lREdVCVHvZFqgrgv5IaKQWDY///ngqxuoRhPjAZePd3GuggC4Jip1LAnjoa7GzUCV6FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779096715; c=relaxed/simple;
	bh=MCNpuyvkUSgyKqegzvQLwEiis2HkJHvIdrzIWqC3Cus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OSJ7TOnOLHCgJSFLdM72sfYqa0Twz/4bLcJeSWEa52dgOQjEcFHxA55WE72zDHyFEePt37TuZSlQUEneBtuQw9kVkMG7YG6WAcz/312ewi+rSNoMAg6g0EF6qrdbRajXyTnhcQ2imT+i4+aTRAanYVIGFSFqPM5SuA9oyu+FKHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eM3Q8yqZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qAkd3IGp; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eM3Q8yqZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qAkd3IGp"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id CD4871D000AB;
	Mon, 18 May 2026 05:31:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 18 May 2026 05:31:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779096712;
	 x=1779183112; bh=Fz0/yM4BuD0pqSv5J+mgrPbvhq2FtZKxxIFPYZMC77M=; b=
	eM3Q8yqZPIFzZyWZnSA8GrG639PNwfQpuXtBA1DMnaSDldCNomMzyUarGbZ7bOQ3
	b8P+5KB8FaN6pdAcUWfSSetvpaxS2vUR8D90ARzR6folKF9TjZHcu4TmPH4XhHz1
	Fhsh6RvMoM8YuXqDBWKGNW+zxkCaAq6Umuhu9YLJvQJGODzaAVSLlooJO/FWBp24
	S81HHLWpiFo98LLsXeglKbn5XEfl6rvBgN84dwaYo7uTg6wtqUSfwInm3Hx6AfPK
	UIRo+wm2NzfhKTPoia4879469s0MYP7E7gjcoyxvtQTgzHKd9y4En47Ty9S7cVyU
	+A0TRl4PWP8vgwarbL3ZPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779096712; x=
	1779183112; bh=Fz0/yM4BuD0pqSv5J+mgrPbvhq2FtZKxxIFPYZMC77M=; b=q
	Akd3IGpJwzAVu7+/7VrTZe/IbB092c920M9qY8EP0F3Ux1wQtwH9Yrec0R7ZJZ9I
	xei3fbSaV5+ESdYfnoMcSzdh+rQzvYW69zXwoRmG8b+QrcQVJdspUreV2Nhtxug/
	/V9o/LJkjgcQ+eZM2M/elN3E69bwdcUqwiygIO8rS5sisTPolM/5fAHNO3dtzcna
	rI3A/6RU+B4fU5vqkNAflmF3M45/67E0G0atIWNY4yppzkWbijUHjhRmHWCNMqAf
	ReSpSVD0SEpn4a/QOS8gLxSlH2o6mO2iVOfw+hP3sAvAqcOEwpuKWDRfW//q3EtQ
	dhjADBb+FrJ0RSoP9q4zA==
X-ME-Sender: <xms:iNwKahaax2eSak8NPnG3MBnIwN3p1_yWOwF5JTWRdpAqnx6BX2ZA1w>
    <xme:iNwKavRF4b-UYxK7ejt-6cQQHYkFWV11_HfTXZebvCBL4y73nt5RR58pt3VXfIAJn
    DxImA6hVy0CbrywUUgfqlmlcW4TQIZO6pUq-QmeLMUll03mKW0M1A>
X-ME-Received: <xmr:iNwKasSTxs-TnIlw7qVUUPiVFHFHY4qXL9BIsQdM57TDVYVhwsn8W5r2TvAhf3M3X7zGH38LXV4hBPcAwzdwsEdILA4oDQDIAdKzS0eviw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeekhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfi
    hrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptggrthesmhgrlhhonhdruggvvhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:iNwKarQsoJbTDbAlxX_T9z4339f71XEWzVy9ZdCA-0hbLlYEezDKXA>
    <xmx:iNwKap59Yo0sH3Du5VvmO7ulfkcC6bLAGEWO4Vz_55J2OEhAVcrUew>
    <xmx:iNwKav3Jb4Ubktmj7RbkLPFA5A4NdpOLPc6ajEMVUJ39MVfypoRDeQ>
    <xmx:iNwKasCWhzFOaa2GiIn3SfLbalTscu3zDD_X331qQSVIiQJiQe-Rhg>
    <xmx:iNwKaqivo3Ebcl-rB7AyPP9k8I-Z0hmjDdAn9TbJ0CoO4KGLMRIstvqn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 05:31:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3a453854 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 May 2026 09:31:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 18 May 2026 11:31:09 +0200
Subject: [PATCH v2 18/18] setup: stop using `the_repository` in `init_db()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-pks-setup-wo-the-repository-v2-18-6933c0f1d568@pks.im>
References: <20260518-pks-setup-wo-the-repository-v2-0-6933c0f1d568@pks.im>
In-Reply-To: <20260518-pks-setup-wo-the-repository-v2-0-6933c0f1d568@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Tian Yuchen <cat@malon.dev>
X-Mailer: b4 0.15.2

Stop using `the_repository` in `init_db()` and instead accept
the repository as a parameter. The injection of `the_repository` is thus
bumped one level higher, where callers now pass it in explicitly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c   |  2 +-
 builtin/init-db.c |  2 +-
 setup.c           | 43 ++++++++++++++++++++++---------------------
 setup.h           |  3 ++-
 4 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 53a41629e6..d60d1b60bc 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1186,7 +1186,7 @@ int cmd_clone(int argc,
 	 * repository, and reference backends may persist that information into
 	 * their on-disk data structures.
 	 */
-	init_db(git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN,
+	init_db(the_repository, git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN,
 		ref_storage_format, NULL,
 		do_not_override_repo_unix_permissions, INIT_DB_QUIET | INIT_DB_SKIP_REFDB);
 
diff --git a/builtin/init-db.c b/builtin/init-db.c
index e626b0d8b7..c55517ad94 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -252,7 +252,7 @@ int cmd_init_db(int argc,
 	}
 
 	flags |= INIT_DB_EXIST_OK;
-	ret = init_db(git_dir, real_git_dir, template_dir, hash_algo,
+	ret = init_db(the_repository, git_dir, real_git_dir, template_dir, hash_algo,
 		      ref_storage_format, initial_branch,
 		      init_shared_repository, flags);
 
diff --git a/setup.c b/setup.c
index 9c49319568..6aee839d8c 100644
--- a/setup.c
+++ b/setup.c
@@ -2778,7 +2778,8 @@ static void repository_format_configure(struct repository *repo,
 				    repo_fmt->ref_storage_payload);
 }
 
-int init_db(const char *git_dir, const char *real_git_dir,
+int init_db(struct repository *repo,
+	    const char *git_dir, const char *real_git_dir,
 	    const char *template_dir, int hash,
 	    enum ref_storage_format ref_storage_format,
 	    const char *initial_branch,
@@ -2798,13 +2799,13 @@ int init_db(const char *git_dir, const char *real_git_dir,
 		if (!exist_ok && !stat(real_git_dir, &st))
 			die(_("%s already exists"), real_git_dir);
 
-		set_git_dir(the_repository, real_git_dir, 1);
-		git_dir = repo_get_git_dir(the_repository);
+		set_git_dir(repo, real_git_dir, 1);
+		git_dir = repo_get_git_dir(repo);
 		separate_git_dir(git_dir, original_git_dir);
 	}
 	else {
-		set_git_dir(the_repository, git_dir, 1);
-		git_dir = repo_get_git_dir(the_repository);
+		set_git_dir(repo, git_dir, 1);
+		git_dir = repo_get_git_dir(repo);
 	}
 	startup_info->have_repository = 1;
 
@@ -2814,27 +2815,27 @@ int init_db(const char *git_dir, const char *real_git_dir,
 	 * config file, so this will not fail.  What we are catching
 	 * is an attempt to reinitialize new repository with an old tool.
 	 */
-	check_repository_format(the_repository, &repo_fmt);
+	check_repository_format(repo, &repo_fmt);
 
-	repository_format_configure(the_repository, &repo_fmt, hash, ref_storage_format);
+	repository_format_configure(repo, &repo_fmt, hash, ref_storage_format);
 
 	/*
 	 * Ensure `core.hidedotfiles` is processed. This must happen after we
 	 * have set up the repository format such that we can evaluate
 	 * includeIf conditions correctly in the case of re-initialization.
 	 */
-	repo_config(the_repository, git_default_core_config, NULL);
+	repo_config(repo, git_default_core_config, NULL);
 
-	safe_create_dir(the_repository, git_dir, 0);
+	safe_create_dir(repo, git_dir, 0);
 
-	reinit = create_default_files(the_repository, template_dir, original_git_dir,
+	reinit = create_default_files(repo, template_dir, original_git_dir,
 				      &repo_fmt, init_shared_repository);
 
 	if (!(flags & INIT_DB_SKIP_REFDB))
-		create_reference_database(the_repository, initial_branch, flags & INIT_DB_QUIET);
-	create_object_directory(the_repository);
+		create_reference_database(repo, initial_branch, flags & INIT_DB_QUIET);
+	create_object_directory(repo);
 
-	if (repo_settings_get_shared_repository(the_repository)) {
+	if (repo_settings_get_shared_repository(repo)) {
 		char buf[10];
 		/* We do not spell "group" and such, so that
 		 * the configuration can be read by older version
@@ -2842,29 +2843,29 @@ int init_db(const char *git_dir, const char *real_git_dir,
 		 * and compatibility values for PERM_GROUP and
 		 * PERM_EVERYBODY.
 		 */
-		if (repo_settings_get_shared_repository(the_repository) < 0)
+		if (repo_settings_get_shared_repository(repo) < 0)
 			/* force to the mode value */
-			xsnprintf(buf, sizeof(buf), "0%o", -repo_settings_get_shared_repository(the_repository));
-		else if (repo_settings_get_shared_repository(the_repository) == PERM_GROUP)
+			xsnprintf(buf, sizeof(buf), "0%o", -repo_settings_get_shared_repository(repo));
+		else if (repo_settings_get_shared_repository(repo) == PERM_GROUP)
 			xsnprintf(buf, sizeof(buf), "%d", OLD_PERM_GROUP);
-		else if (repo_settings_get_shared_repository(the_repository) == PERM_EVERYBODY)
+		else if (repo_settings_get_shared_repository(repo) == PERM_EVERYBODY)
 			xsnprintf(buf, sizeof(buf), "%d", OLD_PERM_EVERYBODY);
 		else
 			BUG("invalid value for shared_repository");
-		repo_config_set(the_repository, "core.sharedrepository", buf);
-		repo_config_set(the_repository, "receive.denyNonFastforwards", "true");
+		repo_config_set(repo, "core.sharedrepository", buf);
+		repo_config_set(repo, "receive.denyNonFastforwards", "true");
 	}
 
 	if (!(flags & INIT_DB_QUIET)) {
 		int len = strlen(git_dir);
 
 		if (reinit)
-			printf(repo_settings_get_shared_repository(the_repository)
+			printf(repo_settings_get_shared_repository(repo)
 			       ? _("Reinitialized existing shared Git repository in %s%s\n")
 			       : _("Reinitialized existing Git repository in %s%s\n"),
 			       git_dir, len && git_dir[len-1] != '/' ? "/" : "");
 		else
-			printf(repo_settings_get_shared_repository(the_repository)
+			printf(repo_settings_get_shared_repository(repo)
 			       ? _("Initialized empty shared Git repository in %s%s\n")
 			       : _("Initialized empty Git repository in %s%s\n"),
 			       git_dir, len && git_dir[len-1] != '/' ? "/" : "");
diff --git a/setup.h b/setup.h
index 21737e9bd6..9409326fe4 100644
--- a/setup.h
+++ b/setup.h
@@ -227,7 +227,8 @@ const char *get_template_dir(const char *option_template);
 #define INIT_DB_EXIST_OK   (1 << 1)
 #define INIT_DB_SKIP_REFDB (1 << 2)
 
-int init_db(const char *git_dir, const char *real_git_dir,
+int init_db(struct repository *repo,
+	    const char *git_dir, const char *real_git_dir,
 	    const char *template_dir, int hash_algo,
 	    enum ref_storage_format ref_storage_format,
 	    const char *initial_branch, int init_shared_repository,

-- 
2.54.0.771.g3ed373ac14.dirty

