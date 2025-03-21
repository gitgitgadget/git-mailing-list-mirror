Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9B722098
	for <git@vger.kernel.org>; Fri, 21 Mar 2025 14:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567446; cv=none; b=ZDqDcKpiSWVkjSnvnd3XBaJZmQjr/pG2/z9h7Nm2trLZ5Pw4Jx9W/sQ0YIQkWFpGgv57etkve38RyYWBIacWyn73UAu4Q3SBaxX9DIRn0TtkeZFC6Re+uTY+/2XORNXrluq7YGElzQRa1mqVlu6D//2HHL7ntzbMu5fiVwHbc2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567446; c=relaxed/simple;
	bh=ZwmmIJAr382YCdQ8yrbSYxXUlbs8CGZ0aeqGtN8Xhi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ivkhy8M2KXlbo6FBIadRaSfA8CMtR19REuVbpR51UaejVDXnUKgNG0l6B3fsMd1VYkLw+ptuLZ+U4cvaijRFTvYkQEHTXS2TKYQkE3L8AFDQLdGhZdeZkKL6pxc+GV/ExcCBykHARl0SKur5AEmSTPBH7Kjho7Wq+89f/tf1sVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3svCI3R; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3svCI3R"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-223fb0f619dso42837895ad.1
        for <git@vger.kernel.org>; Fri, 21 Mar 2025 07:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742567443; x=1743172243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1dma/oxvUFzMetSfshD/u+J12dhz7oB+VAmElmibua8=;
        b=J3svCI3R8r54j2SaJ3/OClK+c7asv7jgGnkNN5nO57JcnoTGcLvgsXLdN0P+r8qSeV
         //TmndRfsFbiqEsv4UjX+nKRSseLTQtsuLOT/P5UXuUnSDMu/GNdJ0QFyjQdBJb5y/t9
         C27e0HRQiygQ/QX/y4pI/sr5m9tbXjiBpfS2fNldmgwxpM9210CFCDV2u+kae1l3cMDf
         QJ7tFgBMuyl59FN5z7sp7VGsw50ORznt6Jj+Gi1xcsTbqISHZSf4DGy05XvU5pq+QuWf
         nn8qR56xi90YN9uUwGAFlUeYO1Q9rYhNg0faNDbG5POVsMedCa/tlhbsJQUw7M4NaTd4
         wIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742567443; x=1743172243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1dma/oxvUFzMetSfshD/u+J12dhz7oB+VAmElmibua8=;
        b=Aur5yN3giI+tyIdAv1r5Lutp7WG1Lug/o6uMKv6bPWoXnwFsw5FsSwz95XFyFg33Yq
         hfU+kzxzFxSmUVujeVSL54/tRQqA2B7yvl4XkQxcbPZztXStd5Tqbc5dsh9EoofcAbLX
         DRWRa3socFr7GfJ3NkUlkB1P7haiWNGj+vFWdXNPvkosvVt1s7CEg1oUUFNa/S1GJkim
         Lf7pJcg/mS6kuUMwHM1YlkSdbp/+6AQB6Pj9yDcRnyzB5MSA5rJBKyoPH5FWQnfpPHhQ
         EPOw4EX4h6O9VDZbHIbRve4b2rsw9i39v1+RjZX/2aYLrkJxOUZxhyWGAqqOY3oWlPWs
         37GQ==
X-Gm-Message-State: AOJu0Yxs5CMjTP9QW20n5k0Bvpihl4yteoGDqYifKEKZAKj2cF8lDEAP
	aInj3nZeoloW8v77dr5bR/G3OoepUAjzbKBEuWlkPyqhG8nSLAb7e0zyUrd2
X-Gm-Gg: ASbGncvb69wzODkNQ4YKQvbXvf/o+JzneVFE6i20T/Sl0f0JQnJJnoHeMLImoJy0vA8
	aXSOKeXIbzS5Gn9laXkfhh2L/9IEQqJdFq4uf3JjB5YczmaksIo4zFf9b8/Qh8QiR/LibYY0h3G
	nap8n6cCFp+eeYHhzaC5PU1fklt24BAo2DeoaqOPQ04ZG8HlkawikJvf4ADWpV024ylaqR2nuI4
	t0T1Yxj+VBKCxy1jErkMfjE8cgyXwCPIlr7EMUHOFogycPFVWvaFBxSvIZqPQdq6zm/9PgqPj/U
	E2Poz/q10teYfvEmFQuZG+JaGPLxil6/tMdSEqgwkiWOxLAg/8f2c8aZwbmuKcj5Fae/HPcW9ls
	BAazVZslk7PmnUw==
