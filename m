Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6800D30E0E5
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773410509; cv=none; b=RIIGold48JXJGcKC56EobwWCv/FX0KNPCqhij+g3uZD6JesHvRZHDfYqGG9xp6OEkkn1W7QaEhJk9P9VdgK9OR5DomWhFswGJPYamfqTtQ4e/cwze9fw7Bk/Kr/uytfprbalCfzoipVAuf/+Q64qJXb0M/3HDvpAjiMSD4534Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773410509; c=relaxed/simple;
	bh=1ye0M7jy2GqNtgx9jg08vk2zsOEBLJ6Dwt9XzS8+SJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d+7mwFl/tRwQTm4JjkNIpCnGblBnG6cszwmtLxujTLXknlmoWN7+rSTLCqXV+l5cy2SjRiE7OvLxGXy0MlXEdqTval6txE8TNaWFsLjBdxufrhQHZrepUVW7AydZiVBAQPn96eJM7aTNasMaVjWIO9xQG6EGZVO3Klzttiu5bIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ao17jFRN; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ao17jFRN"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35a211df8e3so767318a91.2
        for <git@vger.kernel.org>; Fri, 13 Mar 2026 07:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773410507; x=1774015307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ngz8VvOSsajozeAmVbPtHTBA6R7Ie45SRRI/oudwuAA=;
        b=ao17jFRNxr4gV3Ls+ovWuh34BCENchqw2RqzDZGtUxFu8134vikdNWkq3EIOOGNiIQ
         bDqEXob8V677YO5fnFnHiPgd8ZXZ7gZ+R8m+OtY1R81Sjr+PvBkt3WXGkl9BRf5CUqiu
         5wwWCrMe8plbAnrQg8qbT7eNfwtVACc+YmmhCee/tHIkVW/4oGidZNyM4SYLw08tBgF1
         /7iHZG6SJJ/de3fqeipFj2F93h4tPmIbsFU/7oKuLrY96SXAEtY1d3Txn4Af86lsGaK+
         dvVzFtIH1UC8wHPSX/G1HHkoWihicfP2iOB+8ONh7nBp+ysqTWJJ1xTmFEHABPByGOzr
         k+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773410507; x=1774015307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ngz8VvOSsajozeAmVbPtHTBA6R7Ie45SRRI/oudwuAA=;
        b=HaHeHUw7emJE3w2SJQk0NXo7j9pXvN1xpfdILdfaQOgYkQcfkUWlr5h+Be5f/Rxwx2
         BPYBeid1vl4X4fX/C+a1U3SLnHOS8yuXts9trXo2WDQScyDMF3BiWcl04AO8yiGCGZ5O
         k+1+VifjAAFPs/n3JkmCY+m4zcgwt28MyRr9ZFIy9QGnykeBohcyUzDfvTy8tAewLcpR
         w/aw0UorPrFsZor/ln5T5K1Bf0ukpDv0Fn/vQ8lizlCiGJirEdJgufIpcD2ENYV5fCGq
         kvDXd25LwB23P2Jhi0WJxSNGOHo1lsCooLTMlhXcHneze1doNO1ApMCYefyalDmQpvHr
         G3ew==
X-Gm-Message-State: AOJu0Ywkcejb6PkjmZPOUSOXBwgxTVKggwZIwErFaV3E68gtyAyZXR1a
	q48UlwvGBcZgG97uK5R+NsY8IDRop4q6I0G/BaPpsok+XrC+YS3JhzgjQho01rJK
X-Gm-Gg: ATEYQzzfAgPANHJMBNaRYbvgT4JOZTn68EMIhz3+yXRXsG+xnX4aFFA9N1wj61ui6Qd
	xUmXcEhykQogRAxrn7ftE9OdkLTnHXSWhefzTOZ11+NhIL2gA7YYIj3DxLIssPnuZnLenSSX4sP
	zkrJqkE0zcXkQnsY7obL9a3nicKKkmvxG1GXnGTZ06SeZH0sLTIHGvfnIHcXBxjIrvHBZhvoZ7u
	adGWzEUuv3ynPzdGD8RXy52+OlFgTB8zqxnIQvH29HtEhQTsvX3FMlVuGI5qHIHlwusBDI+jv+r
	v/y1nWTRG9OugD4WUj8Ot/2PeRFXrP5TQwajy94YL62LQo6zKEKndrZQqVPKcaE6gFG+MEmxmKE
	ea+t6fG8tBJuBdK9QhChSRvaR95kq/ojrdp04w+7Wtww+UXtwgP+fwu30sM+JGO7dxFPTmN3fxg
	Zj23/WsXj4VyVHOEX26CBes6jwKQ1T6w==
X-Received: by 2002:a17:90b:574f:b0:359:fe72:3559 with SMTP id 98e67ed59e1d1-35a21fdd3b7mr2936588a91.21.1773410507105;
        Fri, 13 Mar 2026 07:01:47 -0700 (PDT)
Received: from divineocn ([45.127.227.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359ffe77311sm9342229a91.11.2026.03.13.07.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 07:01:46 -0700 (PDT)
From: aum2357 <ahambrahmasmi2357@gmail.com>
To: git@vger.kernel.org
Cc: aum2357 <ahambrahmasmi2357@gmail.com>
Subject: [PATCH GSOC] Signed-off-by: aum2357 <ahambrahmasmi2357@gmail.com>
Date: Fri, 13 Mar 2026 19:32:25 +0530
Message-ID: <20260313140225.563948-1-ahambrahmasmi2357@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff: use conventional comparison order

Replace `0 <= addremove_explicit` with `addremove_explicit >= 0`
to follow the common coding style where variables appear on the
left side of comparisons.
---
 builtin/add.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/add.c b/builtin/add.c
index 0ee21692c2..ad0d6047af 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -432,7 +432,7 @@ int cmd_add(int argc,
 	argc--;
 	argv++;
 
-	if (0 <= addremove_explicit)
+	if ( addremove_explicit >= 0 )
 		addremove = addremove_explicit;
 	else if (take_worktree_changes && ADDREMOVE_DEFAULT)
 		addremove = 0; /* "-u" was given but not "-A" */
-- 
2.53.0

