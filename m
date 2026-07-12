Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D1B37186A
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 11:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783855076; cv=none; b=ngV5w65e/rAyBl+odGI+eMj2TV1gKvIhPYrfl/3hK628Q7UGnmo14Uma/RsahL8Xh2/xzHB7UuM+LeH1zScpO+Ro3hMywUgXowDZCVHC0H+cQlBr6ZtpUlLKWfTzrkNVOXi5Lzu8A/BMpos8Gy2J8/3Sabdb6ZwMMqSp4ok8eSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783855076; c=relaxed/simple;
	bh=wK5dFsMPTUiUtToAER0ciJXCxED5Rg4PR3EVdbzNRHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aCTIj5kgjhk32If+8joU4juni4x82AelrIohKSczEC0f1fHStuC96jicUnRU5AcGTXz2bodMVjtmTOpDTJ669O3LIU3phLclzRBlZadDZuoRBPk2yyrycDvO7pNhjwBW52QLLGxILdQk0Nh2Z//B+CWaca9g6sbROSmj+44YkLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=Qkmb1cXE; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=g+ywvyEx; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="Qkmb1cXE";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="g+ywvyEx"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=Qkmb1cXEGRiBzAFoExopGhLK43sojhygOcuxNLNoX4A64FNBMathTUoImAi/R/fiAZXgs4q26UKwcBIi7YEjVvphhgiqSr8x6CIya4rYws7xOigV+t3VPcFS+nL5al+ZzZPynEdDQcNlkI6I4Ch1xheT2VZdByhRciJ/KqIBtOgDysM0v/9Y0uVvcevPZFq/CTqG2pPkHATlUseBSxVezKnkt8cLViLd1nhi2tJ+fBE8Cd1w5Jp69qXBUkxgxfOubRuNgojRdxlWKgit66yuA0RNnejjsnnYi21Oveo+dWvSstokyvL6CDPBUWp22UqXvKHUbXSjIbze31TgjF86aw==; s=purelymail1; d=malon.dev; v=1; bh=wK5dFsMPTUiUtToAER0ciJXCxED5Rg4PR3EVdbzNRHc=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=g+ywvyExUNzvHzbQvnkn2ecgzvWRIxJe8LGmEoiduGqOycMXzWz2jThrAp1SlmNMYBKhf9q+pj0eNurZ2A2E1EKbxcp84+iUbVPL/c70mDHd3j1T+l3kVn2K297X7kIWbsHR/ZTfhF5tDjnSPCZfNH6hlW/MyuZ37VT0M0PXaIv6RNE90KUJJBVz7eW0fgtfvobHPJgTaAiGaH7TsiE5KxRHA2B1d/GZqYyX53iyvUE0cxsP1IjYpu19HcMqc665abYlmvF6bYbtw7n/AdVQLhZdtAZi/3Wlrbhg2/V7byZZu98zIZyRB6DKnwrXdvPl8ObWIFzvDppJOC8dcMP06A==; s=purelymail1; d=purelymail.com; v=1; bh=wK5dFsMPTUiUtToAER0ciJXCxED5Rg4PR3EVdbzNRHc=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -46196840;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 12 Jul 2026 11:17:46 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v10 2/9] environment: move excludes_file into repo_config_values
Date: Sun, 12 Jul 2026 19:17:26 +0800
Message-ID: <20260712111734.1073514-3-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260712111734.1073514-1-cat@malon.dev>
References: <20260709161145.13349-1-cat@malon.dev>
 <20260712111734.1073514-1-cat@malon.dev>
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
'setup_standard_excludes()' in 'dir.c' forcefully evaluates and assigns
the XDG default path to it.

Continue the libification effort by encapsulating this lazy-loading
fallback logic into a proper getter and moving the variable into
'struct repo_config_values'.

Since 'excludes_file' is a dynamically allocated string, it requires
proper heap memory management. It is safely freed using the newly
introduced 'repo_config_values_clear()' function when the repository
is torn down.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 dir.c         |  4 ++--
 environment.c | 17 ++++++++++++++---
 environment.h |  4 +++-
 3 files changed, 19 insertions(+), 6 deletions(-)

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
index ae05f16d04..275931c213 100644
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
@@ -134,6 +133,16 @@ int is_bare_repository(void)
 =09return is_bare_repository_cfg && !repo_get_work_tree(the_repository);
 }
=20
+const char *repo_excludes_file(struct repository *repo)
+{
+=09struct repo_config_values *cfg =3D repo_config_values(repo);
+
+=09if (!cfg->excludes_file)
+=09=09cfg->excludes_file =3D xdg_config_home("ignore");
+
+=09return cfg->excludes_file;
+}
+
 int have_git_dir(void)
 {
 =09return startup_info->have_repository
@@ -461,8 +470,8 @@ int git_default_core_config(const char *var, const char=
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
@@ -715,6 +724,7 @@ int git_default_config(const char *var, const char *val=
ue,
 void repo_config_values_init(struct repo_config_values *cfg)
 {
 =09cfg->attributes_file =3D NULL;
+=09cfg->excludes_file =3D NULL;
 =09cfg->apply_sparse_checkout =3D 0;
 =09cfg->branch_track =3D BRANCH_TRACK_REMOTE;
 =09cfg->trust_ctime =3D 1;
@@ -730,4 +740,5 @@ void repo_config_values_init(struct repo_config_values =
*cfg)
 void repo_config_values_clear(struct repo_config_values *cfg)
 {
 =09FREE_AND_NULL(cfg->attributes_file);
+=09FREE_AND_NULL(cfg->excludes_file);
 }
diff --git a/environment.h b/environment.h
index 9169d7f62d..4776ccc657 100644
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

