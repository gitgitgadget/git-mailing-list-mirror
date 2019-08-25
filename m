Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 691171F461
	for <e@80x24.org>; Sun, 25 Aug 2019 09:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfHYJMJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 05:12:09 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34647 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfHYJMJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 05:12:09 -0400
Received: by mail-io1-f66.google.com with SMTP id s21so30302603ioa.1
        for <git@vger.kernel.org>; Sun, 25 Aug 2019 02:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lPR2OAXYDyxgPTlUNuL3MQGfJ4o0dVgWUjdGy3VtHHY=;
        b=u/YFwI90KiRgEuXGh73CBV8E+5ir9qa2l3xIcArVGROt24z/fVvMGGz5sUntkPgBrP
         +A4+ZnBKh5bOsc/kX5Roq6PRGUER+oPfyXhySm9rQBQE95qfeRVRkTMp6zKwW4YFLp7n
         qnKQkL5TaoH17jzvqB2KxTRloGUo8DzEgcyeXUjG3CBRkJH31ggUlmUuMdPCeTZbRUOk
         nbtqAC8m/77Z77XgzjizHqV/Ill/VgHGJeRIZCjgCWz0FRyMjRBSZYKItjZgEyLfbAQX
         GRIPBgkkrZ2RRddR9CPkH2VFTIYB5ZuxDiww67OyKVzpnXJvvisFWUXIPB8TqymEj3fr
         kRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lPR2OAXYDyxgPTlUNuL3MQGfJ4o0dVgWUjdGy3VtHHY=;
        b=oyVzTW4nUZFVw7rmF0Id3mJNxhPdaPb1fdbAd7n0UBt1Vso23cfwns0g8E3TOJCXjX
         Aj/RljbfSTesQcKUEFri+jS4FJbCdGJnZwDk3gt5GKqKUdVBxtrmcok8BAW4Y7Y4mme4
         AOXt5kpzDvO5/CEBOFuZpMRKFvAPOCOVDe3cGmd/HGfnygDuCOJxinHxpuwMGDouJIV/
         dehHgTs3SEIsNItosKInLledbaPU4zmc0P05QUVjKJZUQG0HlgAQAuYmnv5yu4cYsq5Q
         pyJpjEfzFXHpP3yHNszHWr8UBK8q10XqJHdRqEdAJ0LwU6MsH6rkJQP+avIHGzfALTs0
         iuWg==
X-Gm-Message-State: APjAAAWzdLLmqD3IpbMCfYjjWFT5GV6DQcvAjYhSZWDYJ0+ZLpX+4Cym
        ojWwZ4jEZkWf398W4Q+CCWZHNdX5
X-Google-Smtp-Source: APXvYqwOYxhoc037RS7Wc37EHfCAlFi88BI3i4bnHK7nS/RnvSQQnr71c8Nqd3SbVX2WK3Hd2Aa8iA==
X-Received: by 2002:a05:6638:310:: with SMTP id w16mr13069114jap.136.1566724327487;
        Sun, 25 Aug 2019 02:12:07 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id l10sm8645878ioa.13.2019.08.25.02.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 02:12:07 -0700 (PDT)
Date:   Sun, 25 Aug 2019 05:12:05 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v9 4/9] t3432: test for --no-ff's interaction with
 fast-forward
Message-ID: <48b4e41a17d98b2f3a4254ed37c76361c3abc9ba.1566724236.git.liu.denton@gmail.com>
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

