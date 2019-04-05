Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B04F420248
	for <e@80x24.org>; Fri,  5 Apr 2019 21:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfDEVkC (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 17:40:02 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35442 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfDEVkC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 17:40:02 -0400
Received: by mail-pf1-f196.google.com with SMTP id t21so1646129pfh.2
        for <git@vger.kernel.org>; Fri, 05 Apr 2019 14:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jOhTeKqUbY4obqKZ37X5dxxlUO9w8f891tgMoV9IIns=;
        b=QxVC3DJ9cYD26qyh/1tT9mtjylkAjY/4kJkYE1aD7O5FokT3H7NIbM6bANjyEe7Nz+
         xcuYiOf9xvneA37MgvrSjR4VCBqVTDSl10owk+LoS7bpRZ1UZqw2yHyGOnfUU5h8ujA5
         XGphMeC2LgZz5VUFCeu+xnCDVdFryQXqnApoZUhEAFdJFDhU2svn/DAcyZjQP7dQ1o51
         bzkfVEVsjlnc5gzo03UqfzSPM92FGO3KcZ0OF9CdXdChJci2/f3xN4UhQR/ZhaIiFOj5
         2txettE+T3al46TLfyFxRgLSxkb/UobEwzr4WqqAhAiueqQV01SCzPVDL3HQnO8UVqtr
         mhdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jOhTeKqUbY4obqKZ37X5dxxlUO9w8f891tgMoV9IIns=;
        b=pw01f7J4PAF0p8oI6azC46W1C/yaZPY7191FlCPahiGIDFs9O5cf7bCuZdl6T2aaBW
         6UGJDHGdQNqeFrf5bQXrU3mhO8y1P1LJChHD/9293s+azZjrT9kUtURU6ps2FAADhFe9
         BGmMUSKsN/gKQt/QyBreKingXbRruvv6WTnYyhYZJycwaq+KlwVId6fK+dyhj/mErmnn
         18jPo4f5xDmFFuLh0oh8KpAkPHI/PqE+mwG6hJn5fC8UFGR8M0p2K4z3wqQGmi4a43bX
         S1klhXH88Bv7C6k1p/gUHPeMRU1ZoCUdLdJQX/u1z+3ToO5WAcdW7ryv7GBb+r9LcQHQ
         1D9g==
X-Gm-Message-State: APjAAAXKfELXAP/chQmFBg/lwyHjXnR4pa7IM7/KhDTVqAiNvuoEBrEX
        pOckc+NjXyy0f2Ej5L0C+rdrLi/k
X-Google-Smtp-Source: APXvYqy1+W/U2yP53Zh7r+G2pYIlURemvQKH5Xr8ii/Q9JSpIp15QnsiaxXoZ+D9jQfC6lr2xOxZ8Q==
X-Received: by 2002:a62:ae13:: with SMTP id q19mr15192923pff.152.1554500400710;
        Fri, 05 Apr 2019 14:40:00 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id s15sm26730622pga.71.2019.04.05.14.39.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 14:39:59 -0700 (PDT)
Date:   Fri, 5 Apr 2019 14:39:58 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v4 0/4] rebase: teach rebase --keep-base
Message-ID: <cover.1554500051.git.liu.denton@gmail.com>
References: <cover.1554151449.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1554151449.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I dug into it a little more and according to the bash 4.2->4.3
changelog,

	bbb. Fixed a bug that caused spurious DEL characters (\177) to appear in
	double-quoted expansion where the RHS is evaluated to the empty string.

so, in particular, I've removed all of the '' from the tests.

I also downloaded bash 4.2 and tested everything with that. Seems to be
working well!

Thanks for catching this!

---

This patchset now depends "[PATCH 1/8] tests (rebase): spell out the
`--keep-empty` option" which is the first patch of Johannes's "Do not
use abbreviated options in tests" patchset[1]. (Thanks for catching
that, Johannes!)

Changes since v1:

* Squashed old set into one patch
* Fixed indentation style and dangling else
* Added more documentation after discussion with Ævar

Changes since v2:

* Add testing for rebase --fork-point behaviour
* Add testing for rebase fast-forward behaviour
* Make rebase --onto fast-forward in more cases
* Update documentation to include use-case

Changes since v3:

* Fix tests failing on bash 4.2
* Fix typo in t3431 comment

[1]: https://public-inbox.org/git/a1b4b74b9167e279dae4cd8c58fb28d8a714a66a.1553537656.git.gitgitgadget@gmail.com/

Denton Liu (4):
  t3431: add rebase --fork-point tests
  t3432: test rebase fast-forward behavior
  rebase: fast-forward --onto in more cases
  rebase: teach rebase --keep-base

 Documentation/git-rebase.txt     | 30 +++++++++++--
 builtin/rebase.c                 | 72 +++++++++++++++++++++++---------
 t/t3400-rebase.sh                |  2 +-
 t/t3404-rebase-interactive.sh    |  2 +-
 t/t3416-rebase-onto-threedots.sh | 57 +++++++++++++++++++++++++
 t/t3431-rebase-fork-point.sh     | 57 +++++++++++++++++++++++++
 t/t3432-rebase-fast-forward.sh   | 62 +++++++++++++++++++++++++++
 7 files changed, 258 insertions(+), 24 deletions(-)
 create mode 100755 t/t3431-rebase-fork-point.sh
 create mode 100755 t/t3432-rebase-fast-forward.sh

