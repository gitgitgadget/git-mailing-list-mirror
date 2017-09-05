Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B792208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 18:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754530AbdIESkS (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 14:40:18 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34478 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754132AbdIESkM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 14:40:12 -0400
Received: by mail-wm0-f66.google.com with SMTP id l19so638679wmi.1
        for <git@vger.kernel.org>; Tue, 05 Sep 2017 11:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vZMbvD9y4ccaoNcV92QAEYJs/tJb/hPYfgF7Q7FvIq0=;
        b=StSa1v8cfMFXMciwtg/JpmAWzYJqnI3wmhElHMk0y3mtuhKZ5ybP+6lw0JOJDBSfUH
         5UT6QMG55Mbv5YIeYJvTARRDPevI+qR3G2joDX8rUvpygXKyTFNKO762vgh4vtliaNty
         sMQYZhFRX5iGUQ9PaoH9mooyH5CZGleesh5KG52XCJ0b+1GS0eg/0/fji5JAgf3HkP6Z
         ofGTmbkBsMBh0YRET4Sa1wLmbk/+QUa1dDxOlWqYPp9oM9ajo4VeOn+ICcIYZGyn4QLG
         ErTuAH+fgt1mUM1z36GcHnWsUnwAQjK5pPh8PCwjaw1p9/0FdM2Yw8A3wl9YkkD/eMrb
         ZEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vZMbvD9y4ccaoNcV92QAEYJs/tJb/hPYfgF7Q7FvIq0=;
        b=FqK8x3fKeMZcKjwegdKeLJre01WHXPlYBCkhd+To9IyXWC803cP8ThPjc1Ko/Ljmfy
         Fa8R7RyNpSecWWGaMW+sVNyE/eJUddNR7fJoKYOp7PDKv7r/QwmL6felrCCme+ycdnBf
         IXRw5hqYzWoe9N9laOhTxXrnBU4E+kcKGi9POeZ/keSFFUR28mzKwzK0+B+SMc4igeij
         95dawmxhDdv+gddiVu4ljYossKWtkTxg7KFW2Yq8XHosHDV0In9TviefuQGs/z/SSfGs
         0jS+2tFsJh8fISJZH7jh/rWo7tUCVd9dvYZ+Bh6vK+7XxpRznwLZgg+RxW2285j/GNEX
         drXw==
X-Gm-Message-State: AHPjjUjxiGuIVehjM1mryv1ZnJ97cYl3j0CCMLsG5Ibn2ccQxKJXb2ij
        teeJx6ltkeVVsJbS
X-Google-Smtp-Source: ADKCNb4215VfJwPbER/JllD8y7sOnHnMCHsAuLHoHzplcWfJJ94cFkUMeA6wqBt2/ug6mcP9YKFOZg==
X-Received: by 10.28.174.80 with SMTP id x77mr556wme.83.1504636810973;
        Tue, 05 Sep 2017 11:40:10 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:1208:b1ff:fee6:d811])
        by smtp.gmail.com with ESMTPSA id 4sm1456856wrl.60.2017.09.05.11.40.09
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Sep 2017 11:40:10 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH] config: remove git_config_maybe_bool
Date:   Tue,  5 Sep 2017 20:39:59 +0200
Message-Id: <20170905183959.22454-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.460.g848a19d64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function was deprecated in commit 89576613 ("treewide: deprecate
git_config_maybe_bool, use git_parse_maybe_bool", 2017-08-07) and has no
users.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
ma/parse-maybe-bool has been in master for some time and I cannot find
any inflight topics which rely on git_config_maybe_bool (neither in pu,
nor on the list). Indeed, it would have been easier to kill this
function immediately instead of deprecating it.

 Documentation/technical/api-config.txt | 4 ----
 config.h                               | 1 -
 config.c                               | 5 -----
 3 files changed, 10 deletions(-)

diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
index 7a83a3a6e..9a778b0ca 100644
--- a/Documentation/technical/api-config.txt
+++ b/Documentation/technical/api-config.txt
@@ -186,10 +186,6 @@ parsing is successful, the return value is the result.
 Same as `git_config_bool`, except that integers are returned as-is, and
 an `is_bool` flag is unset.
 
-`git_config_maybe_bool`::
-Deprecated. Use `git_parse_maybe_bool` instead. They are exactly the
-same, except this function takes an unused argument `name`.
-
 `git_parse_maybe_bool`::
 Same as `git_config_bool`, except that it returns -1 on error rather
 than dying.
diff --git a/config.h b/config.h
index 97471b887..456b3d134 100644
--- a/config.h
+++ b/config.h
@@ -56,7 +56,6 @@ extern unsigned long git_config_ulong(const char *, const char *);
 extern ssize_t git_config_ssize_t(const char *, const char *);
 extern int git_config_bool_or_int(const char *, const char *, int *);
 extern int git_config_bool(const char *, const char *);
-extern int git_config_maybe_bool(const char *, const char *);
 extern int git_config_string(const char **, const char *, const char *);
 extern int git_config_pathname(const char **, const char *, const char *);
 extern int git_config_set_in_file_gently(const char *, const char *, const char *);
diff --git a/config.c b/config.c
index d0d8ce823..f627657cf 100644
--- a/config.c
+++ b/config.c
@@ -956,11 +956,6 @@ int git_parse_maybe_bool(const char *value)
 	return -1;
 }
 
-int git_config_maybe_bool(const char *name, const char *value)
-{
-	return git_parse_maybe_bool(value);
-}
-
 int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
 {
 	int v = git_parse_maybe_bool_text(value);
-- 
2.14.1.460.g848a19d64

