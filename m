Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FA324E4C4
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 16:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783613537; cv=none; b=FYdkVPH2RMo1AlRhCCXGQQNpo3tpULZn4fa1lW8igCzwFgWIk0wGDN4ga7eKeEQMCFu/Yqu8eO+pMdvA5HgOJsicNbN2w0BwnWjiJJhvkzezCJhf6Ek4d1M1TQXML+11+tEwqy9KXGmEyxxrvP62ms8ivz/0oLsJl81t18F9Lys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783613537; c=relaxed/simple;
	bh=km7IvXDoK+aXXmzuMz/ecALXSGEeLILPZhDw9LKG1pY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nKWOTEHJVzh3F6NUZNLy58Abbmbqet1KrlBv/CvN4CNi1ZQVcVPIwstoys9sdXzbtjAq11lEJXGcGWWJe12iG04J2L4kC3LrCU7RrXcLBijXOlTaFuASC+Zt75AT0RD0XorESscfBp1ku4ziWBhHsJpywKmrBuB3HxRtyUI09+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=CmDlOGGu; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=CwLwuJVh; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="CmDlOGGu";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="CwLwuJVh"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=CmDlOGGuCfQp+gVhYDj85jSxxZBPD8ET8bBmfaxFvdeD5MB3zRbEORMS0WPSj5GfuHNVeROFwfNx55Jmapt6iQ0w/vYwfEthNlLMU9AfLQcF0RLnnPurAp4frssrZ9HrpZNk8ixFGtOUqLuuKw9jhVfr5kqCOcqS8kQwVpAVX+psnqRh4VTf6ZQaj4mTZYcxjgLyOhef1T6bCsyl1igVBEEsz4xCTQ1Q3boQUPuO0aVI4aJcqWKEj1DmaJ4AubXMsTMWseX/TSCArH7bIEQbkFRoIoRsy0SKp4iGbCUWLTNagSMdE1j9OUCo6pv91M7lHkscgTYE87pU7BvTsKLaPw==; s=purelymail1; d=malon.dev; v=1; bh=km7IvXDoK+aXXmzuMz/ecALXSGEeLILPZhDw9LKG1pY=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=CwLwuJVhcm0oX2Oc9yD+3k54zN9UCk3taC0m4vSCF75uiBv6TrNI86NBZOWoVCmll7uXvtmcbXNZimMBj/unj0dXLFtVlp4G/xejfkrLiz8n0FtiNAJgqHradp6KO1RL7XJ5m9hvNVz+1FbUy8cE/+tk+CTaSkquxW46ke401IxiJund6aUsmEuQ9xFRJcERj17z81sVGVVtcHaA5ZxeKCx+QJeC4cRlVlh+O4O3F9fdDR9sAHTbrRZ2V42w8kpOH5Y7ewpwtxvq1eCG2r03dUjSVcdsdQ1AJ7dhUVx6r/oELFAzzrD+PDjdvvhArJ91x5IVTIVb80i9LKtbBBFHug==; s=purelymail1; d=purelymail.com; v=1; bh=km7IvXDoK+aXXmzuMz/ecALXSGEeLILPZhDw9LKG1pY=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 872182701;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 09 Jul 2026 16:12:13 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v9 3/9] environment: move editor_program into repo_config_values
Date: Fri, 10 Jul 2026 00:11:39 +0800
Message-ID: <20260709161145.13349-4-cat@malon.dev>
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

The global variable 'editor_program' holds the path to the user's
preferred editor. Move 'editor_program' into
'struct repo_config_values' to continue the libification effort.

There have been discussions on whether external programs like
editors truly need to be configured on a per-repository basis within
the same process. While a single process might rarely invoke
different editors, this migration is necessary for two reasons:

1. Developers frequently use different toolchains for different
   projects. Per-repo configuration respects this.

2. Moving this string into 'repo_config_values' eliminates mutable
   global state. As the codebase moves toward becoming a long-running
   processes managing multiple repositories concurrently must
   not overwrite each other's program configurations.

No standalone getter function is introduced. Callers directly access
the field via 'repo_config_values()'. Heap memory is safely reclaimed
in 'repo_config_values_clear()'.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 editor.c      | 4 ++--
 environment.c | 7 ++++---
 environment.h | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/editor.c b/editor.c
index fd174e6a03..07d264cba0 100644
--- a/editor.c
+++ b/editor.c
@@ -29,8 +29,8 @@ const char *git_editor(void)
 =09const char *editor =3D getenv("GIT_EDITOR");
 =09int terminal_is_dumb =3D is_terminal_dumb();
=20
-=09if (!editor && editor_program)
-=09=09editor =3D editor_program;
+=09if (!editor && repo_config_values(the_repository)->editor_program)
+=09=09editor =3D repo_config_values(the_repository)->editor_program;
 =09if (!editor && !terminal_is_dumb)
 =09=09editor =3D getenv("VISUAL");
 =09if (!editor)
diff --git a/environment.c b/environment.c
index 5950592d63..0a01f4761a 100644
--- a/environment.c
+++ b/environment.c
@@ -55,7 +55,6 @@ int fsync_object_files =3D -1;
 int use_fsync =3D -1;
 enum fsync_method fsync_method =3D FSYNC_METHOD_DEFAULT;
 enum fsync_component fsync_components =3D FSYNC_COMPONENTS_DEFAULT;
-char *editor_program;
 char *askpass_program;
 enum auto_crlf auto_crlf =3D AUTO_CRLF_FALSE;
 enum eol core_eol =3D EOL_UNSET;
@@ -435,8 +434,8 @@ int git_default_core_config(const char *var, const char=
 *value,
 =09}
=20
 =09if (!strcmp(var, "core.editor")) {
-=09=09FREE_AND_NULL(editor_program);
-=09=09return git_config_string(&editor_program, var, value);
+=09=09FREE_AND_NULL(cfg->editor_program);
+=09=09return git_config_string(&cfg->editor_program, var, value);
 =09}
=20
 =09if (!strcmp(var, "core.commentchar") ||
@@ -723,6 +722,7 @@ void repo_config_values_init(struct repo_config_values =
*cfg)
 {
 =09cfg->attributes_file =3D NULL;
 =09cfg->excludes_file =3D NULL;
+=09cfg->editor_program =3D NULL;
 =09cfg->apply_sparse_checkout =3D 0;
 =09cfg->branch_track =3D BRANCH_TRACK_REMOTE;
 =09cfg->trust_ctime =3D 1;
@@ -753,4 +753,5 @@ void repo_config_values_clear(struct repository *repo)
=20
 =09FREE_AND_NULL(cfg->attributes_file);
 =09FREE_AND_NULL(cfg->excludes_file);
+=09FREE_AND_NULL(cfg->editor_program);
 }
diff --git a/environment.h b/environment.h
index 2e8352de7f..1ec19149cb 100644
--- a/environment.h
+++ b/environment.h
@@ -91,6 +91,7 @@ struct repo_config_values {
 =09/* section "core" config values */
 =09char *attributes_file;
 =09char *excludes_file;
+=09char *editor_program;
 =09int apply_sparse_checkout;
 =09int trust_ctime;
 =09int check_stat;
@@ -218,7 +219,6 @@ const char *get_commit_output_encoding(void);
 extern char *git_commit_encoding;
 extern char *git_log_output_encoding;
=20
-extern char *editor_program;
 extern char *askpass_program;
=20
 /*
--=20
2.43.0

