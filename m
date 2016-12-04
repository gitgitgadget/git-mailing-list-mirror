Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D17431FBB0
	for <e@80x24.org>; Sun,  4 Dec 2016 22:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751176AbcLDWQ4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Dec 2016 17:16:56 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35212 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750917AbcLDWQz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Dec 2016 17:16:55 -0500
Received: by mail-pg0-f65.google.com with SMTP id p66so14319466pga.2
        for <git@vger.kernel.org>; Sun, 04 Dec 2016 14:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=YV+O7NfIV5yrMTFvk6YoqPslfhlqHwHwhsxx0ROK3N4=;
        b=RJw8UpmCGB/hiw4pNnfrkrhydg96d/tHMB7kYbkxz3ID7IlChaSGkiHq3wBhuXQjdg
         47wiRYL9GYaLiMBimojuLwxH2LVkZJIwtmxFofRTNLSQxeLq7YB0R9FwHoGEShynmUb8
         i5hJAlOF6o1hhUuQLaBaMrxyejL3/RrJh+TIoW+IhuHCgeZNfDFAOQUYNXP3V45kh0GZ
         w7leCc73srlij63qtDzmcjRv7bO9gphTnOuz6pqePsg/oK8RluhRcJFFmYAtID+eEXeN
         dmRSCAWwK/kgWkIsTTIUjHgPi3A0TKsZMNDryIlS0dJ3GNMeS2RrACE3RLUa9l0CADrm
         q4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YV+O7NfIV5yrMTFvk6YoqPslfhlqHwHwhsxx0ROK3N4=;
        b=JaIRP8YFKMvs4q0uORKCiMGj/RKQadwfCa+8BF5kWoBuDbZAwk6dK1XvvNfXYrFVai
         qTdyZdsCT0ZrXuqo9yZR6/ucJbSjHX83H8AtRKfu0boye+lfySLGVBDpepeEv+Hpjbwy
         euCzErUreyDHwqT+zwgzNqGSUlXu584uf4ekbg0OnmIED/Q25LuHSbk5mbr/Wqx2zw/N
         +vvRqnOvKJNJuEFBAEHWvx2uvMTYQvQ88a3khGDjv20fs2pPfDPHa96FZbY7O7LDBMZh
         XIjXB5HwTQzTixRBVnkytD1VAjHHZjadNX+RUXfWrHdchhu11LsM4EXHXtesqG7Sp5vJ
         +OAQ==
X-Gm-Message-State: AKaTC02gJZl1FaCkmxhaWEw9/wup9ERXIJiqcXtzK7UU1TY9JFRtlGwzyV5c+Wpb1ieaCw==
X-Received: by 10.99.120.13 with SMTP id t13mr94505026pgc.17.1480889055258;
        Sun, 04 Dec 2016 14:04:15 -0800 (PST)
Received: from wolverine.hsd1.ut.comcast.net ([2601:681:4101:1302:e8b:fdff:fecc:2734])
        by smtp.gmail.com with ESMTPSA id a30sm22122304pgd.45.2016.12.04.14.04.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Dec 2016 14:04:13 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     pclouds@gmail.com, gitster@pobox.com, git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] clone,fetch: explain the shallow-clone option a little more clearly
Date:   Sun,  4 Dec 2016 15:03:59 -0700
Message-Id: <20161204220359.30807-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"deepen by excluding" does not make sense because excluding a revision
does not deepen a repository; it makes the repository more shallow.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/clone.c | 2 +-
 builtin/fetch.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 6c76a6e..e3cb808 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -99,7 +99,7 @@ static struct option builtin_clone_options[] = {
 	OPT_STRING(0, "shallow-since", &option_since, N_("time"),
 		    N_("create a shallow clone since a specific time")),
 	OPT_STRING_LIST(0, "shallow-exclude", &option_not, N_("revision"),
-			N_("deepen history of shallow clone by excluding rev")),
+			N_("deepen history of shallow clone, excluding rev")),
 	OPT_BOOL(0, "single-branch", &option_single_branch,
 		    N_("clone only one branch, HEAD or --branch")),
 	OPT_BOOL(0, "shallow-submodules", &option_shallow_submodules,
diff --git a/builtin/fetch.c b/builtin/fetch.c
index b6a5597..fc74c84 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -122,7 +122,7 @@ static struct option builtin_fetch_options[] = {
 	OPT_STRING(0, "shallow-since", &deepen_since, N_("time"),
 		   N_("deepen history of shallow repository based on time")),
 	OPT_STRING_LIST(0, "shallow-exclude", &deepen_not, N_("revision"),
-			N_("deepen history of shallow clone by excluding rev")),
+			N_("deepen history of shallow clone, excluding rev")),
 	OPT_INTEGER(0, "deepen", &deepen_relative,
 		    N_("deepen history of shallow clone")),
 	{ OPTION_SET_INT, 0, "unshallow", &unshallow, NULL,
-- 
2.10.2

