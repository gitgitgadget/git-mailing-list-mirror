Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F5635C1B4
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 16:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783526601; cv=none; b=Qh1Eqh/utCVEiJQM7NEvWjpJeWXs2rsXtQ8TxFuUOcZHdqjEUyXzuCJMPpQv+paHcSUPaepgofjPIZ+K84PmozU4s519G0qW/x6yO+sksaa2LVrWuN5vcXWP9px6kF7upyzevxIJU7CqoIpRed+uZqVzIsRdKEjs9azDw2nDzDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783526601; c=relaxed/simple;
	bh=nGesFb1OxnzIT6Shb2NImBp1k9YsE5KnjcJEb7pxnCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YPd3Okc4Yo8K2qT9UA1seleSY6EumGC1U14cyQX0VHM+D3ZIAdyNVvehxLfu7mJZbqF20kfdqSZ6k6387LRChRUFaroTjFgadS/vWGdEfaS00mF4NztFxfrSj9vSotDHzOEWnlRm9Rt6kEyQT810HYR16zSZH5v1mqrRjZ+/ztc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=t/OtAu/8; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=cx2noaU5; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="t/OtAu/8";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="cx2noaU5"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=t/OtAu/8nj763L5JpgaZmUwz1lbe5sYQNRAZgrvFmasiRZCcbQMcxecG7f520p22Jd+/a1r4jo/rNAQ3qGC290rA+DJNuwoGZxnSjAXNQovFpHeqShEnBlxre9YsrAhJx4yCF3q4LMBVjPhD+HT00K9IxsqvoJGoTlAIBAruBSxmpYVT/O6KyEV2o/XN1W7Xu++EqUDHdG64jCdrjarzgeJ/LapQ4gSkeYBPf+f/j7nEkv9GdYFajkKcqYOq70trC23RNJQHRwQaTtJE6IuDAUmZT2ODBA1Whk0xxR7oOHYq97JXkdwrJhOYY3rx+Uiv7DXnnou4q0xtN6ZXik800Q==; s=purelymail3; d=malon.dev; v=1; bh=nGesFb1OxnzIT6Shb2NImBp1k9YsE5KnjcJEb7pxnCI=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=cx2noaU5gGuUQXPHReLPy7gH1O0P4NcdCqJYfVCIhRd9yK9vJojvmPD4OC27cArIqaF2QCwKwArI+tD77e7KhFT08tluSM45ZwBwMeg1R3CwZEVG8NIMVkY5e0ii1DJwW4zyIDJ8Jt9elGr3e24cMlaVs+FDxdvWhBPe7GPeAv3JWMtKm+1SZpt0wYMXYVvmf9ZmlxOPn+gETyVDZMXpqlQ42YSr0d9NwpcQ395w4dB2vzq0bURj3Vdh2tArVfAmnzTPYqKR3hB8ZiasPc4Gcq/HvwT5Kn2TOUXixypQnOVAX3jr/voVjNY4IckpqfYbBMKomjgTGaezE/P1v3RJEQ==; s=purelymail3; d=purelymail.com; v=1; bh=nGesFb1OxnzIT6Shb2NImBp1k9YsE5KnjcJEb7pxnCI=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -238025841;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 08 Jul 2026 16:03:11 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v8 1/9] repository: introduce repo_config_values_clear()
Date: Thu,  9 Jul 2026 00:02:52 +0800
Message-ID: <20260708160300.8852-2-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708160300.8852-1-cat@malon.dev>
References: <20260706142530.3681520-1-cat@malon.dev>
 <20260708160300.8852-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

As part of the ongoing libification effort, dynamically allocated
global configuration variables are being moved into
'struct repo_config_values'. To prevent memory leaks, we need a
destructor to free these heap-allocated variables when a repository
instance is torn down.

Introduce 'repo_config_values_clear()' in environment.c and invoke it
from 'repo_clear()' in repository.c. As a starting point, update this
new function to handle the cleanup of 'attributes_file'.

Note:

Submodules are currently not supported by repo_config_values(), which
explicitly BUG()s out if 'repo !=3D the_repository'. Since repo_clear()
cleans up all repository instances, we must bypass them to prevent
crashing.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 environment.c | 19 +++++++++++++++++++
 environment.h |  9 +++++++++
 repository.c  |  1 +
 3 files changed, 29 insertions(+)

diff --git a/environment.c b/environment.c
index ba2c60103f..13677484de 100644
--- a/environment.c
+++ b/environment.c
@@ -726,3 +726,22 @@ void repo_config_values_init(struct repo_config_values=
 *cfg)
 =09cfg->sparse_expect_files_outside_of_patterns =3D 0;
 =09cfg->warn_on_object_refname_ambiguity =3D 1;
 }
+
+void repo_config_values_clear(struct repository *repo)
+{
+=09struct repo_config_values *cfg;
+
+=09/*
+=09 * NEEDSWORK: Submodules are currently not supported by
+=09 * repo_config_values(), which explicitly BUG()s out if
+=09 * repo !=3D the_repository. Since repo_clear() cleans up all
+=09 * repository instances, we must bypass them here to prevent
+=09 * crashing.
+=09 */
+=09if (repo !=3D the_repository)
+=09=09return;
+
+=09cfg =3D repo_config_values(repo);
+
+=09FREE_AND_NULL(cfg->attributes_file);
+}
diff --git a/environment.h b/environment.h
index 6f18286955..c4a6a45704 100644
--- a/environment.h
+++ b/environment.h
@@ -135,6 +135,15 @@ int git_default_core_config(const char *var, const cha=
r *value,
=20
 void repo_config_values_init(struct repo_config_values *cfg);
=20
+/*
+ * Frees memory allocated for dynamically loaded configuration values
+ * inside `repo_config_values`.
+ *
+ * As dynamically allocated variables are migrated into this struct,
+ * their FREE_AND_NULL() calls should be appended here.
+ */
+void repo_config_values_clear(struct repository *repo);
+
 /*
  * TODO: All the below state either explicitly or implicitly relies on
  * `the_repository`. We should eventually get rid of these and make the
diff --git a/repository.c b/repository.c
index 187dd471c4..b31f1b7852 100644
--- a/repository.c
+++ b/repository.c
@@ -388,6 +388,7 @@ void repo_clear(struct repository *repo)
 =09FREE_AND_NULL(repo->parsed_objects);
=20
 =09repo_settings_clear(repo);
+=09repo_config_values_clear(repo);
=20
 =09if (repo->config) {
 =09=09git_configset_clear(repo->config);
--=20
2.43.0

