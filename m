Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DED38F954
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 14:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347971; cv=none; b=BNFdbDP1kTQJVOBtmQK4i7x6q5vBtw/p1Ur3xlhuP1ybhqAd1n9nf5XhY8/NyXS2JVflseTKBDGxaO//EaVhhg6orEohMyRraoGNkpCju0LumDOSeReCbPNYp1j3mB4GXQY/R2sF+osNtyPcrOCn+b7rK7IKMP4ZrIH9bFh21yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347971; c=relaxed/simple;
	bh=k6XCaHdEBl/ejUK7nxneynvKPRyDZTC/K0nynNkO8uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NICTdukYRWHTyJysj0dXQJq1pqR/Jxzk4iFZnXZOsOBh5MF8ZCe5tyyLOCLzaVPUaF6MbbU/dySVJlAB9kiNc0iKZioCuj4MZS2HlI5EQzR1DGF0k20FS3PaQxZ8XmLxsWSj7gtnDOg2QfleGP4BxisBnXoBBGYbWDO5IoWuKsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=gwSJCncQ; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=ZRpEZUSw; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="gwSJCncQ";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="ZRpEZUSw"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=gwSJCncQuRy1a/QVKtGWLBdg13pPyORrR1cseCIv+FgPk62EM4evjQbTr/KmRWeOG0qw7C4S7/1eMZ+hNsBqMTAzCB8ahfD0DT8KxDWDe7FW6N12iK+I3FCLiwh9Qgm89ixWX1MmWQGzg3o7W5RjeT2jZWNFB6AmgBSqclt7qq0R9n7GBOvcjGRptTh31fVUfh6Q6X9GtHicNijeWahibv4F5QdEJw2kQo2xKLBlbgLPR2IWACWKNphaBRCuiiCB5PihQ30zktLta7hCT+HNgi9yE053F+rB/6APPIUnEOnKNnjfupQu9Bvc8QgqeT4SqagUElkLsIRO4f4ggNN9YQ==; s=purelymail3; d=malon.dev; v=1; bh=k6XCaHdEBl/ejUK7nxneynvKPRyDZTC/K0nynNkO8uc=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=ZRpEZUSwmQbBkPWScICascg8NDXnZpuLYaqgfZQbumJpkEJSo6UfQWmYsn3UDH3RqOupT2AVr5eF+u9qpRqXbZofaTec4SeiWVz5J91FBuiQM3WBrTmdv/zcuEH7pnSuf1Zp6D1lG1MdeAml3f38CzDAldQAxBQM2IFKts8M82CinUoI3eNNGHtaD4RXIG9yUl/QRyX/j/XX0faUSbczvPjMru28jI3Qh/dNDlICQlaqrCVBQMfVTz0bEMp6iDGKzgb12XI3vZD2JI+T0p9DJ1AuT0iZyoKWhckDGzuujT8tQsnYpcuYQwct26iZbnaT6XVplgiQKX8uzVWIsAGKfg==; s=purelymail3; d=purelymail.com; v=1; bh=k6XCaHdEBl/ejUK7nxneynvKPRyDZTC/K0nynNkO8uc=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1851978137;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 06 Jul 2026 14:26:07 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v7 4/9] environment: move pager_program into repo_config_values
Date: Mon,  6 Jul 2026 22:25:25 +0800
Message-ID: <20260706142530.3681520-5-cat@malon.dev>
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

The 'pager_program' variable is currently defined as a file-scoped
static string in pager.c. Move it into 'struct repo_config_values'.

The configuration parsing logic remains strictly within pager.c to
respect subsystem boundaries. The read/write operations are simply
redirected to the repository-specific structure using
'repo_config_values()'.

Similar to the recent editor_program migration, no standalone getter
is introduced to keep the code minimal. The dynamically allocated
memory is now managed by 'repo_config_values_clear()'.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 environment.c |  2 ++
 environment.h |  1 +
 pager.c       | 17 ++++++++++-------
 3 files changed, 13 insertions(+), 7 deletions(-)

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
index 35b210e048..450ad053b6 100644
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
@@ -303,6 +306,6 @@ int check_pager_config(struct repository *r, const char=
 *cmd)
 =09read_early_config(r, pager_command_config, &data);
=20
 =09if (data.value)
-=09=09pager_program =3D data.value;
+=09=09repo_config_values(r)->pager_program =3D data.value;
 =09return data.want;
 }
--=20
2.43.0

