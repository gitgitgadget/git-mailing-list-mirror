Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4591CC433FE
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 19:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235524AbiCMT5E (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Mar 2022 15:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235508AbiCMT45 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Mar 2022 15:56:57 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39617D00C
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 12:55:48 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id j25so3749196edj.11
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 12:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F2nPzwvuSHY753h5wLR5Ecn7w67urfHqa/fzj2XzmUU=;
        b=b5xwwLq8RSGUFeYWIToyJC8GpmSNVLXCIBI/f0t1OxNauscGx5ZX8QOLSrtakoQFpB
         dsyu5oH3ORDBZNNZYstPDNNhTai8rPEnE6nX8Iv6S7hDNdmiU6Vy0NKR4gdAro2qxkuP
         uSib1cIbetDlYteW3zJl96jkoVIgV8vLsYNIE8eNQem3dzXtoACwZc6BN5MMxRRPKFNm
         WvsWPK0zbXfHHFctemUFL9j/Humx5czJrIfKsltYvByfhL4CvpitQVme2YN7zx51tgLV
         6F31ZdfXKu8w5xqwNk1NHN/GooLFbaFmKic3LgxFERAnQ/5ZSZ2+cDBd6XzSigVqR/5e
         j7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F2nPzwvuSHY753h5wLR5Ecn7w67urfHqa/fzj2XzmUU=;
        b=KzYArZEh8qcLvbu2j+TYW4JlMJ/MALXZSduG7XO8qRFU9Ny2Mm2EAyDQ+uKMnDL6+x
         CVu0LshnFt59MvI/TMdM9APekOzG4RGFcVJv3NiTC+Y6yo1V9BKSNtCQIoOsHK3UKXVx
         NK4NGfSpimuReGGOFKQEtKrQAq+N2fma/zQw8l3NXqy/Vetx7yKsUPE13CJf7BqqroCv
         PfKzW6FRwsYvLk65egLrgrfsengoBEgSBzL/ZaCT2o131F98CeJdplhAcnU2eEZFv/Zt
         N7ZVBu3Avs3wFUl0qV1DwaUbPSTs61v2NNdHaP+x3No4W68N2L7O0FO+bweiKAXrhCf8
         VTSg==
X-Gm-Message-State: AOAM532oAblgnAGUG25f5H7hLf6T1y390Wd8DwMOmdTaLCLvmSF0nY9l
        A1jkwhUSEuAWJ08Z0gqTsmVM1p6xUZA=
X-Google-Smtp-Source: ABdhPJytKMMQZqccdvQ/f9kdGUEQsQ5j+8kv6cDXHclatqmQoKH7NS8oiBcWgv6xfBgvuE6JChnGOw==
X-Received: by 2002:a05:6402:40cc:b0:416:d191:54fe with SMTP id z12-20020a05640240cc00b00416d19154femr12117318edb.380.1647201347275;
        Sun, 13 Mar 2022 12:55:47 -0700 (PDT)
Received: from fedora35.example.com ([151.27.250.86])
        by smtp.gmail.com with ESMTPSA id f6-20020a056402354600b0041871c5b9a6sm2164087edd.41.2022.03.13.12.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 12:55:46 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 5/5] t/helper/test-run-command.c: delete duplicate include
Date:   Sun, 13 Mar 2022 19:55:36 +0000
Message-Id: <20220313195536.224075-6-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220313195536.224075-1-gitter.spiros@gmail.com>
References: <20220313195536.224075-1-gitter.spiros@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

parse-options.h is included more than once.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/helper/test-run-command.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 8f370cd89f..1b35a143c1 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -19,7 +19,6 @@
 #include "thread-utils.h"
 #include "wildmatch.h"
 #include "gettext.h"
-#include "parse-options.h"
 
 static int number_callbacks;
 static int parallel_next(struct child_process *cp,
-- 
2.35.1

