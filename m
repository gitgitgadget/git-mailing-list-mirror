Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59A281F609
	for <e@80x24.org>; Wed, 28 Nov 2018 19:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbeK2GFS (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 01:05:18 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43568 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbeK2GFS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 01:05:18 -0500
Received: by mail-lf1-f68.google.com with SMTP id u18so20202500lff.10
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 11:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pofh9GX6KhSMLpPtPoWu5t/TumYyHRdjYVfyiUBhy6Q=;
        b=YYusPzY8jNDpVpN+FnbhEKrDuROPuoqNb4FQhhENUlHj89vzxbUW4+K9CwoG34lDg7
         LRTYjsnwpHLQQ6edYEF58znBLnPaPOnT9GdkdmgveXZQvjZr42Zza/K31ykrXO7MVpQy
         S0FsjVeZaSpBAy9KTmDuYB2UqPwdAOpuCM2Rhz9CM7agTH+gV9J/nsC7UzW9cxpbOr/0
         4THX6C40+1fQdjJqYzOqB1ChCYXxKNYRWbGYp9YOoyi9P1aQiRHBBh7sV4ShvdF4eQ6N
         +OgU+DRWHKIQQ+3xysh/HZ2yqTVv37d6O4jVPv5I7H9/D4yHeFbeXuM+scdpJMpYsPUd
         HtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pofh9GX6KhSMLpPtPoWu5t/TumYyHRdjYVfyiUBhy6Q=;
        b=SnTQj8xUVHCXn63Ot3Ob9hCIGN9wtchCVehga7CHAfR2/lpWxHQ/P4Zz8M0UUAH39Q
         U145SZ1ZZuRHykBS4ZnjMezZ0dhJsd2pYvpBn+E94fuVD6LbioBhOAOQVyahNPchfNKD
         XD8h6RsRVKC/9hfGOVXJt3vw2lO2/3H31xcdnMXRn8phDGhDS7DIOb5Ipuk+3gZUuzFn
         qNzgP80wrwSPrKxabSb//NdUIZpmLdPIbN5LnrjJVY4fkOBMR0ZH1imzC1iwrpBdRM+t
         68crL0Bc07aQyOvoDD4jUYJQUwq45vmqelo7r8LEpb2npYefyyeuaJ7rwTnOa6X1tYeg
         anYw==
X-Gm-Message-State: AGRZ1gJurC+yEyV3guJuc8FXKt0ax2YZhwSMGh+zzzWVzxyN2UMq4LfS
        MFLK4VvC0hxvgspjqDXV3snMIQDD
X-Google-Smtp-Source: AJdET5dXzMbZPtz0DJK6HnrMV7lLhzukdjBHhKAK37C/kx7qYmfRK8l+Qccj6ehoiQWrQ2lgQ7PaYg==
X-Received: by 2002:a19:d145:: with SMTP id i66mr23109131lfg.97.1543431757046;
        Wed, 28 Nov 2018 11:02:37 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id 15-v6sm1407330lje.18.2018.11.28.11.02.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 11:02:36 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Pawe=C5=82=20Samoraj?= <samoraj.pawel@gmail.com>
Subject: [PATCH 1/2] git-reset.txt: render tables correctly under Asciidoctor
Date:   Wed, 28 Nov 2018 20:02:09 +0100
Message-Id: <1596a9ff9fa6849f53590de1b15eb18ee6b41e4d.1543429054.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1.8.g46351a2c6f
In-Reply-To: <cover.1543429054.git.martin.agren@gmail.com>
References: <CAN0heSph-a08AzsihqqxfC=nqmUQLsqx-rKGULXQ-gmT4+c10w@mail.gmail.com> <cover.1543429054.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Asciidoctor removes the indentation of each line in these tables, so the
last lines of each table have a completely broken alignment.

Similar to 379805051d ("Documentation: render revisions correctly under
Asciidoctor", 2018-05-06), use an explicit literal block to indicate
that we want to keep the leading whitespace in the tables.

Because this gives us some extra indentation, we can remove the one that
we have been carrying explicitly. That is, drop the first six spaces of
indentation on each line. With Asciidoc (8.6.10), this results in
identical rendering before and after this commit, both for git-reset.1
and git-reset.html.

Reported-by: Paweł Samoraj <samoraj.pawel@gmail.com>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-reset.txt | 140 ++++++++++++++++++++----------------
 1 file changed, 78 insertions(+), 62 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 2dac95c71a..7c925e3a29 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -365,53 +365,65 @@ index in state B.  It resets (i.e. moves) the HEAD (i.e. the tip of
 the current branch, if you are on one) to "target" (which has the file
 in state D).
 
-      working index HEAD target         working index HEAD
-      ----------------------------------------------------
-       A       B     C    D     --soft   A       B     D
-				--mixed  A       D     D
-				--hard   D       D     D
-				--merge (disallowed)
-				--keep  (disallowed)
-
-      working index HEAD target         working index HEAD
-      ----------------------------------------------------
-       A       B     C    C     --soft   A       B     C
-				--mixed  A       C     C
-				--hard   C       C     C
-				--merge (disallowed)
-				--keep   A       C     C
-
-      working index HEAD target         working index HEAD
-      ----------------------------------------------------
-       B       B     C    D     --soft   B       B     D
-				--mixed  B       D     D
-				--hard   D       D     D
-				--merge  D       D     D
-				--keep  (disallowed)
-
-      working index HEAD target         working index HEAD
-      ----------------------------------------------------
-       B       B     C    C     --soft   B       B     C
-				--mixed  B       C     C
-				--hard   C       C     C
-				--merge  C       C     C
-				--keep   B       C     C
-
-      working index HEAD target         working index HEAD
-      ----------------------------------------------------
-       B       C     C    D     --soft   B       C     D
-				--mixed  B       D     D
-				--hard   D       D     D
-				--merge (disallowed)
-				--keep  (disallowed)
-
-      working index HEAD target         working index HEAD
-      ----------------------------------------------------
-       B       C     C    C     --soft   B       C     C
-				--mixed  B       C     C
-				--hard   C       C     C
-				--merge  B       C     C
-				--keep   B       C     C
+....
+working index HEAD target         working index HEAD
+----------------------------------------------------
+ A       B     C    D     --soft   A       B     D
+			  --mixed  A       D     D
+			  --hard   D       D     D
+			  --merge (disallowed)
+			  --keep  (disallowed)
+....
+
+....
+working index HEAD target         working index HEAD
+----------------------------------------------------
+ A       B     C    C     --soft   A       B     C
+			  --mixed  A       C     C
+			  --hard   C       C     C
+			  --merge (disallowed)
+			  --keep   A       C     C
+....
+
+....
+working index HEAD target         working index HEAD
+----------------------------------------------------
+ B       B     C    D     --soft   B       B     D
+			  --mixed  B       D     D
+			  --hard   D       D     D
+			  --merge  D       D     D
+			  --keep  (disallowed)
+....
+
+....
+working index HEAD target         working index HEAD
+----------------------------------------------------
+ B       B     C    C     --soft   B       B     C
+			  --mixed  B       C     C
+			  --hard   C       C     C
+			  --merge  C       C     C
+			  --keep   B       C     C
+....
+
+....
+working index HEAD target         working index HEAD
+----------------------------------------------------
+ B       C     C    D     --soft   B       C     D
+			  --mixed  B       D     D
+			  --hard   D       D     D
+			  --merge (disallowed)
+			  --keep  (disallowed)
+....
+
+....
+working index HEAD target         working index HEAD
+----------------------------------------------------
+ B       C     C    C     --soft   B       C     C
+			  --mixed  B       C     C
+			  --hard   C       C     C
+			  --merge  B       C     C
+			  --keep   B       C     C
+....
 
 "reset --merge" is meant to be used when resetting out of a conflicted
 merge. Any mergy operation guarantees that the working tree file that is
@@ -434,21 +446,25 @@ entries.
 The following tables show what happens when there are unmerged
 entries:
 
-      working index HEAD target         working index HEAD
-      ----------------------------------------------------
-       X       U     A    B     --soft  (disallowed)
-				--mixed  X       B     B
-				--hard   B       B     B
-				--merge  B       B     B
-				--keep  (disallowed)
-
-      working index HEAD target         working index HEAD
-      ----------------------------------------------------
-       X       U     A    A     --soft  (disallowed)
-				--mixed  X       A     A
-				--hard   A       A     A
-				--merge  A       A     A
-				--keep  (disallowed)
+....
+working index HEAD target         working index HEAD
+----------------------------------------------------
+ X       U     A    B     --soft  (disallowed)
+			  --mixed  X       B     B
+			  --hard   B       B     B
+			  --merge  B       B     B
+			  --keep  (disallowed)
+....
+
+....
+working index HEAD target         working index HEAD
+----------------------------------------------------
+ X       U     A    A     --soft  (disallowed)
+			  --mixed  X       A     A
+			  --hard   A       A     A
+			  --merge  A       A     A
+			  --keep  (disallowed)
+....
 
 X means any state and U means an unmerged index.
 
-- 
2.20.0.rc1.8.g46351a2c6f

