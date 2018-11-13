Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73F451F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 19:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730729AbeKNFwo (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 00:52:44 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38187 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbeKNFwo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 00:52:44 -0500
Received: by mail-wm1-f66.google.com with SMTP id f2-v6so12575561wme.3
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 11:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H/iYvIxl3Gd53RnWyN7Xfm/xbBRzcmmCQkBn3d6b7l4=;
        b=QPWNAQwH3LJa6vd525xOU7SOi/ZzcIT6Utl9Cy2C1MNEn/bn+8i8rjxqgXVKiqI+Mf
         SSnEpwIA1rfmGalBDUijgl7Nwb3hLrjGYvChukzT+KlhqQY+bTpWUPzV9pyu1R3OoRp/
         /0bJ9cLFnO+0vxnD2hwvCpUO+XHzMj/dqONMyZykdcHb6loVZKAEj4ivB8D0IhTNU2+n
         RzfdHgRU2uusBeMrq4zH22v1wzp7DEoOMX5nSI69n4xgG7hj/u/prRFS1BR+EIhP7hwR
         9/0E8decAj5z1Quq715jTnISsFyjPxD1JZwvgsObL9N6VIfzZ9hrfr1wimtMD0QC1ny9
         1NFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H/iYvIxl3Gd53RnWyN7Xfm/xbBRzcmmCQkBn3d6b7l4=;
        b=iexS0eHZuBLUQZPjN+Hw3rZIKNe5a7RNKTWRQlbK4y/yValDftFgKgGHPQVvY/4O7d
         I/gW7MJEOvJ9EionmXaUrqv1VZjieZhxiXZ+XW8QLs2olGy/vMdvoZf2h97rdZ7BPWjQ
         tliI++Fk1mGPJA+fyreOY03GfSPKvPRTifZUCl8YCCUQFmxTSSv/1oLS+WJx73h7kesu
         cbEzGvJTNJ+tskdDhscouornU0a74DXJLy5eFxK56Cep/jbK3tpcJWX0VbF0jLNpnJMB
         0tcHE6D97OHwth/RjKwfTK8JOBkun12uDpoE1/qGaD6O+y1O4a/cahnNuhsVwyV6ZkkS
         SFZw==
X-Gm-Message-State: AGRZ1gJ4SA4xUJ6gn2EzdnjTuF5l7PhLDc6e/jDKuMvUMeAp1t/B3LCJ
        4mupDbRKI01NUIK3y8/7i2dwn2vwgXs=
X-Google-Smtp-Source: AJdET5fR/kjC1Nu1B9rrH9mW2A7WUoOel8HqZN0bATyCPaTzT+M3dqvIrEsOJWeed2CmWO5S5Eob5g==
X-Received: by 2002:a1c:f30b:: with SMTP id q11-v6mr4327046wmq.45.1542138782964;
        Tue, 13 Nov 2018 11:53:02 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y7-v6sm13828560wmy.27.2018.11.13.11.53.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 11:53:02 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 5/7] push: add an advice on unqualified <dst> push
Date:   Tue, 13 Nov 2018 19:52:43 +0000
Message-Id: <20181113195245.14296-6-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.1182.g4ecb1133ce
In-Reply-To: <20181026230741.23321-1-avarab@gmail.com>
References: <20181026230741.23321-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an advice to the recently improved error message added in
f8aae12034 ("push: allow unqualified dest refspecs to DWIM",
2008-04-23).

Now with advice.pushUnqualifiedRefName=true (on by default) we show a
hint about how to proceed:

    $ ./git-push avar v2.19.0^{commit}:newbranch -n
    error: The destination you provided is not a full refname (i.e.,
    starting with "refs/"). We tried to guess what you meant by:

    - Looking for a ref that matches 'newbranch' on the remote side.
    - Checking if the <src> being pushed ('v2.19.0^{commit}')
      is a ref in "refs/{heads,tags}/". If so we add a corresponding
      refs/{heads,tags}/ prefix on the remote side.

    Neither worked, so we gave up. You must fully qualify the ref.
    hint: The <src> part of the refspec is a commit object.
    hint: Did you mean to create a new branch by pushing to
    hint: 'v2.19.0^{commit}:refs/heads/newbranch'?
    error: failed to push some refs to 'git@github.com:avar/git.git'

When trying to push a tag, tree or a blob we suggest that perhaps the
user meant to push them to refs/tags/ instead.

The if/else duplication for all of OBJ_{COMMIT,TAG,TREE,BLOB} is
unfortunate, but is required to correctly mark the messages for
translation. See the discussion in
<87r2gxebsi.fsf@evledraar.gmail.com> about that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/advice.txt |  7 +++++++
 advice.c                        |  2 ++
 advice.h                        |  1 +
 remote.c                        | 37 +++++++++++++++++++++++++++++++++
 t/t5505-remote.sh               | 28 +++++++++++++++++++++++++
 5 files changed, 75 insertions(+)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index 57fcd4c862..88620429ea 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -30,6 +30,13 @@ advice.*::
 		tries to overwrite a remote ref that points at an
 		object that is not a commit-ish, or make the remote
 		ref point at an object that is not a commit-ish.
