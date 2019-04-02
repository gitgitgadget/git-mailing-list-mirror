Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D3A020248
	for <e@80x24.org>; Tue,  2 Apr 2019 01:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfDBBlf (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 21:41:35 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38191 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbfDBBlf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 21:41:35 -0400
Received: by mail-qk1-f196.google.com with SMTP id g1so6962664qki.5
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 18:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0Rn2jQx2nZm2pPQxC+/Qi0b+0xM3SeQLJFU8pHRfukE=;
        b=p4zZKyUtt6YJnIaKgK/afIdl9agfOhpYIb7faVWgYHPBqFMRNnMMbod64y0ukhle+j
         PG+DDJKSuialjkGpE+LrD9MHIzoGOOW8hy8i5djyebgh2upFRD5oCbLgt1W4tpfo6IwT
         xrmTRmdVGExqLDHRdWIP2hz5ABrrmFRHGCq+GX36kE23bLOsDDi/kP+SZen2ELQltK7S
         livyz9WkFxmbTwjbq3m0oeBhkWfNtRo7tW55YLZOopSRu82v535M0YAmtLAi3Hr13w/u
         Jg/iwABrpHrPiqUW8Ijqa/7LQ0DkIyCFSGKp+izga5deDnDb9/5zIBLcjo9FjLQewvNM
         GOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0Rn2jQx2nZm2pPQxC+/Qi0b+0xM3SeQLJFU8pHRfukE=;
        b=WrKf8lyRPXkHTLE9D32fZNdDkBU0XHRxKBDTXlCdhOj4qthYkTHLxVzc9cPahYCIgt
         tBtDxI8qhRQV2WHm2oCVfEd82FOx++rEqscMZtrrTR4VselaRIRH0VAhO3WbjufoYTlT
         8SzLM6OAqwJCx7xKv8DuVeOe63Qe+0RnRA1NFiDs2zAkGgPMkqolq4rSOcMIEti9QnCd
         aXvUgjPF2AWtPde4b3vG7nXMDd4r+/fuqEKcYndkcQs8AW4CUB7eb0GvUXqyfb4KLZRE
         glZkmsk+MSlUk/PWRrl5NfFFAHlR3lJTsS72xOOftHs7V/+DFpSTEMeakxVst+ixz5t9
         Q3tw==
X-Gm-Message-State: APjAAAUg4OlSKv39m3Kz7p1Ht52ufTFFeJ5Z899kcQIRMqVMoXpMEzKQ
        PV7vCwwR9R32S8IJaqwkeIwL7XdHuR0=
X-Google-Smtp-Source: APXvYqzYr2tupd29ngKkc+DYFej/y61r8tWvb1NL0p8MX56TuY5Ti3USyA7xWyNJIazA79WDfmSzRA==
X-Received: by 2002:a37:a94c:: with SMTP id s73mr52569870qke.76.1554169293781;
        Mon, 01 Apr 2019 18:41:33 -0700 (PDT)
Received: from khalids-mbp.lan (pool-173-73-95-89.washdc.fios.verizon.net. [173.73.95.89])
        by smtp.gmail.com with ESMTPSA id s43sm7255341qth.47.2019.04.01.18.41.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Apr 2019 18:41:33 -0700 (PDT)
From:   Khalid Ali <khalludi123@gmail.com>
To:     git@vger.kernel.org
Cc:     Khalid Ali <khalludi123@gmail.com>
Subject: [GSoC][PATCH v1] t9811: avoid pipe in git commands in test script
Date:   Mon,  1 Apr 2019 21:41:15 -0400
Message-Id: <20190402014115.22478-1-khalludi123@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The exit code of the upstream in a pipe is ignored thus we
should avoid using it. By writing out the output of the git command to a
file, we can test the exit codes of both the commands.

Aside from the commit message, I plan to apply for GSoC. Planning to
solve the rebase/cherry-pick issue or adding functionality for the
rebase interactive command. 

Any review on this commit would be appreciated!

Signed-off-by: Khalid Ali <khalludi123@gmail.com>
---
 t/t9811-git-p4-label-import.sh | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
index 602b0a5d5c..2f4e80ed55 100755
--- a/t/t9811-git-p4-label-import.sh
+++ b/t/t9811-git-p4-label-import.sh
@@ -63,7 +63,8 @@ test_expect_success 'basic p4 labels' '
 		git checkout TAG_WITH\$_SHELL_CHAR &&
 		test -f f1 && test -f f2 && test -f file_with_\$metachar &&
 
-		git show TAG_LONG_LABEL | grep -q "A Label second line"
+		git show TAG_LONG_LABEL >actual &&
+		grep -q "A Label second line" actual
 	)
 '
 # Test some label corner cases:
@@ -92,9 +93,9 @@ test_expect_success 'two labels on the same changelist' '
 		cd "$git" &&
 		git p4 sync --import-labels &&
 
-		git tag | grep TAG_F1 &&
-		git tag | grep -q TAG_F1_1 &&
-		git tag | grep -q TAG_F1_2 &&
+		git tag >actual && grep TAG_F1 actual &&
+		git tag >actual && grep -q TAG_F1_1 actual &&
+		git tag >actual && grep -q TAG_F1_2 actual &&
 
 		cd main &&
 
@@ -205,7 +206,7 @@ test_expect_success 'use git config to enable import/export of tags' '
 		git p4 rebase --verbose &&
 		git p4 submit --verbose &&
 		git tag &&
-		git tag | grep TAG_F1_1
+		git tag >actual && grep TAG_F1_1 actual
 	) &&
 	(
 		cd "$cli" &&
-- 
2.21.0.196.g041f5ea1cf

