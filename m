Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D363A48E4
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 11:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783855094; cv=none; b=RoJGKQOnAf/19F2vZwK8NfuYjWgruLaUR6ptS0zCqV3EEUEXzTMSrApZikLkNWKvWqIflxKTg0ZTtqL6B35imUHgxCKPk8RKg9/qkliWFqi3a0Tful6w5pH3faJuGdz230Kn8i4OktY6QpIIR10e+nduVAOAa57GFSy04lr0o74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783855094; c=relaxed/simple;
	bh=uwhVT1L/PCFju/2Wtvb711XKtUnWKfA7sY1gtQfh/A4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IJPcxmVfE2zr1TB1ZppgxEhXZwfQDkNhhF39Ym9NoKpJUvqoszDXflpbwxqVyENEI04IEEXpOTpQRq+uBXfdaahrMKch08d5rnYQi+6xa6vrP70g90z8W1lcexa7SASsala+dmMGSM0Mtp8dKLci08JuLv2GePSQSfhs1RtLbwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=fClagtTW; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=KqWutiUb; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="fClagtTW";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="KqWutiUb"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=fClagtTW/zJurTkZ9dN9HU64AIwnSio9dGqDaLvetYI8JVV3W6vOx6/1qhw0+K3KDi8NqTXa2U7thHlbNRqtiTdmDE0TWNV/sRAVL6j6gfgta6OblnjskOO6f1IkZ/m0vytnlTe52gm7dciZUHA7xoCX3Sl8UBUwVUZoObh14exkgoBIMx3pliZXPoUT7JQ8JUf29+g62zc2WTAWvu77DoxeEC82+XBdhaAs3E1PIn1Gj2Jrio4atS+3epMCz0rPqcpnpK7+n6X63DRZT2I4atr9H6oBq28QkzliPGWa+3i/a284hUNSOegfDAjC2c2rmoEcU7ArOpBFXiZdG8F8xQ==; s=purelymail1; d=malon.dev; v=1; bh=uwhVT1L/PCFju/2Wtvb711XKtUnWKfA7sY1gtQfh/A4=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=KqWutiUbngRz9+yIYHw+L61BrwaTrxW+6vUylXV2DCJqhiCd5JEcWvlxXoSyZY6dv/eTzgkmGrNUrXovj/LJ0QhvsVQ60fMlZN+076jylo4iNBlXjUIjNCgcy3oi53DNxVXB0zBVf6bTgQw1Z27R9vSsnFi2Vz6lDtq/hzP6udX7YXzPexs2MZGTsgiYLw/WdfFx50D0ljiCuUkMmNgtMR6ZcGlU5gUqhyDVsw0LEu3YJ5MDgUsgWkyZB96ea0JjUQPoCcmN/oU7xBQgiD3neg6rlBVaXYNSwNZYhAlNvGDipBtbEQxDkqITHAXSF8OMIpcjgtDQRxL2eugTAmoVUg==; s=purelymail1; d=purelymail.com; v=1; bh=uwhVT1L/PCFju/2Wtvb711XKtUnWKfA7sY1gtQfh/A4=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -46196840;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 12 Jul 2026 11:18:11 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v10 9/9] environment: move object_creation_mode into repo_config_values
Date: Sun, 12 Jul 2026 19:17:33 +0800
Message-ID: <20260712111734.1073514-10-cat@malon.dev>
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
index 42829a9c7a..e882e4ada2 100644
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
@@ -513,9 +512,9 @@ int git_default_core_config(const char *var, const char=
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
@@ -729,6 +728,7 @@ void repo_config_values_init(struct repo_config_values =
*cfg)
 =09cfg->apply_default_ignorewhitespace =3D NULL;
 =09cfg->push_default =3D PUSH_DEFAULT_UNSPECIFIED;
 =09cfg->autorebase =3D AUTOREBASE_NEVER;
+=09cfg->object_creation_mode =3D OBJECT_CREATION_MODE;
 =09cfg->apply_sparse_checkout =3D 0;
 =09cfg->branch_track =3D BRANCH_TRACK_REMOTE;
 =09cfg->trust_ctime =3D 1;
diff --git a/environment.h b/environment.h
index deabc5ef30..de6e80cce2 100644
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

