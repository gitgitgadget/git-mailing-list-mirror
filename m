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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3190E1F461
	for <e@80x24.org>; Tue, 27 Aug 2019 05:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbfH0Fhz (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 01:37:55 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36369 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfH0Fhy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 01:37:54 -0400
Received: by mail-io1-f68.google.com with SMTP id o9so43433029iom.3
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 22:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YLd6o7LN3LqvPwEWLdfJPuaCMuppb/NlA1oVwvVSznk=;
        b=Hla/YigRJeuGdKYR3KdkIC9uCNFa+jqUPYyGqYHjmORkL8fbZUS9o8runxuI7iQvI3
         s8jhJ6iOsm4umVl22OCrTeMPFuEWnMEW7vkpWsOMyAQOtdNEqSMbP7KDdkD6rqSiGNsE
         dliZRwTvVOX0YpyNL4Fj38WrM3+GiWHanTU5VDtGZRcgLihEgIKNtq+eimgBMy9E56Gu
         IwVsv8njYBsZ1GiuwOO3s2NbXK+MdEnMlPT26ZNBlnZacqhlPgfQ0C9NS5/D4I1sik3a
         0H/cAQAYTnDkw+u3fgpizIrngMrlqd9pBeiTfdRr0IWLm5YRqF49lstPsUGD6j/GrSvU
         Xd6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YLd6o7LN3LqvPwEWLdfJPuaCMuppb/NlA1oVwvVSznk=;
        b=JtNYpDO0mwPgVzDwT1zqqbMcEW6h3tLgu33rvNi+qALrZHHKjyTj2z03IoKX5kHKt3
         CLgTBiDi+yPxDl7sUcLJ53SeO7rRVNOHZGbggGG4MkHaNPuGLeFfNIIq6pKCCelg0Vhi
         HMEGo2SQ0T27SU9k924E3Bfe6rDvIS9pSH3EJCZQMopH3B31l2a88JYEnGWGefor2iZo
         eAmb6qOurCMMYzxj7rD8hJuvlpk5se0no33yLyiNLls3H/5TI2nmr9sLX8rqBtBCe3T6
         hszQe5fE/VSrJZO3Ob98nNnT3d+0bBD6Fslv1RXpSxfRhlMYnHCAwg+lccCnuzxIroCf
         RA1A==
X-Gm-Message-State: APjAAAWgloKwBBxMdWpjKRYS/zdgn3wgd1IU11LkKIu5W8UaN/VGoI8F
        p+Ju8409iU4fq1N4OGN9+KSQB6lc
X-Google-Smtp-Source: APXvYqyLaGy/gM+W5e2BhmDC0e0li6DAurqzQrx4DifEB6gjqCx7zHV8ZNtiEcULCRU6qG1vETR1uw==
X-Received: by 2002:a02:354d:: with SMTP id y13mr19924549jae.41.1566884273721;
        Mon, 26 Aug 2019 22:37:53 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id y19sm12555845ioj.62.2019.08.26.22.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 22:37:53 -0700 (PDT)
Date:   Tue, 27 Aug 2019 01:37:51 -0400
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
Subject: [PATCH v10 3/9] t3432: distinguish "noop-same" v.s. "work-same" in
 "same head" tests
Message-ID: <5c08e2b81fd65c5d4bcef1fb908987364143d181.1566884063.git.liu.denton@gmail.com>
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

Change "same head" introduced in the preceding commit to check whether
the rebase.c code lands in the can_fast_forward() case in, and thus
prints out an "is up to date" and aborts early.

In some of these cases we make it past that and to "rewinding head",
then do a rebase, only to find out there's nothing to change so HEAD
stays at the same OID.

These tests presumed these two cases were the same thing. In terms of
where HEAD ends up they are, but we're not only interested in rebase
semantics, but also whether or not we're needlessly doing work when we
could avoid it entirely.

I'm adding "same" and "diff" here because I'll follow-up and add
--no-ff tests, where some of those will be "diff"-erent, so add the
"diff" code already.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3432-rebase-fast-forward.sh | 79 +++++++++++++++++++++-------------
 1 file changed, 48 insertions(+), 31 deletions(-)

diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
index f49af274e0..d9f20fa07c 100755
--- a/t/t3432-rebase-fast-forward.sh
+++ b/t/t3432-rebase-fast-forward.sh
@@ -18,55 +18,72 @@ test_expect_success setup '
 test_rebase_same_head () {
 	status="$1" &&
 	shift &&
-	test_expect_$status "git rebase $* with $changes is no-op" "
+	what="$1" &&
+	shift &&
+	cmp="$1" &&
+	shift &&
+	test_expect_$status "git rebase $* with $changes is $what" "
 		oldhead=\$(git rev-parse HEAD) &&
 		test_when_finished 'git reset --hard \$oldhead' &&
-		git rebase $* &&
+		git rebase $* >stdout &&
+		if test $what = work
+		then
+			test_i18ngrep 'rewinding head' stdout
+		elif test $what = noop
+		then
+			test_i18ngrep 'is up to date' stdout
+		fi &&
 		newhead=\$(git rev-parse HEAD) &&
-		test_cmp_rev \$oldhead \$newhead
+		if test $cmp = same
+		then
+			test_cmp_rev \$oldhead \$newhead
+		elif test $cmp = diff
+		then
+			! test_cmp_rev \$oldhead \$newhead
+		fi
 	"
 }
 
 changes='no changes'
-test_rebase_same_head success
-test_rebase_same_head success master
-test_rebase_same_head success --onto B B
-test_rebase_same_head success --onto B... B
-test_rebase_same_head success --onto master... master
-test_rebase_same_head success --no-fork-point
-test_rebase_same_head success --fork-point master
-test_rebase_same_head failure --fork-point --onto B B
-test_rebase_same_head failure --fork-point --onto B... B
-test_rebase_same_head success --fork-point --onto master... master
+test_rebase_same_head success work same
+test_rebase_same_head success noop same master
+test_rebase_same_head success noop same --onto B B
+test_rebase_same_head success noop same --onto B... B
+test_rebase_same_head success noop same --onto master... master
+test_rebase_same_head success noop same --no-fork-point
+test_rebase_same_head success work same --fork-point master
+test_rebase_same_head failure noop same --fork-point --onto B B
+test_rebase_same_head failure work same --fork-point --onto B... B
+test_rebase_same_head success work same --fork-point --onto master... master
 
-test_expect_success 'add work to side' '
+test_expect_success 'add work same to side' '
 	test_commit E
 '
 
 changes='our changes'
-test_rebase_same_head success
-test_rebase_same_head success master
-test_rebase_same_head success --onto B B
-test_rebase_same_head success --onto B... B
-test_rebase_same_head success --onto master... master
-test_rebase_same_head success --no-fork-point
-test_rebase_same_head success --fork-point master
-test_rebase_same_head failure --fork-point --onto B B
-test_rebase_same_head failure --fork-point --onto B... B
-test_rebase_same_head success --fork-point --onto master... master
+test_rebase_same_head success work same
+test_rebase_same_head success noop same master
+test_rebase_same_head success noop same --onto B B
+test_rebase_same_head success noop same --onto B... B
+test_rebase_same_head success noop same --onto master... master
+test_rebase_same_head success noop same --no-fork-point
+test_rebase_same_head success work same --fork-point master
+test_rebase_same_head failure work same --fork-point --onto B B
+test_rebase_same_head failure work same --fork-point --onto B... B
+test_rebase_same_head success work same --fork-point --onto master... master
 
-test_expect_success 'add work to upstream' '
+test_expect_success 'add work same to upstream' '
 	git checkout master &&
 	test_commit F &&
 	git checkout side
 '
 
 changes='our and their changes'
-test_rebase_same_head success --onto B B
-test_rebase_same_head success --onto B... B
-test_rebase_same_head failure --onto master... master
-test_rebase_same_head failure --fork-point --onto B B
-test_rebase_same_head failure --fork-point --onto B... B
-test_rebase_same_head failure --fork-point --onto master... master
+test_rebase_same_head success noop same --onto B B
+test_rebase_same_head success noop same --onto B... B
+test_rebase_same_head failure work same --onto master... master
+test_rebase_same_head failure work same --fork-point --onto B B
+test_rebase_same_head failure work same --fork-point --onto B... B
+test_rebase_same_head failure work same --fork-point --onto master... master
 
 test_done
-- 
2.23.0.248.g3a9dd8fb08

