Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 961E51F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 16:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387554AbeKOCGm (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 21:06:42 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45020 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387548AbeKOCGm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 21:06:42 -0500
Received: by mail-lf1-f65.google.com with SMTP id z13so11866310lfe.11
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 08:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FtfhM4Kf1rV50HFFuJgHYfv7A7RfUj/0mJTNtoDT9VM=;
        b=Obbz/E0bdVjbbkInpKof3r9wXcPoPqdTfC7y5716sQvrVlc6BNmgw0XFPXu1xc26R1
         uGsB+88LbqueFMcdbEu8ZLhSEzY5BK11OwQdzvMvQzZQ9nZxg/jVgi4G/nAltJ0tVLn+
         Dxd1puBUGL8hkzTVF8Naa9vlyjZNUbUQIK0OnZUHk3sI8K1wzhLeU2j+/ZkHx8J0MWqd
         b/aOIxYPdByJp7YSI/G8u9Rf7nf4XG8yT6R/LxwpFONyLDOmm+6qIpDIpgBIYI5QA8tA
         s7qXKWuYmv3Hs4UfKfFJxlmqOCU6WbQvlMyq8sg4GZQIQFYXGrun/JKEfq5WVOJW4m5n
         a9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FtfhM4Kf1rV50HFFuJgHYfv7A7RfUj/0mJTNtoDT9VM=;
        b=KPHp/R8sDw3uU/y2Q+f/JbSQ/DWuQAiVD9khNdzymrhq83UzEPrguCqAJ2/vLl+z62
         5FUeYrkNpV7RZmwk3eiq3Pcigj+dBofJZKgsvfnKDOVLmmkMiUc3GDxZ6KG7LQn4E3N0
         gUuv70rh/Tn9C9RERpDfv/HIyj8xohepEBkYC3yvYyh3wFGs4/6AXsJiRgzwLtEuPKMm
         6NNaVZrVOd0KBGDr33QvlB3EglMtub7jnyLD95cwp7FlOhrrsYx6helRqpTKmHTUtRbC
         75soJ8nk9Eg9IvOKzkOa7vhFoG8XhC1ZchYCeiyIHne6AMWaOAOeMhR5ybFhPyC2AVGA
         DC3g==
X-Gm-Message-State: AGRZ1gLdPLBF/SP/nKdXI5dPe+i7GGpH2yudXK1bjysbMdAq0OVdOTUC
        Gy1tcUZ/QMKXF7EsfavmnpQWID3H
X-Google-Smtp-Source: AJdET5cugnVxbeb0fe5uQf+wyTjLlNLGEEeJwtAMGQMUXsqvI4I4KOX4ckYYRZHxDtc65Txh8Tju7A==
X-Received: by 2002:a19:e30f:: with SMTP id a15mr1368416lfh.66.1542211370452;
        Wed, 14 Nov 2018 08:02:50 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id p138sm408529lfp.22.2018.11.14.08.02.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 08:02:49 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] doc: move extensions.worktreeConfig to the right place
Date:   Wed, 14 Nov 2018 17:02:47 +0100
Message-Id: <20181114160247.24715-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1320.g030759e4a3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All config extensions are described in technical/repository-version.txt.
I made a mistake of adding it in config.txt instead. This patch moves
it back to where it belongs.

Since repository-version.txt is not part of officially generated
documents (it's not even part of DOC_HTML target), it's only visible
to developers who read plain .txt files. Let's include it in
gitrepository-layout.5 for more visibility. Some minor asciidoc fixes
are required in repository-version.txt to make this happen.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt                      |  7 -----
 Documentation/gitrepository-layout.txt        |  2 ++
 .../technical/repository-version.txt          | 26 ++++++++++---------
 3 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3e735f1a9a..d87846faa6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -292,13 +292,6 @@ include::config/advice.txt[]
 
 include::config/core.txt[]
 
-extensions.worktreeConfig::
-	If set, by default "git config" reads from both "config" and
-	"config.worktree" file from GIT_DIR in that order. In
-	multiple working directory mode, "config" file is shared while
-	"config.worktree" is per-working directory (i.e., it's in
-	GIT_COMMON_DIR/worktrees/<id>/config.worktree)
-
 include::config/add.txt[]
 
 include::config/alias.txt[]
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index d501af9d77..366dee238c 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -290,6 +290,8 @@ worktrees/<id>/locked::
 worktrees/<id>/config.worktree::
 	Working directory specific configuration file.
 
+include::technical/repository-version.txt[]
+
 SEE ALSO
 --------
 linkgit:git-init[1],
diff --git a/Documentation/technical/repository-version.txt b/Documentation/technical/repository-version.txt
index e03eaccebc..7844ef30ff 100644
--- a/Documentation/technical/repository-version.txt
+++ b/Documentation/technical/repository-version.txt
@@ -1,5 +1,4 @@
-Git Repository Format Versions
-==============================
+== Git Repository Format Versions
 
 Every git repository is marked with a numeric version in the
 `core.repositoryformatversion` key of its `config` file. This version
@@ -40,16 +39,14 @@ format by default.
 
 The currently defined format versions are:
 
-Version `0`
------------
+=== Version `0`
 
 This is the format defined by the initial version of git, including but
 not limited to the format of the repository directory, the repository
 configuration file, and the object and ref storage. Specifying the
 complete behavior of git is beyond the scope of this document.
 
-Version `1`
------------
+=== Version `1`
 
 This format is identical to version `0`, with the following exceptions:
 
@@ -74,21 +71,18 @@ it here, in order to claim the name.
 
 The defined extensions are:
 
-`noop`
-~~~~~~
+==== `noop`
 
 This extension does not change git's behavior at all. It is useful only
 for testing format-1 compatibility.
 
-`preciousObjects`
-~~~~~~~~~~~~~~~~~
+==== `preciousObjects`
 
 When the config key `extensions.preciousObjects` is set to `true`,
 objects in the repository MUST NOT be deleted (e.g., by `git-prune` or
 `git repack -d`).
 
-`partialclone`
-~~~~~~~~~~~~~~
+==== `partialclone`
 
 When the config key `extensions.partialclone` is set, it indicates
 that the repo was created with a partial clone (or later performed
@@ -98,3 +92,11 @@ and it promises that all such omitted objects can be fetched from it
 in the future.
 
 The value of this key is the name of the promisor remote.
+
+==== `worktreeConfig`
+
+If set, by default "git config" reads from both "config" and
+"config.worktree" file from GIT_DIR in that order. In
+multiple working directory mode, "config" file is shared while
+"config.worktree" is per-working directory (i.e., it's in
+GIT_COMMON_DIR/worktrees/<id>/config.worktree)
-- 
2.19.1.1320.g030759e4a3

