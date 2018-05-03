Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73782200B9
	for <e@80x24.org>; Thu,  3 May 2018 00:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751885AbeECAyX (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 20:54:23 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36425 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751747AbeECAyR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 20:54:17 -0400
Received: by mail-pg0-f66.google.com with SMTP id z129-v6so7685243pgz.3
        for <git@vger.kernel.org>; Wed, 02 May 2018 17:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u8ZSM5oMV9yHgDHEzFOhEbd/MlZCC2fYJZqG2NjdLwY=;
        b=GJat/DYcfn+fLeN3QiZwbemp4XuZECdNC7uZ13fDNuuTheD5N3wKPd/bi6bd7ujO5k
         jUC5Of2WqFYqQkecjArpUxYJ47T3wKNeQt1sVgbSFrcBbcQBUE7sVkvy29YIvPo6OBXG
         aN3B4EYUcvjup9sUoet/H7aSDsGf9iWRi/h8zc/LBT7J+RDVYWWCMlHBjiqWZ+vnJk5L
         H2abZPXKdGqZy1WJLfXeRDp8t7wbbQL7fJWME2qwVIOJqPs2vptbvNaH5vEpS092xVWy
         d349dmaO18eoxfhhUFNsKAKCvgC7TsxTORrqIn8Z6SnkAtQ5rN/bHkwLOX/vxtx1Nei/
         fCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u8ZSM5oMV9yHgDHEzFOhEbd/MlZCC2fYJZqG2NjdLwY=;
        b=WrVAR8wOUdu8Rb27GBVbV9qluq5JdThTGgHSSd/xboOpwWD18IRSejf2QBXbDp/Ix7
         L5/Suia6bFi3GIJdWnJ9a2FqTnlwi3uGUKR/O7z0qiej41Gp3r//kk4B4fqjrAqu+aJg
         iRmDHZKNc+KE754UhMYu1spNkrt/HWQGR8LaD4HYUVty2lJgofT36TVYNKuirxFEm8z6
         GYVKaSR42Myl5cKVHUGA5q2kFxK8PMraZWIkARqNy7knX/t16pxQPB37zGgUBgzP46PS
         syN+a2iDLMh8khx44RtC4zBsicTv2/HEV3L9pvZpZPxwGUEuyohn0a/ybCo1CkWpHDiM
         Qwfw==
X-Gm-Message-State: ALQs6tCQzRs4SAculjqTOsnNG1ErYMnIMt7T3dSk+r0A6ZmP1vcglF8F
        14HkQHhrJQ1Qhykpox+nqOG6ew==
X-Google-Smtp-Source: AB8JxZqhEIRXyRGtIUGa4MPgrqhNwd5puU44PGS/aDEmU325bXEIrMVgoNA6kWOzus+Q6tyu2PCz5A==
X-Received: by 10.98.58.148 with SMTP id v20mr8480648pfj.90.1525308856396;
        Wed, 02 May 2018 17:54:16 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id y15sm25029923pfb.37.2018.05.02.17.54.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 May 2018 17:54:15 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        christian.couder@gmail.com, pc44800@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/5] submodule foreach: document '$sm_path' instead of '$path'
Date:   Wed,  2 May 2018 17:53:55 -0700
Message-Id: <20180503005358.89082-3-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180503005358.89082-1-sbeller@google.com>
References: <20180503005358.89082-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Prathamesh Chavan <pc44800@gmail.com>

As using a variable '$path' may be harmful to users due to
capitalization issues, see 64394e3ae9 (git-submodule.sh: Don't
use $path variable in eval_gettext string, 2012-04-17). Adjust
the documentation to advocate for using $sm_path,  which contains
the same value. We still make the 'path' variable available and
document it as a deprecated synonym of 'sm_path'.

Discussed-with: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-submodule.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 71c5618e82a..755ed695f08 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -183,12 +183,14 @@ information too.
 
 foreach [--recursive] <command>::
 	Evaluates an arbitrary shell command in each checked out submodule.
-	The command has access to the variables $name, $path, $sha1 and
+	The command has access to the variables $name, $sm_path, $sha1 and
 	$toplevel:
 	$name is the name of the relevant submodule section in `.gitmodules`,
-	$path is the name of the submodule directory relative to the
-	superproject, $sha1 is the commit as recorded in the superproject,
-	and $toplevel is the absolute path to the top-level of the superproject.
+	$sm_path is the path of the submodule as recorded in the superproject,
+	$sha1 is the commit as recorded in the superproject, and
+	$toplevel is the absolute path to the top-level of the superproject.
+	Note that to avoid conflicts with '$PATH' on Windows, the '$path'
+	variable is now a deprecated synonym of '$sm_path' variable.
 	Any submodules defined in the superproject but not checked out are
 	ignored by this command. Unless given `--quiet`, foreach prints the name
 	of each submodule before evaluating the command.
-- 
2.17.0.441.gb46fe60e1d-goog

