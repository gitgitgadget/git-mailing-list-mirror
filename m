Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6B2368941
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 16:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783613541; cv=none; b=XdUh2wB3ikUNFm7AG+HEvkgvYUoBGauf0ZOBaffG53WcCRDhpdUPeHr/m5zEhcx0e4CH7sKDtzOicd7gXCT/V44zg9Uq6oepF1SfCWPKpuyrNf/bdm+/XZzV5NqdR26Xn5MW0yISPqH+6XduVTpF0fvN6i/mke4oQZQ2ZGfFOBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783613541; c=relaxed/simple;
	bh=0HjIadP9KokW+NZKhha+49lP7cQNINBRFEgXpyINWOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OLp5+EimnSYZ0Jk9GMPVFYVbc+sK9FphouYnXDhh7NCdu2M8L5/1sgzf9tUJVjPy/qBIuXQ+naGArfenM88ZAPc5yXy514ovANU1wYimrU9JU8CLZKU8GaIQq32b2urUhWsY6m81BESagFP442ZvmfoinxK4BU6a7RiozUP/07Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=bYBcbbWY; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=FqexzibV; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="bYBcbbWY";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="FqexzibV"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=bYBcbbWYcKxAFHxWTM5uCKGI4/LBLGkkPM7Jn1OVpkwqDEhwmWbyIjB8XDOtzs+ZcQfebtrOCTDcNVaosb720ztJnueING37nKh2EEXsMx2ZuN6nkX+gG/z+ehxtTxAGpZDXL8ufit6a68qWaEPc7iBs3EzLoGYCU4YEDd8yS3xJTlxaFt2F+EFpG3NgkfeB4aony4TAY8Vgf2OD5UWk7r55gMpfTlU1dXxQx7KSRfZgojkeAro17Wm/w8MUiIpFI2BN5a6Dh9aCaKLNQCiIwL7mifpmSJ6bzn/1Zc17mK65hdHb/OBJm8ZkpW2mPANvPI/tsahI2PBlGufWvUOFdA==; s=purelymail1; d=malon.dev; v=1; bh=0HjIadP9KokW+NZKhha+49lP7cQNINBRFEgXpyINWOQ=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=FqexzibV6xvSMG8UlnnkpstZS67xporlREi9jQEd3Rr9H9S04/h7RzM6sdUf7KLWkKW61XzaN79MDPFr9Fy3jFRYA+3BrKhLp8rmG49LBuxEH7gQxmO1XYlNnT5f8Xuc6rd6bWQUOJl38C7ywJsya3VdHlgc/g4sIJLFvgG6vGnWzU6k17uQkkretm8EcE2AqBkjuTPIOiK2zRVD2T47w4wvE7eoaeGu3GguUQTfa++v+SQDVLshpEJfnixIFPRQqSru3JfvqXuWCLvN/Zl2EW7pTjPEPVnMeEel367f1YR2cMT2+5tzb2JqlTkfa/4AXnfDn/HY3Xi1g0A8GeOR6Q==; s=purelymail1; d=purelymail.com; v=1; bh=0HjIadP9KokW+NZKhha+49lP7cQNINBRFEgXpyINWOQ=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 872182701;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 09 Jul 2026 16:12:18 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v9 4/9] environment: move pager_program into repo_config_values
Date: Fri, 10 Jul 2026 00:11:40 +0800
Message-ID: <20260709161145.13349-5-cat@malon.dev>
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

