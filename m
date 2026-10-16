Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A9443C051
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 20:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792184270; cv=none; b=CSfMABlFbEOs+hwLMdxHxpbT7Tf70i/eoSOL8s4+rgWt/+G89XWzkanrd5Mty/c9elYvYIN01OqN82EVkwVz3e3bsRNXvyfz95q/15bGrV2bVHPtu42y1ykTq61S67F9zLpn5DsX78QtB8ZKRf8dJ8j3Ho9IH/DR71jQtLXwyks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792184270; c=relaxed/simple;
	bh=bpgkI4P9pggb3D52IxIPnTZODRgNVpxFQXNzGQRiUuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ob+nDWZ/JIEkkwZtYiVOuKOXFvkPSV01vIhXaHbogqzIUHzEQZ2uyqzR13sTztEd8qOdj3lk7c3meBBMeu+MTPVo19BXWqRWFE+yoEoD553HoQIbSLmknocNW5QMfvTSylbTJx/kjSR3f7ilG3JL2VwX8b7U7/+OuI3VDoFMhdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2r7M0YJ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2r7M0YJ"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a0213948d3so2740255e9.2
        for <git@vger.kernel.org>; Fri, 16 Oct 2026 13:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792184265; x=1792789065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=q/MtL0rSa1KCnvVWFJXbIS95MgazG2i7w5ZvSDO/kVc=;
        b=A2r7M0YJqOVO2BgPBRJfG8XppkQfPBZrRp17lEP37UYhFAgj0SgEQWNAOj83JZi2sU
         oLxi3YNjxTGfL6wKxp5132WabRUnaxfSWeg8Jw5KrSr3NJ/nRL8xJ7f/xtmFjjR2Vpzf
         MM9oyMkHFAhBNbEMzxGjcD1KTXPiEsSLfgbIak3sUu1cgGAbd0/sqmg00b3MNOeWxnkU
         eVmHaiD7D5InpgsDfodf5GgCPubZ0QmhD8N0wiPUTGYPEB3F5JVKV15EiOLORFaJGKWx
         leWsxfw5RfJRfeU1pXAdDU8uNxPHDrO5u1HNQb0M53gJeWuAa8GC3sKa5HP2QsLP0Xdl
         xxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792184265; x=1792789065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q/MtL0rSa1KCnvVWFJXbIS95MgazG2i7w5ZvSDO/kVc=;
        b=nQIqomk0lBR4D+O2iWudRM2WQV5n96kx8o8HUbNFBNmZmEWfv3tp3BQXN9Wy5AM48U
         bd0aIplfv4kB+r4Sey8gLOrh1yXiwbbNJtmjOgy4biUzjnAqRscy/wD1PNj2bmdnuluy
         uYMHUF922k7Tp/MtFsEWmiP6vIJWlprXIAGN95QB52gOhngn6oYQ4EkdDEAlLmxbYiEQ
         n/JBiwEtW7WrxIj5+9aI2Nk4Xj+YJSrGnGhnBd1sSC45cgPwE6E/XHiTX1I4SflomQ5Z
         VrhqSqlhLDe+oU4njS8Zx7ItALzNgEx5kV4lHkmK2I+oA1IPMcExbh4Es/eOP2oJ1ogx
         StFg==
X-Gm-Message-State: AFq9FYK1MNmesG4wrj4FV3S3QQuq1X8JsZHH37zwX7qsJeS1QR7LgF//
	29zp4o4tizPfXohz46GVmPRTmJ1DhpG9WMyqJ2AZPC1KIhMLk/x6Nzp97T8wUigS
X-Gm-Gg: AYBFou1Gssz32HEG15krokwZFyBMqObb1B2oVUrblbb+4aaHbTjc0tClQ8Cgnt+EXO2
	zB34nZp94jAtRqw/HU+8XT4h3v+wjbBnq0IHAHT2Ngyhvm0jim29AHuReSXPiUcw5jEnZH9I3in
	XcYzVfaPJR9CpvlGqJ4Qo/qnilqT8PlJv9xBsFwpPGI/nad5W54GHZbaB2wUi2fIK/csZPwgQ2F
	1W1iSmvLZjojaPb2LtAZQXYSssnU+6QFmZADHfA4xy7hjll4DEmp1RY0nuoSvFzJpHZRtA1e4DE
	/dR/PSIxCQvgw+vkiLUh3tkAieS7EZfKw5SLdBUbQS57zZ9qsmuomWJrTUGRe+jJxisaAvT9/f7
	4QByrnGHCjh8XyjsCRH9nW6/JiXKEbbhoCzplECoNBgInKMbgazqkG1oRBt2bRyFffkg9OHY+4U
	jnEtLwcl77v5QqlDaWW4CuXSB9ZVswThoCmocegtp75bd1P/Y+ZsdeS8VZ9XJGKIU0NkqiccnO8
	s10mIvX6GNURWZ0vDdhsJ8=
