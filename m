Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A472C77B73
	for <git@archiver.kernel.org>; Sat,  6 May 2023 04:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjEFEOS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 May 2023 00:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEFEOQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2023 00:14:16 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECCB76AA
        for <git@vger.kernel.org>; Fri,  5 May 2023 21:14:14 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f19afc4fbfso25151485e9.2
        for <git@vger.kernel.org>; Fri, 05 May 2023 21:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683346452; x=1685938452;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hu6e3KviOPRL2jdf9EMb3DFEZivv5cBHb9qJFuDv0Ho=;
        b=IjBBXLJu/3LVhEDixtduY59EDgfSGCUv3tS5FYSTE9ClAesakFx91ONURhEDURhMbl
         f48FukREhnuA4jayR84WWvrLvaV1mYdLT/0VgSXdhMFXikZAmh9EldzaIep5+TuNTcOb
         aa+EcUQcld76YRmss7GIJFStEQlrUfeL6PYxIRT9H4ifKj2uIiNTNj+Y6Ns6w9bfVlAT
         LHQDQ9XiUHixZ2/XgAT29o1XuE+9dCO8S82mPyJ0lXgkpuewNAMx08jjFdbgC8Tg7nU6
         os90EP7paqbwE/emQYUg5mftue4K/DWeJ09rOjMvUa+sfzxDltBGIUCNjWqc9aUS5t0N
         V7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683346452; x=1685938452;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hu6e3KviOPRL2jdf9EMb3DFEZivv5cBHb9qJFuDv0Ho=;
        b=Us2I337di+ZIPDACVuekYwHIb/cFCdJ34DJo5pY+mQiDaxspNQ6OXOaD5JusqLZr0Z
         icftJi/Bg/Naotx+tS1g0UhwaHo537qilBMnZHBw4nj15xYT9ILJgkDMb5Fcp7R8YBEg
         MVC1/dgvrBD14NVt0qQuak2jPnjWATozejilwcK2PG/r6YTw8svDjqFrOAcGcSEclwOv
         nrslptZVfsoazX2nN06rmP09cS8bekAMsb0lYUiQqsG+0vLZZoqWjvmnbCez/lrVD8hU
         Lw0qGm/3tav2SVJPW+Q0TzfHr5wu7qGJMSSJGlWs5MUxUCVphaskeiyJXiqbvTwUjRT+
         HFZQ==
X-Gm-Message-State: AC+VfDwO57qKr/MxNy1Xd8aQwZCGx6rvtdIrM1iaSuwbzHEDPF41Tf2A
        6LxtWbwRtEclHq8bYX9mvm4mpCQSmlU=
X-Google-Smtp-Source: ACHHUZ7tyeeEVkUW9xvm5nudl29fMU8zOIYxGfuAH0YZyGtUACS0iAcjNP4T7rEPjxkdyRYTlouckA==
X-Received: by 2002:a5d:5003:0:b0:306:3408:f9a8 with SMTP id e3-20020a5d5003000000b003063408f9a8mr2654738wrt.11.1683346452506;
        Fri, 05 May 2023 21:14:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x8-20020a1c7c08000000b003f24f245f57sm9515180wmc.42.2023.05.05.21.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 21:14:12 -0700 (PDT)
Message-Id: <pull.1225.v3.git.git.1683346451239.gitgitgadget@gmail.com>
In-Reply-To: <pull.1225.v2.git.git.1683314270964.gitgitgadget@gmail.com>
References: <pull.1225.v2.git.git.1683314270964.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 06 May 2023 04:14:11 +0000
Subject: [PATCH v3] name-rev: make --stdin hidden
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

In 34ae3b70 (name-rev: deprecate --stdin in favor of --annotate-stdin),
we renamed --stdin to --annotate-stdin for the sake of a clearer name
for the option, and added text that indicates --stdin is deprecated. The
next step is to hide --stdin completely.

Make the option hidden. Also, update documentation to remove all
mentions of --stdin.

