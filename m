Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D90298CA3
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 14:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347980; cv=none; b=I+Y8KGeoncNWJb9Hg1SfohxknGQivMrzoZ+deNwIpK4VHoBh62vlgMtBiW7lOWX6U6t1zdDwGX32jzhb84QJHhfWLTrEjgtjVpuFCwBWDH+O6dKx0HqwoLd/LYvm9G+rJuOs1bkLcXO3EokuSAieWgw3cOzHlBeb94w+natKdFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347980; c=relaxed/simple;
	bh=WFn61YskqVAnt0y/VnVfWSLJye/xzTUP3Cbobh+Kw+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DUtbARyisYY1ymt29QNbpyW3YVzQFD186X+ieqp6B4oazy1gtUIk3lI5iXuYBm67NebWu3m1iI1Ws7h3VfpMSbrH93Mjm3MnhBhyGrf6Li5mTpQcKwD1gFmTx7w6Lfr0uArIFpvQAWUoexNwSdpOdGWVEjjfK1bd+/8sZliRU14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=HiqAEUCa; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=UDalEw1x; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="HiqAEUCa";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="UDalEw1x"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=HiqAEUCadkQpgvDZ8CSve93H0tiyPPEdMpwmoWRDiPCvd/mbi1CF2PEM3VLhC/NYQO+SZtFrpO3HWJelpa83LxeHowVyH1sYQ5S57RZmB8PqgO3jc1dVrRzfXoM5jO8zxCt6k1s2dkywi6z3Xtfn9Bt8dxo7Mk1z/8kOtQc9DrABnxLlpsFIYXGc7y7REKk+BfMEu5Ye3nhICQOO6QcH9lxHcXH2uV01Rb44LoK0HPuqfQTHSQE8TgD342kmqMrW7pZo8JIB3UGz5J03pjFbrIltOVp1pgVN4XNOdHe8bOs6ieowMzZpqso1QDunq5XibnH9lvIYlveltwfjCv+Oog==; s=purelymail3; d=malon.dev; v=1; bh=WFn61YskqVAnt0y/VnVfWSLJye/xzTUP3Cbobh+Kw+4=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=UDalEw1xG+4LkHPQ0YiyIWQqVL1bERq+b2XSXRkIVoYJ5/IRocRK+sSPHFutk/CZtBJ5cjWwss+PjLaU+ZcG4HbumIEsGX1aX6FHmhPEkxIVMy31J/YBNFhS+BDDysztbBRyD88zxjwi3OhjW6gxFjNjPWyDCC/WKotIA/wQuTKMXrVd2mcoaEFn1C1YN0gw9vBe0/UkvYfvKK+xa7A/jl6b/E4GrMHJjikPleqoVEzECmj99Z2yZmH+b74CXmGssq8g1XVGi+WSFn341kT06KYoqhkBcNos+ev+WnjNvCLdG3sdoFiM/IpynhqWcpobxHzswVZxf14VB6ci7BPM3A==; s=purelymail3; d=purelymail.com; v=1; bh=WFn61YskqVAnt0y/VnVfWSLJye/xzTUP3Cbobh+Kw+4=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1851978137;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 06 Jul 2026 14:26:17 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v7 6/9] environment: migrate apply_default_whitespace and apply_default_ignorewhitespace
Date: Mon,  6 Jul 2026 22:25:27 +0800
Message-ID: <20260706142530.3681520-7-cat@malon.dev>
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

