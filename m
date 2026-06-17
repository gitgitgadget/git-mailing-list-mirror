Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BF347798A
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 15:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781711398; cv=none; b=JxgI74RiWlvoF6hk9UEotCVOmqn8/sePJJGTebpJFjSmsnozLL7e5KTCE0/ha4FRIZQsjpevGHxnhshzsJn3rtErwjp8AQeNuA+2hq6O+zBZez5j/0WNGLgXKFE8mDV0HBkXJ7oycCSyX4dnZjcAj81TlG1Uq0p+hbwKtVISdIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781711398; c=relaxed/simple;
	bh=fWoYBNQNSjnzAEOugW3vZdyyEAjxRPisHmjGuYv6sGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=anCm4hUBHwkbInE7J/g3M2nmkvZlj8US+NwiZRHnHhpLxhIkE5conur6HBAiMfXtyKHDvRljrjHDFQwfS53ax+ttUJcjJY7G/wDTTnEd5tAVOp/za+Bzd6SIpPnLbWxcjosCn8rDYoerM4ldwfdD1Uh0FWWQuDv8nyXtA4OngvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=BwiznSql; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=Jm0p2Ut3; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="BwiznSql";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="Jm0p2Ut3"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=BwiznSqlV3K/xd0KLMZOqHEZtK19Wgre5xxQ6wffHaGFnnfiYgjp7r72aMN2uIBD7Pc7Yz/ewXmy3Y/6Twcm+v92vBU76VGAohTBqpolFB/927lSiPcV5Mv8ew12pe+220txBL6FoycdcPCEV3Y3JVYbvXFdRFH7D3Ne6T/0fyfy+WihoyR3w79ZZgyZ7xDDoTfsyFx1sSt+mkYHv38fTaerYnXkMFDFSyPPLfMsgc+I5Xjpeb76JqqVoYvLw8GTdBPvwd5o0rkDvlY6bzTRxAmQW49RqwURAVEpV0fvb+YjvMFU+4PikGxgiUJK8aTg6/74dfUPBW0fc5SEVBOg8Q==; s=purelymail3; d=malon.dev; v=1; bh=fWoYBNQNSjnzAEOugW3vZdyyEAjxRPisHmjGuYv6sGM=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=Jm0p2Ut34H+rJk8h3XzOxNyLEx+Y/Gj+tNgWngQ56thQD31VtLrJWob/a1S73ICzGh3YdbkqDp5Jhfb6MlODbRSAkt+G00WT3CfoaocoSjpy06pbz8mn0NC9RXIFA6s0bFhnwBhq0tmUy6ZeITQIN/m/HIhPhRUdkRI0guhWDKjg1ZnWqyRWv/w2uk+ym40uw79tPZpeG26LbG+DPcZiqpneAsMgbazWf2pM9jL16Dt0x2jvgWpA5Az6bzg3RRi5LGqMSpNdpuh80A6bsY24JCkWu7/ExDie8/5DQcw+YZo8fjLl2YrirpBRBMhY6eETd1lffv7IlUoCDINQlAQ/LQ==; s=purelymail3; d=purelymail.com; v=1; bh=fWoYBNQNSjnzAEOugW3vZdyyEAjxRPisHmjGuYv6sGM=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 416529734;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 17 Jun 2026 15:49:42 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood123@gmail.com,
	johannes.schindelin@gmx.de,
	stolee@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH 1/2] environment: move ignore_case into repo_config_values
Date: Wed, 17 Jun 2026 23:49:28 +0800
Message-ID: <20260617154929.564498-2-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260617154929.564498-1-cat@malon.dev>
References: <20260617154929.564498-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

The 'core.ignorecase' configuration which is stored as the
global variable 'ignore_case' acts as a core filesystem
capability flag.

Move this global variable into 'struct repo_config_values' to tie it
to the specific repository instance it was read from. This reduces
global state and aligns with the ongoing libification effort.

Note that the newly introduced getter, 'repo_get_ignore_case()',
intentionally avoids checking 'repo->gitdir'. This could safely
accommodates early dynamic probing of the filesystem during
'git init' or clone operations, where the 'gitdir' might not be fully
initialized but the filesystem capability must be recorded.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 environment.c | 8 ++++++++
 environment.h | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/environment.c b/environment.c
index fc3ed8bb1c..c568d3b6fb 100644
--- a/environment.c
+++ b/environment.c
@@ -142,6 +142,13 @@ int is_bare_repository(void)
 =09return is_bare_repository_cfg && !repo_get_work_tree(the_repository);
 }
=20
+int repo_get_ignore_case(struct repository *repo)
+{
+=09if (repo)
+=09=09return repo_config_values(repo)->ignore_case;
+=09return 0;
+}
+
 int have_git_dir(void)
 {
 =09return startup_info->have_repository
@@ -720,5 +727,6 @@ void repo_config_values_init(struct repo_config_values =
*cfg)
 {
 =09cfg->attributes_file =3D NULL;
 =09cfg->apply_sparse_checkout =3D 0;
+=09cfg->ignore_case =3D 0;
 =09cfg->branch_track =3D BRANCH_TRACK_REMOTE;
 }
diff --git a/environment.h b/environment.h
index 9eb97b3869..9e3d94fb80 100644
--- a/environment.h
+++ b/environment.h
@@ -91,6 +91,7 @@ struct repo_config_values {
 =09/* section "core" config values */
 =09char *attributes_file;
 =09int apply_sparse_checkout;
+=09int ignore_case;
=20
 =09/* section "branch" config values */
 =09enum branch_track branch_track;
@@ -123,6 +124,13 @@ int git_default_config(const char *, const char *,
 int git_default_core_config(const char *var, const char *value,
 =09=09=09    const struct config_context *ctx, void *cb);
=20
+/*
+ * Getter for the `ignore_case` field of `struct repo_config_values`.
+ * It intentionally avoids checking `repo->gitdir` to allow early dynamic
+ * probing during `git init` or clone.
+ */
+int repo_get_ignore_case(struct repository *repo);
+
 void repo_config_values_init(struct repo_config_values *cfg);
=20
 /*
--=20
2.43.0

