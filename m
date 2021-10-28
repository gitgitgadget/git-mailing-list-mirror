Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D620EC4332F
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 16:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1563610E5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 16:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhJ1QYh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 12:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbhJ1QYf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 12:24:35 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C74C061570
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 09:22:08 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id o14so11132005wra.12
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 09:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=zIdJpkr1mGdk1nIZntrXZ8/kOMPNeGQpEJSf9XOB3gs=;
        b=im+MvOJtadfeHQ2gXzCqQDPwLQBlFizsZeCf4aqCBxA0FtUxA2URNP+XEsASHncKmI
         fYtq6XjULA0edtPWrbOAUdj5+DZL7qrymWSkOKtNuaRORPKM7wFUO4gxiQKEybNHRSES
         dixC6ijzh+1xksOfS3+RK53DB+RkAg7UiMKHFvE4NmM2Xd4yr9Tr8HnekwCQS8qqm8Bb
         Mc5n5C1QGQGKt12s6fbFlUTvRKNngqrkV7zPPBrVcZ+y/KRHrrHNJ74s6bG9fLnqADBe
         /JibF7djGffwpO4Sq+ecbPt8f05+DcbuweC3t3nyF0w5wwi8H+Vs/uEohfiK3+iDupe8
         cVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=zIdJpkr1mGdk1nIZntrXZ8/kOMPNeGQpEJSf9XOB3gs=;
        b=EOPkKS0pzLIjvn6HRqOjFO3eecvbzfWmpdicKfQX4hO5A3AHj89v3SRuNPM3FyyfXX
         Vp31yRPRV3TigHbDZR4vwgLCVjnNO3JKilGyxbOIHte53TBFrSQZjxZVLN3QB5sFgWq6
         zWR5opBa8WTXuNhwI0dfd6AwHkFOS9bgJgBsZIVPDRF+yhVzpze4MPNoCsIuMzLMElsL
         IAWNntDU7/5pr+d96RbYhjFsOETSeyf5nkpI50vkNQZ43A1wxGXBzMBSKl/04ia7TL2X
         E/drcr8geWhl914A4sgkOHFhr6JYcHDkkfEXygwjg+0BUVYPCPeV9d0HO3CYYPV0BgOW
         7xxg==
X-Gm-Message-State: AOAM531233ptFPcakTrQjUPmkV6mGq5SPI9i6hatYmbogqh7zYkT9bEs
        Lv/P470s0gMpSC4G+XAwFNRgETA4xsc=
X-Google-Smtp-Source: ABdhPJz/S+nwQUfTSNkoS6y6dhnCMVmCjtf/1M90xICh04Ck4mulGKpiQd1qh4pwFLVabx2kplsOvA==
X-Received: by 2002:a5d:6b04:: with SMTP id v4mr7161629wrw.148.1635438126850;
        Thu, 28 Oct 2021 09:22:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n66sm3007238wmn.2.2021.10.28.09.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 09:22:06 -0700 (PDT)
Message-Id: <0045fe6faeaa2beb63a1e63b3b7573ae06cfba38.1635438124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1066.v2.git.1635438124.gitgitgadget@gmail.com>
References: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
        <pull.1066.v2.git.1635438124.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 28 Oct 2021 16:21:57 +0000
Subject: [PATCH v2 2/9] doc: split placeholders as individual tokens
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

The placeholders represent atoms of tokens and must not be
aggregates.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-archimport.txt  | 14 +++++++-------
 Documentation/git-p4.txt          |  2 +-
 Documentation/git-web--browse.txt |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-archimport.txt b/Documentation/git-archimport.txt
index a595a0ffeee..847777fd172 100644
--- a/Documentation/git-archimport.txt
+++ b/Documentation/git-archimport.txt
@@ -9,14 +9,14 @@ git-archimport - Import a GNU Arch repository into Git
 SYNOPSIS
 --------
 [verse]
-'git archimport' [-h] [-v] [-o] [-a] [-f] [-T] [-D depth] [-t tempdir]
-               <archive/branch>[:<git-branch>] ...
+'git archimport' [-h] [-v] [-o] [-a] [-f] [-T] [-D <depth>] [-t <tempdir>]
+	       <archive>/<branch>[:<git-branch>]...
 
 DESCRIPTION
 -----------
 Imports a project from one or more GNU Arch repositories.
 It will follow branches
-and repositories within the namespaces defined by the <archive/branch>
+and repositories within the namespaces defined by the <archive>/<branch>
 parameters supplied. If it cannot find the remote branch a merge comes from
 it will just import it as a regular commit. If it can find it, it will mark it
 as a merge whenever possible (see discussion below).
@@ -27,7 +27,7 @@ import new branches within the provided roots.
 
 It expects to be dealing with one project only. If it sees
 branches that have different roots, it will refuse to run. In that case,
-edit your <archive/branch> parameters to define clearly the scope of the
+edit your <archive>/<branch> parameters to define clearly the scope of the
 import.
 
 'git archimport' uses `tla` extensively in the background to access the
@@ -42,7 +42,7 @@ incremental imports.
 
 While 'git archimport' will try to create sensible branch names for the
 archives that it imports, it is also possible to specify Git branch names
-manually.  To do so, write a Git branch name after each <archive/branch>
+manually.  To do so, write a Git branch name after each <archive>/<branch>
 parameter, separated by a colon.  This way, you can shorten the Arch
 branch names and convert Arch jargon to Git jargon, for example mapping a
 "PROJECT{litdd}devo{litdd}VERSION" branch to "master".
@@ -104,8 +104,8 @@ OPTIONS
 	Override the default tempdir.
 
 
-<archive/branch>::
-	Archive/branch identifier in a format that `tla log` understands.
+<archive>/<branch>::
+	<archive>/<branch> identifier in a format that `tla log` understands.
 
 
 GIT
diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 38e5257b2a4..8a6addcf72f 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -361,7 +361,7 @@ These options can be used to modify 'git p4 submit' behavior.
 	p4/master.  See the "Sync options" section above for more
 	information.
 
---commit <sha1>|<sha1..sha1>::
+--commit (<sha1>|<sha1>..<sha1>)::
     Submit only the specified commit or range of commits, instead of the full
     list of changes that are in the current Git branch.
 
diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web--browse.txt
index 8d162b56c59..f2f996cbe16 100644
--- a/Documentation/git-web--browse.txt
+++ b/Documentation/git-web--browse.txt
@@ -8,7 +8,7 @@ git-web--browse - Git helper script to launch a web browser
 SYNOPSIS
 --------
 [verse]
-'git web{litdd}browse' [<options>] <url|file>...
+'git web{litdd}browse' [<options>] (<URL>|<file>)...
 
 DESCRIPTION
 -----------
-- 
gitgitgadget

