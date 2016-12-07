Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1451203C1
	for <e@80x24.org>; Wed,  7 Dec 2016 15:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753450AbcLGPhC (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 10:37:02 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35755 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753209AbcLGPgv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 10:36:51 -0500
Received: by mail-pf0-f193.google.com with SMTP id i88so11380862pfk.2
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 07:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rCG7der9H2nijCaW138dtPKo+8so7ttTY7ecD4WnUcY=;
        b=Kf28JioIr0t+fAdXH8lGhfDN96vaBD4+7C82uvohjMur8vwmT8C0VcY57v8vQneW3K
         31SfzbTEpc7CfUFK75g4tJLMLqjZ/cRfxAe1rCNQV+CNoMiWla1BKqmLntHAJ8PZAXuW
         pgEvhL2v3FH+vSCsAFrLJhH64GzdPDL6mTNuL4ozyvO6oKSk+vTAxxsFc4UPY2SVQYZW
         yMg9gwRn7Xe8+6Pg1EAYvPfQy1dOW02FrufH1Htekv9VkHon0ZsXtvzXr+ZwWjwMRcUn
         lvwZt4OiexUuP3F8Xj6RQ0zJ84dux7HRdBWC59J3cTvF3dN0izKvan9CaaUijH34MQ+5
         Y+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rCG7der9H2nijCaW138dtPKo+8so7ttTY7ecD4WnUcY=;
        b=m/SmYoAHJfNlr+htE9hyq2FQnDBs2NuPz9oGbDDWiFLwJHjOHYrBhlrDLmhAGnyy0j
         dPtExAUG0HwsO+3emZAaM5TN3D5NtjY5xkZ7U0bLHlSDcCZGWZtRODNYUxQoo0pIF0Wi
         WekBhdH0JbJ/FZQqS89f8YE9rypFo2Ru1OXesywFQrQzybv0JpjKK5x3aDnyMO9+Wg9H
         MZNC037JAtoNA98Fxtico/saGpI4eB0etjN4w3ebMDpulM48FTzU11lHbJWBucPyy431
         BV+gi+UwzG6450/TVhSXLH8kNXHgUNaojepLBT9Dg9IGS4KorMbT7LdjII4hd4y/ZV/K
         z+YQ==
X-Gm-Message-State: AKaTC02LSLzTFkbtvo5U4Kokc7Xmrm92Xru6KJ3iOXo7jbmnecPB+447HUHM0aZdW4aeQQ==
X-Received: by 10.84.146.140 with SMTP id g12mr150073262pla.157.1481125005545;
        Wed, 07 Dec 2016 07:36:45 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([122.15.255.69])
        by smtp.gmail.com with ESMTPSA id l7sm43584459pfg.35.2016.12.07.07.36.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Dec 2016 07:36:45 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com, jnareb@gmail.com,
        Karthik Nayak <Karthik.188@gmail.com>
Subject: [PATCH v8 13/19] ref-filter: rename the 'strip' option to 'lstrip'
Date:   Wed,  7 Dec 2016 21:06:21 +0530
Message-Id: <20161207153627.1468-14-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161207153627.1468-1-Karthik.188@gmail.com>
References: <20161207153627.1468-1-Karthik.188@gmail.com>
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
index 6a1e747..f85ccff 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -92,9 +92,9 @@ refname::
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
 
@@ -113,7 +113,7 @@ objectname::
 
 upstream::
 	The name of a local ref which can be considered ``upstream''
-	from the displayed ref. Respects `:short` and `:strip` in the
+	from the displayed ref. Respects `:short` and `:lstrip` in the
 	same way as `refname` above.  Additionally respects `:track`
 	to show "[ahead N, behind M]" and `:trackshort` to show the
 	terse version: ">" (ahead), "<" (behind), "<>" (ahead and
@@ -127,7 +127,7 @@ upstream::
 
 push::
 	The name of a local ref which represents the `@{push}`
-	location for the displayed ref. Respects `:short`, `:strip`,
+	location for the displayed ref. Respects `:short`, `:lstrip`,
 	`:track`, and `:trackshort` options as `upstream`
 	does. Produces an empty string if no `@{push}` ref is
 	configured.
@@ -171,7 +171,7 @@ if::
 symref::
 	The ref which the given symbolic ref refers to. If not a
 	symbolic ref, nothing is printed. Respects the `:short` and
-	`:strip` options in the same way as `refname` above.
+	`:lstrip` options in the same way as `refname` above.
 
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
diff --git a/builtin/tag.c b/builtin/tag.c
index 50e4ae5..24bbe24 100644
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
index be535a6..c74b08d 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -32,8 +32,8 @@ struct if_then_else {
 };
 
 struct refname_atom {
-	enum { R_NORMAL, R_SHORT, R_STRIP } option;
-	unsigned int strip;
+	enum { R_NORMAL, R_SHORT, R_LSTRIP } option;
+	unsigned int lstrip;
 };
 
 /*
@@ -90,10 +90,10 @@ static void refname_atom_parser_internal(struct refname_atom *atom,
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
@@ -1071,7 +1071,7 @@ static inline char *copy_advance(char *dst, const char *src)
 	return dst;
 }
 
-static const char *strip_ref_components(const char *refname, unsigned int len)
+static const char *lstrip_ref_components(const char *refname, unsigned int len)
 {
 	long remaining = len;
 	const char *start = refname;
@@ -1079,7 +1079,7 @@ static const char *strip_ref_components(const char *refname, unsigned int len)
 	while (remaining) {
 		switch (*start++) {
 		case '\0':
-			die(_("ref '%s' does not have %ud components to :strip"),
+			die(_("ref '%s' does not have %ud components to :lstrip"),
 			    refname, len);
 		case '/':
 			remaining--;
@@ -1093,8 +1093,8 @@ static const char *show_ref(struct refname_atom *atom, const char *refname)
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
index 2facfaf..2b1af9c 100755
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
@@ -605,8 +605,8 @@ cat >expected <<EOF
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

