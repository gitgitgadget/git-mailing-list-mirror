Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CF73E7165
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 16:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782404346; cv=none; b=iv5UoacwI6hxK/DZ/bZjbdhcT3BDV4/Gi46mBrKDeaO8IiSGsIE5+gwwTPGI/Axz2T2yRC3fxovSFKebGQsbzkTKCN5zSxfi4GDgkAAxR6G3NIa0Zn6Y5taCbX7SVOZ98XMr2e1QO3gM0KLYmacAlySyGfTSQzyty47X8kuvauM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782404346; c=relaxed/simple;
	bh=jRU452HOaBxxqnLVyJz5RCGUGIpT+I1BEG6//LyxiLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HxErR94WSUC8Gf233aJ9dtNL2C9MfjdKQKJHpzchFLZkcKALojKIzJLujSkb89C0AIlgD1/nk3xfHrlR25q4jegjGg5Tdm7JgmKgjoa3qbmxRwRvEVk+xFT3wof0svk+S/PeWhEt2x8FX8ddJgFOVBSHSy9349qcZ0TASEy9u64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=rg2JVU89; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=WMVGx+oz; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="rg2JVU89";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="WMVGx+oz"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=rg2JVU89oUgRCKEzwtIlOlLXWWtOpBXANP/BGZZLG7W8IFEKAKfJlhvwRKelc+y+UO4D3Id7oP7IbWmx/HgoGUhUB1PLhlXUvdQMkfL6sw1Z6IRxiLAm4CqJqOv44oudJMk/9seLS1yUnsFe8swWaT3uJFrdWmfoPC9liLby0rn05nyihbBt2pUWNy81sfSYUlmYoAv1DsOavXUQoJy8UMo7ASbzvt+oYu5/9bFOWID/VG3ulLi+kQqlO6MaKJUVvkNvBKud+9c2iMQS8tNdwlZvK+x1YXfrABZjSlLkyQC3KIXnlMPB3MGHkv+JCaylD85mDel+2T1EqjcxBO/Zvw==; s=purelymail2; d=malon.dev; v=1; bh=jRU452HOaBxxqnLVyJz5RCGUGIpT+I1BEG6//LyxiLk=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=WMVGx+ozuex1KkkqnKr8eMTHBtVURFZzO0u0WzNk27tnNx1GA4IU4itWptTFur79ijbBvFOQ6JVHSrWqqtb8s7qlDtOSrSleej/a2o1bVswdwh5z1rnTNmBbqLBKM3vu8T5CZaUC3jXbYoNxfRtScEIzGtM67pgWPdzspa62O2zUvnIinw7Yfi98lYcOD87KH6wzB1otLsD95qQLT7cKdXlj3AN34+WbI/tW6zV5UbDyJJCVfufzbiW7SvgxVYfILsLuZ3oexd1EQinhgVZkhdGJvSdJuGlWlMhqlgDYnzIQBh0N9ba2zx40DIgOjNDLUk65CuWI14+3fSPlbdn+/Q==; s=purelymail2; d=purelymail.com; v=1; bh=jRU452HOaBxxqnLVyJz5RCGUGIpT+I1BEG6//LyxiLk=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -612697585;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 25 Jun 2026 16:19:03 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: cirnovskyv@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v1 2/2] environment: move excludes_file into repo_config_values
Date: Fri, 26 Jun 2026 00:18:45 +0800
Message-ID: <20260625161845.7543-3-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625161845.7543-1-cat@malon.dev>
References: <20260625161845.7543-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Continue the libification effor by moving the 'excludes_file' global
variable into 'struct repo_config_values'.

Since 'excludes_file' is a dynamically allocated string (char *), it
requires proper memory management. Introduce repo_config_values_clear()
to safely free the heap memory when repository instance is destroyed.

Note: 'if (repo !=3D the_repository)' fallback logic is temporarily added
in both the getter and the clear function. This prevents calling
repo_config_values() on uninitialized submodules, which triggers BUG().

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 environment.c | 28 ++++++++++++++++++++++------
 environment.h | 15 +++++++++++----
 repository.c  |  1 +
 3 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/environment.c b/environment.c
index 8efcaeafa6..e1c7ed178a 100644
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
@@ -733,3 +736,16 @@ void repo_config_values_init(struct repo_config_values=
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
+=09FREE_AND_NULL(cfg->excludes_file);
+}
diff --git a/environment.h b/environment.h
index 52d531e4ea..2839913551 100644
--- a/environment.h
+++ b/environment.h
@@ -98,6 +98,7 @@ struct repo_config_values {
 =09int precomposed_unicode;
 =09int core_sparse_checkout_cone;
 =09int warn_on_object_refname_ambiguity;
+=09char *excludes_file;
=20
 =09/* section "sparse" config values */
 =09int sparse_expect_files_outside_of_patterns;
@@ -133,13 +134,20 @@ int git_default_config(const char *, const char *,
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
+ * Note: `excludes_file` is currently the only heap-allocated field in
+ * this struct. As other dynamically allocated variables are migrated,
+ * their FREE_AND_NULL() calls should be appended here.
+ */
+void repo_config_values_clear(struct repository *repo);
+
 /*
  * TODO: All the below state either explicitly or implicitly relies on
  * `the_repository`. We should eventually get rid of these and make the
@@ -213,7 +221,6 @@ extern char *git_log_output_encoding;
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

