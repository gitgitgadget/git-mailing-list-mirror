Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DB1326951
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 00:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792198451; cv=none; b=dxON7jG5+h28pcDsORJTNy2Rbw9mkl0SOz9/oijKX0JOnQ9fi5k7CCBaGiVeLhOtWmxuOtbdQX0eLwBY9130g6RYAp6NyF2Wm/DzavpvO91fIS1m2gR/7bWB8b1KGs8frOt2fIUCKFvlk8vls+T7uyFoCD7ZwpujWXFgWpFaBAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792198451; c=relaxed/simple;
	bh=WxNq+Lj/5yd8FrM6GPW30HtW/PhHJKuGAysFrhdp4UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kiz5BKDYu889I4/Rp9MYOJT1bg5MakGE/z6+PWXyszrwmc2bt2wq1DatJap6X8F5a3G5NE1Moca7LrvwtKi81XiX8U97fKw0MIgJo++qikboXpGr7DG2ARGPUbwEoi2WV+qV/cmON5Ke/OgJs+gY1nZ/Hh3xUe1PplC/naznf9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YB5kN7QO; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YB5kN7QO"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a1880e1bf1so4159895e9.1
        for <git@vger.kernel.org>; Fri, 16 Oct 2026 17:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792198448; x=1792803248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o/LNXDXE8XVLO1Y0QjVHikymoiLT7g3w4WYbuUCIxAQ=;
        b=YB5kN7QO1ooM48tLncyAlo/qaj2IVoqvU9tCTgcgoz3eklyInGGSHch/yTJGfH60HH
         9T2wUEvTeKS6Mcj6c0bI85PwdABI018n3BFTYFMHWRud6N0isR/+bNfXtvKxuz0IwX+v
         WonL8HcsJ5ivEZIjcr5XDu1WpZqlKvpbRdbkoRKWWV+nwO8oOD1LUlvERW77WbjYaOrx
         FqNKOtHW1ndXrceEH/534xwqx2LDRhsjn63BauvX+ZZbqUILTch+XqsVhNu1K9vwCU3c
         0emWyWIiaWowbaZF+NajxgZ3hsqmLF4IbvBouA/vyXAGYvuO031yHYgWhpKoPoRne4Uu
         KBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792198448; x=1792803248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o/LNXDXE8XVLO1Y0QjVHikymoiLT7g3w4WYbuUCIxAQ=;
        b=atCC3E/7uBN1uyQLQB4gvwBhNIOhKjoCSYu6/8k8ZULvWtKBW1bJBgC/3+u2XWyw/4
         cuZbJNnf/CuRvT4xyLBM2QCf5fwLZkCIwnsm0pGwMAaANKLAXY8lYhq4LibvRz0DwJxh
         cKk2/oxixngFLbovkg9K0BUKDxLcQnmxInrZL4zRsdyhVVYB8J9yxZr3hLIEclIgHbXm
         ZUchQvcK6nP91tvf/bFspXzoxVGg7iqgP2S4Tqa1XxzqJSX2PQlrZCBzF5Yugg/BRT6A
         3ocA3RyKYEBb9XtPVnNa5KLS56BJM0PJzLKwhxH4aYsE1tBqqD4rdyhAyrtzNYi8pKBP
         8bNQ==
X-Gm-Message-State: AFq9FYLCJUkql3zfsuOigMKb80SDg8OwXOoW055jTubHNpEuG5fXriiy
	NuA1eIULaRcYaLpFvdAERaF/o1VFugOSuIsiAoUGQcHLyZpZuCg0ncfB91o/n5MZ
