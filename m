Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCDCC20A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 18:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbeLJSrS (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 13:47:18 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43569 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728420AbeLJSrQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 13:47:16 -0500
Received: by mail-pl1-f194.google.com with SMTP id gn14so5646965plb.10
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 10:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jPuGp/yyrh6ei6UgitHqf2ugLpWewTHKCFwAxf7Ty58=;
        b=UqXStfqD/CQDionIwFhiA5X1zs3PPIehRFH4m2KQqS/N6M3LJxeLNasTFSVzi/j00L
         ZjGNJLpu4oNWuGvPhL/GFEy63bUpm4xPST3GeCXIuvPX+1nvOIb2NRd0cTecKTcyiRVd
         731/ardg0xyWZrxXIiSvgelx7qE82u4EL1JJsFwDH3VARc7XF7blpZB7VnrKgDIT7Ftz
         D7o+NFDpfnS9KAb17WX0GwO26AokxZQa9KTpnHLTzkyp1B0S/6rMGT/zoNdvuOnRDB+D
         oz89wWCi33OthOWwvKILMgjV1icQkVLkPhlzWvaRvqwR6WE3BXb6y27ZYYHu+A5H7yao
         Lg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jPuGp/yyrh6ei6UgitHqf2ugLpWewTHKCFwAxf7Ty58=;
        b=axOV4ac9ExGK5DR48IZ00n83bTz3j/jLqRYFdoCSnSnqH5gwNObGbrMluIPO4Y1kJE
         25WFKhv6chlslUdxJ9CzOeXZg03uzg2hNvByMtBQfhH0Gaq9D6aY3OeWddj3jEBug8Yc
         jJ+zlQQlzAvathfyUhLpnGp6Dp91zUW5JFwt7Z6hAZyCsPKwqPlqtpD9CL7cvo0sZvaC
         q2kpl+fPMYWSisllbyPMdg1toNoP4hqD27e+rqhoIuzMztYBhaBGXc7bfCQrOtXKQ3Ur
         qWPqHEu6Kj9BFkkbMQhw5yES9muV2wU5RNbrMDG/82kiYGHKNkCNjqaAuQn9MHR74+IK
         XONw==
X-Gm-Message-State: AA+aEWahzbI8k9rm0duKK7bSNCfPS+2mi3V7lgpixuCHTK+Hb0EQBh8e
        jpOUjIt0vm2WiiW4WnLS/K7b/JBh
X-Google-Smtp-Source: AFSGD/VxQa9HmMFN5AQA1bGZXv3pKM8oBQAHnAHgaqX1bJzJlFd6hcbB1AkJkm8orXzX7MclWBRhKw==
X-Received: by 2002:a17:902:50e:: with SMTP id 14mr12953315plf.141.1544467636069;
        Mon, 10 Dec 2018 10:47:16 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id h134sm22257197pfe.27.2018.12.10.10.47.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 10:47:15 -0800 (PST)
Date:   Mon, 10 Dec 2018 10:47:15 -0800 (PST)
X-Google-Original-Date: Mon, 10 Dec 2018 18:47:11 GMT
Message-Id: <50ac31ef7f4380f37a0e2d3b75e82b324afee9e3.1544467631.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.96.git.gitgitgadget@gmail.com>
References: <pull.96.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/2] mingw: allow absolute paths without drive prefix
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When specifying an absolute path without a drive prefix, we convert that
path internally. Let's make sure that we handle that case properly, too
;-)

This fixes the command

	git clone https://github.com/git-for-windows/git \G4W

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c            | 10 +++++++++-
 t/t5580-clone-push-unc.sh |  2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 34b3880b29..4d009901d8 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -928,11 +928,19 @@ unsigned int sleep (unsigned int seconds)
 char *mingw_mktemp(char *template)
 {
 	wchar_t wtemplate[MAX_PATH];
+	int offset = 0;
+
 	if (xutftowcs_path(wtemplate, template) < 0)
 		return NULL;
+
+	if (is_dir_sep(template[0]) && !is_dir_sep(template[1]) &&
+	    iswalpha(wtemplate[0]) && wtemplate[1] == L':') {
+		/* We have an absolute path missing the drive prefix */
+		offset = 2;
+	}
 	if (!_wmktemp(wtemplate))
 		return NULL;
-	if (xwcstoutf(template, wtemplate, strlen(template) + 1) < 0)
+	if (xwcstoutf(template, wtemplate + offset, strlen(template) + 1) < 0)
 		return NULL;
 	return template;
 }
diff --git a/t/t5580-clone-push-unc.sh b/t/t5580-clone-push-unc.sh
index c2b0082296..17c38c33a5 100755
--- a/t/t5580-clone-push-unc.sh
+++ b/t/t5580-clone-push-unc.sh
@@ -29,7 +29,7 @@ case "$UNCPATH" in
 	;;
 esac
 
-test_expect_failure 'clone into absolute path lacking a drive prefix' '
+test_expect_success 'clone into absolute path lacking a drive prefix' '
 	USINGBACKSLASHES="$(echo "$WITHOUTDRIVE"/without-drive-prefix |
 		tr / \\\\)" &&
 	git clone . "$USINGBACKSLASHES" &&
-- 
gitgitgadget
