Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37422205ACF
	for <git@vger.kernel.org>; Sat, 15 Mar 2025 18:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742062517; cv=none; b=Y5P9bOLy9XA3MfX4WSIzpRD7B4+GZ2+whr0EPZ+C42w2OLHuzzYPTNcN/RsddGPVsDAqgeB6cP9adphXNI6tFYLUvU8UllWE6qoI8ixICDLMywXdhw0yNtdBRkXuIwPp+z19oyKD3iuplBjmfKOOLGkkOxRqWczA669OuhFuKUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742062517; c=relaxed/simple;
	bh=A6ao4jgqLgWJiihjDe4WTxogNHeN0SizcfUywNqf6as=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dk3n7Bu6NXG4vQDzQVvSRnZMfyupmo3T17pHLtsFnF9mtwtMKo8t8DHMFj2Jz61Gv+AX9NUn6HzkI06X8h+gQp36OKoHf8aIyIfkiUcTC+n1ON7Xl1GLujX63mGiFjg3+oxulPx43g4VGdwY0xtSpONQ9ShmfG7OiC/QDi3JVoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUbPPypv; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUbPPypv"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22113560c57so1495725ad.2
        for <git@vger.kernel.org>; Sat, 15 Mar 2025 11:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742062513; x=1742667313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDstDvHAoMhU651BbLyiZkyQBhhcmDL/esNn3kE0xPU=;
        b=HUbPPypvt/gEKH/9uhVL3lVDdp6JNfmESmjkGdabsDQrUlyMBCr2qbMoEjDKQs+cbK
         WRMcl+nuKtt1ZWrUjwXkIPfv8LxmG/D094YaLjJpcMijHcWWgLHqaTMCX9OxE8wiJNUd
         rW6TZHlmLiOuhICDP0czxXFDZxF6iQOIJRAxX+sg8SksgzPTWbVHMncXFTphE11/q6YV
         o5Fa98U6MM86wYNvE3Ac7Q5FzxeGZOVuvoYxKmyA0NecLmFoqcxy8l1me4bALg9DKTPd
         xmL2Zr35fwLHySUEnz8u8uIpaaMFCzhBH9eHqiXZnMlOEx9wyxHz3kAtum/u5pdghCfL
         unUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742062513; x=1742667313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FDstDvHAoMhU651BbLyiZkyQBhhcmDL/esNn3kE0xPU=;
        b=h+JO2tCvHMFy8WdmDdLsLgN3R1Z7ZUBX+akrKY9koKSDshvQGQNQ1E+Qu2TDvEMyVX
         Jhp1MrFspAIaKZxQbNz3aWap8Um+rPXa/8OUewDTbPtDh60CNdEkQ0wSeOwR7qYJBJCS
         CmylCi2sjwbc3hGHJa4E2JW4zvrc8jMgI7JSsY3Aho2f8QV8+mu80EnFbBaFkztUvZdV
         SIt/Pz0rB12i+jUERUIkQ4AS9IMVV9tqghCo4AhcjSa7LEKoR70nnlq2AdEm2yRxSjGI
         kwLshO6pr1nUW7IoVGfU555WWxRt4NyN3WvOtZOSy1PwWXm29lc94Vn+1e0OJ6643MM/
         kKGw==
X-Gm-Message-State: AOJu0YyUoWQFbD9TwE+9d2wYnd9+hYUMjRpHySzKvt998Vho4ZStb6ei
	bZrSOVrXqgnI7/Ml7E9erp172hr49vh4/oUSrHgJgOIP4EDT1v2b/Kpszobz
X-Gm-Gg: ASbGncvWxD+UV4OmI/R/Hu/rG+sUXfwWiNSUSY1QyONyhzZy37S2oyDwzFisK0BmzjR
	17kXtF01D6S3qhSFFAY0fhJ663XD8+jsnOjF8PNZEMptnR6bpyEpli/m660KU8g8QC1MRG/3D01
	7yszwHjTCdUmOs2bv/pwxdQqviIswWX1gbjgBtVv3v8hC8ImUPyptXrnyuJtbhQK8yGKnNL6ddZ
	Y3Tl+VbR3uhDe24XCDZFqKJMLfJbanvBIVI2BQPND8EwTf2uFWndS0Dcvne6+5xJolQvnSW4OCB
	iNeVAspGGorAyKfwr9HX6DgC2I+M1UisEnCRFJNrE2oZ+aw525tQd3S+S5vXfi2emwmoNdjeegY
	er04=
