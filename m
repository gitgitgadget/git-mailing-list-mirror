Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA0021E0BD
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 06:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744784117; cv=none; b=cxKSS/aZ/U+ANctidlm5Io2COfqj/XhmltOIdsTOFgYaHQnkTUeg3sDhKArQJhrIsOYGkBv5foGLRt0NjNC+//BJ7KCb42HOuwXmvblidhFGM+g7Be4eLMopdD0l3FF2jBOpe/KbSUQr9xN5TDgcdRqF+rM/5dwufqoEqm+4Yh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744784117; c=relaxed/simple;
	bh=ibSDkZP8h4Aowwv2Wmr+5SGgCt2PK2cfPZdLG7gSOeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gXean9tQ3dqk1DHrSMZBSm374541e0vP/q7Y3emxGtlHm3Am7Efdgq4c6D1i2cOwuNXtM3sEFkzHGo3HgTfXtNBV5a+DwkimbFJplk9ZGzon7kIQVCl8H566Om4pBMdf5cNRCB8Po5K+8+r57Io15hZ0u+0BTEp5odsE9wO/soY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1ZOBC5+; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1ZOBC5+"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ad51f427054so4592447a12.1
        for <git@vger.kernel.org>; Tue, 15 Apr 2025 23:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744784115; x=1745388915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yzjDLeLF9Lg3pgu0G4beDbywxt+pseBSz7qvSfZpe3U=;
        b=E1ZOBC5+Jih8HA5LjuVB0EhrKkdmJyj+hl0rcrDhDNofO3nyR/GHtcPM6Q4XLDfBMI
         NwDMZ03Zcs3OUhJ/RTCZrPwfiPgzMvrlsWpDwx5J/H+Uc29XT97AOLJUVEIsRCAK2Is0
         Ran+fqa2/ewdVzh3+BqNPmhxPCg/XPS4tnjJUKKeHfy3qIP+rlbWlV7o9SKXs7ghQ7mB
         GTtMwAfzEQ99M6cXyF14UEE+C9v59sf7nvhRVG7i2Q/g+bZ8L+iS+pQ4eQQNDJn9k6gt
         uz6LaF6YD3HroOPi+Nuincx31cQJ5ergISGmL+lUFfgzOGHgFjUDhl4TWLhkzPc4eDQy
         x4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744784115; x=1745388915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yzjDLeLF9Lg3pgu0G4beDbywxt+pseBSz7qvSfZpe3U=;
        b=aaGWFNrq+2ghcPA9VjScDd8ziVFZnwEZOe3BPz7WEwuUdh8WxpRC9N0c+0tWUgffdz
         7hZ5B6xpKwUA9kljGL/GhpMap7gor/Whl76rfG7nzzCJCScz/C6J3ak2qqFWTlqOz3mR
         oVz5LS/QUcG7xVmI0sn3PEhviYxQiw577XyCCvwSPbHA9OIt3ovkG6SuVR+aEaSLIjTz
         Di3Vtgb+jJTnJjrKGmXXeywIGLq3b5pQmu2zZ5ZKWZ7Y7UQga6hQxjokIPz6sFYjyTul
         JhDuBE3N0+HPdIXiDok8KQqksFAPaRU3/6/sDsENmyGctlHBzamPqFyOjbr9A94xa95X
         Mmiw==
X-Gm-Message-State: AOJu0Yz9WhufAzLyen61vhYWZVU0XTJYAsFsVP0Ye0mIgA8spFZ+jRNt
	6Fz5aUK22lt3Lrz8lOx1bWGyW37JZz8JqVqqAWknRvUJz3QCJU66doAgmw==
X-Gm-Gg: ASbGncs0Zk/AId2XZzEZF2D8hpSyVIj9YEv9iR86/5kExcm5+5wd9/AfXLUjO4kyTfs
	2Vegif5dlPYs6sPU2mwkaeE0mINc81r0SejmY947OcMzq52LCOr2is08XDRSeqMIr+lmDm9f0cr
	ddfIx/IE5+uKBgJrvZUnqYilmQ51o2r4irHcNsjo9FvP5iRIU09HkfTXKM86y+V/ZtmoPPWHo15
	sf9kRDyGvpW7FKdmW/YtonQBAgdYfrl/Yt0l1x4mJgRHtpKz8dUecSvmBUIhsAohlyFentLmG6e
	JBZFpCB3VVngCWwhU5H97nBfzwdenBMHZUJYClo5Z2wTy5Hck/U6OV3ekvzUNqAuYq1Y
