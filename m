Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C64AC6FA82
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 02:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiITCqu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 22:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiITCqq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 22:46:46 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8804D255
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 19:46:45 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id bu5-20020a17090aee4500b00202e9ca2182so525781pjb.0
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 19:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=XzI/zQUfgF1N2/RGvSTGnHk23nyk7H/1FdpWg/44QP8=;
        b=BVSPNIKhvMtjMFhXBRFeUgkh2jwhSZ6JNdAIf5nQ1oe50t+j7YaCmTmxlyNIn7AHKW
         MR5ltFLmiY9LIZkpC4UfQJ+VyzchsPEGJYb1K8Mbume6jLFh+iVmiB5UeqSPS04BYBw5
         Bc1jaw1St2gkbsMeq+sDRHrdB4+sFC4v3ht6jboCWsI4Ug0J2KZc+ToDKDYXi/PRa2wr
         jChHjox0UwlWwdJH0kFXzQnFLsIQ/f5Rw9JMbmpdPDHN3PHvV/jIj4jcN+ZBqT+aERfF
         46+n22E9a2UQy9sNLhhOKvAgGUjzHND6YLPZobtnM6O1WZRWVQLSzXHR0xlw2TaHFPq3
         Vh0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XzI/zQUfgF1N2/RGvSTGnHk23nyk7H/1FdpWg/44QP8=;
        b=SNM/bQ8PY1AA5Yju77La5wMgwLrE1OOuwaHM2NNBaKWz4biilPpA+XiruCsrvi7nX/
         PG3vTxldGz3OdD4n2hrvFKpSK07/lcbY3JjB5EocPNVHoCUqvQmOFAceX7PyLNT83/eE
         KDnbgeu+37bGOfoH/brpKEWUuEYimQbJdSwohsS9GuCAXnsph8kRRS892FsfxG5JGOcu
         FOyVzTEep2r28WMz7H67qt9ytsEqbaW4B5tbqmMxtblVu0EWVCAdKGroMRsf/A8ib3y6
         Nc8wlZrD4d2Sa9lr2S+5uVXsTWGgzznuaEyf+MdzNFGy4LpqRfOsoKJhgO/BQdc7m/ab
         JsRA==
X-Gm-Message-State: ACrzQf2ba6tujptLphtY/l5JziLOeMdHSJoHdQ6XrysJ9NLLfuI8dk00
        X/7jWgni0HMsgcp9YBVuWJss9pbdx397n5Oc
X-Google-Smtp-Source: AMsMyM5xaZYMceol0cP8YiCul2Pg0uBUI8ewZbww0m8pymmN3gRbbIfPH85ILBIf0duNrcom/fR5eA==
X-Received: by 2002:a17:902:b907:b0:178:9d11:c978 with SMTP id bf7-20020a170902b90700b001789d11c978mr2802242plb.90.1663642004884;
        Mon, 19 Sep 2022 19:46:44 -0700 (PDT)
Received: from localhost.localdomain ([2600:8801:9c0a:f300:a972:1d85:8e93:c538])
        by smtp.gmail.com with ESMTPSA id m14-20020a62a20e000000b00537aa0fbb57sm146471pff.51.2022.09.19.19.46.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Sep 2022 19:46:44 -0700 (PDT)
From:   Jacob Stopak <jacob@initialcommit.io>
To:     git@vger.kernel.org
Cc:     Jacob Stopak <jacob@initialcommit.io>
Subject: [PATCH 2/2] Documentation: clean up various typos in technical docs
Date:   Mon, 19 Sep 2022 19:45:57 -0700
Message-Id: <20220920024557.22889-3-jacob@initialcommit.io>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220920024557.22889-1-jacob@initialcommit.io>
References: <20220920024557.22889-1-jacob@initialcommit.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Used GNU "aspell check <filename>" to review various technical
documentation files with the default aspell dictionary. Ignored
false-positives between american and british english.

