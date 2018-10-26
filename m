Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19DC71F453
	for <e@80x24.org>; Fri, 26 Oct 2018 23:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbeJ0Hq4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 03:46:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40675 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbeJ0Hq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 03:46:56 -0400
Received: by mail-wm1-f68.google.com with SMTP id b203-v6so2805531wme.5
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 16:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0lUuqdHQKvCR0ZzZ3Hl+vymd3mDJFPQzBu2SA0IgrBc=;
        b=XliB8vHMKt/ZFOPoNgXihb6c/eFRFEmbHkzqpgLouO5Ao0YDCB8GKE92l6TS0TYH+v
         A2Yfmcvqn7IKV1mpxrWaZHFo2mjMMr3WJ+ImHeo16NV9ScswTNqh7Nnmv/K8rXzQW+4J
         wPyo12aM0JF8h4T84QkmTu1J7zGcHDYX5Wtp2bjWBJDP7gH8W5UA2+hRw6JKds4wfUlk
         IpfmARAIgzkkDnhwnL1HWsKhpMJXYWFdNQKBVLDUybENLPc6jXuY5xfOm7ftw8AnnO04
         dEg9T1W/eEKgCntfSWntCaxpFU+DFg1/cjlZggKAVKnXF1Wb7Fr6cuRqkB1qCq9vuVG+
         b7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0lUuqdHQKvCR0ZzZ3Hl+vymd3mDJFPQzBu2SA0IgrBc=;
        b=eMxKd7zAqj/29wVexxJGdcFIJx7pTmE416IGuV+4pGzHeVQeMwC+9LDevadBUdQvE4
         61WHil2VOSUAO4jWlxrXrs8JbRQTrhhiNh7X8R9kWTcAEr39cD1Hdwlpusb5akSzlAmn
         xJDVCfzjxWYA+awy6UYUaQF5bw9K1hw7wEjnJL4Vy93XA2mJIr1AJVsRsw0stBPhzVGH
         xxJis1tF7tqLKXdBozMqS2S0d8cpW9eYn/Hzm1xvPVryi0t1csg7bG//jABslmSO48Tm
         p99JfB8fDdnxMP4daTfqtPJkE0a66HKt2fl3/s5FmXwF2M1IecDP0zQbd1ePa57IVROL
         9IPw==
X-Gm-Message-State: AGRZ1gKGERCEu8fQhY/IxyaQawwWM6hCqVFTTwG7QVOfAQ4B2BJZTqYb
        xOeO0ieriN1Val9TPpcgMJVgk/0PgbU=
X-Google-Smtp-Source: AJdET5d0mUHIboStGNm6k/ZGY4Dq4ZMJMpkPO806PYYcAXbiHNIPoh0XhbiTdJTJfeOY0qh8f0DG7Q==
X-Received: by 2002:a1c:e203:: with SMTP id z3-v6mr4680871wmg.42.1540595277310;
        Fri, 26 Oct 2018 16:07:57 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 4-v6sm5632830wmt.16.2018.10.26.16.07.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 16:07:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 5/8] push: add an advice on unqualified <dst> push
Date:   Fri, 26 Oct 2018 23:07:38 +0000
Message-Id: <20181026230741.23321-6-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.759.g500967bb5e
In-Reply-To: <20181026192734.9609-1-avarab@gmail.com>
References: <20181026192734.9609-1-avarab@gmail.com>
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

    Neither worked, so we gave up. You must fully-qualify the ref.
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
 Documentation/config.txt |  7 +++++++
 advice.c                 |  2 ++
 advice.h                 |  1 +
 remote.c                 | 37 +++++++++++++++++++++++++++++++++++++
 t/t5505-remote.sh        | 25 +++++++++++++++++++++++++
 5 files changed, 72 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 552827935a..8ca465702e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -320,6 +320,13 @@ advice.*::
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
index 3561cd64e9..3089a4ca65 100644
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
@@ -62,6 +63,7 @@ static struct {
 	{ "pushAlreadyExists", &advice_push_already_exists },
 	{ "pushFetchFirst", &advice_push_fetch_first },
 	{ "pushNeedsForce", &advice_push_needs_force },
+	{ "pushUnqualifiedRefName", &advice_push_unqualified_ref_name },
 	{ "statusHints", &advice_status_hints },
 	{ "statusUoption", &advice_status_u_option },
 	{ "commitBeforeMerge", &advice_commit_before_merge },
diff --git a/advice.h b/advice.h
index ab24df0fd0..9a2f8b5226 100644
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
index c7a0b9c46f..93f802509d 100644
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
 		"Neither worked, so we gave up. You must fully-qualify the ref."),
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
index d2a2cdd453..2e58721f98 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -1222,4 +1222,29 @@ test_expect_success 'add remote matching the "insteadOf" URL' '
 	git remote add backup xyz@example.com
 '
 
+test_expect_success 'unqualified <dst> refspec DWIM and advice' '
+	test_when_finished "(cd test && git tag -d some-tag)" &&
+	(
+		cd test &&
+		git tag -a -m "Some tag" some-tag master &&
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
+			test_i18ngrep ! "hint: Did you mean" err
+		done
+	)
+'
+
+
 test_done
-- 
2.19.1.759.g500967bb5e

