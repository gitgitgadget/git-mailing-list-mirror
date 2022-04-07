Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB22C433F5
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 15:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345207AbiDGPzJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 11:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345228AbiDGPzI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 11:55:08 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F55CA6F1
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 08:53:07 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id s13so8020963ljd.5
        for <git@vger.kernel.org>; Thu, 07 Apr 2022 08:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ghvygs+QlV+2ArHsobUlMJSLfGJC8zdCsRsHBIucaiE=;
        b=onPKVf3zWO6IxJbY3R0hgvPGJxaqiQnb2kjO84LitLlw6hSK9snZYebZXjvtooiqXn
         A/eDgPUU0uGi+puHwwyg4O1VMwSd7Xh3lbN3ERx1mxRtFDByU0x/H9owpUDPM0BHTO3Y
         hFzBUgRSdLbwzvflEH+E73rS+Vako9dKToAqsZ/WhVeuF8wgmoFG+omM2hxKLAk3RywH
         pBzm1yCLenY9YctGh8cWJ44PLkUJxCmxfamt3J/0aQ38Z2jrUWp+b3B1OLL2WOJu2OmT
         eeKhQ33LMSbOwe5+q+FtoRFgPgUPoveDiVcsIPCf6g6XQtD495wCQi8pxLkSNFC24mhq
         PUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ghvygs+QlV+2ArHsobUlMJSLfGJC8zdCsRsHBIucaiE=;
        b=ckSiak+Yqk4mwZiBxG5TFe1slcfiooedYmxTsVYdYTfdOb/qMy4Bq01+csemdhxLiU
         zahrpicQN/wxx2J4Pyy+w2kwgcbM1YPwLW2u/b79WTbaHmsQ9Lr3HKuUQQ4oCYijI6Nw
         ScJbMrJZcCNvHhWrv9AHOBOxr7kO/YRU26GPjR/oBgNiP+h2KVn4GLJb9VIE8u1KQSWp
         NSLI/cIBf6vaY8T/VKV/GYYyrH98paVBxiHn/fPdNemuzMpv8znCwSxfs9gZYWsysvhZ
         gCTwULbHv1wF9D2kqWicfE2Jnt37PXc8udHSHqoD35kAGsmHq7EOnwqoxTSQYRa34ACb
         kSHQ==
X-Gm-Message-State: AOAM531DfzYUws+e1234FiI+c3jsDbow5I7NkDIOFw8WlCYOH2pXvyXd
        e+Cv1wnmXh3EAJVGzrLvYpYG9ukO1fc=
X-Google-Smtp-Source: ABdhPJxNSVrm4g/3FehXHCmE5Iu+/2hGQWlmaLUIwKr05mCiyxRMm3D86lfZ5rlG09WIzpSeV72jmQ==
X-Received: by 2002:a05:651c:1a28:b0:24b:1ff4:e172 with SMTP id by40-20020a05651c1a2800b0024b1ff4e172mr9106639ljb.157.1649346785277;
        Thu, 07 Apr 2022 08:53:05 -0700 (PDT)
Received: from localhost.localdomain (81-233-167-126-no2216.tbcn.telia.com. [81.233.167.126])
        by smtp.gmail.com with ESMTPSA id b35-20020a0565120ba300b0044a909dba3asm2205160lfv.266.2022.04.07.08.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 08:53:04 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Teng Long <dyroneteng@gmail.com>
Subject: [PATCH] git-ls-tree.txt: fix the name of "%(objectsize:padded)"
Date:   Thu,  7 Apr 2022 17:52:31 +0200
Message-Id: <20220407155231.2528221-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.36.0.rc0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 455923e0a1 ("ls-tree: introduce "--format" option", 2022-03-23)
introduced `--format` and the various placeholders it can take, such as
%(objectname) and %(objectsize).

At some point when that patch was being developed, those placeholders
had shorter names, e.g., %(name) and %(size), which can be seen in the
commit message of 455923e0a1. One instance of "%(size:padded)" also
managed to enter the documentation in the final version of the patch.
Correct it to "%(objectsize:padded)".

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-ls-tree.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index 43aebb9938..8f31e2ee9d 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -156,7 +156,7 @@ objectname::
 	The name of the object.
 objectsize[:padded]::
 	The size of the object ("-" if it's a tree).
-	It also supports a padded format of size with "%(size:padded)".
+	It also supports a padded format of size with "%(objectsize:padded)".
 path::
 	The pathname of the object.
 
-- 
2.36.0.rc0

