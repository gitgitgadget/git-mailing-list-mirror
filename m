Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA4EA1FC43
	for <e@80x24.org>; Mon, 13 Mar 2017 18:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751267AbdCMSXa (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 14:23:30 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:33591 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751102AbdCMSX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 14:23:28 -0400
Received: by mail-pg0-f42.google.com with SMTP id 25so66933283pgy.0
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 11:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l97RNAO6Y9XdDD8Pa4qsdEX/T9m6KxDmXvct/+fEyHE=;
        b=e0Kg9QxE53wwrwqMZeIyepX9DlrmNCV3dFMY4qafmTNxqzCVuD6GehPU3nkhWWcS6n
         3aCN/kgOYwOxuf7F1MiJEWTToYhshbE+sF7YwJ4whuL17If2xrRj/AgMvDM95Q5qHIe7
         yOkqHyj8W711XeeHUBoBc8KER/F/ms/0frc2R7ov+uZh95Lh1NkoGjPNea/om/9/iQkm
         +a5a1hCmnwPa/CsKfb+P77irhD0yrd64uJNZP8c/V38cH+HHWvB8O7fCwhNEwHzZl+8E
         rtaljxY6B47MPcgqmsZEPNCBCKqLnMwcUhZSn+wynizq3C1nrqOQZADOMHmXKA6dtex2
         P0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l97RNAO6Y9XdDD8Pa4qsdEX/T9m6KxDmXvct/+fEyHE=;
        b=V56llIRsmrnKumXDM0Xw1ZJ0NHAoeXderpFRiX8cxwFi+x5GkZlveyaYTZHAIhNTCb
         8h667vo6OHKQIigae1lvg+n0z1viZT0GIlrJMun1ASF8iAAq0QcJF7uzckfbqTBhI+gC
         2LrCYIwSxvAlzRAcmTGQuP/5/b1SrLg7bx+UHf/UGnidpgj4M21NS8UlJBhmJlSRsX6p
         FTzA3qHc/eDDbirO33tBFtHXA36CRt/Tic1ZZdybFe+ZSmVF7FsvWwrCpQdjwfy2lF+S
         SNPPiPp6+Pto5G5ecTpmPV9xTbRiaHmRwMMvmlnLdO4+5OnwRgfI0umSSq/O16BE2R9R
         NkmA==
X-Gm-Message-State: AMke39kx3pvMPMCEn09rHDIqgkhfwF+qstOn8pzLIZ4W+dXYeb4b5xci73LZipTVIjdXbNcf
X-Received: by 10.98.62.219 with SMTP id y88mr39154037pfj.62.1489429406958;
        Mon, 13 Mar 2017 11:23:26 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id z4sm22875320pge.49.2017.03.13.11.23.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Mar 2017 11:23:25 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, jonathantanmy@google.com
Subject: [PATCH v3 0/2] bringing attributes to pathspecs
Date:   Mon, 13 Mar 2017 11:23:20 -0700
Message-Id: <20170313182322.27539-1-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.246.ga2ecc84866-goog
In-Reply-To: <20170310185908.171589-1-bmwill@google.com>
References: <20170310185908.171589-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3 fixes some nits in style in the test script (using <<-\EOF instead of <<-EOF)
as well as fixing a few other minor things reported by Junio and Jonathan.

Brandon Williams (2):
  pathspec: allow querying for attributes
  pathspec: allow escaped query values

 Documentation/glossary-content.txt |  21 ++++
 attr.c                             |  17 ++++
 attr.h                             |   1 +
 dir.c                              |  43 +++++++-
 pathspec.c                         | 159 +++++++++++++++++++++++++++--
 pathspec.h                         |  15 ++-
 t/t6135-pathspec-with-attrs.sh     | 200 +++++++++++++++++++++++++++++++++++++
 7 files changed, 446 insertions(+), 10 deletions(-)
 create mode 100755 t/t6135-pathspec-with-attrs.sh

--- interdiff with bw/attr-pathspec

diff --git a/pathspec.c b/pathspec.c
index d7956f6bf..303efda83 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -139,7 +139,7 @@ static void parse_pathspec_attr_match(struct pathspec_item *item, const char *va
 	struct string_list_item *si;
 	struct string_list list = STRING_LIST_INIT_DUP;
 
-	if (item->attr_check)
+	if (item->attr_check || item->attr_match)
 		die(_("Only one 'attr:' specification is allowed."));
 
 	if (!value || !*value)
@@ -149,9 +149,7 @@ static void parse_pathspec_attr_match(struct pathspec_item *item, const char *va
 	string_list_remove_empty_items(&list, 0);
 
 	item->attr_check = attr_check_alloc();
-	ALLOC_GROW(item->attr_match,
-		   list.nr,
-		   item->attr_match_alloc);
+	item->attr_match = xcalloc(list.nr, sizeof(struct attr_match));
 
 	for_each_string_list_item(si, &list) {
 		size_t attr_len;
@@ -462,7 +460,6 @@ static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
 	item->attr_check = NULL;
 	item->attr_match = NULL;
 	item->attr_match_nr = 0;
-	item->attr_match_alloc = 0;
 
 	/* PATHSPEC_LITERAL_PATH ignores magic */
 	if (flags & PATHSPEC_LITERAL_PATH) {
@@ -712,8 +709,7 @@ void copy_pathspec(struct pathspec *dst, const struct pathspec *src)
 		COPY_ARRAY(d->attr_match, s->attr_match, d->attr_match_nr);
 		for (j = 0; j < d->attr_match_nr; j++) {
 			const char *value = s->attr_match[j].value;
-			if (value)
-				d->attr_match[j].value = xstrdup(value);
+			d->attr_match[j].value = xstrdup_or_null(value);
 		}
 
 		d->attr_check = attr_check_dup(s->attr_check);
diff --git a/pathspec.h b/pathspec.h
index 83625f006..55e976972 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -34,7 +34,6 @@ struct pathspec {
 		int nowildcard_len;
 		int flags;
 		int attr_match_nr;
-		int attr_match_alloc;
 		struct attr_match {
 			char *value;
 			enum attr_match_mode {
diff --git a/t/t6135-pathspec-with-attrs.sh b/t/t6135-pathspec-with-attrs.sh
index f60af29a9..77b8cef66 100755
--- a/t/t6135-pathspec-with-attrs.sh
+++ b/t/t6135-pathspec-with-attrs.sh
@@ -4,7 +4,7 @@ test_description='test labels in pathspecs'
 . ./test-lib.sh
 
 test_expect_success 'setup a tree' '
-	cat <<-EOF >expect &&
+	cat <<-\EOF >expect &&
 	fileA
 	fileAB
 	fileAC
@@ -49,7 +49,7 @@ test_expect_success 'pathspec with labels and non existent .gitattributes' '
 '
 
 test_expect_success 'setup .gitattributes' '
-	cat <<-EOF >.gitattributes &&
+	cat <<-\EOF >.gitattributes &&
 	fileA labelA
 	fileB labelB
 	fileC labelC
@@ -66,7 +66,7 @@ test_expect_success 'setup .gitattributes' '
 '
 
 test_expect_success 'check specific set attr' '
-	cat <<-EOF >expect &&
+	cat <<-\EOF >expect &&
 	fileSetLabel
 	sub/fileSetLabel
 	EOF
@@ -75,7 +75,7 @@ test_expect_success 'check specific set attr' '
 '
 
 test_expect_success 'check specific unset attr' '
-	cat <<-EOF >expect &&
+	cat <<-\EOF >expect &&
 	fileUnsetLabel
 	sub/fileUnsetLabel
 	EOF
@@ -84,7 +84,7 @@ test_expect_success 'check specific unset attr' '
 '
 
 test_expect_success 'check specific value attr' '
-	cat <<-EOF >expect &&
+	cat <<-\EOF >expect &&
 	fileValue
 	sub/fileValue
 	EOF
@@ -95,7 +95,7 @@ test_expect_success 'check specific value attr' '
 '
 
 test_expect_success 'check unspecified attr' '
-	cat <<-EOF >expect &&
+	cat <<-\EOF >expect &&
 	.gitattributes
 	fileA
 	fileAB
@@ -119,7 +119,7 @@ test_expect_success 'check unspecified attr' '
 '
 
 test_expect_success 'check multiple unspecified attr' '
-	cat <<-EOF >expect &&
+	cat <<-\EOF >expect &&
 	.gitattributes
 	fileC
 	fileNoLabel
@@ -133,7 +133,7 @@ test_expect_success 'check multiple unspecified attr' '
 '
 
 test_expect_success 'check label with more labels but excluded path' '
-	cat <<-EOF >expect &&
+	cat <<-\EOF >expect &&
 	fileAB
 	fileB
 	fileBC
@@ -143,7 +143,7 @@ test_expect_success 'check label with more labels but excluded path' '
 '
 
 test_expect_success 'check label excluding other labels' '
-	cat <<-EOF >expect &&
+	cat <<-\EOF >expect &&
 	fileAB
 	fileB
 	fileBC

-- 
2.12.0.246.ga2ecc84866-goog

