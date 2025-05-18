Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4E6202969
	for <git@vger.kernel.org>; Sun, 18 May 2025 07:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747554220; cv=none; b=mfc+7EVbv0STCXwLap73Ltx7peN+tSEFPDhSzHPjl6hp55CjKUDAo6AZrOf3eY2wtWBXF7+uA1ZPq5/VJ4+ayegxniW0kBFajWzou+KBtn0Yz+rwb0ZfyvpFCQhZRZvIyOH7abq8YwYXxkYSGM4/MsHBRfjj4S91F8RFzAXgSxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747554220; c=relaxed/simple;
	bh=0XC4oeOnjyA4Y+QX9aiZKchM0utistwwSjOfadOHcWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBAD2PnS6JmYw9U0Ga/0riskEzORRweBt54mjHhFYPn9lFr9rv8myc69II07Vavh47FfQqs51s9zZ2Ef6gtIVLMdQ1VilIGe7nm/+hgeO6SUNoADy4VwtF/VIwi5IiExoIa8+UYv+ZbirCLC8GySu7S17vvOYJ9UHGUlSW3AhGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lf/ZZru8; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lf/ZZru8"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2321c38a948so4835655ad.2
        for <git@vger.kernel.org>; Sun, 18 May 2025 00:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747554218; x=1748159018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+LO7bElb9Nihy9MjMvDsP6tusWsRZXv3TzfeAe6QnM=;
        b=Lf/ZZru8Ez33XyoM6d3ux+LaS3899+pKiL6OF9WjKMw9BVgxNuw+OWLEa6DY2JRrBm
         HGp88WxaHDT6BtGw10Pu6m/Rd9htwAJto9d/D4TQD1EboMJjnHqnlU1aLDOVz5pSLHcp
         /KseYIT+nhry61SKToDI6Z0mc8vGt3yeWAv7goJTNd5kBykG+PLPkSBb2lsO/8ox3ras
         YMF8fL1P4nnB6+z0ITKX9U2Px1RVKCOPvhV8oqyMS9CbvKqMtIrj+7/yu8w6uHB/PaTi
         RkSZm8lB+WRxszBXNhm3JvZguqCa3ceTVceSNvN4z1qRozj7ok4/cmN1PqbiefODgD3X
         0WSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747554218; x=1748159018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+LO7bElb9Nihy9MjMvDsP6tusWsRZXv3TzfeAe6QnM=;
        b=nTDcmhb6NgaBLC3y2Yok22QW9Xnj1TI51zur78P2+Gb7yIJb6O5DsSsZtp/itqHbHu
         3xXSSMRrtjKGrS4hTOjpNTjRXx89lwwQeEmK9W1QW2drzxveL5jOPxODezV3oA6u8xf7
         Sc4tz8Ncc+R1UCeQgJw1am4Zb+2XX62tNFKKw/uGRJ9khgN1UnWrgzTcRa7H/FaJYSUf
         fbchTvCHSNq7ylaWe/HZp0uoR4krgTPfNchuJ1zcnW7pHdqnGzAiGyHtJ2l71Az3mFXH
         Qs3SdezbxKiMOgW+tteNChRCcjLrHZdwHzcjjBJFkAH6qVgAqwDLZXa0KO4H9aqVQtyo
         Tepw==
X-Gm-Message-State: AOJu0YxmgRwem84iDAJZPPwIWvR6MTB6owYskrpP1umlbA67jXR+4pM9
	Fj/xu5V82DyRC/yhtTfsKkf/DTzEh5AbACrexxVbshLVWFN+k++18xgo9cAuZ8zU
