Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EBD36B07C
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 03:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783915079; cv=none; b=T5WMesJHt8PXVDYbZ/Je5lPkoqlhupkmp+S7dVy9mE9O4yHxILi2RIl8/BZ/BfmL8aMg8PjZbBOLz+4q4FZ70tx+21etNRxz/l8BhbZ9WsLr+IsDjS6k/VI6B5fDncHVV9lYHUrbYBIYiKtq1t1aRYuRzrDUbCerl3wW4PAZzF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783915079; c=relaxed/simple;
	bh=sAPZx9Gckpvfq5xy5fZcTHo9aJoceNju/Lyt6XXmpkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BSj8yKEL7u5EhpopK2zWFyKYg2ABJ3xoX4KDTjnZly04w7Vdgl7Bft/vnnEPx51PxxJ2BSkorrqQV9Gqq0hcIIx6epUrZGAGGSDpYiKMoqTYwogxXA6gANvIi1ZUkUa7Rc5YqBK26kXJ/Mog1St5uXrSQsls8SW2nr5o4zhtZnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=E7NdI0q6; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=A16BoH+J; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="E7NdI0q6";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="A16BoH+J"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=E7NdI0q6L7nbh0wDT+wuA1mNn0aYpcFNdfWjcT1WZJxfrbcLLdCaVDSVat11gVr2autX+43+LxdvYSD0011mOHMbfBd7PtA6uyi1Qsa8jXT5Wc44lO/MpCm/rLPvR9aDFaYRR8KgeVNpE622qYf8D1laTXr+BmlX4N/oKy2Qs1NJvA/J6rQSUcPnm7B7T5jKaUtnMuoNKBodjk9gsucjerqBlf037MT908AH1wvNoQ4whzAvJCTpZKrEXn6vwIdaUhsCJTvlN7xTEn2tCpPdoQ+He1qvsGEAV/eDXA5y35YEjv/08+KRs63bHsEds/Kj6ZqteVm6z31HHen1u6k5Ow==; s=purelymail1; d=malon.dev; v=1; bh=sAPZx9Gckpvfq5xy5fZcTHo9aJoceNju/Lyt6XXmpkM=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=A16BoH+J9vAGX3Kc0t57bT72GGJ/gYNd4MeYlmmyxq7CYrd8fX92iyByPqMXx4qugbsWYKCBXSLJiwGvvgXM/MFFwHUDn3W/g9tIBjKNue+2FXFHvJUdIrfPEN2IdvZY0I1KlZ6d/PaTZT6E5oVSIgoGwd9+V8/nMULl0TVvGE2bdRoMsiey01kh4JHe2KFUqoPDn5ROptDd44SM4gzCmqUR5+KB5Cbau5C5K7KlP0Uv2YzwlGsYhxAiJklc6I4o7C10V5jM4ZQQtlJJoprh/7T27mFd1QbEL/RhYc6/ZOq0bLvnhpSZKjP1S+iW2QyEZ8rEgLqUYyfKkLIcjruCCA==; s=purelymail1; d=purelymail.com; v=1; bh=sAPZx9Gckpvfq5xy5fZcTHo9aJoceNju/Lyt6XXmpkM=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1573664722;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 13 Jul 2026 03:57:56 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v11 03/10] environment: move editor_program into repo_config_values
Date: Mon, 13 Jul 2026 11:57:31 +0800
Message-ID: <20260713035738.1606138-4-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713035738.1606138-1-cat@malon.dev>
References: <20260712111734.1073514-1-cat@malon.dev>
 <20260713035738.1606138-1-cat@malon.dev>
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
   processes, managing multiple repositories concurrently must
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
index fd174e6a03..0d1cb8768d 100644
--- a/editor.c
+++ b/editor.c
@@ -29,8 +29,8 @@ const char *git_editor(void)
 =09const char *editor =3D getenv("GIT_EDITOR");
 =09int terminal_is_dumb =3D is_terminal_dumb();
=20
-=09if (!editor && editor_program)
-=09=09editor =3D editor_program;
+=09if (!editor)
+=09=09editor =3D repo_config_values(the_repository)->editor_program;
 =09if (!editor && !terminal_is_dumb)
 =09=09editor =3D getenv("VISUAL");
 =09if (!editor)
diff --git a/environment.c b/environment.c
index 275931c213..a65d575af4 100644
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
@@ -437,8 +436,8 @@ int git_default_core_config(const char *var, const char=
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
@@ -725,6 +724,7 @@ void repo_config_values_init(struct repo_config_values =
*cfg)
 {
 =09cfg->attributes_file =3D NULL;
 =09cfg->excludes_file =3D NULL;
+=09cfg->editor_program =3D NULL;
 =09cfg->apply_sparse_checkout =3D 0;
 =09cfg->branch_track =3D BRANCH_TRACK_REMOTE;
 =09cfg->trust_ctime =3D 1;
@@ -741,4 +741,5 @@ void repo_config_values_clear(struct repo_config_values=
 *cfg)
 {
 =09FREE_AND_NULL(cfg->attributes_file);
 =09FREE_AND_NULL(cfg->excludes_file);
+=09FREE_AND_NULL(cfg->editor_program);
 }
diff --git a/environment.h b/environment.h
index 4776ccc657..8178ebab76 100644
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