Interdiff against v3:
diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
index 0311bcbc68..e63040932f 100755
--- a/t/t3431-rebase-fork-point.sh
+++ b/t/t3431-rebase-fork-point.sh
@@ -11,7 +11,7 @@ test_description='git rebase --fork-point test'
 #     \
 #      C*---F---G (side)
 #
-# C was formerly part of master but is side out
+# C was formerly part of master but master was rewound to remove C
 #
 test_expect_success setup '
 	test_commit A &&
@@ -29,29 +29,29 @@ test_expect_success setup '
 test_rebase() {
 	expected="$1" &&
 	shift &&
-	test_expect_success "git rebase $@" "
+	test_expect_success "git rebase $*" "
 		git checkout master &&
 		git reset --hard E &&
 		git checkout side &&
 		git reset --hard G &&
-		git rebase $@ &&
+		git rebase $* &&
 		test_write_lines $expected >expect &&
 		git log --pretty=%s >actual &&
 		test_cmp expect actual
 	"
 }
 
-test_rebase 'G F E D B A' ''
-test_rebase 'G F D B A' '--onto D'
-test_rebase 'G F B A' '--keep-base'
-test_rebase 'G F C E D B A' '--no-fork-point'
-test_rebase 'G F C D B A' '--no-fork-point --onto D'
-test_rebase 'G F C B A' '--no-fork-point --keep-base'
-test_rebase 'G F E D B A' '--fork-point refs/heads/master'
-test_rebase 'G F D B A' '--fork-point --onto D refs/heads/master'
-test_rebase 'G F B A' '--fork-point --keep-base refs/heads/master'
-test_rebase 'G F C E D B A' 'refs/heads/master'
-test_rebase 'G F C D B A' '--onto D refs/heads/master'
-test_rebase 'G F C B A' '--keep-base refs/heads/master'
+test_rebase 'G F E D B A'
+test_rebase 'G F D B A' --onto D
+test_rebase 'G F B A' --keep-base
+test_rebase 'G F C E D B A' --no-fork-point
+test_rebase 'G F C D B A' --no-fork-point --onto D
+test_rebase 'G F C B A' --no-fork-point --keep-base
+test_rebase 'G F E D B A' --fork-point refs/heads/master
+test_rebase 'G F D B A' --fork-point --onto D refs/heads/master
+test_rebase 'G F B A' --fork-point --keep-base refs/heads/master
+test_rebase 'G F C E D B A' refs/heads/master
+test_rebase 'G F C D B A' --onto D refs/heads/master
+test_rebase 'G F C B A' --keep-base refs/heads/master
 
 test_done
diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
index 8585c21c5c..f493ce64c4 100755
--- a/t/t3432-rebase-fast-forward.sh
+++ b/t/t3432-rebase-fast-forward.sh
@@ -18,34 +18,34 @@ test_expect_success setup '
 test_rebase_same_head() {
 	status="$1" &&
 	shift &&
-	test_expect_$status "git rebase $@ with $changes is no-op" "
+	test_expect_$status "git rebase $* with $changes is no-op" "
 		oldhead=\$(git rev-parse HEAD) &&
 		test_when_finished 'git reset --hard \$oldhead' &&
-		git rebase $@ &&
+		git rebase $* &&
 		newhead=\$(git rev-parse HEAD) &&
 		test_cmp_rev \$oldhead \$newhead
 	"
 }
 
 changes='no changes'
-test_rebase_same_head success ''
-test_rebase_same_head success 'master'
-test_rebase_same_head success '--onto B B'
-test_rebase_same_head success '--onto B... B'
-test_rebase_same_head success '--onto master... master'
-test_rebase_same_head success '--keep-base master'
+test_rebase_same_head success
+test_rebase_same_head success master
+test_rebase_same_head success --onto B B
+test_rebase_same_head success --onto B... B
+test_rebase_same_head success --onto master... master
+test_rebase_same_head success --keep-base master
 
 test_expect_success 'add work to side' '
 	test_commit E
 '
 
 changes='our changes'
-test_rebase_same_head success ''
-test_rebase_same_head success 'master'
-test_rebase_same_head success '--onto B B'
-test_rebase_same_head success '--onto B... B'
-test_rebase_same_head success '--onto master... master'
-test_rebase_same_head success '--keep-base master'
+test_rebase_same_head success
+test_rebase_same_head success master
+test_rebase_same_head success --onto B B
+test_rebase_same_head success --onto B... B
+test_rebase_same_head success --onto master... master
+test_rebase_same_head success --keep-base master
 
 test_expect_success 'add work to upstream' '
 	git checkout master &&
@@ -54,9 +54,9 @@ test_expect_success 'add work to upstream' '
 '
 
 changes='our and their changes'
-test_rebase_same_head success '--onto B B'
-test_rebase_same_head success '--onto B... B'
-test_rebase_same_head success '--onto master... master'
-test_rebase_same_head success '--keep-base master'
+test_rebase_same_head success --onto B B
+test_rebase_same_head success --onto B... B
+test_rebase_same_head success --onto master... master
+test_rebase_same_head success --keep-base master
 
 test_done
-- 
2.21.0.843.gd0ae0373aa

