Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,URIBL_BLACK,
	URIBL_DBL_SPAM shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80B331F453
	for <e@80x24.org>; Thu,  1 Nov 2018 12:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbeKAVFn (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 17:05:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51692 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbeKAVFn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 17:05:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id w7-v6so1164127wmc.1
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 05:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l/2Dlumwjj1Xe6rzOcO06HupXx209aDWI2zE44n3fDc=;
        b=iO9AH207bZa9Fi2YneOagU2MnCscyEtdsCp0cF8u+iQrL7+ObUcf4w8mWqYlJKZiGq
         X/EWQQ0ywK07il6u5LYNK935urPzq2mCfkZz8lRsm6INyfwUj8LK6gqaFWu4C24Qan17
         XlS9Pzj7uCPXxpN9ZbKOEUeEt+XC8Ip3J5hRi8t/T3d88nU83Xt8BBIeuOpLun4YbsxU
         26WNDFIyrE81aHcIVNdu+6d46JAUKvRYsctGO2fqKNXrWdI0t0MpY9e95x69mzsKtTCT
         jYalxzEestRVVQhX6kEAaBcUSBIZexvSm8tQ2u6cUT9qqNzBi3Vkez/wc1q2xupjha3G
         tojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l/2Dlumwjj1Xe6rzOcO06HupXx209aDWI2zE44n3fDc=;
        b=X0S/iSQoRn5xaCfdP987tdZzxcD3juzMLUfP7PbozOPxNuzW0/AT0HEbykqR+v4kKK
         hdi2fuZNrodeCgpSO29NMk03xtljFNaaMU6/VBS6EI2dP/TF21Q1gwd86XnlefOBCFVr
         8Sp6/kLgkEyhXqX6y/E3Qj+t8lhyGF4PHQcCbQgvMzjPn7wZ+PjBvuUXSAuY8icAxzpM
         1V+01R73XuqDHJ/MsjkF7M/ypUDcTSMCP7cqBZPoS0bRFdvsnDThYAwa7buLa/cyotdZ
         Lkn+/WF+UJC2SHWNROl3ZNwr7o1PMI8DYoIR0yotAv4fpBohoeCRUD64ARpuzfP+RVkD
         XQ/Q==
X-Gm-Message-State: AGRZ1gIBF0kYjwWWoim2RIeK3xB8GKJTrvH30UqSt4XU60wFT3j00dvu
        JzgY4KbYRq7BOurt0UwjvPc=
X-Google-Smtp-Source: AJdET5cp5wiSICwQTmFDweSXqNFfDboVasKzquDZVe7uJIPn9Gy9eM3rLklMnanflMw74qIsOxfshQ==
X-Received: by 2002:a1c:950f:: with SMTP id x15-v6mr5227885wmd.3.1541073781697;
        Thu, 01 Nov 2018 05:03:01 -0700 (PDT)
Received: from localhost.localdomain ([31.223.156.57])
        by smtp.gmail.com with ESMTPSA id o188-v6sm2666544wmg.9.2018.11.01.05.03.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 05:03:01 -0700 (PDT)
From:   Slavica Djukic <slavicadj.ip2018@gmail.com>
X-Google-Original-From: Slavica Djukic <slawica92@hotmail.com>
To:     slavicadj.ip2018@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        slawica92@hotmail.com
Subject: [PATCH 3/3] [Outreachy] stash: use set_fallback_ident() function
Date:   Thu,  1 Nov 2018 13:02:39 +0100
Message-Id: <20181101120239.15636-1-slawica92@hotmail.com>
X-Mailer: git-send-email 2.19.1.windows.1
In-Reply-To: <20181101115546.13516-1-slawica92@hotmail.com>
References: <20181101115546.13516-1-slawica92@hotmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Call set_fallback_ident() in cmd_stash() and update test
from the first commit to expect success.

Executing stash without user.name and user.email configured
can be useful when bots or similar users use stash, without anyone
specifing valid ident. Use case would be automated testing.
There are also users who  find this convinient.
For example, in this thread:
https://public-inbox.org/git/87o9debty4.fsf@evledraar.gmail.com/T/#ma4fb50903a54cbcdecd4ef05856bf8094bc3c323
user points out that he would find it useful if stash had --author option.

Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
---
 builtin/stash.c  | 1 +
 t/t3903-stash.sh | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 965e938ebd..add30aae64 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1523,6 +1523,7 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
 	trace_repo_setup(prefix);
 	setup_work_tree();
 
+	set_fallback_ident("git stash", "stash@git.commands");
 	git_config(git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, options, git_stash_usage,
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index aaff36978e..06a2ffb398 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1156,7 +1156,7 @@ test_expect_success 'stash -- <subdir> works with binary files' '
 	test_path_is_file subdir/untracked
 '
 
-test_expect_failure 'stash works when user.name and user.email are not set' '
+test_expect_success 'stash works when user.name and user.email are not set' '
 	git reset &&
 	>1 &&
 	git add 1 &&
-- 
2.19.1.windows.1

