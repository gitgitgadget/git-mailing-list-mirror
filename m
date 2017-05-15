Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23E96201A7
	for <e@80x24.org>; Mon, 15 May 2017 19:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966359AbdEOTOV (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 15:14:21 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33995 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966317AbdEOTOS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 15:14:18 -0400
Received: by mail-qk0-f194.google.com with SMTP id u75so18966858qka.1
        for <git@vger.kernel.org>; Mon, 15 May 2017 12:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=om8M1LOtHqo+B6BTRqkC3v5wqqOj+yvAk5DbYQbBGk4=;
        b=ocKklKRh/TR/EMH2U8xAsEhbgcLSqj+TUPbkPZEcDtwUjv5264r1TrZfSb72kiAG4b
         EYZax9Q0eTjQ8aIs4vsPQMgCUrKnZDv6U9j14HuZfnIT1oySrRK5eRF5Kub5RROr5iy9
         oLsrDwm93Q0Sm8MLc6sMU8RFTHko3NGDI9ST7k/+OPWQtKMMIkEyuwwuF1AcBJqh60Dx
         ibXbgnxmOYDDvXNH41Z4ZFqAmnQ4ExtYGYbAVDUx3e2ZGs0g0IlwK+lS37u3TYnQumbr
         Ag2KT/4AZSh8iBIIjWTXVmyQFx0UENG1saBvb1rdRmEtqj2UzIrPYckn9JP+muUkdhgV
         4+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=om8M1LOtHqo+B6BTRqkC3v5wqqOj+yvAk5DbYQbBGk4=;
        b=cMgAHR3eTv8VaBkb6SvuuQC9QE4IuCtAZY2prqtLFaK782T0BMcxKzPl5XTryhdrmf
         EtEkUpPWnxGqR7bXZm21bi5qzl9HabbtkoNdoabPOR/S0o0AAG7wOw20BtarYx9Ru9Rp
         87G6ZzLPv0wCBJjO2zqJrw1gXsOVT9KfGb+kKknEbheE6x9Mvxo19gnxqdRmZdGuzLvO
         ryid9vSelsNVA34TNXOPwGfyBN3Kvwc1/38LbuJofYhAs+tDnudKI21z5D7XEaWEdaDu
         Ksq9ifVzBmoP2dCOQbnuOTtgv6WujGUAfcvaEhpw0lsrVs8LynQtxptePi/9iSkS67iC
         efLg==
X-Gm-Message-State: AODbwcD0V8orY5QRiAjDeUn/KCrZ0h89V/RTPdbRl6tjkyhjB4teMT8T
        52AcVQ5txjr58A==
X-Received: by 10.55.127.199 with SMTP id a190mr2394477qkd.100.1494875657570;
        Mon, 15 May 2017 12:14:17 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id 47sm9086903qts.26.2017.05.15.12.14.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 May 2017 12:14:17 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net
Subject: [PATCH v1 4/5] Add documentation for the fsmonitor extension.  This includes the core.fsmonitor setting, the query-fsmonitor hook, and the fsmonitor index extension.
Date:   Mon, 15 May 2017 15:13:46 -0400
Message-Id: <20170515191347.1892-5-benpeart@microsoft.com>
X-Mailer: git-send-email 2.13.0.windows.1.6.g4597375fc3
In-Reply-To: <20170515191347.1892-1-benpeart@microsoft.com>
References: <20170515191347.1892-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 Documentation/config.txt                 |  7 +++++++
 Documentation/githooks.txt               | 23 +++++++++++++++++++++++
 Documentation/technical/index-format.txt | 18 ++++++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bc7088b287..a9a58cb8a6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -391,6 +391,13 @@ core.protectNTFS::
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
index 706091a569..f7b4b4a844 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -448,6 +448,29 @@ The commits are guaranteed to be listed in the order that they were
 processed by rebase.
 
 
+[[query-fsmonitor]]
+query-fsmonitor
+~~~~~~~~~~~~
+
+This hook is invoked when the configuration option core.fsmonitor is
+set and git needs to identify changed or untracked files.  It takes
+a single argument which is the time in elapsed seconds since midnight,
+January 1, 1970.
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
index ade0b0c445..b002d23c05 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -295,3 +295,21 @@ The remaining data of each directory block is grouped by type:
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
+	time which is stored as the seconds elapsed since midnight, January 1, 1970.
+
+  - 32-bit bitmap size: the size of the CE_FSMONITOR_DIRTY bitmap.
+
+  - An ewah bitmap, the n-th bit indicates whether the n-th index entry
+    is CE_FSMONITOR_DIRTY.
-- 
2.13.0.windows.1.6.g4597375fc3

