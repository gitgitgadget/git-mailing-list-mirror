Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE03779CD
	for <git@vger.kernel.org>; Sun,  5 Jan 2025 12:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736080523; cv=none; b=eggSyN3l0A/j3FSCtqQE4jBNxvg+raxM2Ka+kfaKyCppIIEfEbddspv2PLhDoPU/lMbkRWQM+Wtskaqc0YZPYc4hISfB0YuNjXVtmm1Um5H1UX7LFtRcdUuUgkrq6Bm1yGfQpdbA1LVaQ5Ski0N4UH5/VeRVONVChXmT3WTAGXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736080523; c=relaxed/simple;
	bh=QKcIEpuWvEjClxkFaCCDphOckv3CnTH3u3MYuZPueAU=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=N2eUk9O8OsW3lkRcXGMiXmIZjdNVIGWLemRvl0BHw/3fKWv08vVyUqmmJEJ1yHJYq3AfhViNG824ocz7vN7bAutTDagzyGGToyNW5QcUoVRdciGWoqt3Ze0iyBiZOMZRfbUqKkeN1yuIjNwuYpIPUiMnkSABszKS8vk2zQoXNTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCVadX9z; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCVadX9z"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4361c705434so97665355e9.3
        for <git@vger.kernel.org>; Sun, 05 Jan 2025 04:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736080519; x=1736685319; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wCoq8U0rYDPgzu2piCcnmQHFNHpEUkxE1NtZD1XozlM=;
        b=iCVadX9zYLns2am09WqTPXrBbIWoZNh2M6ApW0qu/c8BMz6f+3px9LucunakWfIHv7
         LXap6UXlxQlI7Ihzgyi+dCysqjkH3T27nFTGFKXFYfahTBC/frCWe6poT2K6eR1WtO2g
         xA3dL65Rh/WA7RE1Q9t2E9YTqu1oQv0DlRSzcY0RGdL3Kt2aXS9lb9is2unT78UfIWv/
         8bJjO7HW/iUWS8ZYqMalBun7CCfIHqVB6f38z7Yo7gY1WWoAI8qIB58KtbJuXWjnw/CH
         3QyVL127yMlozMcAiKUQrwCGwVKr8ajpFHwEGrREzI7abyUYFSZosVrU1vYSMSE5nYyA
         o4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736080519; x=1736685319;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wCoq8U0rYDPgzu2piCcnmQHFNHpEUkxE1NtZD1XozlM=;
        b=hocR8CdA7QQt4jw8v5tZjq6G8P0XnU2s6A49iSqwH2yO3Ki8CijHJlftNdTOF94jW4
         ljUalIzon/grO/POsGb3rxwGbk7imJrNM/fQwWUbpjijUqki4UfJUGBZ/+gg8q9W6Yov
         QK+Yi46IuNJl4WCPzG5tV+kdLND1lZcZN1Isbl1N1u47gEYIpiMOX9hSlDL7/BY/07j1
         02Nh33/84jPimNYmV5whOxZIVTIepoPBY6oIjL42hMP4qrvALbAf1+Ar7inDAsWBL/hR
         D0hs2CjtBp8qMsmharI+GV2Y6BkcCAvM9GW7UudZ3uPaOaW23sVdBi13vjy3Ofa1k+o+
         cDIA==
X-Gm-Message-State: AOJu0YypJ48yuYWGfWUDEgdFpW/W5r4Y+X00jW4QGkfD6/E6wKO/0olu
	MSjZ9/Y58bbHIN1phtGOH8OhGRr/mRNzKi7GhgNfxDQvXaeZGCkGSI2E9A==
X-Gm-Gg: ASbGncsjfVM15FCvLC4dxcuovbGjtlP+czYVAT5gPrggQ9V//kBeWNzmQ/hLoOFEgp+
	MeOHzAtGM6qHzb9nF9DWHp3TFcCZ7MG6Z4Ou8fxLvfqpMw1ndaiLPIrZr30WchdpdCpGxhZ01Th
	GCGNMV+PCYgAqqwQGfneVH9TewyeDFsEv/iz/5NORd/Cy6vuoaU3S/m1c9c2b4kBmuyrAwmJJMF
	e/0F/uLrtwcPRPfKzeic1NUhJ9xfUFAndtW0zgMEy9upnCHzo5YWaj08A==
X-Google-Smtp-Source: AGHT+IF/SF3DDvgiS/bKr5n5EeX5z4NyN3pe0lSsK5I4ltHD+WRpeZTfKQhW1z7vkMD6qxR6UJ7JKQ==
X-Received: by 2002:a05:600c:35d2:b0:434:a929:42bb with SMTP id 5b1f17b1804b1-436686464cemr501519615e9.18.1736080519055;
        Sun, 05 Jan 2025 04:35:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436612899f0sm538265495e9.38.2025.01.05.04.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 04:35:18 -0800 (PST)
Message-Id: <pull.1867.git.git.1736080517950.gitgitgadget@gmail.com>
From: "Rhythm Narula via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 05 Jan 2025 12:35:17 +0000
Subject: [PATCH] docs: update contributing guide to refer current bugs and
 feature requests
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
Cc: Rhythm Narula <rhythm.narula26@gmail.com>,
    Rhythm-26 <rhythm.narula26@gmail.com>

From: Rhythm-26 <rhythm.narula26@gmail.com>

The contributing guide is updated to include references to the current
open bugs and feature requests. This update aims to improve visibility
for contributors on where to find open issues and features that need
attention.

CC: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Rhythm-26 <rhythm.narula26@gmail.com>
---
    docs: updates MyFirstContribution guide to refer current bugs and
    feature requests

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1867%2FRhythm-26%2FupdateContirbutingDocumentation-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1867/Rhythm-26/updateContirbutingDocumentation-v1
Pull-Request: https://github.com/git/git/pull/1867

 Documentation/MyFirstContribution.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index e41654c00a6..3b26a5265b2 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -109,6 +109,14 @@ of invocation during users' typical daily workflow.
 (We've seen some other effort in this space with the implementation of popular
 commands such as `sl`.)
 
+:mailinglist: git+subscribe@vger.kernel.org
+
+Here's where you can find bugs and feature requests existing in the system:
+
+ - Git uses a mailing list for discussion on bugs, features and patches. Search for relevant topics or tagged issues
+   like #leftoverbits in the archives: https://lore.kernel.org/git/
+ - Unofficial bug trackers - https://github.com/gitgitgadget/git/issues, https://git.issues.gerritcodereview.com/
+
 [[setup-workspace]]
 === Set Up Your Workspace
 

base-commit: 1b4e9a5f8b5f048972c21fe8acafe0404096f694
-- 
gitgitgadget
