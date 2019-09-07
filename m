Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F9631F4B7
	for <e@80x24.org>; Sat,  7 Sep 2019 14:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391442AbfIGONS (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 10:13:18 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35147 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388458AbfIGONS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Sep 2019 10:13:18 -0400
Received: by mail-lf1-f65.google.com with SMTP id w6so7288310lfl.2
        for <git@vger.kernel.org>; Sat, 07 Sep 2019 07:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qEDo+fkeB8xz3wuIY3GGDmQBiU7awWjJY5+uX6Ymb/I=;
        b=kTcvXF1M2gskpJFd7i7BbSQCvr7YGBYJUyoIm765s8PwPF19swqe9q48MEpeQO+6ie
         FzvxSRqs4okRyKmvtwktEov16lpajOGwcMNo5uDHNCbhG/IzLqnwy7H8E1QuPjlfM+Lw
         PWX85LA/Bec7pMmRjVyZ4gJuO8zfnh47kz4I8ivlrK67XcDZkR9DmJh6LCN/WoH4JiGe
         m/kKlUHrcT2Sq0WzA1lJcDh/UzxX22ytD95cD5A6x1atWOlKW+wcCVVf2oF0+hpMNVB8
         hS8Xj0qru/lHQUbMGCZ7IGa9yKchfSI32loc3lnxldyPMdYEljkbQhRuqYfhZ/tDdVDQ
         iOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qEDo+fkeB8xz3wuIY3GGDmQBiU7awWjJY5+uX6Ymb/I=;
        b=ca3OOEPWxX6Q3Lf/X3TTn+Cj/9dO+sJSXPiP1V7yAO6FokSVDLUMWPXKtSOrb6wHnv
         WXWJTrDVE6OszTFe77y0D13Wp5jizU16c3XAcLaGBm92PhvstL/e2A215rtvQt92s5J7
         hykONDGNlOUgbRbuRYl/AsG0wSZfq+9wWXzTBmf7KPq2Eh3zPtc7ayZaCB+UDqnm/hm3
         mpEFNNa8Cf+57t7CdlNX/xV8EaIbqzR6CAP32iiLJoI8tUYN73QNnvTSc70Kp5/jkeDC
         KoeAkhsh5uD752xV3u+2EA7434wPVf2t59i7XT6WrvAn4rODEaybYjdsmjqmkChD7UMO
         kicw==
X-Gm-Message-State: APjAAAV41VFxzoLY13KMV/wodZ+isjtjitxcX7QhNUN4vin1+2FAzH1S
        XHokXnGOK7GgdGejnue8ySVmwlZ1
X-Google-Smtp-Source: APXvYqxY1oOFYaqmNgSi+Bq5/heCcpeLRfO6lncMgnJi38Zo9+kXWlUtolNnI4yzrA+bhk51iGOZnw==
X-Received: by 2002:ac2:51ce:: with SMTP id u14mr9402022lfm.72.1567865595025;
        Sat, 07 Sep 2019 07:13:15 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id u10sm1741316lfk.34.2019.09.07.07.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 07:13:14 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 1/7] Documentation: wrap blocks with "--"
Date:   Sat,  7 Sep 2019 16:12:47 +0200
Message-Id: <4c6e89fbeb3b76ec1cd8d12d00da2e8d9c77f6bd.1567707999.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1567707999.git.martin.agren@gmail.com>
References: <cover.1567707999.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation for each of these options contains a list. After the
list, AsciiDoc interprets the continuation as a continuation of the
*list*, not as a continution of the larger block. As a result, we get
too much indentation. Wrap the entire blocks in "--" to fix this. With
Asciidoctor, this commit is a no-op, and the two programs now render
these identically.

These two files share the same problem and indeed, they both document
`--untracked-files` in quite similar ways. I haven't checked to what
extent that is intentional or warranted, and to what extent they have
simply drifted apart. I consider such an investigation and possible
cleanup as out of scope for this commit and this patch series.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-commit.txt |  8 +++++---
 Documentation/git-status.txt | 18 +++++++++++-------
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index a85c2c2a4c..e43dad26f5 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -282,18 +282,20 @@ FROM UPSTREAM REBASE" section in linkgit:git-rebase[1].)
 --untracked-files[=<mode>]::
 	Show untracked files.
 +
+--
 The mode parameter is optional (defaults to 'all'), and is used to
 specify the handling of untracked files; when -u is not used, the
 default is 'normal', i.e. show untracked files and directories.
-+
+
 The possible options are:
-+
+
 	- 'no'     - Show no untracked files
 	- 'normal' - Shows untracked files and directories
 	- 'all'    - Also shows individual files in untracked directories.
-+
+
 The default can be changed using the status.showUntrackedFiles
 configuration variable documented in linkgit:git-config[1].
+--
 
 -v::
 --verbose::
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index d4e8f24f0c..7731b45f07 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -59,16 +59,17 @@ This is optional and defaults to the original version 'v1' format.
 --untracked-files[=<mode>]::
 	Show untracked files.
 +
+--
 The mode parameter is used to specify the handling of untracked files.
 It is optional: it defaults to 'all', and if specified, it must be
 stuck to the option (e.g. `-uno`, but not `-u no`).
-+
+
 The possible options are:
-+
+
 	- 'no'     - Show no untracked files.
 	- 'normal' - Shows untracked files and directories.
 	- 'all'    - Also shows individual files in untracked directories.
-+
+
 When `-u` option is not used, untracked files and directories are
 shown (i.e. the same as specifying `normal`), to help you avoid
 forgetting to add newly created files.  Because it takes extra work
@@ -78,9 +79,10 @@ Consider enabling untracked cache and split index if supported (see
 `git update-index --untracked-cache` and `git update-index
 --split-index`), Otherwise you can use `no` to have `git status`
 return more quickly without showing untracked files.
-+
+
 The default can be changed using the status.showUntrackedFiles
 configuration variable documented in linkgit:git-config[1].
+--
 
 --ignore-submodules[=<when>]::
 	Ignore changes to submodules when looking for changes. <when> can be
@@ -100,11 +102,12 @@ configuration variable documented in linkgit:git-config[1].
 --ignored[=<mode>]::
 	Show ignored files as well.
 +
+--
 The mode parameter is used to specify the handling of ignored files.
 It is optional: it defaults to 'traditional'.
-+
+
 The possible options are:
-+
+
 	- 'traditional' - Shows ignored files and directories, unless
 			  --untracked-files=all is specified, in which case
 			  individual files in ignored directories are
@@ -112,12 +115,13 @@ The possible options are:
 	- 'no'	        - Show no ignored files.
 	- 'matching'    - Shows ignored files and directories matching an
 			  ignore pattern.
-+
+
 When 'matching' mode is specified, paths that explicitly match an
 ignored pattern are shown. If a directory matches an ignore pattern,
 then it is shown, but not paths contained in the ignored directory. If
 a directory does not match an ignore pattern, but all contents are
 ignored, then the directory is not shown, but all contents are shown.
+--
 
 -z::
 	Terminate entries with NUL, instead of LF.  This implies
-- 
2.23.0

