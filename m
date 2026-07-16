Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC8B3F4109
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784191810; cv=none; b=tJ3nL4fHwEqSTcpZRiauHPDvLeNQ28hF/cBLH3A6/qTOR02+Kwf2Ze4q2Qy9zqLG1KkpdfUb2C+YJH6aMV+DO54ERBjob8Oz9WZtFh/HFjkguZtFVXOpVuEYM4J0QoImzt1Pbo4KUOHQpKREJ6lZRrxiDe1qRjiedD4m5vhwu8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784191810; c=relaxed/simple;
	bh=xOqTjDQM5VBtNunLG7fXaE95Q00MHQq19H+p9wGxr2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pvG0GcvcRYzC/orIaVnd3IsqxargFNeg8y/eyY+7Yb04Hsxo5pBCtvP3tYg0RxjihcshRQK1OE8H+1v9YB6t0Mg0fB0HZUagQcr8j6KoEeYb2ODAZl5sjy5ZkwpGi6hPP9NO988Wkld2KevkGEGMXXjR8bAG9A+1yjE4dumYgGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=FvcnMI3X; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=AuKmmVQC; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="FvcnMI3X";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="AuKmmVQC"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=FvcnMI3X7n3W/lpV/yns+4f4SZllebsz8W5EFo8O0drufJxoYe03SE2gbWjT2UydB5SpAdyFXZRKxs2SDVQGbBQKqb0e9yU/xl6iHYQCfkDAGxOp7c+aw0+L2MWwd5hdRJgGCEnNGxtlvVn1L6TJvFr845K9/Oh5IEDcZjkCmSY/5t7vIi/H2oOf/2tjXJZSF3RKkl24xfpxpQF2iArVNe2winpkSIm2MU4WLScGd+tcYk2GSfL9qrJQ1R8blij2sNiHvqAcWqc8kfD2Az7CIoB1KqJH0SJsFmxaJvyX0hnhbDtjJ9C7b3/Y8YNu++3es1e3Lvl6z1e4ApUpRGidQg==; s=purelymail2; d=malon.dev; v=1; bh=xOqTjDQM5VBtNunLG7fXaE95Q00MHQq19H+p9wGxr2k=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=AuKmmVQCIxSpsWyabK6QGuwQnVtGlE9z0C/wGjGzsR4QZqMWa3w/+VbBscUMx8Hj++ZpGaffJS9V6IgoJWRkF5jGpqPs5iV0NwcdH1Eazn8mxYovyPL+43wMskaH9xL7q7zF4e6xLhWO1rlvis67sdpGI9upIoZehwjkPwHfr7FdthlsgMo3SmYejcIlLdsagkBWQGpI7P5YGAeNPygP0UeizH3P7W5WHBq1uIDiNWyVqw2nbaGg4ikPe9zTUworfgcvTT+FB4MBQ6t2kiA0ftTSDnOwKEVn6Fbei8A4vSM/dRisv4+ng212f5wF+BCUZgPeMB/UlanMenZ9/S2jMg==; s=purelymail2; d=purelymail.com; v=1; bh=xOqTjDQM5VBtNunLG7fXaE95Q00MHQq19H+p9wGxr2k=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -873613066;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 16 Jul 2026 08:49:59 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v6 2/4] read-cache: move 'ce_mode_from_stat()' to 'read-cache.c'
Date: Thu, 16 Jul 2026 16:49:39 +0800
Message-ID: <20260716084941.1101918-3-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716084941.1101918-1-cat@malon.dev>
References: <20260715035501.48271-1-cat@malon.dev>
 <20260716084941.1101918-1-cat@malon.dev>
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

