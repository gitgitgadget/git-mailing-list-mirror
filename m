Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1356820248
	for <e@80x24.org>; Thu, 21 Mar 2019 13:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfCUNRN (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 09:17:13 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38513 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbfCUNRN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 09:17:13 -0400
Received: by mail-pg1-f193.google.com with SMTP id v1so4171014pgi.5
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 06:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IT/XadOQGFJG/UF7iaJ90cH9I8hu+AtsezvGthI2kXI=;
        b=M9F/KD5RA+DHW0nDS+XQYfy/q6dy4St6dGUwl3FQlASw0Q1TWEkVN/ZaqbyOXyIWLA
         2CXObr4IQUVBVYDaz5DnmpDRgLlRkhFn2PJZPi/KAmHt/nV7G1jLxIdcs7KhNFc8zwRQ
         bGAVY2nBJxEpnOkAOETmE0Xet6g3+EUHULlB/2sa8bLtWcKb4CcKKfoDIua8QFW/pByg
         Z0KITILbCh2pjrEx03UojLnxd+R0sP4NW34PKkFThNJl958NhTnfAjq4g5Em1UVaLnzD
         NjuzKuxl+c7aeLrlC/tewheycMTDhe55OV6WlzmMsuQ4b+iM/RROZ614UZXIWb/L/G2O
         XnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IT/XadOQGFJG/UF7iaJ90cH9I8hu+AtsezvGthI2kXI=;
        b=pqiC5fg6I6c8jOWomqOB5KWjhEU3jMmmK0MIx5En855jhhNJkEjYtOldiCUNCvRDA7
         xAvgWR9UNE+E37lilocNR8h/2UhyuVX4QefiXv5aLXvJiIqK6yzD7nmqD1WCDRNNSHec
         JFEiN/Pt8F1uOG557v8bhoxU1POfXp4i1QlmKUgxJcYJeOAY08o5WVqW0um9ktRfy6PK
         /dKn8W4A6HwXFTBe5cfIkN60pbiSvfju4BQhFmfinL3c+vHlhCjBEiIfU42yCyMll+/u
         6rllLAFVS1KFDhtU80rNwW0FjWw5/8Zo4L+G1WyySIvCzf9D15V1N1da++jZCGCVgUW8
         SCew==
X-Gm-Message-State: APjAAAVt++seQrSr59ojKJ4QZ73NnJCruOCywMA2SgH4TLcxA7WmcYOb
        gjvlTQYaFRKPoLHWNgdHh3eA/eaC
X-Google-Smtp-Source: APXvYqyabcI3s+j2AWTEDQ8LRItmLE/sv53hhxx1v7JjLykbqgCCIfQ+qJb9T2crOOydeShldIpgFg==
X-Received: by 2002:a63:3fc8:: with SMTP id m191mr3302086pga.240.1553174232260;
        Thu, 21 Mar 2019 06:17:12 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id o76sm13697730pfa.156.2019.03.21.06.17.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 06:17:11 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Mar 2019 20:17:05 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v5 01/26] git-checkout.txt: spell out --no-option
Date:   Thu, 21 Mar 2019 20:16:30 +0700
Message-Id: <20190321131655.15249-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190321131655.15249-1-pclouds@gmail.com>
References: <20190317124926.17137-1-pclouds@gmail.com>
 <20190321131655.15249-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's easier to search for and also less cryptic.
---
 Documentation/git-checkout.txt | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index f179b43732..99c8c0dc0f 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -118,7 +118,8 @@ OPTIONS
 --quiet::
 	Quiet, suppress feedback messages.
 
---[no-]progress::
+--progress::
+--no-progress::
 	Progress status is reported on the standard error stream
 	by default when it is attached to a terminal, unless `--quiet`
 	is specified. This flag enables progress reporting even if not
@@ -262,7 +263,7 @@ edits from your current working tree. See the ``Interactive Mode''
 section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
 +
 Note that this option uses the no overlay mode by default (see also
-`--[no-]overlay`), and currently doesn't support overlay mode.
+`--overlay`), and currently doesn't support overlay mode.
 
 --ignore-other-worktrees::
 	`git checkout` refuses when the wanted ref is already checked
@@ -270,7 +271,8 @@ Note that this option uses the no overlay mode by default (see also
 	out anyway. In other words, the ref can be held by more than one
 	worktree.
 
---[no-]recurse-submodules::
+--recurse-submodules::
+--no-recurse-submodules::
 	Using --recurse-submodules will update the content of all initialized
 	submodules according to the commit recorded in the superproject. If
 	local modifications in a submodule would be overwritten the checkout
@@ -283,7 +285,8 @@ Note that this option uses the no overlay mode by default (see also
 	Do not attempt to create a branch if a remote tracking branch
 	of the same name exists.
 
---[no-]overlay::
+--overlay::
+--no-overlay::
 	In the default overlay mode, `git checkout` never
 	removes files from the index or the working tree.  When
 	specifying `--no-overlay`, files that appear in the index and
-- 
2.21.0.548.gd3c7d92dc2