X-Google-Smtp-Source: AGHT+IFoxKpA4K66j4cC87IxjxO67nx4xE197+ZCNzlItP3V7uKZpDFmEAYijQ4jCtEGhKIikoIbcw==
X-Received: by 2002:a17:90a:da8d:b0:2ff:6fc3:79c4 with SMTP id 98e67ed59e1d1-3086415ea4amr827757a91.27.1744784114644;
        Tue, 15 Apr 2025 23:15:14 -0700 (PDT)
Received: from fedora.. ([2405:201:c005:b018:5522:eab2:4cba:30d0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-308537cdb13sm1688603a91.0.2025.04.15.23.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 23:15:14 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	jayatheerthkulkarni2005@gmail.com
Subject: [PATCH 3/4] Docs: Add cmd_psuh with repo and UNUSED removal
Date: Wed, 16 Apr 2025 11:44:49 +0530
Message-ID: <20250416061450.25695-4-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <20250416061450.25695-1-jayatheerthkulkarni2005@gmail.com>
References: <20250416061450.25695-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit improves the `cmd_psuh` documentation example by:

Correcting the function signature to include struct repository *repo.
Makes the signature accurate and consistent with typical Git built-in
commands.

Removing the `UNUSED` macros from the `cmd_psuh` function arguments
(argc, argv, prefix, repo). This is done because the example now
uses these arguments.

Showing how to access the repository's Git directory (repo->gitdir)
within the cmd_psuh function. This provides a practical example of
how to use the repo argument and repository-related information.

Keeps your existing printf() calls in place.
This lets the users see the arguments which is given to the function.

This enhanced example provides a more complete illustration of
Adding a Git built-in command and use the repository argument.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/MyFirstContribution.adoc | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index b463d42f63..ed6dcc1fc6 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -158,7 +158,7 @@ declaration for `cmd_pull`, and add a new line for `psuh` immediately before it,
 in order to keep the declarations alphabetically sorted:
 
 ----
-int cmd_psuh(int argc, const char **argv, const char *prefix);
+int cmd_psuh(int argc, const char **argv, const char *prefix, struct repository *repo);
 ----
 
 Be sure to `#include "builtin.h"` in your `psuh.c`. You'll also need to
@@ -174,7 +174,8 @@ Throughout the tutorial, we will mark strings for translation as necessary; you
 should also do so when writing your user-facing commands in the future.
 
 ----
-int cmd_psuh(int argc, const char **argv, const char *prefix)
+int cmd_psuh(int argc UNUSED, const char **argv UNUSED, 
+			const char *prefix UNUSED, struct repository *repo UNUSED)
 {
 	printf(_("Pony saying hello goes here.\n"));
 	return 0;
@@ -287,10 +288,14 @@ on the reference implementation linked at the top of this document.
 It's probably useful to do at least something besides printing out a string.
 Let's start by having a look at everything we get.
 
-Modify your `cmd_psuh` implementation to dump the args you're passed, keeping
+Modify your `cmd_psuh` implementation to dump the args you're passed
+and removing the UNUSED macro from them, keeping
 existing `printf()` calls in place:
 
 ----
+int cmd_psuh(int argc, const char **argv, 
+			const char *prefix, struct repository *repo)
+{
 	int i;
 
 	...
@@ -305,6 +310,14 @@ existing `printf()` calls in place:
 	printf(_("Your current working directory:\n<top-level>%s%s\n"),
 	       prefix ? "/" : "", prefix ? prefix : "");
 
+	if (repo && repo->gitdir) {
+        printf(_("Git directory: %s\n"), repo->gitdir);
+    } else {
+        printf(_("No Git directory found.\n"));
+    }
+
+	...
+}
 ----
 
 Build and try it. As you may expect, there's pretty much just whatever we give
-- 
2.49.GIT

