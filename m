Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA85547F784
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 10:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792234374; cv=none; b=hc32NV1invS6vZlW75VLQbuC472g5AVyazWc7n2fZEJAgpRT2WJntzrhVKeImKqfww66bGPpdMFUyPkLGTgxj0l5XuyMO8hPNQVOu4UN/Cs7Kc54ToqN6ji5OOBfSVOCVnJvaGSHMutoLnEeK2pj6XH1l/H8+eTzyq8+FHNjpUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792234374; c=relaxed/simple;
	bh=Kc43N2MIvGSwXtUw50NXUpedMn5GvaPh42Jya5UoQ/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lpCaLPS4VPYJjaHTdi5KIYgnc8tn6EgZyNBxFQz18Vanfw3DdjtsyK39bonRp77ry2vQX5YjCVQE/RSz11B0NY4tO+iP6Hy31hUtTj1UkaaoOblb0POddZmdxMrOTqIIzA1tpayuLnzL4eP2nBQgn59rmwn5GFMgHYGrLA7zeUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdpbhsRG; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdpbhsRG"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c40447e25e6so81073166b.1
        for <git@vger.kernel.org>; Sat, 17 Oct 2026 03:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792234371; x=1792839171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YZv7sNVqUT6ZBi5gc7e0xaL9q6mIZvGh2c9MqvEWNAA=;
        b=LdpbhsRGIjiCG5Hkp7gZ8YjRmMyO4oWfw5S82IFjq1kJYHdoS8votgV0gTxhYfHeCK
         A3+qVKoa8bj097+PhAaHGcrB1GvcpYVQzKMJxiKeOQdcXbIkIPd+m9x6k2NRj9sMqIzd
         WLkTAiwHpG6SmZ5MKkH0mg3l+nXUM4fv/ovQBWqGrUyYtFhZjuSoNs91IHgwcltMKAMN
         ouBiR0vmtVEGOT8lip5F3wVyRJ9mC+r2G54F23FOK5hvgqhfsTB8RyqPyhJ9LDr7s3q+
         pw6mwNT3ubzXyAc3dL7iTrv295RVQGpxfMwSSo5cbLGoqTKyCvJ6/eaG7EHXxuA7UwIB
         s1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792234371; x=1792839171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YZv7sNVqUT6ZBi5gc7e0xaL9q6mIZvGh2c9MqvEWNAA=;
        b=GKc2ewSjystBS8iieWA7xl8uCZt2LZLdO/YusIi0sn8ANvJAs/xtNKAFZMqqB7+UCW
         3bojriH2kMdOJS0AzmC9UzCw0cIqthNp6P5yZWR59/tavSLelQXqoANxxOas3KiNdcvN
         q4QR0VP9c0RzUz0IVJW8dJ7iH2Tz5izAS3+hc8ektPIUaMCjf2Eoxe1R9/fCVDmeV1Y3
         LIEqlw9swMaDDtd8kKo/qvdisJkLjWyCR/bhCQheE8r8leWalOt6gzpn3biAEZ1Kz0NT
         k4FbqpAtHTupFbiu0TmdG+YrCHgFGlYcdR7Nr8WuyGmbqNBxjwv111/VdBG3mwTACqCQ
         LUvA==
X-Gm-Message-State: AFq9FYIvKLrnYTGxweO8CF0/rry2koXInCisxptzxrkjBC2kyGHT2Buw
	jeo2B6TeIVYdv6wW46b6XSPM4rr5xhzJekvGpVZIEDEX/0GpE4k6JDUCplHX9d3K4kg=
