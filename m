Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78E0ECAAA1
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 03:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbiIBDxv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 23:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbiIBDxg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 23:53:36 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA06B56D9
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 20:53:35 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k9so772498wri.0
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 20:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=x645O1zVYFnGA4NwKmisZG6lBYxy92sgJqAdRMhMqHg=;
        b=lVDsssV6RDDalybT8/nNnviu6TIAxdcuCVqpj0k6QBO6zrHW0ygIFg9po9yHg5o8Dh
         QtLETCsQ+G0a1lNxPH6rSOmao8Ck1l3DI0/tD4M/GP5JF2tqNjSlZLHlv7AvQpZywtzZ
         oKKcE1X8g8rrNgx99yhivR9yTliIW5Eu08uLnmvcBqvuK2X12r09PqYmisdmXIHexDWv
         PvlAHuXczSTrk/eJYo/fjyEzMUwpZhqldYbmG5fxXkuWS6YvuBPzuBqXWQocybb9Yklv
         3p4DtPhZ2cHMBh/lgW4CIRx4sGuRUi007P18EGr32O7UKePPRa3hdcfWhlKtyy/VxEic
         UqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=x645O1zVYFnGA4NwKmisZG6lBYxy92sgJqAdRMhMqHg=;
        b=i1wcXqF/iCjG528SQ+blQacLcH4DOOcPiJ/qhRcVH33IZnvzKqvwb6zxoEklXbh76k
         dLiS+mR/3HAUFYR5T4qdaEdSJJEwztJb/qQDmabFC4L+vgjHtcJauOeN2UDAT3xl12Sq
         fyR2moNgRrUWbiCqGm1ytyyNp5WmkCBOwAQSmn7edfourInFZnCeePVAkXRYVKDhgbB/
         /f11YVP7Ef9HqpU+ZYcaYCBRo1006HvpHh55q3E8KGGIu/IRNDGkD7h2MD3uYEn0pPvC
         BQnOMPKrr4Uwt/SDmtPTm9aHr1l394PYVgckCqOlkAWk3KG/Fxagnyy7IY3/tmnQ+jxH
         3zIQ==
X-Gm-Message-State: ACgBeo0cz2BoMz7jGXOHzaRln8PkNqhAHMvzC7TJuBruJWBM78AD6mhS
        v76r2x+vTfQfsuf8ioGeFjDdOMqkom4=
X-Google-Smtp-Source: AA6agR5tzY555QRefpLOuTJBsaWisQSM4grWc+TOlmPm7XMZ9Elhej4m2byc+UlJqJsuiPiJGceR4g==
X-Received: by 2002:adf:f6cb:0:b0:220:7859:7bf with SMTP id y11-20020adff6cb000000b00220785907bfmr15429898wrp.683.1662090813394;
        Thu, 01 Sep 2022 20:53:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t6-20020a05600001c600b00226d2462b32sm450242wrx.52.2022.09.01.20.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 20:53:33 -0700 (PDT)
Message-Id: <f91bea2bbc3744e2789b421dfd4fdc4498a790c7.1662090810.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1342.v3.git.1662090810.gitgitgadget@gmail.com>
References: <pull.1342.v2.git.1662016087.gitgitgadget@gmail.com>
        <pull.1342.v3.git.1662090810.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 02 Sep 2022 03:53:29 +0000
Subject: [PATCH v3 2/3] diff: fix filtering of additional headers under
 --remerge-diff
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Commit 95433eeed9 ("diff: add ability to insert additional headers for
paths", 2022-02-02) introduced the possibility of additional headers.
Because there could be conflicts with no content differences (e.g. a
modify/delete conflict resolved in favor of taking the modified file
as-is), that commit also modified the diff_queue_is_empty() and
diff_flush_patch() logic to ensure these headers were included even if
there was no associated content diff.

However, when the pickaxe is active, we really only want the remerge
conflict headers to be shown when there is an associated content diff.
Adjust the logic in these two functions accordingly.

This also removes the TEST_PASSES_SANITIZE_LEAK=true declaration from
t4069, as there is apparently some kind of memory leak with the pickaxe
code.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diff.c                  |  2 ++
 t/t4069-remerge-diff.sh | 17 ++++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 7f8637f3006..2439310ae1f 100644
--- a/diff.c
+++ b/diff.c
@@ -5869,6 +5869,7 @@ static void diff_flush_patch(struct diff_filepair *p, struct diff_options *o)
 {
 	int include_conflict_headers =
 	    (additional_headers(o, p->one->path) &&
+	     !o->pickaxe_opts &&
 	     (!o->filter || filter_bit_tst(DIFF_STATUS_UNMERGED, o)));
 
 	/*
@@ -5924,6 +5925,7 @@ int diff_queue_is_empty(struct diff_options *o)
 	int i;
 	int include_conflict_headers =
 	    (o->additional_path_headers &&
+	     !o->pickaxe_opts &&
 	     (!o->filter || filter_bit_tst(DIFF_STATUS_UNMERGED, o)));
 
 	if (include_conflict_headers)
diff --git a/t/t4069-remerge-diff.sh b/t/t4069-remerge-diff.sh
index e3e6fbd97b2..95a16d19aec 100755
--- a/t/t4069-remerge-diff.sh
+++ b/t/t4069-remerge-diff.sh
@@ -2,7 +2,6 @@
 
 test_description='remerge-diff handling'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # This test is ort-specific
@@ -90,6 +89,22 @@ test_expect_success 'remerge-diff with both a resolved conflict and an unrelated
 	test_cmp expect actual
 '
 
+test_expect_success 'pickaxe still includes additional headers for relevant changes' '
+	# reuses "expect" from the previous testcase
+
+	git log --oneline --remerge-diff -Sacht ab_resolution >tmp &&
+	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'can filter out additional headers with pickaxe' '
+	git show --remerge-diff --submodule=log --find-object=HEAD ab_resolution >actual &&
+	test_must_be_empty actual &&
+
+	git show --remerge-diff -S"not present" --all >actual &&
+	test_must_be_empty actual
+'
+
 test_expect_success 'setup non-content conflicts' '
 	git switch --orphan base &&
 
-- 
gitgitgadget

