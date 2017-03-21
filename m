Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E36402095B
	for <e@80x24.org>; Tue, 21 Mar 2017 13:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757460AbdCUNBU (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 09:01:20 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33043 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757021AbdCUNAv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 09:00:51 -0400
Received: by mail-wm0-f66.google.com with SMTP id n11so2785802wma.0
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 06:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4IzQoH79e1rLLnRPP4H9JQsmzLIXyeCdWtUzM1XJ5Gg=;
        b=SBv0G4N2xDGqHhTeEngz96MsZq0omCDOmutGZnCRq1ZdXBV3vWkxwSUira9gMCop/7
         UFLVyFNiDddyLua8B6aa7WCLSVrvOPl5eabPIbDBk/N8zOzgVZfdYk/gSUXIpflp7vZO
         aOnIuxXYCnQ80j9pf1zynMau5RYKw5m0NTIHo5U/1qu3vLoBMfdPvypdJc9yrbih4dFU
         Up2K6mHs6NYlO8Z8/kMHib0BeRlV4w5A6aTQtASsXX1EzhPRdGLDSgg8/DqwL73Nnr9N
         7yZR2uBfM4Bv5CMJoXxa6uJCVnc4xRYK2aYYo2CG8pYl5mZ8c32sZl4Gxe3afgSIiFZC
         6JQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4IzQoH79e1rLLnRPP4H9JQsmzLIXyeCdWtUzM1XJ5Gg=;
        b=Z35m4vHU0aqCMyx7lhpIMyU4AfYqC2jQjdK7c3zEbHh3nhrOkFIcFTNDbXdUil0tyE
         PuMiV5EZRMFWn5cWT1Ct+LqWf+oVpUOjH5ic46GM7W1dz3qVL1hEccR3t7hmX6FBIp5e
         j1tAnXN7V8rya9DnkkWvayhfW0LCr40ar6s9k7aPo3FMf9lTZuZxeFj6HhhOfjlV1LxG
         MJcHThHUiDNU9ZCL70NJ6ZvpR6KnnLjGdqw5eIB0phSfuR3FBKAHLf/S7wk6D3E2X4ps
         bGW1wXnoMjjuZpz5Krci05EOyHCPyEGm3Jc4rUHWpr+xFuh30nGMjSFIGlEOD9kwtCv3
         I1fw==
X-Gm-Message-State: AFeK/H1g1qVEM69aOu9RlssmObCQzvRLzMkpBPfVKfu3R+/yPrTM1y+fkJ4hejvtft+QoA==
X-Received: by 10.28.104.212 with SMTP id d203mr2637821wmc.114.1490101204505;
        Tue, 21 Mar 2017 06:00:04 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 63sm17555072wmg.22.2017.03.21.06.00.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Mar 2017 06:00:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 05/16] ref-filter: add test for --contains on a non-commit
Date:   Tue, 21 Mar 2017 12:58:50 +0000
Message-Id: <20170321125901.10652-6-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170321125901.10652-1-avarab@gmail.com>
References: <20170321125901.10652-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the tag test suite to test for --contains on a tree & blob, it
only accepts commits and will spew out "<object> is a tree, not a
commit".

It's sufficient to test this just for the "tag" and "branch" commands,
because it covers all the machinery is shared between "branch" and
"for-each-ref".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3201-branch-contains.sh | 9 +++++++++
 t/t7004-tag.sh             | 4 +++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/t/t3201-branch-contains.sh b/t/t3201-branch-contains.sh
index 7f3ec47241..daa3ae82b7 100755
--- a/t/t3201-branch-contains.sh
+++ b/t/t3201-branch-contains.sh
@@ -130,6 +130,15 @@ test_expect_success 'implicit --list conflicts with modification options' '
 
 '
 
+test_expect_success 'Assert that --contains only works on commits, not trees & blobs' '
+	test_must_fail git branch --contains master^{tree} &&
+	blob=$(git hash-object -w --stdin <<-\EOF
+	Some blob
+	EOF
+	) &&
+	test_must_fail git branch --contains $blob
+'
+
 # We want to set up a case where the walk for the tracking info
 # of one branch crosses the tip of another branch (and make sure
 # that the latter walk does not mess up our flag to see if it was
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 45790664c1..3439913488 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1461,7 +1461,9 @@ test_expect_success 'mixing incompatibles modes and options is forbidden' '
 	test_must_fail git tag -n 100 &&
 	test_must_fail git tag -l -m msg &&
 	test_must_fail git tag -l -F some file &&
-	test_must_fail git tag -v -s
+	test_must_fail git tag -v -s &&
+	test_must_fail git tag --contains tag-tree &&
+	test_must_fail git tag --contains tag-blob
 '
 
 # check points-at
-- 
2.11.0