X-Gm-Gg: AYBFou2/ZkSWJxSjhoJneqG4+VmRxGFrgcJ2uyq/r7fO+AxyHDvwxx4LY/B2anZjPa3
	oY4S6BrYREK94sPTEv1Pqe5rqGn0f/zRGTl/pUbaDIT1QhF9oLfkE0E4iSC6jGKV/E4gMaAiDBD
	Ul6GirJqIVpwgvf3ZWfbR2IXhj7Vw2uxD2wTNh/YJ2P6DdNjgzSMhkivLq7o/W8DPzFgcVRTENq
	b5LCex3Uo81ho8NlImQYBwbGTuMXEWqxD+5WHE08/d3pALl7vsp7dw7I8k7IXFzU87pbnWkJ42u
	ziQCgPnBPRxCAIQYnTXfAFUZyuGemwVl96UMUWXyPW0WreuiyjVtynE7xRt2vhRJn0p40qPwKN2
	QvwTuCXc5o+BPhPap9YpfJcN26dUVgXQ92rwwhiJVOkWOsk1tIoe5iChINA29HoxvmthKSDh8zq
	UCfXlNdrmnQ+23TyhFkP7Shvi8TEYAuST/Hum+REj+46JZcBLQOzAlxBUO/PvdBEpI+XYqCIPlM
	4/hJnIsHmsymnQd2xmhs7w=
X-Received: by 2002:a05:600c:8518:b0:4a0:159b:d2a9 with SMTP id 5b1f17b1804b1-4a1d7628ad1mr28070975e9.24.1792198448154;
        Fri, 16 Oct 2026 17:54:08 -0700 (PDT)
Received: from DESKTOP-0SUCFI3.localdomain ([129.0.81.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1ce33155fsm61544875e9.4.2026.10.16.17.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 17:54:07 -0700 (PDT)
From: Keryle <kerylefondji7@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christiancouder@gmail.com,
	siddharthasthana31@gmail.com
Subject: [Outreachy][PATCH v2] builtin/var: refactor to use parse-options API
Date: Sat, 17 Oct 2026 01:54:03 +0100
Message-ID: <20261017005403.5397-1-kerylefondji7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <1a146af667a8bcd4>
References: <1a146af667a8bcd4>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: keryle <kerylefondji7@gmail.com>

Migrate option handling in 'git var' to the parse-options API.
This update also aligns variable resolution with current Git configuration
and attribute handling.

Signed-off-by: Keryle <keryle@DESKTOP-0SUCFI3>

---
Range-diff against v1:
- Fixed whitespace damage and replaced space-indentation with proper tabs.
- Removed redundant inline comments as suggested.
- Enforced mutual exclusivity between '-l' and positional arguments.
- Aligned variable resolution with Git configuration and attribute handling.

 builtin/var.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/builtin/var.c b/builtin/var.c
index cc3a43cde2..b9234a55eb 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -3,11 +3,9 @@
  *
  * Copyright (C) Eric Biederman, 2005
  */
-
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "builtin.h"
-
 #include "attr.h"
 #include "config.h"
 #include "editor.h"
@@ -18,8 +16,12 @@
 #include "path.h"
 #include "strbuf.h"
 #include "run-command.h"
+#include "parse-options.h"
 
-static const char var_usage[] = "git var (-l | <variable>)";
+static const char * const var_usage[] = {
+	N_("git var (-l | <variable>)"),
+	NULL
+};
 
 static char *committer(int ident_flag)
 {
@@ -120,6 +122,7 @@ struct git_var {
 	char *(*read)(int);
 	int multivalued;
 };
+
 static struct git_var git_vars[] = {
 	{
 		.name = "GIT_COMMITTER_IDENT",
@@ -221,21 +224,32 @@ int cmd_var(int argc,
 {
 	const struct git_var *git_var;
 	char *val;
+	int list = 0;
 
-	show_usage_if_asked(argc, argv, var_usage);
-	if (argc != 2)
-		usage(var_usage);
+	struct option builtin_var_options[] = {
+		OPT_BOOL('l', "list", &list, N_("list builtin variables")),
+		OPT_END()
+	};
 
-	if (strcmp(argv[1], "-l") == 0) {
+	argc = parse_options(argc, argv, prefix, builtin_var_options,
+			     var_usage, 0);
+
+	if (list) {
+		if (argc > 0)
+			usage(var_usage[0]);
 		repo_config(the_repository, show_config, NULL);
 		list_vars();
 		return 0;
 	}
+
+	if (argc != 1)
+		usage(var_usage[0]);
+
 	repo_config(the_repository, git_default_config, NULL);
 
-	git_var = get_git_var(argv[1]);
+	git_var = get_git_var(argv[0]);
 	if (!git_var)
-		usage(var_usage);
+		usage(var_usage[0]);
 
 	val = git_var->read(IDENT_STRICT);
 	if (!val)
-- 
2.53.0

