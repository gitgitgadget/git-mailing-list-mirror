Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD03D200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 16:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755631AbcL0QXy (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 11:23:54 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34392 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755556AbcL0QXq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 11:23:46 -0500
Received: by mail-pg0-f67.google.com with SMTP id b1so12844413pgc.1
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 08:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fLUzJReNIGfO5MkYW+aeOQooe8vM8zAKfeybbY1dLQ0=;
        b=BWpy1I3Pb6i30h0W0EAZZg8KWMBd5p/psw4kJ8+ODpM+H+ctSrd5Uw1wJrB4EJuGQ8
         SfrsdstsusoefDtTcFsbMO7hSd1hpq9Wj/xjZ571xQ9e2PMcFB9c8LxJp/gZwQOVceNo
         MU2d6W0No0pmpgeNfVdqXL/6rvpDYrZdUO5mafzV349YgVvz9/awbZWsZH03YONgL9Sg
         eqxxu9dM0cC2qL7dYpqqmjw82kHeqx3BZH0cI301zMg+eERgWH8kq507IPYaJl9CbZ41
         nUTptcLZeH8EeeePqqvXoh/hKTNmQbpRx+UWjqWC9/PS93l3RTWP7WvzrO/gzr5ocAet
         eghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fLUzJReNIGfO5MkYW+aeOQooe8vM8zAKfeybbY1dLQ0=;
        b=D/9XgHbYGdqLGhM3w5RPxMjVxhLA6XvS3XcUB5/zfLLTIFrdvDaLFwgzHcNIjwuUQd
         3yoIbOl6TVWnJrC/aeGfKxuJuzVY0ntkK+2fBBRSpufFjjcjz8jQg4DgHrT1O/zbQfX4
         MCQzJ8jbFJ0lFTAo/UjxppUHNSRnzclxeyQQs7L803dmg2adFkATXVVLKIPOeICizt7j
         No1F0LUN03GXW02cMV93o4KxNOvYC5DWKS9rPcjNWQ1tr2Ek5TbGfZ3l2Y0Bnq8PxcsI
         IqbY/3tLliAguhA6kCoFBK2rjsFd3w+yYwAz+PHbpQLB07+1lx5FqJkVskoI1ZtwOCEm
         2HjQ==
X-Gm-Message-State: AIkVDXJl1gZjnU8dtiywYyDbFtpIB5KUGcYJX7RcGwpzspFD3iZAlesA+9GCm0nPKBj12w==
X-Received: by 10.99.54.140 with SMTP id d134mr59329994pga.132.1482855825175;
        Tue, 27 Dec 2016 08:23:45 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([115.110.127.198])
        by smtp.gmail.com with ESMTPSA id c64sm46517096pfa.91.2016.12.27.08.23.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Dec 2016 08:23:44 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, Karthik Nayak <Karthik.188@gmail.com>
Subject: [PATCH v9 13/20] ref-filter: rename the 'strip' option to 'lstrip'
Date:   Tue, 27 Dec 2016 21:53:50 +0530
Message-Id: <20161227162357.28212-14-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161227162357.28212-1-Karthik.188@gmail.com>
References: <20161227162357.28212-1-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for the upcoming patch, where we introduce the 'rstrip'
option. Rename the 'strip' option to 'lstrip' to remove ambiguity.

Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt | 10 +++++-----
 builtin/tag.c                      |  4 ++--
 ref-filter.c                       | 20 ++++++++++----------
 t/t6300-for-each-ref.sh            | 22 +++++++++++-----------
 4 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index e7cdff6..46b4583 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -95,9 +95,9 @@ refname::
 	The name of the ref (the part after $GIT_DIR/).
 	For a non-ambiguous short name of the ref append `:short`.
 	The option core.warnAmbiguousRefs is used to select the strict
-	abbreviation mode. If `strip=<N>` is appended, strips `<N>`
+	abbreviation mode. If `lstrip=<N>` is appended, strips `<N>`
 	slash-separated path components from the front of the refname
-	(e.g., `%(refname:strip=2)` turns `refs/tags/foo` into `foo`.
+	(e.g., `%(refname:lstrip=2)` turns `refs/tags/foo` into `foo`.
 	`<N>` must be a positive integer.  If a displayed ref has fewer
 	components than `<N>`, the command aborts with an error.
 
@@ -116,7 +116,7 @@ objectname::
 
 upstream::
 	The name of a local ref which can be considered ``upstream''
-	from the displayed ref. Respects `:short` and `:strip` in the
+	from the displayed ref. Respects `:short` and `:lstrip` in the
 	same way as `refname` above.  Additionally respects `:track`
 	to show "[ahead N, behind M]" and `:trackshort` to show the
 	terse version: ">" (ahead), "<" (behind), "<>" (ahead and
@@ -130,7 +130,7 @@ upstream::
 
 push::
 	The name of a local ref which represents the `@{push}`
-	location for the displayed ref. Respects `:short`, `:strip`,
+	location for the displayed ref. Respects `:short`, `:lstrip`,
 	`:track`, and `:trackshort` options as `upstream`
 	does. Produces an empty string if no `@{push}` ref is
 	configured.
@@ -174,7 +174,7 @@ if::
 symref::
 	The ref which the given symbolic ref refers to. If not a
 	symbolic ref, nothing is printed. Respects the `:short` and
-	`:strip` options in the same way as `refname` above.
+	`:lstrip` options in the same way as `refname` above.
 
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
diff --git a/builtin/tag.c b/builtin/tag.c
index 73df728..b4789ce 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -45,11 +45,11 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, con
 	if (!format) {
 		if (filter->lines) {
 			to_free = xstrfmt("%s %%(contents:lines=%d)",
-					  "%(align:15)%(refname:strip=2)%(end)",
+					  "%(align:15)%(refname:lstrip=2)%(end)",
 					  filter->lines);
 			format = to_free;
 		} else
-			format = "%(refname:strip=2)";
+			format = "%(refname:lstrip=2)";
 	}
 
 	verify_ref_format(format);
diff --git a/ref-filter.c b/ref-filter.c
index 9140539..e0015c6 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -33,8 +33,8 @@ struct if_then_else {
 };
 
 struct refname_atom {
-	enum { R_NORMAL, R_SHORT, R_STRIP } option;
-	unsigned int strip;
+	enum { R_NORMAL, R_SHORT, R_LSTRIP } option;
+	unsigned int lstrip;
 };
 
 /*
@@ -91,10 +91,10 @@ static void refname_atom_parser_internal(struct refname_atom *atom,
 		atom->option = R_NORMAL;
 	else if (!strcmp(arg, "short"))
 		atom->option = R_SHORT;
-	else if (skip_prefix(arg, "strip=", &arg)) {
-		atom->option = R_STRIP;
-		if (strtoul_ui(arg, 10, &atom->strip) || atom->strip <= 0)
-			die(_("positive value expected refname:strip=%s"), arg);
+	else if (skip_prefix(arg, "lstrip=", &arg)) {
+		atom->option = R_LSTRIP;
+		if (strtoul_ui(arg, 10, &atom->lstrip) || atom->lstrip <= 0)
+			die(_("positive value expected refname:lstrip=%s"), arg);
 	} else
 		die(_("unrecognized %%(%s) argument: %s"), name, arg);
 }
@@ -1091,7 +1091,7 @@ static inline char *copy_advance(char *dst, const char *src)
 	return dst;
 }
 
-static const char *strip_ref_components(const char *refname, unsigned int len)
+static const char *lstrip_ref_components(const char *refname, unsigned int len)
 {
 	long remaining = len;
 	const char *start = refname;
@@ -1099,7 +1099,7 @@ static const char *strip_ref_components(const char *refname, unsigned int len)
 	while (remaining) {
 		switch (*start++) {
 		case '\0':
-			die(_("ref '%s' does not have %ud components to :strip"),
+			die(_("ref '%s' does not have %ud components to :lstrip"),
 			    refname, len);
 		case '/':
 			remaining--;
@@ -1113,8 +1113,8 @@ static const char *show_ref(struct refname_atom *atom, const char *refname)
 {
 	if (atom->option == R_SHORT)
 		return shorten_unambiguous_ref(refname, warn_ambiguous_refs);
-	else if (atom->option == R_STRIP)
-		return strip_ref_components(refname, atom->strip);
+	else if (atom->option == R_LSTRIP)
+		return lstrip_ref_components(refname, atom->lstrip);
 	else
 		return refname;
 }
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index c538084..5eb013c 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -51,14 +51,14 @@ test_atom() {
 
 test_atom head refname refs/heads/master
 test_atom head refname:short master
-test_atom head refname:strip=1 heads/master
-test_atom head refname:strip=2 master
+test_atom head refname:lstrip=1 heads/master
+test_atom head refname:lstrip=2 master
 test_atom head upstream refs/remotes/origin/master
 test_atom head upstream:short origin/master
-test_atom head upstream:strip=2 origin/master
+test_atom head upstream:lstrip=2 origin/master
 test_atom head push refs/remotes/myfork/master
 test_atom head push:short myfork/master
-test_atom head push:strip=1 remotes/myfork/master
+test_atom head push:lstrip=1 remotes/myfork/master
 test_atom head objecttype commit
 test_atom head objectsize 171
 test_atom head objectname $(git rev-parse refs/heads/master)
@@ -141,14 +141,14 @@ test_expect_success 'Check invalid atoms names are errors' '
 	test_must_fail git for-each-ref --format="%(INVALID)" refs/heads
 '
 
-test_expect_success 'arguments to :strip must be positive integers' '
-	test_must_fail git for-each-ref --format="%(refname:strip=0)" &&
-	test_must_fail git for-each-ref --format="%(refname:strip=-1)" &&
-	test_must_fail git for-each-ref --format="%(refname:strip=foo)"
+test_expect_success 'arguments to :lstrip must be positive integers' '
+	test_must_fail git for-each-ref --format="%(refname:lstrip=0)" &&
+	test_must_fail git for-each-ref --format="%(refname:lstrip=-1)" &&
+	test_must_fail git for-each-ref --format="%(refname:lstrip=foo)"
 '
 
 test_expect_success 'stripping refnames too far gives an error' '
-	test_must_fail git for-each-ref --format="%(refname:strip=3)"
+	test_must_fail git for-each-ref --format="%(refname:lstrip=3)"
 '
 
 test_expect_success 'Check format specifiers are ignored in naming date atoms' '
@@ -630,8 +630,8 @@ cat >expected <<EOF
 master
 EOF
 
-test_expect_success 'Verify usage of %(symref:strip) atom' '
-	git for-each-ref --format="%(symref:strip=2)" refs/heads/sym > actual &&
+test_expect_success 'Verify usage of %(symref:lstrip) atom' '
+	git for-each-ref --format="%(symref:lstrip=2)" refs/heads/sym > actual &&
 	test_cmp expected actual
 '
 
-- 
2.10.2

