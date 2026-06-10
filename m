Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAC93DD507
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 09:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781084227; cv=none; b=rMACIaJTPuzYJTEVDznVp4t9bHlgVh3VqE9QiP3/26G5wpzDrQx8UGH+OaKNNz9YR0YO46L6kIObCKdxopzIARhLIupsoxRYnyYAr/hekOn6OUKaIM7YpnJMi5RHDftwoP/J7ot3raJQ0WZONOv0gIiv6rr1g2BMg4Btx+nTpzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781084227; c=relaxed/simple;
	bh=xOqTjDQM5VBtNunLG7fXaE95Q00MHQq19H+p9wGxr2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WjV4eXIqpYq4IQEpPe7EHW5U/H3uXVhDN7VIBh3ysdi22OjZa4cSozmG0y6S0G49Z55QUqYTO9lbYbmzMNhvuUzH9QGBf1lB5L354EREdgSQSXRCS0LeefwUHV4WdXXBgxAuBeZjG3hNjL4ZFJEGm0H2iIHRMA67mXkA1ayygtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=jc8f+Lk5; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=LfR2jWSi; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="jc8f+Lk5";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="LfR2jWSi"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=jc8f+Lk5OuMczbflXGWMGxRZBNW38s8fo608mZFsFodhrKCNOtmfDQQ8Nm5giZCXFiKiCW1kreWtdDWzT6t5R5Ue26R9fG/bdhnryLCzqZFp6Mx3dHrev0ZT5v7eB4lyngSVV3WoR9vOjg+OFbReLrOKzHHA7cUfnrkRTipzEzzodfLaeaJI2PShSOnSYMPvHu+KADN7nxIfikRBQMZ4cWAsL130aOWbLtpBkIsryNhvYto4P4IkbN4p0Swsn8HCXzxRCSdBcXkAq84a9Md+2Ar8IJc0gJYgf25C1dRjzfmjHEtj8gO2YsYDQPNRAsDirgCNBY30+LvOh2Oey50chw==; s=purelymail2; d=malon.dev; v=1; bh=xOqTjDQM5VBtNunLG7fXaE95Q00MHQq19H+p9wGxr2k=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=LfR2jWSi5FwM4L/OltQTfLejya+6Q8my65gaBt9QT1DBTiTHwFn1RGxO3iBwhcSp1z1cE4nNhhXpqk5VoX42WNzX4bcNHiykqLm8+vydP4eg1gHSUQKwio9n2QtmI0pU4bjvq/hMfzjF12qiC5IUX9U952Bsygnh5S+VlOpphTKxTFPSuuOuQZzQ7Lk6Gz+HY3b3dT+LuEHkEJnxd7RDSfodPuEAOQV2KBzknagsex8j9PrRuD3oJnTtlxBC5iJ3FDDI9X4Uh8L6cClelnZSyBStKL635Htz27BxzHdXVnMqSIJPkGbt4hz6WJqoo0oqvBIs2E+A1HPjK9amHVqMEA==; s=purelymail2; d=purelymail.com; v=1; bh=xOqTjDQM5VBtNunLG7fXaE95Q00MHQq19H+p9wGxr2k=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1035819346;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 10 Jun 2026 09:36:56 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v2 2/3] read-cache: move 'ce_mode_from_stat()' to 'read-cache.c'
Date: Wed, 10 Jun 2026 17:36:33 +0800
Message-ID: <20260610093635.139719-3-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610093635.139719-1-cat@malon.dev>
References: <20260530160520.77859-1-cat@malon.dev>
 <20260610093635.139719-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

The ce_mode_from_stat() function is declared as a static inline function
in 'read-cache.h'. As we want to migrate configuration variables, this
helper function will need access to corresponding repository-specific
configuration logic. Move the implementation to 'read-cache.c' to
cleanly encapsulate its dependencies.

Note that the 'extern int trust_executable_bit, has_symlinks;' line is
discarded because it's not necessary when the function lives in
"read-cache.c".

At present, this change has no visible impact, but it is crucial
for our future plans to pass in the repo context. Comment
has been added whilst we are at it.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 read-cache.c | 20 ++++++++++++++++++++
 read-cache.h | 16 ++--------------
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index c44e4d128f..cb4f4878c8 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -202,6 +202,26 @@ void fill_stat_cache_info(struct index_state *istate, =
struct cache_entry *ce, st
 =09}
 }
=20
+/*
+ * Determine the appropriate index mode for a file based on its stat()
+ * information and the existing cache entry (if any).
+ *
+ * This function handles degradation for filesystems that lack
+ * symlink support or reliable executable bits.
+ */
+unsigned int ce_mode_from_stat(const struct cache_entry *ce, unsigned int =
mode)
+{
+=09if (!has_symlinks && S_ISREG(mode) &&
+=09    ce && S_ISLNK(ce->ce_mode))
+=09=09return ce->ce_mode;
+=09if (!trust_executable_bit && S_ISREG(mode)) {
+=09=09if (ce && S_ISREG(ce->ce_mode))
+=09=09=09return ce->ce_mode;
+=09=09return create_ce_mode(0666);
+=09}
+=09return create_ce_mode(mode);
+}
+
 static unsigned int st_mode_from_ce(const struct cache_entry *ce)
 {
 =09switch (ce->ce_mode & S_IFMT) {
diff --git a/read-cache.h b/read-cache.h
index 043da1f1aa..3c4af2faeb 100644
--- a/read-cache.h
+++ b/read-cache.h
@@ -5,20 +5,8 @@
 #include "object.h"
 #include "pathspec.h"
=20
-static inline unsigned int ce_mode_from_stat(const struct cache_entry *ce,
-=09=09=09=09=09     unsigned int mode)
-{
-=09extern int trust_executable_bit, has_symlinks;
-=09if (!has_symlinks && S_ISREG(mode) &&
-=09    ce && S_ISLNK(ce->ce_mode))
-=09=09return ce->ce_mode;
-=09if (!trust_executable_bit && S_ISREG(mode)) {
-=09=09if (ce && S_ISREG(ce->ce_mode))
-=09=09=09return ce->ce_mode;
-=09=09return create_ce_mode(0666);
-=09}
-=09return create_ce_mode(mode);
-}
+unsigned int ce_mode_from_stat(const struct cache_entry *ce,
+=09=09=09=09unsigned int mode);
=20
 static inline int ce_to_dtype(const struct cache_entry *ce)
 {
--=20
2.43.0

