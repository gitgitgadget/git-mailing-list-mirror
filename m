Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEFC61F461
	for <e@80x24.org>; Tue, 27 Aug 2019 05:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbfH0FiI (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 01:38:08 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:38865 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfH0FiH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 01:38:07 -0400
Received: by mail-io1-f42.google.com with SMTP id p12so43496478iog.5
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 22:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vQ/XcDGahnhdplmjyOLvVAhEom12eBuxu/TN2N3wMX0=;
        b=NJv3qlvPgslO/KRVNZFPZOAF+OQQFW4xL9EDHnjyR9GrTMa3cqQlRrGUsWb3+hNrOt
         fAzQW0Yfm4YKyFdYMEsgahg6fKSgnGZi2Bbnq3LHQRXKJa6PMWms0xoovEBuSD316MKT
         mWUWG1FQPUKMm7IiWeP9M030/TxSFcOfY+JVrXfp+2harC86KkGKcOiLX0f6zHHIzSJh
         7SbDUv4RfR+aJnHo/NPVhB7dpbBwuD8hUOd+PUKbFzhAIJp97owwzJ/InqHiKxbP8Odd
         fZccj25wql7zqgsQIeZjKtd7nj+eiGi1LYhjW3pLlq846Fy9qxlPJjFz71k4nCrMakpz
         y4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vQ/XcDGahnhdplmjyOLvVAhEom12eBuxu/TN2N3wMX0=;
        b=fQ218kU8mmGJby6rop0MJKZIAqSSksabXplUhDJH5Ep/C6kOB9zWjF5dZvCUgIuDBA
         4WOtZ+/UKax5Gjsnd1+ZqOWg8Zif7LRcQZOI77Z5l4RjYlVs8Gb+8WFRxac3UrIVqLwX
         Zwr/JDx/o28yVOmPt+GT4wCTYszJMInLg5R4oNpvL+Ey7GSwhVeNCyoYihoDn6on+A3+
         BklsI/mAcEKMBPd7/4WJ3mRDoF8V8uDQMLsrShwhHn2ssa7CRp9PawTZGi/zVuCVqDma
         SL9CvawYFxz8Udx8kb6ZVpEIXdU5AT8IfgUXk6EyVkddotceyw+BNP3BlmQo2cGKA+ba
         IKLA==
X-Gm-Message-State: APjAAAUiokgeh7vWajKJ5PJOHMBts0cZyMerUZyei02TSskxggv61rGj
        fs7n65Gr2HA8JETCSMsvXJu44eoj
X-Google-Smtp-Source: APXvYqw7fV7U2cN91/nWwVwDFw5AlMOTmJ4BIourdWr/JXjivoNBZQS2ZipbZbQWKpQUHcfdkJ9RHA==
X-Received: by 2002:a02:9644:: with SMTP id c62mr10719718jai.45.1566884286604;
        Mon, 26 Aug 2019 22:38:06 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id s11sm12483137ioo.45.2019.08.26.22.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 22:38:06 -0700 (PDT)
Date:   Tue, 27 Aug 2019 01:38:04 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Pratyush Yadav <me@yadavpratyush.com>
Subject: [PATCH v10 8/9] rebase tests: test linear branch topology
Message-ID: <bf6cc6a6102d7b872de590db99b1c5957d7a2dad.1566884063.git.liu.denton@gmail.com>
References: <cover.1566724236.git.liu.denton@gmail.com>
 <cover.1566884063.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1566884063.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Add tests rebasing a linear branch topology to linear rebase tests
added in 2aad7cace2 ("add simple tests of consistency across rebase
types", 2013-06-06).

These tests are duplicates of two surrounding tests that do the same
with tags pointing to the same objects. Right now there's no change in
behavior being introduced, but as we'll see in a subsequent change
rebase can have different behaviors when working implicitly with
remote tracking branches.

While I'm at it add a --fork-point test, strictly speaking this is
redundant to the existing '' test, as no argument to rebase implies
--fork-point. But now it's easier to grep for tests that explicitly
stress --fork-point.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3421-rebase-topology-linear.sh | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-linear.sh
index 7274dca40b..b847064f91 100755
--- a/t/t3421-rebase-topology-linear.sh
+++ b/t/t3421-rebase-topology-linear.sh
@@ -31,6 +31,16 @@ test_run_rebase success -m
 test_run_rebase success -i
 test_have_prereq !REBASE_P || test_run_rebase success -p
 
+test_expect_success 'setup branches and remote tracking' '
+	git tag -l >tags &&
+	for tag in $(cat tags)
+	do
+		git branch branch-$tag $tag || return 1
+	done &&
+	git remote add origin "file://$PWD" &&
+	git fetch origin
+'
+
 test_run_rebase () {
 	result=$1
 	shift
@@ -57,10 +67,28 @@ test_run_rebase () {
 	"
 }
 test_run_rebase success ''
+test_run_rebase success --fork-point
 test_run_rebase success -m
 test_run_rebase success -i
 test_have_prereq !REBASE_P || test_run_rebase failure -p
 
+test_run_rebase () {
+	result=$1
+	shift
+	test_expect_$result "rebase $* -f rewrites even if remote upstream is an ancestor" "
+		reset_rebase &&
+		git rebase $* -f branch-b branch-e &&
+		! test_cmp_rev branch-e origin/branch-e &&
+		test_cmp_rev branch-b HEAD~2 &&
+		test_linear_range 'd e' branch-b..
+	"
+}
+test_run_rebase success ''
+test_run_rebase success --fork-point
+test_run_rebase success -m
+test_run_rebase success -i
+test_have_prereq !REBASE_P || test_run_rebase success -p
+
 test_run_rebase () {
 	result=$1
 	shift
@@ -71,6 +99,7 @@ test_run_rebase () {
 	"
 }
 test_run_rebase success ''
+test_run_rebase success --fork-point
 test_run_rebase success -m
 test_run_rebase success -i
 test_have_prereq !REBASE_P || test_run_rebase success -p
-- 
2.23.0.248.g3a9dd8fb08

