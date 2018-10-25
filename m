Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 550251F453
	for <e@80x24.org>; Thu, 25 Oct 2018 19:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeJZDzP (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 23:55:15 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39047 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbeJZDzP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 23:55:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id y144-v6so2579398wmd.4
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 12:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RK1++auMtwt0s07XJsG581WachxG5dAyb8h88trMXjg=;
        b=DhzjiGRk8Z5LR1ynnJYcMso8yn63+t60dT1z/8Z1tXHgP+dWuGvPFxZSfr4diiU7tH
         FFlWb6r002NHe49+UYxgHh1fY4rUXNCeoCBw0v1zhpKIogFO31VXK4LI9rkIOAwSaKTl
         Ttc+F8ExqG/HaHJjzEPOI2tSGl0wNiD38asTbC53Gtf8SyOE1PdOfvlQzpI1aeQosgmK
         v2WFhzLx9/m5jzkyHCy9nxgd9YaX1c2k8/xVIihBdabpt+yMI5h0E55ACB+chKCItjnB
         oelpvp8h/tHUMnVVlmFvEYBlFJiLgxPNsU/wmMeN5sLZeBynGujceQcHxEuEnRy9TO52
         kkww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RK1++auMtwt0s07XJsG581WachxG5dAyb8h88trMXjg=;
        b=WWo+zf0KCRSoNWfzEXh9/pjCCBYFk/BLeBTlOHJI/m4lX8RzCkSeUT3sn1LvsRLdT0
         7f+KiU9c3RakmcTqNj1o45a/b7Q1cwkNiqHskrGYV+omBYM+2Edd12RcQqaKLmcFuowP
         lmm8+SIyMlWy/LlL3d52xr1i9CTpC9znsrFBDjN/U35zmaYJkZzfgtI4r5pbUs24f46s
         4beyh2q7IioEOL1HumXN7N4LGYMlOmObXTBwmhqI0L/AnB1wvjHMw3mtsIDbMB90U49X
         7MMovRitG+C1GpRD0ExspEzTytJmbiSHVUYhCN/XnXg8EFW7w1MhltgPOeGwPE1HaBAo
         +ZJg==
X-Gm-Message-State: AGRZ1gL5f8xB8zYhelEUBqEn5L9iG3j9j1Aw321p/4b+8mqiZytkyYTI
        VCj5ZnJ1He3nKq9DpBKM5ic=
X-Google-Smtp-Source: AJdET5c54QLrI6lJ/wtFTwr0q02B8mPNKYMtPe26sBeAXcjF+qKVd4sXMDx+Ynx+aDYVYULezPWEFQ==
X-Received: by 2002:a1c:603:: with SMTP id 3-v6mr3021668wmg.64.1540495270997;
        Thu, 25 Oct 2018 12:21:10 -0700 (PDT)
Received: from localhost.localdomain ([31.223.156.124])
        by smtp.gmail.com with ESMTPSA id l11-v6sm6698956wrn.61.2018.10.25.12.21.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 12:21:10 -0700 (PDT)
From:   Slavica Djukic <slavicadj.ip2018@gmail.com>
X-Google-Original-From: Slavica Djukic <slawica92@hotmail.com>
To:     slavicadj.ip2018@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        Slavica <slawica92@hotmail.com>
Subject: [PATCH v3 1/3] [Outreachy] t3903-stash: test without configured user name
Date:   Thu, 25 Oct 2018 21:20:45 +0200
Message-Id: <9ea38cd8e98890b8264696dfd647c1f9e709ae9e.1540494231.git.slawica92@hotmail.com>
X-Mailer: git-send-email 2.19.1.windows.1
In-Reply-To: <cover.1540494231.git.slawica92@hotmail.com>
References: <cover.1540494231.git.slawica92@hotmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Slavica <slawica92@hotmail.com>

This is part of enhancement request that ask for 'git stash' to work
even if 'user.name' and 'user.email' are not configured.
Due to an implementation detail, git-stash undesirably requires
'user.name' and 'user.email' to be set, but shouldn't.
The issue is discussed here:
https://public-inbox.org/git/87o9debty4.fsf@evledraar.gmail.com/T/#u.

Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
---
 t/t3903-stash.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 9e06494ba0..ae2c905343 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1156,4 +1156,18 @@ test_expect_success 'stash -- <subdir> works with binary files' '
 	test_path_is_file subdir/untracked
 '
 
+test_expect_failure 'stash works when user.name and user.email are not set' '
+    test_commit 1 &&
+    test_config user.useconfigonly true &&
+    test_config stash.usebuiltin true &&
+    sane_unset GIT_AUTHOR_NAME &&
+    sane_unset GIT_AUTHOR_EMAIL &&
+    sane_unset GIT_COMMITTER_NAME &&
+    sane_unset GIT_COMMITTER_EMAIL &&
+    test_unconfig user.email &&      
+    test_unconfig user.name &&
+    echo changed >1.t &&
+    git stash
+'
+
 test_done
-- 
2.19.1.windows.1

