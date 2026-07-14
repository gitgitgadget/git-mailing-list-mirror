Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31553A0E8D
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 03:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783999562; cv=none; b=hLQI1xqdEdlKLPcbxXAZ8Ok6bN6iOpfOiY9FU6koP8peKIa5tHYWGkddtIkq0RfcSzvvWIfA7EVt7VJV81RnbJpIKQ+LlKn48R1GqRXuogv8Y5HU/japAzCj1Bp57KiwKxnm0aKGvMCQycKdk8WXi2uZmy9dK2JbysO7O5f+9dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783999562; c=relaxed/simple;
	bh=zLQVtUwRY+W1JycsEoeWqiP9woapJb8x9YWAFydYNpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SfKV7tIrww9H62XBLcspXWJxIwykMwKYYDekjUGFiy2gOKg5k955Bgv7W48HSuRXSh0s+0pEwpq2yG76406HvzDReY8VterHHvk1Vq8negN9bcXQbtN7y6tEVLx/aFPOMSfYqRwld7c4VW1kjh1pXD/xtvn2FPOZG7VyGgSe5I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=NFaWi2sw; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=MgboqSwi; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="NFaWi2sw";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="MgboqSwi"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=NFaWi2swJErqFknovlKY3278V8r4d5dTSdxiJ+Klz2/pUEW76D51IYjQR+872KNgOGSw2pSFK6NO8IHW0IKbVdmzGpLn328qw5tmxChSAubuJWaz2hHFfnmcMXRhpIdcC05pskLV5FDYk4ABuHR+APSPO31fDVnXnFTmFD9bDDSMl9L8kCgnJAS4qeqWbERWpmpuS0wUA8NE2Sae2dMRed5yb96MJbpzzstjts7k/eACokNW+pVwTjWp3j8tsK2FJusy5bbcV90Nv8vbbZ2pAoz0Ds/NsdXqp9aLjqftifb257f5W1Y9SP5TMRgHz8S9ilJGGUOwMsdtmlgf88iZ/g==; s=purelymail1; d=malon.dev; v=1; bh=zLQVtUwRY+W1JycsEoeWqiP9woapJb8x9YWAFydYNpg=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=MgboqSwiRkOYAO5PqTdZLSljsUKFXYaN11BdvUYLxSJoZqva8nZc1Ixbnt8nfy3wYTLEauWGoW1+S2OSRxd+0TtEXDOLkF+mi/X7sx8HBCwWdX5xvVzLE0a9IkVH2HbiagK6nkLlZwpTlUO2/uGXkFPc/3uMm5/NIuXYiePambrhtLXxMLpAqVbP/vtMQvyQha20wCy/HJwRWSrBqA/vmCm2+uvpEGljIG9qAYxIRNaHqK+NkQlI7bZyewS8FarWe+TrUbULiaWqo1mxBOxsTnOiZga3wURhKe61hyeSAsdBTpfYwuJRmA26grdIwCPv3Fj1bpHojzfm9MD4FzIyrQ==; s=purelymail1; d=purelymail.com; v=1; bh=zLQVtUwRY+W1JycsEoeWqiP9woapJb8x9YWAFydYNpg=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1695711826;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 14 Jul 2026 03:25:59 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v12 08/10] environment: move autorebase into repo_config_values
Date: Tue, 14 Jul 2026 11:25:23 +0800
Message-ID: <20260714032525.1611141-9-cat@malon.dev>
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

The global variable 'autorebase' dictates whether a newly created
branch should be configured to automatically rebase by default.
Move it into 'struct repo_config_values' to continue the
libification effort.

The 'enum rebase_setup_type' definition is moved higher up in
'environment.h' so that it is visible to the repository-specific
structure. The default state AUTOREBASE_NEVER is now correctly
initialized in 'repo_config_values_init()'.

Configuration parsing in 'git_default_branch_config()' is updated to
write directly to the repository's configuration instance.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 branch.c      |  2 +-
 environment.c | 10 +++++-----
 environment.h | 16 ++++++++--------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/branch.c b/branch.c
