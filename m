Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C5B420248
	for <e@80x24.org>; Mon, 18 Mar 2019 16:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbfCRQPW (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 12:15:22 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:33435 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbfCRQPV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 12:15:21 -0400
Received: by mail-wr1-f50.google.com with SMTP id q1so2067085wrp.0
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 09:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xBSbKDrcPVlYZOKxqoQURKFY4gVAMC3st+vmY0zSaKU=;
        b=CePlTLpYHcxgXNUGaI9yIMiTTbWZyRHCJy3TG4bezHKDkjkzFZSWoVHdfNylrySGX+
         GWZAJihh1Wcfuv/kHE7UFs82wrzwvu0UbzZY+eHL354OEFvyve5lTplg+QKB6p28mFDU
         3q4eO6oOpTFVapsU7yAKP31amhypJdPXNRRJtqWVy4DyIONXSd3HGstTPca0s22fD41e
         D9b++Qw5ZO1AWeVlXPd1xnUpAzpSQ+zjy4ePCRMesGfxA4/IRhZMFf2TO2lf/ZPtYNbh
         wzOy0AUPrAsJzoJHYanhnp0VMB2VUDGCFdEKxZb+0pzny6YPtkwPq8zjfXnCD8X53gm9
         Eh0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xBSbKDrcPVlYZOKxqoQURKFY4gVAMC3st+vmY0zSaKU=;
        b=gzd14VaulZhy7qEOqmdq1zREhFbkmlCmVXrW4gvBTCfI2Fh3WRNXTFQ1L+TZ60jb2h
         TOOjOKmJXBPJ3Z9qn2eRi3fdC1VVbX3Qf5YbA1pNZsF8KRPxi2iPjhEcGOeZrgzgo1tT
         KDWR2dA8QnwrHBGT7UeeRh+FMjzznSFIxuAZXNqA3k5JJZAAjOhIqlPscY8Gwglf5Lpn
         rsbGmFKQD93DzEaGJEROW056e/qbdvCNLKp77FuybKJpWKIl1zTMSYPopyr0ZXkNDXuS
         3JQxsLcGY7vccS0MMYWtmllbSz0xXkpgZmJzHr5idSXlfYD33SRTf8+LZjPO868XBEVi
         mx8w==
X-Gm-Message-State: APjAAAV/q4zQ+bGu6YPhgTdqfpC8iRprixtzZvAog8vWwK9422+OtI+q
        SC+d+bqh8lw+gs6xeTvR9PWhUrVZcx8=
X-Google-Smtp-Source: APXvYqxE7yfdMoO9FIctWpHR4ZqYVY7B6Mhbg1sfDFjnLL/Pv8D8fkJv2J9+TQMp/vsfvav/UjJQTA==
X-Received: by 2002:a5d:464e:: with SMTP id j14mr13586625wrs.109.1552925718733;
        Mon, 18 Mar 2019 09:15:18 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z9sm3269728wmf.12.2019.03.18.09.15.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 18 Mar 2019 09:15:17 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/4] gc docs: include the "gc.*" section from "config" in "gc"
Date:   Mon, 18 Mar 2019 17:15:00 +0100
Message-Id: <20190318161502.7979-3-avarab@gmail.com>
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
 Documentation/config/gc.txt | 12 +++++++
 Documentation/git-gc.txt    | 65 +++----------------------------------
 2 files changed, 16 insertions(+), 61 deletions(-)

diff --git a/Documentation/config/gc.txt b/Documentation/config/gc.txt
index c6fbb8a96f9..a834a801cd6 100644
--- a/Documentation/config/gc.txt
+++ b/Documentation/config/gc.txt
@@ -2,11 +2,17 @@ gc.aggressiveDepth::
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
@@ -94,6 +100,12 @@ gc.<pattern>.reflogExpireUnreachable::
 	With "<pattern>" (e.g. "refs/stash")
 	in the middle, the setting applies only to the refs that
 	match the <pattern>.
++
+These types of entries are generally created as a result of using `git
+commit --amend` or `git rebase` and are the commits prior to the amend
+or rebase occurring. Since these changes are not part of the current
+project history most users will want to expire them sooner, which is
+why the default is more aggressive than `gc.reflogExpire`.
 
 gc.rerereResolved::
 	Records of conflicted merge you resolved earlier are
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index cc82971022e..9edf4e465b4 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -29,8 +29,7 @@ You should only need to run `git gc` manually when adding objects to a
 repository without regularly running such porcelain commands. Another
 use-case is wanting to do a one-off repository optimization.
 
-If you know what you're doing and all you want is to disable automatic
-runs, do:
+If you know what you're doing and want to disable automatic runs, do:
 
 ----------------------
 $ git config --global gc.auto 0
@@ -103,66 +102,10 @@ be performed as well.
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

