Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EB222A814
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744127330; cv=none; b=BoiyfAIzF5iyMEPP5OM2PrWTgmjq/v+xafPc+jkxYVjWw8kw8zOUN5KFAebCnm0gDQuJGvVUHXF4BzbyT/79oX1GD0axz8IlybECu2QW2w5gFauaHIdP9Cw9L+2YASNfWckurthipNtKYZ1m6ucQW+GWKtwxvnjnyfZEOgAzzOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744127330; c=relaxed/simple;
	bh=z8LfGgLUPat5lQgkwY5bahZbvOjNOBCfro/4+Vavk78=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XZhSp8by0NYMxvu3MvshMAdo2wssnS50lQEd0Xw9I/nDlZAL7s5Ol6ETGkMUGSH68lBbn87wPNRhykNW7brxgk79xyw2fSBBct3k5tyh4ex5utrUA+8EhDgXfK+MEwqxlWAgBJxaxH3o9YeV677tAUaYolwof7TEPFcfgRoSDbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deD32hoT; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deD32hoT"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso39047825e9.1
        for <git@vger.kernel.org>; Tue, 08 Apr 2025 08:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744127325; x=1744732125; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQyn0+ygKamw+2iRagveNFiC1G8x3BKb3kCx/Hvn/tU=;
        b=deD32hoTOjzRVCOyhzygRUfm8FnMpj4GujXTPxsv6ksqwvKA5wFBb4L6d2jQqGFwGL
         I2c7ziy0SclznuuEaFEHTROQg00Oz67yyuo3e9ZDizLgD6FgTnAT1BkLeWQbM6N5CK8X
         DNv28HitQKkn+v/0jP7IianW/mXKaadzEQg6hpqFWlFvtlnRUTzKIiXCeNMkP2m39zHO
         VindZtnJAi0ui5G1MCmDdPH1vyRqd7VMVbqqdGjsIIAluRqJ4ERINqS0mSRx1xHJ6C+A
         5ATrnw+pnkXLHTPsxQw1WfU2X93hIOQtsLnFWqQBWTDliPs8+x1pDH0dxWdaOkFlqpFo
         ZfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744127325; x=1744732125;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQyn0+ygKamw+2iRagveNFiC1G8x3BKb3kCx/Hvn/tU=;
        b=Z190VqXamtLeU++T8H99tlHKdJuNlFInaNWWUg19jC1a3EhnVghTPpBsL5aRGAG5SP
         02kP8/Dr2ZoXq8Xz0cdrXW4HpTAZUmUmyx96UdaWvCKviUJX9GpBXdCag47hK2CjKReb
         zA6UVYuIqA/xPc2pD3hgynHMRcdfqd4morZUhMlsYM3npc5Ca3tAfeuP958BzDQh32IT
         a+Jrn4hu3lVe+t9ik8zWvBL558LM1BEULXQGvO2Lk0qstuxfORgpSWXXp5klhvhtyqP6
         LykvFvPXvazHyLy567gWY+dD26oI++lRc4QzZrCOSdjq9MPiAoOr01blFRWB1LXKlwdn
         9DXw==
X-Gm-Message-State: AOJu0YwXjLUzMz1jeepKiwspiNEyXDrpdTHoTEk8KLfu8EfYgvrpiPao
	MWqFlo6xFFiaaYiBgFczbmCJrwMpyvSi8+9a90iZOV3y6KEszBzQ1rzJ3Q==
X-Gm-Gg: ASbGncuo+V3dIB6YPoFOvv+8Krxn5j/Re89KaYG0qAebsEDzNjXWYmSxVOZeWO4xyK3
	se7M7GMzOTh+AsScQCyX2HoR2j+DFR3XV4kiwePO+lpl8pgaLMgBye4n+o1WzoSUf/eoibyvhVC
	Pib4IsXJZxYNJ88XxpOWO2nNp94cXA1vc2zkiLiUav+CXELyXCX4v/KvHENlR1Gtg5ghwaAzHKO
	8r//6xMwNVtHUkCN+hvyT4dd128NMBsHTUGmZR7yFUyvth7CAKh3thmaZHUVIM/V05nHkZD15zu
	KlAiMBvoSio/m0hnH5bnx/cxGZuMtjAcd+p0N3l3IlpNDDY2BUPpHxzz
X-Google-Smtp-Source: AGHT+IG8gLUBbMV+eOPk4dTUb7HYbVf+nHTmR9nvJz9KRPkYzHe+4sBI+RKp5gOZUj1Bqt1olG84AA==
X-Received: by 2002:a05:6000:40da:b0:39c:3122:ad55 with SMTP id ffacd0b85a97d-39cb359703fmr14012969f8f.18.1744127325353;
        Tue, 08 Apr 2025 08:48:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301b6778sm14965215f8f.46.2025.04.08.08.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 08:48:45 -0700 (PDT)
Message-Id: <0e150ee90659c89399bec614902077729cb2c917.1744127322.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1898.v3.git.1744127322.gitgitgadget@gmail.com>
References: <pull.1898.v2.git.1743891374.gitgitgadget@gmail.com>
	<pull.1898.v3.git.1744127322.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Apr 2025 15:48:35 +0000
Subject: [PATCH v3 1/8] checkout: replace merge_trees() with
 merge_ort_nonrecursive()
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Replace the use of merge_trees() from merge-recursive.[ch] with the
merge-ort equivalent.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/checkout.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 01ea9ff8b28..67879e72362 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -17,7 +17,7 @@
 #include "merge-ll.h"
 #include "lockfile.h"
 #include "mem-pool.h"
-#include "merge-recursive.h"
+#include "merge-ort-wrappers.h"
 #include "object-name.h"
 #include "object-store-ll.h"
 #include "parse-options.h"
@@ -907,10 +907,10 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			o.branch1 = new_branch_info->name;
 			o.branch2 = "local";
 			o.conflict_style = opts->conflict_style;
-			ret = merge_trees(&o,
-					  new_tree,
-					  work,
-					  old_tree);
+			ret = merge_ort_nonrecursive(&o,
+						     new_tree,
+						     work,
+						     old_tree);
 			if (ret < 0)
 				exit(128);
 			ret = reset_tree(new_tree,
-- 
gitgitgadget

