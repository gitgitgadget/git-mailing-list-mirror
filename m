Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A618F1F453
	for <e@80x24.org>; Sat, 22 Sep 2018 18:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbeIVX7i (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 19:59:38 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36343 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeIVX7h (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Sep 2018 19:59:37 -0400
Received: by mail-lf1-f68.google.com with SMTP id v17-v6so9695102lfe.3
        for <git@vger.kernel.org>; Sat, 22 Sep 2018 11:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/E1eWnJ1dSirjjk7el6HYf2/Al+hJoeqIBbAEO8hT+s=;
        b=gyfTQdA6oGpr7ezbEPM9pT+0qCavWOtq7KLBxp+U5A2HFMH/26J85eHldJibv+srSl
         3syygAj+ccjXeyqxcjh9FrxttrS4zl3uut9knktKYc8qj+O7r7748JUBr5YbrEbU1DU+
         LGNebyLrAlHm5EAnGUMiFumFozVE5Bvgth3VM6rYQIGQo6/ABtDVZ84tpkQ7NWaDM3GG
         tzCNVLiGc3MZCQ+RGiuEnB6ixg3A9j5GYXL9xQAOiiKAI6/u3DHz0eHUfCq5hzMcxahz
         GytxYOf7e1fZshl0w5stRQHBCf/EamJsufFpCsKjvTQUXl0mKlaPyVXVWv7FCmHKnXv0
         UgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/E1eWnJ1dSirjjk7el6HYf2/Al+hJoeqIBbAEO8hT+s=;
        b=fmaF04YsRKYiNT1B10/Gg3l9saon1Nuv7FM/8rb++lSdIuYQJhGPzL4CB0t2S/QjWN
         pvXh0w2OvRVYCUce66U2j93wFqLEFEJVpDx4lht5UcoyxQ0OikwVTAI5M4neUxFlG+OY
         kdLiDJQ+3ZhYG9agm4VvokcRtH7LmOrgNttyAMbRLWP6GAxQaP46kHI3aJz+bzi0iMIH
         QhW4UA38+AgUv5As6pen8zL97933ysRlGjjjGSUF162C+tgy45vU5H+R755M99wt1yxQ
         nI43gzzekdRsN/AhPZ80W/1A3BpwNHAOo57UEIlQAklB1eHVPfQD3oCQUXOXOPZnLvpo
         twbg==
X-Gm-Message-State: APzg51AOSxV7XiPghb7XgwzZNrSXStvhpO+fEMyaWu+INwbCMh+rlFxi
        0aHj9s13r6cbz4JodSbc9N1a6uEC
X-Google-Smtp-Source: ANB0Vdb4Ndvkko6JYuLqUW7l4kOzxi12NcqWGsJl9oQBDEwdzqpEwGD1npC5g4cRO27z6HayIbhtCQ==
X-Received: by 2002:a19:a085:: with SMTP id j127-v6mr1857551lfe.106.1537639509490;
        Sat, 22 Sep 2018 11:05:09 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id f4-v6sm2877942lfa.9.2018.09.22.11.05.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 11:05:08 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 3/8] refs: new ref types to make per-worktree refs visible to all worktrees
Date:   Sat, 22 Sep 2018 20:04:55 +0200
Message-Id: <20180922180500.4689-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.647.gb9a6049235
In-Reply-To: <20180922180500.4689-1-pclouds@gmail.com>
References: <20180922180500.4689-1-pclouds@gmail.com>
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
acccessible via the name "main/HEAD" (we can't use
"worktrees/main/HEAD" because "main" under "worktrees" is not
reserved).

This patch also makes it possible to specify refs from one worktree in
another one, e.g.

    git log worktrees/foo/HEAD

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c                   | 20 ++++++++++++++++++++
 refs.h                   |  8 +++++---
 refs/files-backend.c     | 28 ++++++++++++++++++++++++++++
 t/t1415-worktree-refs.sh | 30 ++++++++++++++++++++++++++++++
 4 files changed, 83 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index a851ef085b..90b73c7334 100644
--- a/refs.c
+++ b/refs.c
@@ -641,12 +641,32 @@ static int is_pseudoref_syntax(const char *refname)
 	return 1;
 }
 
+static int is_main_pseudoref_syntax(const char *refname)
+{
+	return skip_prefix(refname, "main/", &refname) &&
+		is_pseudoref_syntax(refname);
+}
+
+static int is_other_pseudoref_syntax(const char *refname)
+{
+	if (!skip_prefix(refname, "worktrees/", &refname))
+		return 0;
+	refname = strchr(refname, '/');
+	if (!refname)
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
index 416eafa453..bf9ed633b1 100644
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
+		if (!skip_prefix(refname, "main/", &refname))
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
+		if (!skip_prefix(refname, "main/", &refname))
+			BUG("ref %s is not a main pseudoref", refname);
+		/* passthru */
+	case REF_TYPE_OTHER_PSEUDOREF:
 	case REF_TYPE_NORMAL:
 		strbuf_addf(sb, "%s/%s", refs->gitcommondir, refname);
 		break;
diff --git a/t/t1415-worktree-refs.sh b/t/t1415-worktree-refs.sh
index 0c2d5f89a9..46ca7bfc19 100755
--- a/t/t1415-worktree-refs.sh
+++ b/t/t1415-worktree-refs.sh
@@ -33,4 +33,34 @@ test_expect_success 'refs/local are per-worktree' '
 	( cd wt2 && test_cmp_rev local/foo wt2 )
 '
 
+test_expect_success 'resolve main/HEAD' '
+	test_cmp_rev main/HEAD initial &&
+	( cd wt1 && test_cmp_rev main/HEAD initial ) &&
+	( cd wt2 && test_cmp_rev main/HEAD initial )
+'
+
+test_expect_success 'resolve worktrees/xx/HEAD' '
+	test_cmp_rev worktrees/wt1/HEAD wt1 &&
+	( cd wt1 && test_cmp_rev worktrees/wt1/HEAD wt1 ) &&
+	( cd wt2 && test_cmp_rev worktrees/wt1/HEAD wt1 )
+'
+
+test_expect_success 'reflog of main/HEAD' '
+	git reflog HEAD | sed "s/HEAD/main\/HEAD/" >expected &&
+	git reflog main/HEAD >actual &&
+	test_cmp expected actual &&
+	git -C wt1 reflog main/HEAD >actual.wt1 &&
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
2.19.0.647.gb9a6049235

