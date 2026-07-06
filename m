Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DC8379C5F
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 14:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347967; cv=none; b=AN+1vgi18EPQEqasUEABlMIj8jCZKyJGpC3x5De1m8z4qvdiqSGd0w2OjVoY9e80V9Ci2Y29lCyQo090HJ4db9VJAD/0KZUl8WhzB1gvowTxV1Ehy9hGwzXSnahXY7L4/MJIpZZc1pGBUP4QC/pSdReeGHsdwhma5/hAlc35OlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347967; c=relaxed/simple;
	bh=km7IvXDoK+aXXmzuMz/ecALXSGEeLILPZhDw9LKG1pY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bxV8WAPvsxVksY5Uyqk+eeLzxPwZGLCv4Wjn5eQPPueIiDk9KHBOusCLlPsI1b8VQ6T9aJBNJcP1P8r2CjsiBhslVsSaVzOSuLzYvWM7kKjdHMws5KMqv3VzOu4CMPxW7CwEr3ARu1VzjZJM0WcZ2KAtDMlW2guNipwvuGbnYz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=w2D9MC5W; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=WqQ0VCnK; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="w2D9MC5W";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="WqQ0VCnK"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=w2D9MC5WPbVOqqPshHYhAPoZ7XbJQpys1KCS9bUULb0l9VTDJqIHwc4f7KOy5gstgs7R+f98Cfux3KjlaTiBb5kDCZ0SnrC+Ac8y0Vu1i5Y4DeJVY92Q0htcP//neoQ4zAV77239VieG6p4cY8AmX9YHd2IrFouDv2TeItHT3F1/yhMqYFsivAdr+mw6Znvoo2/EZBEen7QDaATm3wM+eor9FuHMoZsZYQx331YMnPTsmt1dktowQTK7C4s+RjhgS9fzY8Q3dy2HmRO4BWFyAdiwBvDHlBSJnOJehPDYpdy4BcXkZRbb7i5p9wkVHoiKBZxNJlM35cUm+hWKROp5kg==; s=purelymail3; d=malon.dev; v=1; bh=km7IvXDoK+aXXmzuMz/ecALXSGEeLILPZhDw9LKG1pY=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=WqQ0VCnK1tZnLg9ndMmsKEATYZS8z4MskXrVesgC26edtJZuPNmJuEtce6CYp89BMGBG78ylR2O/QezoKK/4drjrPWWbVqJBUVTeVb5MJhqD+0YktiqxSK2z2Udf20J1nRM7NsEOqovjQ+yAuhKc7SG3wdbQRRAorUZay/DPbwfVMDivdIYuPy9K0/gcTYlu3WIyeNA5rhJjHjDOX8hdWePOA5NKA4c/oJXK7YAlj2ht5Mxr2ln9t22d5maHc/izFUIwWcMqzNsneV2EcrbKL20WYaNMg9oULUVXEt8pZQ9WTZJJrms6Ed+caQ3VPDFy7zamJEbnmJDeF1ycsldBBw==; s=purelymail3; d=purelymail.com; v=1; bh=km7IvXDoK+aXXmzuMz/ecALXSGEeLILPZhDw9LKG1pY=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1851978137;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 06 Jul 2026 14:26:03 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v7 3/9] environment: move editor_program into repo_config_values
Date: Mon,  6 Jul 2026 22:25:24 +0800
Message-ID: <20260706142530.3681520-4-cat@malon.dev>
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

