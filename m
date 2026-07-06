Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC37379C5F
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 14:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347959; cv=none; b=hAPRxOiQc4ktuayJWpHbe0bF1dJoV6CVk0YpL1y8opMyyaAB+5pJWtoyPnKd5Da5ByH/0hkwh2YluJs9MABZ7jsJNiGMXp9aby70NKrnDr+6xw8KoZwBALYFuAEyVIDvyg7DjokE7TYUVBVSrqEaZX5Pu1fXpK4gN7P/wTflfQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347959; c=relaxed/simple;
	bh=nGesFb1OxnzIT6Shb2NImBp1k9YsE5KnjcJEb7pxnCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pI0C0Dyg7tbadpKmL+0lAw6V1eJq+4cfiX8DBmzjzgbJASBuXta6eb7xMOW/zmE7Pfn932v8xjPeM8/3HCnEhw+fEJgV4iPa8sCMI5DWrkR/W2nYyGoCDL5aHL1k6SRs6f5MVbPWPgTzskw+N0+wazt+tmcnfFmhHNhXqukEzMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=kdqJHfhe; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=JgI/8HBm; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="kdqJHfhe";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="JgI/8HBm"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=kdqJHfhekLa8nHS9vgsva8qiSWZ35JclynWVJ8zEiia1KEyX43ZGUU4N87Izu6ixJPNlNwF9z3PwchMGhYv+KzBdELH9+fnMvfg3pPS2xmKXLEN27gcZ0aI/tHhNN5+vJgVYRZijp5jmVmSEP22pbWfz7QynaXdRbzJcYjJOrk22+VNB8bvZGQWmi1YAFHgjkbBRGCue9cok6LwVtOLSdmf9NsMp5cEML2EnbLJDyax15WVDc2Yi+UHALOM9yE88EieSF5XzQVZA7Mr7fEpHB32if9ws75iRpGaL0uK2W6h3HmB5gNYOO/loq6XK8MNcriTWCins7qD3+fuOeJVHBQ==; s=purelymail3; d=malon.dev; v=1; bh=nGesFb1OxnzIT6Shb2NImBp1k9YsE5KnjcJEb7pxnCI=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=JgI/8HBm8VFNdZWGOnpcM5X92IaRlKT7CMZ6l48u5Al0VOtGtwlDyUnWIMfvii7R18fh5b1eeBMfA7bAwc2cJRbMOE1bgcds9/aIy0nv+n6sYZmEIE8BDpCu+YgknAn9deodHtR/lcUCz3xMTIOmnMOA/59GgCaa0nz0Wl2l3otqfR8efEqVXMsMqK8fbIX2LBNp32VUka5SpQUdJ/GePdGtv05HL9hhgXE0sS2DdJEysEe9Lko0WG42vVOMeVGIefiBz9KlObI8Wwv0c4bV3G4SPC1DZI1rlIT8ek+MfvbU9s8PjYJW4Nu2bFN+EYsOO0Bwaa9n+AXEdU/ySeU0Ug==; s=purelymail3; d=purelymail.com; v=1; bh=nGesFb1OxnzIT6Shb2NImBp1k9YsE5KnjcJEb7pxnCI=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1851978137;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 06 Jul 2026 14:25:55 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v7 1/9] repository: introduce repo_config_values_clear()
Date: Mon,  6 Jul 2026 22:25:22 +0800
Message-ID: <20260706142530.3681520-2-cat@malon.dev>
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

