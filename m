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
	by dcvr.yhbt.net (Postfix) with ESMTP id 850DC1F461
	for <e@80x24.org>; Sun, 25 Aug 2019 09:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfHYJMG (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 05:12:06 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38322 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfHYJMG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 05:12:06 -0400
Received: by mail-io1-f67.google.com with SMTP id p12so30277457iog.5
        for <git@vger.kernel.org>; Sun, 25 Aug 2019 02:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YLd6o7LN3LqvPwEWLdfJPuaCMuppb/NlA1oVwvVSznk=;
        b=ux7tY0xZjUL3bttAJfte9upwQnf0WAMA2RwPF3mrN9unH0mG7vgV9RnHRi7B4O+gqa
         rK1Yiomvg1Lq3AcmvIpsP2+YVUOZL/7J8gQtye73Deng8Hd+Dr+cAoA2VIuAtrrbuQjC
         7wQbJAoxRw5Cwg0g6aSuUY8r2Yh9pSGNb4qdIAQbxgMhMlmOzYGlJsiGtpm4ETQcjTNS
         y60jGxsh2lsFogygK/SQ6UgoepJC1duvU8CtWTXBVDORn8FcSET+DJhz5Waf9XH8jf3X
         FEOG+wIf+pm6fWqOz1SMX70U/j4kRSMWWIp3NzEw+RSAElAxSLnOYz0fTwiY/li4PYle
         +H1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YLd6o7LN3LqvPwEWLdfJPuaCMuppb/NlA1oVwvVSznk=;
        b=LK/OAjHQv7MPqJgoJRElI5lV0MA5UdBsW2ouhOneGSGi+F36GCE1UBrEcZWluTwP2O
         0anIPBHb0kBclVPJ3/xZ6N5ZIDuwv+ugTyIFYXbBgdWHqK7JPrs0VI4BiX442We406WM
         4DCkI9Sc+a+5fwy8V6JruaPpHMm5e7ZXhGYDEXC61GwgNL8RMkAJkXRmUO6QOgpYxxea
         F0um2arGTvsCScj/ndorleZ87m71PNSYR7GCfyHvrk/dYEQBY8DXIrv2Wj31Yl5BfgRd
         +uqhfR16Ra/vmruIA9BpsBXx7cDpkka+bpsdf/gm4VzMHuXDbHsQBs8isdEWSVXujmOn
         iMNw==
X-Gm-Message-State: APjAAAV0K8C1LZQloEknQkGTmaNntkLuYaFQwUKD7pvXPDdjHfCQnJyn
        yFm7fdh5hC8abWeDOqYNzoJ5qII6
X-Google-Smtp-Source: APXvYqxEB0LwqpZsoNOX8vs0fedp1ViHnF2FKigRHBqbIDipaphTzssaZgorsoCKRSwVQeQiPYS1JQ==
X-Received: by 2002:a02:c055:: with SMTP id u21mr13553477jam.32.1566724324967;
        Sun, 25 Aug 2019 02:12:04 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id v23sm6061287ioh.58.2019.08.25.02.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 02:12:04 -0700 (PDT)
Date:   Sun, 25 Aug 2019 05:12:02 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v9 3/9] t3432: distinguish "noop-same" v.s. "work-same" in
 "same head" tests
Message-ID: <5c08e2b81fd65c5d4bcef1fb908987364143d181.1566724236.git.liu.denton@gmail.com>
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

