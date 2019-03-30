Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFFEE20248
	for <e@80x24.org>; Sat, 30 Mar 2019 14:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730914AbfC3O2X (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 10:28:23 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37683 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730840AbfC3O2X (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 10:28:23 -0400
Received: by mail-pf1-f194.google.com with SMTP id 8so2397612pfr.4
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 07:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FhAAN28qHfr9fTL5Y+JfBtxC+H9lMrCKQyb4ktkGN0Y=;
        b=uX8siTw4X9lPTkX8Y9fbQWrXmbRepyFWkAKwuvkxmnEgBGw2zInHJIWiBg/nb+svL7
         lPfTi15wizBpwwF5bZc8/DAuCI1im4eEllj/kaKntUAefiH+SjFSs0u2IfR+sJKZld9k
         QFLpnr0bmg7TndiJV1rLxVNhHVDDtjwukplFhbgKij8Z5s6LpblRc7I6ItdV1ZEHfsbx
         JiBaHz0rO+9E3NGK5ptyn6Dqo7bgY9nwcX6E5Vrp5xJerwadIO3vHiRcNQufVEn7dhll
         NXVbkafr8tWNkwOyllkVnuXZ/ts7UiE4moiPzRhpZKd0eaTHIBHCxDasSUEXoR4M7lLi
         gz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FhAAN28qHfr9fTL5Y+JfBtxC+H9lMrCKQyb4ktkGN0Y=;
        b=nYmn3SsqE5ASsgvnDQUpQc6y0XWXHUEVKza4PG0jZgFzDiBtzPlIVEAL0WvCOGJ/Ac
         JAwMLfQPP+wn7fECapqMWqYNqCf1vPhgMMpTxQ6QZCrx5CudNYOEVc0yoCcjcC2h2hUe
         3uqrj21hFc91u3l8zy59+/rYcOBMEvYm51JcUDzzFL5GJQ1M5tOYmS6pqujFca3SjKLT
         XBUTTZOAr2y1CvqtD5/IqueKXI1K70RjmyAFQYnQct95z5VgV59qeCZXHxOwmlsMKurE
         xy5gpI8aT4TvvxWvum+iQliisdYdnKZtbroztBWVhN1nYwSaQeH5492aBJUr+eSpuqYB
         vaTA==
X-Gm-Message-State: APjAAAVe5GLpfE8wkMcv/N8clkaA1cY1daJ5EkNwpYah8XQC3hirEykj
        smgK8+g0+AcSHGLzTshXJy7boGZkmrk=
X-Google-Smtp-Source: APXvYqywX/eYizBTSKeKbW6OGxc5xkHkJacX13UxUL12CEWQV/ZyW4DPvlOYCX6f//Dt7VNS+Hz7yw==
X-Received: by 2002:a62:874d:: with SMTP id i74mr25725273pfe.211.1553956102265;
        Sat, 30 Mar 2019 07:28:22 -0700 (PDT)
Received: from localhost.localdomain (cloudream.m3.ntu.edu.tw. [140.112.244.5])
        by smtp.gmail.com with ESMTPSA id v12sm6621737pfe.148.2019.03.30.07.28.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Mar 2019 07:28:21 -0700 (PDT)
From:   Jonathan Chang <ttjtftx@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jonathan Chang <ttjtftx@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [GSoC][PATCH v4 5/5] t0000: make use of the test_must_be_empty function
Date:   Sat, 30 Mar 2019 22:27:58 +0800
Message-Id: <53f58a4f89ff911d0f761f4e9403e0ddb4454674.1553954776.git.ttjtftx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1553954776.git.ttjtftx@gmail.com>
References: <cover.1553954776.git.ttjtftx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Chang <ttjtftx@gmail.com>
---
 t/t0000-basic.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 49923c5ff1..0cb69a89de 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -51,7 +51,7 @@ test_expect_success 'verify that the running shell supports "local"' '
 
 test_expect_success '.git/objects should be empty after git init in an empty repo' '
 	find .git/objects -type f -print >should-be-empty &&
-	test_line_count = 0 should-be-empty
+	test_must_be_empty should-be-empty
 '
 
 # also it should have 2 subdirectories; no fan-out anymore, pack, and info.
@@ -1110,7 +1110,7 @@ test_expect_success 'git update-index --refresh should succeed' '
 
 test_expect_success 'no diff after checkout and git update-index --refresh' '
 	git diff-files >current &&
-	cmp -s current /dev/null
+	test_must_be_empty current
 '
 
 ################################################################
-- 
2.21.0

