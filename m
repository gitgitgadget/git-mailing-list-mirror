Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C96C4332F
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 19:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiLITmd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Dec 2022 14:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiLITmN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2022 14:42:13 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861E3AF4FE
        for <git@vger.kernel.org>; Fri,  9 Dec 2022 11:41:40 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id bx10so6224274wrb.0
        for <git@vger.kernel.org>; Fri, 09 Dec 2022 11:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=62u8Z2y+z7u1Xa2KdIX0C5enKTnPXUdZvp6U9HT+CLo=;
        b=lzMx4yi2pc08QcYquBTLs189MBwi7a6h18miw0nAHbIWMJb71i8rppTMoaN/PHXQ/n
         Do38hEg2QWeOVB3Ag9E5xoSnHlactChybfLCUJfbIQTuciYSXK9EkGR42ZioNKDtuEyi
         XypwsQZVVY9ukt8S+L+XASh+nn1h4vqiSqMmoZ1uWKWbXqGVqZUooTwXimN2z2PTHrYR
         3ZFH6UB3SjuMMRXx0h/QGJwiRFtrnCkAsOk2E7AV6pBMH0TmTPDuz3+pe9jhQvqudHQ3
         lTojErlp04d06Z2aCrnwAyXasaPRkpHe7rMVdpnmUXg/U+bZkaSERSk1hIR22h3VlHvU
         9duw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=62u8Z2y+z7u1Xa2KdIX0C5enKTnPXUdZvp6U9HT+CLo=;
        b=N7vmgb36C1RKW40LE9klCEpiVhCujUODLFFF96LOypDYsCbOaMW+zd6gscjbkNL15M
         rE3bZ5DJf2qNdOIxzjKCfXw5qSk7TI2KpmVHh+DbgNgNLOHu3bHmtBOblzxsVSeqziCx
         VhY+VikHRKgJiysFwuZ1CnyaFrfcnS+62iCFDLR180k9g+JuJ+zR3TMHTqjQncCm+CJe
         qyv+DOJ7IK8HgDY/Ap16a66fvNc4X1k9raD8xqZiEcbOe14D19oJmPW/VPQ/u9mczT+C
         inL1BHAlS4/FOw/9VS7/TOea5BIqDvPzg2VtlFUEoUdlCqx/yWt6u9EiYrArfboar6F6
         whlQ==
X-Gm-Message-State: ANoB5pmOIbe6z+X8/v7fnTnlZstZqvqGytVpp2pQleMKrHNK5AQeLPXB
        YTZ7c8BEwQLWJY/G5mnDN++OXzhBFko=
X-Google-Smtp-Source: AA0mqf48DZiQxYsrMdTr+cylZWQX1cCTOXkK93oxapwSJrVBRA+T+Qvu/EBLgAkV7Y7QZBlqCI5yfg==
X-Received: by 2002:adf:e992:0:b0:242:4035:622 with SMTP id h18-20020adfe992000000b0024240350622mr5126528wrm.31.1670614893410;
        Fri, 09 Dec 2022 11:41:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bn1-20020a056000060100b00242269c8b8esm2153152wrb.25.2022.12.09.11.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 11:41:33 -0800 (PST)
Message-Id: <pull.1392.git.git.1670614892380.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 09 Dec 2022 19:41:32 +0000
Subject: [PATCH] docs: link generating patch sections
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Currently, in the git-log documentation, the reference to generating
patches does not match the section title. This can make the section
"Generating patch text with -p" hard to find, since typically readers of
the documentation will copy and paste to search the page.

Let's make this more convenient for readers by linking it directly to
the section.

Since git-log pulls in diff-generate-patch.txt, we can provide a direct
link to the section. Otherwise, change the verbiage to match exactly
what the section title is, to at least make searching for it an easier
task.

Signed-off-by: John Cai <johncai86@gmail.com>
---
    docs: link generating patch sections
    
    Currently, in the git-log documentation, the reference to generating
    patches does not match the section title. This can make the section
    "Generating patch text with -p" hard to find, since typically readers of
    the documentation will copy and paste to search the page.
    
    Let's make this more convenient for readers by linking it directly to
    the section.
    
    Signed-off-by: John Cai johncai86@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1392%2Fjohn-cai%2Fjc%2Fdoc-generate-patch-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1392/john-cai/jc/doc-generate-patch-v1
Pull-Request: https://github.com/git/git/pull/1392

 Documentation/diff-options.txt | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 3674ac48e92..5acffdd129e 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -22,7 +22,13 @@ ifndef::git-format-patch[]
 -p::
 -u::
 --patch::
-	Generate patch (see section on generating patches).
+	Generate patch (see section on
+ifdef::git-log[]
+<<_generating_patch_text_with_p, generating patches>>).
+endif::git-log[]
+ifndef::git-log[]
+Generate patch text with -p).
+endif::git-log[]
 ifdef::git-diff[]
 	This is the default.
 endif::git-diff[]

base-commit: 2e71cbbddd64695d43383c25c7a054ac4ff86882
-- 
gitgitgadget
