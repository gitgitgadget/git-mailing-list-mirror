Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 099CC1F453
	for <e@80x24.org>; Sat, 29 Sep 2018 19:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbeI3BkX (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 21:40:23 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:47030 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727643AbeI3BkX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 21:40:23 -0400
Received: by mail-lf1-f67.google.com with SMTP id q2-v6so7183181lfc.13
        for <git@vger.kernel.org>; Sat, 29 Sep 2018 12:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gjH83BQBEIV9zGTb6sA7alTUSuKHIbeGklJLQwZvK8s=;
        b=JIXs0jlacT/qTUNaY5+a8kUWt1Q8gRTJrblgKmwvMfj+A2UBZlIjkGvprxSKSvUIUB
         PEq0DsLtRdQsfB3y/6qmanwl8HZ8xhF3EZI02LYgay0ZYooobEzH/TMEIge2ZbMxc4G2
         lRSMR4X/W3sVs5/WisjLiJx+iEg55eZ9f0IX8gOefAbHjaLybnYg387xqx5GRbcLpijB
         9tdbCoQeFVlmvyQFzwu7lj6KDS+0LT5MPubOtP/4NmcoQw7MxM8m6CC+JSfl51A5wptc
         XTRIVSN4K+oA9f1H/YzY9r4SlouhrHb7Iq4F3Y0oYsuqkLo03EaVp+tAAP+uXLPQ2/Ql
         3bxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gjH83BQBEIV9zGTb6sA7alTUSuKHIbeGklJLQwZvK8s=;
        b=uR1CdJwo8fT2ulKoUIQIVVMLCFqDYTyxlBB77rDz4Av2O5m4K2dXM8U+Rof79R0/Ah
         gR98NTuyPSOMpdMwRyGY2xIxaQ7WYs9VSPiBJR9w/opFA0C7p1MdAVOFUHavA/fKQdzt
         w1fiHg1KWcRFwGAPCl91dOx4O/GXJfi+vgzS7rTeC7h27Qfq/nNvZkX8PuHZ0nxSvBxj
         wDwu6nWhQA5ySPdJ8H4Ifru1xG7QAH2lw0N44b8HGi/uI5DD7GjIFuloAOGtN7RGr0Zz
         jbP7z+tjrCxh876VW/8gKXBUTLDTVtEj2uWojKHzIa1yUoOeaY9pPEjjkX5zMuY6925d
         t1Uw==
X-Gm-Message-State: ABuFfogTCLi3YBu3wU5oaYHKlCLFGpG4+y7oRKdbWavyZJvWAwfu0D+V
        ljFrLAeZV0mcz2f/Pi/pCr0=
X-Google-Smtp-Source: ACcGV61Xmz6Io22FAPjFYaZqZWjDaNHnJ1r91cU/L7JHTHJjOJx55djkEG3rCPVFi6WFdrDQB+gn5A==
X-Received: by 2002:a19:a90f:: with SMTP id s15-v6mr1877353lfe.154.1538248245773;
        Sat, 29 Sep 2018 12:10:45 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c14-v6sm1638494lfi.23.2018.09.29.12.10.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 12:10:44 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 3/8] refs: new ref types to make per-worktree refs visible to all worktrees
Date:   Sat, 29 Sep 2018 21:10:24 +0200
Message-Id: <20180929191029.13994-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.341.g3acb95d729
In-Reply-To: <20180929191029.13994-1-pclouds@gmail.com>
References: <20180922180500.4689-1-pclouds@gmail.com>
 <20180929191029.13994-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of the problems with multiple worktree is accessing per-worktree
refs of one worktree from another worktree. This was sort of solved by
multiple ref store, where the code can open the ref store of another
worktree and has access to the ref space of that worktree.

The problem with this is reporting. "HEAD" in another ref space is
also called "HEAD" like in the current ref space. In order to
differentiate them, all the code must somehow carry the ref store
around and print something like "HEAD from this ref store".

But that is not feasible (or possible with a _lot_ of work). With the
current design, we pass a reference around as a string (so called
"refname"). Extending this design to pass a string _and_ a ref store
is a nightmare, especially when handling extended SHA-1 syntax.

So we do it another way. Instead of entering a separate ref space, we
make refs from other worktrees available in the current ref space. So
"HEAD" is always HEAD of the current worktree, but then we can have
"worktrees/blah/HEAD" to denote HEAD from a worktree named
"blah". This syntax coincidentally matches the underlying directory
structure which makes implementation a bit easier.

The main worktree has to be treated specially because well.. it's
special from the beginning. So HEAD from the main worktree is
acccessible via the name "main-worktree/HEAD" instead of
"worktrees/main/HEAD" because "main" could be just another secondary
worktree.

