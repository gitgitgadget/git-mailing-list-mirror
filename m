Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D14E620A1E
	for <e@80x24.org>; Mon, 24 Dec 2018 22:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbeLXWeK (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Dec 2018 17:34:10 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:36101 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeLXWeK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Dec 2018 17:34:10 -0500
Received: by mail-ed1-f46.google.com with SMTP id f23so10800163edb.3
        for <git@vger.kernel.org>; Mon, 24 Dec 2018 14:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=V2KTmtqfcELAiDIFNJVkomX7fuexDZC2/X2i9fTvg3k=;
        b=ac+6Iqa28sz0m1NPi4QvJN4AYDGUcnP4uKOo2Lz1VktXo96i8grRexshHy1J9ASI/G
         qIBbQnhsv3CsG0K7wOZA+wfZV2T/iLjeL9c+2UYvJhDnxB6Obq+04JV8FauoXEyrm9y8
         pSRCpoJz2lUZwQtoguTGh49mhXywGDvpTSxTqq4fEYPNJOX2UfrKIjRJGXS04Vb6Bi0C
         iMlRZnvnEBZEAedbdZS94tR7aSM6KtU31x27kLvxPdpy1RvE6yvhNmLdpNx7PiZcBTTG
         SzLRuXV6OcCSZRvFnage4R0aa8chjrtPvZfRz7RtvMbjS9giDWS6jFMvL9vdo940ycju
         3dXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=V2KTmtqfcELAiDIFNJVkomX7fuexDZC2/X2i9fTvg3k=;
        b=fOJqCYmdrsD3gBgNsZtKPRiSN3wGjFv6nARrHA1ByslzAVLRnXHe7MadanR/pUU93f
         Yucfhs/eMAPmX4nQwGofxWS8ku8FBjRV7BGpwHSCmK5Vl8s0j0OnN2AtxJzco9GoHY1g
         lgQP0Kq4TPDWPxvDbVG4XbQPhIplkvYpxA1YF5uzWIwhTb3/Zl0PJ44g8Vow/0ElcnLa
         4lPMHzPKSqWwISIe1UcCedsjNJuEC5nzI1GXlyI/b66VFpHlint9Tc4pJSWyAJGiNQTR
         yxcdhTnhK9ptsQzvU2R3cUzzcaSGKeN6ilwNa5GuRNa0bB8/OWPeX1LB/uz0azJT97R/
         5nig==
X-Gm-Message-State: AA+aEWYSvvLHtOngxBxg9BXa8ZcFgxoFBvEB53+UdJc94MlKa8Yi+3dm
        EQGJsTo1eoaDdKUux3XCEBSNTdjs
X-Google-Smtp-Source: AFSGD/WIs64R93RApYjnVdj84BIgkCDlLP95vfd2XrOROmRmuokgMPu/OUuDSqeA523E1ovpY+Sepw==
X-Received: by 2002:a50:fc07:: with SMTP id i7mr11531095edr.153.1545690847243;
        Mon, 24 Dec 2018 14:34:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i46sm9439253eda.37.2018.12.24.14.34.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Dec 2018 14:34:06 -0800 (PST)
Date:   Mon, 24 Dec 2018 14:34:06 -0800 (PST)
X-Google-Original-Date: Mon, 24 Dec 2018 22:34:04 GMT
Message-Id: <3eaec10c46bdb1a4a1795ae16a76cef15d541ff5.1545690845.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.104.v2.git.gitgitgadget@gmail.com>
References: <pull.104.git.gitgitgadget@gmail.com>
        <pull.104.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/1] abspath_part_inside_repo: respect core.fileMode
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

If the file system is case-insensitive, we really must be careful to
ignore differences in case only.

This fixes https://github.com/git-for-windows/git/issues/735

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 setup.c        | 6 +++---
 t/t3700-add.sh | 7 +++++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/setup.c b/setup.c
index 1be5037f12..291bfb2128 100644
--- a/setup.c
+++ b/setup.c
@@ -39,7 +39,7 @@ static int abspath_part_inside_repo(char *path)
 	off = offset_1st_component(path);
 
 	/* check if work tree is already the prefix */
-	if (wtlen <= len && !strncmp(path, work_tree, wtlen)) {
+	if (wtlen <= len && !fspathncmp(path, work_tree, wtlen)) {
 		if (path[wtlen] == '/') {
 			memmove(path, path + wtlen + 1, len - wtlen);
 			return 0;
@@ -59,7 +59,7 @@ static int abspath_part_inside_repo(char *path)
 		path++;
 		if (*path == '/') {
 			*path = '\0';
-			if (strcmp(real_path(path0), work_tree) == 0) {
+			if (fspathcmp(real_path(path0), work_tree) == 0) {
 				memmove(path0, path + 1, len - (path - path0));
 				return 0;
 			}
@@ -68,7 +68,7 @@ static int abspath_part_inside_repo(char *path)
 	}
 
 	/* check whole path */
-	if (strcmp(real_path(path0), work_tree) == 0) {
+	if (fspathcmp(real_path(path0), work_tree) == 0) {
 		*path0 = '\0';
 		return 0;
 	}
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 37729ba258..8ee4fc70ad 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -402,4 +402,11 @@ test_expect_success 'all statuses changed in folder if . is given' '
 	test $(git ls-files --stage | grep ^100755 | wc -l) -eq 0
 '
 
+test_expect_success MINGW 'path is case-insensitive' '
+	path="$(pwd)/BLUB" &&
+	touch "$path" &&
+	downcased="$(echo "$path" | tr A-Z a-z)" &&
+	git add "$downcased"
+'
+
 test_done
-- 
gitgitgadget
