Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329E9378833
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 16:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783526603; cv=none; b=XgpilA3QUTCjJKdjO3ipHpcFdxS9uPXUW05cROVyIvB4vCG5TPM7pzAI1jVbgxrA9ODuXvjjtPwI37wa1eSB4kGcU7MRtf2aGok/k66HUIg7fqoTLC4G2frUK6TAW3CFDA5Oq2EZctkdCgsB2Z1DtqXStiyPsdH4Knvnq9tbwdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783526603; c=relaxed/simple;
	bh=km7IvXDoK+aXXmzuMz/ecALXSGEeLILPZhDw9LKG1pY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qGWUli2DoGyZKk8m0gNwu9bQaUfve4X3wvK5M9EzYePubuaUh3XV70jW1So6+oQ+cd3UYBIbBsOR32vz8RxZlWks1klOlczetx0hXbxFMEEQ6dKMMuJghPdebiDcPd7PLzIKElSqOimnqhpENxxpngW65qZBCQNe+QCZmhwHJOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=CrKuRi7E; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=YOysXmVR; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="CrKuRi7E";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="YOysXmVR"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=CrKuRi7Ejjtf3AUAGX6lc7DUwmz5hEBYfrOLljh9cKdyOG/tIft7oEhTOo2twr8oGpuEwvNMhOA9OP8ILuz7s/qQZNjkpw/RqZUOeFsz72z3/UNLbN5PXjj4E+Q/hlvF8tZt78ocsrkQdPvflK2dqQgAVJSRKqP3SNOpTIiyHeyqQyCvZ+tM4rdljiWxuVY3onISYeSlDPt4FKWj5bCnLzu7WTNvYFTkgqIHepCyl9KwsiTT8NQZNQTI4MR0eGHweh2uusCYf/GLsLmXPK9/7IHsaEBc7uMEUZ6qfIlOeJlowhHvkP9izTrZiA5W6NvHbALcOknFQGmy1Uji41UWGA==; s=purelymail3; d=malon.dev; v=1; bh=km7IvXDoK+aXXmzuMz/ecALXSGEeLILPZhDw9LKG1pY=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=YOysXmVRMlO8R2fGtlcDztivbrG07rGhkNjYm7g2ZXLFRfj6rrkhw14yq+BnoEFb1gQf/N09q8FjBDWhRBE0fetsmx87J4uTKeBx5hrFGB6Vhz+vakDsJ9ofcVa9DnlWSdbbUOvrqWxZnJZHBG3h70FTY2ZBXoE1uNegicMLDdpdsJSy3feYOMtnK/Ed6KvX1u7nvVAb4g8yg3H4lrnCJSkGi6CTNYSJYdtPmAtBzhj0CPpdxMnPFDB1a39d7XubPIMZwcPx5/oxzJGaFWJaLn9+lTjr8ZabJMVKDjW1mzYFbsjG9YLNDV1D0+EFUY+h5uQpjGIbfXN8cj/nxlN8Sg==; s=purelymail3; d=purelymail.com; v=1; bh=km7IvXDoK+aXXmzuMz/ecALXSGEeLILPZhDw9LKG1pY=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -238025841;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 08 Jul 2026 16:03:20 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v8 3/9] environment: move editor_program into repo_config_values
Date: Thu,  9 Jul 2026 00:02:54 +0800
Message-ID: <20260708160300.8852-4-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708160300.8852-1-cat@malon.dev>
References: <20260706142530.3681520-1-cat@malon.dev>
 <20260708160300.8852-1-cat@malon.dev>
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

