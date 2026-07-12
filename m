Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C013A6B9A
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 11:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783855079; cv=none; b=Mqz9XqlsZFWcOf+6xOONrp7eQwmzf3L/qK/ZCNf82mV5FTqqn3G/DkAuuxpg2t4YJInKuOGhHHj7xyuPJYuWJFvpZqAnk954raaS0BxII3ZwTdmB/P5h99ucet0+KmyAqsQdNook4hcdyaBMlGHA7IQgel7n28n1Kw9o1/n+pEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783855079; c=relaxed/simple;
	bh=t3fhUd3vmwlrwTZorhW9NOhBgMCp2MIgTEY7/8uQ66E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ABqBFjh6XSHiw+aTcQYmIhXftfHJJgUNJCi3KT1BX/uRJx8pdtUSOsLcf52vG/fRLMWCu3eao8GRMLVOVMI36byvtuW8G2YkSQgclHq2fnujpIae492vB0IPsuo+co85GatYWZcr20AJ7tD9rbK5stgH0XadLW9vHtmuVVFKdw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=GGjt8Lm1; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=GpBrBDYD; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="GGjt8Lm1";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="GpBrBDYD"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=GGjt8Lm1/pMNmEKZclHiYjzzw33+2eMpX6aVB7bTkFxzcbX8T/wgBt7IX9jfYOXogAoAAhs+baRWaxx5gNwuSAq1HS/8QY/x41UreasWvUW7buVVRNVNDJlmR4LFypIyj5khsPvSWYVDAYWj9LzQ/NVkFCBEuUy80YmkpeYB8ZV+UQbt5Qyb6eLUYSx3ykHp2TNHvSpTrw3Pbty13W7acVDktElPhxuI5fpjoU/fgiLH7FRVAFlV0pFF7nbOuf52I0IkSELmZfASXDpAq90tyOhgquny4m3hBUJEtB6ERKFuBlnsWafnsQOQjQZzykicg6LcYG3wtj6hiq7BY9IVbQ==; s=purelymail1; d=malon.dev; v=1; bh=t3fhUd3vmwlrwTZorhW9NOhBgMCp2MIgTEY7/8uQ66E=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=GpBrBDYD+wOLfXYoOclSKEBkvwsJA03NYjvGGR9F6AKLPAT3Ax3PJ0uYx8OqJZwRaBEnP6qVA2GeR2nlY4zZiNnITTeIw4+8Skkd0cMOWuFihmjgGVTfPwYFxLSShWOFV3f4QeqL5CX8QgdXi44WGHl05YiwjrX52w01kjMcyE2/OxCeMZA2WcrUh5jMv7qw/RgdOqFbfTgl4PTAvQGdKGza/AtRqNkpwF5Hd9oZY4fRNI9YOnpeeQxettQFNdi+vIAdufypAVETq3dJh+HwdjLnwGHPaBtQKt8NiRCSm1EVxeGd1zaekRFd1ewVPDuWm12PC9exQeRM2MZfL8id1A==; s=purelymail1; d=purelymail.com; v=1; bh=t3fhUd3vmwlrwTZorhW9NOhBgMCp2MIgTEY7/8uQ66E=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -46196840;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 12 Jul 2026 11:17:53 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v10 4/9] environment: move pager_program into repo_config_values
Date: Sun, 12 Jul 2026 19:17:28 +0800
Message-ID: <20260712111734.1073514-5-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260712111734.1073514-1-cat@malon.dev>
References: <20260709161145.13349-1-cat@malon.dev>
 <20260712111734.1073514-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

The 'pager_program' variable is currently defined as a file-scoped
static string in pager.c. Move it into 'struct repo_config_values'.

The configuration parsing logic remains strictly within pager.c to
respect subsystem boundaries. The read/write operations are simply
redirected to the repository-specific structure using
'repo_config_values()'.

Similar to the recent editor_program migration, no standalone getter
is introduced to keep the code minimal. The dynamically allocated
memory is now managed by 'repo_config_values_clear()'.

