Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A891F1EB44
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 12:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740660377; cv=none; b=otFQinH81+cNuLajmNK36b4S5lpAu4Q+3YWzRatF2Gv+63O8b17EdsHDA2L8TKx0D6WFZ5P1Wj6jbZUHQKfobZ6Ncoskqj6+t+7cokLL+svVwFtoAQj/Kxlp0Y/ERuIji7emSLvAdkbDVuSkrYhy2iJKzCmfxkfK8Xia0mLtNzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740660377; c=relaxed/simple;
	bh=kKA/eb2GXS42ECBizSq9FQ3KOY4/XxOuZMMipVpdLbE=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=QW6zLydneoNvSNN0McsOJwDWrxrrAw9RU4EYtiLmdpwT+trqG4AkOdZQ4qoHbhGKDAERqBa5uKnZF9t4cwseIMo3FzDsG26of1kw7rMCnLqtqyY3kKaZA7VeHL6XH3m9op8VVR1pz2wP7QTGCPuMBajMA0l+2ML9wVMHqcOpdQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FsdkxHFn; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FsdkxHFn"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43948021a45so8346745e9.1
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 04:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740660374; x=1741265174; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KfKci5abfi+snah7aym/Kt1+EAG2RtDYlkJZGVeA2Jg=;
        b=FsdkxHFnNP95K/94er+mh3veBsw29H6CANk/eX4IBv2PYgQMgQmJpYwF+I8EFS0TY2
         5LAdNURNjTy9R6qHcfI/PwBXNxSJ9e4+lsyuF4OHRgz7/jRnx1MOG9R6psZ6rGCxhlHC
         iRSXcV/dZI9FEyLLwAJ4ezVbS8iSU4SJX8ndjI0z1nxUnECsxjvCzx7r7LXe4UiER4rk
         I76K0+J6l7A7LAZdaM3H7Ov6n0DoA++SYM4+dlpecZ5ODvcit+K2ojPc/EmhCUshmzzF
         BjowCqtik5Ri9Htov03D3DYasnzuNaylg/4NZ/kmHG0hamHHi0xaY9L1JTk3eiB3AmDu
         eGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740660374; x=1741265174;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KfKci5abfi+snah7aym/Kt1+EAG2RtDYlkJZGVeA2Jg=;
        b=QJlfNzbvoqaMFpS457rXAiyhsVT0K517Th9kM8KsGABRQ8XxpsUdUCgYxe+tjf5Vze
         ynvf/sbUkkDLbEAPz37a2BoJA4dZW5F3cGWK1YVIDEfg7pIEOxQKLi60qPbZA85nF7ew
         Yrax2PTDIJHhixkIcLn3UbGt7KbUXqtrpOzYuIMcZMxn9x9VEXG5RKee3hvICQdCKDc0
         /XmPGM58jpLHdc8RID/UOFYxBUQ+21AHyMGpyIDy+ohgMp+QLjyFebhAizORtEmu6TZ1
         KULJ80IwKJF8YsX8pZYeNnIr4t1R1A4j9TyWEVTuaHpAYJS/51tmKwkzscR58DxVbguT
         mp2g==
X-Gm-Message-State: AOJu0YzOLATWs1f+YuOicgbFSm8xkO1PV1V0Z4Hx4Om6cBvXbVRIGVSv
	ACke5NNQcEsJl2yfKOjL0GK12fC5NbXGp9okXKCDZsEA4ESvIdtwft9ToA==
X-Gm-Gg: ASbGncvcV7DBVQ+sDUF8V5XD8Wdz6DA10Zi6SawV7frw5vQK47s0evNUFl15hfofYPx
	gLL3+71gkW/Uu6KskCbwB52nNI3+Iy4XtHww+P92TgYgOoelqKJGudyBAdz0n5dRNXEv5kHAvNE
	Of/6LaEua+IB3sKA7XkA7DFlbJ/Olmvghs13HCkhFWv6S5uiY9jdnsSmJT7KMJZrPRZd/0UyW61
	cnF0IUcMwHkWTd/UB+NZbRGHHf7xxJ1lrHYZm4bv2EPyVbu+6BITLGlBG+molI6dO89tFcQgZDE
	GM7/KV4eSQfNTCa1SlRgPL6OtaA=
X-Google-Smtp-Source: AGHT+IG4e6z4z4wzuRjVxDoVGh7cz59BWDehy7lZp32nwzN03AkB6A2WGplw8re9/5OQqkex/87zZQ==
X-Received: by 2002:a05:600c:4f48:b0:439:9828:c434 with SMTP id 5b1f17b1804b1-43ab901d7f4mr56014245e9.20.1740660373245;
        Thu, 27 Feb 2025 04:46:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b73717230sm21549145e9.19.2025.02.27.04.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:46:12 -0800 (PST)
Message-Id: <pull.1866.git.1740660371583.gitgitgadget@gmail.com>
From: "SURA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Feb 2025 12:46:11 +0000
Subject: [PATCH] upload-pack: no longer use hidden-refs as exclude_patterns
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
Cc: SURA <sura907@hotmail.com>,
    SURA <sura907@hotmail.com>

From: SURA <sura907@hotmail.com>

Signed-off-by: SURA <sura907@hotmail.com>
---
    upload-pack: No longer use hidden-refs as exclude_patterns

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1866%2FSURA907%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1866/SURA907/master-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1866

 upload-pack.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 728b2477fcc..9ae42a463a3 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -609,21 +609,12 @@ static int allow_hidden_refs(enum allow_uor allow_uor)
 static void for_each_namespaced_ref_1(each_ref_fn fn,
 				      struct upload_pack_data *data)
 {
-	const char **excludes = NULL;
 	/*
-	 * If `data->allow_uor` allows fetching hidden refs, we need to
-	 * mark all references (including hidden ones), to check in
-	 * `is_our_ref()` below.
-	 *
-	 * Otherwise, we only care about whether each reference's object
-	 * has the OUR_REF bit set or not, so do not need to visit
-	 * hidden references.
+	 * config transfer.hideRefs of upload-pack is diffient from arg exclude of for-each-ref,
+	 * We should not set exclude_patterns here
 	 */
-	if (allow_hidden_refs(data->allow_uor))
-		excludes = hidden_refs_to_excludes(&data->hidden_refs);
-
 	refs_for_each_namespaced_ref(get_main_ref_store(the_repository),
-				     excludes, fn, data);
+				     NULL, fn, data);
 }
 
 

base-commit: 08bdfd453584e489d5a551aecbdcb77584e1b958
-- 
gitgitgadget
