Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91C2320372
	for <e@80x24.org>; Thu,  5 Oct 2017 20:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751966AbdJEUAA (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 16:00:00 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34598 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbdJET76 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 15:59:58 -0400
Received: by mail-wr0-f193.google.com with SMTP id z1so10186625wre.1
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 12:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=0CrBSlCZeSqgv+r9AcFREfJ2HKGrjJUE7UiNF7yzdXI=;
        b=WslYHjwmoGbK5cCHbnvsFEu5ZZYfkLFyw1kwBlJBjF1PUyT+WLBx0aY+4hDewHKual
         HWFB7R6yMny5m3V/+GVzJN3Ium93HxRNqL0jqQVpkHjpY9tr00Xe9k7ixhGDzRy6jSpi
         xH4wQE/d7ZiTGze9++nbhExX8iHsZDP6KnfmWgHYo+PYwidipv6y8tQDuUsCTjcvFBDR
         Um/qp3iT7Rq/U6SBN5RFGZTAmNiU46GHIbW0SMehT7i9phGQBTXQSWr7vjWyHyuDCdcv
         AnJXYSUBXhZxEH8QN1O+y0ftO1mhrSrpmOFRM7UWy2gqS/tQ4SIcmMIhwYC9Xs+GlBYq
         I8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0CrBSlCZeSqgv+r9AcFREfJ2HKGrjJUE7UiNF7yzdXI=;
        b=EG+kt53S49OFOuz4tJB2Nl3RKbyMw4a9fXlT/0CWx6/76DAGuoLvtxhmuUdVfbAGW5
         +1Az9WZyn2E46XinCCh8VWHim99IhONpd35kIw/FknwIKUG6y8CeU1GEzRRixuSEjnv+
         nRIwxN543/uBR5ckXm0rgeJ6E9R7a5ttP+i83+wm5w7d0yhSdJwBYPzEP+qcGwT5Y0u0
         +3z2cIP9IoPTJESlNzJjxq7izIjh0el9YJSngSQIgX9JIXx5qLUYJslHbUJ5aGM/aPNW
         fma5K2gmDIgkj6UFbt4zYx+/8hEg54fp1+J1cd0Nhedk2MvAqyFXIHix9ag0Iwd5Yw6L
         UNmA==
X-Gm-Message-State: AMCzsaViGP5W10bS9eZHZKrLQ/wYxGl5mSB56n5A8I5eYLNnlh7dGJlZ
        renAuGa1YMCyYDBVgZK1Egs=
X-Google-Smtp-Source: AOwi7QBuShUzAS5w1g2B7Pm0nK3kCtIHAqTD8ehqfdaiZkTc4V+PH4huL4HlsQb130beaN8AK3i4ng==
X-Received: by 10.223.173.234 with SMTP id w97mr12378695wrc.26.1507233597366;
        Thu, 05 Oct 2017 12:59:57 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id c142sm95300wmh.39.2017.10.05.12.59.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Oct 2017 12:59:56 -0700 (PDT)
Date:   Thu, 5 Oct 2017 21:00:49 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        git@vger.kernel.org
Subject: [RFC] deprecate git stash save?  (was: Re: [PATCH 2/3] http-push:
 fix construction of hex value from path)
Message-ID: <20171005200049.GF30301@hank>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/04, Junio C Hamano wrote:
> I do not object with such a well designed deprecation plan for any
> other features, if there are other "favourite" ones people would
> want to deprecate and eventually remove, by the way.

Since you were asking :)  With the introduction of 'git stash push',
my hope was always that we could eventually get rid of 'git stash
save' and only keep one interface around.

As there still many references to it around on the internet, it
probably requires a bit of a longer deprecation plan.  What do you
think about the following:

- Change docs/man pages to use 'git stash push' everywhere instead of
  'git stash save'.
- Mention the deprecation in the release notes and in the man page.
- Print a warning when 'git stash save' is used.
- Eventually get rid of it (maybe something for 3.0?)

The steps above would all occur sequentially with a few releases
between each of them.

A patch for the first step below.  I think that even makes sense if we
don't want to follow through with the deprecation.

--- >8 ---
Subject: [PATCH] replace git stash save with git stash push in the documentation

