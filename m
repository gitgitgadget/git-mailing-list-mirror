Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9A0C47089
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 21:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbiLEVEv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 16:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbiLEVEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 16:04:25 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B5F2A408
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 13:03:38 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id m14so20707805wrh.7
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 13:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sdiw0KoeKYls4SN0B93nawEsjtT9XHHrrVAQbu6zMKg=;
        b=JjjyGqbJzxOcobCyezRT2BCxlV9gIMf+ziLta3sQLU9EwbXi+iAw9oLzPo60JYOqgg
         TNsrFAV0iwRBtT9DMOQ7frYnAbzophup6nUlKHkE9cUEgpLJm4UUABnGem9kJeSRha5K
         tx/r0+zOHjGq7riz1ib1CfcI1cykVAeEHmc1SsM8l0KDdJMjeAecDKDx6hcyAvodqDU1
         QKpMkiZ30BDNO0SKaXiYZdFVykUem5bSDsNiZhgLmD9Tcxy3jymyNRyr+BogxxDheNJp
         tSbUXvNrGp3OrPCQ/c3K8A2opXPWlbiT+DjUx90TWmbxys+7/0B3yVFge8jN28XmlzhU
         livQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sdiw0KoeKYls4SN0B93nawEsjtT9XHHrrVAQbu6zMKg=;
        b=bykLca1+F3XjpqODCFW7Ur9JYD6/kQfEO80WfqyuLOe29+1PUNcpMZe3U31cYFqjJQ
         S+YXA/VTZoOsuznmvHKlpLCIlwbhoDFFRjxzsDvo9LCmZfXDQV4/9byrh5uxIUTDnnSJ
         xf/kwkCAN9nNf8tHsv8qZNxohf1HQzvEDbWBUVW0/8PGdh5uWrZVyCM6eSQ8Y2PMr5Hd
         ajw03j1CW1NCrqwrzQ2LTcW1hcCNCxJG2a18I0hGAYGdYQSPBsoFyO4S+fhcrYhpsz7q
         q4qwnF9KZn3gNv672jzfgYhI5I1ttaUzR8HAfPenzqm6PLw81JdLSG4nEfeWaroc0FDm
         HQdg==
X-Gm-Message-State: ANoB5pkxAWascYmIlYXM4w2e7t6SMpXQXrCiRaj0XkBOt8zwIDGwpUEJ
        EzHSTdklnaCrJksuTdcbie4e9o5+3qw=
X-Google-Smtp-Source: AA0mqf7tRSPJdwfjLVwadmHyMwOUIvaolWaHHSul1LB+Z+MNkKY/L7LE2PHpaIfDIVVbnNyx+657Xw==
X-Received: by 2002:adf:f54e:0:b0:242:1534:7b57 with SMTP id j14-20020adff54e000000b0024215347b57mr24458207wrp.404.1670274217001;
        Mon, 05 Dec 2022 13:03:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g3-20020a5d5543000000b0022cc0a2cbecsm14977547wrw.15.2022.12.05.13.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 13:03:36 -0800 (PST)
Message-Id: <bc79dfcc4d44e0f006dc64d75a2c7f8a11834229.1670274213.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1433.git.1670274213.gitgitgadget@gmail.com>
References: <pull.1433.git.1670274213.gitgitgadget@gmail.com>
From:   "Harshil-Jani via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 05 Dec 2022 21:03:32 +0000
Subject: [PATCH 1/2] mingw: remove duplicate `USE_NED_ALLOCATOR` directive
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Harshil Jani <harshiljani2002@gmail.com>,
        Harshil-Jani <harshiljani2002@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Harshil-Jani <harshiljani2002@gmail.com>

nedalloc was added to fix the slowness of memory allocator. Here
specifically for the MSys2 build there seems to be a duplication of
USE_NED_ALLOCATOR directive. So this patch intends to remove the
duplicate USE_NED_ALLOCATOR and keeping it only into the MSys2 config
section so it still uses the nedalloc.

Signed-off-by: Harshil-Jani <harshiljani2002@gmail.com>
---
 config.mak.uname | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index d63629fe807..377667c4bbc 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -652,7 +652,6 @@ ifeq ($(uname_S),MINGW)
 	USE_WIN32_IPC = YesPlease
 	USE_WIN32_MMAP = YesPlease
 	MMAP_PREVENTS_DELETE = UnfortunatelyYes
-	USE_NED_ALLOCATOR = YesPlease
 	UNRELIABLE_FSTAT = UnfortunatelyYes
 	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
 	NO_REGEX = YesPlease
-- 
gitgitgadget