X-Received: by 2002:a05:600c:19ca:b0:4a0:c01:1902 with SMTP id 5b1f17b1804b1-4a1d75acaf5mr20881935e9.2.1792184264506;
        Fri, 16 Oct 2026 13:57:44 -0700 (PDT)
Received: from DESKTOP-0SUCFI3.localdomain ([129.0.81.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8af2fcesm89116175e9.8.2026.10.16.13.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 13:57:43 -0700 (PDT)
From: kerylefondji7@gmail.com
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	kerylefondji <kerylefondji7@gmail.com>
Subject: [Outreachy PATCH] var: refactor to use parse-options API
Date: Fri, 16 Oct 2026 21:56:59 +0100
Message-ID: <20261016205659.4417-1-kerylefondji7@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: kerylefondji <kerylefondji7@gmail.com>

Refactor 'git var' command handling to use an existing API (parse-options API)
instead of ad hoc code for argument parsing.

Previously, the ad hoc code lacked proper validation for option
combinations. Specifically, listing all variables (-l) and requesting a
specific variable name are mutually exclusive operations, but the code
did not enforce this restriction, causing test failures.

This change:
- Includes the parse-options.h header and defines builtin_var_options.
- Adds an explicit check to ensure that combining '-l' with additional
  positional arguments correctly triggers a usage error.

All 27 automated tests in t0007-git-var.sh pass successfully.
---
 builtin/var.c | 50 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/builtin/var.c b/builtin/var.c
index cc3a43cde2..20ea4e0489 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -18,8 +18,11 @@
 #include "path.h"
 #include "strbuf.h"
 #include "run-command.h"
-
-static const char var_usage[] = "git var (-l | <variable>)";
+#include "parse-options.h"
+static const char * const var_usage[] = {
+	N_("git var (-l | <variable>)"),
+	NULL
+};
 
 static char *committer(int ident_flag)
 {
@@ -220,22 +223,39 @@ int cmd_var(int argc,
 	    struct repository *repo UNUSED)
 {
 	const struct git_var *git_var;
-	char *val;
+        char *val;
+        int list = 0; /* Flag to track if -l/--list option is used */
 
-	show_usage_if_asked(argc, argv, var_usage);
-	if (argc != 2)
-		usage(var_usage);
+        /* Define the accepted command-line options */
+        struct option builtin_var_options[] = {
+                OPT_BOOL('l', "list", &list, N_("list builtin variables")),
+                OPT_END()
+        };
 
-	if (strcmp(argv[1], "-l") == 0) {
-		repo_config(the_repository, show_config, NULL);
-		list_vars();
-		return 0;
-	}
-	repo_config(the_repository, git_default_config, NULL);
+        /* Parse options using the standard API */
+        argc = parse_options(argc, argv, prefix, builtin_var_options,
+                             var_usage, 0);
+
+        /* If the user requested to list all variables (-l) */
+       
+if (list) {
+    if (argc > 0)
+        usage(var_usage[0]);
+    repo_config(the_repository, show_config, NULL);
+    list_vars();
+    return 0;
+}
+
+        /* Ensure only one positional argument (the variable name) remains */
+        if (argc != 1)
+                usage(var_usage[0]);
+
+        repo_config(the_repository, git_default_config, NULL);
 
-	git_var = get_git_var(argv[1]);
-	if (!git_var)
-		usage(var_usage);
+        /* Retrieve the specific git variable (note: now at argv[0] after parsing) */
+        git_var = get_git_var(argv[0]);
+        if (!git_var)
+                usage(var_usage[0]);
 
 	val = git_var->read(IDENT_STRICT);
 	if (!val)
-- 
2.53.0

