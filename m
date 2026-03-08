Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9C21531C1
	for <git@vger.kernel.org>; Sun,  8 Mar 2026 04:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772944321; cv=none; b=mzt/z1xwADbt3dcUOk6PEdP+Bcu+PTWvnFcDe64RIiQZk7n8Mk5IwDnNP7Sfz0FA78pEtXQ6+RNF0vGCqmEpKSafBnZOBNEqRBA2SUm3HjaATnEELFPhBaiZ2LtJUej4wEMLcZh0BJHf9ueOMesK8VQdmB3/6yCYTsCd5j/U76k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772944321; c=relaxed/simple;
	bh=X0vI9C4IbSxKH9DW1b6H6nSrLpR1poLB5f6UEfK5Y10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sHj/XgdfQuK6KWO6ocBbAxGKr2+guJf08loY5HSwoQA0CNTchsgkIiIObgb/RMhravQkle9QRzupmEOg1OaiBMl6XurzoThy9ta6QEkzfIFPAlcC/fvoEr74uNes6mT7SwCMZaRjZyjKyBTddiVKiYkhweCf9Xoky2HY5JATaNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Us+8YvSP; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Us+8YvSP"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ad2b375e58so14534305ad.3
        for <git@vger.kernel.org>; Sat, 07 Mar 2026 20:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772944319; x=1773549119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p1tQn5k9Dxdi+97QGZI9s8RdWSX6XzmCB2gR17SLsS8=;
        b=Us+8YvSP2J8Wci0ADpcqRPjeK/13WBQP9IHswIx8tO1dR9XGt3jPn9sqCkPxza+HRb
         p+c7jzAiVUzqc92pTFy7SvixNRebqXDiZ4hcb0qaKFjFKMu+OMPMjJaT48na5oN0GKWR
         jjRdopEc6VKa665F5rLh5sfT2+zg4OAycuYTWUwVcNxBDfC+Tg/eFIyYCnQoG/+whmLN
         kdbEEXuFEqnMd4ZEwyfdWO/7T7ibqAURErd21DmGvzfCpACabw7C5IHMI49lpdYPoJ3c
         9i68jLGsHdzExL+AfJUdUI3Tk5eUOxLQmIDh6FdDzVJCN+L9iVF9sWifT71UFVcqjm24
         zMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772944319; x=1773549119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1tQn5k9Dxdi+97QGZI9s8RdWSX6XzmCB2gR17SLsS8=;
        b=o4ThEUJu2VzGtfCRoMEByUp8DAAZXmccfUP0SQkHxpWqqLzvgF6V/9JhXnIsrTy32p
         sj2gLcEDCs/17+7wf9YPpjwE4JUAdrNTpSbmx8vaofPhweKEKETJ9k6qwanyVICo2zRy
         qaQCM1RwVHMWCqKEt96srEfkrabMEZ4xjxEFEgU/xBXEf50Nyr7bKLJkiXpAQJr5IOrl
         O7dHteZD6Msk50U6+LcErFkRdiwi/xVheubGZWkoOoe7bw36AfHy4yNyh7hPpXTfqpVB
         Fa202nV0c3LI/8pdxLs6mEZXVQuq1mwqYwXBDRfslSVLseBtr6XDifX54NHKbmY4VpY0
         pC0w==
X-Gm-Message-State: AOJu0YwyfhvdF17Buwtrv+27V52+HOROYXqPi9fWjwe8or9oatuKUJZQ
	RvoFyDoLHnwLBQZg+T/mExieXHL8ZZqZHxzPYKKLOZLS7guTGvAjqiSKTPiSJVLY
X-Gm-Gg: ATEYQzz44GSFhubRtN83N61IoccU3dTEazs1zeVpXlXF07eoPmewR645Y1ku1liC2Rx
	Ww6fJPUemeIxiXXaCAdLUAc0DflZFFUVdj8aYyeNUVV4gN7dOhlULxtorUpmYjqZcJnxfV+ua3k
	LzapS3GbYzktHWm9zAE1c9IB9TPXR1/qO+PrmPx7z+F57wAfzxPJrSqKrVYI6hRmh9sxwhJGtHe
	kixgFwqbr534MEpr6Bo+wux03zq+0jtvB8JeOPaotnMBI6BuGG05anxusAvO9NXWCqWBRYI9/2X
	COcSu2t2eqQpXbcaSrxSnDP2y+phOq5BiLGh7+m7xz24WoC27hQZALfLJYH06piV0beJ9N/b3zV
	B+L9JjjL85CBucdyAO80XT1qIlVtbH2WUVvUYyuqElPL98foyYVNdNqNk9teDWh3Oz760dmKPgR
	3sxJCAfX/0pNuxET5Ew0kHrVV2lGwaeYwkUSunoIc3BNKwnGTwsLDpdCQnVBT+kVxEv7lC1ELok
	fvY4vebqTqyT1J2xS2A/Q9A
X-Received: by 2002:a17:903:2441:b0:2ae:464f:fe3e with SMTP id d9443c01a7336-2ae8245cd68mr48905315ad.5.1772944319132;
        Sat, 07 Mar 2026 20:31:59 -0800 (PST)
Received: from malon-Yoga-14sARE-2020.. ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e5774bsm93246965ad.11.2026.03.07.20.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 20:31:58 -0800 (PST)
From: Tian Yuchen <a3205153416@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Tian Yuchen <a3205153416@gmail.com>
Subject: [PATCH] patch-ids: achieve const correctness in patch_id_neq()
Date: Sun,  8 Mar 2026 12:31:31 +0800
Message-ID: <20260308043131.77782-1-a3205153416@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The implementation of the 'contain_of' macro in 'patch_id_neq()' is:

	#define container_of(ptr, type, member) \
		((type *) ((char *)(ptr) - offsetof(type, member)))

Here, 'type' is passed as a raw type with no const information.
Consequently, const correctness cannot be guaranteed here, resulting
in an eight-year-long NEEDSWORK comment.

Use explicit casting (struct object_id *) to ensure const correctness.

Signed-off-by: Tian Yuchen <a3205153416@gmail.com>
---
 patch-ids.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/patch-ids.c b/patch-ids.c
index a5683b462c..e2d29e9dbb 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -41,19 +41,18 @@ static int patch_id_neq(const void *cmpfn_data,
 			const struct hashmap_entry *entry_or_key,
 			const void *keydata UNUSED)
 {
-	/* NEEDSWORK: const correctness? */
-	struct diff_options *opt = (void *)cmpfn_data;
-	struct patch_id *a, *b;
+	struct diff_options *opt = (struct diff_options *)cmpfn_data;
+	const struct patch_id *a, *b;
 
-	a = container_of(eptr, struct patch_id, ent);
-	b = container_of(entry_or_key, struct patch_id, ent);
+	a = container_of(eptr, const struct patch_id, ent);
+	b = container_of(entry_or_key, const struct patch_id, ent);
 
 	if (is_null_oid(&a->patch_id) &&
-	    commit_patch_id(a->commit, opt, &a->patch_id, 0))
+	    commit_patch_id(a->commit, opt, (struct object_id *)&a->patch_id, 0))
 		return error("Could not get patch ID for %s",
 			oid_to_hex(&a->commit->object.oid));
 	if (is_null_oid(&b->patch_id) &&
-	    commit_patch_id(b->commit, opt, &b->patch_id, 0))
+	    commit_patch_id(b->commit, opt, (struct object_id *)&b->patch_id, 0))
 		return error("Could not get patch ID for %s",
 			oid_to_hex(&b->commit->object.oid));
 	return !oideq(&a->patch_id, &b->patch_id);
-- 
2.43.0

