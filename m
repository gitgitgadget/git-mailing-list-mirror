Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F202C433F5
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 17:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F7866103D
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 17:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhJXRMP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Oct 2021 13:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhJXRMO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Oct 2021 13:12:14 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB7BC061745
        for <git@vger.kernel.org>; Sun, 24 Oct 2021 10:09:53 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id ec8so13390535edb.6
        for <git@vger.kernel.org>; Sun, 24 Oct 2021 10:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/ae6v6ZUOlunu6pLJcs0OUkxh6cbNUDF8WfbDj5g890=;
        b=RIVpuMd3LO5vJu5IidrjH4xoEUZWLGo0oxTCSjOcIaFqo+ENowVhq8nHfCGuoLbkBm
         YvSftr+4kRKhwGUQFF7YXscahdOWkWGxzzb+J9xoUDTs+DilcciFkNr+V6jLRh+/vSbY
         KsgsuitJvYva9xar51LdVTRX7oX09r2rgqNWYAVdhM8HNg/v94A5MOlo6bB3/IwjFYqK
         HRehJxSB5Is4Qj7xe7qNYZl+BKtJP9OOndErVzM2YhgNDphtJv6XbVTLhUU99Y5jxgyc
         Irv3BlJZOgCE91qIEsYUqzyL9mi+loXBci62C/Ir9iyKvkd7tkmj7d5W+fexLA4g2wiS
         CD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/ae6v6ZUOlunu6pLJcs0OUkxh6cbNUDF8WfbDj5g890=;
        b=S37mI5sdmVpUvNn5l3dqybDC4rIcNbweI4I18hWSfdvQJ6M3JTk0vFwrSAMm4DMoAF
         /BGAqt9ji/fd9hsTdd3okJGcF1I2BtO4+kywhVQ6odl5RULxzZDFBqzOZWiqYRWroyye
         nNXUdCUdDf4fJpzQWBAqXHV/Cwd0OhgtXFUxVDgb/KK2qquvSUgA1f2qdkmbHJ8us5RZ
         FRYVWxPq+2Ar4UxnW0YiIFjTRt8bjTc+ebOddKZ2uqH5mKbYGwajduRdasNvnHpAs+ob
         4nAHDuBPbJsMgwtU/V7opXVOFgK3Cc2Jr1yBpT1S2WeEY7WA7WxoLZ84JH08rgWSY37e
         oqFg==
X-Gm-Message-State: AOAM532F6dfG5G+k3A7bJSan+eVLMlmo+K3lThy5qYO8z4EFhwmeEaXb
        Foovh5eiSPVpVLnkFs4pZExfF5k/xcYJCQ==
X-Google-Smtp-Source: ABdhPJwD0JOOuTXiX+dJmoSVGVPNUxpnWfjDskxxl7ueite9E5BHn2oOzX2H3C3ioqFOPnce3+QSTg==
X-Received: by 2002:a05:6402:1a2f:: with SMTP id be15mr18024490edb.270.1635095391785;
        Sun, 24 Oct 2021 10:09:51 -0700 (PDT)
Received: from lena.c.hoisthospitality.com ([194.209.187.34])
        by smtp.gmail.com with ESMTPSA id j11sm6313670ejt.114.2021.10.24.10.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 10:09:51 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 1/3] git-multi-pack-index.txt: change "folder" to "directory"
Date:   Sun, 24 Oct 2021 19:09:15 +0200
Message-Id: <a2db03adddee0a8b46e943b40a85a8d44a20c10a.1635094161.git.martin.agren@gmail.com>
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
concept. In all of our documentation, these are the only spots where we
refer to the `.git` directory as a folder. Switch to "directory", and
while doing so, add backticks to the ".git" filename to set it in
monospace.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-multi-pack-index.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index b008ce2850..c588fb91af 100644
--- a/Documentation/git-multi-pack-index.txt
+++ b/Documentation/git-multi-pack-index.txt
@@ -99,13 +99,13 @@ associated `.keep` file will not be selected for the batch to repack.
 EXAMPLES
 --------
 
-* Write a MIDX file for the packfiles in the current .git folder.
+* Write a MIDX file for the packfiles in the current `.git` directory.
 +
 -----------------------------------------------
 $ git multi-pack-index write
 -----------------------------------------------
 
-* Write a MIDX file for the packfiles in the current .git folder with a
+* Write a MIDX file for the packfiles in the current `.git` directory with a
 corresponding bitmap.
 +
 -------------------------------------------------------------
@@ -118,7 +118,7 @@ $ git multi-pack-index write --preferred-pack=<pack> --bitmap
 $ git multi-pack-index --object-dir <alt> write
 -----------------------------------------------
 
-* Verify the MIDX file for the packfiles in the current .git folder.
+* Verify the MIDX file for the packfiles in the current `.git` directory.
 +
 -----------------------------------------------
 $ git multi-pack-index verify
-- 
2.33.1.711.g9d530dc002

