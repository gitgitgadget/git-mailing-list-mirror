Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DABA1F404
	for <e@80x24.org>; Fri, 31 Aug 2018 20:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbeIAATh (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 20:19:37 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53713 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbeIAATg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 20:19:36 -0400
Received: by mail-wm0-f66.google.com with SMTP id b19-v6so6270323wme.3
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 13:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yhBMtldLgUp2p5P9EF+xSDg4G2ZUCAtgz5DUazrrPko=;
        b=USfhsk+to6dxScSsj8X8aMIzZonataKE8dA9VLEL9QjRLMh2d8Qr4w8mcJ5tC9lXvu
         HtVIWuFxDw5yX5c9+T1JXnS/h/6tU29VVfaIzfvcdpqclivWvLlRWLJwANt1T/VKNny4
         4JKkcBCZiSYxEImOpw752fxnUT9RK1JZjxH5wA+/qinltR/06BUKpylzhlxhoQ6w9PeS
         IDle2YMKCKyTkgQqIXxr75wXYJe00U9rDscZbs6uV42337wyTkPzFFwDEMqdGqCckLek
         CvY/wuV7lUSYxlkGs2RM7/Q/O50606o4zPlWLoM/gsQXdEjnXgKcFRV6nPOPuYFDMklx
         V5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yhBMtldLgUp2p5P9EF+xSDg4G2ZUCAtgz5DUazrrPko=;
        b=Dj7pCddWclk1E0YgDeeMP2uX03cvfsxxolpXrP2r95V0iygH6TS4veQHPTvtMzuolt
         f1Nl+epj04zvUjnHtNKuVYNXTuTBUDi8PLlhWPA2NEE4jNuDa2ZRpgl5aP3s0ATJKaLs
         4Ii52UPbgV2kOy2/2KMGDjyLCdOp3KBQV7DxBvaf4BYmZz3MTzt69r+JD9qZVIb4PldC
         nMOPyGZ2z5uCv3WtN364fsINd6jSXruST2m0gz9y+CQrXLXSB8uQmjFAUsXZdxo2LZUU
         1FTFA1u4duMIoYP+IgB2i6SryzoL8pieC6z4X5cojoRiFVyqj/KOX/H9GtCppFbUWs7i
         4PVQ==
X-Gm-Message-State: APzg51C8eyMVauevyn8vKX2EPbaJjzdBlX7DmjWfkmjssC5MwilA7BGN
        FguA7ONq3Lz840LBmbIWfHlpqtcn97Q=
X-Google-Smtp-Source: ANB0VdaoLa51q4KbX7eU5J6OzZGXu7HzRfuPxV8+p3VdIQEzXT72nCblaQpIpQorTWr6fPMa6ofI0g==
X-Received: by 2002:a1c:2905:: with SMTP id p5-v6mr5435282wmp.1.1535746230649;
        Fri, 31 Aug 2018 13:10:30 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l16-v6sm4486753wmc.38.2018.08.31.13.10.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 13:10:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Marc Branchaud <marcnarc@xiplink.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 9/9] fetch: stop clobbering existing tags without --force
Date:   Fri, 31 Aug 2018 20:10:04 +0000
Message-Id: <20180831201004.12087-10-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1
In-Reply-To: <20180830201244.25759-1-avarab@gmail.com>
References: <20180830201244.25759-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change "fetch" to treat "+" in refspecs (aka --force) to mean we
should clobber a local tag of the same name.

This changes the long-standing behavior of "fetch" added in
853a3697dc ("[PATCH] Multi-head fetch.", 2005-08-20). Before this
change, all tag fetches effectively had --force enabled. See the
git-fetch-script code in fast_forward_local() with the comment:

    > Tags need not be pointing at commits so there is no way to
    > guarantee "fast-forward" anyway.

That commit and the rest of the history of "fetch" shows that the
"+" (--force) part of refpecs was only conceived for branch updates,
while tags have accepted any changes from upstream unconditionally and
clobbered the local tag object. Changing this behavior has been
discussed as early as 2011[1].

