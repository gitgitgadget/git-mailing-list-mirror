Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F77F2047F
	for <e@80x24.org>; Mon,  7 Aug 2017 21:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbdHGVTt (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 17:19:49 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33582 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752094AbdHGVTs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 17:19:48 -0400
Received: by mail-pf0-f195.google.com with SMTP id c65so1468509pfl.0
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 14:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3KPVOT2picinBERO1EvOrb7cfpMHlduj0wRoBLm7Mbk=;
        b=SwRjpl5gNdKIIHdnUKV038sue2U0Pir7ULb/mApeZ4zr5HnjLx4mDVAwzMxBhTR3mR
         tlRPUNHIydefXHFEktWCf9E0x8kLGnvTM3cH2MNZxTHTTkx4344TQ6UzFZ3Kklz0d+NF
         O1+pYdNEkhu5Q/dcDl9m9efGJVuD4HfUF0pIarT6c/fquT4dIO0aN2+ofMLcuB//78Ko
         0zoVRh0JmJEvxHFKXNGhwLebEKebC446KOKG+MdvEtXMsXQG/tYNTp9c2+U7OAdcyZq3
         h6UnllFnX/zJ8UzUrH+RPPiTHQu7AIn4CdHa1kwnd2QlrsdDwFjFj8MaPUgAiRbNwe3N
         v7DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3KPVOT2picinBERO1EvOrb7cfpMHlduj0wRoBLm7Mbk=;
        b=LtWzgt8xbjYZyVyMnKD66ScBEmjs7YJVyiyvmrl8nwcZNW8iNLB1Hroqcf+YB1R7VK
         mhvRLoXfKkBWiHmhKWSH4TwCjUndEi8pcXjvGXj09+iuNQ4KGCjoq+Ksn0uBWlbJkD3C
         hdCgObsCIOXdbrNsX9I2y3OTpO3I2MANn2bCcVe+HLcobLGt1FqOTpe8ViJG1LiTZY/H
         Vst7U9gVgIiKmwg+3roXEZca2Um+Vmwy6Nhrhg/Jr2deigmvPPVrBofTwKQLBXXaJmm0
         Iywf9gAt0qPmGIy80HB/ONFAq/mTI4+3K1OxDfGY9tprBLeM7W1DDrB1h6EbVZwIWb+v
         fWMw==
X-Gm-Message-State: AHYfb5hkx2f6DQH/byEz+97wgZ4fu1C03Qag8GWLgi/5E4r1mkxtjv2N
        ReWfbewiwBNrTLoc/Gc=
X-Received: by 10.84.232.197 with SMTP id x5mr2045351plm.329.1502140787589;
        Mon, 07 Aug 2017 14:19:47 -0700 (PDT)
Received: from localhost.localdomain ([2405:205:6016:3285:fd77:5453:49e2:f3b5])
        by smtp.gmail.com with ESMTPSA id z127sm15141084pfb.64.2017.08.07.14.19.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Aug 2017 14:19:47 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 10/13] submodule foreach: document '$sm_path' instead of '$path'
Date:   Tue,  8 Aug 2017 02:48:57 +0530
Message-Id: <20170807211900.15001-11-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170807211900.15001-1-pc44800@gmail.com>
References: <20170807211900.15001-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As using a variable '$path' may be harmful to users due to
capitalization issues, see 64394e3ae9 (git-submodule.sh: Don't
use $path variable in eval_gettext string, 2012-04-17). Adjust
the documentation to advocate for using $sm_path,  which contains
the same value. We still make the 'path' variable available and
document it as a deprecated synonym of 'sm_path'.

Discussed-with: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
 Documentation/git-submodule.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index ff612001d..a23baef62 100644
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
2.13.0

