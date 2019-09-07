Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A49E01F461
	for <e@80x24.org>; Sat,  7 Sep 2019 14:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403863AbfIGONU (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 10:13:20 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32976 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391011AbfIGONT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Sep 2019 10:13:19 -0400
Received: by mail-lj1-f193.google.com with SMTP id a22so8644756ljd.0
        for <git@vger.kernel.org>; Sat, 07 Sep 2019 07:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mmbt82z6qlumMJEhVZeHBxoaqkysoIgb93tl4ZU3h9o=;
        b=m7VusFGyCAuCLlr9i4CSc2suaObZ0RkIJCpKH3WnsSfsIf94jeDk+9y6ztYopC6jtt
         oIh4gXZwI0kNAQChKbHE4H3ugAgQ5MVMmSLaCuwD4dIFJo9EQ1sGpmcDvLDbGfMeoVFd
         erYrHdnabWSKXcvFkEGOu2/enN3GM0LkcwsDOQRHiqp+Xucp5TyM6PWpZwRVbaJKGMUi
         N6K4EyM8xBODmN0gnW57Iu4ZcwEj5GtqEjfuZU0hgQdwWVAm78sz8e5+rX7IZ7TPKvaB
         53shvX866W781eF0vtxjNkqKJYl6SWKmYDIDFFGlF368nxqtS/MxM32Ef5G7Hc+jUQZW
         1WfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mmbt82z6qlumMJEhVZeHBxoaqkysoIgb93tl4ZU3h9o=;
        b=mddA1y49rWYJ6vC0HbeyGtu7c6DL1QQ+CaCOymMInJ+rn9ucILGQnRJlVSRUMJ1HnR
         qIA7/XoFwHnOvHGTIDk/7pyC8+GFmJGWVzrPO0SU6gD+jaDZndjWTAZmcHEH2JJXsNIL
         E9Lu20at0F+O0gLl1+4tb2hPLpsoLrKJ88xxhKw3n+wSheswat67T/htNFNNp4urMRT9
         tODMejOkdH1/6r+nnIhCVH+CtNeLyInCfmupGzRJBiJb9sz9D+LzeoMxJrvSSEhiBNnZ
         Q1A91Ky51rottfWyNIdDoiSzi8hazTtAApSyDlw4EIR/04AWefaH6wGriZVCsImL/+NS
         FcEw==
X-Gm-Message-State: APjAAAUVutRUftyEJRbhzJjKH2T432F6gdSJZFHq6zokyP+GQ+be6xhM
        HoMqtLE/dCHHaOyDHTgcIoRZEvwa
X-Google-Smtp-Source: APXvYqyhGfLJPJ0TL/tuoZXFCxxMigN3XCWk7cFv8QSw6jR65KYqqrT8ZSZ2KYDG8G6tN85bVg4VGg==
X-Received: by 2002:a2e:6e1a:: with SMTP id j26mr9405870ljc.172.1567865596950;
        Sat, 07 Sep 2019 07:13:16 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id u10sm1741316lfk.34.2019.09.07.07.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 07:13:16 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 2/7] git-merge-base.txt: render indentations correctly under Asciidoctor
Date:   Sat,  7 Sep 2019 16:12:48 +0200
Message-Id: <4c548f2fcea3db674a70973ef6ce46b6f1095dfe.1567707999.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1567707999.git.martin.agren@gmail.com>
References: <cover.1567707999.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are several graphs in this document. For most of them, we use a
single leading tab to indent the whole graph, and then we use spaces
(possibly eight or more) to align things within the graph.

In the larger graph, we use a different strategy: We use 1-N tabs and
just a small number of spaces (<8). This is how we usually prefer to do
our indenting, but Asciidoctor ends up rendering this differently from
AsciiDoc. Same thing for the if-then-fi examples where the conditional
code is indented by two tabs, which renders differently under AsciiDoc
and Asciidoctor.

