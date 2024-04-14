Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9403418B14
	for <git@vger.kernel.org>; Sun, 14 Apr 2024 22:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713132488; cv=none; b=X2opqMCUsdA0OvsSoS7TSRvCKXemx3t/3V998m31VTmZw0IUib6gmLvzyZxG1Hwc+OBZo9WV3sptGblctkxWW5ZIwgaJ+mbO8ud26lJiiFwQXRPz+fwmHJNwu7VcL6+3sWPYIWhN8bofi26CkAnhLKcmvqyoK8xQsE4aMjFg7+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713132488; c=relaxed/simple;
	bh=jwQxUYtPy+rv72XQ/lUqPFiwDzJj6YkZ44d5rKcrDVg=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=OgT4rtX5L4iPvtwNkMmm6I42180ch56V6FDEfi8VK7w6USfEG0lDEI+0zwCyjEeVBFNHlBtFyUXljQzY6lH880W2LivTZv2/bmsXAEQLN03oA6kDIQzyAIHDSdRKSugpq0zvxaLO6iwtZIJjsVIDCZIXPnTd3CxrGYSg7PVMhRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAVpA5Y6; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAVpA5Y6"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d895e2c6efso32809331fa.0
        for <git@vger.kernel.org>; Sun, 14 Apr 2024 15:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713132484; x=1713737284; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HdsRmMSPWQz2/5lcJ+BxDj1VLB4U5rBXPPC4nidZMzk=;
        b=BAVpA5Y6uD/tyQvkmGMZwP6YLNr7Y2L44U6Gs3A8sFo0QpfdNnelajO/cyjNz194qA
         kkCf+nsPUOttf4Rv3sIL+VVjG9RqUHp38SRM8X+KjvuACGVIXTCqulFsJaT8cRt5JqTv
         YMaC/1RJo0IANyZWvuN3gfaev31DQ6SGrDD4iDIuZBpgZ1P84OotETJO09QvseKctsl+
         BTtbtgkgdyqW98xS0dLZJRKwJAb6FU/AW/lkCYVdjAOvX081gD4N+j4/1I55GXGWXgSo
         qjuPFmRzVGrChCRvbOcFxbhoN08vtJcREYjC88BWejq6KyltV8utLL4fjBfQeGzikLb6
         OyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713132484; x=1713737284;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HdsRmMSPWQz2/5lcJ+BxDj1VLB4U5rBXPPC4nidZMzk=;
        b=JTBfpsoIqkuVtOEIC29NtnoElP/4vdAGahEMOVdl7rU45RlLjuOIt3+9kVLZrEAO/6
         P3R4o6DnAy4ku9RoPAmy5/F8FL0kbd575OhKeCZuBT724dT5rfORa4lEQSb8BLKUFjrw
         BZEhAXq3GO+gxfoAOhqiaztRibrareDTd7l/qj4WJs17nEKy6B835JH4ce0AHscFH8R/
         0LwDO82GV4V/EqOAei1zZp58pN5ytfOE44VFAYDOf7wGLvOWvufso4YeObquR8jjnaQ2
         wkMan3z7I9TfR3CEmj7nViOsQpHbq7BQZ8FjoRWfz7nk27bobh22lRTwqzXH2NdJL/aU
         3OUQ==
X-Gm-Message-State: AOJu0Yxt2UaoVYz/WPoxD+C5I2qWrbQIt3BwzzStOBRU2MjsK6XfSpi4
	B0mGc5Zo5IxW/SuE7es+XfeolXz7b+s05HQAoBLJ1Ek04hRMvqeUYEBZ5g==
X-Google-Smtp-Source: AGHT+IGf8sPOfQb3bnLC9g2WsdQlVbhqXvhMUglTFx0M20LtCLjD2RVx88pM/NO/3U9ArWjTtqegCQ==
X-Received: by 2002:a05:651c:b0b:b0:2d8:2799:fbcf with SMTP id b11-20020a05651c0b0b00b002d82799fbcfmr6085015ljr.34.1713132483916;
        Sun, 14 Apr 2024 15:08:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n3-20020a05600c4f8300b0041627ab1554sm16791235wmq.22.2024.04.14.15.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 15:08:03 -0700 (PDT)
Message-Id: <pull.1706.git.git.1713132482976.gitgitgadget@gmail.com>
From: "Yehezkel Bernat via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 14 Apr 2024 22:08:02 +0000
Subject: [PATCH] Documentation: fix linkgit reference
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
Cc: Yehezkel Bernat <yehezkelshb@gmail.com>,
    Yehezkel Bernat <yehezkelshb@gmail.com>

From: Yehezkel Bernat <yehezkelshb@gmail.com>

In git-replay documentation, linkgit to git-rev-parse is missing the man
section which breaks its rendering

Add section number as done in other references to this command

Signed-off-by: Yehezkel Bernat <YehezkelShB@gmail.com>
---
    Documentation: fix linkgit reference

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1706%2FYehezkelShB%2Fyb%2Ffix-linkgit-reference-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1706/YehezkelShB/yb/fix-linkgit-reference-v1
Pull-Request: https://github.com/git/git/pull/1706

 Documentation/git-replay.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-replay.txt b/Documentation/git-replay.txt
index f6c269c62d5..8f3300c683a 100644
--- a/Documentation/git-replay.txt
+++ b/Documentation/git-replay.txt
@@ -46,7 +46,7 @@ the new commits (in other words, this mimics a cherry-pick operation).
 	Range of commits to replay. More than one <revision-range> can
 	be passed, but in `--advance <branch>` mode, they should have
 	a single tip, so that it's clear where <branch> should point
-	to. See "Specifying Ranges" in linkgit:git-rev-parse and the
+	to. See "Specifying Ranges" in linkgit:git-rev-parse[1] and the
 	"Commit Limiting" options below.
 
 include::rev-list-options.txt[]

base-commit: 8f7582d995682f785e80e344197cc715e6bc7d8e
-- 
gitgitgadget
