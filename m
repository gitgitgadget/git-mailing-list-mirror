Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA106201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 12:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbdF3MN7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 08:13:59 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36191 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751929AbdF3MMg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 08:12:36 -0400
Received: by mail-pf0-f193.google.com with SMTP id z6so16893726pfk.3
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 05:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+Y9aVICaKsWpLIFSTG//kJKk0LiruJKVN7xqb/h5k0E=;
        b=P9ibknVflkyCgTBPO/+X1ze7/qZOzJ7e3NwvTdr6jjAThag0cuX+LwoBlbwTDNRRWl
         bPYSvJkDX9ej/krC0aoCBup9uNpym02Y/Dq8NGCxlSjC7uNquno6ot89vLnPoGSNm0cS
         oD+R4Qm0Vebbxc1o8gjkJyaG4lhVZ6KCwqxdGPT+Kvvb4FKgkt7gudIpjKF2N/tjf/zF
         Uo+u/rotLKZefJ8Dk644tHsB9q0mnBc47K6TFVuloB590db1IoT+wXDM8uk9AC7ySSvg
         MjS2/jpjgkWMJNfUEsLQHBn6AR1w7iPMl1y1vzkejlLDUDX2NGSjKfYMJvXF0upZxoyc
         bgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+Y9aVICaKsWpLIFSTG//kJKk0LiruJKVN7xqb/h5k0E=;
        b=mTDNzgbbqAoG3S+DDSp9fYkkwNa/fE68PYXtB3JylB1fhcuivvPvzUkimI3kNkylnJ
         ygE4xcZr7d6nqeKdFWprW5EYeawYqh1WLdNjDQKaW/BdYT5K/H4JPJlzP3qdxt3XMU7I
         Yk20xMfAsFkqo/rK4nUchWAYb+goAA9QNRb6EijhHNA55j6s5oId9URu9mJa0JwFvrm5
         vkKfRRbKBw1OB7Miz5uhGfAkDVlLHSB3CDR33K8XSUhy7p47Un4pgWolWgw4GyHvMZe8
         g2CVdcxSXZeqpACTzZsZbhKv0nJhmpTxoTnG/4BmnQFU/Tvd8whJniuLpZiPshWIRQmE
         r61A==
X-Gm-Message-State: AKS2vOzr3QmWQQ4dgzFGCld9gTt1ESAzAztJnWJW+f1LeN6PHmf8Ak9E
        0L0ScwGvUlKVS7nKmqTCsA==
X-Received: by 10.99.240.69 with SMTP id s5mr16977061pgj.23.1498824755858;
        Fri, 30 Jun 2017 05:12:35 -0700 (PDT)
Received: from localhost.localdomain ([42.111.140.60])
        by smtp.gmail.com with ESMTPSA id q29sm8046453pfg.11.2017.06.30.05.12.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Jun 2017 05:12:35 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH 2/2] commit-template: distinguish status information unconditionally
Date:   Fri, 30 Jun 2017 17:42:21 +0530
Message-Id: <20170630121221.3327-2-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170630121221.3327-1-kaarticsivaraam91196@gmail.com>
References: <1498792731.2063.5.camel@gmail.com>
 <20170630121221.3327-1-kaarticsivaraam91196@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit template adds the status information without
adding a new line to distinguish them in the absence
of optional parts. This results in difficulty in interpreting
it's content, specifically for inexperienced users.

Unconditionally, add new lines to separate the status message
from the other parts of the commit-template to make it more
readable.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 In trying to make the test independent of the previous test,
 it got a bit long. Hope it's not doing anything that shouldn't
 be done.

 In case you would wonder, the 'git reset' line is to remove 
 the files that were staged in previous test. I've done it in
 the same motive that lead to a bigger test.

 travis-ci builds passed

 builtin/commit.c  |  3 +--
 t/t7500-commit.sh | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 64701c8f4..22d17e6f2 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -873,8 +873,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 				(int)(ci.name_end - ci.name_begin), ci.name_begin,
 				(int)(ci.mail_end - ci.mail_begin), ci.mail_begin);
 
-		if (ident_shown)
-			status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
+		status_printf_ln(s, GIT_COLOR_NORMAL, "%s", ""); /* Add new line for clarity */
 
 		saved_color_setting = s->use_color;
 		s->use_color = 0;
diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index 116885a26..5739d3ed2 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -329,4 +329,27 @@ test_expect_success 'invalid message options when using --fixup' '
 	test_must_fail git commit --fixup HEAD~1 -F log
 '
 
+cat >expected-template <<EOF
+
+# Please enter the commit message for your changes. Lines starting
+# with '#' will be ignored, and an empty message aborts the commit.
+#
+# Author:    A U Thor <author@example.com>
+#
+# On branch commit-template-check
+# Changes to be committed:
+#	new file:   commit-template-check
+#
+# Untracked files not listed
+EOF
+
+test_expect_success 'new line found before status message in commit template' '
+	git checkout -b commit-template-check &&
+	git reset --hard HEAD &&
+	touch commit-template-check &&
+	git add commit-template-check &&
+	GIT_EDITOR="cat >editor-input" git commit --untracked-files=no --allow-empty-message &&
+	test_i18ncmp expected-template editor-input
+'
+
 test_done
-- 
2.11.0

