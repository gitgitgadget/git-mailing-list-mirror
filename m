Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FC01E1023
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743436286; cv=none; b=lNSnJyvzBNLNL1yoKUP89QGKt08gq1gM7+1PZpjCp0AKjdwbXXsPm3sTejgS2W87Ct+qw64xQ8JUP1/wMSsOpTuoydsAx7GGbaEdDXCk8qpGH2y6V/V2+xbK1G71xz9f1ryTUhLIkVtX/btWD+XXnPOfEt1HLdSk5sNNJ4iMs3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743436286; c=relaxed/simple;
	bh=z8LfGgLUPat5lQgkwY5bahZbvOjNOBCfro/4+Vavk78=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YLkL3pSToocYHY/vOueYd5gKxazsioBYX/yncMKiZo5I5durlIhNx5rTCYbVCgUVWGYHAN46cfJM56xv6DXvPg+/nykkyZ9Q+fEfjqv18D75pg01BzxIgEDjMaxojAz7MUqawIuKEm3UzS2cowlHQ9UcSV2mkywr9cOsU3H0/sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVdl0FXm; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVdl0FXm"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4394a823036so43804135e9.0
        for <git@vger.kernel.org>; Mon, 31 Mar 2025 08:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743436282; x=1744041082; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQyn0+ygKamw+2iRagveNFiC1G8x3BKb3kCx/Hvn/tU=;
        b=MVdl0FXm886sQZ3v9nhKsr+Yk8gzcbZwOW5Xiy7pNofyHUa1c4ZUseA4L9Ejy/ebdV
         B0siZaDig3e+6w4CxNx4qneNsqfh3h/jmqvcazMwimBRxCXidaEQAwPpxYgxlxTtkJMO
         Locx2ojfZicoo/Ze8zE+3iB2iiA+f7ld7oZ0gafx2yS4QNNJoJH74sNPc4iF7EryfQyy
         E3eARvj9KhiCOcu7ewwFKwRdYeq3WMVnK06f6N/EYS/faIHtwKYvGSVp5/fw/UewT7fu
         0L4ZrUBFIoA4GuL5VYwalhwskDOGX4LyuuDhyYa9tPR1W5Y3NlkTY7W5R+gUjeigW5/V
         MQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743436282; x=1744041082;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQyn0+ygKamw+2iRagveNFiC1G8x3BKb3kCx/Hvn/tU=;
        b=BvFcPFDEKTjvLGk9tW9EgXwaRKOP/G1p4hkA+HrJNTUTPo2yARQ4ylpRUYGeQaXVLS
         PV+i54we75bFmLSGfa01xoBqElSOrEnKjfJwuGsOaNe7sczCMdv/VSG/oH3LJq2jzfq4
         aKpmB2IEZ+/GKmnXsjZ15VnL1TS76CWLTB19kiqpbX1OFd97U9RzTxcxXC6vN4Gk92ZV
         FjJ94v5ERUFVVYk6SDLfpeluVs3pGn0fMh+R5dUAWy9RA829luxZI5tfbgKO+9h2RjhO
         jlh/Yil902IsRI0aKHeS9/gKXtSuG6dnFIINDxemSI+OnAejr0QH1wPb/TroSWKzYrwy
         DQeQ==
X-Gm-Message-State: AOJu0YwX1X+C5+RGbsOAD+Uu4+n+mX1PPZ3QSsjcqKNUqJjYrCtHhuGe
	9ZvaygKrXuVjE3shVpZDqsJh4dKLemz70ogjWB3SKDyXWDLyxA5GLJfxVA==
X-Gm-Gg: ASbGncvatU+dMbsS0MWofuy4CK8nP5rkpCYpdi1/rPOxOsu0AAq0aVYwKziMPSfv1lG
	XHT/NZ1bBXvowl7HartwYCc9el76JoZ1PL21FBwl3Oi1RdayPI8TEr8a6zH4LWU+xj2MmAOt6k6
	ZeejgvTevjq1gWQkF/MngX4hKtF9MnJ620cipSrVPDxu/IILWsILLbvJvbc9Ss9ZHglHywYlrMY
	RXH6L3fOP5YaHi6oNVkc7gAs6cJi1iehgZD0bRaeNvXDLfrMRYWZ/0CIdwVDd3nGlc3Bbe1FMys
	k6peIgP6FxMktcQN+lR0fzeIRSETpEpS7FYrY9x4xOpEIA==
X-Google-Smtp-Source: AGHT+IGkNpkNIF6xMIiwiCOzclO1LJpqx924R9sJrcKH/9wo4vjtTdLxKEzt/bpLljAKfzXJPONACQ==
X-Received: by 2002:a05:600c:244:b0:43d:fa59:af98 with SMTP id 5b1f17b1804b1-43dfa59afc2mr56994395e9.33.1743436282384;
        Mon, 31 Mar 2025 08:51:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d8fbc12bbsm125523775e9.13.2025.03.31.08.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 08:51:22 -0700 (PDT)
Message-Id: <0e150ee90659c89399bec614902077729cb2c917.1743436280.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1898.git.1743436279.gitgitgadget@gmail.com>
References: <pull.1898.git.1743436279.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 31 Mar 2025 15:51:12 +0000
Subject: [PATCH 1/8] checkout: replace merge_trees() with
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
Cc: Elijah Newren <newren@gmail.com>,
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

