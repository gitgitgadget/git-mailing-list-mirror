Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD96520248
	for <e@80x24.org>; Sun, 24 Feb 2019 22:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfBXWMN (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 17:12:13 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41339 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbfBXWMN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 17:12:13 -0500
Received: by mail-ed1-f67.google.com with SMTP id x7so5980311eds.8
        for <git@vger.kernel.org>; Sun, 24 Feb 2019 14:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5ccghqqIFhwP2Tu1sO0/m2YKOC2xJT72msCYauDe+AM=;
        b=UoHdPwg08lcGjlr3wcL845rim8pobScVDDe+k3Ikn+YYU3GjVjak47iDN6zoKHZil4
         7Pg3hqPKMM76iCPXsthh5X8imvRKMoM8VaxA4Ds4LI+voMZSF2S7vbi2wWzx8Sswznml
         jqNTInEf4NlyS5DdOFeEZSMh7EIYwSKB81fQgK5XJu3+kyhwu2TBnfxXFEiMiLlsATO9
         gdH5YSdaixC5GG5FzU2FedQW+JlYictVH4wyQ8YWeqIhZf1Nme6tojDHK335wwqTFG4x
         TYgM/gs8VeshXpaBsnxoh1nQuZtmAVsYHPKHNwBTLj8+lMI92veSUHcLovAfvKDw9OHY
         asLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5ccghqqIFhwP2Tu1sO0/m2YKOC2xJT72msCYauDe+AM=;
        b=lzA7w80OdyFDrw091LWTIpf5bwABFjQcrrbThkP5z9Pq84vTUhhuntYHj/c7H+tWPG
         NPAKkCWE6oEaGDOy6tuZKRP5w+qNUpJke8XOrC5clh+nrKI4vAVhWITRgCy0vL16dub4
         nZ2r11ncGSTNXl4J69+724z1HCyNICEWESyNqWy8e3Uv3ry4J3QCDrk0THJS0aRw4jTn
         Y2xrEXQs3AquBnUo5LMdgtCkyHyx/yGS7g7uX9d6SFlBAnuDVbpGMEmqdOhNx6N0NJmh
         o6LJ5jIXEtZZTrlVTE5vetvgMX8R9+ZMIo1nmM5k5nM6567x1tmHrGEYT47bDCYLzZY5
         r8vA==
X-Gm-Message-State: AHQUAuZ0WGMT0u9GfrwF/5G4zl1mQhJgr/qEbsdLRP5PvGm5YQT+6k+E
        trHvDKsjkU3rEJekbxUvObX4381A
X-Google-Smtp-Source: AHgI3IYy+pu6f1wkwv1Ol/3M5dc6NN/ZUyzU/XZwvKXJBkajItsUZlP7+Rxr9MLtV/BYDLpPX0jGAw==
X-Received: by 2002:a17:906:2dda:: with SMTP id h26mr10726739eji.26.1551046331597;
        Sun, 24 Feb 2019 14:12:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i8sm2205972edg.21.2019.02.24.14.12.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 14:12:11 -0800 (PST)
Date:   Sun, 24 Feb 2019 14:12:11 -0800 (PST)
X-Google-Original-Date: Sun, 24 Feb 2019 22:12:09 GMT
Message-Id: <5fa4fcad63e18dd9d840217eb8cf3dab8f69bc1b.1551046329.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.139.git.gitgitgadget@gmail.com>
References: <pull.139.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] fixup! upload-pack: refactor reading of pack-objects out
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This fixes an issue pointed out by clang.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 upload-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/upload-pack.c b/upload-pack.c
index 2365b707bc..534e8951a2 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -179,7 +179,7 @@ static void create_pack_file(const struct object_array *have_obj,
 			     const struct string_list *uri_protocols)
 {
 	struct child_process pack_objects = CHILD_PROCESS_INIT;
-	struct output_state output_state = {0};
+	struct output_state output_state = {"\0"};
 	char progress[128];
 	char abort_msg[] = "aborting due to possible repository "
 		"corruption on the remote side.";
-- 
gitgitgadget