+	pushUnqualifiedRefname::
+		Shown when linkgit:git-push[1] gives up trying to
+		guess based on the source and destination refs what
+		remote ref namespace the source belongs in, but where
+		we can still suggest that the user push to either
+		refs/heads/* or refs/tags/* based on the type of the
+		source object.
 	statusHints::
 		Show directions on how to proceed from the current
 		state in the output of linkgit:git-status[1], in
diff --git a/advice.c b/advice.c
index 5f35656409..567209aa79 100644
--- a/advice.c
+++ b/advice.c
@@ -9,6 +9,7 @@ int advice_push_non_ff_matching = 1;
 int advice_push_already_exists = 1;
 int advice_push_fetch_first = 1;
 int advice_push_needs_force = 1;
+int advice_push_unqualified_ref_name = 1;
 int advice_status_hints = 1;
 int advice_status_u_option = 1;
 int advice_commit_before_merge = 1;
@@ -63,6 +64,7 @@ static struct {
 	{ "pushAlreadyExists", &advice_push_already_exists },
 	{ "pushFetchFirst", &advice_push_fetch_first },
 	{ "pushNeedsForce", &advice_push_needs_force },
+	{ "pushUnqualifiedRefName", &advice_push_unqualified_ref_name },
 	{ "statusHints", &advice_status_hints },
 	{ "statusUoption", &advice_status_u_option },
 	{ "commitBeforeMerge", &advice_commit_before_merge },
diff --git a/advice.h b/advice.h
index 696bf0e7d2..f875f8cd8d 100644
--- a/advice.h
+++ b/advice.h
@@ -9,6 +9,7 @@ extern int advice_push_non_ff_matching;
 extern int advice_push_already_exists;
 extern int advice_push_fetch_first;
 extern int advice_push_needs_force;
+extern int advice_push_unqualified_ref_name;
 extern int advice_status_hints;
 extern int advice_status_u_option;
 extern int advice_commit_before_merge;
diff --git a/remote.c b/remote.c
index ba8abf4d32..f7477b8eb6 100644
--- a/remote.c
+++ b/remote.c
@@ -13,6 +13,7 @@
 #include "mergesort.h"
 #include "argv-array.h"
 #include "commit-reach.h"
+#include "advice.h"
 
 enum map_direction { FROM_SRC, FROM_DST };
 
@@ -1008,6 +1009,9 @@ static int match_explicit_lhs(struct ref *src,
 static void show_push_unqualified_ref_name_error(const char *dst_value,
 						 const char *matched_src_name)
 {
+	struct object_id oid;
+	enum object_type type;
+
 	/*
 	 * TRANSLATORS: "matches '%s'%" is the <dst> part of "git push
 	 * <remote> <src>:<dst>" push, and "being pushed ('%s')" is
@@ -1023,6 +1027,39 @@ static void show_push_unqualified_ref_name_error(const char *dst_value,
 		"\n"
 		"Neither worked, so we gave up. You must fully qualify the ref."),
 	      dst_value, matched_src_name);
+
+	if (!advice_push_unqualified_ref_name)
+		return;
+
+	if (get_oid(matched_src_name, &oid))
+		BUG("'%s' is not a valid object, "
+		    "match_explicit_lhs() should catch this!",
+		    matched_src_name);
+	type = oid_object_info(the_repository, &oid, NULL);
+	if (type == OBJ_COMMIT) {
+		advise(_("The <src> part of the refspec is a commit object.\n"
+			 "Did you mean to create a new branch by pushing to\n"
+			 "'%s:refs/heads/%s'?"),
+		       matched_src_name, dst_value);
+	} else if (type == OBJ_TAG) {
+		advise(_("The <src> part of the refspec is a tag object.\n"
+			 "Did you mean to create a new tag by pushing to\n"
+			 "'%s:refs/tags/%s'?"),
+		       matched_src_name, dst_value);
+	} else if (type == OBJ_TREE) {
+		advise(_("The <src> part of the refspec is a tree object.\n"
+			 "Did you mean to tag a new tree by pushing to\n"
+			 "'%s:refs/tags/%s'?"),
+		       matched_src_name, dst_value);
+	} else if (type == OBJ_BLOB) {
+		advise(_("The <src> part of the refspec is a blob object.\n"
+			 "Did you mean to tag a new blob by pushing to\n"
+			 "'%s:refs/tags/%s'?"),
+		       matched_src_name, dst_value);
+	} else {
+		BUG("'%s' should be commit/tag/tree/blob, is '%d'",
+		    matched_src_name, type);
+	}
 }
 
 static int match_explicit(struct ref *src, struct ref *dst,
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index d2a2cdd453..f069cbcc24 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -1222,4 +1222,32 @@ test_expect_success 'add remote matching the "insteadOf" URL' '
 	git remote add backup xyz@example.com
 '
 
+test_expect_success 'unqualified <dst> refspec DWIM and advice' '
+	test_when_finished "(cd test && git tag -d some-tag)" &&
+	(
+		cd test &&
+		git tag -a -m "Some tag" some-tag master &&
+		exit_with=true &&
+		for type in commit tag tree blob
+		do
+			if test "$type" = "blob"
+			then
+				oid=$(git rev-parse some-tag:file)
+			else
+				oid=$(git rev-parse some-tag^{$type})
+			fi &&
+			test_must_fail git push origin $oid:dst 2>err &&
+			test_i18ngrep "error: The destination you" err &&
+			test_i18ngrep "hint: Did you mean" err &&
+			test_must_fail git -c advice.pushUnqualifiedRefName=false \
+				push origin $oid:dst 2>err &&
+			test_i18ngrep "error: The destination you" err &&
+			test_i18ngrep ! "hint: Did you mean" err ||
+			exit_with=false
+		done &&
+		$exit_with
+	)
+'
+
+
 test_done
-- 
2.19.1.1182.g4ecb1133ce