X-Google-Smtp-Source: AGHT+IGAKnyZDiI6ONtllgbVhGY6gYYbmEUsV+ALx3YbTt7NjZew4ofjjH7mS+kK7vDk5K4tCbbSVQ==
X-Received: by 2002:a17:902:f54f:b0:220:c164:6ee1 with SMTP id d9443c01a7336-225e0ae6dcdmr71671945ad.32.1742062513232;
        Sat, 15 Mar 2025 11:15:13 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c005:b018:5841:514c:af52:5598])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4e0dsm47269775ad.221.2025.03.15.11.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 11:15:12 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: ben.knoble@gmail.com,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [GSOC][PATCH 2/3] Update function signature and UNUSED to include struct repository and modify builtin.h accordingly
Date: Sat, 15 Mar 2025 23:45:03 +0530
Message-ID: <20250315181504.65069-2-jayatheerthkulkarni2005@gmail.com>
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
 Documentation/MyFirstContribution.adoc | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index f7e510e6c1..34a0336898 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -142,9 +142,13 @@ followed by the name of the subcommand, in a source file named after the
 subcommand and contained within `builtin/`. So it makes sense to implement your
 command in `builtin/psuh.c`. Create that file, and within it, write the entry
 point for your command in a function matching the style and signature:
-
 ----
-int cmd_psuh(int argc, const char **argv, const char *prefix)
+int cmd_psuh(int argc, const char **argv, const char *prefix, struct repository *repo)
+----
+Before proceeding further, we should use the UNUSED macro to suppress warnings about unused parameters in the function.
+This prevents the compiler from generating warnings when certain parameters are not used within the function body:
+----
+int cmd_psuh(int argc UNUSED, const char **argv UNUSED, const char *prefix UNUSED, struct repository *repo UNUSED)
 ----
 
 We'll also need to add the declaration of psuh; open up `builtin.h`, find the
@@ -152,7 +156,7 @@ declaration for `cmd_pull`, and add a new line for `psuh` immediately before it,
 in order to keep the declarations alphabetically sorted:
 
 ----
-int cmd_psuh(int argc, const char **argv, const char *prefix);
+int cmd_psuh(int argc, const char **argv, const char *prefix, struct repository *repo);
 ----
 
 Be sure to `#include "builtin.h"` in your `psuh.c`. You'll also need to
@@ -168,7 +172,7 @@ Throughout the tutorial, we will mark strings for translation as necessary; you
 should also do so when writing your user-facing commands in the future.
 
 ----
-int cmd_psuh(int argc, const char **argv, const char *prefix)
+int cmd_psuh(int argc UNUSED, const char **argv UNUSED, const char *prefix UNUSED, struct repository *repo UNUSED)
 {
 	printf(_("Pony saying hello goes here.\n"));
 	return 0;
@@ -199,6 +203,9 @@ with the command name, a function pointer to the command implementation, and a
 setup option flag. For now, let's keep mimicking `push`. Find the line where
 `cmd_push` is registered, copy it, and modify it for `cmd_psuh`, placing the new
 line in alphabetical order (immediately before `cmd_pull`).
+----
+{ "psuh", cmd_psuh, RUN_SETUP}
+----
 
 The options are documented in `builtin.h` under "Adding a new built-in." Since
 we hope to print some data about the user's current workspace context later,
@@ -285,6 +292,8 @@ Modify your `cmd_psuh` implementation to dump the args you're passed, keeping
 existing `printf()` calls in place:
 
 ----
+int cmd_psuh(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
+{
 	int i;
 
 	...
@@ -298,7 +307,8 @@ existing `printf()` calls in place:
 
 	printf(_("Your current working directory:\n<top-level>%s%s\n"),
 	       prefix ? "/" : "", prefix ? prefix : "");
-
+	...
+}
 ----
 
 Build and try it. As you may expect, there's pretty much just whatever we give
-- 
2.48.1

