Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFE881F453
	for <e@80x24.org>; Sun, 27 Jan 2019 23:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfA0X1Q (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 18:27:16 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:36223 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbfA0X1B (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 18:27:01 -0500
Received: by mail-ed1-f46.google.com with SMTP id f23so11603865edb.3
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 15:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=78IrL+5/ULRbiBWonyqqOoF9pTaUuqJK4U/mjC0vwos=;
        b=EYyVZ8JUrMpgx0x8445+5kZiyD1w0ao38QS0fny295lCmYXOjkJKyaEq5nXiCe+Sek
         bcIPqP/VJicptWBHd4H45Z/SO3JY5/d1C5zfRSrveq1SEKLcxfvktxdYViEBop02EPA0
         vKpUYFk2MakbYc0K9ZCJnkstkjm1Pu8Mb93kNJgb6C1kpSiwOiuMBDGioZyHMAcagDOn
         rKuM5RfTlrhRp3iv7eHyTvZElVhpIiWQbV4qLDLjFHSscYdU5lo+SU3mkaB7PUTDbiVG
         HNiHbXJjh9su2vD2cu19GHnt1Z241htmk5TFyHxkJmhiMgo9gSbexBBea0kR5rmvkr2f
         Z9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=78IrL+5/ULRbiBWonyqqOoF9pTaUuqJK4U/mjC0vwos=;
        b=uaxGIa3N0iKLESminJ/SfufwkXYmiBPKuGCOxsNE2im66GNLrhxfH+laapBxpagyDR
         wmu3DKFftYVOZjJQTyx4bOed3lzVmMBbEZcmenydGnGH/8tGu87Z89dde8ksI3ePAdhp
         snTZ7Ms2atbXWEeEdGT67rznAQXaLaJ95U8va10foBuvvfLEIQ8AYrcV3SqJAgLrtU7Q
         pgqhTR2BweXaXHasjZp75RdXyxcKWDPUjTC4qwb0e66GqxByIFPDFYj1X9bBX5VfaH1r
         2fEg4TyXHR5DOtRErArS+De2HTw18pruyafw/NJU1Xig/01P2ra3kS7S8Gjiywd68HIS
         kzWw==
X-Gm-Message-State: AJcUukdBtcU8XATTPxBFEWt5ULcRNwK3rcti8hssyusij/5W8VBKDDJc
        02i0uEiKmiDfQiF0hzmctBnRYyyE
X-Google-Smtp-Source: ALg8bN6ziNNoh2PO9a3vWni1u190bxr404KEpflnLHyWwCQwWyrNGIry9yWGnPT3xuqbbBaX3ESt5A==
X-Received: by 2002:a17:906:118c:: with SMTP id n12mr12687163eja.228.1548631618476;
        Sun, 27 Jan 2019 15:26:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w31sm13394557edw.82.2019.01.27.15.26.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 15:26:57 -0800 (PST)
Date:   Sun, 27 Jan 2019 15:26:57 -0800 (PST)
X-Google-Original-Date: Sun, 27 Jan 2019 23:26:37 GMT
Message-Id: <52d63018c9d4ef0374fe0dca58fc1f8a856736c9.1548631607.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v5.git.gitgitgadget@gmail.com>
References: <pull.31.v4.git.gitgitgadget@gmail.com>
        <pull.31.v5.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 11/21] ci: use git-sdk-64-minimal build artifact
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Instead of a shallow fetch followed by a sparse checkout, we are
better off by using a separate, dedicated Pipeline that bundles
the SDK as a build artifact, and then consuming that build artifact
here.

In fact, since this artifact will be used a lot, we spent substantial
time on figuring out a minimal subset of the Git for Windows SDK, just
enough to build and test Git. The result is a size reduction from around
1GB (compressed) to around 55MB (compressed). This also comes with the
change where we now call `usr\bin\bash.exe` directly, as `git-cmd.exe`
is not included in the minimal SDK.

That reduces the time to initialize Git for Windows' SDK from anywhere
between 2m30s-7m to a little over 1m.

Note: in theory, we could also use the DownloadBuildArtifacts@0 task
here. However, restricted permissions that are in effect when building
from forks would let this fail for PR builds, defeating the whole
purpose of the Azure Pipelines support for git.git.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 azure-pipelines.yml | 44 +++++++++-----------------------------------
 1 file changed, 9 insertions(+), 35 deletions(-)

diff --git a/azure-pipelines.yml b/azure-pipelines.yml
index 0f7b2125a1..480e841a85 100644
--- a/azure-pipelines.yml
+++ b/azure-pipelines.yml
@@ -18,44 +18,18 @@ jobs:
     env:
       GITFILESHAREPWD: $(gitfileshare.pwd)
   - powershell: |
-      # Helper to check the error level of the latest command (exit with error when appropriate)
-      function c() { if (!$?) { exit(1) } }
-
-      # Add build agent's MinGit to PATH
-      $env:PATH = $env:AGENT_HOMEDIRECTORY +"\externals\\git\cmd;" +$env:PATH
-
-      # Helper to initialize (or update) a Git worktree
-      function init ($path, $url, $set_origin) {
-        if (Test-Path $path) {
-          cd $path; c
-          if (Test-Path .git) {
-            & git init; c
-          } else {
-            & git status
-          }
-        } else {
-          & git init $path; c
-          cd $path; c
-        }
-        & git config core.autocrlf false; c
-        & git config core.untrackedCache true; c
-        if (($set_origin -ne 0) -and !(git config remote.origin.url)) {
-          & git remote add origin $url; c
-        }
-        & git fetch --depth=1 $url master; c
-        & git reset --hard FETCH_HEAD; c
-        & git clean -df; c
-      }
-
-      # Initialize Git for Windows' SDK
-      $sdk_path = "$(Build.SourcesDirectory)\git-sdk-64"
-      init "$sdk_path" "https://dev.azure.com/git-for-windows/git-sdk-64/_git/git-sdk-64" 0
+      $urlbase = "https://dev.azure.com/git-for-windows/git/_apis/build/builds"
+      $id = ((Invoke-WebRequest -UseBasicParsing "${urlbase}?definitions=22&statusFilter=completed&resultFilter=succeeded&`$top=1").content | ConvertFrom-JSON).value[0].id
+      $downloadUrl = ((Invoke-WebRequest -UseBasicParsing "${urlbase}/$id/artifacts").content | ConvertFrom-JSON).value[1].resource.downloadUrl
+      (New-Object Net.WebClient).DownloadFile($downloadUrl,"git-sdk-64-minimal.zip")
+      Expand-Archive git-sdk-64-minimal.zip -DestinationPath . -Force
+      Remove-Item git-sdk-64-minimal.zip
 
       # Let Git ignore the SDK and the test-cache
-      "/git-sdk-64/`n/test-cache/`n" | Out-File -NoNewLine -Encoding ascii -Append "$(Build.SourcesDirectory)\.git\info\exclude"
-    displayName: 'Initialize the Git for Windows SDK'
+      "/git-sdk-64-minimal/`n/test-cache/`n" | Out-File -NoNewLine -Encoding ascii -Append "$(Build.SourcesDirectory)\.git\info\exclude"
+    displayName: 'Download git-sdk-64-minimal'
   - powershell: |
-      & "git-sdk-64\git-cmd.exe" --command=usr\\bin\\bash.exe -lc @"
+      & git-sdk-64-minimal\usr\bin\bash.exe -lc @"
         export DEVELOPER=1
         export NO_PERL=1
         export NO_SVN_TESTS=1
-- 
gitgitgadget

