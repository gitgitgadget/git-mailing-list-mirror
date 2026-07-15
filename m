Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B546A3B38B6
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 03:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784087717; cv=none; b=jdt6zC3FtdaMHM+i5hIdx55aHRwI9OGKl+d3C6T1j8qKjjN9K12xZ8qdTQoCbTjZH97J32XDgZoIrmPr4fb+J7jgYpgRMCUoj+LbWVlauG91GGcx9oRtrZ5zFVRbwbGrdWn46s2Hek5txb8SRQIRejImE8JkDuvRzBzv32Q+QyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784087717; c=relaxed/simple;
	bh=xOqTjDQM5VBtNunLG7fXaE95Q00MHQq19H+p9wGxr2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K/1wMvYgfY9j7D5pkSPmHXl20l0Gj4stvmfaP83JR7OeBdcHFbdfcpoup7upVY5XZ0E4mkhdMsfU1CoUWUdvb6l0MgVof4sc5WDdaw+UE4Q6NzwKE9B/m1/UCbXFf1fMmuB0sBDUr1z56CRmwIFbW7VbLWnWh9oeVwN+dnz/hj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=KcJY18cB; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=T1u5zorZ; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="KcJY18cB";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="T1u5zorZ"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=KcJY18cBoKd1Dtg5nZMCa1tI55a9RPjCCzFSsqBPkvCTT55YKFChpwtRU3q25Ggbf3a1NUvaxOZjyK9tcvIj5E3kpSZzeKITnrn2tSgtV8am0CuxAeomGtNQmwWUMLS59ZpR0Xab84bWxo9UN5LyvKhSYpRpdEKNAc9xoqkGy0Db/XTE9reonDrE52oippCMgQic6PmTipN+D83+wbcfxcjxOOsK6KcgN2PpWsOLDI66LjPFEQgXdft7G02amZ1Sh5QULChDOEFhBK/koJhPSo9YFU+O2ZbI1OwIK+iL+i7b/kTZuzLbw0fob7+snkq+kcbKOd9/T94OIsVOlv7qbw==; s=purelymail1; d=malon.dev; v=1; bh=xOqTjDQM5VBtNunLG7fXaE95Q00MHQq19H+p9wGxr2k=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=T1u5zorZYNSoG9tJrdIMJqTfi9mkd4eVHyNmRBwKNnbHzZv5lprZ08DL6u75zo0G35MIJ4L36gNtx3pif2Pp46B6AnJ1zWTsBYn+VkFb+ZFpYrOpfSr2i2jwC/J7ocncrPafDKDn7yQ3OhglSaGnvQfRsEn+wOLxaAHW30vPad+TojX6xiMHgReVHX+kan7Wod5e6Jgz3mRdpQ3qXxhgOBk2tDnmqRv7cNXN6hrutm0G5vjhbs0Vdauep1ABni0mdKfPkrOMKphT9v17FLmG2YX+rKC0PFqPxp2qykDpWRYtegQo3F1SVaCZODq7+HT8IP2j/fxCqts7sMUwQ+VFeA==; s=purelymail1; d=purelymail.com; v=1; bh=xOqTjDQM5VBtNunLG7fXaE95Q00MHQq19H+p9wGxr2k=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1876003495;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 15 Jul 2026 03:55:13 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: ps@pks.im,
	cirnovskyv@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v5 2/4] read-cache: move 'ce_mode_from_stat()' to 'read-cache.c'
Date: Wed, 15 Jul 2026 11:54:59 +0800
Message-ID: <20260715035501.48271-3-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715035501.48271-1-cat@malon.dev>
References: <20260619162105.648495-1-cat@malon.dev>
 <20260715035501.48271-1-cat@malon.dev>
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

