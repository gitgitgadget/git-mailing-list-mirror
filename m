Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266DC37FF61
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 03:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783915083; cv=none; b=jEKFa2nASDvNdSDH+U/ulv/QXpSWC4qykzyaGs0u2J1cYPjBOr6BrpP1QNksm+p3nQuUjssgpgd9XMEv5MGN6HV6BEH/7sbCJGNUGTSpbU/qT2TZaAar3+awN87bfQqro2k+KCGWmkO5SheRNrxI89fScKIeC+OvPu2nEXbA1sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783915083; c=relaxed/simple;
	bh=yMMVR+ouRmQDm8T5aVmzbjGBr3laEiPWRIy5CsJwrLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WsJdesg3nanbLM6t+7Ti99pIwcPDJZWfYt/4avsIetILqlYHgc1p3MYwcSU8GamBBCjiQdOpHtwA5Cf2gbB8ZM9TVY9GDxJIAzhWT6qt+LK6p7Y5D3HmhzULQFG7C/dTp5fWe496mQpnBp8f8eTuX9fyltn4pCrMGadaSck1RwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=RFhNnCCy; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=AYGLc+db; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="RFhNnCCy";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="AYGLc+db"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=RFhNnCCyRtzobHE8xNwCV5LXvjPrIj7Fyy4D0k0HD8XtekBa9v5u3jrSC0hT0VYJ6wvu82kbsN0UrpICX1rMHzbxkts037EB2t0HSrAHUSp7KSa/hNfOUtNFEbqRJFMBLkBUyy0PJTH0RawJfZOINust0ij+H3ZuHD7ZDOIq3iOZnHOl1drrlcoa04ajcnb3Mh6tpWZxbJYpI09pTTQq00rvyH86OihjSWD0kbOJPbD2lxMpaeuwZ+NfXU3+9kQTKtzBE8cHiZBKaY/Tu8cWC2RwI8TdnajWBwtI4XAq67gq+8HSuCm+nL0BCAv6Du4ueDbg0dwsTfHjwQAa/HDGDg==; s=purelymail1; d=malon.dev; v=1; bh=yMMVR+ouRmQDm8T5aVmzbjGBr3laEiPWRIy5CsJwrLs=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=AYGLc+dbZ0q/QW4Y8CBGDdptYYrjV5gZCfzH2NTmzAEFyi42hAqCjbz9G7hmJ4dvJ6WJFnZrCiu29VlnsFof1AaZedAWxvLZ66GjnJUsbqc9Maq6gdyAIl310b1TS0oB+9aoGfPzmuJQFEGmetkXJA9Sqhip0Kzp28+2K1AsVYj+09sOrFJ2syuD3Lw238LvL6WiT48zPCVIp6InSpPAPirIHVpRpsq2pp23huesDMOlFb8u/beu7lasaUAYdyEShYsDMx2apKmPaKnpR9a8hza47H/eZxIsEZxGwkzuEQ8Ijeb1qgDD81bil9y/sW1uToFQntESBfrM+xN53dcerw==; s=purelymail1; d=purelymail.com; v=1; bh=yMMVR+ouRmQDm8T5aVmzbjGBr3laEiPWRIy5CsJwrLs=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1573664722;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 13 Jul 2026 03:57:59 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v11 04/10] environment: move pager_program into repo_config_values
Date: Mon, 13 Jul 2026 11:57:32 +0800
Message-ID: <20260713035738.1606138-5-cat@malon.dev>
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

The 'pager_program' variable is currently defined as a file-scoped
static string in pager.c. Move it into 'struct repo_config_values'.

The configuration parsing logic remains strictly within pager.c to
respect subsystem boundaries. The read/write operations are simply
redirected to the repository-specific structure using
'repo_config_values()'. All current callers indeed pass
'the_repository', so this new enforcement does not harm them.

Similar to the recent editor_program migration, no standalone getter
is introduced to keep the code minimal. The dynamically allocated
memory is now managed by 'repo_config_values_clear()'.

On top of that, fix memory leaks in pager.c while we are at it.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 environment.c |  2 ++
 environment.h |  1 +
 pager.c       | 32 +++++++++++++++++++++++---------
 3 files changed, 26 insertions(+), 9 deletions(-)

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
index 35b210e048..543ef12936 100644
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
@@ -75,10 +76,17 @@ static void wait_for_pager_signal(int signo)
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
+=09=09struct repo_config_values *cfg =3D repo_config_values(r);
+
+=09=09FREE_AND_NULL(cfg->pager_program);
+=09=09return git_config_string(&cfg->pager_program, var, value);
+=09}
+
 =09return 0;
 }
=20
@@ -91,10 +99,12 @@ const char *git_pager(struct repository *r, int stdout_=
is_tty)
=20
 =09pager =3D getenv("GIT_PAGER");
 =09if (!pager) {
-=09=09if (!pager_program)
+=09=09struct repo_config_values *cfg =3D repo_config_values(r);
+
+=09=09if (!cfg->pager_program)
 =09=09=09read_early_config(r,
-=09=09=09=09=09  core_pager_config, NULL);
-=09=09pager =3D pager_program;
+=09=09=09=09=09  core_pager_config, r);
+=09=09pager =3D cfg->pager_program;
 =09}
 =09if (!pager)
 =09=09pager =3D getenv("PAGER");
@@ -302,7 +312,11 @@ int check_pager_config(struct repository *r, const cha=
r *cmd)
=20
 =09read_early_config(r, pager_command_config, &data);
=20
-=09if (data.value)
-=09=09pager_program =3D data.value;
+=09if (data.value) {
+=09=09struct repo_config_values *cfg =3D repo_config_values(r);
+
+=09=09free(cfg->pager_program);
+=09=09cfg->pager_program =3D data.value;
+=09}
 =09return data.want;
 }
--=20
2.43.0

