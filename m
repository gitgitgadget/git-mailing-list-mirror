Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11BBB20248
	for <e@80x24.org>; Thu, 21 Mar 2019 20:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfCUUvN (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 16:51:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37504 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfCUUvL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 16:51:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id w10so78450wrm.4
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 13:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cgo3NxIVUC5v6M283X2WVMC/ES7O0JJvxP2XwmLwG/o=;
        b=ohZ7+EY4lsIxfj2yvjLg15Vd9rj+88dAwKKQJtAeONNzQg1KCbgb5md55tC42Dmuag
         fvPuKvurNk2m/VxjTOsuD5kzjcI9FFzyMlnBEEeSpC8r0UBzebJsu3/pn19K+pwRqGlZ
         pkWkWkUL5H+RQQw6er2FQKFLC+4Sybkg0du93RucOzkskiTVRdSEcJJE0BVV7zKWcGQI
         wpbRvBoxAiiMUxO0AR3LlSZ29oRNl4b/5hdcg5UegaY+mXDmXEQVSgFaElJnGUlrdInr
         qmV0ITRtzay/V4dTaR5wFLPDa4bpCmaDfcpxrAz3jK+Hp5B5XlvQqrC8CyuKKCR0yK3p
         ceXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cgo3NxIVUC5v6M283X2WVMC/ES7O0JJvxP2XwmLwG/o=;
        b=Uj5n0THrU6tsczxQE/NIIrbx8raKLFKeNzSDgUFdfKYnriW2flLGZBd+LF8zbXOuWZ
         aG86vOmBwwApq8lNG6SzJGZ56iMQRXKztdXBE4AizyDzMSbXqXBDj3shQ2EJ3t6EKilW
         XmIhbaXfulobz0kZT5FSzzRKJJuItpGtmy4DN11/ZeL0h/v4eaKCicBdHwQoyzuy1uHE
         CrG+HA5td29fw8EQ6h89ZrXxLPDTXYSjqfbDldP6y5g7xYhX0Pl2cakSkPPLEWi6XWs5
         GJhJhnrJIUvm13tvhlp4DH+GKcRpUs4uyliEHhKMf7bMpH93rWBAFa5JQi/9PS69KHzA
         +JRA==
X-Gm-Message-State: APjAAAWMwEvgJRNcdmvGZstR90JwcVLb58uBWqgmyqknG7tRvcBJBycq
        /IwmfSHcAGNmINj2m+UZor11mdB2
X-Google-Smtp-Source: APXvYqzYPSB3/0dBhUihcejmVQfn8LWnNClIK7MKpk6P/QFx3ncAj/hB49dvVMgGxDuLGKFS4k9qTQ==
X-Received: by 2002:adf:fb0c:: with SMTP id c12mr4061290wrr.123.1553201469621;
        Thu, 21 Mar 2019 13:51:09 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b4sm6053978wmj.3.2019.03.21.13.51.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 21 Mar 2019 13:51:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 04/10] gc docs: include the "gc.*" section from "config" in "gc"
Date:   Thu, 21 Mar 2019 21:50:48 +0100
Message-Id: <20190321205054.17109-5-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190318161502.7979-1-avarab@gmail.com>
References: <20190318161502.7979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rather than duplicating the documentation for the various "gc" options
let's include the "gc" docs from git-config. They were mostly better
already, and now we don't have the same docs in two places with subtly
different wording.

In the cases where the git-gc(1) docs were saying something the "gc"
docs in git-config(1) didn't cover move the relevant section over to
the git-config(1) docs.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/gc.txt | 29 ++++++++++++-
 Documentation/git-gc.txt    | 86 +++----------------------------------
 2 files changed, 35 insertions(+), 80 deletions(-)

diff --git a/Documentation/config/gc.txt b/Documentation/config/gc.txt
index c6fbb8a96f..a255ae67b0 100644
--- a/Documentation/config/gc.txt
+++ b/Documentation/config/gc.txt
@@ -2,24 +2,39 @@ gc.aggressiveDepth::
 	The depth parameter used in the delta compression
 	algorithm used by 'git gc --aggressive'.  This defaults
 	to 50.
++
+See the documentation for the `--depth` option in
+linkgit:git-repack[1] for more details.
 
 gc.aggressiveWindow::
 	The window size parameter used in the delta compression
 	algorithm used by 'git gc --aggressive'.  This defaults
 	to 250.
++
+See the documentation for the `--window` option in
+linkgit:git-repack[1] for more details.
 
 gc.auto::
 	When there are approximately more than this many loose
 	objects in the repository, `git gc --auto` will pack them.
 	Some Porcelain commands use this command to perform a
 	light-weight garbage collection from time to time.  The
-	default value is 6700.  Setting this to 0 disables it.
+	default value is 6700.
++
+Setting this to 0 disables not only automatic packing based on the
+number of loose objects, but any other heuristic `git gc --auto` will
+otherwise use to determine if there's work to do, such as
+`gc.autoPackLimit`.
 
 gc.autoPackLimit::
 	When there are more than this many packs that are not
 	marked with `*.keep` file in the repository, `git gc
 	--auto` consolidates them into one larger pack.  The
 	default	value is 50.  Setting this to 0 disables it.
+	Setting `gc.auto` to 0 will also disable this.
++
+See the `gc.bigPackThreshold` configuration variable below. When in
+use, it'll affect how the auto pack limit works.
 
 gc.autoDetach::
 	Make `git gc --auto` return immediately and run in background
