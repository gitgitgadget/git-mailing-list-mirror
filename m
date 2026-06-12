Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643B13D2FEC
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 16:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781280349; cv=none; b=FMAD4OtuAvKlHuvHGTOtPky1Tf2kvGe3gp51NTTHuWxykjPjqp+FkID9gwu1RazWuQ/5+PwPv3ir8+GdIPpnZPOx7m11O8e+KjN+JKmpB8io+kQpx+P1GreM17T7H4Ft15uj5gjhcFqs+rUwY+VVW4VpeqG6Tw46fMXlbvRCaWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781280349; c=relaxed/simple;
	bh=0oaLoQsIh6Cs3uAU8MVNnAsWJplbAFI4CX3XnPIFyao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o1ZAmHjUCVoLGKqEunmCTTAz+uIeo0dROftYKAYUuPq3ra0Cszqrr8AGLyCwLWZdR+2TKmgzmrP3HIQJv8chUo0ac+EsrlqRxbTCmGweVKXWxY0KueLW0pyxR1KQT6Angfg8wf0reor6d3GyFNxni9n0yy9hWLDs41IZpnP9DiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=AnTe/uLC; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=PQvcotq1; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="AnTe/uLC";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="PQvcotq1"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=AnTe/uLCGD7ploXXYj92cvqKkUexZqtdCiMzEcZ1Q1DW2klTuBDd9GJnT0lRd30MLNcmcxCtADnZEu/KzA9HXA0x79X8HCafjCoXhMVq0uYV3/pnoSDst1cOq5WWw725K/Zni775aCzj/+Do/CXf46KEXwtUENd+cvmnZxHn51KJRm273gaPJswFPvRTF7Hom+c6Z7awUz4lWwRbjOk9mlLqvBkFkgpYSCMyEBjptkEmmycwcm7Wk0DsI25b5uQJSp7L7sjRPBoDFSjgqW9JA4cJMlueoV2ijUer6gi7VELqSWZ/k/NQsQCBoDguBl4OCILFebvjVgW7Q8p5GB15DA==; s=purelymail3; d=malon.dev; v=1; bh=0oaLoQsIh6Cs3uAU8MVNnAsWJplbAFI4CX3XnPIFyao=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=PQvcotq1vdToLJKlbCrdp34nWGhiBD1ZtzEbn5ZLgY87cyaOB1UdcYNS7PrKWLw9uKAJUUdKKdRfy7+Yw54joqrWa4zX3Z5cHOBzqLJ3z04h/s5zf7EnnBX9JRM6iPl5i7ZYSasnUHSoRm+VcX0nU5e94RVbT5NCTbtyuAlkOt979EAuE60s/Af+5BPN6qQ0WIXnM/euQsxnZX5VwNQeK5MS/KGvgVcxOwm80/o8M4WyWa4C4aXyZSPlD/j5YEbxob/v+EH2sPgJgLqJXyvA8A3/hfaaVOOgpLQbVkMAI2hxBuWCPtuj1XcbkApcfZf8NrA6ujn/F+GCfC5DS30Vsw==; s=purelymail3; d=purelymail.com; v=1; bh=0oaLoQsIh6Cs3uAU8MVNnAsWJplbAFI4CX3XnPIFyao=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -702755865;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 12 Jun 2026 16:05:45 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v3 2/3] read-cache: move 'ce_mode_from_stat()' to 'read-cache.c'
Date: Sat, 13 Jun 2026 00:05:25 +0800
Message-ID: <20260612160527.167203-3-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612160527.167203-1-cat@malon.dev>
References: <20260610093635.139719-1-cat@malon.dev>
 <20260612160527.167203-1-cat@malon.dev>
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
 read-cache.c | 13 +++++++++++++
 read-cache.h | 23 +++++++++--------------
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index c44e4d128f..54150fe756 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -202,6 +202,19 @@ void fill_stat_cache_info(struct index_state *istate, =
struct cache_entry *ce, st
 =09}
 }
=20
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
index 043da1f1aa..9088a0724a 100644
--- a/read-cache.h
+++ b/read-cache.h
@@ -5,20 +5,15 @@
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
+/*
+ * Determine the appropriate index mode for a file based on its stat()
+ * information and the existing cache entry (if any).
+ *
+ * This function handles degradation for filesystems that lack
+ * symlink support or reliable executable bits.
+ */
+unsigned int ce_mode_from_stat(const struct cache_entry *ce,
+=09=09=09=09unsigned int mode);
=20
 static inline int ce_to_dtype(const struct cache_entry *ce)
 {
--=20
2.43.0

