Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ACC13664E
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 08:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727945883; cv=none; b=UsTZ7xEpfk8EN1NoxtobDeKBfvBWkPg9HYolzTV2Ce3avwWF3EUS9CGLbaJRnwnv28vHuLSBZeTKv8DUgveQhaIFX3pWsyuJEtOxecf40PEJ5Euu7NCjRATvsrP1I5mIz4a+OMt5bOnaz24ff6xV0icdHexoKRFutT2YYvQy7A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727945883; c=relaxed/simple;
	bh=U2gqif2oNxe1/yy5uvoql/Hpm1aPV7yXqiMYeKiEMdk=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=JBsVn4MR4t/GVMq7qy45CA5go1HiQfxpUbxJR+7VED1PaCeNZBnjO9CoQih8/5H9CtkjahhXnvKrZgn1lv7Nl26mQjrsKSriDb6KPADLa0U5StycSU91/Ir0FqLhLVPwK2Q1gY1OkVyOV2bBzzX2u5krT0/SB/D0m8JAZxP/F8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZep8Nm+; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZep8Nm+"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5398cc2fcb7so758284e87.1
        for <git@vger.kernel.org>; Thu, 03 Oct 2024 01:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727945879; x=1728550679; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IksLpMxD9pfneRnCk9hmu0rpyca2O16MpYcFOEwJl18=;
        b=IZep8Nm+8cHM0Im+2tey9YVAKzv7xbyMZqndwAKdE68m92vlCmKHRIEgzVLjC6rdWK
         rv0sP0EqciBQ9kLCYBObfHxu9n0s03bUxn7O/N9B3jBHe3coSMBZ0mJQZk268jW6vhVC
         MEse8jCcPCfM737MIlmkkGQHpgMf+fvXVCjPf5NYFjh8Bq71ItdJq4vbHVnfttpMU7Py
         op0M0xwsECMD3b6WTYA+sHIG8hIpfPjl0jHh00EVk8pSlbyqK05SOd80pCi+SmwO+rdj
         HDeqyiTa5A5pOq0QFQhNJPm28goqgC/hhNiOdh1m4F35sYxBCsjbvS0+Eo15gVVFQKk8
         07Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727945879; x=1728550679;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IksLpMxD9pfneRnCk9hmu0rpyca2O16MpYcFOEwJl18=;
        b=VmxfrbywKSfqzFGkOutKiV01NOc175VcA7Cpdz23JDVZMAVfzqt676CTV4uNI88tC0
         SVImDK9RHlXV8NuZ7D8jRvwtpbomtM17SQrwYJ+4BPkdhM2fnmQyoXjk9RNXqSKge2U/
         3Ozwwml3GOW1J58bQbQ+XzilTeMpPqQrJpcPmrbeKg6cHxHw9fqsUT9ooD7YkDnG8JOJ
         2HxM43vQQqhVZy5yHSqAp/teizELoz9x62gMACilm9Iz2L7Je8IX2gSAa8fczHrkdHLo
         7Lo3wf+KNYo7qk53RHyh4o0kTAKtvAzo9snU5nQGvQW67IxTkPTIkdNIY2YE2sVKQQFJ
         T2cQ==
X-Gm-Message-State: AOJu0YwsdISewq8yTzYbau7DWwkeY5k2Js1b6bZ0yc39a9Eg7QMBz17/
	8wEq3oEvCpT9n9qhNk4VMdXiouNZJA5+f4c8Y+75crylKMO67Z2bWOEYjw==
X-Google-Smtp-Source: AGHT+IEBo5qCCfKBob8R6lSfhFu6tZ8O0eyRkRd9Hu4NKZpVNo3lUV8BxQq3lb9eGbSpoIj3HMYfDg==
X-Received: by 2002:a05:6512:3085:b0:530:aa3f:7889 with SMTP id 2adb3069b0e04-539a07a6691mr3715977e87.56.1727945879003;
        Thu, 03 Oct 2024 01:57:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99104c97fasm54852866b.208.2024.10.03.01.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 01:57:58 -0700 (PDT)
Message-Id: <pull.1794.git.git.1727945877922.gitgitgadget@gmail.com>
From: "Shubham Kanodia via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 03 Oct 2024 08:57:57 +0000
Subject: [PATCH] doc: add a note about staggering of maintenance
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
Cc: stolee@gmail.com,
    Shubham Kanodia <shubham.kanodia10@gmail.com>,
    Shubham Kanodia <shubham.kanodia10@gmail.com>

From: Shubham Kanodia <shubham.kanodia10@gmail.com>

Git maintenance tasks are staggered to a random minute of the hour per
client to avoid thundering herd issues. Updates the doc to add a note
about the same.

Signed-off-by: Shubham Kanodia <shubham.kanodia10@gmail.com>
---
    doc: add a note about staggering of maintenance
    
    Git maintenance tasks are staggered to a random minute of the hour per
    client to avoid thundering herd issues. Updates the doc to add a note
    about the same.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1794%2Fpastelsky%2Fsk%2Fdocs-update-maintenance-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1794/pastelsky/sk/docs-update-maintenance-v1
Pull-Request: https://github.com/git/git/pull/1794

 Documentation/git-maintenance.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 9d968191331..6e6651309d3 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -220,7 +220,9 @@ on an hourly basis. Each run executes the "hourly" tasks. At midnight,
 that process also executes the "daily" tasks. At midnight on the first day
 of the week, that process also executes the "weekly" tasks. A single
 process iterates over each registered repository, performing the scheduled
-tasks for that frequency. Depending on the number of registered
+tasks for that frequency. The processes are scheduled to a random minute of
+the hour per client to spread out the load that multiple clients might
+generate (e.g. from prefetching). Depending on the number of registered
 repositories and their sizes, this process may take longer than an hour.
 In this case, multiple `git maintenance run` commands may run on the same
 repository at the same time, colliding on the object database lock. This

base-commit: 111e864d69c84284441b083966c2065c2e9a4e78
-- 
gitgitgadget
