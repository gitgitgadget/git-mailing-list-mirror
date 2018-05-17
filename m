Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF6891F51C
	for <e@80x24.org>; Thu, 17 May 2018 19:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752080AbeEQTrR (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 15:47:17 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:43153 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751530AbeEQTrP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 15:47:15 -0400
Received: by mail-pg0-f65.google.com with SMTP id p8-v6so2251734pgq.10
        for <git@vger.kernel.org>; Thu, 17 May 2018 12:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JZe6LTLybs78Vu4i4xAU++c5IGxsvs3chJeUH7R5PyQ=;
        b=HE5SofqzAK78eP89IehOFAbEPSuF+nYkf27j4RPIULB3O58MYS4EKJCRZBe3rQU0t6
         QJgSJi710gkNlc7BYbx1PMqnYlKPU31rlkeVuN8Hv+hKGXq7H/XL5kjL/gitrnqLPEal
         cJ9SPfd0+D3ZnRMj7AG2D3Ml9Xlgn+K1IuegO+tgIAg9SdAfnVT48vHrU9bs6QAJnUMp
         BWaWTDCVwWJCfMmHJqlwGyI3vvH0YMyfQROZutIhmXgEcx1Vxns0rE3QQRHNhluKOSRB
         xg3OlrpDxXqykLJAYihtZu2baZQ5gZ2R6JaxSWSUkRnWgWCo2coMxmB+x+wMhtjFIxxw
         DdXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JZe6LTLybs78Vu4i4xAU++c5IGxsvs3chJeUH7R5PyQ=;
        b=bn86ci15ALsjAPIewwoiaP2xPzsvHgRoYUYbsxs9ipRmn6MeV8PXDru4A6lpfzX1f2
         kvYsJcg08zQqr2jMLEXnLxO/D2LFwh6Rrxy9jzztPF+Dvcl945em75hDBttWrIlTWP2Q
         oAImFJHrgFdVtggeF9zL+qad74VwmfttWwtkeV8zfWK37MtoX+5QPfkovRWJdUxIDSkC
         HPHiHfxuyQtOyCF/5M/Js1RT8gZmVzDT/pfVi6UsMxMzYytMasVCYO2D0eynrhBPO4yM
         bD2ygpSMDUooSoAZniT5eJELBlJ4g4nSCmMqixupsB/nP7QkpGxXJvr1T9Zr08G350yz
         A7Mg==
X-Gm-Message-State: ALKqPwfnSFVcMazbQOG5fvEYDZCh2r1pYLAWUFjjsWd0Y8lkK8Xo9/Cp
        8gMT5deP42VIU17ulR9pReBOuUUokQU=
X-Google-Smtp-Source: AB8JxZp7//8BPdK+90KWL+iJo/Vvw5TyWwxQ3kiHwLbpttmnSMZXW+LjCKY7oGrL4utMZS6VUTpZuw==
X-Received: by 2002:a63:350d:: with SMTP id c13-v6mr816128pga.426.1526586434818;
        Thu, 17 May 2018 12:47:14 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id s4-v6sm7101859pgp.35.2018.05.17.12.47.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 12:47:14 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com
Subject: [PATCH 8/8] diff: color-moved white space handling options imply color-moved
Date:   Thu, 17 May 2018 12:46:53 -0700
Message-Id: <20180517194653.48928-9-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180517194653.48928-1-sbeller@google.com>
References: <CAGZ79kY1DOgrbkgUWHb+5KSBjrupHod0n8SU6M+xMnBGjMTmZQ@mail.gmail.com>
 <20180517194653.48928-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When giving options how move coloring should treat white spaces, the user
expects that move coloring is actually active. If it is not active, we
can just take the default mode.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c                     | 18 +++++++++++++-----
 t/t4015-diff-whitespace.sh |  9 +++++++--
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/diff.c b/diff.c
index 1227a4d2a83..a10184e576e 100644
--- a/diff.c
+++ b/diff.c
@@ -4713,15 +4713,23 @@ int diff_opt_parse(struct diff_options *options,
 		options->color_moved_ws_handling &= ~XDF_IGNORE_WHITESPACE_AT_EOL;
 	else if (!strcmp(arg, "--color-moved-no-ignore-space-prefix-delta"))
 		options->color_moved_ws_handling &= ~COLOR_MOVED_DELTA_WHITESPACES;
-	else if (!strcmp(arg, "--color-moved-ignore-all-space"))
+	else if (!strcmp(arg, "--color-moved-ignore-all-space")) {
+		if (options->color_moved == COLOR_MOVED_NO)
+			options->color_moved = COLOR_MOVED_DEFAULT;
 		options->color_moved_ws_handling |= XDF_IGNORE_WHITESPACE;
-	else if (!strcmp(arg, "--color-moved-ignore-space-change"))
+	} else if (!strcmp(arg, "--color-moved-ignore-space-change")) {
 		options->color_moved_ws_handling |= XDF_IGNORE_WHITESPACE_CHANGE;
-	else if (!strcmp(arg, "--color-moved-ignore-space-at-eol"))
+		if (options->color_moved == COLOR_MOVED_NO)
+			options->color_moved = COLOR_MOVED_DEFAULT;
+	} else if (!strcmp(arg, "--color-moved-ignore-space-at-eol")) {
 		options->color_moved_ws_handling |= XDF_IGNORE_WHITESPACE_AT_EOL;
-	else if (!strcmp(arg, "--color-moved-ignore-space-prefix-delta"))
+		if (options->color_moved == COLOR_MOVED_NO)
+			options->color_moved = COLOR_MOVED_DEFAULT;
+	} else if (!strcmp(arg, "--color-moved-ignore-space-prefix-delta")) {
 		options->color_moved_ws_handling |= COLOR_MOVED_DELTA_WHITESPACES;
-	else if (!strcmp(arg, "--indent-heuristic"))
+		if (options->color_moved == COLOR_MOVED_NO)
+			options->color_moved = COLOR_MOVED_DEFAULT;
+	} else if (!strcmp(arg, "--indent-heuristic"))
 		DIFF_XDL_SET(options, INDENT_HEURISTIC);
 	else if (!strcmp(arg, "--no-indent-heuristic"))
 		DIFF_XDL_CLR(options, INDENT_HEURISTIC);
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 37ff528822f..e1ab08d7bb4 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1875,7 +1875,11 @@ test_expect_success 'compare whitespace delta across moved blocks' '
 
 	git diff --color --color-moved --color-moved-ignore-space-prefix-delta |
 		grep -v "index" |
-		test_decode_color >actual &&
+		test_decode_color >actual1 &&
+
+	git diff --color --color-moved-ignore-space-prefix-delta |
+		grep -v "index" |
+		test_decode_color >actual2 &&
 
 	q_to_tab <<-\EOF >expected &&
 		<BOLD>diff --git a/text.txt b/text.txt<RESET>
@@ -1898,7 +1902,8 @@ test_expect_success 'compare whitespace delta across moved blocks' '
 		<BOLD;YELLOW>+<RESET><BOLD;YELLOW>not adjust<RESET>
 	EOF
 
-	test_cmp expected actual
+	test_cmp expected actual1 &&
+	test_cmp expected actual2
 '
 
 test_done
-- 
2.17.0.582.gccdcbd54c44.dirty

