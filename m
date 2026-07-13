Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1668737646A
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 03:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783915073; cv=none; b=OQFZIw/mlb8YImBgN6Ckp+R0kADDOWubVT39LgcYcoDxVYFLyvRMnmodDKFIRDw2RiJzvCfXNAugI1Y3LfO1G3u9bQV2ryAxLsa4+F5wMUmd7ZeKkGy6AI3xRhVoOtJq010ngf1D1kQD8tc/rK0zembL6mnEr4+T9Md2fuRVWkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783915073; c=relaxed/simple;
	bh=eFVK5uWaGRUXlObsoT/vaUTGFfvwnliNgsMAA4fAXeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BPtknnTWMT2YAQkzX8n9PQL39+ovShkSdb5ONeKC2JUNPKA890i7419JY++0p2aWvyT4m2BMHI7lJeCJROQQvq7Oh6VnP7GBD4bLqy6GAazxMdha/J2BnZ9p02FZeYSH27Dhh05Os1Z4jrzj+Q3OvUKzb1ECrWCv+TGpEdoAW4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=a+vAplVV; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=dZQdMUPY; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="a+vAplVV";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="dZQdMUPY"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=a+vAplVVKsd4/q+dl0W5midNRYBAYv8ccKU+LE7AsYTTGt9lY5WZHFxxGfCygL8eRKkumy3spOyBUvBYMaqPW/1fyajmigKc2+uRtqE7/ZZ7VHSCVSd+BY1bmn9d8sWS2uem3lDAd7LF4genQvbOKpK93ayolt4c8vPoaTPp7xM5E6zEer2vnA87yZEQtSc0hmnSakuCkrAZT3IMC1SD7x24cPIvobUlTkw8YTEnp6F0KRlu9ImykNdewUIBeHayvMS6jrxFIuvVdoybTyMdXJePI3aiK6dZA6QUQDQSHTU0YJVdPAz2ONqDItMyRHeJZOIQ7KWT+RSxIKVn09/kjQ==; s=purelymail1; d=malon.dev; v=1; bh=eFVK5uWaGRUXlObsoT/vaUTGFfvwnliNgsMAA4fAXeg=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=dZQdMUPYRfys1rBTq2bLCJ4EU2ywSrGapJyhWO8yVXQTsQd2vdyD58ZM2eW5NozJ8BPllEcL0tNZ5koioDHb1/W4X4j2X7fHx47yhmCKz7ga+0ymzdSujHZWcvyzLbLgqq89Z5bzOriHtGojbHju+Tv+lPOSrS4N1ZH9n1eXTFA1UuJLzIYueFxZjewsn5EO3Z0tAIV5sPzqAdX/OhAR0hW4wq/nCpNOl0rCGV74S4SUnHXTvcfCJ+dsjv369Plr+sjIi10h/QO7MI+5Mib/AYc/Vfy5slTRjAddxCrElqzfmvkWvo9ubNJ8XIR6umna1dPzM5w9uHHYKPfWu71L5w==; s=purelymail1; d=purelymail.com; v=1; bh=eFVK5uWaGRUXlObsoT/vaUTGFfvwnliNgsMAA4fAXeg=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1573664722;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 13 Jul 2026 03:57:48 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v11 01/10] repository: introduce repo_config_values_clear()
Date: Mon, 13 Jul 2026 11:57:29 +0800
Message-ID: <20260713035738.1606138-2-cat@malon.dev>
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

As part of the ongoing libification effort, dynamically allocated
global configuration variables are being moved into
'struct repo_config_values'. To prevent memory leaks, we need a
destructor to free these heap-allocated variables when a repository
instance is torn down.

Introduce 'repo_config_values_clear()' in environment.c and invoke it
from 'repo_clear()' in repository.c. As a starting point, update this
new function to handle the cleanup of 'attributes_file'.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 environment.c | 5 +++++
 environment.h | 9 +++++++++
 repository.c  | 1 +
 3 files changed, 15 insertions(+)

diff --git a/environment.c b/environment.c
index ba2c60103f..ae05f16d04 100644
--- a/environment.c
+++ b/environment.c
@@ -726,3 +726,8 @@ void repo_config_values_init(struct repo_config_values =
*cfg)
 =09cfg->sparse_expect_files_outside_of_patterns =3D 0;
 =09cfg->warn_on_object_refname_ambiguity =3D 1;
 }
+
+void repo_config_values_clear(struct repo_config_values *cfg)
+{
+=09FREE_AND_NULL(cfg->attributes_file);
+}
diff --git a/environment.h b/environment.h
index 6f18286955..9169d7f62d 100644
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
+void repo_config_values_clear(struct repo_config_values *cfg);
+
 /*
  * TODO: All the below state either explicitly or implicitly relies on
  * `the_repository`. We should eventually get rid of these and make the
diff --git a/repository.c b/repository.c
index 187dd471c4..669e2d1200 100644
--- a/repository.c
+++ b/repository.c
@@ -388,6 +388,7 @@ void repo_clear(struct repository *repo)
 =09FREE_AND_NULL(repo->parsed_objects);
=20
 =09repo_settings_clear(repo);
+=09repo_config_values_clear(&repo->config_values_private_);
=20
 =09if (repo->config) {
 =09=09git_configset_clear(repo->config);
--=20
2.43.0

