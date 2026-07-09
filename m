Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791EB2609FD
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 16:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783613545; cv=none; b=FfTuxipqUZdQu8omk8COis124l0a9h8QmDfLl0+o6AS30lffnh21h7XjXyqaktIW3F8BDB6JjxKIcOLhiftPlO7Iq3VT8A9alIhyhIRi1utJvgEVvsqBb1e9pT+cStssMEaeGrlmMmHkOGQEnz0IGDucn6bQQebht9fuu1fA3Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783613545; c=relaxed/simple;
	bh=G/N4/GoBGArFbwzq0okUmeG4pHfbbJLUMy3m89IS4Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OjEv3cBOUVMh7FpkiO4s0iWNb/U02ZbKLz8QnGERoF8+fmtIUA1Vx3GV3AiXPjxm0p2LaxbPMrqMZbCw/543JjSvCREPjDJUJAdHJIF/BubYUrz2ota6YmW8mmRRVDtC9YfG3a4nzauizUjfK6YJ6Xj/reNumvBEN9a1qw0niuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=JgG6R4Rh; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=CFeZsYTf; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="JgG6R4Rh";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="CFeZsYTf"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=JgG6R4RhuQ2cGOOPS/+IGMV1zlMM4Q7yMvN7PxQVRi/j8CIGsc0PdCLJKHKTKw3C1/6YzXmsCzdc0ws2nOQ78Bcmd4Qw6l9m8TnaGc6imz7lai68BVuitPuzuLd6TcWo/ZEEfK6l8P+wNjrO7ODEpltrcpoGZa/lsuzhY7yqJRL68FERK7/116fx3NqDWehUu+T4y+OrDzYR6Adofc4cSs0t5T6yzCidTHIELGVFdAVuYsZTUyc+8+w8tCkb1TYhYgZu3CGswauddEjohQmMctRsYFOKPO61mLE08U6rd8rG/qkOmzBPOcAilNnRqjRPh3DoQ0rwgdoAsymST0ZBag==; s=purelymail1; d=malon.dev; v=1; bh=G/N4/GoBGArFbwzq0okUmeG4pHfbbJLUMy3m89IS4Wc=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=CFeZsYTfGcogg5Qu/S/UQ5dAZOVFyu/S4B1YaXlKNzv0s/UnoqA6uAYn0RtXNJDKWy2cxXupj8tLivit1ZkK2h+4GsGCXAp472whSAaTUFleuaCifASR0ErTFY/jv53dOuBkI3PYmF3CYbS52IbrdPDdElvByoZxLA7Xq31cOcpReJdFHeN3luSlGpHMnw7r2v5gwmlUsZLt6FTzzoq1QXZuxRy3CELF5aRXpfp2hglZg7Q36f54Vx3IPbT4I/4GZzaGZmv2iQjRDMHsQbNgRPiL985Z6ZoxufYJVTxPRPr6iBnwBz6vox/5hxUepHfYuEcBFsw6F3BpildBgxFuMA==; s=purelymail1; d=purelymail.com; v=1; bh=G/N4/GoBGArFbwzq0okUmeG4pHfbbJLUMy3m89IS4Wc=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 872182701;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 09 Jul 2026 16:12:22 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v9 5/9] environment: move askpass_program into repo_config_values
Date: Fri, 10 Jul 2026 00:11:41 +0800
Message-ID: <20260709161145.13349-6-cat@malon.dev>
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

