Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C68E3209FD
	for <e@80x24.org>; Thu, 25 May 2017 18:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1036419AbdEYSg7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 14:36:59 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34191 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424845AbdEYSgq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 14:36:46 -0400
Received: by mail-qk0-f195.google.com with SMTP id u75so31081090qka.1
        for <git@vger.kernel.org>; Thu, 25 May 2017 11:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h2bAKPDvErCZhjI5ZMyyl7XA0+dlw9U6toXatJWB5fE=;
        b=TqbMMVFqV86uHeJiYkbax0hTsik+wO1FhWwLFrocVF+PRHdMrgy0Ft9Dg+Jq6Klcin
         8RIxx3HpAgVqQDkco7viDLhBZf1B6b4VozcesQt6aIzqL0cFkn4RS5Fal0oVs1nj3VFn
         rMgYjhLzxEb61teyYGos1wZ04N3ThUryKXXxG4e5WZnVSRJbwRgMkmJ67icK/855ybrg
         vW8zKE8NXFh6MMt3pIKD870k02ZBEBnZ0m8F8iaOc6ksMfLFWUul4CXJ7PvwjzOnfrv+
         zoclVKkCwg3oSP3SPTqUBWJvDH/llDJEEFdf8VSIWKy6yhGBBEyAbZ2WGTCXiKQdfHlV
         dXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h2bAKPDvErCZhjI5ZMyyl7XA0+dlw9U6toXatJWB5fE=;
        b=F2B0aLI7bwtPjBl2PUJWj1ESGKXG5+nP6EDcSRDB0q0OQ/EUFBwn2gO2wUmBIrA75a
         N275CGzodPIO8nwAPDrESsNESrygYptXrsdR9IlJsjDwxZcmRSxBHnIuENXyoxvNJ2xT
         LBdWUpSxRTM1MPezUPZ8vECNaPd+UYzWYY8jUkrW5umvdFGzED9cXIfzrohr/C+gTi4p
         /q7NghzzD0u7JOkDxW42ZjweCkFd/oizaAi3AtajpiELiz2lc/ednOP/edEbxERg0QrG
         Vydo99O+hDR3hX74iblm4BfoTSuT5g0EvHbSqxfS9nRykTloU6ShiS9rCYYJPYZZjnqE
         t39w==
X-Gm-Message-State: AODbwcBknk4zRQc4yuJHJhAQ4d0itsUpyMwVjTjsFie8LGE7TRRCTfwB
        h2FEozrLo1t4MDpkGd4=
X-Received: by 10.55.40.158 with SMTP id o30mr38987784qko.210.1495737405002;
        Thu, 25 May 2017 11:36:45 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id j66sm5089231qte.26.2017.05.25.11.36.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 May 2017 11:36:44 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net
Subject: [PATCH v3 5/6] fsmonitor: add documentation for the fsmonitor extension.
Date:   Thu, 25 May 2017 14:36:11 -0400
Message-Id: <20170525183612.3128-6-benpeart@microsoft.com>
X-Mailer: git-send-email 2.13.0.windows.1.9.gc201c67b71
In-Reply-To: <20170525183612.3128-1-benpeart@microsoft.com>
References: <20170525183612.3128-1-benpeart@microsoft.com>
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
index e0b9fd0bc3..5211388167 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -389,6 +389,13 @@ core.protectNTFS::
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
index 706091a569..48127e8729 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -448,6 +448,29 @@ The commits are guaranteed to be listed in the order that they were
 processed by rebase.
 
 
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
2.13.0.windows.1.9.gc201c67b71

