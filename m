Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F368E20281
	for <e@80x24.org>; Thu, 29 Jun 2017 17:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752836AbdF2RCF (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 13:02:05 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34818 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751797AbdF2RCD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 13:02:03 -0400
Received: by mail-pg0-f65.google.com with SMTP id f127so12567495pgc.2
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 10:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IIi7RKRnzHib6UGGalq972PtBpHzB3jXrEGIx37HwSI=;
        b=E0/tDPzLKN5mWQAiEh6yuFMzUVU1iiSTBAL7TFYRUkT9yRIH4sQTQmmoG8FmfYuOE8
         GiEnRkto62IHqxEe3F95OInl2ojhiN+wGFlybkvr4ncl7N5r3cCS2B4Qpcq3TSsKGaGh
         QfUgrIaxO6gdtVeuY981eblr8qnhMFV4Op1o0SmzdvezchUNRFUja6O4IdcrdnXm+esl
         bFN2+23LIn0i32FR0bDYyXIadi1H26Lmq8R9oumsgW6xouyAT2N5mytY5tQ7YG9LaGjy
         TQFaKROcu1wttDomjPcW7bU0ee4HQcLqbIf8x182NwySo3PRug/frdC+RcxNvchao5gf
         WuNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IIi7RKRnzHib6UGGalq972PtBpHzB3jXrEGIx37HwSI=;
        b=KMWxg5iEJhxZ79DMtqg099UI4/BfDfP1df4eszsIENL3p9h66nyOJRU3uqLLMDAG/g
         WjiKnYI0TI9HztGwQBPFVv+Z71r0vXen7AhF9cDu2OuG+b/hM3mMGudFR8OZ5pbU1TB/
         uEM1BuQYYXY+8pRWJbjkfc1bLxPSRFhM4dIoIRrd0oQ+PVUt5N4iFbVgkXpczC+8bz1n
         mXJoyzlVZkWhL8OZPsoA88SFpHqMvL4B+yvq84Q8t8v4vuwa52gDhidzbvqSVKYGANZl
         6RPh/zSGUT0AeLiMfi7tyIiEx5JX+irrhh8ddJyYajKMHDU9xjP48V/15fCAzuYr6Ae+
         R+eA==
X-Gm-Message-State: AKS2vOwMYQpCh9TDMJZ0Dt7dkxElkAbTGhPIFJ/qJ3I/6f0oh1cEokdz
        IaKs6dp+lDxbWog8B9LooQ==
X-Received: by 10.84.224.207 with SMTP id k15mr19084290pln.15.1498755722202;
        Thu, 29 Jun 2017 10:02:02 -0700 (PDT)
Received: from localhost.localdomain ([42.111.134.170])
        by smtp.gmail.com with ESMTPSA id p28sm12962577pfl.102.2017.06.29.10.01.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Jun 2017 10:02:01 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH 2/2] commit-template: add new line before status information
Date:   Thu, 29 Jun 2017 22:31:20 +0530
Message-Id: <20170629170120.11479-2-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170629170120.11479-1-kaarticsivaraam91196@gmail.com>
References: <xmqqshikvz1s.fsf@gitster.mtv.corp.google.com>
 <20170629170120.11479-1-kaarticsivaraam91196@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit template adds the optional parts without
a new line to distinguish them. This results in
difficulty in interpreting it's content, specifically
for inexperienced users.

Add new lines to separate the distinct parts of the
template.
---
 I tried writing tests to ensure that the new line is added
 but as it seems to require checking multi-line, special 
 options of grep were required to check. I tried the following,

   test_expect_success 'new line found before status message' '
    ! (GIT_EDITOR="cat >editor-input" git commit) &&
    grep -Pz "#\n# On branch" editor-input
   '

 It worked well locally but seems to make the build with 
 GETTEXT_POISON=YesPlease to fail. So, I removed it.
 Not sure how to write a good test for this change, sorry :(

 builtin/commit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

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
-- 
2.11.0

