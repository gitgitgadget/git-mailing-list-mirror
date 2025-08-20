Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D9427A91D
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 18:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755715204; cv=none; b=jfCwLDSEdLzap8WZR7LV028QU4zEMm/GwqazKcwAJZnqPaEfGLMKh8+U+mCvUWxh/Y8czjgyYrJk3SWRFtS2VzFY872hfMZ8g0brgKx7ogXcn4B83xamgV+MbvF3AD42bhtI3mQa0/PykOu5U5wKETYtEOhsEW6WtpwaFdz7kNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755715204; c=relaxed/simple;
	bh=6XNFoJBhG1TdKWdt8nsZDm5DzFahc3wzMV4/CTt0Nu0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TESUSAe2aFjzjY2UUWidrMmH8aF7eyqaFXs/JddrEQ+i87gFIII0ocRRTnnwxF5mGw2x6c3MGKA9dxIIA16GBrSgeXTg71E1YwjJfP8kxwUIauYP8ltoERWZLrvtsWQaZLtBwNzkyCYPk3Ag9DzCsNlUyaHFpcLWl4wXz+0i22k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxssOp7q; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxssOp7q"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b9d41c1149so137927f8f.0
        for <git@vger.kernel.org>; Wed, 20 Aug 2025 11:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755715199; x=1756319999; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+YPoNkFFmX102pti6i/rDHcIqFWDfGDdlWmx+CQ968=;
        b=PxssOp7qUEM3BbdoN2NYgmdLLiKKxPjzByOV7H3L4baWD1GejJucGUCXP8DYU0u3fN
         1s+riLQ4C4rTWrhfi9CTwqI61b7J5zyK0nzHFvqijV9bTdQMyBDvyRipCOb4Fhoz8cq3
         Q6sbjU1ifbHq00ZUxTexyyOoNjRBVFvaxrrS7Os2PI5KQPvrWOzhRFNp25i8yXJgLy0n
         kQBYSScNL15zr6ISWOVvFPN2MV9kdCCFx+1Bm14fI9Mwg/ahVJJBO4fWmdR8H1eR1Ufn
         JwRianv/anx3ckj6fcopsZWLEC4k22kyrOLWaOVlHgWiwByS64Lv0J2iwZuSsV53ol48
         Fo4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755715199; x=1756319999;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+YPoNkFFmX102pti6i/rDHcIqFWDfGDdlWmx+CQ968=;
        b=nURgOYefVDjMB6FuI90m9KnpnVpThVA1Mzlsto+QqGzROcF1prX8iHwfvgpa7rgGtz
         X3JXwv/ef2tboJRlU5h3T+5v06eviWXrL+E67Mlb5ubylqDC1qhXMU27Ih8k5YF8k5hn
         YNTBXHAJUBLsjC3CxLivFsAXaCwsAFc96ezkHkLz51R3jrkI2SuTzksQJrw5W2NMAN1b
         Yur7xtC6nGf7GHkEO7aD758aNCAwi/RDXOGxyqoMDnoOi9F/KgHtgPsWCqQQTGoJxNN1
         NSKWizkm/NvoTrKyo5WzXw8ZYx+Q/JMSkoDDv1/0QBnlld3hS4167Lpwiz4u8B+YKvbJ
         bZyw==
X-Gm-Message-State: AOJu0YxS1KmK4WQLtJLG1erf6HIxCvTWjpB6vzZgfsrRevmn7YJAVRAN
	LQDjAn611/vzKY+vPTmMyDkGV19cVw6H9Io0fNPvAmh2WEbNP8IGRwehCiz4SA==
