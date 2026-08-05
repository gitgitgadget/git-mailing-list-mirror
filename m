Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F5B4446E7
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 11:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785930858; cv=none; b=uiZ8KKXwDlIJWrHvtGtqhE3ou7z/tYb3ws55v4xndInSpul2WEFYWy5SOhFIwsrZaSXKBRlrkrtGmSITJILhAZxSIj2z8hx22DBjjF3JH+q97ISz12dPJW4yjyf++kBO6rBJSPwDa/jG+Zj3UVjyKaJpdddbh0N2PG710emrMeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785930858; c=relaxed/simple;
	bh=ij+WR2kl1KTQ6zSI+JbhtYUtu7xMff4TAoSPBILR0vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZnwVZvXZF1p97MOfSibo/MHJ63q535OpIhs2LOqKgDnbGyIq1AIlQ24y1xR4hTRZ5N3vdZhjmiyYOpX3FQyOBxRK9FEZhAf8MkZkzPMRPv41SD4wuyNyhrne82r0S9hlUO3J8P9RgFB1+uo1wj2+z/PaB0nHugmxTbJdB1ihkjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=EVBMbWwc; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=HarlmeCD; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="EVBMbWwc";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="HarlmeCD"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=EVBMbWwcJ0AxJsjcXrw4kTI11vbLm3xh3oYW3CGKnXyWKDT0d+trSOeVa6cXvPHet3BME0lTw5jzlwITSkpNlm02QZ44ztNH3HXe/+bpzBi6Z2XYT3VBroBZVC3P9s8j+Dmq+trSPzTkpaG+jlxC9e/xNB6uRoPEIhHVahc8BHSWfIWWV67k3yOIhIjQcSxGOoiVMMVvrNXO2PnkWWQ6C6pkk41decMwHeAWsYMweDs28PI9RGq64xF61YS9P7eLAZvZ4xn1zoZs4DAOtzEGecHoW5+SajsR/49mlLWrMLiLVjvYuI3dOZEpCf9OWOHTUdQK+28Y9tUmcDyhcscc5g==; s=purelymail1; d=malon.dev; v=1; bh=ij+WR2kl1KTQ6zSI+JbhtYUtu7xMff4TAoSPBILR0vo=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=HarlmeCDJH/+Bs0L9JjXdaryyedt+GkrYLhyuxXpj2IZx0PXAeigfXQ+THv1ONhXU9Ba22AeLvSmY8UtR5Cz2/QmDTyeGt+0TZ4NGiaGzQUf26YNkttedl+TpSEe+YFoAXAcBHi2+zZCWFqtXVYsBZyMbZu4jm1s+r9WXHl3poaJ2uzJE45BlNehCgqEZArXklQl2AfUR1RvNDE91dH5zS1Wv2GNcoYFo6yNQtOx/U/37jP8y3xFboTdz2D1b/OprfmKKc09vn4u4kPcEbgekbQgOHWXXyqiQ5oadkcbMBNkATt1LcS2Q4ADuuyGDVz4zmxQrpEdPrPU25HmWpmLwg==; s=purelymail1; d=purelymail.com; v=1; bh=ij+WR2kl1KTQ6zSI+JbhtYUtu7xMff4TAoSPBILR0vo=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1777023232;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 05 Aug 2026 11:54:14 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH 3/3] environment: reorder variables in repo_config_values structure
Date: Wed,  5 Aug 2026 19:53:41 +0800
Message-ID: <20260805115342.3939931-4-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805115342.3939931-1-cat@malon.dev>
References: <20260805115342.3939931-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Reorder the fields in struct repo_config_values and its initialization
function to follow the order of configuration sections.

Keeping the declaration and initialization order aligned makes the
structure easier to review and maintain.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 environment.c | 31 +++++++++++++++++++++----------
 environment.h | 20 +++++++++++++-------
 2 files changed, 34 insertions(+), 17 deletions(-)

