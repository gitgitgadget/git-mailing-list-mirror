Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029D73AC0EC
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 04:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783484065; cv=none; b=r48buG3e5wq5VmFhsPvU4GikkRURXwKOHtu8wIKnCrRhp7R+1Nza/UV6n/FcUvtvLOqw4JXkgQCpniZ9bCUWosW+/MQmJ7CkWwCgBmKFrWB3Emn9RnD7Bdg/H4D0iN796zCuzeA1/ilky4Z3oHTEJ056SqOkB6Jt1SzZb7zNfRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783484065; c=relaxed/simple;
	bh=LgJOvA37/dn989m/9nA4etAmFKnNL4+6BPFhTkQDyqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJq2jLWQm9GelgRgx3MSdlCQcb2GIh93o2q976IZkfUniRGi5YKgnFAcBX/koiIkTQzTaNZkJIcYZqLoPzQOWRD9CqWsRig11SFlQKfKURuIewsFq7IyGcaIWlahpAD7QeTbDBGPKgU/kjqFR6xAKQVfYxT6vB7tdZbMdRZDpps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcPGzq6D; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcPGzq6D"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7eb68bdf53aso88933a34.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 21:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783484063; x=1784088863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qDSOP+3BniZFgdUwWWr+Ikn6OeyHKX1hklh3zV0kIh8=;
        b=XcPGzq6D57uigimFpYHj2mDBsmkTQI+AkPvXO0kSgIhdOJQ720iQ+xfT+x9OAzORcJ
         e27GP4dQdHH2SvEAsQg/2XlqFZ/ztQFMpgPn5q+hPmu6RQe/q/vCd9Zd19U5Bf1YUgH7
         styrI7h0h6O04DcFXP8QW0HjvOS7htDqpB7piUQkc5pbSKS2qk8yG9R2jhBILXSYi1eT
         +vDle17vSZBQp/+IUjnfsELgHEPBxT4TogVBLyjDJooulVHhFfJ+0c5xG2E9p1TUgoNe
         46nF3OlKGac7xFdVn5wEV4mq6nTE8Deta4fyrYBwdQAZILi7N6Fw0z7aTVvh2btwSnG3
         eA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783484063; x=1784088863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qDSOP+3BniZFgdUwWWr+Ikn6OeyHKX1hklh3zV0kIh8=;
        b=eC2TDVFY5Y93ZJEn7crF+/UqNRibBZhiepERB95tpXtfBrsF+87FQ26ehURgO5gBRl
         mHzs+bmeNFai3BjeoCVlyEhg1hlvuUncgU9F4Jl0a0UF2jyQ7/oZQvHIz1mVIZ4AVLUs
         0ZWNmDM2CrA7LQDtuZJ1c5ja9bPVVeRhmq0xMs0ej8GjSTDfLKm/+zsF17iAoG1lvHm0
         oS+/WrBbKJvyrwvnZvcbSK2ZpeJMQZ/525WxfiWnNYkVVafMvpcBniar9VSSNA/EY6DJ
         6T7XKayyDA2MPBGHlahTrKNOjUb2MpweZnB0/B6uDwbXVNSq3388SbvqjJCVOU1a26kD
         LrrQ==
X-Gm-Message-State: AOJu0Yzs6S+UjCOTY6DlzvVSX7EtLIoo86lK/J4wREQs5BDhF68+m/p8
	wdjwZpt7tTNB2037e4pE+tebBE8YuaoEWglqVz/KyGOObPZrJ8XtlX4s4dArjQ==
X-Gm-Gg: AfdE7ckn3xQvYA2Tg6KiomJP+aXgGcvIprBBuZPFHcEG4e2Otvx5YpzEfohInEN60ah
	HUQ7JdoUBl8NX57ZxqEzTjWkW1Bax4T57p0C3vdQk/zcw75A2HZS9NI6vpITXus6oJTZ976UhQJ
	k08J12+aMHfUWKzCQjjKVZjI5Ftn1Yz1P3OwVYmOWZ+4Tq9s9ZtkNavFyI7F31I4XdWkF7UVFhM
	QgAf16oBa3YOrXINl9SHu3ZXQhQPY6cBgp/zqU+pLn3iHGYyY8Jm17Reutwq9Y7bKKIDfrxadau
	PMYdo6vMh9TxCX4h9JCcW68s72TRSKc4GTZ8iuoTLQCDjzmBQh339CBfL4zwGreHpf5SHCwo8fF
	hlQQVY7vSIbCY9JT5upXnnGVpHSEzJt0PJZA50F/xCBGRDgF0IyY84m2uw04Rm7OHnEUm0GgydX
	rOlvTqDwxfKw2PEbrK5bvMj7zyn6DXU88=
X-Received: by 2002:a05:6808:198f:b0:497:d371:21c8 with SMTP id 5614622812f47-4a2031a5000mr752583b6e.19.1783484062998;
        Tue, 07 Jul 2026 21:14:22 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1acc83099sm931498b6e.2.2026.07.07.21.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 21:14:22 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 04/11] object-file: drop check for inflight transactions
Date: Tue,  7 Jul 2026 23:14:05 -0500
Message-ID: <20260708041412.1157499-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.122.gf85a7e6620
In-Reply-To: <20260708041412.1157499-1-jltobler@gmail.com>
References: <20260624041920.2601961-1-jltobler@gmail.com>
 <20260708041412.1157499-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ODB transactions are started via `odb_transaction_begin()` and contain
validation to avoid starting multiple transactions at the same time. The
"files" backend also has the same logic, but is redundant due to the
generic layer already handling it. Drop this validation from the "files"
backend accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c | 4 ----
 object-file.h | 3 +--
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/object-file.c b/object-file.c
index 33bd6c6810..e51389833a 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1678,10 +1678,6 @@ static void odb_transaction_files_commit(struct odb_transaction *base)
 struct odb_transaction *odb_transaction_files_begin(struct odb_source *source)
 {
 	struct odb_transaction_files *transaction;
-	struct object_database *odb = source->odb;
-
-	if (odb->transaction)
-		return NULL;
 
 	transaction = xcalloc(1, sizeof(*transaction));
 	transaction->base.source = source;
diff --git a/object-file.h b/object-file.h
index 528c4e6e69..ea43d818f0 100644
--- a/object-file.h
+++ b/object-file.h
@@ -194,8 +194,7 @@ struct odb_transaction;
 /*
  * Tell the object database to optimize for adding
  * multiple objects. odb_transaction_files_commit must be called
- * to make new objects visible. If a transaction is already
- * pending, NULL is returned.
+ * to make new objects visible.
  */
 struct odb_transaction *odb_transaction_files_begin(struct odb_source *source);
 
-- 
2.55.0.122.gf85a7e6620

