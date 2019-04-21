Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A2FA20248
	for <e@80x24.org>; Sun, 21 Apr 2019 08:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfDUILT (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Apr 2019 04:11:19 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42176 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfDUILT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Apr 2019 04:11:19 -0400
Received: by mail-pf1-f194.google.com with SMTP id w25so4329627pfi.9
        for <git@vger.kernel.org>; Sun, 21 Apr 2019 01:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hyDsO78qh8nWHAElULPeCXK9hd/Yuseps9GDals1Ivk=;
        b=kIhmxKhl4CDLK3nXO3r0cQ+HsxiY13ADXvKeTjjj696qxRuH13fY2Kdls+523GKRON
         KLAsMP1HE4xmPfvQMNPstqsGi0ZzxFV+w6gAWyT794qLNtjIXX58Srz+MGD9ianp3E8P
         bp+Z+3ews9IOg6Iq5x7zUDtaMqHhGibg+oIg5Gzw1MuoSsSatbTSm5xyPb5440JGg1ug
         pnsDJ7ZTVyKJ5lhGByDANrBJh0drFBjprPmQPhl8CkAfilddnkzpcaTLr8Khuu2cHJs2
         /nH/zlY4EjSx/oPl8I1ZvwxI7iKSYjwgJ7dRXCFQpVii3RJKC9BDowQe9byBke6zwSaY
         4lUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hyDsO78qh8nWHAElULPeCXK9hd/Yuseps9GDals1Ivk=;
        b=J6iTNjSX7Hi3Wp7nrwBCHOfWxdbT7Xj+sn2eK+QAwNcHS11jX0jVpZLFlDYoEG9r9p
         6XOO1xORmxpZB7ub4F27QN1fVXoB6UVDO0C67w5uqtrOlCG/T0o4DunpBLXNC3nSWSyr
         o/ViLbyn20u+tI40I2cxikdlAToglue2nHfU/6rQF/dlbZy6fABNjmgZOCp0QUoJJabP
         UAjSWWBa64on/ppwfgt/0nL2vUDVKUbmLfuzfZl9o19nVc3+OSAPcssDeScAOanwag4d
         eU60o6t+u6E8SA3xXKEO3WPbuaWy95dFiSecRGiuQPRQw0RYsUNdU8y72ZKzJogyAHks
         JspQ==
X-Gm-Message-State: APjAAAWUpAm9pmBuL4I4bcPjLBRVbZlOQFTNB/DHweKfPRGEfiL8IDKo
        hcQUnHuVFEXKWzoKJp5ehygKy3MZ
X-Google-Smtp-Source: APXvYqzD9a78UZlI3iJrt1TWZz0a6JA/olw0R4pTQvBx0uIZrFifUG8XofYt2agIiaZ3Hp1mdCOjbg==
X-Received: by 2002:a63:4a1b:: with SMTP id x27mr3885761pga.204.1555834278221;
        Sun, 21 Apr 2019 01:11:18 -0700 (PDT)
Received: from archbookpro.localdomain ([2601:647:4b00:5d::661d])
        by smtp.gmail.com with ESMTPSA id h19sm16165712pfd.130.2019.04.21.01.11.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Apr 2019 01:11:17 -0700 (PDT)
Date:   Sun, 21 Apr 2019 01:11:15 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v7 0/6] rebase: learn --keep-base
Message-ID: <cover.1555832783.git.liu.denton@gmail.com>
References: <cover.1555523176.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1555523176.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

Sorry for yet another reroll. I realised earlier that rebase doesn't use
--git-completion-helper for completion so I had to manually insert
--keep-base into the completion script.

Between this and forgetting to update the comment around the
can_fast_forward call, I figured with the number of mistakes to fix, it
was worth another reroll.

Thanks,

Denton

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

Changes since v4:

* Make rebase --fork-point fast-forward in more cases

Changes since v5:

* Fix graph illustrations so that the "branch off" is visually in the
  correct place
* Refactor if-else in can_fast_forward into one-level-deep ifs to
  increase clarity

Changes since v6:

* Remove redundant braces around if
* Update comment around can_fast_forward call
* Add completion for rebase

[1]: https://public-inbox.org/git/a1b4b74b9167e279dae4cd8c58fb28d8a714a66a.1553537656.git.gitgitgadget@gmail.com/


Denton Liu (6):
  t3431: add rebase --fork-point tests
  t3432: test rebase fast-forward behavior
  rebase: refactor can_fast_forward into goto tower
  rebase: fast-forward --onto in more cases
  rebase: fast-forward --fork-point in more cases
  rebase: teach rebase --keep-base

 Documentation/git-rebase.txt           | 30 ++++++++-
 builtin/rebase.c                       | 87 +++++++++++++++++++-------
 contrib/completion/git-completion.bash |  2 +-
 t/t3400-rebase.sh                      |  2 +-
 t/t3404-rebase-interactive.sh          |  2 +-
 t/t3416-rebase-onto-threedots.sh       | 57 +++++++++++++++++
 t/t3431-rebase-fork-point.sh           | 57 +++++++++++++++++
 t/t3432-rebase-fast-forward.sh         | 83 ++++++++++++++++++++++++
 8 files changed, 291 insertions(+), 29 deletions(-)
 create mode 100755 t/t3431-rebase-fork-point.sh
 create mode 100755 t/t3432-rebase-fast-forward.sh

Interdiff against v6:
diff --git a/builtin/rebase.c b/builtin/rebase.c
index cf63195e7d..19e7e2a1c9 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1723,7 +1723,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	/*
 	 * Check if we are already based on onto with linear history,
-	 * but this should be done if this is not an interactive rebase.
+	 * in which case we could fast-forward without replacing the commits
+	 * with new commits recreated by replaying their changes. This
+	 * optimization must not be done if this is an interactive rebase.
 	 */
 	if (can_fast_forward(options.onto, options.upstream, options.restrict_revision,
 		    &options.orig_head, &merge_base) &&
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 976e4a6548..f9dc431a39 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2027,7 +2027,7 @@ _git_rebase ()
 			--autosquash --no-autosquash
 			--fork-point --no-fork-point
 			--autostash --no-autostash
-			--verify --no-verify
+			--verify --no-verify --keep-base
 			--keep-empty --root --force-rebase --no-ff
 			--rerere-autoupdate
 			--exec
-- 
2.21.0.967.gf85e14fd49

