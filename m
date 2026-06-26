Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28F73E022D
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 07:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782460260; cv=none; b=RC6z8x4aVvCzwXr2b4i8C6wjdJCC8YtwuZmyfX73uTtFwHV0H0MGvaUnHII5yDuFXfjyTQ4dxEBfu8/fPuyAkIsWH5bltgSUotC2ojkog7bqENomNns+QZLseOrAL0PAqerGFFzNsgYfQhcGJXoXScyTe7bnlnrb1A/OceKSuWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782460260; c=relaxed/simple;
	bh=garNmD6jxHTIXVjhe2Sr9rM+gibtE/zDO9A13itKSLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EEWr1PLkRq3vlmZwsZfjVVYSLSARozkJjeyCrUjXelfHNOLaGhoNHxJ6GyWWH0jySbu6/uB9aUN/owXTRDUa9q9nzenuZzNcaCtcI6MjRvRc2D6nnY5UzGJ55sDbXefJMga3g6QfSCF+Ikq0fwmwUNXa9gIq7GXzCTrwFpy9fEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=UrC6eweX; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=aFfeKFoM; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="UrC6eweX";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="aFfeKFoM"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=UrC6eweXG77nGkyiWNce05MoU3d9Nw+sQ8fECDuaM/Io2OLTQ/4RzMOuHgK2U1/bFCrN9dTgIflsOg+kQbpDSYxNeVWjhQmId3aR2Va92D6QbbI9RAlIsh+ya2GJvTMCvdFfAwvMI3W3YMBv7BpWggt1kuiiD+5b+JPzO5UGhgeR/lpbzR4eMbr/KKV8kAHWNkYRfE8y6WlcdD3WpPHMXQ5mu0MsxjK6J+1YeuIi+2l6itnMSUUvNI1aQAXkysrGPcxxTFeCZvZ/pk0nWQLc7dm9jR8Xax6k9jOSdfksLXtELJOHKart85lj1HOKCM45xqLDNAt0DRSlYrxJSA0msQ==; s=purelymail2; d=malon.dev; v=1; bh=garNmD6jxHTIXVjhe2Sr9rM+gibtE/zDO9A13itKSLM=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=aFfeKFoMMuDnTWSylQ40Tz4i0KyPT0SomASyUZ4JgOZRjURpBn2lnaqY/3NVt9CW8OJLvRGROS7bpZc8TvSM6aLgmfEIKMtFHamQDaPZcVSIbGo4PVP8IF+P5BWMVjTw8OCm9pfw7YVmjymDirIwVCkNvKOlzT8UaPEPxtLAVKSut/EFenvOC2zzkjj/9tgdjjJyJDDSQQqVwstvCGiF1xhkjjrXy41GbhelpnLCkANflBDwNdzVUXcs813a1ECh9Zf612e6oQrqilJb47eo0CLRde1uvdXurwDS+xYi3D+zM7DpbkRm/0OUWF5Vk7PzNOW/vOy/WKGq2JS7juABWA==; s=purelymail2; d=purelymail.com; v=1; bh=garNmD6jxHTIXVjhe2Sr9rM+gibtE/zDO9A13itKSLM=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -72641762;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 26 Jun 2026 07:50:54 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: cirnovskyv@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v2 2/2] environment: move excludes_file into repo_config_values
Date: Fri, 26 Jun 2026 15:50:37 +0800
Message-ID: <20260626075037.532164-3-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626075037.532164-1-cat@malon.dev>
References: <20260626075037.532164-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Continue the libification effort by moving the 'excludes_file' global
variable into 'struct repo_config_values'.

Since 'excludes_file' is a dynamically allocated string (char *), it
requires proper memory management. Introduce repo_config_values_clear()
to safely free the heap memory when repository instance is destroyed.

Note:

 - 'if (repo !=3D the_repository)' fallback logic is temporarily added
in both the getter and the clear function. This prevents calling
repo_config_values() on uninitialized submodules, which triggers BUG().

 - 'attribute_file' is another string variable that was migrated
 earlier. Its FREE_AND_NULL() call is also added to
 repo_config_values_clear().

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 environment.c | 31 +++++++++++++++++++++++++------
 environment.h | 14 ++++++++++----
 repository.c  |  1 +
 3 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/environment.c b/environment.c
index 8efcaeafa6..b8dfa3e213 100644
--- a/environment.c
+++ b/environment.c
@@ -57,7 +57,6 @@ enum fsync_method fsync_method =3D FSYNC_METHOD_DEFAULT;
 enum fsync_component fsync_components =3D FSYNC_COMPONENTS_DEFAULT;
 char *editor_program;
 char *askpass_program;
