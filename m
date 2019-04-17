Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9F2F20248
	for <e@80x24.org>; Wed, 17 Apr 2019 10:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731725AbfDQKZH (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 06:25:07 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34345 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729091AbfDQKZH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 06:25:07 -0400
Received: by mail-wm1-f67.google.com with SMTP id r186so4318158wmf.1
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 03:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=YhsYHfaZv3tn5mxlDC5N2Fh7f/+c7rWISBZasCsHUqU=;
        b=TP4dhefkSxrV9k3Z2LXLm6IuH+/L271FIrfhTqEcdKcMuxVOeL21XZLSwVv+T0byYM
         Z0Cewce7NTmBbj4LCH6Lq7hwbKSBBxaEBZj+9w3Z7ffOFG7KIhhJpZ2LTa/qeClx7Vss
         HTLFvM9ZIfuXdglZJV6AK6+NK/WMLvBNiXbQQhxAkdpOmHJlf5RQK7gpyou8VJ9dEnbE
         2T8oGbg9nv6e643rNQ/aEGwQWkKFVwnhIOGkawpelQuHG5T2r85l5ux/GPcRkDWNaX+u
         sjhVAtnks4iNZUGCOV6pm7TG22xMuR5m4thyVnqBJzD3WNt355lyVEQdkN6vjKO0E+Yo
         1deA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=YhsYHfaZv3tn5mxlDC5N2Fh7f/+c7rWISBZasCsHUqU=;
        b=YvEkZ+lxYB4NFQof+jGr5d16JXsYfsh73iOVFDh+Sf34hm4kahANOIF+3gys2Qrc2k
         ELg6TeaJAXO/4KoXv6DXBvC4NScm0TdhyjVnEQjxb0HY+76HdIzkq48jnE22nRRBgyMR
         PlSFgyUEIGJX0fXFkKPzdQi+RUZK2N2NWqjxN/QT0csmk7YiJby7j/hyG+nfnyAI53Rr
         lL5U8748X3dGYp9nsreiLoL6X7eAIKZrPSXVub6IPJ889Gr71iMsEMW1EwlP1tlkKQoY
         QmkyvY7ZVOJX4elVqSwVRpK1L0TFa+hbrK1UahxtBqixefdeXRzRT1UjZfWN8qCcC/py
         oJxA==
X-Gm-Message-State: APjAAAVJLyNaVUDY/wKtEGETmLjovC51viIU5e8WnZKas1B3aTQTYRkA
        ArcmoVYf1ZdbsxEvBvqzHqg=
X-Google-Smtp-Source: APXvYqzhpDxvkOQnZmtYM723IqlNwJsU86H8yG0Q0QAruiptGAQFxsNp3M1fWvosBOKyWy55orUjow==
X-Received: by 2002:a1c:4d02:: with SMTP id o2mr30328306wmh.134.1555496705123;
        Wed, 17 Apr 2019 03:25:05 -0700 (PDT)
Received: from lindisfarne.localdomain (host-92-22-21-176.as13285.net. [92.22.21.176])
        by smtp.gmail.com with ESMTPSA id a11sm53399903wrx.5.2019.04.17.03.25.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 03:25:04 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v10 06/10] parse-options.h: extract common --cleanup option
Date:   Wed, 17 Apr 2019 11:23:26 +0100
Message-Id: <20190417102330.24434-7-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190417102330.24434-1-phillip.wood123@gmail.com>
References: <cover.1553150827.git.liu.denton@gmail.com>
 <20190417102330.24434-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Denton Liu <liu.denton@gmail.com>

The --cleanup option is commonly used. Extract it so that its definition
is not repeated.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/commit.c | 2 +-
 builtin/tag.c    | 3 +--
 parse-options.h  | 1 +
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 0df15e4851..8277da8474 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1473,7 +1473,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('s', "signoff", &signoff, N_("add Signed-off-by:")),
 		OPT_FILENAME('t', "template", &template_file, N_("use specified template file")),
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
-		OPT_STRING(0, "cleanup", &cleanup_arg, N_("default"), N_("how to strip spaces and #comments from message")),
+		OPT_CLEANUP(&cleanup_arg),
 		OPT_BOOL(0, "status", &include_status, N_("include status in commit message template")),
 		{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key-id"),
 		  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
diff --git a/builtin/tag.c b/builtin/tag.c
index 02f6bd1279..a3870fbdba 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -397,8 +397,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_FILENAME('F', "file", &msgfile, N_("read message from file")),
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of tag message")),
 		OPT_BOOL('s', "sign", &opt.sign, N_("annotated and GPG-signed tag")),
-		OPT_STRING(0, "cleanup", &cleanup_arg, N_("mode"),
-			N_("how to strip spaces and #comments from message")),
+		OPT_CLEANUP(&cleanup_arg),
 		OPT_STRING('u', "local-user", &keyid, N_("key-id"),
 					N_("use another key to sign the tag")),
 		OPT__FORCE(&force, N_("replace the tag if exists"), 0),
diff --git a/parse-options.h b/parse-options.h
index 74cce4e7fc..b93169337f 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -314,5 +314,6 @@ int parse_opt_passthru_argv(const struct option *, const char *, int);
 #define OPT_NO_CONTAINS(v, h) _OPT_CONTAINS_OR_WITH("no-contains", v, h, PARSE_OPT_NONEG)
 #define OPT_WITH(v, h) _OPT_CONTAINS_OR_WITH("with", v, h, PARSE_OPT_HIDDEN | PARSE_OPT_NONEG)
 #define OPT_WITHOUT(v, h) _OPT_CONTAINS_OR_WITH("without", v, h, PARSE_OPT_HIDDEN | PARSE_OPT_NONEG)
+#define OPT_CLEANUP(v) OPT_STRING(0, "cleanup", v, N_("mode"), N_("how to strip spaces and #comments from message"))
 
 #endif
-- 
2.21.0

