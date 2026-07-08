Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63053370ACF
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 16:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783526610; cv=none; b=bWXGVno0FgVYhFcPL69XZZ0UIT3FbQZ6Bloxbm9Ql86tMbKTB7R7Y6Q2jRfhnxIfEK+RCZ9heDjtNV9bJ+JH7ug5x3LPKqlzQ4kFjJlrSLVqeafj5+44dIEbZENeIXEkLWDeUOddIKnrrHbIT04QX27FChTIbDHiRuqv15IPIf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783526610; c=relaxed/simple;
	bh=G/N4/GoBGArFbwzq0okUmeG4pHfbbJLUMy3m89IS4Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QajLWYpYDku0vBqAvAX2gGG3N8jndJkKZTW5WAsVHH6ioGlv505CYOzV23LQn5Nl6/ATfnRvP6t9w4Z50vsCLj6reIq60rxoLWzp0NETy4zS0kfjhjVYU9bXEZfx8R5SvBIb+z1Hg9QmfrIOa0FXp/4VxmsdRHaOGVccsIrOdac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=jUtIw0op; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=JlqbYf9B; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="jUtIw0op";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="JlqbYf9B"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=jUtIw0opvKRI0E/jfuDOGhm1NmFCJZZiSX7tH5Rs+GK8iPDPj0w36b2WCzaeqlOlHG6vCZC/NjjIht7oLT9g2NkIZ9yVJyTrYe5+AMmE6ZVvZM0jg/w4ufQ81IpY5aZolYu3flAorvH0cJfLgrl1BtZ49Nz9W7mPgjvdQp/w5LdhqMQvSnt3mFtgf0RSvgeR88EbdG0K4MF8/5E/tFHD98PQDHgA3n2UvlNpcVPaasm+9CUOSodA6DAsq36BkhurGJ7L1JdVrXebZPniRLSksCVBUJFy7rz4deteZu09wb9h4SVMp06rE6+urIXU3PHTxULTUzBCSFO3OD/ffHYb1Q==; s=purelymail3; d=malon.dev; v=1; bh=G/N4/GoBGArFbwzq0okUmeG4pHfbbJLUMy3m89IS4Wc=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=JlqbYf9BoA6YTAcFQsKF1ouSOjA0IGJwb2oZEoKiw4tnaqqEPcIbqFfBLhIRJYU4G7tdwTewMZ6MvB6u6YfB8sT1FHeyW75eBaxsd9i0SHbetGkSCPRaUoKF1bVJ/7/8hcScJF/zFDLZ1LNtNmpVebnkgK1PDvm0dG1C1KOipVcZW9W478O7Lq4EDyDbq15DBmGKTwlLWmddCDzbCxHZEpyxS6AtVc4GSWgvgd7nMOirlA6sNgfTjhB8oJFomzlSi+poKt0pINfARH1o4A3FHBSZs4ygWQBb5Jw7FimP4e7vkwgdra9tDg/Dn92hzl5ezfluhAUSmh62Tv9m07Ty7A==; s=purelymail3; d=purelymail.com; v=1; bh=G/N4/GoBGArFbwzq0okUmeG4pHfbbJLUMy3m89IS4Wc=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -238025841;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 08 Jul 2026 16:03:26 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v8 5/9] environment: move askpass_program into repo_config_values
Date: Thu,  9 Jul 2026 00:02:56 +0800
Message-ID: <20260708160300.8852-6-cat@malon.dev>
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
index a1204fdcb2..3782bf68aa 100644
--- a/environment.c
+++ b/environment.c
@@ -462,8 +462,8 @@ int git_default_core_config(const char *var, const char=
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
@@ -724,6 +724,7 @@ void repo_config_values_init(struct repo_config_values =
*cfg)
 =09cfg->excludes_file =3D NULL;
 =09cfg->editor_program =3D NULL;
 =09cfg->pager_program =3D NULL;
+=09cfg->askpass_program =3D NULL;
 =09cfg->apply_sparse_checkout =3D 0;
 =09cfg->branch_track =3D BRANCH_TRACK_REMOTE;
 =09cfg->trust_ctime =3D 1;
@@ -756,4 +757,5 @@ void repo_config_values_clear(struct repository *repo)
 =09FREE_AND_NULL(cfg->excludes_file);
 =09FREE_AND_NULL(cfg->editor_program);
 =09FREE_AND_NULL(cfg->pager_program);
+=09FREE_AND_NULL(cfg->askpass_program);
 }
diff --git a/environment.h b/environment.h
index 22f6697c52..d55b1ba073 100644
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

