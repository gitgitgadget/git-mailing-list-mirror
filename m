Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CA3C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 20:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241191AbhLGUX5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 15:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241211AbhLGUXv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 15:23:51 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E13C061748
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 12:20:20 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d9so168250wrw.4
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 12:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QhRn6jR12SaRa1vJe/8gWJ/ery4FebNCuFjH2tRz29c=;
        b=ByBQA31mz1jM3/IcA794GWOpajPT2VXIAch68CPKVstFe+OOYIxsjEQNRf/sVcLJAy
         GNxNbYfGWk2wTEF2hiy6ThYM1eZK3TlkcbEhAH3M+1hNZPGC9L9sIRvP4gW/VnlT0E1e
         G7Z8YG+dwxqg5O8PHypaaAJ3wSaO3P4zN7z6Zt0iqbK8bo3043JUJnxhpdgPqD/yUA6F
         eh+tG6Umu91yAYfWm3qmMGdfD+XkK2Ai0JI5Boz9Pg4dLmwqYx96bdHlT1E7gplkeJKz
         dKFtix+ObTFNPGUNiIWWo2FUPlQR8p2RfoU5rWyTjeilkWWUVb27xlwhVY+olw0fP1+A
         w1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QhRn6jR12SaRa1vJe/8gWJ/ery4FebNCuFjH2tRz29c=;
        b=FO2uyNtWOvxGZ+GwtKXqZ31+h8RSgsv+n9e16V9AeHWw0YgNuE6fUwXyaYzfxNWvw+
         4vk9ADu/PV3ExrDmE22CDrGZAJ6kgGI6KLORJEp+ngMlFZSVr8StlUr6j/dWKmjhBK0Q
         PmEQOyRS+AzRPvXgrLdeefbwqu11QARuN+ERk0iCeigq7T7lMQd6T9MAUyCXdGrlUwjI
         xmxPrQdmIqRJKvaAfr/Jq+Cv+beS4xQu/HwMw4nU5Ron9bBoALLj2m7J7rJJsMcHoZAw
         +fpefvW2V5FTy0Uu66f+OdyNgclaCGDFlmYdVA4JwEcPWU4dzxfpZPXL1rsbD6vQZTXr
         BKwA==
X-Gm-Message-State: AOAM531sG2djzcfyxqmf6wzZA5i5vcHVvo8FMlTQDNnuYLbfNznTVtkS
        2IP+wC+LdRVfR4a/46QaMfY3rHLFxqY=
X-Google-Smtp-Source: ABdhPJz9ibDHaPtJ9m65fc1gkkeYTtc1TzgCXwELhD1wn0b/wyRY5P7Hmo0Pgy1GIaakzMvCmDKlXg==
X-Received: by 2002:a5d:6849:: with SMTP id o9mr53093754wrw.515.1638908419019;
        Tue, 07 Dec 2021 12:20:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v6sm3724767wmh.8.2021.12.07.12.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 12:20:18 -0800 (PST)
Message-Id: <922a65b4019c599e7491135fe088f20fccddb628.1638908410.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1151.v2.git.git.1638908410.gitgitgadget@gmail.com>
References: <pull.1151.git.git.1638648020.gitgitgadget@gmail.com>
        <pull.1151.v2.git.git.1638908410.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 20:20:09 +0000
Subject: [PATCH v2 09/10] Documentation: clarify/correct a few sparsity
 related statements
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-clone.txt           | 8 ++++----
 Documentation/git-sparse-checkout.txt | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 3fe3810f1ce..b348a71fc68 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -167,10 +167,10 @@ objects from the source repository into a pack in the cloned repository.
 	configuration variables are created.
 
 --sparse::
-	Initialize the sparse-checkout file so the working
-	directory starts with only the files in the root
-	of the repository. The sparse-checkout file can be
-	modified to grow the working directory as needed.
+	Employ a sparse-checkout, with only files in the toplevel
+	directory initially being present.  The
+	linkgit:git-sparse-checkout[1] command can be used to grow the
+	working directory as needed.
 
 --filter=<filter-spec>::
 	Use the partial clone feature and request that the server sends
diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index c7a25e282e7..aca36782cef 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -121,7 +121,7 @@ SPARSE CHECKOUT
 It uses the skip-worktree bit (see linkgit:git-update-index[1]) to tell
 Git whether a file in the working directory is worth looking at. If
 the skip-worktree bit is set, then the file is ignored in the working
-directory. Git will not populate the contents of those files, which
+directory. Git will avoid populating the contents of those files, which
 makes a sparse checkout helpful when working in a repository with many
 files, but only a few are important to the current user.
 
-- 
gitgitgadget

