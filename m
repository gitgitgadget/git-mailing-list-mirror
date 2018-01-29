Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F59B1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 22:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752131AbeA2WiF (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:38:05 -0500
Received: from mail-oi0-f73.google.com ([209.85.218.73]:36539 "EHLO
        mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751457AbeA2WiA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:38:00 -0500
Received: by mail-oi0-f73.google.com with SMTP id 75so5991673oie.3
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 14:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=ADwxlnzxQxyHDKS51hPpdAdClVkRtvv5eLMmNbtLU/M=;
        b=Cn7r+TwVyp58StvxSGHF4lUQt3JRNTZUt4muWcBwlFTq6FQ8yXfTh5vrSSj5BjtMtP
         vEBwoZ2jbJZyne3rJzccmIcP0Prhw0bNkCCXpSabWToI4Q9TonaavgyqF/idMZMXfMAK
         yfT6erFg2LznEU3J/2hvzwqMeclE/SpLCcqS8xT+hxif/kj+xd8jBhbbWCxl1gPevupO
         hErClTebFmXxBDE9IqoYpIszCwqfoLPaz7kvsauM2Mc7NRilNStnfL1w2O3yuV3jEUJS
         XZE4JclUvQdBf6oi4rLS3P2a7IygEP8tABNz2FCUAFLUczPb4c/y0jIoF6zng1DgNM7n
         eoQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=ADwxlnzxQxyHDKS51hPpdAdClVkRtvv5eLMmNbtLU/M=;
        b=GHeNM/2t+RnhyacWI/38EBkPyrHH5rNkT+JhL2ot/uv6agNnSFQljHkeGZ91p+L/k4
         jyrBuU6zW85/MJiTCbHwV+K/ItW4e32ZpqTFSySC+CvQ6E8ZY93zEFkSdYZT68XY9+l/
         4EJEDuxJFRNJf4RxhdYFjXjQww1nQKwGbUcTez8cPtmgSBFQokvE0HOL9PF6hWFCmOIz
         OQObsarkv/xAL2VhJ7tKMz1RApYa/Hr5SjQVO8McZOjuV46PadIU0lk/eywpkujAuWl5
         I9qfSXqGCAXJA62Z0gd9bSYEThePqDAaeCvlsUCfTF+LfmDuZ/bcCxazQ9T77RmBwHC4
         Nx/g==
X-Gm-Message-State: AKwxytc0PsiDd0ARsGF8yaXlKpjNdQ3ua2w+DlgA6lST+o3KOmm0cBX7
        U5wBz4viKT3rMiVfUldOo8ATaTPqDW4i1ZxEKJGKs4zNjolQ8hmhNXeBTFygxaaX+hJLSExYj0z
        fH79UUcCncD3Y1pQoeGDLTabEiHl/EKxeMoHWKBmpNF1J4kDtEWKfsRefOg==
X-Google-Smtp-Source: AH8x224F0U1Y+N0iNmdNZwzvs1xZW9wiCDkpC/lMtfDfzqG9LmGT4aZaGU8eLnJEVnkwngjAslQuIegjhoI=
MIME-Version: 1.0
X-Received: by 10.202.92.67 with SMTP id q64mr16750566oib.80.1517265479951;
 Mon, 29 Jan 2018 14:37:59 -0800 (PST)
Date:   Mon, 29 Jan 2018 14:36:59 -0800
In-Reply-To: <20180129223728.30569-1-bmwill@google.com>
Message-Id: <20180129223728.30569-9-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH 08/37] apply: rename 'new' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, avarab@gmail.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 apply.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/apply.c b/apply.c
index 071f653c6..657c73930 100644
--- a/apply.c
+++ b/apply.c
@@ -2301,7 +2301,7 @@ static void update_pre_post_images(struct image *preimage,
 				   size_t len, size_t postlen)
 {
 	int i, ctx, reduced;
-	char *new, *old, *fixed;
+	char *new_buf, *old, *fixed;
 	struct image fixed_preimage;
 
 	/*
@@ -2329,18 +2329,18 @@ static void update_pre_post_images(struct image *preimage,
 	 */
 	old = postimage->buf;
 	if (postlen)
-		new = postimage->buf = xmalloc(postlen);
+		new_buf = postimage->buf = xmalloc(postlen);
 	else
-		new = old;
+		new_buf = old;
 	fixed = preimage->buf;
 
 	for (i = reduced = ctx = 0; i < postimage->nr; i++) {
 		size_t l_len = postimage->line[i].len;
 		if (!(postimage->line[i].flag & LINE_COMMON)) {
 			/* an added line -- no counterparts in preimage */
-			memmove(new, old, l_len);
+			memmove(new_buf, old, l_len);
 			old += l_len;
-			new += l_len;
+			new_buf += l_len;
 			continue;
 		}
 
@@ -2365,21 +2365,21 @@ static void update_pre_post_images(struct image *preimage,
 
 		/* and copy it in, while fixing the line length */
 		l_len = preimage->line[ctx].len;
-		memcpy(new, fixed, l_len);
-		new += l_len;
+		memcpy(new_buf, fixed, l_len);
+		new_buf += l_len;
 		fixed += l_len;
 		postimage->line[i].len = l_len;
 		ctx++;
 	}
 
 	if (postlen
-	    ? postlen < new - postimage->buf
-	    : postimage->len < new - postimage->buf)
+	    ? postlen < new_buf - postimage->buf
+	    : postimage->len < new_buf - postimage->buf)
 		die("BUG: caller miscounted postlen: asked %d, orig = %d, used = %d",
-		    (int)postlen, (int) postimage->len, (int)(new - postimage->buf));
+		    (int)postlen, (int) postimage->len, (int)(new_buf - postimage->buf));
 
 	/* Fix the length of the whole thing */
-	postimage->len = new - postimage->buf;
+	postimage->len = new_buf - postimage->buf;
 	postimage->nr -= reduced;
 }
 
@@ -4163,30 +4163,30 @@ static void show_mode_change(struct patch *p, int show_name)
 static void show_rename_copy(struct patch *p)
 {
 	const char *renamecopy = p->is_rename ? "rename" : "copy";
-	const char *old, *new;
+	const char *old, *new_name;
 
 	/* Find common prefix */
 	old = p->old_name;
-	new = p->new_name;
+	new_name = p->new_name;
 	while (1) {
 		const char *slash_old, *slash_new;
 		slash_old = strchr(old, '/');
-		slash_new = strchr(new, '/');
+		slash_new = strchr(new_name, '/');
 		if (!slash_old ||
 		    !slash_new ||
-		    slash_old - old != slash_new - new ||
-		    memcmp(old, new, slash_new - new))
+		    slash_old - old != slash_new - new_name ||
+		    memcmp(old, new_name, slash_new - new_name))
 			break;
 		old = slash_old + 1;
-		new = slash_new + 1;
+		new_name = slash_new + 1;
 	}
-	/* p->old_name thru old is the common prefix, and old and new
+	/* p->old_name thru old is the common prefix, and old and new_name
 	 * through the end of names are renames
 	 */
 	if (old != p->old_name)
 		printf(" %s %.*s{%s => %s} (%d%%)\n", renamecopy,
 		       (int)(old - p->old_name), p->old_name,
-		       old, new, p->score);
+		       old, new_name, p->score);
 	else
 		printf(" %s %s => %s (%d%%)\n", renamecopy,
 		       p->old_name, p->new_name, p->score);
-- 
2.16.0.rc1.238.g530d649a79-goog

