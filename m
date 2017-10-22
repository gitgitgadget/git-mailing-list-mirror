Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28F2E202DD
	for <e@80x24.org>; Sun, 22 Oct 2017 17:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751528AbdJVRDL (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Oct 2017 13:03:11 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:54799 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751406AbdJVRDK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Oct 2017 13:03:10 -0400
Received: by mail-wr0-f194.google.com with SMTP id o44so15149399wrf.11
        for <git@vger.kernel.org>; Sun, 22 Oct 2017 10:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=imVkOLj87Losno0jjrntWaaVLx/PGFlOqvvzNjarph4=;
        b=jXnq+B+i1AjI6pVVWIwuCc8aKk8EJ2XniIBy/YAKa4GQk4d8wZoCK3uApWO6iv7QPD
         tMue9RDNKsEd7uTrIfqTcd4CFCl/Wu8Gb1tlWD9KItA1p+pvyRW8feSksDvokQwIf5h+
         gijrnCAZRs1uoCWaY/eVlD3zRCuxORCaYE7EosrA5H7pOEDyHfXRpok+02vcP3KpPJaC
         QOi7b5HEhywpIByrOV9kpmkVw3Nafuq7uqawxb71mSLsdx3ijM4mEGjiJKCaPXb3n9FK
         Zq+JFUzxvN+MxI+mTlEBPsO92ThD2N3KFqSyGMwxhA0D7bKi15R0TFdMLCZN4xcsrye5
         esFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=imVkOLj87Losno0jjrntWaaVLx/PGFlOqvvzNjarph4=;
        b=Wleth3YC5Gs5Hjs+xeqCzpAWZD1/NKdgBo725hSf4b7iw8XwkRZ2POT8wScP7L6nAf
         4ubY8RSFagdkQGLygOjbk7tw01u2pLbl/N7AfjRyAGdH5phXaq0ZdUtD+Z9kNZ6KN3cY
         cSEsX22OEx6ClNMIFEOSojn6o5F3qqEqJP46adUVkr8QF7cjOcWI8fQu6SnbJUd/6/Rj
         wFSkSvj60NP9CLw7ZX2I2m6SZ0JMkYID2IeyLsW+dBkbL49Whxd8qRnATMzlS8CyfmAm
         SRUDuLox70dwU7rVaX8E8G8j/P7S6iW6V5wQFOisLSA5FnWMtOxAFb0F8oH58PY+cNjz
         UfUA==
X-Gm-Message-State: AMCzsaV9vw1E4+OBm8Kpa9sC2l5UaDTu3hdsy2gBw9KNNaGTX+6fqWQK
        FR2lVSinqrVQzlOpal9qjSFasV3E
X-Google-Smtp-Source: ABhQp+S1Nt6XK97iw3wLAnNyfaXfywGFoZDxknkSBVNP5E20N8dS2d+/Gbn0jdIvlbTR4K+jXUIQOg==
X-Received: by 10.223.147.135 with SMTP id 7mr9669402wrp.237.1508691788865;
        Sun, 22 Oct 2017 10:03:08 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id o14sm3417270wra.54.2017.10.22.10.03.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Oct 2017 10:03:07 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "Robert P . J . Day" <rpjday@crashcourse.ca>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 1/3] replace git stash save with git stash push in the documentation
Date:   Sun, 22 Oct 2017 18:04:07 +0100
Message-Id: <20171022170409.8565-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.0.rc0.2.g8fac3e73c8.dirty
In-Reply-To: <20171022170409.8565-1-t.gummerer@gmail.com>
References: <20171019183304.26748-2-t.gummerer@gmail.com>
 <20171022170409.8565-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
index b4d88af133..3a03e63eb0 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1556,7 +1556,7 @@ so on a different branch and then coming back), unstash the
 work-in-progress changes.
 
 ------------------------------------------------
-$ git stash save "work in progress for foo feature"
+$ git stash push -m "work in progress for foo feature"
 ------------------------------------------------
 
 This command will save your changes away to the `stash`, and
diff --git a/git-stash.sh b/git-stash.sh
index 8b2ce9afda..3a4e5d157c 100755
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
+			#           To provide a message, use git stash push -m '--blah-blah'
+			eval_gettextln "error: unknown option for 'stash push': \$option
+       To provide a message, use git stash push -m '\$option'"
 			usage
 			;;
 		*)
-- 
2.15.0.rc0.2.g8fac3e73c8.dirty

