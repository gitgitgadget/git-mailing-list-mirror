Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D45255F5E
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 01:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771552798; cv=none; b=ufXVjplpQW8FcKcvY62Qwv7XyewW0o/xy6bQ73CZkqW9Gik5odchA81BeXF/zKpMdvWldnx8N9vqDuUVQYRyc/1LabqzIZeMISn9wvTkL/lYh/v5oKOKkCBm+g6tCyNY+eNNWLMLh6YC018Lk2wXv6cyIr1FjZw5ejRU+DWRKGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771552798; c=relaxed/simple;
	bh=HcyjotHM01uDT5QWFcQejox5PJZAKmwDpPPq9k7rU2w=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=c7oACrvy3MtC2GmLY2tPYe2tKnlSObhNo/lVCyBk5Gd1V/AIo8SvdbBEa8xbWvY6jE3KZWboBUvUQVp1OAa9enBzL9g14Y83k5QlywsOUU0YG3MnfNwIHtcFrxjAPYFFmEzhxo8XFanSgpI1+mDzjS1/yCO8V3MbHj8VMEoRezI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMgIazCi; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMgIazCi"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2bd62e10a72so2889579eec.0
        for <git@vger.kernel.org>; Thu, 19 Feb 2026 17:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771552796; x=1772157596; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vM3vCqKYzvIlj5sr9Vc7buwqW45ez77hKog+NPxKRfw=;
        b=nMgIazCid+BlYoDjuzPQVOUN840v8uu3eP35IMdSqhwuQZMjUWVVGAfn1vLVVBiPQ+
         slOKxWy0B3R5UmQ2JOLG6/d1YiZtp1ggyRd07b2e9VGoeLpmQg9XSGwdBgFFO7SpYB28
         d5aek+hTEMc/GjYXI+7RAG6LM+UlaWMNecbrZ3vYDGuazuY2M9Z+5rx+RUvuWntQ8DM7
         utEc+yol7LKZhkJaL8IgNsKztSCGauYLUqzhl3XkidIjLMHQxWoAudipvsg1mccrReaS
         s2OsvjkjpW/al0hRdyxr0D9HP+JUxwB+VvlxofS2bg5P0SQSc5nFpUlvPglEt42HPoPQ
         4hkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771552796; x=1772157596;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vM3vCqKYzvIlj5sr9Vc7buwqW45ez77hKog+NPxKRfw=;
        b=tsy9ajMSYn7htsyZxHKMNOxktyW9qRuxt3E2GGPal3gntZtJGJZM8vZGuddWSta+Jv
         DB+Fcj7QGD1KMozsA9cblJUHecTAIvJ1FdnYNNCRCOTTaQuuRJgKUn4mePZ6j1j91HcX
         eaAo3kAB9onxNbJPr6KiEC3gm3b3fWyb629WdWdgqE6ZR8XPzLRgfhZMw6Ar2sXhiu2K
         qQkAVYiCruIKe2x9epAXbmD1lJztEwc3YspPuR2zf6nGCuCNDdrU6A9GWj/85r6w1kb/
         dag2nou5Okp62w83J2Ciauj4Bv+1qpPkg8SvAhPyiZQ3l75phq2yk2l+ihs/DFwGRgMJ
         pCnw==
X-Gm-Message-State: AOJu0YxHy40TDtNvo4QrxzleveniXcY1Fks7yTHM6QWr50/pXiqtWugl
	JUqPGiX3sTfXf/tNarjsBxLj4P/jso3TOJPzv51312jxwKQSWdBZPH4qFZTqFg==
X-Gm-Gg: AZuq6aJIcvzIfpjhfMZJ/PZjkaNivXWDINlab42Y86Tc6v9Z01sunxWO82EqeS2WYQE
	fKC2VypVMS9lhMtt2vuiAgASTfysM5w6cw8I0QBQC5Z26dO3bCrx9tagNu1g5LnMjTJtGMDXKJn
	mkWJCyKQehWn7F2w3XOMj4BoDz0DqGZ9vElO1WSV7FrpSJOm9OPsBWW+GXoj9xfKyANF/6szlMI
	OWidBqRSj7ZHI35j12G9bAHBR/cqtujf5VRsbVMsLG0LzzWZFzjbMY/bb8fu6H3gsD0ABKrJSIR
	iWLNk4+TtmpV52K9D1PivLtXyHj1QvV6uyQauxOBnMKAz4JLBmRYz/CLnF2Vsrl5vymmQyF6Oj8
	gxyXM3XuEisQ3oeasSXdGsCIejUtAZUeZJQYMX5OtlDTp+0VYhegavEcvMBBKW7v3FnIG2DVz4a
	8PfeEPHbOGiGHyNOYU3Cydg/837w==
X-Received: by 2002:a05:7301:678a:b0:2b7:2bbd:95ae with SMTP id 5a478bee46e88-2bac97d5160mr8298538eec.37.1771552796358;
        Thu, 19 Feb 2026 17:59:56 -0800 (PST)
Received: from [127.0.0.1] ([172.215.211.50])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb658fb9sm22202278eec.20.2026.02.19.17.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 17:59:55 -0800 (PST)
Message-Id: <932d945c9bd15ae570198fb489173b4461034622.1771552788.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v2.git.1771552788.gitgitgadget@gmail.com>
References: <pull.2048.git.1771406115.gitgitgadget@gmail.com>
	<pull.2048.v2.git.1771552788.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Feb 2026 01:59:47 +0000
Subject: [PATCH v2 5/6] merge-ort: prevent the_repository from coming back
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Due to the use of DEFAULT_ABBREV, we cannot get rid of our usage of
USE_THE_REPOSITORY_VARIABLE.  However, we have removed all other uses of
the_repository in merge-ort a few times.  But they keep coming back.

Define the_repository to make it a compilation error so that they don't
come back any more.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 60b4675f39..00923ce3cd 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -53,6 +53,14 @@
 #include "unpack-trees.h"
 #include "xdiff-interface.h"
 
+/*
+ * We technically need USE_THE_REPOSITORY_VARIABLE above for DEFAULT_ABBREV,
+ * but do not want more uses of the_repository.  Prevent them.
+ *
+ * opt->repo is available; use it instead.
+ */
+#define the_repository DO_NOT_USE_THE_REPOSITORY
+
 /*
  * We have many arrays of size 3.  Whenever we have such an array, the
  * indices refer to one of the sides of the three-way merge.  This is so
-- 
gitgitgadget

