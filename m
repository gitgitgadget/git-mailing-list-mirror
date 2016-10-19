Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5558820986
	for <e@80x24.org>; Wed, 19 Oct 2016 20:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756435AbcJSUnC (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 16:43:02 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34984 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752113AbcJSUnB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 16:43:01 -0400
Received: by mail-pf0-f180.google.com with SMTP id s8so21813345pfj.2
        for <git@vger.kernel.org>; Wed, 19 Oct 2016 13:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=u+3l7oLBte7Iau1xIV6eoRLpskTrdCc1tvGka59ZqcM=;
        b=aw/TLqwovCESAj9g6UuBExa727vBSj4Spv91r0IV2eN7eO8rjb8ODHuvwn7Y1EFp8w
         6yLZ8mINGjSL3m79Jiu0elQx2RCmfYKn/+/n4dxro5h+rHScYuCwa8ujPMsIYoJAdWvL
         7hh+Hu+hw563UJFGOxTtcWyG7JIlWUXYqA1yZulRi1SelfKSr1be4NuH5GzjoGdztepg
         HEOk1ezxX3UI/0JOqdc6ykAJspF39vx2SjulQM2/qchOtW14CzOs7lwqpROwQvOOIX3O
         qlw1aakYwLz7/aPkOMNhZkv3biMpauk7s7FE0j/fnucORmhkT5t3gIbCHIDI7gQXE0/6
         VDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=u+3l7oLBte7Iau1xIV6eoRLpskTrdCc1tvGka59ZqcM=;
        b=YbLFdGI0Fim+CO+6f59J3hsXdsA2Y5zTbVawX7qD/xYaLZQmtdjOD9VrvAOfY7Ayqw
         2lfcuCMRt9RWd1C78FRaieaEcslUs1fpyBu7mlywAYSKybxmgQOzyrH9s19NrCESYPma
         YpziKEopmkQD+HUotDl3RQmT93D/1MeVWdF/1XzfmPHb8PFE7xSZwuJQDyl0f20i8w//
         zrUK866mNWCENM8dGvrL+QcsPHciesoPBcPv4vQ2CI68ccvNSpMQikv3hZ0X9Pak4rll
         mvnsN7nHLn8SBDob5cy9YZkWizFZ0OdawJnabZ5ymUtcs4ig/xM/710mf8PkuQBhKj/O
         kK3w==
X-Gm-Message-State: AA6/9RlkkcxLdobPxpn+2SrwQF/5wAmxxy9QSWZUDXTyM5HCR89pP9I4SjZXH1idbigg84M7
X-Received: by 10.98.93.83 with SMTP id r80mr7436270pfb.17.1476909780577;
        Wed, 19 Oct 2016 13:43:00 -0700 (PDT)
Received: from nalthis.roam.corp.google.com.com ([172.19.37.93])
        by smtp.gmail.com with ESMTPSA id d8sm65896486pfg.56.2016.10.19.13.42.59
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 19 Oct 2016 13:42:59 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH] submodules: update documentaion for submodule branches
Date:   Wed, 19 Oct 2016 13:42:54 -0700
Message-Id: <20161019204254.97659-1-bmwill@google.com>
X-Mailer: git-send-email 2.10.1.484.gd4ef107
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update the documentaion for the the special value `.` to indicate that
it signifies that the tracking branch in the submodule should be the
same as the current branch in the superproject.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/git-submodule.txt | 4 +++-
 Documentation/gitmodules.txt    | 7 +++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index bf3bb37..d841573 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -259,7 +259,9 @@ OPTIONS
 --branch::
 	Branch of repository to add as submodule.
 	The name of the branch is recorded as `submodule.<name>.branch` in
-	`.gitmodules` for `update --remote`.
+	`.gitmodules` for `update --remote`.  A special value of `.` is used to
+	indicate that the name of the branch in the submodule should be the
+	same name as the current branch in the current repository.
 
 -f::
 --force::
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index 10dcc08..8f7c50f 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -50,8 +50,11 @@ submodule.<name>.update::
 
 submodule.<name>.branch::
 	A remote branch name for tracking updates in the upstream submodule.
-	If the option is not specified, it defaults to 'master'.  See the
-	`--remote` documentation in linkgit:git-submodule[1] for details.
+	If the option is not specified, it defaults to 'master'.  A special
+	value of `.` is used to indicate that the name of the branch in the
+	submodule should be the same name as the current branch in the
+	current repository.  See the `--remote` documentation in
+	linkgit:git-submodule[1] for details.
 
 submodule.<name>.fetchRecurseSubmodules::
 	This option can be used to control recursive fetching of this
-- 
2.10.1

