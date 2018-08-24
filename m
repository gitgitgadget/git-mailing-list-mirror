Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B83381F404
	for <e@80x24.org>; Fri, 24 Aug 2018 22:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeHYBqm (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 21:46:42 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54884 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbeHYBqm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 21:46:42 -0400
Received: by mail-wm0-f68.google.com with SMTP id c14-v6so2837924wmb.4
        for <git@vger.kernel.org>; Fri, 24 Aug 2018 15:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HkdTPxJ8iwI7biaw9IFzgOqlCaP0AZhlItXjO3dsWjY=;
        b=F2AJEPw6c9dn6/reZVqjcDnhWLz5gW/5pyQUjE5m19Eh6gPMkZfnNUNXDzCm/35TCm
         V6ByFxkKDaVspC0kyiNk9eyTkaNoWSyfiKVQQMcofDWD1+uO47oZsmP5EGhI+n2l1ih7
         5qcQd5G4srhx3ZLnQOZuFIfXrTT3ao2wAiZijaUGHdWzU3kQru1GBTOe94w+WpdXaLoy
         tSewTzVGOxoZbJy0S5btkjYZ87GSiOdv3aItQash2CMHgWpb3ek2AVRCSa2V21d0/Fu3
         JSajyjHwiUuJA1+Da+h8kP6hDhhW8+vgrwzQRqT5akFphviuNiD1ut4M/yrtHgIAWaTc
         P5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HkdTPxJ8iwI7biaw9IFzgOqlCaP0AZhlItXjO3dsWjY=;
        b=J4MafJXG0heq8YFhy37cx3TYnfMX6pOJRyuA0i7XDCKV/8FpX1DlBfC4z0z/SyVg2+
         IQYnKixpClVtZO/NaWPMTboXaomQya80hOgvpPUeGdl0vuydi0kcYMGdH+7lgJUcv/Of
         NdPSdRAnBVevGZIQDi5MhkoAgkq+zpH3iHZEIXdnCM3u4vj3qmVqULs5A0QXbz3ZBgv3
         Goir5rVNQQTXMR5rdYhCVGGc+/F7XehHf3WAEYiYPg6gGtUdh/a8dk/Cgc2BjMVBTNuf
         yArRmuuGc1fsbnlFQj/pNnmxxdKuSH3JL9lQB6SgjLimDdaB1nwtrM9sGyLkk5d6mSLn
         56LQ==
X-Gm-Message-State: APzg51Aq3nHgnaxjezzZGGrUuqAOgB+d0G2L7E6ouXvnJTeB5/Tg7rK9
        v9Vzbw621NH+iYdEN7ro6gsschxU
X-Google-Smtp-Source: ANB0VdYHluA4qQVQyhnLx1WJZXauzZb5pIEWU1EQiGngttf1VKUJZwRr/fuwWqG/Eo9vAqeXtPvrsw==
X-Received: by 2002:a1c:760d:: with SMTP id r13-v6mr2356450wmc.22.1535148609749;
        Fri, 24 Aug 2018 15:10:09 -0700 (PDT)
Received: from localhost ([2.29.27.208])
        by smtp.gmail.com with ESMTPSA id r140-v6sm2998840wmd.7.2018.08.24.15.10.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Aug 2018 15:10:08 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 1/2] rerere: remove documentation for "nested conflicts"
Date:   Fri, 24 Aug 2018 23:10:04 +0100
Message-Id: <20180824221005.5983-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.18.0.1088.ge017bf2cd1
In-Reply-To: <20180824215619.GH13316@hank.intra.tgummerer.com>
References: <20180824215619.GH13316@hank.intra.tgummerer.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

4af32207bc ("rerere: teach rerere to handle nested conflicts",
2018-08-05) introduced slightly better behaviour if the user commits
conflict markers and then gets another conflict in 'git rerere'.
However this is just a heuristic to punt on such conflicts better, and
the documentation might be misleading to users, in case we change the
heuristic in the future.

Remove this documentation to avoid being potentially misleading in the
documentation.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

The original series already made it into 'next', so these patches are
on top of that.  I also see it is marked as "will merge to master" in
the "What's cooking" email, so these two patches would be on top of
that.  If you are not planning to merge the series down to master
before 2.19, we could squash this into 10/11, otherwise I'm happy with
the patches on top.

 Documentation/technical/rerere.txt | 42 ------------------------------
 1 file changed, 42 deletions(-)

diff --git a/Documentation/technical/rerere.txt b/Documentation/technical/rerere.txt
index e65ba9b0c6..3d10dbfa67 100644
--- a/Documentation/technical/rerere.txt
+++ b/Documentation/technical/rerere.txt
@@ -138,45 +138,3 @@ SHA1('B<NUL>C<NUL>').
 If there are multiple conflicts in one file, the sha1 is calculated
 the same way with all hunks appended to each other, in the order in
 which they appear in the file, separated by a <NUL> character.
-
-Nested conflicts
-~~~~~~~~~~~~~~~~
-
-Nested conflicts are handled very similarly to "simple" conflicts.
-Similar to simple conflicts, the conflict is first normalized by
-stripping the labels from conflict markers, stripping the common ancestor
-version, and the sorting the conflict hunks, both for the outer and the
-inner conflict.  This is done recursively, so any number of nested
-conflicts can be handled.
-
-The only difference is in how the conflict ID is calculated.  For the
-inner conflict, the conflict markers themselves are not stripped out
-before calculating the sha1.
-
-Say we have the following conflict for example:
-
-    <<<<<<< HEAD
-    1
-    =======
-    <<<<<<< HEAD
-    3
-    =======
-    2
-    >>>>>>> branch-2
-    >>>>>>> branch-3~
-
-After stripping out the labels of the conflict markers, and sorting
-the hunks, the conflict would look as follows:
-
-    <<<<<<<
-    1
-    =======
-    <<<<<<<
-    2
-    =======
-    3
-    >>>>>>>
-    >>>>>>>
-
-and finally the conflict ID would be calculated as:
-`sha1('1<NUL><<<<<<<\n3\n=======\n2\n>>>>>>><NUL>')`
-- 
2.18.0.1088.ge017bf2cd1

