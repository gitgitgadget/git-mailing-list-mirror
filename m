Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1CC370ACF
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 16:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783526607; cv=none; b=mFUvT4NQj1MLdnuWOkRVkEDUyxyBt/R67gVrjIBI2jqhr1XOucUJfLE4SDA+rHHWPIQ5N0J6mkvEsU54zxv44dN4Lp6ZpJlMqHbSEHrKQ4/o70lXK3t/NiZdQN3qSRLdDebS1QTi+ZjTVQAkkXFHY9OkhT2c0hvXhXCeLOZ5dew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783526607; c=relaxed/simple;
	bh=A/mgSG/7+RF9HONVWByHZAW0lhk/5MWnfO9O6SzC6CY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GK3D5TlbHyJhzQnYF7tYNkJhfoIkLFX2Cb8/EecTvC5J8zug8/AMuxmfw07KfgxtFsWVBZcNSwcArE6ZcF7yzSqFCsSuF12DIjd0bP8ktswADISbK1t1epx1s9RObMxr1/L6+z+YAlLKSlZQ0pr5VDXvxsT1/tiRWBdtAihLkLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=rLF4WwrL; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=D7Z3awwd; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="rLF4WwrL";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="D7Z3awwd"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=rLF4WwrLWP7K/7UnMd7i/KeCC4YNc1iCSssza4/S15Fd91ZlsY+e/+mwrTVE16Gw822GraFpiJ26ofE0qc94iaIT97gQhpTl/PRNfOZGr8ZJbhqO5f7/tC0OO5ktJ8GDmwkyqahGwxW2jEU0qAqRkfnt+hyM1kwZmbG7rXnpxlc/xrPpwRDxHcnz9YHITC+aKaqLukYshN8e9Z2TTKX0kry/KyKDGa27x2YlrdMTTy+d9qcDUCGvIi288k7tbkcu9sgRRa9nAtLHaA6/JRw0DSN3yDacm0UtFYdwJBBXabm+D2xsBtm4NGfFTFSKj3S4OB1B6Yh46Fc4V8/TVtlAgg==; s=purelymail3; d=malon.dev; v=1; bh=A/mgSG/7+RF9HONVWByHZAW0lhk/5MWnfO9O6SzC6CY=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=D7Z3awwdgIiNxBxuBQNkh2MySs8/CbHPoeytqCfJu2b9eNF6bVTNapDqubuw8HClnTlrUcEigaSX0sRX590a76qvIozMShR3RsWe8T0zfhD0pL5OPe1aIlpjZcYJpMYjKloCiBxJXtSaiEiW148zlKjnH4vHaKL0FUFGNHzW/+7K5D825Mkbyt5oj0j7aFQ2LPhuNWE4GJfdF5l3N3Y+WrdmRNXLcPuSNg8RfO/ADfzF4jZsHGPofh69YfdM7pf92koX63IvlnDOWZiUBb81VW+vijUHlX2vr8DVXNeW0FTEDPIndbDo7IePceY2rG712n+xQsCrw6uUrGiaY44udg==; s=purelymail3; d=purelymail.com; v=1; bh=A/mgSG/7+RF9HONVWByHZAW0lhk/5MWnfO9O6SzC6CY=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -238025841;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 08 Jul 2026 16:03:23 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v8 4/9] environment: move pager_program into repo_config_values
Date: Thu,  9 Jul 2026 00:02:55 +0800
Message-ID: <20260708160300.8852-5-cat@malon.dev>
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
 pager.c       | 21 +++++++++++++--------
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/environment.c b/environment.c
index 0a01f4761a..a1204fdcb2 100644
--- a/environment.c
+++ b/environment.c
@@ -723,6 +723,7 @@ void repo_config_values_init(struct repo_config_values =
*cfg)
 =09cfg->attributes_file =3D NULL;
 =09cfg->excludes_file =3D NULL;
 =09cfg->editor_program =3D NULL;
+=09cfg->pager_program =3D NULL;
 =09cfg->apply_sparse_checkout =3D 0;
 =09cfg->branch_track =3D BRANCH_TRACK_REMOTE;
 =09cfg->trust_ctime =3D 1;
@@ -754,4 +755,5 @@ void repo_config_values_clear(struct repository *repo)
 =09FREE_AND_NULL(cfg->attributes_file);
 =09FREE_AND_NULL(cfg->excludes_file);
 =09FREE_AND_NULL(cfg->editor_program);
+=09FREE_AND_NULL(cfg->pager_program);
 }
diff --git a/environment.h b/environment.h
index 1ec19149cb..22f6697c52 100644
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
index 35b210e048..c8ebdd4b31 100644
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
@@ -75,10 +76,12 @@ static void wait_for_pager_signal(int signo)
=20
 static int core_pager_config(const char *var, const char *value,
 =09=09=09     const struct config_context *ctx UNUSED,
-=09=09=09     void *data UNUSED)
+=09=09=09     void *data)
 {
+=09struct repository *r =3D data;
+
 =09if (!strcmp(var, "core.pager"))
-=09=09return git_config_string(&pager_program, var, value);
+=09=09return git_config_string(&repo_config_values(r)->pager_program, var,=
 value);
 =09return 0;
 }
=20
@@ -91,10 +94,10 @@ const char *git_pager(struct repository *r, int stdout_=
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
@@ -302,7 +305,9 @@ int check_pager_config(struct repository *r, const char=
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

