Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0D171F45F
	for <e@80x24.org>; Wed,  8 May 2019 00:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfEHANW (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 20:13:22 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35671 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfEHANV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 20:13:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id w12so11209221wrp.2
        for <git@vger.kernel.org>; Tue, 07 May 2019 17:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/nPZhFSwhVGvg4QzL36QecDUUXIhWHCy9qrnSTrjid0=;
        b=QflNWJy7HRJg8ZPPXfkC+5dG/OgqEbq2Un9+McN428WCuCV+mV/YyD7MtwQ5E9YO6t
         kZY9WHM397rgMHcoSgKa2v5KxthpmqfB1orPuUDHCzLddDPkcnIjLV9dmqnNpp6uhdAm
         SHXlapeAPldliSyfDGW4LMQVPaM76Iy3tT8KiL7IZ52/xgy5qaDzFw5PJM/VrwSkKHtd
         SNH0AsWUTnXtSdS0uPn0ebtDnQNYPswJc4vXn3VS26wcHJi4XC2v4y76BEDVxXt8LyQ0
         9rcSlOB6TvB4TANuwZWJ0AAYkTvpxM18whpxNTdlIaJ1FqAWf9FhJGpfvcJL3ujBIF8o
         g8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/nPZhFSwhVGvg4QzL36QecDUUXIhWHCy9qrnSTrjid0=;
        b=gjooaaL/FlXj4QMa/NRi7kuZUtkmzCmraR3+kdekTDoRS7k/Cm+JL0W0C3ZZNePm0U
         v5sxSEmV3gBa74ht6o+5kCGBsse25oCqY7rSOizUf938k+20neI40SHWzVFqgrfvxkUD
         RsknKgoJ5B2iSrmC8ZNEyVtbDjCrLfHPv+3hjnJf4sxmQjcvJ8qyXa6axfGiunokiej7
         O1CFKC/HOAXO793UeEVjo3upeeGPaVJFNtHpcj74AnUE0Bp2YTebVB0IYrCiIPPlUCod
         N95jFjlRANOj7g8ZdQ7dlF3U8Th0JF3K1wjX117QUnGhVqCNdxNcEJR6qgBUPtxxcDRz
         GbrQ==
X-Gm-Message-State: APjAAAUA758yjOKdey8beO1kPONM5FT0Clw1gjoqwV65CjpijRH9xhKc
        I0luHjJnEPQrnDpL4P/7KiURBQu7Y38=
X-Google-Smtp-Source: APXvYqz1303ow1kl3gI+jU8cP14tPQLfwxqrsUytkRY5/zL4cax4RQ/qan5SPWD3gRcdQ8LeJrsNRQ==
X-Received: by 2002:adf:fc42:: with SMTP id e2mr18517320wrs.1.1557274399594;
        Tue, 07 May 2019 17:13:19 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n15sm5167825wrp.58.2019.05.07.17.13.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 07 May 2019 17:13:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC WIP PATCH v8 09/13] rebase tests: test linear branch topology
Date:   Wed,  8 May 2019 02:12:48 +0200
Message-Id: <20190508001252.15752-10-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a
In-Reply-To: <cover.1555832783.git.liu.denton@gmail.com>
References: <cover.1555832783.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
2.21.0.1020.gf2820cf01a

