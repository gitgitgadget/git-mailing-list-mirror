Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ED3432BC0
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 16:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783613561; cv=none; b=FPk2asEKuV8pOv7v6WXVd+DnVOx2NvwEGzZahvXH/VIKhSW/uOqMEXLkU/rtPER9KitMpq2Cm8P5XMud9j4w3i2PoUTy2dhFkPIjFnyvi/eeXE4XzS1Nek4sDLNxBMt/+eRUCJQeVqcyOTuRqkyMXp4gXleGoA0gxaBeNJ3bsKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783613561; c=relaxed/simple;
	bh=NDT9s/GCso2W3GSHIWKyKDZX2NwA4cijGAOsKkOrmvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kzWIOZGYgZj/+Ynn3YO4oNqRyDBejMA68NWOXN1leXGW8sxVvjhzbrFzioNiPBgpRm5VItUdB9qOiOgaLw56QFYQjb3ITil6IcILZhoUA7KjoCsDOk1obNCc/GhMJfgSEnV54Xib9BevZwWRPdREcGm7aOLXhWOkW9+M1LouEDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=TfNvqXfI; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=UR6yxvov; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="TfNvqXfI";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="UR6yxvov"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=TfNvqXfIKOGwkr5ZrUj3N8xMARfJUwXiW3Ea0WjJgd8twWLzmax7jTgaZteUsyhqZ+bSjQr61qKYxTziEMSpRojPzNmicw9q1WNdj5VAcRDeZhA+juJ/Y3NPlpey2UUsjyVnXZcOHy30EoUJ1zT5F8/EZaKlOwoZjSv+1xmH18tsyqH3Fr60ztrKQap14/GbTxexs78iSWtZ+oKzoXsxIdRpfsZoCaya7fKFk78YtftE2/1y2NpiX+BZghxMQBPqkC0cRCSH3k34rOMh7pSEWiIAgSLvwUsG43wqMFCchYalsVMk3WDt8eVPNPWQFvEaEtuqLC7hBZ1BxlH2JCwJAw==; s=purelymail1; d=malon.dev; v=1; bh=NDT9s/GCso2W3GSHIWKyKDZX2NwA4cijGAOsKkOrmvE=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=UR6yxvovJHVtH4jfeSJWgXaTG3YOKROi5bAigmCIrHBLDmGd/vK5oyniPxQgy0UtGKp7luaYKIGK+QD7AdQqmd1T6EgfUQed9v7RZ3DUvUo1O0p8adHGTEWHsq7HdalWyOhf/iv2MPWp91Ww3bLzXjw5ksnnwWVvuQoZj9ekGSntUjfSGGXD2l0iTBPpvb4U8NGOGqOXNHMg/C+IwnPtvPE6uue6D4Ovj1daZavnNHlFQo3WQ1a7aqEwiT3XS3gbsrO6I3Z60ezPzv4Ryol8+iZjxGXQnsk4tIBZ8HT03VC9hmbAxgrSlEuwYetd5D7OId8iuhcJPw1qTYzsJE9pfw==; s=purelymail1; d=purelymail.com; v=1; bh=NDT9s/GCso2W3GSHIWKyKDZX2NwA4cijGAOsKkOrmvE=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 872182701;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 09 Jul 2026 16:12:38 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v9 9/9] environment: move object_creation_mode into repo_config_values
Date: Fri, 10 Jul 2026 00:11:45 +0800
Message-ID: <20260709161145.13349-10-cat@malon.dev>
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

The global variable 'object_creation_mode' controls how Git creates
object files, specifically determining whether to use hardlinks or
renames when moving temporary files into the object database. Move
it into 'struct repo_config_values' to continue the libification
effort.

Move the 'enum object_creation_mode' definition higher up in
'environment.h' to ensure it is visible to the structure. Initialize
the per-repository value to its default macro value
OBJECT_CREATION_MODE inside 'repo_config_values_init()'.

Update configuration parsing in 'git_default_core_config()' to write
directly to the repository-specific configuration structure.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 environment.c |  6 +++---
 environment.h | 12 ++++++------
 object-file.c |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/environment.c b/environment.c