diff --git a/environment.c b/environment.c
index f5628b6758..918d8b50b8 100644
--- a/environment.c
+++ b/environment.c
@@ -745,31 +745,42 @@ int git_default_config(const char *var, const char *v=
alue,
=20
 void repo_config_values_init(struct repo_config_values *cfg)
 {
+=09/* core */
 =09cfg->attributes_file =3D NULL;
 =09cfg->excludes_file =3D NULL;
 =09cfg->editor_program =3D NULL;
 =09cfg->pager_program =3D NULL;
 =09cfg->askpass_program =3D NULL;
-=09cfg->apply_default_whitespace =3D NULL;
-=09cfg->apply_default_ignorewhitespace =3D NULL;
-=09cfg->push_default =3D PUSH_DEFAULT_UNSPECIFIED;
-=09cfg->autorebase =3D AUTOREBASE_NEVER;
 =09cfg->object_creation_mode =3D OBJECT_CREATION_MODE;
 =09cfg->apply_sparse_checkout =3D 0;
+=09cfg->trust_ctime =3D 1;
+=09cfg->check_stat =3D 1;
+=09cfg->zlib_compression_level =3D Z_BEST_SPEED;
+=09cfg->precomposed_unicode =3D -1;
+=09cfg->core_sparse_checkout_cone =3D 0;
+=09cfg->warn_on_object_refname_ambiguity =3D 1;
 =09cfg->protect_hfs =3D PROTECT_HFS_DEFAULT;
 =09cfg->protect_ntfs =3D PROTECT_NTFS_DEFAULT;
 =09cfg->ignore_case =3D 0;
 =09cfg->trust_executable_bit =3D 1;
 =09cfg->has_symlinks =3D platform_has_symlinks();
+
+=09/* apply */
+=09cfg->apply_default_whitespace =3D NULL;
+=09cfg->apply_default_ignorewhitespace =3D NULL;
+
+=09/* branch */
+=09cfg->autorebase =3D AUTOREBASE_NEVER;
 =09cfg->branch_track =3D BRANCH_TRACK_REMOTE;
-=09cfg->trust_ctime =3D 1;
-=09cfg->check_stat =3D 1;
-=09cfg->zlib_compression_level =3D Z_BEST_SPEED;
+
+=09/* pack */
 =09cfg->pack_compression_level =3D Z_DEFAULT_COMPRESSION;
-=09cfg->precomposed_unicode =3D -1; /* see probe_utf8_pathname_composition=
() */
-=09cfg->core_sparse_checkout_cone =3D 0;
+
+=09/* push */
+=09cfg->push_default =3D PUSH_DEFAULT_UNSPECIFIED;
+
+=09/* sparse */
 =09cfg->sparse_expect_files_outside_of_patterns =3D 0;
-=09cfg->warn_on_object_refname_ambiguity =3D 1;
 }
=20
 void repo_config_values_clear(struct repo_config_values *cfg)
diff --git a/environment.h b/environment.h
index 30678257b5..52ed13c0fc 100644
--- a/environment.h
+++ b/environment.h
@@ -121,16 +121,11 @@ struct repo_config_values {
 =09char *editor_program;
 =09char *pager_program;
 =09char *askpass_program;
-=09char *apply_default_whitespace;
-=09char *apply_default_ignorewhitespace;
-=09enum push_default_type push_default;
-=09enum rebase_setup_type autorebase;
 =09enum object_creation_mode object_creation_mode;
 =09int apply_sparse_checkout;
 =09int trust_ctime;
 =09int check_stat;
 =09int zlib_compression_level;
-=09int pack_compression_level;
 =09int precomposed_unicode;
 =09int core_sparse_checkout_cone;
 =09int warn_on_object_refname_ambiguity;
@@ -140,11 +135,22 @@ struct repo_config_values {
 =09int trust_executable_bit;
 =09int has_symlinks;
=20
-=09/* section "sparse" config values */
-=09int sparse_expect_files_outside_of_patterns;
+=09/* section "apply" config values */
+=09char *apply_default_whitespace;
+=09char *apply_default_ignorewhitespace;
=20
 =09/* section "branch" config values */
+=09enum rebase_setup_type autorebase;
 =09enum branch_track branch_track;
+
+=09/* section "pack" config values */
+=09int pack_compression_level;
+
+=09/* section "push" config values */
+=09enum push_default_type push_default;
+
+=09/* section "sparse" config values */
+=09int sparse_expect_files_outside_of_patterns;
 };
=20
 struct repo_config_values *repo_config_values(struct repository *repo);
--=20
2.43.0