Signed-off-by: "John Cai" <johncai86@gmail.com>
---
    name-rev: make --stdin hidden
    
    Now that --stdin has been deprecated for several releases, the next step
    of replacing name-rev --stdin with --annotate-stdin is to make --stdin
    hidden. This patch also updates documentation to get rid of any mention
    of --stdin.
    
    Changes since v2:
    
     * Added a reference to --stdin in the docs

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1225%2Fjohn-cai%2Fjc%2Fhide-name-rev-stdin-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1225/john-cai/jc/hide-name-rev-stdin-v3
Pull-Request: https://github.com/git/git/pull/1225

Range-diff vs v2:

 1:  904cd2c3572 ! 1:  dbba7c4373b name-rev: make --stdin hidden
     @@ Documentation/git-name-rev.txt: SYNOPSIS
       
       DESCRIPTION
       -----------
     +@@ Documentation/git-name-rev.txt: OPTIONS
     + 	Transform stdin by substituting all the 40-character SHA-1
     + 	hexes (say $hex) with "$hex ($rev_name)".  When used with
     + 	--name-only, substitute with "$rev_name", omitting $hex
     +-	altogether.
     ++	altogether. This option was called `--stdin` in older versions
     ++	of Git.
     + +
     + For example:
     + +
      @@ Documentation/git-name-rev.txt: The full name after substitution is master,
       while its tree object is 70d105cc79e63b81cfdcb08a15297c23e60b07ad
       -----------


 Documentation/git-name-rev.txt | 11 ++++-------
 builtin/name-rev.c             |  6 +++++-
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
index ec8a27ce8bf..5c56c870253 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git name-rev' [--tags] [--refs=<pattern>]
-	       ( --all | --stdin | <commit-ish>... )
+	       ( --all | --annotate-stdin | <commit-ish>... )
 
 DESCRIPTION
 -----------
@@ -46,7 +46,8 @@ OPTIONS
 	Transform stdin by substituting all the 40-character SHA-1
 	hexes (say $hex) with "$hex ($rev_name)".  When used with
 	--name-only, substitute with "$rev_name", omitting $hex
-	altogether.
+	altogether. This option was called `--stdin` in older versions
+	of Git.
 +
 For example:
 +
@@ -70,10 +71,6 @@ The full name after substitution is master,
 while its tree object is 70d105cc79e63b81cfdcb08a15297c23e60b07ad
 -----------
 
---stdin::
-	This option is deprecated in favor of 'git name-rev --annotate-stdin'.
-	They are functionally equivalent.
-
 --name-only::
 	Instead of printing both the SHA-1 and the name, print only
 	the name.  If given with --tags the usual tag prefix of
@@ -107,7 +104,7 @@ Now you are wiser, because you know that it happened 940 revisions before v0.99.
 Another nice thing you can do is:
 
 ------------
-% git log | git name-rev --stdin
+% git log | git name-rev --annotate-stdin
 ------------
 
 GIT
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 593f0506a10..4d15a23fc4d 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -573,7 +573,11 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 				   N_("ignore refs matching <pattern>")),
 		OPT_GROUP(""),
 		OPT_BOOL(0, "all", &all, N_("list all commits reachable from all refs")),
-		OPT_BOOL(0, "stdin", &transform_stdin, N_("deprecated: use --annotate-stdin instead")),
+		OPT_BOOL_F(0,
+			   "stdin",
+			   &transform_stdin,
+			   N_("deprecated: use --annotate-stdin instead"),
+			   PARSE_OPT_HIDDEN),
 		OPT_BOOL(0, "annotate-stdin", &annotate_stdin, N_("annotate text from stdin")),
 		OPT_BOOL(0, "undefined", &allow_undefined, N_("allow to print `undefined` names (default)")),
 		OPT_BOOL(0, "always",     &always,

base-commit: 69c786637d7a7fe3b2b8f7d989af095f5f49c3a8
-- 
gitgitgadget