On top of that, fix a memory leak in pager.c while we are at it.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 environment.c |  2 ++
 environment.h |  1 +
 pager.c       | 26 +++++++++++++++++---------
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/environment.c b/environment.c
index a65d575af4..975c9cb9eb 100644
--- a/environment.c
+++ b/environment.c
@@ -725,6 +725,7 @@ void repo_config_values_init(struct repo_config_values =
*cfg)
 =09cfg->attributes_file =3D NULL;
 =09cfg->excludes_file =3D NULL;
 =09cfg->editor_program =3D NULL;
+=09cfg->pager_program =3D NULL;
 =09cfg->apply_sparse_checkout =3D 0;
 =09cfg->branch_track =3D BRANCH_TRACK_REMOTE;
 =09cfg->trust_ctime =3D 1;
@@ -742,4 +743,5 @@ void repo_config_values_clear(struct repo_config_values=
 *cfg)
 =09FREE_AND_NULL(cfg->attributes_file);
 =09FREE_AND_NULL(cfg->excludes_file);
 =09FREE_AND_NULL(cfg->editor_program);
+=09FREE_AND_NULL(cfg->pager_program);
 }
diff --git a/environment.h b/environment.h
index 8178ebab76..39b6691b47 100644
--- a/environment.h
+++ b/environment.h
@@ -92,6 +92,7 @@ struct repo_config_values {
 =09char *attributes_file;
 =09char *excludes_file;
 =09char *editor_program;
+=09char *pager_program;
 =09int apply_sparse_checkout;
 =09int trust_ctime;
 =09int check_stat;
diff --git a/pager.c b/pager.c
index 35b210e048..bc55546670 100644
--- a/pager.c
+++ b/pager.c
@@ -5,6 +5,8 @@
 #include "run-command.h"
 #include "sigchain.h"
 #include "alias.h"
+#include "repository.h"
+#include "environment.h"
=20
 int pager_use_color =3D 1;
=20
@@ -13,7 +15,6 @@ int pager_use_color =3D 1;
 #endif
=20
 static struct child_process pager_process;
-static char *pager_program;
 static int old_fd1 =3D -1, old_fd2 =3D -1;
=20
 /* Is the value coming back from term_columns() just a guess? */
@@ -75,10 +76,15 @@ static void wait_for_pager_signal(int signo)
=20
 static int core_pager_config(const char *var, const char *value,
 =09=09=09     const struct config_context *ctx UNUSED,
-=09=09=09     void *data UNUSED)
+=09=09=09     void *data)
 {
-=09if (!strcmp(var, "core.pager"))
-=09=09return git_config_string(&pager_program, var, value);
+=09struct repository *r =3D data;
+
+=09if (!strcmp(var, "core.pager")) {
+=09=09FREE_AND_NULL(repo_config_values(r)->pager_program);
+=09=09return git_config_string(&repo_config_values(r)->pager_program, var,=
 value);
+=09}
+
 =09return 0;
 }
=20
@@ -91,10 +97,10 @@ const char *git_pager(struct repository *r, int stdout_=
is_tty)
=20
 =09pager =3D getenv("GIT_PAGER");
 =09if (!pager) {
-=09=09if (!pager_program)
+=09=09if (!repo_config_values(r)->pager_program)
 =09=09=09read_early_config(r,
-=09=09=09=09=09  core_pager_config, NULL);
-=09=09pager =3D pager_program;
+=09=09=09=09=09  core_pager_config, r);
+=09=09pager =3D repo_config_values(r)->pager_program;
 =09}
 =09if (!pager)
 =09=09pager =3D getenv("PAGER");
@@ -302,7 +308,9 @@ int check_pager_config(struct repository *r, const char=
 *cmd)
=20
 =09read_early_config(r, pager_command_config, &data);
=20
-=09if (data.value)
-=09=09pager_program =3D data.value;
+=09if (data.value) {
+=09=09free(repo_config_values(r)->pager_program);
+=09=09repo_config_values(r)->pager_program =3D data.value;
+=09}
 =09return data.want;
 }
--=20
2.43.0

