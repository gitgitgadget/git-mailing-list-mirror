Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB56C25B0E
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 00:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237375AbiHQA2J (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 20:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237285AbiHQA2G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 20:28:06 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672C372849
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 17:28:05 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id g11so80527wrv.9
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 17:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=AYuywWNAHcQXkupiS7Llbsz+hOb5QF+T6kmpf2oK2wU=;
        b=F73mvnVU49x6yTI3y4sMjlhbxJjx/H6dLrX1Se4nPTiT8s8y7IO9j2FhiQ9QtblVAz
         vbMAHtliKjwhZbdGj7R0VznnBHMRINrGYvN4+oygvoN/0cLofWPiAZcyaiJ4Jyj8qFeg
         Kp3gzSkkAFm4sRcYGeM1AJUTqWzBRSt4J30z83rzH8ROHW9YYthQ3YoyzJA29Lxc9O0R
         +brRCqr2zJK/gRe0llKs1aFTU/+Hy29JZ/GXyrypKz0FT+k6yv22OG20FHRR4RojrR7i
         ZFOaMciVKeZNBIEs/QgQq3e0iai4M0VWXddqlQB1Lgghe3oCHuDhQCTxUKefLtfOmC6c
         m8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=AYuywWNAHcQXkupiS7Llbsz+hOb5QF+T6kmpf2oK2wU=;
        b=ufUUxEJ7lQJ9E6XjvteN+MgjKuNCQqS+qiFgbkB3e0+m8SOYjfLkTa5rFTKHWXdDRI
         kMP+mmy51aNbKeIxD8VVb2lGt1zbWLKFgHAFjvEW75YdrOj7vnEZ1FeWFdcZDPFjpJPu
         FmNIXHx54q1uYmBWl8GKOF9s96zueuOyGsy8rAawL7iGmAZw1XXkJ1vgvPPIsungq+4k
         DUWtKHmhV9GFvdIht0a3FqC9RbPM2BIQa/gow0Jky5XWmf/ccDw+rn/SQCyb87DLgiKw
         JdWJlYNRyZCTCdXhP5gg8pHa8IUSaaWcQ2go1vFd7WkVcJf2IBpNLzaLKZqWrE7cDOAM
         ygHQ==
X-Gm-Message-State: ACgBeo3qcloi3Y7WIuRPbLx3//Vsd0CiICOyQ26ykMInQ8bYQ/ITQ3tu
        krXpONbSbf/UHE7mKpdmVAy62d7cP5g=
X-Google-Smtp-Source: AA6agR7Dn1cFDlhlhtwTyTFueGzmNcLJ+jmqrhno2ixc2dCwZhjNzKn7/uMmncmIkIXkyLIYs+OaZA==
X-Received: by 2002:a5d:5848:0:b0:222:c8cd:288 with SMTP id i8-20020a5d5848000000b00222c8cd0288mr12848795wrf.34.1660696083774;
        Tue, 16 Aug 2022 17:28:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e26-20020a05600c219a00b003a5de95b105sm295374wme.41.2022.08.16.17.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 17:28:03 -0700 (PDT)
Message-Id: <269714da7062cf9d9de5200ab564bd727e921359.1660696081.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1325.git.1660696081.gitgitgadget@gmail.com>
References: <pull.1325.git.1660696081.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Aug 2022 00:28:00 +0000
Subject: [PATCH 2/3] merge-ort: add comment to avoid surprise with new
 sub_flag variable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Commit 4057523a40 ("submodule merge: update conflict error message",
2022-08-04) added a sub_flag variable that is used to store a value from
enum conflict_and_info_types, but initializes it with an invalid value
of -1.  The code may never set it to a valid value, and use the invalid
one.  This can be surprising when reading over the code at first, but it
was intentional.  Add a comment making it clear that it is okay to be
using an invalid value, due to how it is used later.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 67159fc6ef9..0a935a8135f 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1886,7 +1886,7 @@ cleanup:
 		const char *abbrev;
 
 		util = xmalloc(sizeof(*util));
-		util->flag = sub_flag;
+		util->flag = sub_flag; /* May still be -1 */
 		util->abbrev = NULL;
 		if (!sub_not_initialized) {
 			abbrev = repo_find_unique_abbrev(&subrepo, b, DEFAULT_ABBREV);
-- 
gitgitgadget

