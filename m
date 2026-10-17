Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57771F2B8D
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 11:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792236437; cv=none; b=fqQBXR+AW23LPC/iiGyVu/Z6jIMWGBQGDaUMbwpqw0c3A8wg0Bxrl5TTnjQ3F7fGQFknAI1Hewmhl+qAkh1Hi8JacVSMoxY3Xc5ttm5v9i72rFjUljzkU8rJBLWf2Y0++4118hO+4h01J7yLPYgLteuRu2cB4jZe+jQ3L6bCIjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792236437; c=relaxed/simple;
	bh=botoM93QMiEmOqnmNn8gcITplqyAgddA7aycL0j//jU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yt9QaID7UbHpS4Ee+a3WygxaAkz3Lnjfb8l0Tm7ezf7c4xqkvh0VU1gSr+y4zUqnXslA5CvWCIr7K1m+YGqdzlDZ5LyN/0ZCDW9kiiQgtykelLyc1/aTMr9flJ8G/BuZD2LtRi/IaDNAoQbGXwqNwQFxcE6un37BtCZ02dELSEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLsL1qZb; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLsL1qZb"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a021c809e3so7333185e9.0
        for <git@vger.kernel.org>; Sat, 17 Oct 2026 04:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792236433; x=1792841233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U5bk8sLjLX2rUrlsqgZCX103LoG6DvIhAQBlkgtxrAY=;
        b=PLsL1qZb4RbqAh+Mli/59uII+P3mk0YY3NREEb2Tf5Mi3rfmyVJA30mMAt/6EwVcTz
         4RVRGNtKgKouB+2aeC8iPl52TFsS8wrtLOH+PKIP1hB9hdO/Wpzqf95CS7m2uxbE2hb8
         rUuGCc1+cGJkSc6XpurmRmCzq5sLPlcAu3UlQ6FinggCmgjhKsPivf0pAd5bLDrYF37a
         PZ2hSL1aK2TH24h4+s61bJZXuDllsVM6ZOtPgBJeUMNd+rhqvH2AQ1JcZ2PCPZuCXFZe
         duLHmJRlfBRPynXxiEYbEcSWVjUZYaoMEU1PRHI5K4uZ3pdAYNWQW6EwuuF6xF99wpIA
         AgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792236433; x=1792841233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U5bk8sLjLX2rUrlsqgZCX103LoG6DvIhAQBlkgtxrAY=;
        b=o1Ncvf0abecSVkQy+aJSlOVhMa/6YU/fVHBSMb6wqRVwmsfCOlxP4rN9H4w+k0STmc
         vQPCymhqYe7TSooCZKwdH3Rqk8fVdYSWn1EWlXF7zkuWWPSzSYoFFn6SFQPQohi3I6Oq
         mMaKmUTcu7F5yxIRmAWYnpc+01MdYdXkUAxmpEzn4m4UEtdLi0/58MRUxdianOSaIYq2
         p+/L4coQbIpiORfOHHj2sQn/ueRV2G305N2NtbdcEJFipNUI8gS5+js0Iu5/yZX/XiRK
         hC2gspU1rafe+NTl9Coy00Yq6hQATLpIK19mJB5M6F9Wb1zcOWddhRBBwWbIYkrrhGyq
         IIuA==
X-Gm-Message-State: AFq9FYLpKRC0P+v/T2Zfrs9CsDMmC3SQpibvGEX2tQ0kUA/eQLzcV9vl
	GGkROrsVq2EfHWWp1slz+0DqkMSI+wXmnAysnVKV1ePq57ayvp/A4442
X-Gm-Gg: AYBFou19ozXPq/LJXSZXh+U2GaUjywMoMPy36fVyU+qVH5DVFXpKw8uhmO0L+3lK1Su
	4xiJYWSgyj1nXKbO9j79HFbKpxjXT01YAc2vPRm39QRIfgDQjdCCeK9GHd4O0KL3DXzwslRpQlG
	aipaMiTe2VRHGyGqel6+TSQLZ4jvQshil3reqkFrgn+iHOVZFe88BmpKC47PwcRn0zw3OnhABkY
	w+R1z0PeOs5UQNrw/vMCk4gpMBjhmW/1n1nveBXBrxnEpi2cQOT/nVEqfbzzgJKCuyn61C+Dj0m
	NQUQvNh6fwbgQzoUH901svfyObw8isipPIEjEtzkdjF9GzNel+5kSdPQlQvscZxXY7goAr9iJ2b
	gRUIymqNPIhirpIuL40eI+e6h+0K80LHB3eJJ55H7diyBHCRbVI19UVXk+0eb9lD+p2Aj4uBqbm
	IW+dhe/WA/QtYeUqadO/RJnkARfYjn29SiZEDEjDIvhyjmkDw87KytQcyWOvQF9PQeRwp/vXvGV
	AlXzI4q78FdHY1g79IPx68=
X-Received: by 2002:a05:600c:820e:b0:4a0:174:579e with SMTP id 5b1f17b1804b1-4a1d761637amr46972445e9.28.1792236433281;
        Sat, 17 Oct 2026 04:27:13 -0700 (PDT)
Received: from DESKTOP-0SUCFI3.localdomain ([129.0.81.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd91c55bsm194244515e9.0.2026.10.17.04.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 04:27:12 -0700 (PDT)
From: kerylefondji7@gmail.com
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	christiancouder@gmail.com,
	siddharthasthana31@gmail.com,
	kerylefondji <kerylefondji7@gmail.com>
Subject: [Outreachy][PATCH v2] builtin/var: refactor to use parse-options API
Date: Sat, 17 Oct 2026 12:25:09 +0100
Message-ID: <20261017112518.4548-1-kerylefondji7@gmail.com>
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

From: kerylefondji <kerylefondji7@gmail.com>

Migrate option handling in 'git var' to the parse-options API.
This update also aligns variable resolution with current Git configuration
and attribute handling.

Signed-off-by: Keryle Blondeau Fondji Tamekong <keryle@DESKTOP-0SUCFI3>
---
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

