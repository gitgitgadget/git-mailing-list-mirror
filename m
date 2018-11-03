Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BEDD1F453
	for <e@80x24.org>; Sat,  3 Nov 2018 15:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeKDAmk (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 20:42:40 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38330 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbeKDAmk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 20:42:40 -0400
Received: by mail-lj1-f196.google.com with SMTP id q186-v6so4278720ljb.5
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 08:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fi8sXRJwxu4f5vI+RW1APEhf0Z0ggiarYfUbtJ524/4=;
        b=nV2TSNBRjdT6cyA20n6ws9OQXmqVzXjGlxA1f+dTJVwdpOT++2kLOSWCl45YlEAtoG
         dDYW9LlIFRyyXaBdgt0kGckMmzk5NhEPYrxZtrgDo2/UTfGTdeZt9k/XiurS1yoQfT8d
         BPlNthoKjM3z6ifltLJqNZQ1q4/0sKN7e4OBz7VzO8Mm8OrhI/QzZ/QAtKaaDCtd52a+
         bTn0WaadMMzQamLQl0cC295K6UmmgXcYnsHt0Zs94sVI7HPGzaOnjPYev2Btsz1AG9BF
         IgI4tN5HEagREAchu/1hhOmVfXaz06p6NBppn1YOxBZIbC6lUb4z1lHuu1nVU3VYOHmi
         dICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fi8sXRJwxu4f5vI+RW1APEhf0Z0ggiarYfUbtJ524/4=;
        b=s+mWkfOQf3UbnG8n3EySYVxJDx5J8GkRf7vwEpC4FQDn+kbig1xNlXfHK90sKJgnqh
         u+uPtXjiFKvzIltF5vb18aIgbfPIHZiTlqoR8YqhNpJTVGpgF8wXZD/hZwbP0wZeamSh
         wxv5qggo90v0Z/eJjR/X4SXtFMm1Nlkt4bsujI6SKZ0eaKXg0eRJYJhNk+0M9DvFWiyt
         TGhTkD2qLOPXqlsI5dSMoqbQpz9pDm6bKw35EjrRxKkZcOrOxPEARuWkQ51h+dtcb67/
         YP880c/+J9UjDnxlotS/e4xLE3V353zDfZAcoL0fpRUkFjea/lkFBKAvbFOUTyc4/756
         xAEQ==
X-Gm-Message-State: AGRZ1gJEFRpbLnMJoHrqsbIPYjHxE/roPrGH+aCJeAbJ1rxGWyAPa5xp
        w/v+MhKsfGBwK8sBSk8hAp8=
X-Google-Smtp-Source: AJdET5c54bvfQuNstGW5QSEz3mhxBNmCGC0q2YLbt5HpTQ4M8l8gyw4H0Ifm0z9InVFRnBGPJ5UCxQ==
X-Received: by 2002:a2e:b1ca:: with SMTP id e10-v6mr2130864lja.16.1541259059827;
        Sat, 03 Nov 2018 08:30:59 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x1-v6sm1856678ljc.57.2018.11.03.08.30.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 08:30:59 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     christophe.bliard@trux.info
Cc:     git@vger.kernel.org, rafa.almas@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] tree-walk.c: fix overoptimistic inclusion in :(exclude) matching
Date:   Sat,  3 Nov 2018 16:30:49 +0100
Message-Id: <20181103153049.22850-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1005.gac84295441
In-Reply-To: <CAGOLd-5Gbt6fQTvm+7018uX+8WF7NUWpa1sFWAg3-5bxtmOt-Q@mail.gmail.com>
References: <CAGOLd-5Gbt6fQTvm+7018uX+8WF7NUWpa1sFWAg3-5bxtmOt-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tree_entry_interesting() is used for matching pathspec on a tree. The
interesting thing about this function is that, because the tree
entries are known to be sorted, this function can return more than
just "yes, matched" and "no, not matched". It can also say "yes, this
entry is matched and so is the remaining entries in the tree".

This is where I made a mistake when matching exclude pathspec. For
exclude pathspec, we do matching twice, one with positive patterns and
one with negative ones, then a rule table is applied to determine the
final "include or exclude" result. Note that "matched" does not
necessarily mean include. For negative patterns, "matched" means
exclude.

This particular rule is too eager to include everything. Rule 8 says
that "if all entries are positively matched" and the current entry is
not negatively matched (i.e. not excluded), then all entries are
positively matched and therefore included. But this is not true. If
the _current_ entry is not negatively matched, it does not mean the
next one will not be and we cannot conclude right away that all
remaining entries are positively matched and can be included.

Rules 8 and 18 are now updated to be less eager. We conclude that the
current entry is positively matched and included. But we say nothing
about remaining entries. tree_entry_interesting() will be called again
for those entries where we will determine entries individually.

Reported-by: Christophe Bliard <christophe.bliard@trux.info>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 t/t6132-pathspec-exclude.sh | 17 +++++++++++++++++
 tree-walk.c                 | 11 ++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/t/t6132-pathspec-exclude.sh b/t/t6132-pathspec-exclude.sh
index eb829fce97..393b29f205 100755
--- a/t/t6132-pathspec-exclude.sh
+++ b/t/t6132-pathspec-exclude.sh
@@ -194,4 +194,21 @@ test_expect_success 'multiple exclusions' '
 	test_cmp expect actual
 '
 
+test_expect_success 't_e_i() exclude case #8' '
+	git init case8 &&
+	(
+		cd case8 &&
+		echo file >file1 &&
+		echo file >file2 &&
+		git add . &&
+		git commit -m twofiles &&
+		git grep -l file HEAD :^file2 >actual &&
+		echo HEAD:file1 >expected &&
+		test_cmp expected actual &&
+		git grep -l file HEAD :^file1 >actual &&
+		echo HEAD:file2 >expected &&
+		test_cmp expected actual
+	)
+'
+
 test_done
diff --git a/tree-walk.c b/tree-walk.c
index 77b37f36fa..79bafbd1a2 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -1107,7 +1107,7 @@ enum interesting tree_entry_interesting(const struct name_entry *entry,
 	 *   5  |  file |    1     |    1     |   0
 	 *   6  |  file |    1     |    2     |   0
 	 *   7  |  file |    2     |   -1     |   2
-	 *   8  |  file |    2     |    0     |   2
+	 *   8  |  file |    2     |    0     |   1
 	 *   9  |  file |    2     |    1     |   0
 	 *  10  |  file |    2     |    2     |  -1
 	 * -----+-------+----------+----------+-------
@@ -1118,7 +1118,7 @@ enum interesting tree_entry_interesting(const struct name_entry *entry,
 	 *  15  |  dir  |    1     |    1     |   1 (*)
 	 *  16  |  dir  |    1     |    2     |   0
 	 *  17  |  dir  |    2     |   -1     |   2
-	 *  18  |  dir  |    2     |    0     |   2
+	 *  18  |  dir  |    2     |    0     |   1
 	 *  19  |  dir  |    2     |    1     |   1 (*)
 	 *  20  |  dir  |    2     |    2     |  -1
 	 *
@@ -1134,7 +1134,12 @@ enum interesting tree_entry_interesting(const struct name_entry *entry,
 
 	negative = do_match(entry, base, base_offset, ps, 1);
 
-	/* #3, #4, #7, #8, #13, #14, #17, #18 */
+	/* #8, #18 */
+	if (positive == all_entries_interesting &&
+	    negative == entry_not_interesting)
+		return entry_interesting;
+
+	/* #3, #4, #7, #13, #14, #17 */
 	if (negative <= entry_not_interesting)
 		return positive;
 
-- 
2.19.1.1005.gac84295441

