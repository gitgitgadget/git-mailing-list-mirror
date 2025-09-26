Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6392BF3DB
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 22:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758926533; cv=none; b=LDWH7TJd9raEhns3BERB33Kil7JLp3n/0yo2Gn6HzCRZpv3wE6NdDH3U257S/q7f/iFt0FPNuQWwCA5XP7BZooCoSZz/zfKpmwJX6qXBKxahOvkv3VcISO7JTMEDvfKsprkCwPpp+GAeoMEE8Ne5chEqtzGhqag5KpzrNjSCi9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758926533; c=relaxed/simple;
	bh=dSoSDFjP1yoh4ARvQxehL/Cx+cSqROXi9gm4WGq5CFo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=j09QZeQf/oBi3riglI9+O3UxUges1UDDZT4uPCiKC+WbWvLShoT6QRxSuQhgJlvKNnmO5Z0eU9bgUnxD1AxMjbZBrjHERCgjx94D36BwZeT9ss8UP0iP9AAHuY7DnA3KD0bdENzq8Mlp9Y6tfhwlpye4YS3KLtEMuVbnhOajaeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nA/6xh2J; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nA/6xh2J"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2698384978dso20436305ad.0
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 15:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758926531; x=1759531331; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m86ynlxOihQxCNGqHvdWkwGvoEOQ/pZFact7JnS0EAg=;
        b=nA/6xh2JS86Qrej20fXqPpomJ5p0Y9ipmxcqlHMeZxasMQuB07DebwNy2fTKkUyOhT
         zY2lhm2DbycIrH6Afk64B4wak3OQ+5pat7Kh2aD2+jEARmu6Jc92zU2QRwfpAdl7tkx3
         MwExGkbn0PqCQVnQi8YdYJH9kJl1gzYgptr8bKJQCAD0w5xqker5wRUTLc/6GdpUDbyK
         K8S8iqJBso5NuejheM9XZUgJ41UzsuI4VSXgZFhhN4TWIsZMSvUvu3D1S5fs+NRdnhUT
         rSmzWkFGpfmipE51BdC0JOCZulGcfql0Nzhb0ALBe/CbAbh4NdZ5Phw6ooE12sbC7LRV
         wNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758926531; x=1759531331;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m86ynlxOihQxCNGqHvdWkwGvoEOQ/pZFact7JnS0EAg=;
        b=m7hCN9K2EpTWeWwL/+0iMG2BgX0HcfMRqYXKJVrrvDzz3EjGYFyRKo3LhUryw/ifjf
         RWkDUXq+BAFe1yX2Y+SUC8BSquA/XW/oD1b96wzSRu94uVirzo40yynOGuudbgq3ow9t
         Opxtx1DdD6EffeiYxtXClS9FwJB7BQUfhFcaSbVCvNUuHeUneP0dOWfuRt5/EvFksJ2M
         5eqxQzv+R4IlteANI692RdexZJX91NsKF9AXRun1FGyivXcfha/9+7RIyITmNYDR7Tam
         tysTPS3qoAaT/71r4TJbZszGBBNqM/g7LTx/mEpO2XIfbvQHDv1D1AtHogQanfRNuPuh
         rbuw==
X-Gm-Message-State: AOJu0YwSosgwVsTwKqJPcy3BXTTq5adJdyt15S2oIBbnovtS5geINOOb
	XdMZPYbYTRQpGV7GsnkZA4NXydY84lGP3ymEFWq+gsbpTUbt5TSTe+GtGRACOpka
