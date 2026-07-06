Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A658E37FF5D
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 14:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347989; cv=none; b=GJmukswy2+4j5uOk0UIeX5Zxi0WqzE1SsGUOgfxi7pnXCF1l/E4swqTbM4i4EEhdvfykfDFd4RPaMGTYZYsuyKxFgGeUukMx0qhG8yV/baDXBHOFatSceloR0o03yJA+2K/VtKgXkHXJzIjzQg+EuZNm1se60xsbm9A8fWrPyr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347989; c=relaxed/simple;
	bh=K4jDaSTMeoolyDMlvZgBzQQYQjZYFcmdA8FZogWfkow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L+g5XfFq+DfvYcfmL+3SCTOpmnbW8KO0U0z+hMsvnjayWAiQYre+AdMyiiWYKp9J9Rd8Aqnpb1PBAMGwZsQ2nsdCCV8mq82L1MtxeJKQCXA3S1MZCHurxbzu/kGowlpLC25MBDHEAYgPd6LZZw7wLnGNpDz4vNWkaVbHGmp8+1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=Lkb5oMxt; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=BbFeP6XL; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="Lkb5oMxt";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="BbFeP6XL"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=Lkb5oMxtiMcfWV1D36PjA3+rMhKD5g+6P6mZjqW9YblhzqwQJK+J+EKMbMCyK2Fv+eMqAcz1j1YtHrT3ZUHSo+R/7S73sIkK57c8j+Ss4uSs9vQLhTjRfkp6Ck9wfDmb8zMXeQmvuHhBmasKr+f/Xs3NW39crDHzpheSYPpcWVRH6jRjx41slNRKdSW+zuq5IxvssPKJIq4Mxb1Cfed6XMZoC9iLXwXrw6fjFmjo8HlIjJFT1utALTJCgxuXXfz4VQxZVf3J3E4munSSCH58ok/qyNON8XiRYI7RwuniQLKzOL4xq0fkA3UoLKBcWxIyr66dGcJMwqHp3WACjm1UuQ==; s=purelymail3; d=malon.dev; v=1; bh=K4jDaSTMeoolyDMlvZgBzQQYQjZYFcmdA8FZogWfkow=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=BbFeP6XLQaJoWvY2wnnVgczn6Y+29XxFnMNrH+YhkjeKFVu0BaUtJTcUsBrnzh7pse61I59xgc4R78rSpHh98V1uHIMyd+7pw7NoPjpp2Kax8kEgXyGLWKkD3Kdm27ry4Y2CxoDuN5F1+IaiP58HCiM8dBKtpJfhCUbtL5Pa0fbhQ3m5mprcAFeS4gjrTyYd+RVSFCuj3wHvvLozs1uH4MTLMNyiZtEOXNgWp3dzpS2QbUVC6KN1f7nnCTyvTGtu8bbt+p7cKdMlIlSqe4vN+UZd3jIH0ci9dO7+rSFD1qPgZJqXfjMGKawKH4nCAgct3KvZQSVgR7eJ9cB0ohT8PA==; s=purelymail3; d=purelymail.com; v=1; bh=K4jDaSTMeoolyDMlvZgBzQQYQjZYFcmdA8FZogWfkow=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1851978137;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 06 Jul 2026 14:26:25 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v7 8/9] environment: move autorebase into repo_config_values
Date: Mon,  6 Jul 2026 22:25:29 +0800
Message-ID: <20260706142530.3681520-9-cat@malon.dev>
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
index 09de2fee87..7701aa3bc0 100644
--- a/environment.c
+++ b/environment.c
@@ -58,7 +58,6 @@ enum auto_crlf auto_crlf =3D AUTO_CRLF_FALSE;
 enum eol core_eol =3D EOL_UNSET;
 int global_conv_flags_eol =3D CONV_EOL_RNDTRP_WARN;
 char *check_roundtrip_encoding;
-enum rebase_setup_type autorebase =3D AUTOREBASE_NEVER;
 #ifndef OBJECT_CREATION_MODE
 #define OBJECT_CREATION_MODE OBJECT_CREATION_USES_HARDLINKS
 #endif
@@ -600,13 +599,13 @@ static int git_default_branch_config(const char *var,=
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
@@ -727,6 +726,7 @@ void repo_config_values_init(struct repo_config_values =
*cfg)
 =09cfg->apply_default_whitespace =3D NULL;
 =09cfg->apply_default_ignorewhitespace =3D NULL;
 =09cfg->push_default =3D PUSH_DEFAULT_UNSPECIFIED;
+=09cfg->autorebase =3D AUTOREBASE_NEVER;
 =09cfg->apply_sparse_checkout =3D 0;
 =09cfg->branch_track =3D BRANCH_TRACK_REMOTE;
 =09cfg->trust_ctime =3D 1;
diff --git a/environment.h b/environment.h
index 72859b5d76..464ff73136 100644
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

