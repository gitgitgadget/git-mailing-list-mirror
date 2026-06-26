Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40B63E3DB8
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 07:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782460255; cv=none; b=lNc1Sv2Dbg9tIXLytRm74NCbMIdjYiTPoUd8i6e6myMkl2jvUtKlm8XPwpbJlv39a6ur1YJ2pgBKN5W3XkDPPljlLSqtKMrbkOpxfX9NUGpg/xvYqjXg417TtFjyS/LeJ1uQmmtNSltWVq4G878oYIAKJE/Arjnc8AGPa3derXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782460255; c=relaxed/simple;
	bh=ZIhnWjgIpNvb5yuIcIxIbtvqgp0htfkOmLMwJR3mYSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HRkZ9KJUPzf202KtQLV6ENXugD3vOvTLYTecten3SoIaomkAwsmY5niLL2ntLBHC3RnK1wYmTjaenFF4f21qIhwClJgxsfPgSA5G3bIH80LmiZJsHz3bL2fiDR/CcStzfMeSac+I6PUm5xCNkhzTsOVUx+kME85b2PdlXIWQdkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=dySVgqGG; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=XlZwz1pU; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="dySVgqGG";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="XlZwz1pU"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=dySVgqGGbrKBLW14XcTwPdq+Zv9u58oofiUAwNd1woTWpyv1i9G1CQ3YIcUF2lNuzMc8j9KLmDfyAzeH6dRQBt+eAhH/OLxQUNpvm63uVNKHUntey3ccJZJaAjTod8HpQz4a1/PVEBZxTkn7XeCCSC33E+jG0TJJZxiBMKQW2/kmNTwpWjNxIZe/yLuLE0qnsViwl3A5DT2JfZy2OyPjlyb/ExSiOUDagj4khlExVMbKA/s6EEPqWUCYcLQ7Zg2pWzEdEnB2JdcjXL52S+xI/ylQopni+lpoVfwzF1b6jDuRbp9BO4HZ64t4jNCgu1G1rB7VEwpkdYUsJUJHezQYtA==; s=purelymail2; d=malon.dev; v=1; bh=ZIhnWjgIpNvb5yuIcIxIbtvqgp0htfkOmLMwJR3mYSc=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=XlZwz1pUCkCkdxdpPZ58Q6lqPjx8kZYp8WbNB/G+ZyOstyNp8FoQcLz0lOV0zc7BHgi3BBBPbJ8yLbTkSB6ahdnyCzp/4XmG/NRNpepSfkiuSqaK2K5Twfo01mc+Y8W7y2cB8w7izho51svKSJObRJLpeIVIbnicQ3LYJ0sI3nErorDhyDLWQhMxo6V3ckm8oZQmOCmzLGS2jdJbyk4QWSQeDZ9HEmdCdG6CNiJXZatPwIiTW4qJcTd8OsdCOkcLWA3SVbQy4flu4tflIEg4VOFSmB90cxyUlPUX8n/sbs8Cu4VJSYVHz8NOcEpeo+bUV/kamOHTyklmVHjVkm8LJw==; s=purelymail2; d=purelymail.com; v=1; bh=ZIhnWjgIpNvb5yuIcIxIbtvqgp0htfkOmLMwJR3mYSc=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -72641762;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 26 Jun 2026 07:50:50 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: cirnovskyv@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v2 1/2] dir: encapsulate excludes_file lazy-load
Date: Fri, 26 Jun 2026 15:50:36 +0800
Message-ID: <20260626075037.532164-2-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626075037.532164-1-cat@malon.dev>
References: <20260626075037.532164-1-cat@malon.dev>
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

