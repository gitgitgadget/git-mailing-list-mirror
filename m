Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 477F81F4B7
	for <e@80x24.org>; Fri, 30 Aug 2019 05:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfH3F5U (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 01:57:20 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45004 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfH3F5T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 01:57:19 -0400
Received: by mail-pf1-f193.google.com with SMTP id c81so3866353pfc.11
        for <git@vger.kernel.org>; Thu, 29 Aug 2019 22:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AJjCFrB5UTcHzjbEFgl5FcYB+nuFOQyoQyWUFVGr7Bg=;
        b=U9YVCNUNXlarfNvv9u+kSsrChqDqBY5M4aMlOD1sn0ZHr/QdMukmpm/BBC/wm9mUVP
         dwwGWVaG9OfdRZfoBYAzipR6hwtr+G640KIJKg8tdd1hLtFFLsQESH+PJ229oW5lFVZ2
         ZKzmpUPioSBBYoDicWp7Q9aDJjF57pdHdd0M1p1IzRa6Ae6OeXgKfN90tsODhmMnuCqI
         xX0LhP5Cb4IqRdJ2s8PHD8fcMaOmWwpemybOAEaiKcQwyoSJJbOUWQknTKlIUxHHJ8Kq
         9JWPQAv0CMHPTl8/lD61iw1qDM5lm3LzR4a6/85aAcuBN3cUIrgoIaBDop3tQGfnvIGm
         Hbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AJjCFrB5UTcHzjbEFgl5FcYB+nuFOQyoQyWUFVGr7Bg=;
        b=PI19dB47HEDJ7AADEdiXUapy1QV5xID4w8MlFaFU/ubZ23iEZJqNo1ZNHXjZAHU9cu
         ibyNnhLsuNvwGJSfVCMY9tdFKL+ByKYUdauxkDOVYKIs4KKO4rXgPn0fuA+qdt1ibV/m
         PpSRLuH8vJhS0B76ni8E5oPPI8+94YLQwAitqlzft5VFtOFcisFxh+G45HjjcHiQpik0
         iYGPe3/G+RMGEy77ESTdwkHq8YfgtmTBi3kBS8IEpiAlO0ONFf6xJygZ0xxfWNXCMCmV
         N8aLDsbIjERYzrDuUSDgPz/7gjuMft5G46fIAxCN2GInVrsNXZ3jp0uinMcP+UCeCfLC
         yaeA==
X-Gm-Message-State: APjAAAXlAiCEWJylXAxJ7B2vZKgWe8FE41w6mCD8iUdZ2jLYxOSm95PZ
        xRBdURFWSDmBm0qQwDZc0WGJFNo8YGA=
X-Google-Smtp-Source: APXvYqzHyTQYt3SL7iQOXEzfvamH0nxN3B2xprcX2KGN8A2/0zFd1V4iw9JuAFz4in3VihNEC8gnQw==
X-Received: by 2002:a62:e910:: with SMTP id j16mr16568742pfh.123.1567144638455;
        Thu, 29 Aug 2019 22:57:18 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id b136sm5771139pfb.73.2019.08.29.22.57.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Aug 2019 22:57:18 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Eric Wong <e@80x24.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 4/4] t9902: use a non-deprecated command for testing
Date:   Thu, 29 Aug 2019 22:57:07 -0700
Message-Id: <20190830055707.7785-5-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.38.g892688c90e
In-Reply-To: <20190830055707.7785-1-newren@gmail.com>
References: <20190829000657.26415-1-newren@gmail.com>
 <20190830055707.7785-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

t9902 had a list of three random porcelain commands as a sanity check,
one of which was filter-branch.  Since we are recommending people not
use filter-branch, let's update this test to use rebase instead of
filter-branch.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t9902-completion.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 75512c3403..4e7f669c76 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -28,10 +28,10 @@ complete ()
 #
 # (2) A test makes sure that common subcommands are included in the
 #     completion for "git <TAB>", and a plumbing is excluded.  "add",
-#     "filter-branch" and "ls-files" are listed for this.
+#     "rebase" and "ls-files" are listed for this.
 
-GIT_TESTING_ALL_COMMAND_LIST='add checkout check-attr filter-branch ls-files'
-GIT_TESTING_PORCELAIN_COMMAND_LIST='add checkout filter-branch'
+GIT_TESTING_ALL_COMMAND_LIST='add checkout check-attr rebase ls-files'
+GIT_TESTING_PORCELAIN_COMMAND_LIST='add checkout rebase'
 
 . "$GIT_BUILD_DIR/contrib/completion/git-completion.bash"
 
@@ -1392,12 +1392,12 @@ test_expect_success 'basic' '
 	# built-in
 	grep -q "^add \$" out &&
 	# script
-	grep -q "^filter-branch \$" out &&
+	grep -q "^rebase \$" out &&
 	# plumbing
 	! grep -q "^ls-files \$" out &&
 
-	run_completion "git f" &&
-	! grep -q -v "^f" out
+	run_completion "git r" &&
+	! grep -q -v "^r" out
 '
 
 test_expect_success 'double dash "git" itself' '
-- 
2.23.0.38.g892688c90e

