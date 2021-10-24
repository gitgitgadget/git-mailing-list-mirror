Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DB2C433F5
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 17:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69D4B60FDA
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 17:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbhJXRMV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Oct 2021 13:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbhJXRMU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Oct 2021 13:12:20 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D244BC061764
        for <git@vger.kernel.org>; Sun, 24 Oct 2021 10:09:59 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z20so9239114edc.13
        for <git@vger.kernel.org>; Sun, 24 Oct 2021 10:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fhv2hWez0NNBdm9+lqo+ZqmQCpHp09DPoWan7PKqOFs=;
        b=PpZ2oi0qOUQdGx6C2k+V5b+spoPq09M/7nhaHZRDD+iTDRLqdQlCw6qu2CkUH9Fc+v
         TA4Fp44t35QPDcZT8WB4oUPod0CzvE2KqMYcANnWWf0rdOz7ooYtLiateC1qnFGCAEBa
         96tKRE+++FuGNSmRM0hcqBgTGChyhnSsNvTBknwD4gEtsxhDrCJYDgtUFI07pMPa8tup
         it+6aQqb3jkzZRk0QLLGaqgc3OUSiRFTi9zqcm3YRBrkQN5iIIVb3kMjGKaaOIS06Mgv
         6CXQ2vsvwFCM/eblm1TDEY2QrBrVBQ2YJZQ8X+BFg3jpK4lHubnjeD+X84zNXTYqU/zQ
         fN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fhv2hWez0NNBdm9+lqo+ZqmQCpHp09DPoWan7PKqOFs=;
        b=pBX95Qw9WTFNtAQUXzbRw0IOlh4gtizsWI47gGxV5sXdMpJ+/GGQMjCVPWe3rbX+nQ
         04+50c6UprdH1y8BHpIiPlnGERevuWJI8YE+4QrHkUjYLbJ3kyB2B7iGUf1lEgcnGyNM
         5IdqkT2mx0CCcGPmopSPZ3J32val9sDye8DTBJFegGbzX6+PfSRHC6AHp9j/Oo1nTkrw
         /RXPdBe6jGjW+0WF9LrheksMuzCSiIAoj1r+UoGdBgO6OO1kZJ0Vu4YYiZilOenGxYFJ
         nnEi6+iDK9r81M9WNg7V1O4Nj7dyyuRhrKNmPdO5S53GsrHci8+55STmtKq3OZ5p3TVa
         UULw==
X-Gm-Message-State: AOAM532V34rO8jeAv2eL50VhLLPjoSNhZcFGM+jlXx0UkVG2pmgHLbU5
        Mk8EObCvIH5z/WLfR8KcUo/JerCJkqGHQA==
X-Google-Smtp-Source: ABdhPJzIEbym6JT5uUId9/rpvpMi8o7YTlx7hTTHEclgvX0CUT07mhghClCQGD7vlbLYafRFOH1jKw==
X-Received: by 2002:a17:907:168b:: with SMTP id hc11mr16619090ejc.160.1635095398259;
        Sun, 24 Oct 2021 10:09:58 -0700 (PDT)
Received: from lena.c.hoisthospitality.com ([194.209.187.34])
        by smtp.gmail.com with ESMTPSA id j11sm6313670ejt.114.2021.10.24.10.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 10:09:57 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     "Dr . Adam Nielsen" <admin@in-ici.net>
Subject: [PATCH 2/3] gitignore.txt: change "folder" to "directory"
Date:   Sun, 24 Oct 2021 19:09:16 +0200
Message-Id: <4f3ba7fbce97fe74821664c80758ee9781c491c0.1635094161.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.33.1.711.g9d530dc002
In-Reply-To: <cover.1635094161.git.martin.agren@gmail.com>
References: <cover.1635094161.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We prefer "directory" over "folder" when discussing the file system
concept. Change this instance for consistency -- indeed, even within
this paragraph, we already use "directory".

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/gitignore.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index f8a1fc2014..f2738b10db 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -155,7 +155,7 @@ accessed from the index or a tree versus from the filesystem.
 EXAMPLES
 --------
 
- - The pattern `hello.*` matches any file or folder
+ - The pattern `hello.*` matches any file or directory
    whose name begins with `hello.`. If one wants to restrict
    this only to the directory and not in its subdirectories,
    one can prepend the pattern with a slash, i.e. `/hello.*`;
-- 
2.33.1.711.g9d530dc002

