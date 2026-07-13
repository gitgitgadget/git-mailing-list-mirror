Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C55A367F5E
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 03:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783915092; cv=none; b=XpevyN9nunvHu8HwniHpkT1+GDHB5qOTvKaE31EAsne28NHVyGp7C/bjiXsWgodcZU8g9hsR5D6oU2JOHCN4zeyYkDfe6maWFimo05/s7YZEYDlb9PAYzjlGsuLAmegSLakUczLrzTIWT1QMu2ppZcZYNopx8hls1zB5bHGSmvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783915092; c=relaxed/simple;
	bh=J4nGHhjheGgAkFLGhL4deljLDusGQ82RzvbdPQO51+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cC6Nkl/u8cRRqVK799uLYYgubhi/dC7F81XfVRbUnaJgacAkdubV0H1wZvRDtoOZ0kPqDeLNJV/lq4ekamdsj1Ye/0W5yMBtzYDnW2v5ynyWekeJhxKDd6V+my6ZPC/ekIqg35pftpkZoF3dNsxobcRtv9eE2i6Udx6PelaHcBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=FIkQMCq6; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=dl0A86VK; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="FIkQMCq6";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="dl0A86VK"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=FIkQMCq6Rqw+Vv/fPCBadCpHuVaRmM8LkEuYYnxlJUXKscFebsCXrK4OY0SATU3W+jWSXCb7pR1UPmsDEmF8znxrUnTskOJvHSAhAZF+c1PzbdUQie64AdixJA46e/zhehaepF3YbJcix6VYBMjr3IecUEto6gQpfJ/LKmp89cqlnNnVK3nC9At1zbQ6xEi4gwF6mlaRWoFBI+ms84FdCbl/T/LwruswiiqT6RugVWD7lBAvbcAGf1f3RaBwgKXc6M+CNNi3lbNdD4qywDaVU2zf3ngm5Au6NPNf2pG2+DrubZ2/7fO4EwyFyz11LCh8cywgF0H5YH+a7QNjt1NPdw==; s=purelymail1; d=malon.dev; v=1; bh=J4nGHhjheGgAkFLGhL4deljLDusGQ82RzvbdPQO51+0=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=dl0A86VKx4C7Kfq5zBU/stU0wt8Yyqfxh8Xt66luAwtPmF9Fflyz0e44m9DKr5ilp7cNVh4b/vN3COob3ITWObimH5k8ZAr8O8Zge/73GADYbFcpqi42pW3TLq+Y/OraNK6vJzJjYeNUWm4LG/JO8wBF35x6vqfOGvMzmdnv5AzVwmPb5poSmHml5T2SkK7f/poIJ1hA7GfiWgKE4lXymNm8K8cr+/1mtb7EQXct7BRQdqwxzpgUoXHCYv9aLsMjc8n46fNNUnoj7WsFfdQrMm5dIxTBnczu151xezun45qoaJY1CZ+HLj/ZqPoOooKRWxrOiliGO2DLLrsiZzf4pQ==; s=purelymail1; d=purelymail.com; v=1; bh=J4nGHhjheGgAkFLGhL4deljLDusGQ82RzvbdPQO51+0=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1573664722;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 13 Jul 2026 03:58:07 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v11 06/10] environment: migrate apply_default_whitespace and apply_default_ignorewhitespace
Date: Mon, 13 Jul 2026 11:57:34 +0800
Message-ID: <20260713035738.1606138-7-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713035738.1606138-1-cat@malon.dev>
References: <20260712111734.1073514-1-cat@malon.dev>
 <20260713035738.1606138-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

The global variables 'apply_default_whitespace' and
'apply_default_ignorewhitespace' are used to store the default
whitespace configuration for 'git apply'. Move these variables
into 'struct repo_config_values' to continue the libification
effort.

Dynamically allocated strings fetched via 'repo_config_get_string()'
are now tracked per-repository and safely freed in
'repo_config_values_clear()'.

As part of this transition, update 'git_apply_config()' to accept a
'struct repository *' argument rather than relying on the
'the_repository' global.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 apply.c       | 28 ++++++++++++++++++++--------
 environment.c |  6 ++++--
 environment.h |  4 ++--
 3 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/apply.c b/apply.c
index 249248d4f2..f0cfd76190 100644
--- a/apply.c
+++ b/apply.c
@@ -47,11 +47,17 @@ struct gitdiff_data {
 =09int p_value;
 };
