Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CF1205AA6
	for <git@vger.kernel.org>; Sat, 15 Mar 2025 18:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742062518; cv=none; b=ehL13C1S2tat+RNy4TLr/8ObcvVBamr/fZg6Emrk2QFiq8Y0l/fU/ImTn/QCsdt/5SCg8M3QbLolz6UgC8MxU1IVpBjHfAkd3lVW5f/3CoRSJFHJ0eW/DJWF6qxXo6LIoRu9PNaLuosOOeLP2kTaKKsVDp0rTztMowlB/wZ7n2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742062518; c=relaxed/simple;
	bh=+Juhdx+PRJREza7SIeLc14mxZQtjySGEHk4DlnKf0Xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DCnKEDSI3i67yyXteEQXP2Ln/M6++G5isc+hEDjk2V3DRX16XByuKnBR30PHNmjhoMJ/abuPpgTbMjtMcF6QOQdYm5QrBjaFJ8nIpvyKIIvIvV3TCGdP0zhVp6izqquKq4mtk2Wo4LVPTcKiRuLVHvXw/hoOjUO6YMjD5EMnaGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bO65Gu0f; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bO65Gu0f"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2254e0b4b79so76956885ad.2
        for <git@vger.kernel.org>; Sat, 15 Mar 2025 11:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742062516; x=1742667316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvW8h6o7oKyNh8LceolnALHpZvTciFqkIlIzHMER3FM=;
        b=bO65Gu0foLCM93zG1rljThc6u7ucxjx5Pi/dxwV6BrKXJ0Z0ss77n7jS2bkOTE47av
         ucTFz3TRWr9skuf5wHDbVT54MW5/vrR9vBGaZk5WsGlpJBASSPiPTmwMYGLoJ8BgfG2B
         EQzh8F5hiWHQLnvL99SOFbzenrDLi60CATQhnHfv1zhrwRqpPB+uiv07Z3fXfdyQUU/3
         u1W9jOy2G1gT0dBTq4yI8ZRyDG+aFoIqJC8C0i7np+jSuk0ipjqkdfZ33RpcV8ByUss/
         S+TUm/vUSln/f0JagPgEX/yF/S1LqcpHiRVQlUjpHA2a/0OBhCQL4aaNJ6jf6dNtAIUP
         A/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742062516; x=1742667316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WvW8h6o7oKyNh8LceolnALHpZvTciFqkIlIzHMER3FM=;
        b=tQx+1gfElxbkmWr0IIav2Ckt5K7A7RZC5TyBOzNTRhuJrxCGwRnKBT6I4ihPL2i38g
         2L7MKBHlPv31zfJejbe4HYc7jaFnUC60mQ5j4w/Atlz2WFnIeejxZJQPcVIvkukdxC9n
         GKGUPrWZauK/OAgesloTJTOyvF41KhYj+UdCrucV7ovNW6o2HLoJMjzDnq1plcurLoo1
         h8BAChuwgTwmYMvtvpRXuL4o9SL9/wOoX3Yxprkt4Pb5WRlCqtRC0JqP9UL7RX0E4Ui3
         eUH5Dt9LK3UItQVDj5/G5IrS1huI3Phay+5g8VDyzXkU09EdM1gKc/EW+uSVNIcCyvPY
         eijQ==
X-Gm-Message-State: AOJu0YwyU4+O4yjzXv2oeZgFk4wCR06zkfdj8XJhF/Ze2wp2xrXNj0e2
	vV1CvXjvO0qBjsSqLN/T5Ud+joC2344AP/WVZi7SHuCh/yCvh2ii+4ZbO6Px
X-Gm-Gg: ASbGncsPNnmGjnUF7/FnAulPyip1oZR46R8bGGN4wwen78DM7R7FxWFixN2fNbPlvy1
	3zh9UW1Myh3A4KszYzbLuvt2f0qXVY10NU4D7+wmrZI2w/ZZjb2oyIEnf7mPwVfiFFcLf62IN6v
	KtsYftyR8O2odyiiFAN2MWJvji//rP1ub51dHE1Vdm0SYjpIlnuNk84KVCj5FiLYEh+1ChgZHUJ
	vqIX9yC6mjmyK53Urr2lfC+sPqXawUGWI+MqU9R7Wz+OnRJdySQE5TX1CZ7XChoHtbyyvkbIaeF
	nlEqzoBuhYPrxKvtvzbPvM09UI1m9GZkIzZXlHTMEnJxSdQwCqQkAOoqywCaGI86Hq2K9VFdWyr
	SpLVwGrDV39kZRA==
X-Google-Smtp-Source: AGHT+IHJqE6r/lJLc78hNyQMmaDaLH7KxHR/xbLTwutVIk2s1Byerh1eloINvXnXCXj2ukyeFxbg/g==
X-Received: by 2002:a17:902:f689:b0:223:4b88:780f with SMTP id d9443c01a7336-225e0a3ae99mr71927535ad.17.1742062516174;
        Sat, 15 Mar 2025 11:15:16 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c005:b018:5841:514c:af52:5598])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4e0dsm47269775ad.221.2025.03.15.11.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 11:15:15 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: ben.knoble@gmail.com,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [GSOC][PATCH 3/3] Replace git_config(...) with repo_config(...) for modern Git compatibility
Date: Sat, 15 Mar 2025 23:45:04 +0530
Message-ID: <20250315181504.65069-3-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250315181504.65069-1-jayatheerthkulkarni2005@gmail.com>
References: <20250315181504.65069-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/MyFirstContribution.adoc | 57 ++++++++++++++++++--------
 1 file changed, 39 insertions(+), 18 deletions(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index 34a0336898..8f52ebea0c 100644
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

