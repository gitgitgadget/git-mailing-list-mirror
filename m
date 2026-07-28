Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44832D0C82
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 01:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785203204; cv=none; b=fFpo6IFrMT4cyVd2IrnAkj70N0kQuZ4+ZNiRBcVFHjQvMTzrs1K7IiQ5Y1FKRfPuQ+kdA/NRLno5qPNPXTdDHHNW7rcAFEMekqgHgPKYgzGBlinGLFOJlRzAzYJ6IPgvfwKbvW/8Z0vqxaMnEGDojNkJOwNiFQvHLrvGR74CIoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785203204; c=relaxed/simple;
	bh=ujpIyLfH7Tr5H7p8R/3qYJb0biA/YUL2eA3LXZCQwCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EhT6i54BGnxnzAkmG0qQjHlRoaJ+UCOslLxu87V79ZGmTiVUXtGRYCP2DZbR+/NzDFRXHB+RKCR9Z/EDwC+JEVJ2XbgF+pey92iN+qcaFiliAi9zZg6tuVNejoFGeFbIwDtZNE2pvgaOWAszW7/rjTeTmO/hq1z+Ylgm6xHj5X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=pAKTB/ic; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=pP2fYXbP; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="pAKTB/ic";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="pP2fYXbP"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=pAKTB/icpOgLgFhnmF+AdD7Csovib+nST8NzrMxEy2ogLppf+k9wCZ1VCG/rYmJk3ntBjPnBdv43139PnIytMsgzGhjBX0tlkQDqBsMqSMpYw6nVuMXM/OJ8XCDIEuRQjBNBZQQ8oMEnUzQENwzn2/oCLgpenEeYb6c2hxk80EtFH77OabcWU2Dnr142aH275GXKwzU7fu9ncSsbRB0DZY/tlsmIVQpuxhxNnYRmXpka/IBGb65tP3Njz6pOUIsJGOM+xrA9nlh6kzr9R00h/iqDpfKxW1tgf0sahT9ErVkL2akJfb9459eSj3y2vACBzRCztnVx1adG9v2rEHqBCQ==; s=purelymail3; d=malon.dev; v=1; bh=ujpIyLfH7Tr5H7p8R/3qYJb0biA/YUL2eA3LXZCQwCM=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=pP2fYXbP6sBpZilnGiit8GgdEkA2uUvSbX7ki9lV2y2URyE0+RD1u+yG8fEptP6jBMbDfge2tF9BTwNA3X46Yoeoc/FEwN50ECD8b2jI0Q3TBGw/wKOWgnLZegZ2ykRWZPw/OJwJiryb+T9DFVbCRsT+o2sRWIRVrcMAYouRaJZpDViXHmYBExmUO/7ob0WB3v+44WZd+sVhih4vWnAH8+lFRvUgHhwsaW8Tlc2kMAjTIpOuuv/wonPc8DjluTK9mE7LzDakxQhOE0ZLBqOM51htFlZqOmOHM/yF5sXGW76C1p8uME0alJemZj+QGq08XmvtGEA5F8bbdqOzGmT4rg==; s=purelymail3; d=purelymail.com; v=1; bh=ujpIyLfH7Tr5H7p8R/3qYJb0biA/YUL2eA3LXZCQwCM=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1180613032;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 28 Jul 2026 01:46:40 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v2 1/2] environment: migrate pack_size_limit_cfg into repo_config_values
Date: Tue, 28 Jul 2026 09:46:29 +0800
Message-ID: <20260728014630.3284974-2-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728014630.3284974-1-cat@malon.dev>
References: <20260725115428.2214202-1-cat@malon.dev>
 <20260728014630.3284974-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Move the global 'pack_size_limit_cfg' configuration into the
repository-specific 'repo_config_values' struct.