X-Google-Smtp-Source: AGHT+IHB8OjGh5oOP+jMD8SKwBSCvpaX1zRRhiKq+7MHODF5ju8AS2VCZEzQ6XYRH8r7FNgifBbmNw==
X-Received: by 2002:a17:902:c411:b0:220:f7bb:842 with SMTP id d9443c01a7336-22780e10c6emr52451445ad.42.1742567442893;
        Fri, 21 Mar 2025 07:30:42 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c005:b018:5841:514c:af52:5598])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811bafabsm17054835ad.139.2025.03.21.07.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:30:42 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ben.knoble@gmail.com,
	jayatheerthkulkarni2005@gmail.com
Subject: [[GSOC][PATCH v3] 3/3] docs: replace git_config with repo_config
Date: Fri, 21 Mar 2025 20:00:22 +0530
Message-ID: <20250321143022.5406-3-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250321143022.5406-1-jayatheerthkulkarni2005@gmail.com>
References: <xmqqa59evffd.fsf@gitster.g>
 <20250321143022.5406-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor config handling by replacing git_config(...)
with repo_config(...) for better repository context
awareness and alignment with modern Git practices.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/MyFirstContribution.adoc | 57 ++++++++++++++++++--------
 1 file changed, 39 insertions(+), 18 deletions(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index 45efe117ab..3ae85016d4 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -316,26 +316,47 @@ on the command line, including the name of our command. (If `prefix` is empty
 for you, try `cd Documentation/ && ../bin-wrappers/git psuh`). That's not so
 helpful. So what other context can we get?
 
-Add a line to `#include "config.h"`. Then, add the following bits to the
+Add `#include "config.h"` and `#include "repository.h"`. Then, add the following bits to the
 function body:
 
 ----
-	const char *cfg_name;
+#include "builtin.h"
+#include "gettext.h"
+#include "config.h"
+#include "repository.h"  // Required for repo_config_get_string_tmp()
 
-...
+int cmd_psuh(int argc, const char **argv, const char *prefix, struct repository *repo)
+{
+    const char *cfg_name;
+
+    printf(Q_("Your args (there is %d):\n",
+              "Your args (there are %d):\n",
+              argc),
+           argc);
+
+    for (int i = 0; i < argc; i++) {
+        printf("%d: %s\n", i, argv[i]);
+    }
 
-	git_config(git_default_config, NULL);
-	if (git_config_get_string_tmp("user.name", &cfg_name) > 0)
-		printf(_("No name is found in config\n"));
-	else
-		printf(_("Your name: %s\n"), cfg_name);
+    printf(_("Your current working directory:\n<top-level>%s%s\n"),
+           prefix ? "/" : "", prefix ? prefix : "");
+
+    repo_config(repo, git_default_config, NULL);
+
+    if (repo_config_get_string_tmp(repo, "user.name", &cfg_name))
+        printf(_("No name is found in config\n"));
+    else
+        printf(_("Your name: %s\n"), cfg_name);
+
+    return 0;
+}
 ----
 
-`git_config()` will grab the configuration from config files known to Git and
-apply standard precedence rules. `git_config_get_string_tmp()` will look up
+`repo_config()` will grab the configuration from config files known to Git and
+apply standard precedence rules. `repo_config_get_string_tmp()` will look up
 a specific key ("user.name") and give you the value. There are a number of
 single-key lookup functions like this one; you can see them all (and more info
-about how to use `git_config()`) in `Documentation/technical/api-config.adoc`.
+about how to use `repo_config()` ) in `Documentation/git-config.adoc`.
 
 You should see that the name printed matches the one you see when you run:
 
@@ -383,8 +404,8 @@ prepare it, and print its contents:
 
 ...
 
-	wt_status_prepare(the_repository, &status);
-	git_config(git_default_config, &status);
+	wt_status_prepare(repo, &status);
+	repo_config(repo, git_default_config, &status);
 
 ...
 
@@ -1093,11 +1114,11 @@ The one generated for `psuh` from the sample implementation looks like this:
 
 ----
  Documentation/git-psuh.adoc | 40 +++++++++++++++++++++
- Makefile                    |  1 +
- builtin.h                   |  1 +
- builtin/psuh.c              | 73 ++++++++++++++++++++++++++++++++++++++
- git.c                       |  1 +
- t/t9999-psuh-tutorial.sh    | 12 +++++++
+ Makefile                   |  1 +
+ builtin.h                  |  1 +
+ builtin/psuh.c             | 73 ++++++++++++++++++++++++++++++++++++++
+ git.c                      |  1 +
+ t/t9999-psuh-tutorial.sh   | 12 +++++++
  6 files changed, 128 insertions(+)
  create mode 100644 Documentation/git-psuh.adoc
  create mode 100644 builtin/psuh.c
-- 
2.48.1