X-Gm-Gg: ASbGncshRm22Y0jXdg9QM4Ac7nIcMjHODXBuQY3Qx4Ixl534LLnA3/bMkSNsLzhbGu6
	j7TFJsqExyTy50ld6gKsRtrYLYrlOEmWiFaDaeR8/GDEWEA0RDr/nVWwgs4goXf8mT85LVFREKI
	GMQUHTEh+AUY8AsBzA24ef5CGqSCNMoW8x5CGcDaKpbbmINytaP/+MoXzPcDjsj/6axVjnHTlIX
	/LEUSlwbTQ3Iic7NKzhWn2k1zuzUYw+RvhoTZyihgElgi2JE8ILFw7Uy5UDGzXUWF/61vOhDuNq
	mnz/mqnhfihXGNOQsUAzcK3I+tWR12LIQGz9OPXWQBUyP2Ki5TV+FLjWztC02h0Ap7V9UhM7Q+r
	jrWdD0U9lvR1m7ke2SBDx0z/lXa4=
X-Google-Smtp-Source: AGHT+IHk79WbKIa/pMwFLGukW9Q3exaT+z5TmpUGg/F3UfMQ4tSlDoN3QHgaR2T8J/EtKGDrqRP8tA==
X-Received: by 2002:a5d:5d0c:0:b0:3b9:a346:6e78 with SMTP id ffacd0b85a97d-3c32e6fb420mr3149493f8f.53.1755715199383;
        Wed, 20 Aug 2025 11:39:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0748797acsm8318274f8f.10.2025.08.20.11.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 11:39:59 -0700 (PDT)
Message-Id: <0dc4a6323e66598070b403d286ee1918e6a9b791.1755715196.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1956.git.1755715196.gitgitgadget@gmail.com>
References: <pull.1956.git.1755715196.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 20 Aug 2025 18:39:55 +0000
Subject: [PATCH 2/3] path-walk: fix setup of pending objects
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
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    jonathantanmy@google.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The previous change established a buggy instance of 'git repack -adf
--path-walk' when there exist paths that are tracked in the index and
that is the only instance of those paths in the history of the
repository. This change fixes that bug.

The core problem here is that the "maybe_interesting" member of 'struct
type_and_oid_list' is not initialized to '1'. This member was added in
6333e7ae0b (path-walk: mark trees and blobs as UNINTERESTING,
2024-12-20) in a way to help when creating packfiles for a small commit
range using the sparse path algorithm (enabled by pack.useSparse=true).

The idea here is that the list is marked as "maybe_interesting" if an
object is added that does not have the UNINITERSTING flag on it. Later,
this is checked again in case all objects in the list were marked
UNINTERESTING after that point in time. In this case, the algorithm
skips the list as there is no reason to visit it.

This leads to the problem where the "maybe_interesting" member was not
appropriately initialized when the list is created from pending objects.
This is the fix for now.

To help avoid this from happening in the future, a follow-up change will
make initializing lists use a shared method instead of allowing for an
update to this initialization process to miss some existing copies.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 path-walk.c       | 2 ++
 t/t7700-repack.sh | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/path-walk.c b/path-walk.c
index 2d4ddbadd50f..1215ed398f4f 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -385,6 +385,7 @@ static int setup_pending_objects(struct path_walk_info *info,
 					list->type = OBJ_TREE;
 					strmap_put(&ctx->paths_to_lists, path, list);
 				}
+				list->maybe_interesting = 1;
 				oid_array_append(&list->oids, &obj->oid);
 				free(path);
 			} else {
@@ -404,6 +405,7 @@ static int setup_pending_objects(struct path_walk_info *info,
 					list->type = OBJ_BLOB;
 					strmap_put(&ctx->paths_to_lists, path, list);
 				}
+				list->maybe_interesting = 1;
 				oid_array_append(&list->oids, &obj->oid);
 			} else {
 				/* assume a root tree, such as a lightweight tag. */
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 1998d9bf291c..030e9e5b2dc7 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -838,7 +838,7 @@ test_expect_success '-n overrides repack.updateServerInfo=true' '
 	test_server_info_missing
 '
 
-test_expect_failure 'pending objects are repacked appropriately' '
+test_expect_success 'pending objects are repacked appropriately' '
 	git init pending &&
 
 	(
-- 
gitgitgadget

