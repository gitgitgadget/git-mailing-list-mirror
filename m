Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEEE3F1676
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 09:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590171; cv=none; b=fui0t7HXBaZU5w5PYh6+USi/jUeA5ILnH905jchbC08dest2v+z82Nk1IzZj9duNtfXhY6LUjzHRX/q3H2v8NAfyxMnnpu/JxV3SxcgJxd0IRLBE6tBw3ouH6xl85oA+aFWFPDSAcX74176JlgR/ePwSUJZxhpNb4po70gpiZN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590171; c=relaxed/simple;
	bh=NvBcLKW46sQygfbHhF9hpGOhLzRmY9qglO2y5pOJldk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jhoiNnt/0ky5eJlH7gECtSFhQKJoSoJT3Sm0AXpDzWf5rzS/1ldRWivQye39CpqaLHzbmRlMczymuoilnfP+zWmXE7KdisYWQqMwi7QX0TMR8aNAqiKZaiogIezioDFYpOWRiBoWyqB05eo4Xnl5vJgtbDMHztC75Fds1/ddrd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juwmOOjm; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juwmOOjm"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8ee88fce572so14406116d6.1
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 02:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783590169; x=1784194969; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Cq1HYGt0bUp1CHNLgn4gXZ+fGOCRjN7usVWEibfwjNc=;
        b=juwmOOjmhq1t6HlR0rVmdkbxmZkZV69Kjs2ww258rksj6KzOc8cNJVZ2QdadBO/pzB
         9aX/ZUArINfeOkY+2YRyqKCWHDMuesMs/RBIn2M7s5Zpiiw2TKNq4SdsUOYXqK6YcXwl
         bp36/mj2g7wIq/YHcqjsED5x8uOmYpbz2EbzAx4HvLVAtl2I5ueZjhVtvgjLuCnaRXmE
         Pzr+PXNI4X7eiNoJjrGk8sfvN+Zp3BRc6eBaOQmLYHVepISMUYF3bZ3mACXjhC6Hpt9Z
         eWmO9tdCDvxFvzNIP0cYiWyZEViRMhcZfkT4oOpy01tV6Ec3tKF87LYG7ZZfU3GXNj66
         FyKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783590169; x=1784194969;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cq1HYGt0bUp1CHNLgn4gXZ+fGOCRjN7usVWEibfwjNc=;
        b=Hnz7c96n7TkrDPzjC8qCYJy+WExQ9+LCiU0GT0eI6/oVTH/lc3AIFdUEBpJ/Za5pry
         C/LtDAQJKRyBPb1kpdnpQnVGeaTeJbTQQL5JAeKNXqkD9H5H33AxaSJucNUV1jtiBIvn
         dNEdMRtbVlJtPYgEyIFqDU3J0IDv43I6/37HFcXHDu/uKwJqZJNYT1X3XxD7Ct1Qvx6G
         a9JrC0//QPRyNlnfYz+b5R2nSW4SZrwM931dooJ5M9n5pVKIcqlVnGE8QNBbXS40sB1f
         Ueni3EeR+7OFTAFiS4ZpSZuWcWI7+YnGVBCKdCpSpc0iNJANST+CainspWoBAcMyrFa9
         VBtg==
X-Gm-Message-State: AOJu0Yxcfulvux0N/tUWjfyRgVewun+jL+c/13/1DJgw/nIC/jtkEwWj
	y86KS4gKdVMU0LBhBrx0b+I73ATLfLGVlyfCVcR7Yznd4q71WsKZNgK13WqGHneF
X-Gm-Gg: AfdE7cm2BiZoayQ+JE1pOS46d9ajbJFpslsLwqOa8jCPPluxv+tbJ6H0Bay+KSFeSdL
	GeJyw585Re9mFdk3+6aqMMTuj8iPpU19bhVq/yJ4n3K5Rj95/r5gIkdJtJY9Gqe0GN4DE/L1TwX
	Zm2pyBC9laXN2Z30Z34p2fsycp7BT1jlK+0ktMEg4xXoEh1hS99iCEX8pXv0cMyjUoHSXR1pijN
	ZkSYoz9F8X4nxx8RGAD9Qta2cCIIkXB0FroGIZvy3LIaoeZryYsWSPWA7E+z7a4in8QG79K5tDz
	QZ9lcrp1oZ6GMkojQPEKobXbM5hfqGuSxZyhr80EREqZI9VssKi4zzlyAvteLYcYDXPsaaVqLTv
	ZERio1T+1598kbwsQ20nEvaa0RW7CoaYbPlLNWKGtuw73xIkIE6EvjgNLj9iN+aU4QBUBoyo1N1
	7W7ayrqG80V9Lc
X-Received: by 2002:a05:6214:3981:b0:8ee:88fc:e0ba with SMTP id 6a1803df08f44-8fec03f2064mr72969416d6.6.1783590169447;
        Thu, 09 Jul 2026 02:42:49 -0700 (PDT)
Received: from [127.0.0.1] ([20.84.47.35])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50e0811sm13586646d6.3.2026.07.09.02.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:42:48 -0700 (PDT)
Message-Id: <a7245cdffad651a423a4014c176f68c47231c62b.1783590159.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
References: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Jul 2026 09:42:34 +0000
Subject: [PATCH 07/11] replay: die when --onto does not peel to a commit
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `peel_committish()` function calls `repo_peel_to_type()` to convert
the given object to a commit, but does not check the return value. When
the object exists but cannot be peeled to a commit (e.g., a tree or blob
OID is passed as --onto), the return value is NULL. Add an explicit NULL
check and die with a descriptive message in that case.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 replay.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/replay.c b/replay.c
index da531d5bc6..b38cd5efe4 100644
--- a/replay.c
+++ b/replay.c
@@ -36,12 +36,16 @@ static struct commit *peel_committish(struct repository *repo,
 {
 	struct object *obj;
 	struct object_id oid;
+	struct commit *commit;
 
 	if (repo_get_oid(repo, name, &oid))
 		die(_("'%s' is not a valid commit-ish for %s"), name, mode);
 	obj = parse_object_or_die(repo, &oid, name);
-	return (struct commit *)repo_peel_to_type(repo, name, 0, obj,
-						  OBJ_COMMIT);
+	commit = (struct commit *)repo_peel_to_type(repo, name, 0, obj,
+						    OBJ_COMMIT);
+	if (!commit)
+		die(_("'%s' does not point to a commit for %s"), name, mode);
+	return commit;
 }
 
 static char *get_author(const char *message)
-- 
gitgitgadget

