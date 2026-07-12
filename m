Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739913A48E4
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 11:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783855081; cv=none; b=py19IgIP0XsNljhJTYD6IiBwII1grHe2e14slrpgETasqEwicNl71FYneeUmc+aUb8azV8ylpi22AyQ6waqNSk7773F/WEIYJjpl5jAFzmZbfL9RchwxQ2qdBZ0o1MN+JlZ7TrFhsTjH0Z9MBB663PZmxdy5iOQ/q6QeFSxFtWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783855081; c=relaxed/simple;
	bh=GDAZLdfIbRsNszXnuUXNTZECEpbddPYmbI23Fy6tgzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kOI6I8XJFqmHqIWYmyd5zrKEgGgE5Q+8LvGAy5xHenLxCY2tzhH4cxku/JdcVwIGKFVC3i8lit51gCzLYV5fbRGWw3GwL0j5uHzxkkiaEjBtDwULHkgxpS5pmrAR+q+0aLdIh0H5CjjXehz3hdJhDjy8zIrskSiwbuRhbKzRmJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=ZyOS/4Oa; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=CPEsWqE1; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="ZyOS/4Oa";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="CPEsWqE1"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=ZyOS/4OalvWoeKGrLHJxh+3CmYEqJIl9ejqxbu5Xnj1ILYTKiBTGNTYX+KH//xgWbGPeKQ9OAqOItzVGcGmlOhaUrfcHbj2BwG3sAzKdeumALV6hNyVKcclo2aXWT3zxaU8Vl+YkXlCNX9E6MrLzOtLVODSgxB5aFC0sbNnOkqeM83ZZWpO3bKImp2Bf+RfQ/aOfLKNz8HBVryf+7A6hoB3aD+hbHEoOiaXFOo50/ZgQ/oSiy+zhwoLZmytuYWNfmTlq4gY600URdaLQw+p5S2JLG2FrcD6XPfdU/Yj7lt7w3FtEPcCC1uAZCVMzHJjWYhUo5JSo/e/jvOsFlCOoGA==; s=purelymail1; d=malon.dev; v=1; bh=GDAZLdfIbRsNszXnuUXNTZECEpbddPYmbI23Fy6tgzQ=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=CPEsWqE1KhtyzviFei5eaL1xFqQFo68iijvpLhX1Iuw/XtHmqsA6i8+F6QbQvQxwh5RpHpAmT0pkXrJk2ZyomZCwV5kqvvFMdLcI5KTBr7mO332x30Ylm+Ns5QqLdC+iW3C94/kFfFjDWg0a28E7zSTWUwRBlfqCV6iFB1g+nh/zDfBaqm6OKJU3pysbrSGtGrY26tEhkJnA/ikjody/geEVuO/zEK5axcFfOOgqxQ6wqPZNrlNDYTVcQ5TMvQeiXQLgpuRhFj5vrmM4XpqSMEUj0PjmfG8a6MHHR9XJxYU2/0lG0iO7BJ0+sDQj6hRNZKIjjYR9OtsUXRl685C7YQ==; s=purelymail1; d=purelymail.com; v=1; bh=GDAZLdfIbRsNszXnuUXNTZECEpbddPYmbI23Fy6tgzQ=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -46196840;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 12 Jul 2026 11:17:56 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v10 5/9] environment: move askpass_program into repo_config_values
Date: Sun, 12 Jul 2026 19:17:29 +0800
Message-ID: <20260712111734.1073514-6-cat@malon.dev>
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

The global variable 'askpass_program' stores the path to the program
used to prompt the user for credentials. Move it into repo_config_values
to continue the libification effort.

While it is uncommon for a single process to require different askpass
programs for different repositories, maintaining this value as a mutable
global string is a blocker for libification. Global heap-allocated
strings introduce thread-safety issues in a multi-repo environment.

Move 'askpass_program' into 'struct repo_config_values' to eliminate
this global state. The memory is now safely managed and freed via
'repo_config_values_clear()'.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 environment.c | 6 ++++--
 environment.h | 1 +
 prompt.c      | 3 ++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/environment.c b/environment.c
index 975c9cb9eb..1a26c9c6d6 100644
--- a/environment.c
+++ b/environment.c
@@ -464,8 +464,8 @@ int git_default_core_config(const char *var, const char=
 *value,
 =09}
=20
 =09if (!strcmp(var, "core.askpass")) {
-=09=09FREE_AND_NULL(askpass_program);
-=09=09return git_config_string(&askpass_program, var, value);
+=09=09FREE_AND_NULL(cfg->askpass_program);
+=09=09return git_config_string(&cfg->askpass_program, var, value);
 =09}
=20
 =09if (!strcmp(var, "core.excludesfile")) {
@@ -726,6 +726,7 @@ void repo_config_values_init(struct repo_config_values =
*cfg)
 =09cfg->excludes_file =3D NULL;
 =09cfg->editor_program =3D NULL;
 =09cfg->pager_program =3D NULL;
+=09cfg->askpass_program =3D NULL;
 =09cfg->apply_sparse_checkout =3D 0;
 =09cfg->branch_track =3D BRANCH_TRACK_REMOTE;
 =09cfg->trust_ctime =3D 1;
@@ -744,4 +745,5 @@ void repo_config_values_clear(struct repo_config_values=
 *cfg)
 =09FREE_AND_NULL(cfg->excludes_file);
 =09FREE_AND_NULL(cfg->editor_program);
 =09FREE_AND_NULL(cfg->pager_program);
+=09FREE_AND_NULL(cfg->askpass_program);
 }
diff --git a/environment.h b/environment.h
index 39b6691b47..a2e9def89d 100644
--- a/environment.h
+++ b/environment.h
@@ -93,6 +93,7 @@ struct repo_config_values {
 =09char *excludes_file;
 =09char *editor_program;
 =09char *pager_program;
+=09char *askpass_program;
 =09int apply_sparse_checkout;
 =09int trust_ctime;
 =09int check_stat;
diff --git a/prompt.c b/prompt.c
index 706fba2a50..d8d74c7e37 100644
--- a/prompt.c
+++ b/prompt.c
@@ -3,6 +3,7 @@
 #include "git-compat-util.h"
 #include "parse.h"
 #include "environment.h"
+#include "repository.h"
 #include "run-command.h"
 #include "strbuf.h"
 #include "prompt.h"
@@ -51,7 +52,7 @@ char *git_prompt(const char *prompt, int flags)
=20
 =09=09askpass =3D getenv("GIT_ASKPASS");
 =09=09if (!askpass)
-=09=09=09askpass =3D askpass_program;
+=09=09=09askpass =3D repo_config_values(the_repository)->askpass_program;
 =09=09if (!askpass)
 =09=09=09askpass =3D getenv("SSH_ASKPASS");
 =09=09if (askpass && *askpass)
--=20
2.43.0

