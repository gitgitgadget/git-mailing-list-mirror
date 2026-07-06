Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF42E383C86
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 14:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347991; cv=none; b=cgW1ypeg2fLrCD2YAsR1PbC2oHXHiF2I3sn99EIYLJEc2ZfeZEKLfy1yRJ0phugNKjjaR6O/vgaBe7ZC7Y9MlnpHsQzIFTasnPpLQ+sAVKlShe4L74/Utgy81MoC09FWeWPAQJtcBTBDihgY/4o5UcTfBh1dkggHJF3zwMmjRaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347991; c=relaxed/simple;
	bh=NDT9s/GCso2W3GSHIWKyKDZX2NwA4cijGAOsKkOrmvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WmZw++THcVY1dBeuvHuMSYzOJlARwQCpPfSTCQu7qmP0BRMqyxuv9B1GOxZ0EnX6QdHy25Lh1ELN9hTrKdh0HGlSQ2qvPh1B/PuvsjtCzggxqXbCUNwkXpjS3yEXWq9+G8fYUz6MzpbDhh+rH/TdV/pZgSGqcGE96vD63cDQp/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=PLTBYFZI; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=MXZfBLUU; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="PLTBYFZI";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="MXZfBLUU"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=PLTBYFZILiD009kD+B/gRrW2W72q98SDHh+P7qoNXx36oSqXKxcB9098p3hkZgAopqJySE+uw0M2m8n12rFHJC1CSr9PnGKY4Buq6MTOIK2ApJGZbSaGmGVo2i8BBCX1G/oDmZuAUliJl2/BC/2lYe5VE1Cd+NH74y4xqkZ5sGAFgpOKnOI3SBgxkVHk5zrrq0V4ggIBZEUNiZd5VULDochMuQGMDZhvptBCXRRR/uVsPEPgdKmW4qFOJVo/cScCpnbcTDm6z3BD4cBgpH3oy6tKroFj7Qap2fsa0Dz4lJ5IZnNa9YMUgsOrMhD6mO6VbjOgy6V6pas9uflOxXCJxA==; s=purelymail3; d=malon.dev; v=1; bh=NDT9s/GCso2W3GSHIWKyKDZX2NwA4cijGAOsKkOrmvE=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=MXZfBLUUDRy128kZC/gx1rA+zDnwkskziwSRiAviP9GTIieehwOFZG0G76SYg9RjwFr1/e9xKkj/D1vooxSpABkG+CeVA6N+C6oj1/N7giCVLxPQIFlLWqy+PBOX23P5I3GzYMkkeORVTjYiR3YRFpyPznKI1rkCcIp/nHUKrgJrMWfktX+t5FGAGWE2Zksp041F09LIQ1tESwgdr0ld5KJsEODRWWLxs457Jc1hoHDgPL2ZWZVEPe/vO2WOiuCo3xGaTC5uKeu2yYRICKeWi4YjzxBCB7D4EMEwE/0LajbSuICy5MD4GqC85cZmolUBoECLi8lPkmuhGgYe9+4nVA==; s=purelymail3; d=purelymail.com; v=1; bh=NDT9s/GCso2W3GSHIWKyKDZX2NwA4cijGAOsKkOrmvE=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1851978137;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 06 Jul 2026 14:26:28 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v7 9/9] environment: move object_creation_mode into repo_config_values
Date: Mon,  6 Jul 2026 22:25:30 +0800
Message-ID: <20260706142530.3681520-10-cat@malon.dev>
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

