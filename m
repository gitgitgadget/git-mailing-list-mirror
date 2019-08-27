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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F6671F461
	for <e@80x24.org>; Tue, 27 Aug 2019 05:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbfH0Fh5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 01:37:57 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46005 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfH0Fh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 01:37:57 -0400
Received: by mail-io1-f68.google.com with SMTP id t3so43340593ioj.12
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 22:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lPR2OAXYDyxgPTlUNuL3MQGfJ4o0dVgWUjdGy3VtHHY=;
        b=Ub5RLjlcyYOabdbjjux2AAIlSwGsW2YFh4yHMSPcqt/1KfbMqTVMtVUZFkHLyFyPhb
         bvNjp6LwpERakxb/JEyWfFPPVVtAkmT/EVuZTbfcbNoFsV6oBjQxqd8pzV88FI4zRC9E
         eu+DBpd3H+f1uwqmv5DegNM0+duDVO8DAiwY1KEBs1WWAgh9NuyQNYv8t/vFx8ufX0+f
         3prbZriaQE9r6L56/iVl6DdpcZS3+6sFIOA3UbzxNpbb+sfffZtXbA4NRgsNRQBFDt2r
         MxaU3UnKl9PZv9pMH8Pzw6tzUuejlyUfc59Nqb/jiXrDyvTnNnKBtSACQ4f9HLl9LRX7
         WFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lPR2OAXYDyxgPTlUNuL3MQGfJ4o0dVgWUjdGy3VtHHY=;
        b=bLJOGGdkTPZ/7M5uz4tTTM/a49hfqTps5g79xfzzz1557L1bpdli04cLPWEKEM/EgX
         I3uXpQjN4cdiXoRLjY7A1kopEGoh9BwajCkW/nG7BvBNWx8HGETwvv2qQdT6eZ6GyAaX
         ad0KDsFDRvPaWyrt9QxYz7w0sGHk/t5x4jvbak7c+MUieL5nw0oquKLZfiC/G4Mut7Le
         Ya80Big0xW0SHrigtcgDMFUdVK57+kNiYJQIe+d0hL3+PyrlX14Dp6T8P+UK3zf2JSQL
         3aRlsxHeMr2m/6GrPNJ5uzSklV4C0STm/j9lXFwXaZIOOlvbPnE/lhgQRyAnZA3tJl5b
         e54A==
X-Gm-Message-State: APjAAAVDa65j1Wk/vmDckjH0v/fdr51bFr2uD2WOloanSbCuW6vjIPIc
        KdpfQVIRNkdcVR8OCR7z2awMogFp
X-Google-Smtp-Source: APXvYqy53U5RYwi5zkPBP+nrzZTH2OOr1lRaJQcUIIXNuk6IGDnCHH79J780U7dfzbPKM2UI3dU+3w==
X-Received: by 2002:a5d:87ce:: with SMTP id q14mr14664379ios.248.1566884276167;
        Mon, 26 Aug 2019 22:37:56 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id t2sm27483994iod.81.2019.08.26.22.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 22:37:55 -0700 (PDT)
Date:   Tue, 27 Aug 2019 01:37:53 -0400
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
Subject: [PATCH v10 4/9] t3432: test for --no-ff's interaction with
 fast-forward
Message-ID: <48b4e41a17d98b2f3a4254ed37c76361c3abc9ba.1566884063.git.liu.denton@gmail.com>
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

Add more stress tests for the can_fast_forward() case in
rebase.c. These tests are getting rather verbose, but now we can see
under --ff and --no-ff whether we skip work, or whether we're forced
to run the rebase.

These tests aren't supposed to endorse the status quo, just test for
what we're currently doing.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3432-rebase-fast-forward.sh | 83 ++++++++++++++++++++++------------
 1 file changed, 54 insertions(+), 29 deletions(-)

diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
index d9f20fa07c..02b2516595 100755
--- a/t/t3432-rebase-fast-forward.sh
+++ b/t/t3432-rebase-fast-forward.sh
@@ -16,22 +16,47 @@ test_expect_success setup '
 '
 
 test_rebase_same_head () {
+	status_n="$1" &&
+	shift &&
+	what_n="$1" &&
+	shift &&
+	cmp_n="$1" &&
+	shift &&
+	status_f="$1" &&
+	shift &&
+	what_f="$1" &&
+	shift &&
+	cmp_f="$1" &&
+	shift &&
+	test_rebase_same_head_ $status_n $what_n $cmp_n "" "$*" &&
+	test_rebase_same_head_ $status_f $what_f $cmp_f " --no-ff" "$*"
+}
+
+test_rebase_same_head_ () {
 	status="$1" &&
 	shift &&
 	what="$1" &&
 	shift &&
 	cmp="$1" &&
 	shift &&
-	test_expect_$status "git rebase $* with $changes is $what" "
+	flag="$1"
+	shift &&
+	test_expect_$status "git rebase$flag $* with $changes is $what with $cmp HEAD" "
 		oldhead=\$(git rev-parse HEAD) &&
 		test_when_finished 'git reset --hard \$oldhead' &&
-		git rebase $* >stdout &&
+		git rebase$flag $* >stdout &&
 		if test $what = work
 		then
+			# Must check this case first, for 'is up to
+			# date, rebase forced[...]rewinding head' cases
 			test_i18ngrep 'rewinding head' stdout
 		elif test $what = noop
 		then
-			test_i18ngrep 'is up to date' stdout
+			test_i18ngrep 'is up to date' stdout &&
+			! test_i18ngrep 'rebase forced' stdout
+		elif test $what = noop-force
+		then
+			test_i18ngrep 'is up to date, rebase forced' stdout
 		fi &&
 		newhead=\$(git rev-parse HEAD) &&
 		if test $cmp = same
@@ -45,32 +70,32 @@ test_rebase_same_head () {
 }
 
 changes='no changes'
-test_rebase_same_head success work same
-test_rebase_same_head success noop same master
-test_rebase_same_head success noop same --onto B B
-test_rebase_same_head success noop same --onto B... B
-test_rebase_same_head success noop same --onto master... master
-test_rebase_same_head success noop same --no-fork-point
-test_rebase_same_head success work same --fork-point master
-test_rebase_same_head failure noop same --fork-point --onto B B
-test_rebase_same_head failure work same --fork-point --onto B... B
-test_rebase_same_head success work same --fork-point --onto master... master
+test_rebase_same_head success work same success work same
+test_rebase_same_head success noop same success noop-force same master
+test_rebase_same_head success noop same success noop-force diff --onto B B
+test_rebase_same_head success noop same success noop-force diff --onto B... B
+test_rebase_same_head success noop same success noop-force same --onto master... master
+test_rebase_same_head success noop same success noop-force same --no-fork-point
+test_rebase_same_head success work same success work same --fork-point master
+test_rebase_same_head failure noop same success work diff --fork-point --onto B B
+test_rebase_same_head failure work same success work diff --fork-point --onto B... B
+test_rebase_same_head success work same success work same --fork-point --onto master... master
 
 test_expect_success 'add work same to side' '
 	test_commit E
 '
 
 changes='our changes'
-test_rebase_same_head success work same
-test_rebase_same_head success noop same master
-test_rebase_same_head success noop same --onto B B
-test_rebase_same_head success noop same --onto B... B
-test_rebase_same_head success noop same --onto master... master
-test_rebase_same_head success noop same --no-fork-point
-test_rebase_same_head success work same --fork-point master
-test_rebase_same_head failure work same --fork-point --onto B B
-test_rebase_same_head failure work same --fork-point --onto B... B
-test_rebase_same_head success work same --fork-point --onto master... master
+test_rebase_same_head success work same success work same
+test_rebase_same_head success noop same success noop-force same master
+test_rebase_same_head success noop same success noop-force diff --onto B B
+test_rebase_same_head success noop same success noop-force diff --onto B... B
+test_rebase_same_head success noop same success noop-force same --onto master... master
+test_rebase_same_head success noop same success noop-force same --no-fork-point
+test_rebase_same_head success work same success work same --fork-point master
+test_rebase_same_head failure work same success work diff --fork-point --onto B B
+test_rebase_same_head failure work same success work diff --fork-point --onto B... B
+test_rebase_same_head success work same success work same --fork-point --onto master... master
 
 test_expect_success 'add work same to upstream' '
 	git checkout master &&
@@ -79,11 +104,11 @@ test_expect_success 'add work same to upstream' '
 '
 
 changes='our and their changes'
-test_rebase_same_head success noop same --onto B B
-test_rebase_same_head success noop same --onto B... B
-test_rebase_same_head failure work same --onto master... master
-test_rebase_same_head failure work same --fork-point --onto B B
-test_rebase_same_head failure work same --fork-point --onto B... B
-test_rebase_same_head failure work same --fork-point --onto master... master
+test_rebase_same_head success noop same success noop-force diff --onto B B
+test_rebase_same_head success noop same success noop-force diff --onto B... B
+test_rebase_same_head failure work same success work diff --onto master... master
+test_rebase_same_head failure work same success work diff --fork-point --onto B B
+test_rebase_same_head failure work same success work diff --fork-point --onto B... B
+test_rebase_same_head failure work same success work diff --fork-point --onto master... master
 
 test_done
-- 
2.23.0.248.g3a9dd8fb08

