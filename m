Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420213AB271
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 11:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774007178; cv=none; b=A+RT7Sw7F95fMHSJLju8eUn6w4mxq017AY/ktW45e8XgQA0oiTJVzwxfPhXNBK3gLc20CQpXSHP68S1SIn9Rpg8AfsWI2NvW9uiHmy6gBKn3bVYFBMp9c4CdZEnZb8ODNosuIUxI4FW/DUCAOf0ZX04BPD3hGbn5rzY4SjTpuwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774007178; c=relaxed/simple;
	bh=/d6aOWBnIEO4yWBYZVWPVijNtgPS8ScxoQT5cjvMoD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NMOVY+6qCa1s5CMxUurJSXvNM4SqJb9CdhGTmGYY6FPCg8DS8en0OBjG/Q5UNQn3X1ZLn7KLgy/gpuxRujxRJA3gZFvMcDF97MtnMO6MU+mR/XvFkHW2YyfDw50Hw15DrOPxMIqQ14UY9fZQK4tZX4F7KIlM+991uwcfVjW9na8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvHLNPTz; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvHLNPTz"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2aecefc7503so12906455ad.1
        for <git@vger.kernel.org>; Fri, 20 Mar 2026 04:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774007176; x=1774611976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mYB0Nfvwq7CleEMCtqQgC30UwmlpKcYuErRU+J2U/YQ=;
        b=kvHLNPTzIGB5gv31ln/LGYhxrWIKZy43xYCg5QW0cjMBe3DeU930nok7bq0NdDVVTc
         nrzFtTESCQA8uvuZvbnqc1PJnD8a8KFOcy99rU4XsvE6OxX8nTnIBUt3+RpsFH+lBdwi
         QEA3tEui4L0M2N7BOxf36RimcAYFpKcSH5zlSEZ5KEGni/fyekRi0JRdEXNXQZyIU6SV
         d7Ck9M0yfgiVQMnR9YBNZNJUL76q71KEIQpKaT5a4CNd43H4WcrvD/xsA7Zqq2lW82vu
         ISh8VbdjxP/Qm6RuVQrPr5OCsjBOx/TAGmnR7t5e+Y+wtSDyY4auIJYb5gmb9x+n5Vbk
         ZIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774007176; x=1774611976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYB0Nfvwq7CleEMCtqQgC30UwmlpKcYuErRU+J2U/YQ=;
        b=Ff9JBoV47TKoYCCU/bWZZ9Gs6kAH7Qqn/wevdR6yKS0EkfrsUTavHcjAODvmR/Y+l5
         rohI7XDtFX86pFgzZrSe0fbC4pvrFzrFRVZ2xq5lkpC0dBTWvcQUEl+wVu4lVhXrfrrI
         MtMpcI8a8Q2lwU4RtFklW5OdeZi9huqXeXfwhGFjtduemYt4dG9CizGw+Pzcd6trJ+4m
         HFzHzq8CcKbrHKfbUUQzeWiAbiD1BzX8rlsKFZxqwQIqGc69zXgjFrszrbm1FlYo4Q3E
         uPup/Cpx0khHJ2hdYybb/DWw5IjL9DJF4oBUdlU7K6VG2y1i//w+nH5xg8GFR3Khdr7B
         1gWw==
X-Gm-Message-State: AOJu0Yz+tWeTNCrSCe54D5FvhepoNf8eI/A8wmneHCeX6nmAJX4Gl8We
	cp1zgTkWBhzL9UP9Hm/5OEHbWFLx6LXzHk4cJYI8y7pDMyrCcZyKoujo0C7jkfTT9c4=
X-Gm-Gg: ATEYQzyuri+TrHFXQDbzm68DrXCy6niVcVL77fH0APw6N/3Gq1hwrMNfUZ9ST7RLd3Q
	zgi76xMF+bP4lqunOZ7wthRh/tXnz34OzBy1ZFt7zf+gzF/mpDDSC9YzWWK4DBug3biWpRQnP9u
	kb5B9s47SlApNROxePldDh2P7cQuMsF6l/AymPgd89lqKpwAuYRMc63QB2wv60xc9BJvI22QBDg
	aHnzwQcvIBJFrxNBVEqtHMyB46CXAEnAT52CI8I0d0+5rUKlIjW96NWw62w/QWXIj5BTgS/MQ0t
	616SBpu/2cNoGgOKl3wTO47qTEQQJdOMiI3XNTL/s7OfDun0eNCCXsC89ZrQRDe6611HPT8GEW9
	GKjZxyR2gZyeZ48Xp5chAiD4BaRrNtLrsxfikxZ940Cd41gHgLtBiLpkuGxQFH/CUfCF7+6fVL+
	JnR81gT+IL2DJPlrA6h28ph4vU65a+NhHbsts8noJcROBVSN5PxZqTw0ZlpL5JfxjQR97H6yy7n
	0XC/EyyB7UrCRUVXc65mIAes2XBtzzYRI+8yLL1P4h2CvXfY9HiulbYr5ofy7Hw8Q==
X-Received: by 2002:a17:902:f549:b0:2ab:230d:2d96 with SMTP id d9443c01a7336-2b0826c6909mr29573155ad.11.1774007176371;
        Fri, 20 Mar 2026 04:46:16 -0700 (PDT)
Received: from ThinkPad-E14-Gen-6 ([220.158.168.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08369617dsm28214645ad.71.2026.03.20.04.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 04:46:16 -0700 (PDT)
From: Yuvraj Singh Chauhan <ysinghcin@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	stolee@gmail.com,
	Yuvraj Singh Chauhan <ysinghcin@gmail.com>
Subject: [PATCH] path-walk: fix NULL pointer dereference in error message
Date: Fri, 20 Mar 2026 17:15:56 +0530
Message-ID: <20260320114556.3151040-1-ysinghcin@gmail.com>
X-Mailer: git-send-email 2.53.0.582.gca1db8a0f7
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When lookup_tree() or lookup_blob() cannot find a tree entry's object,
'o' is set to NULL via:

    o = child ? &child->object : NULL;

The subsequent null-check catches this correctly, but then dereferences
'o' to format the error message:

    error(_("failed to find object %s"), oid_to_hex(&o->oid));

This causes a segfault instead of the intended diagnostic output.
Fix this by using &entry.oid instead. 'entry' is the struct name_entry
populated by tree_entry() on each loop iteration and holds the OID of
the failing lookup
---
 path-walk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/path-walk.c b/path-walk.c
index 364e4cfa19..839582380c 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -171,7 +171,7 @@ static int add_tree_entries(struct path_walk_context *ctx,
 
 		if (!o) {
 			error(_("failed to find object %s"),
-			      oid_to_hex(&o->oid));
+			      oid_to_hex(&entry.oid));
 			return -1;
 		}
 
-- 
2.53.0.582.gca1db8a0f7

