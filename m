Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 456FB1F45F
	for <e@80x24.org>; Wed,  8 May 2019 00:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfEHANN (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 20:13:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44193 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfEHANN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 20:13:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id c5so24630196wrs.11
        for <git@vger.kernel.org>; Tue, 07 May 2019 17:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iETxnfYoKPo3dVN8H+8V+vhlq3WbJMMC8m4v3u0gkS8=;
        b=u7HJTegxPKDv+eJTjOjbNUp5N9A4ZhUXuBiotgt77Gzsjy0llexty64TfTNnOScbCQ
         HTJEdgNtbEutESFM4+Dp5uxt9p13QO05s/LMGWBpKqRKHtSncmbRE6aGq3nvnia3Uj1H
         NfNLz1gCTK4YFjqcvVMLMM5zy2i+cr4Qd2CIlWgWnu5boHLOtWuauLBbSpsv4HVFlPkl
         wOLInl7VE9UlReERjb5pJJAJptau1etp1kRRKDSHzZBvCcxkLTBgiVG1iH75pqYNXcoB
         aEVABeuczP8JfB/cJCHGHdlFbKeBB41U1hawz1jPK2K748YpKQmImZsMPkRHIODgTA+p
         2Saw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iETxnfYoKPo3dVN8H+8V+vhlq3WbJMMC8m4v3u0gkS8=;
        b=TxuqlQmPasqnQAMbCQ6DlSigtNYk2QWH4Gacq4XJJrL2tS4aBvmYt0uXw20XBh1pTM
         t7egV9L2XE5b9vbPSXPAqJuNaMxAnQ6lqZjeOuSFe1RDXCxZnwUA/tmn6aYnwD6nNm+K
         PFOgpfYx+G2EnsJfhROsecDge7vq8fZRFvb6hIfwxX6i42SSD1Fw4J0qcvfVGsJA9g6q
         ahMVaoun2JjAfLsnHLcgVrITL5D43hOxj5Og+Scxs+RNeHPZswjomnfVI88OhMVYLH3H
         38U2glEoi2OgAshlYA5u+9m5U2TcaJg5oN1hivU/nZcrORjXOmWJKle+fd9zr+Ptx8VG
         r18A==
X-Gm-Message-State: APjAAAXtImVmVlP2CDfhqJiCdnsi2rmD72jZR+KLACsqIMYMe2Q9Lewe
        lzhoHBLXP6MfWasGc5BjSIfsZyfVf2g=
X-Google-Smtp-Source: APXvYqxFfUR5lOFzCDU9GXhuK0h18gndCD3A58FeV5vx57Tt4EpBYjEZ9uKqlN95jjRzIC6SqeB+Gg==
X-Received: by 2002:a5d:6a47:: with SMTP id t7mr23568681wrw.307.1557274390836;
        Tue, 07 May 2019 17:13:10 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n15sm5167825wrp.58.2019.05.07.17.13.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 07 May 2019 17:13:09 -0700 (PDT)
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
Subject: [RFC WIP PATCH v8 03/13] t3432: distinguish "noop-same" v.s. "work-same" in "same head" tests
Date:   Wed,  8 May 2019 02:12:42 +0200
Message-Id: <20190508001252.15752-4-avarab@gmail.com>
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
---
 t/t3432-rebase-fast-forward.sh | 79 +++++++++++++++++++++-------------
 1 file changed, 48 insertions(+), 31 deletions(-)

diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
index f49af274e0..dd51e28b56 100755
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
+test_expect_success 'add work same  to side' '
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
+test_expect_success 'add work same  to upstream' '
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
2.21.0.1020.gf2820cf01a

