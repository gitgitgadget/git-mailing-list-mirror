Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660AB379C5F
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 14:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347963; cv=none; b=i4c6bnmWAnv0jaR1Pj7bv2gj40DqrJSGVI5bTi34olb0dovOB9FGo0/U+ATTt0Wlft2HVKcTPK9wXDsoMIe9HIPFPiMAQnZaj8WGHKdqR137S4Q9dlQKd49Gp1v8ZrSXcBGL4hNjJRkjs1PNTC3DPqWnXUG9N/cpw9tC+CpilWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347963; c=relaxed/simple;
	bh=NnKM/xeaUHlX759Ewg0zSxvU0e4ZZqvAcStzYuWUBd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B9bMA7+8ROgfi1AYHyb3zW8B4SVK8xuwKgw80eYYxS/Rb8gwLSgZ1JNROAOzVlyg5QhXWeb4OPedqbve3qqAQ7kEjXE9VuxKj6mIlN2o9IQE5HVGrWp8YefSSinsk6w3BVEdX4E743AJHyjxeQCw5ATu+AFfCWPtCLitAkX+b3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=rLuO47I3; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=VCPfmLkS; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="rLuO47I3";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="VCPfmLkS"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=rLuO47I37ZO6nmBXEcA9dY0LuGkm5Z477uURMTaEIuS36/4/v5h+rkhj8dMbY1e1Gwhj8eIJTk7s6B+qWxq0dgQbsKEYhw9Uh9MVk3Zo6lLv7Bvb/TdRpTj+YwXyLzKsAKvGO7bFayavqNV0pJulDbkwhTDhS6AjnsFOBCq/BoiYO7THuHmIu3chKpG0suX72GLsqt9pDc3s+pSRchL+DwD89kKv3fGlu72tWys6KsGkTwZHoHXsxxQy+Yrg5fewVQmJyxLVH+7IHsgRRDXVWsy9u7IwGFSEmgELp2n3D2SecIWuXRTwsv9yuqRDPF80N61LcnTTiNpWpA0ORDpiog==; s=purelymail3; d=malon.dev; v=1; bh=NnKM/xeaUHlX759Ewg0zSxvU0e4ZZqvAcStzYuWUBd8=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=VCPfmLkS0nw3eGV3NtVyXiSuqCu+VF0E/8rY02i0c781/WuBLCaXh/f2N0i04bwv7q+IjrBfrnLvBAUdNcRX3p/BtFsGALQSiYTgKMl/jkuA1eKmKuD5HP8Js5SOY/KSz0SkE9JTyRIoeznwPDzHe/s7uTB+MU4REMHNgXkqXVKRLLX6LqOpG7ASujuh70tIKKD9mnft3HF6WojZywsxVhAyKXfYFJzse8Dz2huihU7v1pibQlpAhwvawICYR8IXMqEFfgi75iSeUfQswziNe7kNxcLeKtF1hq3wX7vHzTpksaOSV3xkz61mmaO1Agf3KJTzuR4IovfJRZfHTqyTYg==; s=purelymail3; d=purelymail.com; v=1; bh=NnKM/xeaUHlX759Ewg0zSxvU0e4ZZqvAcStzYuWUBd8=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1851978137;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 06 Jul 2026 14:26:00 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v7 2/9] environment: move excludes_file into repo_config_values
Date: Mon,  6 Jul 2026 22:25:23 +0800
Message-ID: <20260706142530.3681520-3-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706142530.3681520-1-cat@malon.dev>
References: <20260701180813.776173-1-cat@malon.dev>
 <20260706142530.3681520-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

The global variable 'excludes_file' is used to track the path to the
global ignore file. If this variable is NULL,
'setup_standard_excludes()'
in 'dir.c' forcefully evaluates and assigns the XDG default path to it.

Continue the libification effort by encapsulating this lazy-loading
fallback logic into a proper getter and moving the variable into
'struct repo_config_values'.

Since 'excludes_file' is a dynamically allocated string, it requires
proper heap memory management. It is safely freed using the newly
introduced `repo_config_values_clear()` function when the repository
is torn down.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 dir.c         |  4 ++--
 environment.c | 15 ++++++++++++---
 environment.h |  4 +++-
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/dir.c b/dir.c
index 7a73690fbc..4f87a52b3c 100644
--- a/dir.c
+++ b/dir.c
@@ -3481,11 +3481,11 @@ static GIT_PATH_FUNC(git_path_info_exclude, "info/e=
xclude")
=20
 void setup_standard_excludes(struct dir_struct *dir)
 {
+=09const char *excludes_file =3D repo_excludes_file(the_repository);
+
 =09dir->exclude_per_dir =3D ".gitignore";
=20
 =09/* core.excludesfile defaulting to $XDG_CONFIG_HOME/git/ignore */
-=09if (!excludes_file)
-=09=09excludes_file =3D xdg_config_home("ignore");
 =09if (excludes_file && !access_or_warn(excludes_file, R_OK, 0))
 =09=09add_patterns_from_file_1(dir, excludes_file,
 =09=09=09=09=09 dir->untracked ? &dir->internal.ss_excludes_file : NULL);
diff --git a/environment.c b/environment.c
index 13677484de..5950592d63 100644
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
@@ -134,6 +133,14 @@ int is_bare_repository(void)
 =09return is_bare_repository_cfg && !repo_get_work_tree(the_repository);
 }
=20
+const char *repo_excludes_file(struct repository *repo)
+{
+=09if (!repo_config_values(repo)->excludes_file)
+=09=09repo_config_values(repo)->excludes_file =3D xdg_config_home("ignore"=
);
+
+=09return repo_config_values(repo)->excludes_file;
+}
+
 int have_git_dir(void)
 {
 =09return startup_info->have_repository
@@ -461,8 +468,8 @@ int git_default_core_config(const char *var, const char=
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
@@ -715,6 +722,7 @@ int git_default_config(const char *var, const char *val=
ue,
 void repo_config_values_init(struct repo_config_values *cfg)
 {
 =09cfg->attributes_file =3D NULL;
+=09cfg->excludes_file =3D NULL;
 =09cfg->apply_sparse_checkout =3D 0;
 =09cfg->branch_track =3D BRANCH_TRACK_REMOTE;
 =09cfg->trust_ctime =3D 1;
@@ -744,4 +752,5 @@ void repo_config_values_clear(struct repository *repo)
 =09cfg =3D repo_config_values(repo);
=20
 =09FREE_AND_NULL(cfg->attributes_file);
+=09FREE_AND_NULL(cfg->excludes_file);
 }
diff --git a/environment.h b/environment.h
index c4a6a45704..2e8352de7f 100644
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
@@ -133,6 +134,8 @@ int git_default_config(const char *, const char *,
 int git_default_core_config(const char *var, const char *value,
 =09=09=09    const struct config_context *ctx, void *cb);
=20
+const char *repo_excludes_file(struct repository *repo);
+
 void repo_config_values_init(struct repo_config_values *cfg);
=20
 /*
@@ -217,7 +220,6 @@ extern char *git_log_output_encoding;
=20
 extern char *editor_program;
 extern char *askpass_program;
-extern char *excludes_file;
=20
 /*
  * The character that begins a commented line in user-editable file
--=20
2.43.0