index 243db7d0fc..e1c1f8c89d 100644
--- a/branch.c
+++ b/branch.c
@@ -61,7 +61,7 @@ static int find_tracked_branch(struct remote *remote, voi=
d *priv)
=20
 static int should_setup_rebase(const char *origin)
 {
-=09switch (autorebase) {
+=09switch (repo_config_values(the_repository)->autorebase) {
 =09case AUTOREBASE_NEVER:
 =09=09return 0;
 =09case AUTOREBASE_LOCAL:
diff --git a/environment.c b/environment.c
index 66c1ac1ab8..c0bf7577b7 100644
--- a/environment.c
+++ b/environment.c
@@ -57,7 +57,6 @@ enum auto_crlf auto_crlf =3D AUTO_CRLF_FALSE;
 enum eol core_eol =3D EOL_UNSET;
 int global_conv_flags_eol =3D CONV_EOL_RNDTRP_WARN;
 char *check_roundtrip_encoding;
-enum rebase_setup_type autorebase =3D AUTOREBASE_NEVER;
 #ifndef OBJECT_CREATION_MODE
 #define OBJECT_CREATION_MODE OBJECT_CREATION_USES_HARDLINKS
 #endif
@@ -601,13 +600,13 @@ static int git_default_branch_config(const char *var,=
 const char *value)
 =09=09if (!value)
 =09=09=09return config_error_nonbool(var);
 =09=09else if (!strcmp(value, "never"))
-=09=09=09autorebase =3D AUTOREBASE_NEVER;
+=09=09=09cfg->autorebase =3D AUTOREBASE_NEVER;
 =09=09else if (!strcmp(value, "local"))
-=09=09=09autorebase =3D AUTOREBASE_LOCAL;
+=09=09=09cfg->autorebase =3D AUTOREBASE_LOCAL;
 =09=09else if (!strcmp(value, "remote"))
-=09=09=09autorebase =3D AUTOREBASE_REMOTE;
+=09=09=09cfg->autorebase =3D AUTOREBASE_REMOTE;
 =09=09else if (!strcmp(value, "always"))
-=09=09=09autorebase =3D AUTOREBASE_ALWAYS;
+=09=09=09cfg->autorebase =3D AUTOREBASE_ALWAYS;
 =09=09else
 =09=09=09return error(_("malformed value for %s"), var);
 =09=09return 0;
@@ -728,6 +727,7 @@ void repo_config_values_init(struct repo_config_values =
*cfg)
 =09cfg->apply_default_whitespace =3D NULL;
 =09cfg->apply_default_ignorewhitespace =3D NULL;
 =09cfg->push_default =3D PUSH_DEFAULT_UNSPECIFIED;
+=09cfg->autorebase =3D AUTOREBASE_NEVER;
 =09cfg->apply_sparse_checkout =3D 0;
 =09cfg->branch_track =3D BRANCH_TRACK_REMOTE;
 =09cfg->trust_ctime =3D 1;
diff --git a/environment.h b/environment.h
index 17a3a628d2..46b2f0d861 100644
--- a/environment.h
+++ b/environment.h
@@ -102,6 +102,13 @@ enum push_default_type {
 =09PUSH_DEFAULT_UNSPECIFIED
 };
=20
+enum rebase_setup_type {
+=09AUTOREBASE_NEVER =3D 0,
+=09AUTOREBASE_LOCAL,
+=09AUTOREBASE_REMOTE,
+=09AUTOREBASE_ALWAYS
+};
+
 struct repo_config_values {
 =09/* section "core" config values */
 =09char *attributes_file;
@@ -112,6 +119,7 @@ struct repo_config_values {
 =09char *apply_default_whitespace;
 =09char *apply_default_ignorewhitespace;
 =09enum push_default_type push_default;
+=09enum rebase_setup_type autorebase;
 =09int apply_sparse_checkout;
 =09int trust_ctime;
 =09int check_stat;
@@ -205,14 +213,6 @@ extern unsigned long pack_size_limit_cfg;
 extern int protect_hfs;
 extern int protect_ntfs;
=20
-enum rebase_setup_type {
-=09AUTOREBASE_NEVER =3D 0,
-=09AUTOREBASE_LOCAL,
-=09AUTOREBASE_REMOTE,
-=09AUTOREBASE_ALWAYS
-};
-extern enum rebase_setup_type autorebase;
-
 enum object_creation_mode {
 =09OBJECT_CREATION_USES_HARDLINKS =3D 0,
 =09OBJECT_CREATION_USES_RENAMES =3D 1
--=20
2.43.0

