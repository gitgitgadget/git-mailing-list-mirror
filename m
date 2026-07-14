Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9416E3A4510
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 03:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783999552; cv=none; b=TN3g87PJSwOosn50AGWxQ+wDa77Nj6/aKDxLbiQWCYnbrXj+WqBJSnZCpt6M9L4+LXJH0ntqGaUaJz9+C3+BPy54rxZLrZEhgnDyqRrormpeJKWreqaTOE//pYH4CnUoHf3e4rquQkJL527mFxrkAUfICrSPvHMWrxx1Guv5I7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783999552; c=relaxed/simple;
	bh=tVER+9f7tZiOirO+PzEmvTx4o35QkcQfFYjl/Ao5tl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XgogsObLX6G2XzwXhbJSbeDNYJSjvqaEZRXlX8XvJP2DyPc0wtAKW9chbVedmKNMd/T/k+fFRehuz7fY16JTwj0MxRPHPm0SrjSv0bRGdG1/Cbc5Kf3rttmHoL+RcwAD+aXEbHJ6khVN8h7XrqROM6Qed9uOG7KcL2qOsK8DfQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=clq4k3hh; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=OG9MEdzz; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="clq4k3hh";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="OG9MEdzz"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=clq4k3hhCq6oe5dl1Dki3O/t5QJGQOQfmtC6HkQJfDm6o+QBGrbpvn5bTxkNl/Wmw8rEOhnmULiFiq6nQ5lX4uFzZQr/I106P21Z7cGTW3SM6mugdcyofQpcjVPII58uPUq1o+iM3njdFzKGVJNMkfX638fF1GzerMfKb4OibIOr/6ZfqnWKA34WPVZcoYvv8H8peR85kmbo7AoFBFc1/eAxgqGzsJcFIRPPNw3h0e+HGZCpxTdB6sy/rulTDaEt3GMjs6hIJ0+8SbhKJ2gia0IW7pUjqDuiy1fXB4ozjzjm5saew8tF60QrYAQT2TIuADDu310mAkZtOy9Tyb7+IQ==; s=purelymail1; d=malon.dev; v=1; bh=tVER+9f7tZiOirO+PzEmvTx4o35QkcQfFYjl/Ao5tl8=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=OG9MEdzz7GelaCxXnvGTImuIEgHPpAiq47ERNpLae8KWlJOaQ7P+pyjo34Ik8CdUBAeNtfZRJRLC4aFgT9+saCmVgaovdRB8iffvkTwc9GfYoDLQ6eP9MdrYU6nWajPcWgD1Cyib8qF5vFh59a61P5Bn+H+YN0UFdCQ5fAODlqQte5qF5BA2Q8iWpd+S37CaBY6dwWWJ2aPvaf26hNI99OMmMUz9xATdcDeHcwWHC5u4CTGHFPjA/EkGRcuu+BhNaLdzaGbD6VPH9VXA/xnEWfK06kGuiDUXquZcSerLc0WNDVl7ADLISMI9jLVLak/Gqqh3x7ezHea1+s/VRWEsgw==; s=purelymail1; d=purelymail.com; v=1; bh=tVER+9f7tZiOirO+PzEmvTx4o35QkcQfFYjl/Ao5tl8=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1695711826;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 14 Jul 2026 03:25:48 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v12 05/10] environment: move askpass_program into repo_config_values
Date: Tue, 14 Jul 2026 11:25:20 +0800
Message-ID: <20260714032525.1611141-6-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714032525.1611141-1-cat@malon.dev>
References: <20260712111734.1073514-1-cat@malon.dev>
 <20260714032525.1611141-1-cat@malon.dev>
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

