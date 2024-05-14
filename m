Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7898717BB3A
	for <git@vger.kernel.org>; Tue, 14 May 2024 16:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715705587; cv=none; b=JptxvyijFcq9X+3s3CWTAiabf6UijI3NoELo1jk1F9aJSx8lxJbw5GBRtvtFivPmDE+jdBoj+QimFp9M0AutP+KLGLW1I/63tEDHGU/F6MzvWBVRNw/MTCy5tV2oVbrsDuEuIWfFkyjJA5xLKI+F5R5bPz85B/W6Z6WWBKBEbEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715705587; c=relaxed/simple;
	bh=w9YbShUA6ke5BGtSBNHqS/AhwzKnDTZm3qnPdckMlDk=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=VUwt1+F3po20b6gl1NBKQhTjY20Cf8XNPTAlEUKWKjOuNehw+b/GDlCbXC45EATVh+0VIsPG+mjJ6L/ND+fpfey8N/WmNPpJ43S04Yk9vNbHoSaasuRWHHKHdJen8yNScZTGN419o4ZMHukMvP5VALe+HOYxby2M9/GeXjDkhR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IK6rkPBi; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IK6rkPBi"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41fd5dc0480so36947355e9.1
        for <git@vger.kernel.org>; Tue, 14 May 2024 09:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715705584; x=1716310384; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JPNzkbWD8i4J5O2KAPDIm35ToEV/nZ7tEURNb69gLZQ=;
        b=IK6rkPBim8/5W9Oi4wu7sS4K4UX9gz2d0OSGqlDc1HBrrRLQ38QziEdvWNDY0v/4me
         0liVcPeyDbbmawSmy4zgQpdRDyZDPUmOxKXJluthiIxN+rnleUN9iP5R0dqAigpAylNo
         yv3ezVUhsd9Qa6u0/AoXre1xdFMRSoMDY3KUR88B9iIGB4Xy3JpCykNiM9jjyaHFLoD1
         pDv6uFt9fpN+711GsHC5Z4gycoTMt3iGhNmbTqKr+876/9zwo1HJ4aY8r0/5ZrBTYfDQ
         +mpoNQTFoeeryn9OGtbNEUI7FBDY/u+0M0IzG7W/KYHzWM4F0VKM/g6Q7P16H1cJIqoa
         Kaow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715705584; x=1716310384;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JPNzkbWD8i4J5O2KAPDIm35ToEV/nZ7tEURNb69gLZQ=;
        b=DHCuL9uQk/gio0BDDsdkPmwFPd0lBuWklrERQ4kuwbm3fYzISF4e0afUaT9L2QqNyI
         ND1BhAKNQh7GkClAlxnQP7Q8zIPKmtbFmX6CAEYNsQzGT3J+j8QP05VxV+uBaniGbrsX
         iax0EW4B3bCYBuvavQ12xlSIG8h1Gl7uDFGcGcFib4M7gv878n0YckCaMAeuKVye8rKE
         zQN5/db6wLgiCXgMX5JGERCkLvmNwkW4f7Fl+7b4Op0jNFfAt1Y2iEIi0w2780/yLX+L
         3fcsIn9Uzav9oitSiBSA+se8rfSN555Aq93QygrMY4cZPCrT49zJoZDpS+47TeBMMasQ
         cPqg==
X-Gm-Message-State: AOJu0Yy6LoU3Cwa4/mAHwEwvsTC9V22GKVrDMOrVQF4z/S+3NBMiWaaS
	yTEv9lMVyfmLz8lOu4TEPLN+N8EH8CR91Cq+4nRas4M9U/2Ri9HfM5xmCg==
X-Google-Smtp-Source: AGHT+IFFkSp3jZacfD4Ln5BJxjIaBDddZHsulx/rqXzTPY+D0gYnkyIA/XKZpeiI6pf8h0vtPSbeHg==
X-Received: by 2002:a05:600c:1c02:b0:419:f27f:6b05 with SMTP id 5b1f17b1804b1-41feaa2f438mr87935865e9.8.1715705584389;
        Tue, 14 May 2024 09:53:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42014c21260sm88371385e9.3.2024.05.14.09.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 09:53:03 -0700 (PDT)
Message-Id: <pull.1720.git.git.1715705582609.gitgitgadget@gmail.com>
From: "Timofey Vasenin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 May 2024 16:53:02 +0000
Subject: [PATCH] gitignore.txt: fix slash-rules example
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
Cc: Timofey Vasenin <timofey.vasenin@gmail.com>,
    Timofey Vasenin <timofey.vasenin@gmail.com>

From: Timofey Vasenin <timofey.vasenin@gmail.com>

Fix an apparent typo, introduced in:
1a58bad014 (gitignore.txt: make slash-rules more readable, 2019-06-04)

Reported-by: Andrey Strizhkin <astrizhkin@biarum.com>
Signed-off-by: Timofey Vasenin <timofey.vasenin@gmail.com>
---
    gitignore.txt: fix slash-rules example

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1720%2Ftvasenin%2Ftvasenin%2Fgitignore-slash-rules-example-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1720/tvasenin/tvasenin/gitignore-slash-rules-example-fix-v1
Pull-Request: https://github.com/git/git/pull/1720

 Documentation/gitignore.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 5e0964ef419..7142fa10acc 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -100,7 +100,7 @@ PATTERN FORMAT
    will only match directories, otherwise the pattern can match both
    files and directories.
 
- - For example, a pattern `doc/frotz/` matches `doc/frotz` directory,
+ - For example, a pattern `/doc/frotz/` matches `doc/frotz` directory,
    but not `a/doc/frotz` directory; however `frotz/` matches `frotz`
    and `a/frotz` that is a directory (all paths are relative from
    the `.gitignore` file).

base-commit: 3e4a232f6e3bd3b7dd920bb07b21cf1c8b4e1a7f
-- 
gitgitgadget