Similar to 379805051d ("Documentation: render revisions correctly under
Asciidoctor", 2018-05-06), use an explicit literal block to indicate
that we want to keep the leading whitespace in the tables. Change not
just the ones that render differently, but all of them for consistency.

Because this gives us some extra indentation, we can remove the one that
we have been carrying explicitly. That is, drop the first tab of
indentation on each line. With AsciiDoc, this results in identical
rendering before and after this commit, both for git-merge-base.1 and
git-merge-base.html.

A less intrusive change would be to replace tabs 2-N on each line with
eight spaces. But let's follow the example set by 379805051d, so that we
can use our preferred way of indenting.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-merge-base.txt | 98 +++++++++++++++++++-------------
 1 file changed, 57 insertions(+), 41 deletions(-)

diff --git a/Documentation/git-merge-base.txt b/Documentation/git-merge-base.txt
index 9f07f4f6ed..411dca308b 100644
--- a/Documentation/git-merge-base.txt
+++ b/Documentation/git-merge-base.txt
@@ -80,9 +80,11 @@ which is reachable from both 'A' and 'B' through the parent relationship.
 
 For example, with this topology:
 
-	         o---o---o---B
-	        /
-	---o---1---o---o---o---A
+....
+	 o---o---o---B
+	/
+---o---1---o---o---o---A
+....
 
 the merge base between 'A' and 'B' is '1'.
 
@@ -90,21 +92,25 @@ Given three commits 'A', 'B' and 'C', `git merge-base A B C` will compute the
 merge base between 'A' and a hypothetical commit 'M', which is a merge
 between 'B' and 'C'.  For example, with this topology:
 
-	       o---o---o---o---C
-	      /
-	     /   o---o---o---B
-	    /   /
-	---2---1---o---o---o---A
+....
+       o---o---o---o---C
+      /
+     /   o---o---o---B
+    /   /
+---2---1---o---o---o---A
+....
 
 the result of `git merge-base A B C` is '1'.  This is because the
 equivalent topology with a merge commit 'M' between 'B' and 'C' is:
 
 
-	       o---o---o---o---o
-	      /                 \
-	     /   o---o---o---o---M
-	    /   /
-	---2---1---o---o---o---A
+....
+       o---o---o---o---o
+      /                 \
+     /   o---o---o---o---M
+    /   /
+---2---1---o---o---o---A
+....
 
 and the result of `git merge-base A M` is '1'.  Commit '2' is also a
 common ancestor between 'A' and 'M', but '1' is a better common ancestor,
@@ -116,11 +122,13 @@ the best common ancestor of all commits.
 When the history involves criss-cross merges, there can be more than one
 'best' common ancestor for two commits.  For example, with this topology:
 
-	---1---o---A
-	    \ /
-	     X
-	    / \
-	---2---o---o---B
+....
+---1---o---A
+    \ /
+     X
+    / \
+---2---o---o---B
+....
 
 both '1' and '2' are merge-bases of A and B.  Neither one is better than
 the other (both are 'best' merge bases).  When the `--all` option is not given,
@@ -131,18 +139,22 @@ and B is (or at least used to be) to compute the merge base between
 A and B, and check if it is the same as A, in which case, A is an
 ancestor of B.  You will see this idiom used often in older scripts.
 
-	A=$(git rev-parse --verify A)
-	if test "$A" = "$(git merge-base A B)"
-	then
-		... A is an ancestor of B ...
-	fi
+....
+A=$(git rev-parse --verify A)
+if test "$A" = "$(git merge-base A B)"
+then
+	... A is an ancestor of B ...
+fi
+....
 
 In modern git, you can say this in a more direct way:
 
-	if git merge-base --is-ancestor A B
-	then
-		... A is an ancestor of B ...
-	fi
+....
+if git merge-base --is-ancestor A B
+then
+	... A is an ancestor of B ...
+fi
+....
 
 instead.
 
@@ -154,13 +166,15 @@ topic origin/master`, the history of remote-tracking branch
 `origin/master` may have been rewound and rebuilt, leading to a
 history of this shape:
 
-	                 o---B2
-	                /
-	---o---o---B1--o---o---o---B (origin/master)
-	        \
-	         B0
-	          \
-	           D0---D1---D (topic)
+....
+		 o---B2
+		/
+---o---o---B1--o---o---o---B (origin/master)
+	\
+	 B0
+	  \
+	   D0---D1---D (topic)
+....
 
 where `origin/master` used to point at commits B0, B1, B2 and now it
 points at B, and your `topic` branch was started on top of it back
@@ -193,13 +207,15 @@ will find B0, and
 will replay D0, D1 and D on top of B to create a new history of this
 shape:
 
-			 o---B2
-			/
-	---o---o---B1--o---o---o---B (origin/master)
-		\                   \
-		 B0                  D0'--D1'--D' (topic - updated)
-		  \
-		   D0---D1---D (topic - old)
+....
+		 o---B2
+		/
+---o---o---B1--o---o---o---B (origin/master)
+	\                   \
+	 B0                  D0'--D1'--D' (topic - updated)
+	  \
+	   D0---D1---D (topic - old)
+....
 
 A caveat is that older reflog entries in your repository may be
 expired by `git gc`.  If B0 no longer appears in the reflog of the
-- 
2.23.0