X-Gm-Gg: AYBFou2ZsURbqzvOg1uWZuORRubhC1dw6XY2GzdgMgQEk0Jnv0lIAJgXmGQKEG5mRpC
	ahpIf9TgdnxEhvtyAH+QDl66Wp/xZLnl9QX85NEmXVoZ7xhK3GyNH2V/E1cgNzyT1M336C0MEUG
	Hl1RNO6JghqwGH9KrRRd0uYVSNLpz6pa7K3AxjFIwcLX3++nFA4o5DFH8JvPjyX4y7lbc3aiEqT
	t4mhdakQPAHclF3kT87itQWOl4no0McSZPEeqZ6phLNWyMiKMpGYggPW2OHEmveE4GA5g8+P+O6
	6+kIrLMCDT+vXo4SIlH515F30ItvV3Mz7t5a1cjvjUfhQxBLS3IK3uBDzr17euIUhY3g3Gz04vD
	3kYChvDteF4XOoTPNN4eeF6p6LrBjwzT8lAwlAz/lrNfqV5OlDcDoAEyNM9SMhDEkb27z1y3yVm
	0aJa2lM+LQwssxcQM+wtW+SjYBcPUvk4jhyeT0WjWbOb6NDXRadIaOavTnsDA7QhvenLHD9ok8f
	AiZF3co9v6W6etFz87j3NnwVcnfjSrSwr/D1F8lS6+hCe7uHAM5h0sXGnGAUpBHd5P1wWyM+bRt
	bRhuXlLpS8YOQvnKvyLhqq1S+mj1FiVdkZpgX/FgjovpzUzPVPCKqOGAfuae7p9cvCZw8BR4/OE
	=
X-Received: by 2002:a17:907:fd8b:b0:c40:4965:72bd with SMTP id a640c23a62f3a-c419e54061fmr148535266b.19.1792234370487;
        Sat, 17 Oct 2026 03:52:50 -0700 (PDT)
Received: from localhost.localdomain ([104.28.251.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40913c4c71sm166092566b.45.2026.10.17.03.52.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 03:52:50 -0700 (PDT)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com
Subject: [Outreachy PATCH] merge-blobs: stop using the_repository
Date: Sat, 17 Oct 2026 11:52:43 +0100
Message-ID: <20261017105244.90295-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

merge_blobs() already has the repository through istate.
Pass it to fill_mmfile_blob() and use it when reading objects.

Remove the USE_THE_REPOSITORY_VARIABLE definition and
include the headers needed for the structure definitions.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
 merge-blobs.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/merge-blobs.c b/merge-blobs.c
index 49dbec9529..1b0621c814 100644
--- a/merge-blobs.c
+++ b/merge-blobs.c
@@ -1,18 +1,19 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "merge-ll.h"
 #include "blob.h"
 #include "merge-blobs.h"
 #include "odb.h"
+#include "read-cache-ll.h"
+#include "repository.h"
 
-static int fill_mmfile_blob(mmfile_t *f, struct blob *obj)
+static int fill_mmfile_blob(struct repository *r, mmfile_t *f,
+			    struct blob *obj)
 {
 	void *buf;
 	size_t size;
 	enum object_type type;
 
-	buf = odb_read_object(the_repository->objects, &obj->object.oid,
+	buf = odb_read_object(r->objects, &obj->object.oid,
 			      &type, &size);
 	if (!buf)
 		return -1;
@@ -79,17 +80,17 @@ void *merge_blobs(struct index_state *istate, const char *path,
 			return NULL;
 		if (!our)
 			our = their;
-		return odb_read_object(the_repository->objects, &our->object.oid,
+		return odb_read_object(istate->repo->objects, &our->object.oid,
 				       &type, size);
 	}
 
-	if (fill_mmfile_blob(&f1, our) < 0)
+	if (fill_mmfile_blob(istate->repo, &f1, our) < 0)
 		goto out_no_mmfile;
-	if (fill_mmfile_blob(&f2, their) < 0)
+	if (fill_mmfile_blob(istate->repo, &f2, their) < 0)
 		goto out_free_f1;
 
 	if (base) {
-		if (fill_mmfile_blob(&common, base) < 0)
+		if (fill_mmfile_blob(istate->repo, &common, base) < 0)
 			goto out_free_f2_f1;
 	} else {
 		common.ptr = xstrdup("");
-- 
2.54.0

