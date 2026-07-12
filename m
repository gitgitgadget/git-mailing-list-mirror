Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328CF2D73B9
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 11:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783855075; cv=none; b=Mg+otC6smYM7SwhdHGhgkLNQkr/SZIf3pF2mIRpG5xGOymg2+CT8x5DDZwwkHgOetQyzJEn865nvvrDdlFZIHZfkzfzBlyJVry126oCrXWr1ZqW70TiCt+5VcGXZJ2h90+EgGe3L5UdYINKrdyzpUD6QXdpLi5gOGahYjJV/p1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783855075; c=relaxed/simple;
	bh=sAPZx9Gckpvfq5xy5fZcTHo9aJoceNju/Lyt6XXmpkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qaw//CG4irohQgv9ekFs4qQ4PyJA8QmHtY2UwHWJzUmls94Zy2rGlrHwvTIJVUONUtHFGo0d22tqHLTz+VGMShbYCPxMUZrEQvKsMTsCPcrlzwXzzKaU+lRnmvb4JtM+hjBF1ymh1SM3EjL9kFOGLxbxzKrKLHEP8Z3OF1d7uIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=NkFBiphD; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=GpAGnwC0; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="NkFBiphD";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="GpAGnwC0"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=NkFBiphDO0A1s46/B5VbnXLtd994YozOE/iSKJ549M1e/rP4KFEkjeh0ZLFtt9ZOQUOKFxprRCkjKSuHHK2MG251BUjUNPUVi788NBxBBhBHlldi1fm+4viERFat8r190iVKD3I0BnkFBPGJi8X46F67c15+5qFMQazFovBPh0S/zLJCpS2CEfVB6HV2qEVf3q+viBEdaScNlEj/kULL76zvP9zEIjzi6XcxcfAuOMyhS3NGr/X9f3PCUMoymvgk+RXwyPr5vWPYpkc/9qDf7dK9dWhQsJ0x77YxBQ0avAm9s+w0qDjs41g3VMUpSbwxHYkoxwukrL3uYvFU0m2DDA==; s=purelymail1; d=malon.dev; v=1; bh=sAPZx9Gckpvfq5xy5fZcTHo9aJoceNju/Lyt6XXmpkM=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=GpAGnwC0MwKRINjaLMekeFprz8UE5ZuG/LcVn36j+gaRUyRinV2smyOxZDitx0R6dAP3N2lw0dDId8Vn2sOnXQf4ol5NACN7LcxJMgnOTLxXtQoj/3s0FrjV3f6RNKmbtK95XDwBCRgyaunlKNtKtGSofR8ja6JJjXmuii5X/dJH5JVeSsqtP0760EtVHvfPIDqSoNtC4XJDjXcZAPBXKyk0D5r18RMSL51gO+mjbff4JBcri/d0Vkt5WRWKslYcnp/XqTMlEnuhmoacIM3byVsOZsBCrlIfpuvhHcfQsinvMop2foAx71TgOvciXcnpFTtHWkSdsd1RBmeoOpxyiA==; s=purelymail1; d=purelymail.com; v=1; bh=sAPZx9Gckpvfq5xy5fZcTHo9aJoceNju/Lyt6XXmpkM=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -46196840;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 12 Jul 2026 11:17:49 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v10 3/9] environment: move editor_program into repo_config_values
Date: Sun, 12 Jul 2026 19:17:27 +0800
Message-ID: <20260712111734.1073514-4-cat@malon.dev>
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