=20
-static void git_apply_config(void)
+static void git_apply_config(struct repository *repo)
 {
-=09repo_config_get_string(the_repository, "apply.whitespace", &apply_defau=
lt_whitespace);
-=09repo_config_get_string(the_repository, "apply.ignorewhitespace", &apply=
_default_ignorewhitespace);
-=09repo_config(the_repository, git_xmerge_config, NULL);
+=09struct repo_config_values *cfg =3D repo_config_values(repo);
+
+=09FREE_AND_NULL(cfg->apply_default_whitespace);
+=09repo_config_get_string(repo, "apply.whitespace",
+=09=09=09       &cfg->apply_default_whitespace);
+=09FREE_AND_NULL(cfg->apply_default_ignorewhitespace);
+=09repo_config_get_string(repo, "apply.ignorewhitespace",
+=09=09=09       &cfg->apply_default_ignorewhitespace);
+=09repo_config(repo, git_xmerge_config, NULL);
 }
=20
 static int parse_whitespace_option(struct apply_state *state, const char *=
option)
@@ -126,10 +132,15 @@ int init_apply_state(struct apply_state *state,
 =09strset_init(&state->kept_symlinks);
 =09strbuf_init(&state->root, 0);
=20
-=09git_apply_config();
-=09if (apply_default_whitespace && parse_whitespace_option(state, apply_de=
fault_whitespace))
+=09git_apply_config(repo);
+
+=09struct repo_config_values *cfg =3D repo_config_values(repo);
+
+=09if (cfg->apply_default_whitespace &&
+=09    parse_whitespace_option(state, cfg->apply_default_whitespace))
 =09=09return -1;
-=09if (apply_default_ignorewhitespace && parse_ignorewhitespace_option(sta=
te, apply_default_ignorewhitespace))
+=09if (cfg->apply_default_ignorewhitespace &&
+=09    parse_ignorewhitespace_option(state, cfg->apply_default_ignorewhite=
space))
 =09=09return -1;
 =09return 0;
 }
@@ -192,7 +203,8 @@ int check_apply_state(struct apply_state *state, int fo=
rce_apply)
=20
 static void set_default_whitespace_mode(struct apply_state *state)
 {
-=09if (!state->whitespace_option && !apply_default_whitespace)
+=09if (!state->whitespace_option &&
+=09    !repo_config_values(state->repo)->apply_default_whitespace)
 =09=09state->ws_error_action =3D (state->apply ? warn_on_ws_error : nowarn=
_ws_error);
 }
=20
diff --git a/environment.c b/environment.c
index 3857818da3..20500658a2 100644
--- a/environment.c
+++ b/environment.c
@@ -49,8 +49,6 @@ int assume_unchanged;
 int is_bare_repository_cfg =3D -1; /* unspecified */
 char *git_commit_encoding;
 char *git_log_output_encoding;
-char *apply_default_whitespace;
-char *apply_default_ignorewhitespace;
 int fsync_object_files =3D -1;
 int use_fsync =3D -1;
 enum fsync_method fsync_method =3D FSYNC_METHOD_DEFAULT;
@@ -726,6 +724,8 @@ void repo_config_values_init(struct repo_config_values =
*cfg)
 =09cfg->editor_program =3D NULL;
 =09cfg->pager_program =3D NULL;
 =09cfg->askpass_program =3D NULL;
+=09cfg->apply_default_whitespace =3D NULL;
+=09cfg->apply_default_ignorewhitespace =3D NULL;
 =09cfg->apply_sparse_checkout =3D 0;
 =09cfg->branch_track =3D BRANCH_TRACK_REMOTE;
 =09cfg->trust_ctime =3D 1;
@@ -745,4 +745,6 @@ void repo_config_values_clear(struct repo_config_values=
 *cfg)
 =09FREE_AND_NULL(cfg->editor_program);
 =09FREE_AND_NULL(cfg->pager_program);
 =09FREE_AND_NULL(cfg->askpass_program);
+=09FREE_AND_NULL(cfg->apply_default_whitespace);
+=09FREE_AND_NULL(cfg->apply_default_ignorewhitespace);
 }
diff --git a/environment.h b/environment.h
index 856dc70cc4..f450242ac0 100644
--- a/environment.h
+++ b/environment.h
@@ -94,6 +94,8 @@ struct repo_config_values {
 =09char *editor_program;
 =09char *pager_program;
 =09char *askpass_program;
+=09char *apply_default_whitespace;
+=09char *apply_default_ignorewhitespace;
 =09int apply_sparse_checkout;
 =09int trust_ctime;
 =09int check_stat;
@@ -182,8 +184,6 @@ extern int has_symlinks;
 extern int minimum_abbrev, default_abbrev;
 extern int ignore_case;
 extern int assume_unchanged;
-extern char *apply_default_whitespace;
-extern char *apply_default_ignorewhitespace;
 extern unsigned long pack_size_limit_cfg;
=20
 extern int protect_hfs;
--=20
2.43.0

