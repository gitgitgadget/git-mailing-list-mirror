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
	by dcvr.yhbt.net (Postfix) with ESMTP id D57DF1F461
	for <e@80x24.org>; Sun, 25 Aug 2019 09:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfHYJMT (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 05:12:19 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:32962 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfHYJMS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 05:12:18 -0400
Received: by mail-io1-f44.google.com with SMTP id z3so30295416iog.0
        for <git@vger.kernel.org>; Sun, 25 Aug 2019 02:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vQ/XcDGahnhdplmjyOLvVAhEom12eBuxu/TN2N3wMX0=;
        b=PwArGMEhuPnjq1e7jCdaKO4l+vhUSyduVjGEjtjIHIo2B38KP38sRQSyjlW0kiB/Mz
         PmOH6uNF6mj9Ig4h8f9twQR1Slh91aXgPrHq/THlxOcirbGNMVwpjQx0IMMicF5jKljQ
         wzlx2ch89LwcvhxFRxHDe4WOWKhR54ak1gx0j0XpTs5lNGTXKq3I+JlIK6zLQ33xdiV0
         v3mh/v9uhsHSoZgCxPkaEeuMX4YlqLGeZNNpQd/2tJdqMuJD1TG0ctAOXo9aoBGRARp/
         IdZF/JGluKDyeTOmIIPHpwS34YNac4kTwP/oH8m7+JrySqzqDF5Nhe5Gb0yVamz4ir/s
         pt6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vQ/XcDGahnhdplmjyOLvVAhEom12eBuxu/TN2N3wMX0=;
        b=QQ8SWI/RCBZNibVd/gF7DGU3AaqEvVFAt9DOIYLibV8ySziFGflquDKydKX0W9hrkV
         TVh+Lwds5ZTr0bSCytC3IEwBUek7GuNIzLCUOKyZYu5hxk6y3INyYukmNXA7aFK0sdlS
         TCmuBkyzj/ezX7bexZ6KMB44SPS5w/Im5e9ucZIXX8je1MApPCdPw7dPimd1e6+FVdod
         iUuGYMKoTXXf/lbdKqOjDX4JKdGb3NqFqdwQyz1IGPZCrk2FxOVt7DTtg1oI+hemQYNo
         U/SnRCKKyNQtqKx9zaFbvlejzrY9V7Y0CW+mQQk6RrjEbMcFgcQKq4QnSfrOxqIu+Q14
         imDQ==
X-Gm-Message-State: APjAAAW0iNhGOxcSrnfgFff9HVTVY/cdvbYI7/TiGMCwcQnHT1PYFHlY
        8+RokTryiz1nM0Nnki7AybOY8F4Q
X-Google-Smtp-Source: APXvYqxJKKBZUNG9JV4Ii/GcD/3oDwZo3EfX0Icv0pNnQ3fpXFcjAS2YPp07kjiBlOWyDoG+R7pHYw==
X-Received: by 2002:a5e:c247:: with SMTP id w7mr18286684iop.72.1566724337128;
        Sun, 25 Aug 2019 02:12:17 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id m67sm11378542iof.21.2019.08.25.02.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 02:12:16 -0700 (PDT)
Date:   Sun, 25 Aug 2019 05:12:15 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v9 8/9] rebase tests: test linear branch topology
Message-ID: <4699a909937d3a01ad89f1fb37bf7cb4916c761e.1566724236.git.liu.denton@gmail.com>
References: <20190508001252.15752-1-avarab@gmail.com>
 <cover.1566724236.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1566724236.git.liu.denton@gmail.com>
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