index 7701aa3bc0..e50beda918 100644
--- a/environment.c
+++ b/environment.c
@@ -61,7 +61,6 @@ char *check_roundtrip_encoding;
 #ifndef OBJECT_CREATION_MODE
 #define OBJECT_CREATION_MODE OBJECT_CREATION_USES_HARDLINKS
 #endif
-enum object_creation_mode object_creation_mode =3D OBJECT_CREATION_MODE;
 int grafts_keep_true_parents;
 unsigned long pack_size_limit_cfg;
=20
@@ -511,9 +510,9 @@ int git_default_core_config(const char *var, const char=
 *value,
 =09=09if (!value)
 =09=09=09return config_error_nonbool(var);
 =09=09if (!strcmp(value, "rename"))
-=09=09=09object_creation_mode =3D OBJECT_CREATION_USES_RENAMES;
+=09=09=09cfg->object_creation_mode =3D OBJECT_CREATION_USES_RENAMES;
 =09=09else if (!strcmp(value, "link"))
-=09=09=09object_creation_mode =3D OBJECT_CREATION_USES_HARDLINKS;
+=09=09=09cfg->object_creation_mode =3D OBJECT_CREATION_USES_HARDLINKS;
 =09=09else
 =09=09=09die(_("invalid mode for object creation: %s"), value);
 =09=09return 0;
@@ -727,6 +726,7 @@ void repo_config_values_init(struct repo_config_values =
*cfg)
 =09cfg->apply_default_ignorewhitespace =3D NULL;
 =09cfg->push_default =3D PUSH_DEFAULT_UNSPECIFIED;
 =09cfg->autorebase =3D AUTOREBASE_NEVER;
+=09cfg->object_creation_mode =3D OBJECT_CREATION_MODE;
 =09cfg->apply_sparse_checkout =3D 0;
 =09cfg->branch_track =3D BRANCH_TRACK_REMOTE;
 =09cfg->trust_ctime =3D 1;
diff --git a/environment.h b/environment.h
index 464ff73136..eaa0aba7bc 100644
--- a/environment.h
+++ b/environment.h
@@ -109,6 +109,11 @@ enum rebase_setup_type {
 =09AUTOREBASE_ALWAYS
 };
=20
+enum object_creation_mode {
+=09OBJECT_CREATION_USES_HARDLINKS =3D 0,
+=09OBJECT_CREATION_USES_RENAMES =3D 1
+};
+
 struct repo_config_values {
 =09/* section "core" config values */
 =09char *attributes_file;
@@ -120,6 +125,7 @@ struct repo_config_values {
 =09char *apply_default_ignorewhitespace;
 =09enum push_default_type push_default;
 =09enum rebase_setup_type autorebase;
+=09enum object_creation_mode object_creation_mode;
 =09int apply_sparse_checkout;
 =09int trust_ctime;
 =09int check_stat;
@@ -213,12 +219,6 @@ extern unsigned long pack_size_limit_cfg;
 extern int protect_hfs;
 extern int protect_ntfs;
=20
-enum object_creation_mode {
-=09OBJECT_CREATION_USES_HARDLINKS =3D 0,
-=09OBJECT_CREATION_USES_RENAMES =3D 1
-};
-extern enum object_creation_mode object_creation_mode;
-
 extern int grafts_keep_true_parents;
=20
 const char *get_log_output_encoding(void);
diff --git a/object-file.c b/object-file.c
index 9afa842da2..cbbfc8f1dc 100644
--- a/object-file.c
+++ b/object-file.c
@@ -415,7 +415,7 @@ int finalize_object_file_flags(struct repository *repo,
 retry:
 =09ret =3D 0;
=20
-=09if (object_creation_mode =3D=3D OBJECT_CREATION_USES_RENAMES)
+=09if (repo_config_values(repo)->object_creation_mode =3D=3D OBJECT_CREATI=
ON_USES_RENAMES)
 =09=09goto try_rename;
 =09else if (link(tmpfile, filename))
 =09=09ret =3D errno;
--=20
2.43.0