X-Gm-Gg: ASbGncs76Tmd8zd4ruBYF09kYl/LLanlIgOocgxJFr3wQVqt6Rf2BTsmL5qOFSh8lAw
	iDHHxdnZqoGKJ9fIRlpa+7sS13tYKeKhSVToFNUbs6pkOhcRLwXbNY8sG4eEgXT+FhpBbqZDaPv
	MJks8rHNHyvZzZ6h/zE87qmLr9bdYWnNm9M0SsYOS9xoU2drkUQuZmkJ4UbdrU32QpC+mX/+cwu
	d+woGjtqpNDrwZXmg2kaXUho/eD7pzXH8zn8tK04gWtFjzYQ//fExBaD97JqXDMvtdWMu5rbf6g
	fMjbJ53GTEHPUnRoBlYTlBaxLk6BYD0yqfb7++2iGKuPL7qsjI9+6YBTXUJqgNZf3qO98SRtPhb
	p82YfqYk2MLAue4SMIWATZ7/r
X-Google-Smtp-Source: AGHT+IE4zdGzVUjZ5CQ1zCT163d8oF8uBDZIs2J7NjxVKv3X20CpkSUrHRjaAJ8N9ZEzSFYuuBXbnA==
X-Received: by 2002:a17:902:d2d0:b0:25c:b6fb:778 with SMTP id d9443c01a7336-27ed49fbbd6mr93363685ad.14.1758926531084;
        Fri, 26 Sep 2025 15:42:11 -0700 (PDT)
Received: from [127.0.0.1] ([104.209.5.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d3acfsm64960625ad.20.2025.09.26.15.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 15:42:10 -0700 (PDT)
Message-Id: <738daab090dec58859f4c829eb42f757f035ac70.1758926520.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v6.git.git.1758926520.gitgitgadget@gmail.com>
References: <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
	<pull.2048.v6.git.git.1758926520.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Sep 2025 22:41:55 +0000
Subject: [PATCH v6 08/12] xdiff: delete fields ha, line, size in xdlclass_t in
 favor of an xrecord_t
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Jeff King <peff@peff.net>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

The fields from xdlclass_t are aliases of xrecord_t:
xdlclass_t.line -> xrecord_t.ptr
xdlclass_t.size -> xrecord_t.size
xdlclass_t.ha   -> xrecord_t.ha

xdlclass_t carries a copy of the data in xrecord_t, but instead of
embedding xrecord_t it duplicates the individual fields. A future
commit will change the types used in xrecord_t so embed it in
xdlclass_t first, so we don't have to remember to change the types
here as well.

Best-viewed-with: --color-words
Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 22c44f0683..e6e2c0e1c0 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -32,9 +32,7 @@
 
 typedef struct s_xdlclass {
 	struct s_xdlclass *next;
-	unsigned long ha;
-	char const *line;
-	long size;
+	xrecord_t rec;
 	long idx;
 	long len1, len2;
 } xdlclass_t;
@@ -93,14 +91,12 @@ static void xdl_free_classifier(xdlclassifier_t *cf) {
 
 static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t *rec) {
 	long hi;
-	char const *line;
 	xdlclass_t *rcrec;
 
-	line = rec->ptr;
 	hi = (long) XDL_HASHLONG(rec->ha, cf->hbits);
 	for (rcrec = cf->rchash[hi]; rcrec; rcrec = rcrec->next)
-		if (rcrec->ha == rec->ha &&
-				xdl_recmatch(rcrec->line, rcrec->size,
+		if (rcrec->rec.ha == rec->ha &&
+				xdl_recmatch(rcrec->rec.ptr, rcrec->rec.size,
 					rec->ptr, rec->size, cf->flags))
 			break;
 
@@ -113,9 +109,7 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 		if (XDL_ALLOC_GROW(cf->rcrecs, cf->count, cf->alloc))
 				return -1;
 		cf->rcrecs[rcrec->idx] = rcrec;
-		rcrec->line = line;
-		rcrec->size = rec->size;
-		rcrec->ha = rec->ha;
+		rcrec->rec = *rec;
 		rcrec->len1 = rcrec->len2 = 0;
 		rcrec->next = cf->rchash[hi];
 		cf->rchash[hi] = rcrec;
-- 
gitgitgadget

