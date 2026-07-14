Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC3018D636
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 03:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783999566; cv=none; b=sceQ98zhLnL34tqhKzWDyZtFGbw3kSj7iiUvH05nFh6E+HD8/c7iH4fa5HMP5LX9daGgYmBDzntxkeuU0jHl/G508OlGhKmjE0Ly5LaLOWik9Z+bXvaz3kAxSo0YbRf1b4y2FZ7Eimub0fNi1qO6MOHaq1rwGNmrlWTn02lH48g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783999566; c=relaxed/simple;
	bh=4jDUTYdARK7xIUOKs5+OtQOx0sPnc1+aGF1NILwYPBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OrFrdeLvnjgWpQpG2J18heCmdxTknJ6SSROvgJIrcI9DofNKIPQZnV/HfjK1m0Y8JPMjynttnIYvf6XffPUS5RlQQJENtqNYo69aAkFvh6jWOrnV+SFD34QvNeydQGSwt+X+HqCbZC0cP2PjDW4u0Fzwcak8u0psKu4D2S7WI/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=bO1NZqtq; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=Nv6eB7jQ; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="bO1NZqtq";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="Nv6eB7jQ"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=bO1NZqtqq0l7kbMxo9/ey00amx5q9ai4W5WY31nUek/EZFPPqtesPUI5vG7SXoB5CI5mA85ZLN6m7tf0/qzGcXdbp9CZ1Geo3l9W6cglU1evqBMPRyYK5LHq4VBWyivv767yu8RnUPb8wACw+qJt1D5yVHWVMzXjTIXcn0KWzNKMXMcmTOIUsRrJC+93jbHXmOIZ6ihVnO0EL5M7s+xEBTG0BP5yWEUdZ4HvcEvcMDZ7L2jM/dbhdgOylOYlo3QrHbPZqtRGKOCNKedOP5WmJAMH50hR/PNKZyI3BMdz2fggK4+cUDR9Cqk8CFwpzfbU1B74XK7O9ERVmRjeL7AE7A==; s=purelymail1; d=malon.dev; v=1; bh=4jDUTYdARK7xIUOKs5+OtQOx0sPnc1+aGF1NILwYPBE=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=Nv6eB7jQfcZiz5K22E7A1En917If9h3/ksdTecd86Z+J3liraUwUZyZ0md/xI447M8JLtYO/jJmI0EQSuLlm72RPdPaiOBEDVc+4vvoKliRg1naIjOZtdG8vtQAQcf3AwKtCr2udlplVcbGZldKXidcYYFNan8zmgFLQgjwsv1huvg3HPs6WX3sfY5QfdpB4DUERq76VroPcIgHCeFJqQoJNuM9TXqNz5Y/4qYy6IYryjC+D27d6eUcpigpvov1CvYfLlsoPm0NdlE675+yHcWZbFoV7Ee0OBNG5q2FnwamQOIMD/cqx49pDz2sB4r9M7Dz1OjFkAKzufok/MUTEwA==; s=purelymail1; d=purelymail.com; v=1; bh=4jDUTYdARK7xIUOKs5+OtQOx0sPnc1+aGF1NILwYPBE=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1695711826;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 14 Jul 2026 03:26:02 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v12 09/10] environment: move object_creation_mode into repo_config_values
Date: Tue, 14 Jul 2026 11:25:24 +0800
Message-ID: <20260714032525.1611141-10-cat@malon.dev>
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
 object-file.c |  3 ++-
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/environment.c b/environment.c
index c0bf7577b7..ef3c032e0c 100644
--- a/environment.c
+++ b/environment.c
@@ -60,7 +60,6 @@ char *check_roundtrip_encoding;
 #ifndef OBJECT_CREATION_MODE
 #define OBJECT_CREATION_MODE OBJECT_CREATION_USES_HARDLINKS
 #endif
-enum object_creation_mode object_creation_mode =3D OBJECT_CREATION_MODE;
 int grafts_keep_true_parents;
 unsigned long pack_size_limit_cfg;
=20
@@ -512,9 +511,9 @@ int git_default_core_config(const char *var, const char=
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
@@ -728,6 +727,7 @@ void repo_config_values_init(struct repo_config_values =
*cfg)
 =09cfg->apply_default_ignorewhitespace =3D NULL;
 =09cfg->push_default =3D PUSH_DEFAULT_UNSPECIFIED;
 =09cfg->autorebase =3D AUTOREBASE_NEVER;
+=09cfg->object_creation_mode =3D OBJECT_CREATION_MODE;
 =09cfg->apply_sparse_checkout =3D 0;
 =09cfg->branch_track =3D BRANCH_TRACK_REMOTE;
 =09cfg->trust_ctime =3D 1;
diff --git a/environment.h b/environment.h
index 46b2f0d861..a47a5c83db 100644
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
index 9afa842da2..c00dd3afca 100644
--- a/object-file.c
+++ b/object-file.c
@@ -411,11 +411,12 @@ int finalize_object_file_flags(struct repository *rep=
o,
 {
 =09unsigned retries =3D 0;
 =09int ret;
+=09struct repo_config_values *cfg =3D repo_config_values(repo);
=20
 retry:
 =09ret =3D 0;
=20
-=09if (object_creation_mode =3D=3D OBJECT_CREATION_USES_RENAMES)
+=09if (cfg->object_creation_mode =3D=3D OBJECT_CREATION_USES_RENAMES)
 =09=09goto try_rename;
 =09else if (link(tmpfile, filename))
 =09=09ret =3D errno;
--=20
2.43.0

