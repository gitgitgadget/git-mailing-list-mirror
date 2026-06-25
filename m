Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFDD3E9C0C
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 16:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782404348; cv=none; b=uSi4VAyMYOQ5OUvJzf9OnDRr+IjUMCEU9pDh/QDKIPprGCQijJtndXM4HBnCciIS+RMYQs8p/CLDRexlV0Mwidl9LkRTqBG7RMJpksucXBfMnPx1YEYubNjQGixT1oWDG8OqhxoNrWbCC3IRmRUypYqLV8mrBl2/m4MhOIVIUS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782404348; c=relaxed/simple;
	bh=ZIhnWjgIpNvb5yuIcIxIbtvqgp0htfkOmLMwJR3mYSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D9x9CovpH9uSW+LNRrg9WBniBR7EcJjifvJRj2/+Cv1Yuo1BaGkAqLPLup/Q8Z2gGl1NpcJ+RGD5zpchpHFg/fA0ee26H7BD3nMHJyEYuR4xpysgbq5CYxUz5EXoMF0LR/k0IL0MV10IaNRq1D0ILoyU7c6c1e0CeT4U7Lh2pqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=xwDIGJ53; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=5eG4e1Vt; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="xwDIGJ53";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="5eG4e1Vt"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=xwDIGJ53YSZp1MqEO4lZOiWloYwcq/xFdi0v3UTRmChMvTvZUtUbTEcuFDR72zKZAxOqZcgI8I9j42aDouAj8jabu7PHuLuG3PNMUKU/KC6qqjT+BiVetIO52rSO05XatMCYIRD3jkh1jx7t0VTlg12dFiRsedidlEuIWfQzdK5VzLL09hAnCs/tES3k9Hmho/6LyrfcYVZ+bTkCFg9v3NBpasuNBUI9KZRTLolGfvxRjafJSpNhOgNHu2lS2ztzuiIvC3vUO+AneO5nOrS/9/WdVFR4gtIQVIJgkJLT3u17hdPnbLaol7ZgIeiMktXfW8HBPhxxpP3NKINzLjfbHQ==; s=purelymail2; d=malon.dev; v=1; bh=ZIhnWjgIpNvb5yuIcIxIbtvqgp0htfkOmLMwJR3mYSc=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=5eG4e1VtC0zmbftqFKPuRx9mFzolyNHlJdEp2CUDpdEYsYSuiA7PMDgTkKryoEqb96Ja8vyv5xTsuv7YMvt7pU0kT7+8+E+zcSpkTva/+f6sEM0PKKbVQsfRRX7v29vPkaM5vsm04lpr92uKptk53o1QPxFJaCeus4z0QnT7Loxz4hP185Gq9ymGCJguT8Y77/v+bhIGL8NmU50iwj9hKLFbkmaksv0PyNAHlN803+5KFZ21OMowfzB+zstph+W3gvwzhFVOERvvboWvKrHfXLZF/mjLF+Ilgg1TxegEyVUo8rxw3bzmmICb2JI1VVsPUCtefLysdzWAmitGKkO/fw==; s=purelymail2; d=purelymail.com; v=1; bh=ZIhnWjgIpNvb5yuIcIxIbtvqgp0htfkOmLMwJR3mYSc=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -612697585;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 25 Jun 2026 16:18:58 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: cirnovskyv@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v1 1/2] dir: encapsulate excludes_file lazy-load
Date: Fri, 26 Jun 2026 00:18:44 +0800
Message-ID: <20260625161845.7543-2-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625161845.7543-1-cat@malon.dev>
References: <20260625161845.7543-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

The global variable 'excludes_file' is used to track the path to the
global ignore file, 'core.excludesfile'. If this variable is NULL,
setup_standard_excludes() in dir.c forcefully evaluates and assigns
the XDG default path to it.

Introduce repo_excludes_file() as a getter to encapsulate this
lazy-loading logic. This prepares the variable to be safely moved
into 'struct repo_config_values' in the subsequent commit.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 dir.c         | 4 ++--
 environment.c | 7 +++++++
 environment.h | 5 +++++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 7a73690fbc..4f87a52b3c 100644
--- a/dir.c
+++ b/dir.c
@@ -3481,11 +3481,11 @@ static GIT_PATH_FUNC(git_path_info_exclude, "info/e=
xclude")
=20
 void setup_standard_excludes(struct dir_struct *dir)
 {
+=09const char *excludes_file =3D repo_excludes_file(the_repository);
+
 =09dir->exclude_per_dir =3D ".gitignore";
=20
 =09/* core.excludesfile defaulting to $XDG_CONFIG_HOME/git/ignore */
-=09if (!excludes_file)
-=09=09excludes_file =3D xdg_config_home("ignore");
 =09if (excludes_file && !access_or_warn(excludes_file, R_OK, 0))
 =09=09add_patterns_from_file_1(dir, excludes_file,
 =09=09=09=09=09 dir->untracked ? &dir->internal.ss_excludes_file : NULL);
diff --git a/environment.c b/environment.c
index ba2c60103f..8efcaeafa6 100644
--- a/environment.c
+++ b/environment.c
@@ -134,6 +134,13 @@ int is_bare_repository(void)
 =09return is_bare_repository_cfg && !repo_get_work_tree(the_repository);
 }
=20
+const char *repo_excludes_file(struct repository *repo)
+{
+=09if (!excludes_file)
+=09=09excludes_file =3D xdg_config_home("ignore");
+=09return excludes_file;
+}
+
 int have_git_dir(void)
 {
 =09return startup_info->have_repository
diff --git a/environment.h b/environment.h
index 6f18286955..52d531e4ea 100644
--- a/environment.h
+++ b/environment.h
@@ -133,6 +133,11 @@ int git_default_config(const char *, const char *,
 int git_default_core_config(const char *var, const char *value,
 =09=09=09    const struct config_context *ctx, void *cb);
=20
+/*
+ * TODO: This still relies on the global state.
+ */
+const char *repo_excludes_file(struct repository *repo);
+
 void repo_config_values_init(struct repo_config_values *cfg);
=20
 /*
--=20
2.43.0

