Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1BF01F597
	for <e@80x24.org>; Tue, 31 Jul 2018 13:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732282AbeGaOsI (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 10:48:08 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37492 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732258AbeGaOsI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 10:48:08 -0400
Received: by mail-wm0-f67.google.com with SMTP id n11-v6so3078869wmc.2
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 06:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k6tv+iun8O65bMkaa38mhrXurh2Z58bfsUnz2hBIyhk=;
        b=Y891fjob6mxCA1Okc0bWzL3v5GPoLSqGeXdrM/LwI2WaOEnNM/qZtvo1lZEW88fBJl
         7EVVCI2oIkZ2hM7DYNwylFzGWzeiiJ0iW+7jqEab5sr+LyYIGO9yTIjQUvFGnDrqAy+j
         LMwtAEf6x46w9Ts2snWCUWV2Cz/cLQmb5da+UWrYJaZ+cXkUYoVAJMWYVgY5xJFYZEm7
         /oQvSDuINym4Z2K1YkHoN5Vg1Urycsu3w4CqkcAbU8xrsSex2UGMJ1ISh/IPw2lP6hJf
         MwzVo0nfj4JmKrQMGKyGP5blGKfJVm+ZHXvMx8tzaBtKgBUka6gEsiZR/vHIJ9qW30LN
         wZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k6tv+iun8O65bMkaa38mhrXurh2Z58bfsUnz2hBIyhk=;
        b=o3T70q9yg29qRz4QmHrhWOoQCTTDfRSqVSH9NLlSoiVlQPtJl7Me46Ny0k0/RTkY11
         2+39NmspECzSX09TiTBcrNME7MweBPnMGlwxsPV1LGinvwm4dmZJ6uXWy4YFX1JrTNP5
         IhWr5zTRA9kqjCg63SrjFyg6IYGil4KSK8yPMJezSINvNnZscpJysA5PmlBAZXlMtjxm
         tqgPAJ37MWU1tmnJtCwLddoO3dDLY43ilhnbq2T+Rvy+14nMB/QlR9CTbUQYll/DzZSq
         KN8nnSXgcPOpPqhiVu9nC0MTSC597+yi+STkm4L9uvSko0NbS1K62fy3X3pVeoW4KZcT
         f3oQ==
X-Gm-Message-State: AOUpUlG8JOsViY2h26honAlCzAwx39+UMo/pU9TzGaJdGisPcW9HHND4
        RaB/ZAGzUk9k8/qEkp+PBy7cMHBsVlU=
X-Google-Smtp-Source: AAOMgpdnMSHGv9VPqQkKDNssLFCBClg3TT/GPHfNEjREzXBSx4dtQK6bSvpfOHia5lvtcPIVQcg7tg==
X-Received: by 2002:a1c:9e89:: with SMTP id h131-v6mr2169026wme.13.1533042470923;
        Tue, 31 Jul 2018 06:07:50 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id p25-v6sm894081wmc.29.2018.07.31.06.07.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 06:07:50 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 10/10] fetch: stop clobbering existing tags without --force
Date:   Tue, 31 Jul 2018 13:07:18 +0000
Message-Id: <20180731130718.25222-11-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3
In-Reply-To: <20180429202100.32353-1-avarab@gmail.com>
References: <20180429202100.32353-1-avarab@gmail.com>
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
change all tag fetches effectively had --force enabled. See the
git-fetch-script code in fast_forward_local() with the comment:

    > Tags need not be pointing at commits so there is no way to
    > guarantee "fast-forward" anyway.

That commit and the rest of the history of "fetch" shows that the
"+" (--force) part of refpecs was only conceived for branch updates,
while tags have accepted any changes from upstream unconditionally and
clobbered the local tag object. Changing this behavior has been
discussed as early as 2011[1].

The current behavior doesn't make sense to me, it easily results in
local tags accidentally being clobbered.  We could namespace our tags
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
 Documentation/pull-fetch-param.txt | 20 +++++++++++++++-----
 builtin/fetch.c                    | 20 +++++++++++++-------
 t/t5516-fetch-push.sh              |  5 +++--
 t/t5612-clone-refspec.sh           |  4 ++--
 5 files changed, 43 insertions(+), 21 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 97d3217df9..5b624caf58 100644
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
+	When 'git fetch' is used with `<src>:<dst>` refspec it may
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
index f1fb08dc68..acb8e1a4f0 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -33,11 +33,21 @@ name.
 it requests fetching everything up to the given tag.
 +
 The remote ref that matches <src>
-is fetched, and if <dst> is not an empty string, the local
-ref that matches it is fast-forwarded using <src>.
-If the optional plus `+` is used, the local ref
-is updated even if it does not result in a fast-forward
-update.
+is fetched, and if <dst> is not an empty string, an attempt
+is made to update the local ref that matches it.
++
+Whether that update is allowed without `--force` depends on the ref
+namespace it's being fetched to, and the type of object being
+fetched. If it's a commit under `refs/heads/*` only fast-forwards are
+allowed.
++
+By having the optional leading `+` to a refspec (or using `--force`
+command line option) you can tell Git to update the local ref even if
+it is not allowed by its respective namespace clobbering rules.
++
+Before Git version 2.19 tag objects under `refs/tags/*` would not be
+protected from updates, but since then the `+` (or `--force`) syntax
+is required to clobber them.
 +
 [NOTE]
 When the remote branch you want to fetch is known to
diff --git a/builtin/fetch.c b/builtin/fetch.c
index ac06f6a576..683f70d71e 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -113,7 +113,7 @@ static struct option builtin_fetch_options[] = {
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
index 8912312be7..8647f9cc9e 100755
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
2.18.0.345.g5c9ce644c3