git stash push is the newer interface for creating a stash.  While we
are still keeping git stash save around for the time being, it's better
to point new users of git stash to the more modern (and more feature
rich) interface, instead of teaching them the older version that we
might want to phase out in the future.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-stash.txt    | 12 ++++++------
 Documentation/gitworkflows.txt |  2 +-
 Documentation/user-manual.txt  |  2 +-
 git-stash.sh                   | 10 +++++-----
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 00f95fee1f..53b2e60aeb 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -33,7 +33,7 @@ and reverts the working directory to match the `HEAD` commit.
 The modifications stashed away by this command can be listed with
 `git stash list`, inspected with `git stash show`, and restored
 (potentially on top of a different commit) with `git stash apply`.
-Calling `git stash` without any arguments is equivalent to `git stash save`.
+Calling `git stash` without any arguments is equivalent to `git stash push`.
 A stash is by default listed as "WIP on 'branchname' ...", but
 you can give a more descriptive message on the command line when
 you create one.
@@ -118,7 +118,7 @@ pop [--index] [-q|--quiet] [<stash>]::
 
 	Remove a single stashed state from the stash list and apply it
 	on top of the current working tree state, i.e., do the inverse
-	operation of `git stash save`. The working directory must
+	operation of `git stash push`. The working directory must
 	match the index.
 +
 Applying the state can fail with conflicts; in this case, it is not
@@ -137,7 +137,7 @@ apply [--index] [-q|--quiet] [<stash>]::
 
 	Like `pop`, but do not remove the state from the stash list. Unlike `pop`,
 	`<stash>` may be any commit that looks like a commit created by
-	`stash save` or `stash create`.
+	`stash push` or `stash create`.
 
 branch <branchname> [<stash>]::
 
@@ -148,7 +148,7 @@ branch <branchname> [<stash>]::
 	`stash@{<revision>}`, it then drops the `<stash>`. When no `<stash>`
 	is given, applies the latest one.
 +
-This is useful if the branch on which you ran `git stash save` has
+This is useful if the branch on which you ran `git stash push` has
 changed enough that `git stash apply` fails due to conflicts. Since
 the stash entry is applied on top of the commit that was HEAD at the
 time `git stash` was run, it restores the originally stashed state
@@ -255,14 +255,14 @@ $ git stash pop
 
 Testing partial commits::
 
-You can use `git stash save --keep-index` when you want to make two or
+You can use `git stash push --keep-index` when you want to make two or
 more commits out of the changes in the work tree, and you want to test
 each change before committing:
 +
 ----------------------------------------------------------------
 # ... hack hack hack ...
 $ git add --patch foo            # add just first part to the index
-$ git stash save --keep-index    # save all other changes to the stash
+$ git stash push --keep-index    # save all other changes to the stash
 $ edit/build/test first part
 $ git commit -m 'First part'     # commit fully tested change
 $ git stash pop                  # prepare to work on all other changes
diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflows.txt
index 177610e44e..02569d0614 100644
--- a/Documentation/gitworkflows.txt
+++ b/Documentation/gitworkflows.txt
@@ -40,7 +40,7 @@ beginning. It is always easier to squash a few commits together than
 to split one big commit into several.  Don't be afraid of making too
 small or imperfect steps along the way. You can always go back later
 and edit the commits with `git rebase --interactive` before you
-publish them.  You can use `git stash save --keep-index` to run the
+publish them.  You can use `git stash push --keep-index` to run the
 test suite independent of other uncommitted changes; see the EXAMPLES
 section of linkgit:git-stash[1].
 
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index b4d88af133..1c4e44892d 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1556,7 +1556,7 @@ so on a different branch and then coming back), unstash the
 work-in-progress changes.
 
 ------------------------------------------------
-$ git stash save "work in progress for foo feature"
+$ git stash push "work in progress for foo feature"
 ------------------------------------------------
 
 This command will save your changes away to the `stash`, and
diff --git a/git-stash.sh b/git-stash.sh
index 8b2ce9afda..8ce6929d7f 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -267,11 +267,11 @@ push_stash () {
 			# translation of "error: " takes in your language. E.g. in
 			# English this is:
 			#
-			#    $ git stash save --blah-blah 2>&1 | head -n 2
-			#    error: unknown option for 'stash save': --blah-blah
-			#           To provide a message, use git stash save -- '--blah-blah'
-			eval_gettextln "error: unknown option for 'stash save': \$option
-       To provide a message, use git stash save -- '\$option'"
+			#    $ git stash push --blah-blah 2>&1 | head -n 2
+			#    error: unknown option for 'stash push': --blah-blah
+			#           To provide a message, use git stash push -- '--blah-blah'
+			eval_gettextln "error: unknown option for 'stash push': \$option
+       To provide a message, use git stash push -- '\$option'"
 			usage
 			;;
 		*)
-- 
2.14.1.480.gb18f417b89