This patch also makes it possible to specify refs from one worktree in
another one, e.g.

    git log worktrees/foo/HEAD

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-worktree.txt | 15 ++++++++++-
 refs.c                         | 21 ++++++++++++++++
 refs.h                         |  8 +++---
 refs/files-backend.c           | 28 +++++++++++++++++++++
 t/t1415-worktree-refs.sh       | 46 ++++++++++++++++++++++++++++++++++
 5 files changed, 114 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index a50fbf8094..58415f9207 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -208,7 +208,8 @@ REFS
 ----
 In multiple working trees, some refs may be shared between all working
 trees, some refs are local. One example is HEAD is different for all
-working trees. This section is about the sharing rules.
+working trees. This section is about the sharing rules and how to access
+refs of one working tree from another.
 
 In general, all pseudo refs are per working tree and all refs starting
 with "refs/" are shared. Pseudo refs are ones like HEAD which are
@@ -216,6 +217,18 @@ directly under GIT_DIR instead of inside GIT_DIR/refs. There are one
 exception to this: refs inside refs/bisect and refs/worktree is not
 shared.
 
+Refs that are per working tree can still be accessed from another
+working tree via two special paths main-worktree and worktrees. The
+former gives access to per-worktree refs of the main working tree,
+while the former to all linked working trees.
+
+For example, main-worktree/HEAD or main-worktree/refs/bisect/good
+resolve to the same value as the main working tree's HEAD and
+refs/bisect/good respectively. Similarly, worktrees/foo/HEAD or
+worktrees/bar/refs/bisect/bad are the same as
+GIT_COMMON_DIR/worktrees/foo/HEAD and
+GIT_COMMON_DIR/worktrees/bar/refs/bisect/bad.
+
 To access refs, it's best not to look inside GIT_DIR directly. Instead
 use commands such as linkgit:git-revparse[1] or linkgit:git-update-ref[1]
 which will handle refs correctly.
diff --git a/refs.c b/refs.c
index 1bc4ed301b..2378b2e7fc 100644
--- a/refs.c
+++ b/refs.c
@@ -641,12 +641,33 @@ static int is_pseudoref_syntax(const char *refname)
 	return 1;
 }
 
+static int is_main_pseudoref_syntax(const char *refname)
+{
+	return skip_prefix(refname, "main-worktree/", &refname) &&
+		*refname &&
+		is_pseudoref_syntax(refname);
+}
+
+static int is_other_pseudoref_syntax(const char *refname)
+{
+	if (!skip_prefix(refname, "worktrees/", &refname))
+		return 0;
+	refname = strchr(refname, '/');
+	if (!refname || !refname[1])
+		return 0;
+	return is_pseudoref_syntax(refname + 1);
+}
+
 enum ref_type ref_type(const char *refname)
 {
 	if (is_per_worktree_ref(refname))
 		return REF_TYPE_PER_WORKTREE;
 	if (is_pseudoref_syntax(refname))
 		return REF_TYPE_PSEUDOREF;
+	if (is_main_pseudoref_syntax(refname))
+		return REF_TYPE_MAIN_PSEUDOREF;
+	if (is_other_pseudoref_syntax(refname))
+		return REF_TYPE_OTHER_PSEUDOREF;
 	return REF_TYPE_NORMAL;
 }
 
diff --git a/refs.h b/refs.h
index bd52c1bbae..9b53dbeae8 100644
--- a/refs.h
+++ b/refs.h
@@ -704,9 +704,11 @@ int parse_hide_refs_config(const char *var, const char *value, const char *);
 int ref_is_hidden(const char *, const char *);
 
 enum ref_type {
-	REF_TYPE_PER_WORKTREE,
-	REF_TYPE_PSEUDOREF,
-	REF_TYPE_NORMAL,
+	REF_TYPE_PER_WORKTREE,	  /* refs inside refs/ but not shared       */
+	REF_TYPE_PSEUDOREF,	  /* refs outside refs/ in current worktree */
+	REF_TYPE_MAIN_PSEUDOREF,  /* pseudo refs from the main worktree     */
+	REF_TYPE_OTHER_PSEUDOREF, /* pseudo refs from other worktrees       */
+	REF_TYPE_NORMAL,	  /* normal/shared refs inside refs/        */
 };
 
 enum ref_type ref_type(const char *refname);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 2dd77f9485..9ca2a3706c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -149,6 +149,23 @@ static struct files_ref_store *files_downcast(struct ref_store *ref_store,
 	return refs;
 }
 
+static void files_reflog_path_other_worktrees(struct files_ref_store *refs,
+					      struct strbuf *sb,
+					      const char *refname)
+{
+	const char *real_ref;
+
+	if (!skip_prefix(refname, "worktrees/", &real_ref))
+		BUG("refname %s is not a other-worktree ref", refname);
+	real_ref = strchr(real_ref, '/');
+	if (!real_ref)
+		BUG("refname %s is not a other-worktree ref", refname);
+	real_ref++;
+
+	strbuf_addf(sb, "%s/%.*slogs/%s", refs->gitcommondir,
+		    (int)(real_ref - refname), refname, real_ref);
+}
+
 static void files_reflog_path(struct files_ref_store *refs,
 			      struct strbuf *sb,
 			      const char *refname)
