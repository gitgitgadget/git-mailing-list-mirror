Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7900D1F89C
	for <e@80x24.org>; Sat, 21 Jan 2017 20:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751030AbdAUUIA (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jan 2017 15:08:00 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34176 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750889AbdAUUH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2017 15:07:57 -0500
Received: by mail-wm0-f67.google.com with SMTP id c85so15525843wmi.1
        for <git@vger.kernel.org>; Sat, 21 Jan 2017 12:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xKE7DyvXbMrtxgVV2kcj3HVgNnH5BjpJ+DZNrXkS+ig=;
        b=LnTSmKhTSMDotcrr6s6gAx0Eq5QzDXVxBeE8Y0BgoEe+s9iGDDWP+kaSL5V4ssE8U6
         dYGKto6jRCUvxQGs3dcSmgWzV3o+ZNpyhDGZlA77486KMMJDN83lddEQ82H+KUnJu+Qi
         VfGchK1oZ8JFCRrjwLeuhmgCjRdLjsFek1CtIkQIWmEECM6jXed0JqtWuuIQhP4kCA1B
         +fqRo+TYg1d+SVd/JZXk1P2aZC0Ui9+8vaEkVbmAafdeO0hEohjihwmB1tx7CrzjzXyb
         itNHG5JM82PtFcwFLi0OSgEGkjw9pQp4Jv7HBGEhsEogw3q89hdt6Ed2szcBTs07c0w2
         crTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xKE7DyvXbMrtxgVV2kcj3HVgNnH5BjpJ+DZNrXkS+ig=;
        b=Qtin9RVcuG4dL5lV7lINkHiSOe3uv7DkqbsBcUVSWIB3Kx6ecXzSLvBbDAHNym6LjK
         cE7SFnRr2tXbS5MVBgyhS4p2L9UtL4Lelilnk6/CXIqz8Nk5uj2p3ruB5Ic9v4PLGypY
         +mcCIVj7tv7ORhVv2itJd7LwOdqy/NmwDKNO9jXnXwVSnCLLIjBmYpubMiVIRqz7ZRDe
         hJBZ39amzdQ2fYUoK2XwD5pH7wVaJUQkeDwRVz/Iewvjv7TVybgZNupksoOPenqtPZnz
         8m5IzJSMfuPo40zd3eVEHbaxq6w/vwS5AcMS3z6hTAqg6BgnyMIFtCQ3V6sM8UW5Sh+S
         KOJw==
X-Gm-Message-State: AIkVDXJk3jGMg34UkJlxPYWgx9YinVfLb+ymUE7T1bRo53WqPTBlxGlTeSxB28eE6KB8cQ==
X-Received: by 10.223.151.205 with SMTP id t13mr17028790wrb.9.1485029276470;
        Sat, 21 Jan 2017 12:07:56 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id e14sm12412975wmd.14.2017.01.21.12.07.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Jan 2017 12:07:55 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Stephan Beyer <s-beyer@gmx.net>,
        Junio C Hamano <gitster@pobox.com>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 1/3] Documentation/stash: remove mention of git reset --hard
Date:   Sat, 21 Jan 2017 20:08:02 +0000
Message-Id: <20170121200804.19009-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c
In-Reply-To: <20170121200804.19009-1-t.gummerer@gmail.com>
References: <20170121200804.19009-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Don't mention git reset --hard in the documentation for git stash save.
It's an implementation detail that doesn't matter to the end user and
thus shouldn't be exposed to them.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-stash.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 2e9cef06e6..0ad5335a3e 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -47,8 +47,9 @@ OPTIONS
 
 save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
 
-	Save your local modifications to a new 'stash', and run `git reset
-	--hard` to revert them.  The <message> part is optional and gives
+	Save your local modifications to a new 'stash', and revert the
+	the changes in the working tree to match the index.
+	The <message> part is optional and gives
 	the description along with the stashed state.  For quickly making
 	a snapshot, you can omit _both_ "save" and <message>, but giving
 	only <message> does not trigger this action to prevent a misspelled
-- 
2.11.0.483.g087da7b7c

