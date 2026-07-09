Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3588432BC7
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 16:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783613533; cv=none; b=SthO+s/aOOPq56wDZosTH1RLn1NbKXKLRS7qOQ9Erjms6Uu33kCnP/YMbeITg98gDMoX1nB9EnJXGT8tZY+F+gYtzBFU79bULWX0Jv7Ec9auZo/CTDmHddsHDt79cUh9MHCQH05vRTzdu6VbYN6Winyp4gImD26ZL+A1elJFErA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783613533; c=relaxed/simple;
	bh=NnKM/xeaUHlX759Ewg0zSxvU0e4ZZqvAcStzYuWUBd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=feyiMxCwh1/2SBUl78JL5Z8GZ2Bp/DWKmJVTAKZ2frgaIVkxDI7mVPSxQIPu+dUa2JCUf5TXhIwNgHBLZzoFh/XvH/rTGVVbe2B+k2PzbgWwZpRECcsYjH6aGT7Au1G6H+QHReScsXypoNlCKzECdWVttzIKwCdV/cJs4InAHX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=LxNqGyHX; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=Mm578Fxk; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="LxNqGyHX";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="Mm578Fxk"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=LxNqGyHXl3UW0iQ1b5dBZO6LQOoQy4mIWNhr0Y8JMV2e33egLl3K8vu4c0zsSSaeDUNKnYV86sUNU66G2Xc+Zu1Jt3NV16cgD+7mpU0SGbJBGj4boCz13CAHk0U6VcszGKJCQBr6rXijhPoDCTDaJP6mnsaxV/VcfW81nP4nW3uaa6P3Ygk4OZFR8/9YbOCrv7GP8Y4WvJ9B+2wGwlZJpV6Ier6RoigXXjQswlAhT1rWOZVK5iH/fEqsyI2sxxfOTDwV5NFx/SAR395k/ISY+BNyH5fsw/6nSR1g0YkR1BoD6Pi3PZW5dyag7ys+En84X52WrPuoQyXW8+gqslJ7OQ==; s=purelymail1; d=malon.dev; v=1; bh=NnKM/xeaUHlX759Ewg0zSxvU0e4ZZqvAcStzYuWUBd8=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=Mm578Fxk/ugfMFkMQx+VTUe8u6Q6Dki+B4oYbVtvJB6ottg52fkryfEOyalTHwqBXcpAXztN1u6qGbz6hqzz5g5krfvuRDNlPys2supQ03b8NOwru+dJrJ0VwBPxBmVwdpswKp1F+dOXneGabWlvU2N4/6ZX9wlObHLaDQZgez2yZ6YpxXysohd3YqBPXr0UsT+2/lcmiYvLURKxmiucL/cTWiYGJKuin8uTU6A0O7dvd0SMFvGaTF4jXyEpWmggeDNW/txANWQEJJ3HhT+mmx8QI+9PeTs4WgobWeDf9QNIWJv57QANUa7SyTyslWzJbUAUGvc+yq5dPWFzlZA1sw==; s=purelymail1; d=purelymail.com; v=1; bh=NnKM/xeaUHlX759Ewg0zSxvU0e4ZZqvAcStzYuWUBd8=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 872182701;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 09 Jul 2026 16:12:10 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v9 2/9] environment: move excludes_file into repo_config_values
Date: Fri, 10 Jul 2026 00:11:38 +0800
Message-ID: <20260709161145.13349-3-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709161145.13349-1-cat@malon.dev>
References: <20260708160300.8852-1-cat@malon.dev>
 <20260709161145.13349-1-cat@malon.dev>
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