X-Gm-Gg: ASbGncvQ1AxHy+fJzh/DiZzuQmEf7S5B0hcaXOctKkNQ+df2YXf1Zm9pAuGg8ZCtgJL
	RYfUFrvP6+bh0Vh6bg2fDMmZJm/UIhS7FP3Y1leigN/c6T9xAfgbq7/HMwppU6NMv7vSinPzNyR
	1edjbjPlBubbUdNhZ79TdKW1bHyDTMHtdrB0s59BAYl6eW6w9eYpQHN9GmGT4O9NQXFis8Wv3Yv
	sDt4b/9EnOxksVB355djglR+39+mXSyXMjitYdpG6QKXBlrLmIBwzgjhEf3fIVLamOVKJDEwjIU
	UiBjKNb6CikZF0EdieH72QWK/y215/0rIMquLyZSTE/n7FXuI6EchbXEvgwS+F/cz+o+j9qNqja
	dOw==
X-Google-Smtp-Source: AGHT+IGVS4foH2Jhm1iQ62Vadd87kPMGnYxBc+JCTVD6qF5B0zrHFvwsB+rnKJM7UUGVBpEABHJboA==
X-Received: by 2002:a17:902:dac7:b0:21f:7a8b:d675 with SMTP id d9443c01a7336-231de3515ccmr124941685ad.4.1747554217811;
        Sun, 18 May 2025 00:43:37 -0700 (PDT)
Received: from fedora.. ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ac9fbdsm40131625ad.50.2025.05.18.00.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 00:43:37 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	jayatheerthkulkarni2005@gmail.com,
	nasamuffin@google.com
Subject: [PATCH v4 3/3] docs: replace git_config to repo_config
Date: Sun, 18 May 2025 13:13:17 +0530
Message-ID: <20250518074317.73367-4-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <20250518074317.73367-1-jayatheerthkulkarni2005@gmail.com>
References: <20250518074317.73367-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since this document was written, the built-in API has been
updated a few times, but the document was left stale.

Adjust to the current best practices by calling repo_config() on the
repository instance the subcommand implementation receives as a
parameter, instead of calling git_config() that used to be the
common practice.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/MyFirstContribution.adoc | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index da15d43d1f..08a3137101 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -322,7 +322,8 @@ on the command line, including the name of our command. (If `prefix` is empty
 for you, try `cd Documentation/ && ../bin-wrappers/git psuh`). That's not so
 helpful. So what other context can we get?
 
-Add a line to `#include "config.h"`. Then, add the following bits to the
+Add a line to `#include "config.h"` and `#include "repository.h"`.
+Then, add the following bits to the function body:
 function body:
 
 ----
@@ -330,18 +331,18 @@ function body:
 
 ...
 
-	git_config(git_default_config, NULL);
-	if (git_config_get_string_tmp("user.name", &cfg_name) > 0)
+	repo_config(repo, git_default_config, NULL);
+	if (repo_config_get_string_tmp(repo, "user.name", &cfg_name))
 		printf(_("No name is found in config\n"));
 	else
 		printf(_("Your name: %s\n"), cfg_name);
 ----
 
-`git_config()` will grab the configuration from config files known to Git and
-apply standard precedence rules. `git_config_get_string_tmp()` will look up
+`repo_config()` will grab the configuration from config files known to Git and
+apply standard precedence rules. `repo_config_get_string_tmp()` will look up
 a specific key ("user.name") and give you the value. There are a number of
 single-key lookup functions like this one; you can see them all (and more info
-about how to use `git_config()`) in `Documentation/technical/api-config.adoc`.
+about how to use `repo_config()`) in `Documentation/technical/api-config.adoc`.
 
 You should see that the name printed matches the one you see when you run:
 
@@ -374,7 +375,7 @@ status_init_config(&s, git_status_config);
 ----
 
 But as we drill down, we can find that `status_init_config()` wraps a call
-to `git_config()`. Let's modify the code we wrote in the previous commit.
+to `repo_config()`. Let's modify the code we wrote in the previous commit.
 
 Be sure to include the header to allow you to use `struct wt_status`:
 
@@ -390,8 +391,8 @@ prepare it, and print its contents:
 
 ...
 
-	wt_status_prepare(the_repository, &status);
-	git_config(git_default_config, &status);
+	wt_status_prepare(repo, &status);
+	repo_config(repo, git_default_config, &status);
 
 ...
 
-- 
2.49.GIT

