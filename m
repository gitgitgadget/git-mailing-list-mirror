Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9551202A2
	for <e@80x24.org>; Thu, 19 Oct 2017 18:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754303AbdJSScH (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 14:32:07 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:52928 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754298AbdJSScG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 14:32:06 -0400
Received: by mail-wr0-f195.google.com with SMTP id k62so9254199wrc.9
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 11:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MrF6tnMjLEyQJbwXRSdLt+/CX0+3oWeU+aSu1bLBc/0=;
        b=uSGt45RQ4BzUc6m/I0Zp4WLUwvhKfj1HEGxEsgvc+Xr2vu2S15fqut2e9RzlxkQh+3
         W5pjGMsZh6C3AyfKoAaNAhTgAEiBFEctdEOM09H0D1f0w2Z+sxjnm3S8gAchRyIenIKD
         P4ZriESGhsQTEkZO8j/+9WhNlbo1GNVWolrGDa8fxs0l9J8aKjE5dhiy2K8aX66sNlNf
         rr+lEOD/IgkgIBH2X91kGOkMpPxjMKKIk36bjqAUsmh6ctbUxHnaA5G3HyL6KBdpXce5
         buymwot5N8pwsXPp7JeUwr81mMmjX8h5FXoAnqsZHFL+x8agVA4pwgHE+0UUqWXFBf59
         WGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MrF6tnMjLEyQJbwXRSdLt+/CX0+3oWeU+aSu1bLBc/0=;
        b=mpGqNYTAMahgENQiLozF3lGjONuH2hF7W+syDS68hmShVWF+6DWJVB7wUGBK8YM5J9
         biT3MKd1Qcapnc0gpisg6zME8KESglwOr5uT0QD9n2EHcaFjrVH+KMVrLZ3zaW4KOrmM
         oexQv5v2Yfl946WNDXs/rzv/Uz3eXjpjGUw4d8x9E7WV+sasC6iyrK1Z18BY8ljzdMWo
         zaxiadqv2pBLLDKaaFsSUlwG/KQPm0NZPKK038KBYSC+5LPjsqO3jTZysEevIj29Yfxj
         f+JuijmD2cOee+iIwZeKVdon3N2Ht3rw/AptVYfg0O5VR1afWdn/nwBWgAhLzYtoBn72
         h11w==
X-Gm-Message-State: AMCzsaWEGaR+KtOtvB4YSkYjZnHjOGVc+emox9wzkB0Ek3vzurt1w5RM
        ti/45QvKqZLCk8YPGx+farM=
X-Google-Smtp-Source: ABhQp+Tt6yO0HPXGtdjpv/MWI9qmqZKbSBWBh6BTbSu1H2NB6yuBhtBRFhT4RVeGHneyy0bABfcskQ==
X-Received: by 10.223.184.36 with SMTP id h33mr2530117wrf.38.1508437924604;
        Thu, 19 Oct 2017 11:32:04 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id f27sm28983499wrf.63.2017.10.19.11.32.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Oct 2017 11:32:03 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        git@vger.kernel.org, "Robert P . J . Day" <rpjday@crashcourse.ca>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 1/2] replace git stash save with git stash push in the documentation
Date:   Thu, 19 Oct 2017 19:33:03 +0100
Message-Id: <20171019183304.26748-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.0.rc1.65.g660fb3dfa8
In-Reply-To: <20171005200049.GF30301@hank>
References: <20171005200049.GF30301@hank>
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
index 8b2ce9afda..16919277ba 100755
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
+       To provide a message, use git stash push -m '\$option'"
 			usage
 			;;
 		*)
-- 
2.15.0.rc1.65.g660fb3dfa8