The current behavior doesn't make sense to me, it easily results in
local tags accidentally being clobbered. We could namespace our tags
per-remote and not locally populate refs/tags/*, but as with my
97716d217c ("fetch: add a --prune-tags option and fetch.pruneTags
config", 2018-02-09) it's easier to work around the current
implementation than to fix the root cause.

So this change implements suggestion #1 from Jeff's 2011 E-Mail[1],
"fetch" now only clobbers the tag if either "+" is provided as part of
the refspec, or if "--force" is provided on the command-line.

This also makes it nicely symmetrical with how "tag" itself works when
creating tags. I.e. we refuse to clobber any existing tags unless
"--force" is supplied. Now we can refuse all such clobbering, whether
it would happen by clobbering a local tag with "tag", or by fetching
it from the remote with "fetch".

Ref updates outside refs/{tags,heads/* are still still not symmetrical
with how "git push" works, as discussed in the recently changed
pull-fetch-param.txt documentation. This change brings the two
divergent behaviors more into line with one another. I don't think
there's any reason "fetch" couldn't fully converge with the behavior
used by "push", but that's a topic for another change.

One of the tests added in 31b808a032 ("clone --single: limit the fetch
refspec to fetched branch", 2012-09-20) is being changed to use
--force where a clone would clobber a tag. This changes nothing about
the existing behavior of the test.

1. https://public-inbox.org/git/20111123221658.GA22313@sigill.intra.peff.net/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/pull-fetch-param.txt | 15 +++++++++++----
 builtin/fetch.c                    | 18 ++++++++++++------
 t/t5516-fetch-push.sh              |  5 +++--
 t/t5612-clone-refspec.sh           |  4 ++--
 4 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index ab9617ad01..293c6b967d 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -43,10 +43,13 @@ same rules apply for fetching as when pushing, see the `<refspec>...`
 section of linkgit:git-push[1] for what those are. Exceptions to those
 rules particular to 'git fetch' are noted below.
 +
-Unlike when pushing with linkgit:git-push[1], any updates to
-`refs/tags/*` will be accepted without `+` in the refspec (or
-`--force`). The receiving promiscuously considers all tag updates from
-a remote to be forced fetches.
+Until Git version 2.20, and unlike when pushing with
+linkgit:git-push[1], any updates to `refs/tags/*` would be accepted
+without `+` in the refspec (or `--force`). The receiving promiscuously
+considered all tag updates from a remote to be forced fetches.  Since
+Git version 2.20, fetching to update `refs/tags/*` work the same way
+as when pushing. I.e. any updates will be rejected without `+` in the
+refspec (or `--force`).
 +
 Unlike when pushing with linkgit:git-push[1], any updates outside of
 `refs/{tags,heads}/*` will be accepted without `+` in the refspec (or
@@ -54,6 +57,10 @@ Unlike when pushing with linkgit:git-push[1], any updates outside of
 a commit for another commit that's doesn't have the previous commit as
 an ancestor etc.
 +
+Unlike when pushing with linkgit:git-push[1], there is no
+configuration which'll amend these rules, and nothing like a
+`pre-fetch` hook analogous to the `pre-receive` hook.
++
 As with pushing with linkgit:git-push[1], all of the rules described
 above about what's not allowed as an update can be overridden by
 adding an the optional leading `+` to a refspec (or using `--force`
diff --git a/builtin/fetch.c b/builtin/fetch.c
index b0706b3803..ed4ed9d8c4 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -667,12 +667,18 @@ static int update_local_ref(struct ref *ref,
 
 	if (!is_null_oid(&ref->old_oid) &&
 	    starts_with(ref->name, "refs/tags/")) {
-		int r;
-		r = s_update_ref("updating tag", ref, 0);
-		format_display(display, r ? '!' : 't', _("[tag update]"),
-			       r ? _("unable to update local ref") : NULL,
-			       remote, pretty_ref, summary_width);
-		return r;
+		if (force || ref->force) {
+			int r;
+			r = s_update_ref("updating tag", ref, 0);
+			format_display(display, r ? '!' : 't', _("[tag update]"),
+				       r ? _("unable to update local ref") : NULL,
+				       remote, pretty_ref, summary_width);
+			return r;
+		} else {
+			format_display(display, '!', _("[rejected]"), _("would clobber existing tag"),
+				       remote, pretty_ref, summary_width);
+			return 1;
+		}
 	}
 
 	current = lookup_commit_reference_gently(the_repository,
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 7f3d4c4965..0e758e2a43 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1015,7 +1015,7 @@ test_force_fetch_tag () {
 	tag_type_description=$1
 	tag_args=$2
 
-	test_expect_success "fetch will clobber an existing $tag_type_description" "
+	test_expect_success "fetch will not clobber an existing $tag_type_description without --force" "
 		mk_test testrepo heads/master &&
 		mk_child testrepo child1 &&
 		mk_child testrepo child2 &&
@@ -1027,7 +1027,8 @@ test_force_fetch_tag () {
 			git add file1 &&
 			git commit -m 'file1' &&
 			git tag $tag_args testTag &&
-			git -C ../child1 fetch origin tag testTag
+			test_must_fail git -C ../child1 fetch origin tag testTag &&
+			git -C ../child1 fetch origin '+refs/tags/*:refs/tags/*'
 		)
 	"
 }
diff --git a/t/t5612-clone-refspec.sh b/t/t5612-clone-refspec.sh
index 5582b3d5fd..e36ac01661 100755
--- a/t/t5612-clone-refspec.sh
+++ b/t/t5612-clone-refspec.sh
@@ -103,7 +103,7 @@ test_expect_success 'clone with --no-tags' '
 test_expect_success '--single-branch while HEAD pointing at master' '
 	(
 		cd dir_master &&
-		git fetch &&
+		git fetch --force &&
 		git for-each-ref refs/remotes/origin |
 		sed -e "/HEAD$/d" \
 		    -e "s|/remotes/origin/|/heads/|" >../actual
@@ -114,7 +114,7 @@ test_expect_success '--single-branch while HEAD pointing at master' '
 	test_cmp expect actual &&
 	(
 		cd dir_master &&
-		git fetch --tags &&
+		git fetch --tags --force &&
 		git for-each-ref refs/tags >../actual
 	) &&
 	git for-each-ref refs/tags >expect &&
-- 
2.19.0.rc1.350.ge57e33dbd1

