Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4913783C1
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 03:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783915088; cv=none; b=jtqr6bsETvi+2Ftvk7YLGgAbndZsCilgaj5ptRp3X2wxef0XlWdTyvwZEGR3ZG9var+4oT3zIQhm3sZZkjy7QTYyaM6lRoTsBPabXAapO/o7N9oo14iCSSI0+Xs6nMQY6Za6Cn1irXhsH685YTODBFiqsJC/pmgwgPkV2pervh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783915088; c=relaxed/simple;
	bh=tVER+9f7tZiOirO+PzEmvTx4o35QkcQfFYjl/Ao5tl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gC9hg8Qw+9xYBpAg+F/lynVjg9prZuTPhrh29RAMbydxqq6EADR0zKjXbdg0k2WYI5mvLQiIOeRsAqigo1NrgIbuQc2z5yk8A+haXzg8Bcu5uKMT4lwvXEqlJ9d2H6TtHNfbj9QMQQz9a84FBISPvEfFlXKhZXP+SNFZdM+HDs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=d2DqoXsu; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=e4DT4XLx; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="d2DqoXsu";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="e4DT4XLx"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=d2DqoXsuVkb7eCHvVz7nF4tfoEZE1e/98hMF2EvwecVllPi+vbP+wNZ/ctPM+e6V+7a8fnTOqk6RKPCg0ZDJi4UwhRGG0A6fHRdPf+Mb3nmk8yRXOSIc11cag9JH5o+t898IXKA7wKP8YryAEzSBeK1lLRBS8eS+jRtC8uvLxgOrTlHBshFNk/E6exhTPd4cxsUiZc2+115BvtfTlSFtnSOalrmbrwHuzKa7y/+2uWusrefuxNnNLWUiKZSdXrQHrHAZlxYpEypyZELjTfxposAbWK7C0Ln+EmfuIhtqrj9IA4tVR5QpyjfAaaLMGyLW8jUqlc7/JvqK4y/ytWBctg==; s=purelymail1; d=malon.dev; v=1; bh=tVER+9f7tZiOirO+PzEmvTx4o35QkcQfFYjl/Ao5tl8=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=e4DT4XLxjGZlnXLp/Xw7wcCfC2QMfGBSpkia4V5NQRXSQph2gL4DV+BhzDWtt6gFItCofbVPWWvKM4ixMhgTpDdlbVTFzMqPmkRa79aa68KfVb4vSkK3afTCi3lTGhwocy91tRjv796zVecwguOElstWFiiyqlxWmhSqFxRJmPN6l2tYZN5Bs6/ch8TzogOo+QAKfjjFA3HO8Siz/EIv9SwyJdPSG6ZGg10zDwd2A8O4k+T0mIZ4Jw6eoSew1+ReiJl05uRWWlKoBc3ow1mwYZHl+bN7Rqt1TkQFd240m5QlJW1m3YRWz5uleGW3p5C0SKoUZLoSJH1ND9X0r1Ijeg==; s=purelymail1; d=purelymail.com; v=1; bh=tVER+9f7tZiOirO+PzEmvTx4o35QkcQfFYjl/Ao5tl8=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1573664722;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 13 Jul 2026 03:58:03 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v11 05/10] environment: move askpass_program into repo_config_values
Date: Mon, 13 Jul 2026 11:57:33 +0800
Message-ID: <20260713035738.1606138-6-cat@malon.dev>
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
 environment.c | 7 ++++---
 environment.h | 3 +--
 prompt.c      | 3 ++-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/environment.c b/environment.c
index 975c9cb9eb..3857818da3 100644
--- a/environment.c
+++ b/environment.c
@@ -55,7 +55,6 @@ int fsync_object_files =3D -1;
 int use_fsync =3D -1;
 enum fsync_method fsync_method =3D FSYNC_METHOD_DEFAULT;
 enum fsync_component fsync_components =3D FSYNC_COMPONENTS_DEFAULT;
-char *askpass_program;
 enum auto_crlf auto_crlf =3D AUTO_CRLF_FALSE;
 enum eol core_eol =3D EOL_UNSET;
 int global_conv_flags_eol =3D CONV_EOL_RNDTRP_WARN;
@@ -464,8 +463,8 @@ int git_default_core_config(const char *var, const char=
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
@@ -726,6 +725,7 @@ void repo_config_values_init(struct repo_config_values =
*cfg)
 =09cfg->excludes_file =3D NULL;
 =09cfg->editor_program =3D NULL;
 =09cfg->pager_program =3D NULL;
+=09cfg->askpass_program =3D NULL;
 =09cfg->apply_sparse_checkout =3D 0;
 =09cfg->branch_track =3D BRANCH_TRACK_REMOTE;
 =09cfg->trust_ctime =3D 1;
@@ -744,4 +744,5 @@ void repo_config_values_clear(struct repo_config_values=
 *cfg)
 =09FREE_AND_NULL(cfg->excludes_file);
 =09FREE_AND_NULL(cfg->editor_program);
 =09FREE_AND_NULL(cfg->pager_program);
+=09FREE_AND_NULL(cfg->askpass_program);
 }
diff --git a/environment.h b/environment.h
index 39b6691b47..856dc70cc4 100644
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
@@ -220,8 +221,6 @@ const char *get_commit_output_encoding(void);
 extern char *git_commit_encoding;
 extern char *git_log_output_encoding;
=20
-extern char *askpass_program;
-
 /*
  * The character that begins a commented line in user-editable file
  * that is subject to stripspace.
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

