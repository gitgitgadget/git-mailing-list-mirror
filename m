Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDE5620188
	for <e@80x24.org>; Fri, 12 May 2017 11:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932071AbdELLoY (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 07:44:24 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34365 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756464AbdELLoV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 07:44:21 -0400
Received: by mail-pf0-f195.google.com with SMTP id w69so6791376pfk.1
        for <git@vger.kernel.org>; Fri, 12 May 2017 04:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rz9DuUv0ilFW36cjGj1vW1xa6MKTAC/0w8Kljyy6Fxs=;
        b=iyy9o0E10WhljKKEvm77Q7nrbpV00CSoFihz9rYyCej1hI+A8WvJbQxxPdXI0Nm5up
         pvfZTkHiEyKlqd1JbvGFr/VQErvaHGreOvGpb0QCPk+n2uY20NBZ5l0xo7FmhGXoyPK3
         VVWY9Okq10w4yUYqy1VcgfnsHJ3x0+vFWcYlDxMOW3h2yTIcZW6pC4aYIo/oGQRBPOoA
         FQhhOQLmJ+lVVumbOzxaLKUULHLQNA6KrH1AxqOrYDdJaYro+1F5ND8qa0fovenhYDK3
         6kXnP5FRf/rAYXjjkK0e8IF1wrjNn35qy0rV8Qu+w/Ltce4FQGtaQzCMqmegG8vJejTQ
         dypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rz9DuUv0ilFW36cjGj1vW1xa6MKTAC/0w8Kljyy6Fxs=;
        b=bRdZB1lLldo4/Pj+hbNCWdbf9ULkJ5V2nNQa0zgcSWs+iiJtjR2xc6JlBAbqMMBvGc
         fAErVddKMhgcJvVB30Fy4q10OZqL4qI4Lvab9aCpabuoRlgCoa0JTSvu6WzWubJFeHd8
         wj6DR1vQCdeLmHzyTcUQoC699NCSdmbxAv1/KmsFAJRiecR5NOZJyZhcVs6KqdRb0HS8
         JVS5isApPodXUA1XzgW5z4V3d2nbkGihTeqDoObikxP2Ry9R7UWsDREFmqDheHe4MUFZ
         baHoOf5DgHM8AsVZ5AK/42wUCG5kyZpV9IRuS6Y/U/rcftkBd3jZj2eFM6CPuF0IJYZW
         h1SA==
X-Gm-Message-State: AODbwcBIrkbvEhzfV/xBOmU/tdvLaZfwtnjIu5TnzoOCZIX88PjOBHmv
        0D5ZFX4vvnl86w==
X-Received: by 10.99.103.4 with SMTP id b4mr3878975pgc.84.1494589461046;
        Fri, 12 May 2017 04:44:21 -0700 (PDT)
Received: from prathampc-X550JX.domain.name ([116.73.73.225])
        by smtp.gmail.com with ESMTPSA id 63sm6990988pfg.35.2017.05.12.04.44.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 May 2017 04:44:20 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     ramsay@ramsayjones.plus.com
Cc:     git@vger.kernel.org, pc44800@gmail.com, sbeller@google.com
Subject: [GSoC][RFC/PATCH v3 1/2] t7407: test "submodule foreach --recursive" from subdirectory added
Date:   Fri, 12 May 2017 17:14:03 +0530
Message-Id: <20170512114404.10008-1-pc44800@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <c3b724d8-bb9b-b63b-0105-8c1e22b120be@ramsayjones.plus.com>
References: <c3b724d8-bb9b-b63b-0105-8c1e22b120be@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Additional test cases added to the submodule-foreach test suite
to check the submodule foreach --recursive behavior from a
subdirectory as this was missing from the test suite.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
 t/t7407-submodule-foreach.sh | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 6ba5daf42..58a890e31 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -79,7 +79,6 @@ test_expect_success 'test basic "submodule foreach" usage' '
 	) &&
 	test_i18ncmp expect actual
 '
-
 cat >expect <<EOF
 Entering '../sub1'
 $pwd/clone-foo1-../sub1-$sub1sha1
@@ -197,6 +196,40 @@ test_expect_success 'test messages from "foreach --recursive" from subdirectory'
 	test_i18ncmp expect actual
 '
 
+sub1sha1=$(cd clone2/sub1 && git rev-parse HEAD)
+sub2sha1=$(cd clone2/sub2 && git rev-parse HEAD)
+sub3sha1=$(cd clone2/sub3 && git rev-parse HEAD)
+nested1sha1=$(cd clone2/nested1 && git rev-parse HEAD)
+nested2sha1=$(cd clone2/nested1/nested2 && git rev-parse HEAD)
+nested3sha1=$(cd clone2/nested1/nested2/nested3 && git rev-parse HEAD)
+submodulesha1=$(cd clone2/nested1/nested2/nested3/submodule && git rev-parse HEAD)
+
+cat >expect <<EOF
+Entering '../nested1'
+$pwd/clone2-nested1-../nested1-$nested1sha1
+Entering '../nested1/nested2'
+$pwd/clone2/nested1-nested2-../nested2-$nested2sha1
+Entering '../nested1/nested2/nested3'
+$pwd/clone2/nested1/nested2-nested3-../nested3-$nested3sha1
+Entering '../nested1/nested2/nested3/submodule'
+$pwd/clone2/nested1/nested2/nested3-submodule-../submodule-$submodulesha1
+Entering '../sub1'
+$pwd/clone2-foo1-../sub1-$sub1sha1
+Entering '../sub2'
+$pwd/clone2-foo2-../sub2-$sub2sha1
+Entering '../sub3'
+$pwd/clone2-foo3-../sub3-$sub3sha1
+EOF
+
+test_expect_success 'test "submodule foreach --recursive" from subdirectory' '
+	(
+		cd clone2 &&
+		cd untracked &&
+		git submodule foreach --recursive "echo \$toplevel-\$name-\$sm_path-\$sha1" >../../actual
+	) &&
+	test_i18ncmp expect actual
+'
+
 cat > expect <<EOF
 nested1-nested1
 nested2-nested2
-- 
2.11.0

