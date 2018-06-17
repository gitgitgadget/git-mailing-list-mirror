Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A3191F403
	for <e@80x24.org>; Sun, 17 Jun 2018 05:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753931AbeFQF7H (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Jun 2018 01:59:07 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:40522 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753576AbeFQF7F (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jun 2018 01:59:05 -0400
Received: by mail-oi0-f65.google.com with SMTP id f79-v6so12189609oib.7
        for <git@vger.kernel.org>; Sat, 16 Jun 2018 22:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W1SwQ8Dh92vzTTrvR+p3AgwzcpUavTsACn/HSl3YuIE=;
        b=dt//Tv/O8kM9Ktnx49LF53/QD/8aYI9KtB8ViBZPKAyyiUk+aa2vICG9jUpqM//609
         E1P/W6cTLDEKK8mfu5+Zfz8cMNe/5RQVgIoMTYovL/bk24n1ehbyQydpxEcx78lbnPgI
         nBipNMcuOnRtmhzWsxHiZa2+36q5IOzhbCiaotCGsAO8y2eD/GH2DCPWfF8WttfEZ59H
         fRItOaK1zggVQAYQPZvIU7LPZ/A1dBKBiH1lGVfjoQPmQRScZUx/tqocV4AI5YooWeYa
         oW4YQuYg5uA9nJ0MaTEmc+xZJlGm/hWc2+6n5gyDz7qUxwdrsgCY/Sch4B3sP9dtlEd7
         nlww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W1SwQ8Dh92vzTTrvR+p3AgwzcpUavTsACn/HSl3YuIE=;
        b=poGxgKeKeHUGkvNLjn5bHxvK/rpw2Kkfn30AYj+9UDzSkJpsZq0iW6LqWkTPTW2Y++
         GZQV+PjhvUHOTpsL+7Nt3AQXBin/8EDyrUMUzbvQwjsa7l6hVSepXw4FjlIoSI1UJ2Kf
         R//Z2E7BTuVtkcSc/CtvhkqrbUMnb7aK5b/QQEPnM8SbDvtB2AjmXSz63vFYKInCV90Z
         hxfH4V5bvL7iYkzKQkBORIgVUy9Yz78BaFJf/c2NZsF8Dk9i6hINHCPLizdJ4xwKQgql
         /xilS6+RSxuH21Q7zOmsqnunbR59UJtWoRtInmj+Ni+JN0RJF3V33byh2UH+7T6E+512
         44BA==
X-Gm-Message-State: APt69E0SJi3P4TArZ2bE3mEiW20tSJsWsGUicD3GSboewkpi683IX6kB
        UOszItnHD5m71Ssb5QgCba5P1w==
X-Google-Smtp-Source: ADUXVKK47mHqycxbkkjm9hA/qb/fyxDgsvTy2KUJSFHLpSIxhUWl66vqgs0VaA3Ja9/b/sWdu2414Q==
X-Received: by 2002:aca:f06:: with SMTP id 6-v6mr4621287oip.183.1529215144448;
        Sat, 16 Jun 2018 22:59:04 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id h12-v6sm5366091oti.4.2018.06.16.22.59.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Jun 2018 22:59:03 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org, phillip.wood@dunelm.org.uk
Cc:     johannes.schindelin@gmx.de, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH v2 1/7] git-rebase.txt: document incompatible options
Date:   Sat, 16 Jun 2018 22:58:50 -0700
Message-Id: <20180617055856.22838-2-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.rc1.7.gab8805c40a
In-Reply-To: <20180617055856.22838-1-newren@gmail.com>
References: <20180607050654.19663-1-newren@gmail.com>
 <20180617055856.22838-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git rebase has many options that only work with one of its three backends.
It also has a few other pairs of incompatible options.  Document these.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt | 84 ++++++++++++++++++++++++++++++++----
 1 file changed, 76 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 0e20a66e73..adccc15284 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -243,11 +243,15 @@ leave out at most one of A and B, in which case it defaults to HEAD.
 --keep-empty::
 	Keep the commits that do not change anything from its
 	parents in the result.
++
+See also INCOMPATIBLE OPTIONS below.
 
 --allow-empty-message::
 	By default, rebasing commits with an empty message will fail.
 	This option overrides that behavior, allowing commits with empty
 	messages to be rebased.
++
+See also INCOMPATIBLE OPTIONS below.
 
 --skip::
 	Restart the rebasing process by skipping the current patch.
@@ -271,6 +275,8 @@ branch on top of the <upstream> branch.  Because of this, when a merge
 conflict happens, the side reported as 'ours' is the so-far rebased
 series, starting with <upstream>, and 'theirs' is the working branch.  In
 other words, the sides are swapped.
++
+See also INCOMPATIBLE OPTIONS below.
 
 -s <strategy>::
 --strategy=<strategy>::
@@ -280,8 +286,10 @@ other words, the sides are swapped.
 +
 Because 'git rebase' replays each commit from the working branch
 on top of the <upstream> branch using the given strategy, using
-the 'ours' strategy simply discards all patches from the <branch>,
+the 'ours' strategy simply empties all patches from the <branch>,
 which makes little sense.
++
+See also INCOMPATIBLE OPTIONS below.
 
 -X <strategy-option>::
 --strategy-option=<strategy-option>::
@@ -289,6 +297,8 @@ which makes little sense.
 	This implies `--merge` and, if no strategy has been
 	specified, `-s recursive`.  Note the reversal of 'ours' and
 	'theirs' as noted above for the `-m` option.
++
+See also INCOMPATIBLE OPTIONS below.
 
 -S[<keyid>]::
 --gpg-sign[=<keyid>]::
@@ -324,6 +334,8 @@ which makes little sense.
 	and after each change.  When fewer lines of surrounding
 	context exist they all must match.  By default no context is
 	ever ignored.
++
+See also INCOMPATIBLE OPTIONS below.
 
 -f::
 --force-rebase::
@@ -355,19 +367,22 @@ default is `--no-fork-point`, otherwise the default is `--fork-point`.
 --whitespace=<option>::
 	These flag are passed to the 'git apply' program
 	(see linkgit:git-apply[1]) that applies the patch.
-	Incompatible with the --interactive option.
++
+See also INCOMPATIBLE OPTIONS below.
 
 --committer-date-is-author-date::
 --ignore-date::
 	These flags are passed to 'git am' to easily change the dates
 	of the rebased commits (see linkgit:git-am[1]).
-	Incompatible with the --interactive option.
++
+See also INCOMPATIBLE OPTIONS below.
 
 --signoff::
 	Add a Signed-off-by: trailer to all the rebased commits. Note
 	that if `--interactive` is given then only commits marked to be
-	picked, edited or reworded will have the trailer added. Incompatible
-	with the `--preserve-merges` option.
+	picked, edited or reworded will have the trailer added.
++
+See also INCOMPATIBLE OPTIONS below.
 
 -i::
 --interactive::
@@ -378,6 +393,8 @@ default is `--no-fork-point`, otherwise the default is `--fork-point`.
 The commit list format can be changed by setting the configuration option
 rebase.instructionFormat.  A customized instruction format will automatically
 have the long commit hash prepended to the format.
++
+See also INCOMPATIBLE OPTIONS below.
 
 -r::
 --rebase-merges[=(rebase-cousins|no-rebase-cousins)]::
@@ -404,7 +421,7 @@ It is currently only possible to recreate the merge commits using the
 `recursive` merge strategy; Different merge strategies can be used only via
 explicit `exec git merge -s <strategy> [...]` commands.
 +
-See also REBASING MERGES below.
+See also REBASING MERGES and INCOMPATIBLE OPTIONS below.
 
 -p::
 --preserve-merges::
@@ -415,6 +432,8 @@ See also REBASING MERGES below.
 This uses the `--interactive` machinery internally, but combining it
 with the `--interactive` option explicitly is generally not a good
 idea unless you know what you are doing (see BUGS below).
++
+See also INCOMPATIBLE OPTIONS below.
 
 -x <cmd>::
 --exec <cmd>::
@@ -437,6 +456,8 @@ squash/fixup series.
 +
 This uses the `--interactive` machinery internally, but it can be run
 without an explicit `--interactive`.
++
+See also INCOMPATIBLE OPTIONS below.
 
 --root::
 	Rebase all commits reachable from <branch>, instead of
@@ -447,6 +468,8 @@ without an explicit `--interactive`.
 	When used together with both --onto and --preserve-merges,
 	'all' root commits will be rewritten to have <newbase> as parent
 	instead.
++
+See also INCOMPATIBLE OPTIONS below.
 
 --autosquash::
 --no-autosquash::
@@ -461,11 +484,11 @@ without an explicit `--interactive`.
 	too.  The recommended way to create fixup/squash commits is by using
 	the `--fixup`/`--squash` options of linkgit:git-commit[1].
 +
-This option is only valid when the `--interactive` option is used.
-+
 If the `--autosquash` option is enabled by default using the
 configuration variable `rebase.autoSquash`, this option can be
 used to override and disable this setting.
++
+See also INCOMPATIBLE OPTIONS below.
 
 --autostash::
 --no-autostash::
@@ -487,6 +510,51 @@ recreates the topic branch with fresh commits so it can be remerged
 successfully without needing to "revert the reversion" (see the
 link:howto/revert-a-faulty-merge.html[revert-a-faulty-merge How-To] for details).
 
+INCOMPATIBLE OPTIONS
+--------------------
+
+git-rebase has many flags that are incompatible with each other,
+predominantly due to the fact that it has three different underlying
+implementations:
+
+ * one based on linkgit:git-am[1] (the default)
+ * one based on linkgit:git-merge-recursive[1] (merge backend)
+ * one based on linkgit:git-cherry-pick[1] (interactive backend)
+
+Flags only understood by the am backend:
+
+ * --committer-date-is-author-date
+ * --ignore-date
+ * --whitespace
+ * --ignore-whitespace
+ * -C
+
+Flags understood by both merge and interactive backends:
+
+ * --merge
+ * --strategy
+ * --strategy-option
+ * --allow-empty-message
+
+Flags only understood by the interactive backend:
+
+ * --[no-]autosquash
+ * --rebase-merges
+ * --preserve-merges
+ * --interactive
+ * --exec
+ * --keep-empty
+ * --autosquash
+ * --edit-todo
+ * --root + --onto
+
+Other incompatible flag pairs:
+
+ * --preserve-merges && --interactive
+ * --preserve-merges && --signoff
+ * --preserve-merges && --rebase-merges
+ * --rebase-merges && --strategy
+
 include::merge-strategies.txt[]
 
 NOTES
-- 
2.18.0.rc2.1.g5453d3f70b.dirty

