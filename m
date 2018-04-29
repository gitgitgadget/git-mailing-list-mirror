Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77DB61F428
	for <e@80x24.org>; Sun, 29 Apr 2018 20:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754156AbeD2UVm (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 16:21:42 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:33362 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754276AbeD2UVe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 16:21:34 -0400
Received: by mail-wm0-f46.google.com with SMTP id x12so9187307wmc.0
        for <git@vger.kernel.org>; Sun, 29 Apr 2018 13:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=QEtEVMKEznSOPdJ8titq7HsEEyknMpjbEyPl3m+qwfU=;
        b=uUyxFvDAs6InD3PxaHM0LcB55zJ+1ZK2mFaa09JxOp6Z2Rr/nRzCBpSgtyuBElOkMG
         2WlmEcOkvGsDAc6L4eN++PlRANmO1EiWAI/mD4QvrCqLRGRzCNoFCUe4RRUwiPefi0an
         C8evaLhamF8PJSIiPqjKlNS+687kQHwBZkMs5un54Y25cT+Ko7ekNH3u4SMxGnFd+5yX
         FXe8KmDEqLT1aCyexATxG4aF15WXm8n05WILtEpOzoo+CzFqBXg3jOFkC4AlcL8TYh6q
         193DtH5pkndo9/gMtBLlhjHRaqFAqNtA/WBrdADuzh2T+XOtVWhul/SQZWjXS9M61Zax
         n30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QEtEVMKEznSOPdJ8titq7HsEEyknMpjbEyPl3m+qwfU=;
        b=XgNNb0MnSs5TJ9+gByfS+Nx3Zfm4oNxKlQ1WBo36BjFntXeJ6vPHzPoBs1eBk0ZRFb
         59pN93uV0ZCAdtl/mTToXTVr64FTPjTT1IVTUrMNG0dBfszk9C76dqTez0z8nHPnSqKX
         pr/3oxXdGSXf8/mYMvEdFCC5kHjJTaX1zA8ZLDHS7bM55qJoK6r+fTvFaGvwSDrfo4T2
         SCetX7pngnURQZjq9v0CVTpfdRyrsbiHn7/HnwL+mEoEsvXcWIa2v9SZ24LyPeQP+Fxu
         rumOUwqaJOUgAeuDHuZ7oCZp+SF6uTMpJs5UY9fkZivrSe5cugn8eiTP5ZwFIb+nM7Gp
         0BtA==
X-Gm-Message-State: ALQs6tA27EyYq1ygtf4KEzTx6Ygre+TZEq6FHGWWAQf5el1v4lsgcUCv
        r2mKsHmejMK83aMQt7f0Ku471iYd
X-Google-Smtp-Source: AB8JxZrcuJNyWIRc/Yd8vEVUKRdbzlNmmXMDAI/geAJpXH6uANWUmyJ2VJQCwG0Y9RAQ/sDjcS/AJA==
X-Received: by 10.28.202.26 with SMTP id a26mr6299208wmg.126.1525033292525;
        Sun, 29 Apr 2018 13:21:32 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y42-v6sm8134917wry.21.2018.04.29.13.21.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Apr 2018 13:21:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 8/8] fetch: stop clobbering existing tags without --force
Date:   Sun, 29 Apr 2018 20:21:00 +0000
Message-Id: <20180429202100.32353-9-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180429202100.32353-1-avarab@gmail.com>
References: <20180429202100.32353-1-avarab@gmail.com>
In-Reply-To: <CACBZZX7HFnEMD8PKWj0c7VWqv=yeYCXYJjy-5YPZnF_pJAy0jw@mail.gmail.com>
References: <CACBZZX7HFnEMD8PKWj0c7VWqv=yeYCXYJjy-5YPZnF_pJAy0jw@mail.gmail.com>
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
853a3697dc ("[PATCH] Multi-head fetch.", 2005-08-20), before this
change all tag fetches effectively had --force enabled. The original
rationale in that change was:

    > Tags need not be pointing at commits so there is no way to
    > guarantee "fast-forward" anyway.

That comment and the rest of the history of "fetch" shows that the
"+" (--force) part of refpecs was only conceived for branch updates,
while tags have accepted any changes from upstream unconditionally and
clobbered the local tag object. Changing this behavior has been
discussed as early as 2011[1].

