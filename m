Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865D8193081
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 17:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727718037; cv=none; b=MpZ+Z3XWPPvASZ9dJVqmktD67SpU2+Ox/14HjABDVRfsJAq2eN7mcS6utP78gvNEruT3HiKhDI9sOSHQbw3cFubdm5eajmf3LPG6qG2guvOuwT4uNtrM2ucrYFDuhEGJ3DnGtVVxb8HdA0F4Nd7z7hj+o8u4k05BW2TAmhQVuDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727718037; c=relaxed/simple;
	bh=RwSw2n0VGxAinrFutu8sBIvZqSbF0hYODfcduSUKH/E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PBwgsUDZc6YhJu9WuktnPGU7RbgsVG0zSgzcerxKVlfnKdEjxAozDnl8MWxoKKGa09ods/dl0GF4BNEA/DXPIyyGZQE6j6i6hLAbDR92N2nSZufGLxZ+7sQnJFq0ft7pPZTTzcY9KW4HNO7rnmMnaFBWzP9BQYfBPBkAYWhXh8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRt2+0aE; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRt2+0aE"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c87ab540b3so6994130a12.1
        for <git@vger.kernel.org>; Mon, 30 Sep 2024 10:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727718033; x=1728322833; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvXWV3eIL+YO9QwpdbtM7lr2gqNwX9dCeM2yR1rvk+Y=;
        b=eRt2+0aEO36x12gtxpXEi8FzkUey4LduP72C3k9Dh1XOg/t6rI/29Nvz7Ae6FPJcQI
         jUYGpeX2sbiFWU3MGFcK5fLSSd26q3ciEYp46XlrpSdIhvFM68EBdSTl8HzqxrUitWSd
         iRDlg5DEH6t69yPTMdN6NjXgS2a3EBfsATT2FVLfynAZajWENOWj393dkJ88TWC4faoM
         6uZ/8tlSkwaBsnFP2zDL9rcgsA2DL/WzMVoaQwroCq3ea72Dja2pLph7r00qX64yRMLF
         Xm8kB2jlovOzZMVuEppflHdM9AmwnraMw+yWRmEHQKP3qCdF2fLLoCOIYvFNTMfm8tFS
         DnFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727718033; x=1728322833;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvXWV3eIL+YO9QwpdbtM7lr2gqNwX9dCeM2yR1rvk+Y=;
        b=Mnam85m0tGyyZ+ZWJoy4b7mWl3J+sOAzkEoIyEjtYZ1TlIeb4Gxc2bDdVbiSkBxzbt
         Cmk0nnuWswrVso8EkhAzMw4zGDFENCtcEKE1iT1vVm0j5zZSGWh/18memMzdcI3JX6Wn
         G/A/d0dHx1QBVTkPxdFWqapqjuUkA3rRYlY6uYVzxavqzj8h7/60AwNIQc3yfOBpOX5m
         aLtDQar80p3SMjaKXnmXZQHb0PqoRejXNrDVZJRWFAndwxwMP2K1LdRuaayeBRo9YBiu
         cslZt+fYj+yDaQN3SJNozRYnK4/das5Ohd5VPP53/JJOIaI+BkUIMOQEzojL5RGyjkiV
         +vUg==
X-Gm-Message-State: AOJu0Yw/mACUJ9vVkcXKXGnf/yJ8VEsOXaW2aa1kX7TEkVF0y8JK9j/q
	l8GSs7hYhDaexH8C4KXUO1Sssz5CSVe8WtA5OlsYaXJrO0oX//gl4I+8hg==
X-Google-Smtp-Source: AGHT+IGeyWQxz4wOAIdF7Khxe6gcVopjsxzJ2GYjkU/3Of+cEehkz3wSSGF4NzzefpGVNMQIKDriHg==
X-Received: by 2002:a05:6402:1e88:b0:5c7:227f:3ebe with SMTP id 4fb4d7f45d1cf-5c8a2a0d2f9mr501993a12.5.1727718033272;
        Mon, 30 Sep 2024 10:40:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88240a8e9sm4829822a12.36.2024.09.30.10.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 10:40:32 -0700 (PDT)
Message-Id: <2a29d113815015b82d807d94f8d551c3f885cb9c.1727718031.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1788.v2.git.git.1727718030.gitgitgadget@gmail.com>
References: <pull.1788.git.git.1727185364.gitgitgadget@gmail.com>
	<pull.1788.v2.git.git.1727718030.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 30 Sep 2024 17:40:28 +0000
Subject: [PATCH v2 2/4] annotate: remove usage of the_repository global
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
Cc: shejialuo <shejialuo@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

Remove the the_repository with the repository argument that gets passed
down through the builtin function.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 builtin/annotate.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/annotate.c b/builtin/annotate.c
index a99179fe4dd..ce3dfaafb28 100644
--- a/builtin/annotate.c
+++ b/builtin/annotate.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2006 Ryan Anderson
  */
 
-#define USE_THE_REPOSITORY_VARIABLE
 #include "git-compat-util.h"
 #include "builtin.h"
 #include "strvec.h"
@@ -12,7 +11,7 @@
 int cmd_annotate(int argc,
 		 const char **argv,
 		 const char *prefix,
-		 struct repository *repo UNUSED)
+		 struct repository *repo)
 {
 	struct strvec args = STRVEC_INIT;
 	int i;
@@ -23,5 +22,5 @@ int cmd_annotate(int argc,
 		strvec_push(&args, argv[i]);
 	}
 
-	return cmd_blame(args.nr, args.v, prefix, the_repository);
+	return cmd_blame(args.nr, args.v, prefix, repo);
 }
-- 
gitgitgadget

