Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299ED3A380C
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 03:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783999545; cv=none; b=mZu5B0i8pNM4gnlFijiCanHPaaOT9GSMdrWB+OJPXbMEy2ffxes35Z3kotMMs0eiFv4bJPfp4+bGHZNQN76Yqk/pie7h14q1g1zVzlQaMb13Wi3F+vkxxkVTDyO0x12J1KX805kV09x8G1b6SdANn/aX52aMX8h+zZh05GU/yDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783999545; c=relaxed/simple;
	bh=sAPZx9Gckpvfq5xy5fZcTHo9aJoceNju/Lyt6XXmpkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Se68u57y6xOlWFMH6mJrhpbmwo4jPEF8xsdDqpOy7BC40REEcfX7mrFc7YppE9OXiWdeiEn0fuWMAa/0zZ/QpxwrN7aWh+H9M4jGHWFpOPEcVNulpmuEMT2Eq6fuUOYnx/sO045NqTURVhrlaw4uVo29RVhivfWm3i6fjLb5z90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=KR3OnN1n; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=WZEGeOv8; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="KR3OnN1n";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="WZEGeOv8"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=KR3OnN1n7cjdwKHpc1E+tBPByQmpCsvcs7N1pghyqY0RlCB+2UdE4woffl7U6XpQesm7QikiwUNwmc6LoGWF8+6gJ6V2PJQcNcwxDRksajI3PJhjNlHrvMMUJNs1On3HCd/6+cB4+B2rclpu8fKRFqzot9VRENr9gH3BEzMKfsWP7/4PQukdv5pZ7Eu4oQojPOEqXXG2yZnbZEM5VmygvucsPeQiFZxn1M84LT5HIZCEepLOZn00oLwzmol/Mn+G37Hijjk8n8vxw+17rfJNM0VIRRx5MVd9bot6qgFtF3QyoUgOUmbl7aZpRisFUiTm6fkdE2dlyLgY6BX4VzxCDA==; s=purelymail1; d=malon.dev; v=1; bh=sAPZx9Gckpvfq5xy5fZcTHo9aJoceNju/Lyt6XXmpkM=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=WZEGeOv8fisx3UJomusIonN6//3GBR69mgJai2ExxjVQwm+CqmPEiaWWijc0iQ692GXxC5uDo4hm27GbMh/tcnIT0va1dPKHik+z50401QcClpOVKX147AprXkARf7Mjt/V5pmTM6wc0txTdRaZdp+SFr2uQ6Myf9jl56yWYk0TuQo0cPg6K0UkK9G+i0arWtSTshlWEqTgjx3i3AyE93GL3Z0WSyfA4qbvcPs7yjiMdrQBwrAKidLFCbw3pvmH469Ohd0lvQZOKeXFwRLbrz4Y3Igv2aj853DDtFQ3orItPWVI/XF4YCrJ1eOTK3otCJZb06oDg1rhs2e4Rj29YnA==; s=purelymail1; d=purelymail.com; v=1; bh=sAPZx9Gckpvfq5xy5fZcTHo9aJoceNju/Lyt6XXmpkM=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1695711826;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 14 Jul 2026 03:25:41 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v12 03/10] environment: move editor_program into repo_config_values
Date: Tue, 14 Jul 2026 11:25:18 +0800
Message-ID: <20260714032525.1611141-4-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714032525.1611141-1-cat@malon.dev>
References: <20260712111734.1073514-1-cat@malon.dev>
 <20260714032525.1611141-1-cat@malon.dev>
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

