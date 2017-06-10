Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1E121FAEB
	for <e@80x24.org>; Sat, 10 Jun 2017 13:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752127AbdFJNk6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 09:40:58 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34014 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752038AbdFJNku (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 09:40:50 -0400
Received: by mail-qt0-f195.google.com with SMTP id o21so19589718qtb.1
        for <git@vger.kernel.org>; Sat, 10 Jun 2017 06:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kvve6ybX3LyHsK6l2M9W00c/STZCi3uXauQhoORotmg=;
        b=COWtB/27DNE9nGnwsI6QTECrVf0xAGfakgIdiIvVeFYwpyCC9b+i+gRh0xZO3a5+JX
         8WTo36c6u30/ydno8Kekf+7sL0DJbVhJzSr26brBv/NhrThAG81yN7fk9M1jVUQpkx4q
         d9jf+phfl9pO6gF8Ht7n9GuVgGz6yF59TAfb6ulJmyubokKJxbs3pft2BlIlJBv95P57
         nREWONmN47c3cB/npc9GW8TW7gM/AfMJC3u+0eaZykDfyyZE3XRtPP00Er2/0OlJuC2E
         1FAOJsbgZUqRPZ4t1t0fIiDiGwEYQRTcg6En7YpS9ZD0SBlL0J4vTfh1VwyanEVV63+V
         VEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kvve6ybX3LyHsK6l2M9W00c/STZCi3uXauQhoORotmg=;
        b=BXWIxeudfgCi7i5VVGBEo42NWXgV2+0K86Mx7ZOGCBFDKketEjTES4jza4IO42onmB
         YnpAswwF1ZBc7HfS5U/leTJGSO0fjaEgi86scVrGc7VSzgxGXRL8OtBIwXBBCLJI+QIN
         DTga/WOF4H48NuadAN0eIXcEpgurR8YVzKm1898mfL69syvxppwsw3bzTKRca7CQP85D
         mqGFTgnbdIj6GEijxOY/G50wDggWMkPYjpZ7W6Yh45Dd4TM9XG9w1QhRqQlY9H2FU5LM
         Jx3Wnb5uQOiYpNL3cLO6vnROsUPVQeLBNVcaYZ4YoYK8rQaaYWcMXWAcZZkY/wEVkvfz
         s2iQ==
X-Gm-Message-State: AKS2vOx8dNThOJGhS4nteyLj5qvZEBe0OdodiL29wB2NNArapFomRElq
        ovYjxUZQzc4lTHlFuQg=
X-Received: by 10.200.51.173 with SMTP id c42mr20013385qtb.71.1497102049177;
        Sat, 10 Jun 2017 06:40:49 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id f94sm2707503qtb.16.2017.06.10.06.40.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 10 Jun 2017 06:40:48 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net, christian.couder@gmail.com, avarab@gmail.com
Subject: [PATCH v5 5/7] fsmonitor: add documentation for the fsmonitor extension.
Date:   Sat, 10 Jun 2017 09:40:24 -0400
Message-Id: <20170610134026.104552-6-benpeart@microsoft.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170610134026.104552-1-benpeart@microsoft.com>
References: <20170610134026.104552-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This includes the core.fsmonitor setting, the query-fsmonitor hook,
and the fsmonitor index extension.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 Documentation/config.txt                 |  7 +++++++
 Documentation/githooks.txt               | 23 +++++++++++++++++++++++
 Documentation/technical/index-format.txt | 19 +++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index dd4beec39d..d883e3318c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -410,6 +410,13 @@ core.protectNTFS::
 	8.3 "short" names.
 	Defaults to `true` on Windows, and `false` elsewhere.
 
+core.fsmonitor::
+	If set to true, call the query-fsmonitor hook proc which will
+	identify all files that may have had changes since the last
+	request. This information is used to speed up operations like
+	'git commit' and 'git status' by limiting what git must scan to
+	detect changes.
+
 core.trustctime::
 	If false, the ctime differences between the index and the
 	working tree are ignored; useful when the inode change time
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index b2514f4d44..219786b2da 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -456,6 +456,29 @@ non-zero status causes 'git send-email' to abort before sending any
 e-mails.
 
 
+[[query-fsmonitor]]
+query-fsmonitor
+~~~~~~~~~~~~~~~
+
+This hook is invoked when the configuration option core.fsmonitor is
+set and git needs to identify changed or untracked files.  It takes
+two arguments, a version (currently 1) and the time in elapsed
+nanoseconds since midnight, January 1, 1970.
+
+The hook should output to stdout the list of all files in the working
+directory that may have changed since the requested time.  The logic
+should be inclusive so that it does not miss any potential changes.
+The paths should be relative to the root of the working directory
+and be separated by a single NUL.
+
+Git will limit what files it checks for changes as well as which
+directories are checked for untracked files based on the path names
+given.
+
+The exit status determines whether git will use the data from the
+hook to limit its search.  On error, it will fall back to verifying
+all files and folders.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/technical/index-format.txt b/Documentation/technical/index-format.txt
index ade0b0c445..7aeeea6f94 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -295,3 +295,22 @@ The remaining data of each directory block is grouped by type:
     in the previous ewah bitmap.
 
   - One NUL.
+
+== File System Monitor cache
+
+  The file system monitor cache tracks files for which the query-fsmonitor
+  hook has told us about changes.  The signature for this extension is
+  { 'F', 'S', 'M', 'N' }.
+
+  The extension starts with
+
+  - 32-bit version number: the current supported version is 1.
+
+  - 64-bit time: the extension data reflects all changes through the given
+	time which is stored as the nanoseconds elapsed since midnight,
+	January 1, 1970.
+
+  - 32-bit bitmap size: the size of the CE_FSMONITOR_DIRTY bitmap.
+
+  - An ewah bitmap, the n-th bit indicates whether the n-th index entry
+    is CE_FSMONITOR_DIRTY.
-- 
2.13.0