@@ -158,6 +175,12 @@ static void files_reflog_path(struct files_ref_store *refs,
 	case REF_TYPE_PSEUDOREF:
 		strbuf_addf(sb, "%s/logs/%s", refs->gitdir, refname);
 		break;
+	case REF_TYPE_OTHER_PSEUDOREF:
+		return files_reflog_path_other_worktrees(refs, sb, refname);
+	case REF_TYPE_MAIN_PSEUDOREF:
+		if (!skip_prefix(refname, "main-worktree/", &refname))
+			BUG("ref %s is not a main pseudoref", refname);
+		/* passthru */
 	case REF_TYPE_NORMAL:
 		strbuf_addf(sb, "%s/logs/%s", refs->gitcommondir, refname);
 		break;
@@ -176,6 +199,11 @@ static void files_ref_path(struct files_ref_store *refs,
 	case REF_TYPE_PSEUDOREF:
 		strbuf_addf(sb, "%s/%s", refs->gitdir, refname);
 		break;
+	case REF_TYPE_MAIN_PSEUDOREF:
+		if (!skip_prefix(refname, "main-worktree/", &refname))
+			BUG("ref %s is not a main pseudoref", refname);
+		/* passthru */
+	case REF_TYPE_OTHER_PSEUDOREF:
 	case REF_TYPE_NORMAL:
 		strbuf_addf(sb, "%s/%s", refs->gitcommondir, refname);
 		break;
diff --git a/t/t1415-worktree-refs.sh b/t/t1415-worktree-refs.sh
index 16c91bef57..8b701d07af 100755
--- a/t/t1415-worktree-refs.sh
+++ b/t/t1415-worktree-refs.sh
@@ -30,4 +30,50 @@ test_expect_success 'refs/worktree are per-worktree' '
 	( cd wt2 && test_cmp_rev worktree/foo wt2 )
 '
 
+test_expect_success 'resolve main-worktree/HEAD' '
+	test_cmp_rev main-worktree/HEAD initial &&
+	( cd wt1 && test_cmp_rev main-worktree/HEAD initial ) &&
+	( cd wt2 && test_cmp_rev main-worktree/HEAD initial )
+'
+
+test_expect_success 'ambiguous main-worktree/HEAD' '
+	mkdir -p .git/refs/heads/main-worktree &&
+	test_when_finished rm .git/refs/heads/main-worktree/HEAD &&
+	cp .git/HEAD .git/refs/heads/main-worktree/HEAD &&
+	git rev-parse main-worktree/HEAD 2>warn >/dev/null &&
+	grep "main-worktree/HEAD.*ambiguous" warn
+'
+
+test_expect_success 'resolve worktrees/xx/HEAD' '
+	test_cmp_rev worktrees/wt1/HEAD wt1 &&
+	( cd wt1 && test_cmp_rev worktrees/wt1/HEAD wt1 ) &&
+	( cd wt2 && test_cmp_rev worktrees/wt1/HEAD wt1 )
+'
+
+test_expect_success 'ambiguous worktrees/xx/HEAD' '
+	mkdir -p .git/refs/heads/worktrees/wt1 &&
+	test_when_finished rm .git/refs/heads/worktrees/wt1/HEAD &&
+	cp .git/HEAD .git/refs/heads/worktrees/wt1/HEAD &&
+	git rev-parse worktrees/wt1/HEAD 2>warn >/dev/null &&
+	grep "worktrees/wt1/HEAD.*ambiguous" warn
+'
+
+test_expect_success 'reflog of main-worktree/HEAD' '
+	git reflog HEAD | sed "s/HEAD/main-worktree\/HEAD/" >expected &&
+	git reflog main-worktree/HEAD >actual &&
+	test_cmp expected actual &&
+	git -C wt1 reflog main-worktree/HEAD >actual.wt1 &&
+	test_cmp expected actual.wt1
+'
+
+test_expect_success 'reflog of worktrees/xx/HEAD' '
+	git -C wt2 reflog HEAD | sed "s/HEAD/worktrees\/wt2\/HEAD/" >expected &&
+	git reflog worktrees/wt2/HEAD >actual &&
+	test_cmp expected actual &&
+	git -C wt1 reflog worktrees/wt2/HEAD >actual.wt1 &&
+	test_cmp expected actual.wt1 &&
+	git -C wt2 reflog worktrees/wt2/HEAD >actual.wt2 &&
+	test_cmp expected actual.wt2
+'
+
 test_done
-- 
2.19.0.341.g3acb95d729

