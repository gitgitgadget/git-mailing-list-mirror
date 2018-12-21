Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC5D91F405
	for <e@80x24.org>; Fri, 21 Dec 2018 11:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389644AbeLULcX (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Dec 2018 06:32:23 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:39320 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732738AbeLULcW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Dec 2018 06:32:22 -0500
Received: by mail-ed1-f51.google.com with SMTP id b14so4401176edt.6
        for <git@vger.kernel.org>; Fri, 21 Dec 2018 03:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=V2KTmtqfcELAiDIFNJVkomX7fuexDZC2/X2i9fTvg3k=;
        b=KO3CeWXc2zZ50pmofvjnhUamZpS/baoKD9/9QnqiL3zZDbY3cZGNfy7rrr0VCra9Hw
         9CV7ARd27woC0//4Ko0p9oUsyLwILBwK2R6Eb3/T5ZjeWKiUzfvs4GPJLh5Z6On49xL0
         Q8Dn/UhwRk/NGdDfWYZSjW2xLW7irNSgN133dq8Zn+8SWUfHbSnWG+PFD27Is5Z366Of
         c3AqTqvKxNqRovc23lTYXQI4KkId3sqbbp986y0/ofAFddNLxBo3B7AAy7X6e8r9PBqW
         ldw69RuK32ULaIEMLYx5BDj3/UFJICRQW+Shihj1qwjrVcIcbS/UPkFx6cxd+CpIrhXA
         C4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=V2KTmtqfcELAiDIFNJVkomX7fuexDZC2/X2i9fTvg3k=;
        b=h3iMQYQoHy4+viSEGukrLLqVOl+f2l2fWiKKaUtOgkkqoPy1rKoLsX0r83k8ftMxs/
         6jfBy8M1hGDt+RXt0+nL5OnMfrD0+TZJsAJwR1i1Yot15RIHNSf4n07N0RklBHqSIoSc
         TfV3nA262XdBZZhz7RDD3FJGq6zEDLTWeykm1zd41Mt4bip2MFk49pUQhkX3Yj2PE4Dg
         peYkvUtSdXMz+vqeBpQv1QOfM1OCJeLKr/4c4RxOJ/tseoMVrRiwksa128cnS2VB1WCv
         w1KFg063oB9DBn7wMq2vn65ooBp2rPjdnDwC/nZw6YpZZTBSYqRIhKSLqrjTghjBhCF/
         Kyrg==
X-Gm-Message-State: AA+aEWa0wlTkkLBCsNdQyAq1wKBOs3RbzCAIIIKhk7UuSygS0sD+PSUu
        5FoLaNlhJ1POnDHVF+kBNGYlYLfRklbjoAab
X-Google-Smtp-Source: AFSGD/X10yblc0wKiItYlldTCiA4iwCxoVZKAgyw9VCXxAujTkHnj4OUCFIzgi7ZaM6kIA8E9xdk7A==
X-Received: by 2002:a17:906:b303:: with SMTP id n3-v6mr1872181ejz.34.1545391940852;
        Fri, 21 Dec 2018 03:32:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m44sm5343405edm.54.2018.12.21.03.32.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 03:32:20 -0800 (PST)
Date:   Fri, 21 Dec 2018 03:32:20 -0800 (PST)
X-Google-Original-Date: Fri, 21 Dec 2018 11:32:19 GMT
Message-Id: <4fb5de504e9b48a35075cb87f4158149055f1a13.1545391939.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.104.git.gitgitgadget@gmail.com>
References: <pull.104.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] abspath_part_inside_repo: respect core.fileMode
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