@@ -36,6 +51,11 @@ Note that if the number of kept packs is more than gc.autoPackLimit,
 this configuration variable is ignored, all packs except the base pack
 will be repacked. After this the number of packs should go below
 gc.autoPackLimit and gc.bigPackThreshold should be respected again.
++
+If the amount of memory estimated for `git repack` to run smoothly is
+not available and `gc.bigPackThreshold` is not set, the largest
+pack will also be excluded (this is the equivalent of running `git gc`
+with `--keep-base-pack`).
 
 gc.writeCommitGraph::
 	If true, then gc will rewrite the commit-graph file when
@@ -94,6 +114,13 @@ gc.<pattern>.reflogExpireUnreachable::
 	With "<pattern>" (e.g. "refs/stash")
 	in the middle, the setting applies only to the refs that
 	match the <pattern>.
++
+These types of entries are generally created as
+a result of using `git commit --amend` or `git rebase` and are the
+commits prior to the amend or rebase occurring.  Since these changes
+are not part of the current project most users will want to expire
+them sooner, which is why the default is more aggressive than
+`gc.reflogExpire`.
 
 gc.rerereResolved::
 	Records of conflicted merge you resolved earlier are
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index c31fe581d9..ba1ff9b4cf 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -45,28 +45,12 @@ OPTIONS
 --auto::
 	With this option, 'git gc' checks whether any housekeeping is
 	required; if not, it exits without performing any work.
-	Some git commands run `git gc --auto` after performing
-	operations that could create many loose objects. Housekeeping
-	is required if there are too many loose objects or too many
-	packs in the repository.
 +
-If the number of loose objects exceeds the value of the `gc.auto`
-configuration variable, then all loose objects are combined into a
-single pack.  Setting the value of `gc.auto`
-to 0 disables automatic packing of loose objects.
+See the `gc.auto' option in the "CONFIGURATION" section below for how
+this heuristic works.
 +
-If the number of packs exceeds the value of `gc.autoPackLimit`,
-then existing packs (except those marked with a `.keep` file
-or over `gc.bigPackThreshold` limit)
-are consolidated into a single pack.
-If the amount of memory estimated for `git repack` to run smoothly is
-not available and `gc.bigPackThreshold` is not set, the largest
-pack will also be excluded (this is the equivalent of running `git gc`
-with `--keep-base-pack`).
-Setting `gc.autoPackLimit` to 0 disables automatic consolidation of
-packs.
-+
-If houskeeping is required due to many loose objects or packs, all
+Once housekeeping is triggered by exceeding the limits of
+configuration options such as `gc.auto` and `gc.autoPackLimit`, all
 other housekeeping tasks (e.g. rerere, working trees, reflog...) will
 be performed as well.
 
@@ -97,66 +81,10 @@ be performed as well.
 CONFIGURATION
 -------------
 
-The optional configuration variable `gc.reflogExpire` can be
-set to indicate how long historical entries within each branch's
-reflog should remain available in this repository.  The setting is
-expressed as a length of time, for example '90 days' or '3 months'.
-It defaults to '90 days'.
-
-The optional configuration variable `gc.reflogExpireUnreachable`
-can be set to indicate how long historical reflog entries which
-are not part of the current branch should remain available in
-this repository.  These types of entries are generally created as
-a result of using `git commit --amend` or `git rebase` and are the
-commits prior to the amend or rebase occurring.  Since these changes
-are not part of the current project most users will want to expire
-them sooner.  This option defaults to '30 days'.
-
-The above two configuration variables can be given to a pattern.  For
-example, this sets non-default expiry values only to remote-tracking
-branches:
-
-------------
-[gc "refs/remotes/*"]
-	reflogExpire = never
-	reflogExpireUnreachable = 3 days
-------------
-
-The optional configuration variable `gc.rerereResolved` indicates
-how long records of conflicted merge you resolved earlier are
-kept.  This defaults to 60 days.
-
-The optional configuration variable `gc.rerereUnresolved` indicates
-how long records of conflicted merge you have not resolved are
-kept.  This defaults to 15 days.
-
-The optional configuration variable `gc.packRefs` determines if
-'git gc' runs 'git pack-refs'. This can be set to "notbare" to enable
-it within all non-bare repos or it can be set to a boolean value.
-This defaults to true.
-
-The optional configuration variable `gc.writeCommitGraph` determines if
-'git gc' should run 'git commit-graph write'. This can be set to a
-boolean value. This defaults to false.
-
-The optional configuration variable `gc.aggressiveWindow` controls how
-much time is spent optimizing the delta compression of the objects in
-the repository when the --aggressive option is specified.  The larger
-the value, the more time is spent optimizing the delta compression.  See
-the documentation for the --window option in linkgit:git-repack[1] for
-more details.  This defaults to 250.
-
-Similarly, the optional configuration variable `gc.aggressiveDepth`
-controls --depth option in linkgit:git-repack[1]. This defaults to 50.
-
-The optional configuration variable `gc.pruneExpire` controls how old
-the unreferenced loose objects have to be before they are pruned.  The
-default is "2 weeks ago".
-
-Optional configuration variable `gc.worktreePruneExpire` controls how
-old a stale working tree should be before `git worktree prune` deletes
-it. Default is "3 months ago".
+The below documentation is the same as what's found in
+linkgit:git-config[1]:
 
+include::config/gc.txt[]
 
 NOTES
 -----
-- 
2.21.0.360.g471c308f928

