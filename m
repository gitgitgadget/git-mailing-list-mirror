Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14C1371CE2
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 16:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783613551; cv=none; b=bB0Ih4hqtJdCyj21PPsxEa1bwzXrkhDKt03yqiD4C71Xd9SXHfQZcDcgpmskRaI3DLU/D2KGGQTmPWjC5XN/P7+u16ARbo27+AFhgIc9pyDaxrhzkXQYZdXBTF0hbp9pQ8TeJT8EXrHk/lo1OsbytbdpQ0bQ8BTubfkAnN+Nt+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783613551; c=relaxed/simple;
	bh=WFn61YskqVAnt0y/VnVfWSLJye/xzTUP3Cbobh+Kw+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iSmn3ccxS2uNxgdG4qmMFtxHg9iVB7MqpNW8CU84FM9Gpfs0YMrcKxnAS/TSkctJcvVi8+Vw1iyDMjLvEI1uNoW1QLLm8dORD0Sflyes/4PJNkagNxT0kpL/Zr8gD6VBNePck0/LtifxOp0SCsEcjDQTeQehmu1dbAEcCBNtXyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=VWwPa6jm; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=LLxWjN9n; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="VWwPa6jm";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="LLxWjN9n"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=VWwPa6jmcBZTLJ19e+6EakxB6ukfZX9eA6GpdVlGhSrUO7xPzRm0+DzYu2wX0l2J9OTA+qu9zGO5O6kLzUm6tJnM0NnD6pPJufXBkAJXfhhejy3wpkwwH1EuQTVv0Wm8G0TjXZhW3IjDPv0GaFaa5emlYP5QvdlF00R/LYEDdrk9+vxdzpIDLjZPep56H7VFrT1SOx4o5fGzVLAv1b9IfFKG9F7ggilrmZfOnGN1343MCYGvs5xvbTvCLcSusLOo8WARGN/EkhuMKltwUfx4kIum5kQ2AX6ujAdMftMDMPiQTlMKhECrx7rPjjpk18YTb8zClBfnLoA/wPAAzEfBZQ==; s=purelymail1; d=malon.dev; v=1; bh=WFn61YskqVAnt0y/VnVfWSLJye/xzTUP3Cbobh+Kw+4=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=LLxWjN9nIuBadXheg4CRlNZF6P6kXQfJTsMs2dowe5ngp2FZA7RYZaonTCw15Qs0+vVi+na044asrLfCLAVyd2G2XyHKM6AqSr94T24c3yrOTzKpbKOwN12NmAnZkMU+0PZ1XxrrIxawy6qUJDTo27GH//O90ytZinIeFi0u0Xnj9g7PCttZ+opnXtGIOwTP3EhPoPm8yqWoQpWcLxaRrlS/Z59OAjodRO6gaoHSmJh9QypgbqCTY0ZhdkRz04QlkEemXkaC7noNK20U27B4WefD1SDnDH8BtyW12qw9TeXaHTYQC1UQ5bSIVXbvnlwnTf0r+tjSAqiftDZ5uNh3/A==; s=purelymail1; d=purelymail.com; v=1; bh=WFn61YskqVAnt0y/VnVfWSLJye/xzTUP3Cbobh+Kw+4=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 872182701;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 09 Jul 2026 16:12:27 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v9 6/9] environment: migrate apply_default_whitespace and apply_default_ignorewhitespace
Date: Fri, 10 Jul 2026 00:11:42 +0800
Message-ID: <20260709161145.13349-7-cat@malon.dev>
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
 apply.c       | 20 ++++++++++++--------
 environment.c |  6 ++++--
 environment.h |  4 ++--
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/apply.c b/apply.c
index 249248d4f2..66db9b7678 100644
--- a/apply.c
+++ b/apply.c
@@ -47,11 +47,13 @@ struct gitdiff_data {
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
+=09repo_config_get_string(repo, "apply.whitespace",
+=09=09=09       &repo_config_values(repo)->apply_default_whitespace);
+=09repo_config_get_string(repo, "apply.ignorewhitespace",
+=09=09=09       &repo_config_values(repo)->apply_default_ignorewhitespace)=
;
+=09repo_config(repo, git_xmerge_config, NULL);
 }
=20
 static int parse_whitespace_option(struct apply_state *state, const char *=
option)
@@ -126,10 +128,12 @@ int init_apply_state(struct apply_state *state,
 =09strset_init(&state->kept_symlinks);
 =09strbuf_init(&state->root, 0);
=20
-=09git_apply_config();
-=09if (apply_default_whitespace && parse_whitespace_option(state, apply_de=
fault_whitespace))
+=09git_apply_config(repo);
+=09if (repo_config_values(repo)->apply_default_whitespace &&
+=09    parse_whitespace_option(state, repo_config_values(repo)->apply_defa=
ult_whitespace))
 =09=09return -1;
-=09if (apply_default_ignorewhitespace && parse_ignorewhitespace_option(sta=
te, apply_default_ignorewhitespace))
+=09if (repo_config_values(repo)->apply_default_ignorewhitespace &&
+=09    parse_ignorewhitespace_option(state, repo_config_values(repo)->appl=
y_default_ignorewhitespace))
 =09=09return -1;
 =09return 0;
 }
@@ -192,7 +196,7 @@ int check_apply_state(struct apply_state *state, int fo=
rce_apply)
=20
 static void set_default_whitespace_mode(struct apply_state *state)
 {
-=09if (!state->whitespace_option && !apply_default_whitespace)
+=09if (!state->whitespace_option && !repo_config_values(state->repo)->appl=
y_default_whitespace)
 =09=09state->ws_error_action =3D (state->apply ? warn_on_ws_error : nowarn=
_ws_error);
 }
=20
diff --git a/environment.c b/environment.c
index 3782bf68aa..8744790219 100644
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
@@ -725,6 +723,8 @@ void repo_config_values_init(struct repo_config_values =
*cfg)
 =09cfg->editor_program =3D NULL;
 =09cfg->pager_program =3D NULL;
 =09cfg->askpass_program =3D NULL;
+=09cfg->apply_default_whitespace =3D NULL;
+=09cfg->apply_default_ignorewhitespace =3D NULL;
 =09cfg->apply_sparse_checkout =3D 0;
 =09cfg->branch_track =3D BRANCH_TRACK_REMOTE;
 =09cfg->trust_ctime =3D 1;
@@ -758,4 +758,6 @@ void repo_config_values_clear(struct repository *repo)
 =09FREE_AND_NULL(cfg->editor_program);
 =09FREE_AND_NULL(cfg->pager_program);
 =09FREE_AND_NULL(cfg->askpass_program);
+=09FREE_AND_NULL(cfg->apply_default_whitespace);
+=09FREE_AND_NULL(cfg->apply_default_ignorewhitespace);
 }
diff --git a/environment.h b/environment.h
index d55b1ba073..9aecd64152 100644
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

