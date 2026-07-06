Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A5A3793B8
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 14:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347975; cv=none; b=mfQHu4lLx4p4Lu/IwqRBkoWPNzINHmIwvY03Ev1heb+uQ84iRASN8bju3yZuM6AYKrE3y9hmZMl21ESoYvF7JlUa87/tiDmbLH6LTq8Ka7/zFenT/sh83AEG+gce5GPIRJHIt8MJN3V8y4hJka/wcnL8lV3ubec2+Oq/ZGDKnhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347975; c=relaxed/simple;
	bh=G/N4/GoBGArFbwzq0okUmeG4pHfbbJLUMy3m89IS4Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hVyK9WQr1Ti+YfnnKthbPokrCu+b06Mth3McHPnmQbXgtiIx746KdHNu0rfeXi82qvdU/D5PLpRHZsmr1nhbDvKRAdU2MQfMAcB4v0ShWgBRmB5MQHO+RHDbl/Imp9EOX49OvOxb6CYDQLpiRLiFlgzT0Btwoq8S6+kWWo71dbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=b5FvPJQl; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=qtUmNUTK; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="b5FvPJQl";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="qtUmNUTK"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=b5FvPJQlGTevjV+mR6Wcs+GEt7bzGkdHyAVeHQKKTT1vYix6Ott5MDrrgPQ7APBx/ECVgJxHnOdLrjOY1c6cF1r/cvYktaC1nHYmAip6ywmhB1fHwiPHpfTpNfRmkMMKHvMKq13UtfBKlpOLEzW+obriIl5rExzJYs68irHnD2B1nSb1RpYbieXdLA944/G1Shd7Ne1N5VCJF0zHX0MpsjwM3w+zNGNe23XlekPvHmx7NGOMDlRgTL/0V5tvBYIe9B/wFX9UiVMeEBWZvdV2SeTlVzn8F/EDdVx3M1tH+sLcSqLm+q097XS7tC7+f1E7pMlKL+vAPzjmNWmBQU3trw==; s=purelymail3; d=malon.dev; v=1; bh=G/N4/GoBGArFbwzq0okUmeG4pHfbbJLUMy3m89IS4Wc=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=qtUmNUTKDylRvSEhOKPn5ELEgmGf52Cm86mJa/m7MRDvLZPQ2Bg86bQBeOK9g2Xe/GgzyHlq+oL3R3E0yML76j1pIg0Mr42OJ7wGJOoLzlG6fsrEtJt8cplfcmZidHc/cDnnjQyi/aZF7XjVe65tWweYTaP7XyulCRrnHN2RwhkbMsH2Xyn7PWmRlqnII4dCuKGmEjMjIakclumNtnX/BUuAReQSyz2hJkEhrjay4d60Mv/tZG+1Z+Ue1zJmVy8g7Z15PlX3Oro0RPMyGt5OyqTrpAwOEP8LmcLHKjEU03o/tM99ICPPitqzXyAQsgAi/DnWohKVo5lGO6QWgNgphA==; s=purelymail3; d=purelymail.com; v=1; bh=G/N4/GoBGArFbwzq0okUmeG4pHfbbJLUMy3m89IS4Wc=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1851978137;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 06 Jul 2026 14:26:11 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v7 5/9] environment: move askpass_program into repo_config_values
Date: Mon,  6 Jul 2026 22:25:26 +0800
Message-ID: <20260706142530.3681520-6-cat@malon.dev>
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

