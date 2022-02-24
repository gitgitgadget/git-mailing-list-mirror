Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC672C433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 09:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbiBXJqS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 04:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbiBXJqP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 04:46:15 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29D827DF33
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:45:45 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d17so2024469wrc.9
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3by/pYzrUDkwgiC3YbPUoswDWdfmTup0+7dz39uoq90=;
        b=j/aYRwAJ1IN1KYIjpiBcckJncUOuz5ofPLBUAlzBb4pSbtvxdDMuaRowwjFk9B+nix
         zmQbvTU39boqMYiSPiDU8B2Nw/uqgH3U4GykrTtQaqPXNPx9Pb9LFJWbWKYjI8zq//bD
         7V0R4NwX9epSUfnib5QGEB+t6yFxKtDGkdD+BZx7shd35s0m3NEbvV0aMFcNa2RaO52S
         M8ze2UZnOLp4Wt94qMILXdaxFyjq2HMXKnpf1YnDDxp4KQ6/tNA7Go5geFyOIiPm9A63
         u0/GSAsEfxpBAkn/TQdvFBrnHUIpf47YMWcaGOREMxDSIC3R3mVkZCItEh3nMykFC7KW
         5sGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3by/pYzrUDkwgiC3YbPUoswDWdfmTup0+7dz39uoq90=;
        b=SWbJOMot5xWfL031mIHRU+F3y5+Z541QgRBhi9DOQaHiZJRVjCbiHox6lULvQCBXNm
         6KhCZWiLR4cZ6lb3mCX97l9qsv7It13PgUORs76k6CL9iny47yT4nYhHRDfK5heO8n4Y
         kN29VYZych2lSUXH3Q8bmRGIepvQYCKyeA8/W1X7WipW0FWhfvl+19kdOtCU/oyO1xDp
         LJUDQKD+2tAoOodvkzgHY0EueuUAMw5IkarGf7bDqzz0wD8kL/SRxBvQ1H5elhMtOs35
         DH3p5q+z6MVMBKdhEJ5vPIy14Xu6RreIabOv2npwvXUcxaJ7XtlLWF+xPypd1t13yAq4
         eQSA==
X-Gm-Message-State: AOAM532yRiu2QGlk8w0evixGdeTfJqctpim15JuL8IgoXJDGEtXVTxFz
        se4pXDK7Vhf1/Q/Mr0wisGdbem7kLig=
X-Google-Smtp-Source: ABdhPJyCoDndVplsVQTgHpWNUGY40Zwd4YHSvVVX+FDvtUDoWeDt+/z+YIjy3hJJe1/GnxEFE/br8g==
X-Received: by 2002:a5d:598a:0:b0:1e6:29fa:bab1 with SMTP id n10-20020a5d598a000000b001e629fabab1mr1530569wri.671.1645695944071;
        Thu, 24 Feb 2022 01:45:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 24sm1921830wmf.48.2022.02.24.01.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:45:43 -0800 (PST)
Message-Id: <39c14906e7b65843c2543682bb577c6a2253240a.1645695940.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1161.git.1645695940.gitgitgadget@gmail.com>
References: <pull.1161.git.1645695940.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Feb 2022 09:45:40 +0000
Subject: [PATCH 3/3] branch documentation: new autosetupmerge option "simple"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

Updating the branch and config documentation to reflect
the new "simple" option to branch.autosetupmerge.

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
 Documentation/config/branch.txt | 4 +++-
 Documentation/git-branch.txt    | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/branch.txt b/Documentation/config/branch.txt
index 1e0c7af014b..7b4e5ca5b74 100644
--- a/Documentation/config/branch.txt
+++ b/Documentation/config/branch.txt
@@ -9,7 +9,9 @@ branch.autoSetupMerge::
 	automatic setup is done when the starting point is either a
 	local branch or remote-tracking branch; `inherit` -- if the starting point
 	has a tracking configuration, it is copied to the new
-	branch. This option defaults to true.
+	branch; `simple` -- automatic setup is done when the starting point is
+	a remote-tracking branch and the new branch has the same name as the
+	remote branch. This option defaults to true.
 
 branch.autoSetupRebase::
 	When a new branch is created with 'git branch', 'git switch' or 'git checkout'
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index c8b4f9ce3c7..f99d6a6b008 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -227,7 +227,9 @@ want `git switch`, `git checkout` and `git branch` to always behave as if `--no-
 were given. Set it to `always` if you want this behavior when the
 start-point is either a local or remote-tracking branch. Set it to
 `inherit` if you want to copy the tracking configuration from the
-branch point.
+branch point. Set it to `simple` if you want this behavior only when
+the start-point is a remote branch and the new branch has the same name
+as the remote branch.
 +
 See linkgit:git-pull[1] and linkgit:git-config[1] for additional discussion on
 how the `branch.<name>.remote` and `branch.<name>.merge` options are used.
-- 
gitgitgadget