We do not introduce a getter for it because the readers are
limited and no hardcoded fallback values are needed.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 builtin/pack-objects.c | 2 +-
 environment.c          | 4 ++--
 environment.h          | 3 ++-
 object-file.c          | 5 +++--
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 3673b14b89..4ebcaccb09 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -5328,7 +5328,7 @@ int cmd_pack_objects(int argc,
 =09if (!HAVE_THREADS && delta_search_threads !=3D 1)
 =09=09warning(_("no threads support, ignoring --threads"));
 =09if (!pack_to_stdout && !pack_size_limit)
-=09=09pack_size_limit =3D pack_size_limit_cfg;
+=09=09pack_size_limit =3D cfg->pack_size_limit_cfg;
 =09if (pack_to_stdout && pack_size_limit)
 =09=09die(_("--max-pack-size cannot be used to build a pack for transfer")=
);
 =09if (pack_size_limit && pack_size_limit < 1024*1024) {
diff --git a/environment.c b/environment.c
index c663113e8a..53623518c7 100644
--- a/environment.c
+++ b/environment.c
@@ -67,7 +67,6 @@ enum push_default_type push_default =3D PUSH_DEFAULT_UNSP=
ECIFIED;
 #endif
 enum object_creation_mode object_creation_mode =3D OBJECT_CREATION_MODE;
 int grafts_keep_true_parents;
-unsigned long pack_size_limit_cfg;
=20
 #ifndef PROTECT_HFS_DEFAULT
 #define PROTECT_HFS_DEFAULT 0
@@ -704,7 +703,7 @@ int git_default_config(const char *var, const char *val=
ue,
 =09}
=20
 =09if (!strcmp(var, "pack.packsizelimit")) {
-=09=09pack_size_limit_cfg =3D git_config_ulong(var, value, ctx->kvi);
+=09=09cfg->pack_size_limit_cfg =3D git_config_ulong(var, value, ctx->kvi);
 =09=09return 0;
 =09}
=20
@@ -742,4 +741,5 @@ void repo_config_values_init(struct repo_config_values =
*cfg)
 =09cfg->core_sparse_checkout_cone =3D 0;
 =09cfg->sparse_expect_files_outside_of_patterns =3D 0;
 =09cfg->warn_on_object_refname_ambiguity =3D 1;
+=09cfg->pack_size_limit_cfg =3D 0;
 }
diff --git a/environment.h b/environment.h
index acfb670be1..2e0f8beac0 100644
--- a/environment.h
+++ b/environment.h
@@ -101,6 +101,8 @@ struct repo_config_values {
 =09int protect_hfs;
 =09int protect_ntfs;
 =09int ignore_case;
+=09unsigned long pack_size_limit_cfg;
+
=20
 =09/* section "sparse" config values */
 =09int sparse_expect_files_outside_of_patterns;
@@ -184,7 +186,6 @@ extern int minimum_abbrev, default_abbrev;
 extern int assume_unchanged;
 extern char *apply_default_whitespace;
 extern char *apply_default_ignorewhitespace;
-extern unsigned long pack_size_limit_cfg;
=20
 enum rebase_setup_type {
 =09AUTOREBASE_NEVER =3D 0,
diff --git a/object-file.c b/object-file.c
index 7ff2b730ac..be68eead63 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1273,6 +1273,7 @@ static int odb_transaction_files_write_object_stream(=
struct odb_transaction *bas
 =09=09=09=09=09=09     size_t size,
 =09=09=09=09=09=09     struct object_id *result_oid)
 {
+=09struct repo_config_values *cfg =3D repo_config_values(the_repository);
 =09struct odb_transaction_files *transaction =3D container_of(base,
 =09=09=09=09=09=09=09=09 struct odb_transaction_files,
 =09=09=09=09=09=09=09=09 base);
@@ -1298,8 +1299,8 @@ static int odb_transaction_files_write_object_stream(=
struct odb_transaction *bas
 =09 * the difference between the inflated and on-disk size is limited
 =09 * to zlib compression and is sufficient for this check.
 =09 */
-=09if (state->nr_written && pack_size_limit_cfg &&
-=09    pack_size_limit_cfg < state->offset + size)
+=09if (state->nr_written && cfg->pack_size_limit_cfg &&
+=09    cfg->pack_size_limit_cfg < state->offset + size)
 =09=09flush_packfile_transaction(transaction);
=20
 =09CALLOC_ARRAY(idx, 1);
--=20
2.43.0