-char *excludes_file;
 enum auto_crlf auto_crlf =3D AUTO_CRLF_FALSE;
 enum eol core_eol =3D EOL_UNSET;
 int global_conv_flags_eol =3D CONV_EOL_RNDTRP_WARN;
@@ -136,9 +135,13 @@ int is_bare_repository(void)
=20
 const char *repo_excludes_file(struct repository *repo)
 {
-=09if (!excludes_file)
-=09=09excludes_file =3D xdg_config_home("ignore");
-=09return excludes_file;
+=09if (!repo || !repo->initialized || repo !=3D the_repository)
+=09=09return NULL;
+
+=09if (!repo_config_values(repo)->excludes_file)
+=09=09repo_config_values(repo)->excludes_file =3D xdg_config_home("ignore"=
);
+
+=09return repo_config_values(repo)->excludes_file;
 }
=20
 int have_git_dir(void)
@@ -468,8 +471,8 @@ int git_default_core_config(const char *var, const char=
 *value,
 =09}
=20
 =09if (!strcmp(var, "core.excludesfile")) {
-=09=09FREE_AND_NULL(excludes_file);
-=09=09return git_config_pathname(&excludes_file, var, value);
+=09=09FREE_AND_NULL(cfg->excludes_file);
+=09=09return git_config_pathname(&cfg->excludes_file, var, value);
 =09}
=20
 =09if (!strcmp(var, "core.whitespace")) {
@@ -722,6 +725,7 @@ int git_default_config(const char *var, const char *val=
ue,
 void repo_config_values_init(struct repo_config_values *cfg)
 {
 =09cfg->attributes_file =3D NULL;
+=09cfg->excludes_file =3D NULL;
 =09cfg->apply_sparse_checkout =3D 0;
 =09cfg->branch_track =3D BRANCH_TRACK_REMOTE;
 =09cfg->trust_ctime =3D 1;
@@ -733,3 +737,18 @@ void repo_config_values_init(struct repo_config_values=
 *cfg)
 =09cfg->sparse_expect_files_outside_of_patterns =3D 0;
 =09cfg->warn_on_object_refname_ambiguity =3D 1;
 }
+
+void repo_config_values_clear(struct repository *repo)
+{
+=09struct repo_config_values *cfg;
+
+=09if (repo !=3D the_repository)
+=09=09return;
+
+=09cfg =3D repo_config_values(repo);
+=09if (!cfg)
+=09=09return;
+
+=09FREE_AND_NULL(cfg->attributes_file);
+=09FREE_AND_NULL(cfg->excludes_file);
+}
diff --git a/environment.h b/environment.h
index 52d531e4ea..2e8352de7f 100644
--- a/environment.h
+++ b/environment.h
@@ -90,6 +90,7 @@ struct repository;
 struct repo_config_values {
 =09/* section "core" config values */
 =09char *attributes_file;
+=09char *excludes_file;
 =09int apply_sparse_checkout;
 =09int trust_ctime;
 =09int check_stat;
@@ -133,13 +134,19 @@ int git_default_config(const char *, const char *,
 int git_default_core_config(const char *var, const char *value,
 =09=09=09    const struct config_context *ctx, void *cb);
=20
-/*
- * TODO: This still relies on the global state.
- */
 const char *repo_excludes_file(struct repository *repo);
=20
 void repo_config_values_init(struct repo_config_values *cfg);
=20
+/*
+ * Frees memory allocated for dynamically loaded configuration values
+ * inside `repo_config_values`.
+ *
+ * As dynamically allocated variables are migrated into this struct,
+ * their FREE_AND_NULL() calls should be appended here.
+ */
+void repo_config_values_clear(struct repository *repo);
+
 /*
  * TODO: All the below state either explicitly or implicitly relies on
  * `the_repository`. We should eventually get rid of these and make the
@@ -213,7 +220,6 @@ extern char *git_log_output_encoding;
=20
 extern char *editor_program;
 extern char *askpass_program;
-extern char *excludes_file;
=20
 /*
  * The character that begins a commented line in user-editable file
diff --git a/repository.c b/repository.c
index 187dd471c4..b31f1b7852 100644
--- a/repository.c
+++ b/repository.c
@@ -388,6 +388,7 @@ void repo_clear(struct repository *repo)
 =09FREE_AND_NULL(repo->parsed_objects);
=20
 =09repo_settings_clear(repo);
+=09repo_config_values_clear(repo);
=20
 =09if (repo->config) {
 =09=09git_configset_clear(repo->config);
--=20
2.43.0