I the current behavior doesn't make sense, it easily results in local
tags accidentally being clobbered. Ideally we'd namespace our tags
per-remote, but as with my 97716d217c ("fetch: add a --prune-tags
option and fetch.pruneTags config", 2018-02-09) it's easier to work
around the current implementation than to fix the root cause, so this
implements suggestion #1 from [1], "fetch" now only clobbers the tag
if either "+" is provided as part of the refspec, or if "--force" is
provided on the command-line.

This also makes it nicely symmetrical with how "tag" itself
works. We'll now refuse to clobber any existing tags unless "--force"
is supplied, whether that clobbering would happen by clobbering a
local tag with "tag", or by fetching it from the remote with "fetch".

It's still not at all nicely symmetrical with how "git push" works, as
discussed in the updated pull-fetch-param.txt documentation, but this
change brings them more into line with one another. I don't think
there's any reason "fetch" couldn't fully converge with the behavior
used by "push", but that's a topic for another change.

One of the tests added in 31b808a032 ("clone --single: limit the fetch
refspec to fetched branch", 2012-09-20) is being changed to use
--force where a clone would clobber a tag. This changes nothing about
the existing behavior of the test.

1. https://public-inbox.org/git/20111123221658.GA22313@sigill.intra.peff.net/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/fetch-options.txt    | 15 ++++++++++-----
 Documentation/pull-fetch-param.txt | 22 ++++++++++++++++------
 builtin/fetch.c                    | 20 +++++++++++++-------
 t/t5516-fetch-push.sh              |  5 +++--
 t/t5612-clone-refspec.sh           |  4 ++--
 5 files changed, 44 insertions(+), 22 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 8631e365f4..5b4fc36866 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -49,11 +49,16 @@ endif::git-pull[]
 
 -f::
 --force::
-	When 'git fetch' is used with `<rbranch>:<lbranch>`
-	refspec, it refuses to update the local branch
-	`<lbranch>` unless the remote branch `<rbranch>` it
-	fetches is a descendant of `<lbranch>`.  This option
-	overrides that check.
+	When 'git fetch' is used with `<src>:<dst>` refspec it might
+	refuse to update the local branch as discussed
+ifdef::git-pull[]
+	in the `<refspec>` part of the linkgit:git-fetch[1]
+	documentation.
+endif::git-pull[]
+ifndef::git-pull[]
+	in the `<refspec>` part below.
+endif::git-pull[]
+	This option overrides that check.
 
 -k::
 --keep::
diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index c579793af5..672e8bc1c0 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -32,12 +32,22 @@ name.
 `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`;
 it requests fetching everything up to the given tag.
 +
-The remote ref that matches <src>
-is fetched, and if <dst> is not empty string, the local
-ref that matches it is fast-forwarded using <src>.
-If the optional plus `+` is used, the local ref
-is updated even if it does not result in a fast-forward
-update.
+The remote ref that matches <src> is fetched, and if <dst> is not
+empty string, an attempt is made to update the local ref that matches
+it.
++
+Whether that update is allowed is confusingly not the inverse of
+whether a server will accept a push as described in the `<refspec>...`
+section of linkgit:git-push[1]. If it's a commit under `refs/heads/*`
+only fast-forwards are allowed, but unlike what linkgit:git-push[1]
+will accept clobbering any ref pointing to blobs, trees etc. in any
+other namespace will be accepted, but commits in any ref
+namespace. Those apply the same fast-forward rule. An exception to
+this is that as of Git version 2.18 any object under `refs/tags/*` is
+protected from updates.
++
+If the optional plus `+` is used, the local ref is updated if the
+update would have otherwise been rejected.
 +
 [NOTE]
 When the remote branch you want to fetch is known to
diff --git a/builtin/fetch.c b/builtin/fetch.c
index dcdfc66f09..e3a44b582a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -126,7 +126,7 @@ static struct option builtin_fetch_options[] = {
 		 N_("append to .git/FETCH_HEAD instead of overwriting")),
 	OPT_STRING(0, "upload-pack", &upload_pack, N_("path"),
 		   N_("path to upload pack on remote end")),
-	OPT__FORCE(&force, N_("force overwrite of local branch"), 0),
+	OPT__FORCE(&force, N_("force overwrite of local reference"), 0),
 	OPT_BOOL('m', "multiple", &multiple,
 		 N_("fetch from multiple remotes")),
 	OPT_SET_INT('t', "tags", &tags,
@@ -664,12 +664,18 @@ static int update_local_ref(struct ref *ref,
 
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
 
 	current = lookup_commit_reference_gently(&ref->old_oid, 1);
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 9cf14c5cc1..327737ecaf 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1007,7 +1007,7 @@ test_force_fetch_tag () {
 	tag_type_description=$1
 	tag_args=$2
 
-	test_expect_success "fetch will clobber an existing $tag_type_description" "
+	test_expect_success "fetch will not clobber an existing $tag_type_description without --force" "
 		mk_test testrepo heads/master &&
 		mk_child testrepo child1 &&
 		mk_child testrepo child2 &&
@@ -1019,7 +1019,8 @@ test_force_fetch_tag () {
 			git add file1 &&
 			git commit -m 'file1' &&
 			git tag $tag_args Tag &&
-			git -C ../child1 fetch origin tag Tag
+			test_must_fail git -C ../child1 fetch origin tag Tag &&
+			git -C ../child1 fetch origin '+refs/tags/*:refs/tags/*'
 		)
 	"
 }
diff --git a/t/t5612-clone-refspec.sh b/t/t5612-clone-refspec.sh
index fac5a73851..6ea8f50dae 100755
--- a/t/t5612-clone-refspec.sh
+++ b/t/t5612-clone-refspec.sh
@@ -104,7 +104,7 @@ test_expect_success 'clone with --no-tags' '
 test_expect_success '--single-branch while HEAD pointing at master' '
 	(
 		cd dir_master &&
-		git fetch &&
+		git fetch --force &&
 		git for-each-ref refs/remotes/origin |
 		sed -e "/HEAD$/d" \
 		    -e "s|/remotes/origin/|/heads/|" >../actual
@@ -115,7 +115,7 @@ test_expect_success '--single-branch while HEAD pointing at master' '
 	test_cmp expect actual &&
 	(
 		cd dir_master &&
-		git fetch --tags &&
+		git fetch --tags --force &&
 		git for-each-ref refs/tags >../actual
 	) &&
 	git for-each-ref refs/tags >expect &&
-- 
2.17.0.290.gded63e768a