Signed-off-by: Jacob Stopak <jacob@initialcommit.io>
---
 Documentation/technical/api-parse-options.txt   | 2 +-
 Documentation/technical/bundle-uri.txt          | 6 +++---
 Documentation/technical/commit-graph.txt        | 4 ++--
 Documentation/technical/remembering-renames.txt | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index c2a5e42914..61fa6ee167 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -60,7 +60,7 @@ Subcommands are special in a couple of ways:
 
 * All arguments following the subcommand are considered to be arguments of
   the subcommand, and, conversely, arguments meant for the subcommand may
-  not preceed the subcommand.
+  not precede the subcommand.
 
 Therefore, if the options array contains at least one subcommand and
 `parse_options()` encounters the first dashless argument, it will either:
diff --git a/Documentation/technical/bundle-uri.txt b/Documentation/technical/bundle-uri.txt
index c25c42378a..8939655fc0 100644
--- a/Documentation/technical/bundle-uri.txt
+++ b/Documentation/technical/bundle-uri.txt
@@ -290,7 +290,7 @@ expect that the process will end when all prerequisite commit OIDs in a
 thin bundle are already in the object database.
 
 When using the `creationToken` heuristic, the client can avoid downloading
-any bundles if their creation tokenss are not larger than the stored
+any bundles if their creation tokens are not larger than the stored
 creation token. After fetching new bundles, Git updates this local
 creation token.
 
@@ -319,7 +319,7 @@ Here are a few example error conditions:
   Git's other HTTP protocols in terms of handling specific 400-level
   errors.
 
-* The server reports any other failure reponse.
+* The server reports any other failure response.
 
 * The client receives data that is not parsable as a bundle or bundle list.
 
@@ -447,7 +447,7 @@ created every hour, and then once a day those "hourly" bundles could be
 merged into a "daily" bundle. The daily bundles are merged into the
 oldest bundle after 30 days.
 
-It is recommened that this bundle strategy is repeated with the `blob:none`
+It is recommended that this bundle strategy is repeated with the `blob:none`
 filter if clients of this repository are expecting to use blobless partial
 clones. This list of blobless bundles stays in the same list as the full
 bundles, but uses the `bundle.<id>.filter` key to separate the two groups.
diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
index f05e7bda1a..90c9760c23 100644
--- a/Documentation/technical/commit-graph.txt
+++ b/Documentation/technical/commit-graph.txt
@@ -40,7 +40,7 @@ Values 1-4 satisfy the requirements of parse_commit_gently().
 
 There are two definitions of generation number:
 1. Corrected committer dates (generation number v2)
-2. Topological levels (generation nummber v1)
+2. Topological levels (generation number v1)
 
 Define "corrected committer date" of a commit recursively as follows:
 
@@ -48,7 +48,7 @@ Define "corrected committer date" of a commit recursively as follows:
     equal to its committer date.
 
  * A commit with at least one parent has corrected committer date equal to
-    the maximum of its commiter date and one more than the largest corrected
+    the maximum of its committer date and one more than the largest corrected
     committer date among its parents.
 
  * As a special case, a root commit with timestamp zero has corrected commit
diff --git a/Documentation/technical/remembering-renames.txt b/Documentation/technical/remembering-renames.txt
index af091a7556..1e34d91390 100644
--- a/Documentation/technical/remembering-renames.txt
+++ b/Documentation/technical/remembering-renames.txt
@@ -407,7 +407,7 @@ considered to be "irrelevant".  See for example the following commits:
 		no longer relevant", 2021-03-13)
 
 Relevance is always determined by what the _other_ side of history has
-done, in terms of modifing a file that our side renamed, or adding a
+done, in terms of modifying a file that our side renamed, or adding a
 file to a directory which our side renamed.  This means that a path
 that is "irrelevant" when picking the first commit of a series in a
 rebase or cherry-pick, may suddenly become "relevant" when picking the
-- 
2.37.3

