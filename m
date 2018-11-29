Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6E7C211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 21:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbeK3JGM (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 04:06:12 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38874 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeK3JGL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 04:06:11 -0500
Received: by mail-lf1-f68.google.com with SMTP id p86so2634027lfg.5
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 13:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RoLYRYXpQHqKfYd5P+dsZAZkWkcWeO86aiadkVL2ZJQ=;
        b=FVh6MjrudroKHrCiDINu/Kp28/gthqTDNPrMFLf7ck8kb1c4GA6GTPPfQU0tH98gUc
         rszmPgVq03SJwQNTEHt217uwND/TAdp3Db30zGlK0A756/sj80HBac4HlDQOEFYSkzRF
         4WK8LfnjOqV2oXGCTu3vCdjoHGNg05ynHJL3QjyDRqAxzhpUJiBNx9lhSlGC8TQcYdUl
         0ND7av3+tnvjsg3w9KvJ1uASIzOyDYmltn1qvFqJwN8w2ywqp2iKvYhcN8rfehbHkEcg
         bg1Zgjw9s6BliW4ghOSQBR6VN0/20gNyAAckEjsbd9vwFDVAbeVeMXnrRCVWONHrP0Fc
         pbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RoLYRYXpQHqKfYd5P+dsZAZkWkcWeO86aiadkVL2ZJQ=;
        b=JwU5KuS6wae7LooPbMr5qG+hp9KHjhEwTX8KOolX46RTVr+X47zPAofDZfUkWll5t1
         DkGj7mRm9wILIn1usnGE3T2AniEEFZfhhP7Y3+Oy7l4FWY8wx82arVB4vTo12bsTyBzz
         MCpdHaNy57ruuc3gR5inrHg0+8s5uVPozJ60r96zD5yLonJTpKGje8MkZhYU0wDrJ0+B
         7h9MB/GVXDsSyqfjl1P34nkR74XoB8UdFqy6Cx8R/kaNf8RN6MI48zvRpbLFuV14d9O6
         jLMKcWE13J0EO1s0O3HaDjhiJ8CwBXrCXPdsQ4zv0DtPHRasXGuMwTAyHt/38swN87gC
         T0zg==
X-Gm-Message-State: AA+aEWYrG1JomOsZgFCwXKojakJeLlPXx9KH+8KEpAnmZqHqxCkpLUEC
        WouJvE9GMuPsxfJ3mJOHCDYP4Z4v
X-Google-Smtp-Source: AFSGD/XLPaEUoEtpt3l/nyuRLMxqN7ntbjZGCCgEBkXd7vLeU3saRQpzGOeNGzqRXoTJSyOrFvRVmA==
X-Received: by 2002:a19:4d8d:: with SMTP id a135mr2288397lfb.80.1543528754506;
        Thu, 29 Nov 2018 13:59:14 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id o17sm489703lff.77.2018.11.29.13.59.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 13:59:13 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sbeller@google.com, t.gummerer@gmail.com, sxenos@google.com
Subject: [PATCH v3 02/14] git-checkout.txt: split detached head section out
Date:   Thu, 29 Nov 2018 22:58:37 +0100
Message-Id: <20181129215850.7278-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1.380.g3eb999425c.dirty
In-Reply-To: <20181129215850.7278-1-pclouds@gmail.com>
References: <20181127165211.24763-1-pclouds@gmail.com>
 <20181129215850.7278-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is to be reused by the coming git-switch-branch.txt man page
which also deals with detached HEAD.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/detach-head.txt  | 132 ++++++++++++++++++++++++++++++++
 Documentation/git-checkout.txt | 133 +--------------------------------
 2 files changed, 133 insertions(+), 132 deletions(-)
 create mode 100644 Documentation/detach-head.txt

diff --git a/Documentation/detach-head.txt b/Documentation/detach-head.txt
new file mode 100644
index 0000000000..bb6f5d7843
--- /dev/null
+++ b/Documentation/detach-head.txt
@@ -0,0 +1,132 @@
+HEAD normally refers to a named branch (e.g. 'master'). Meanwhile, each
+branch refers to a specific commit. Let's look at a repo with three
+commits, one of them tagged, and with branch 'master' checked out:
+
+------------
+           HEAD (refers to branch 'master')
+            |
+            v
+a---b---c  branch 'master' (refers to commit 'c')
+    ^
+    |
+  tag 'v2.0' (refers to commit 'b')
+------------
+
+When a commit is created in this state, the branch is updated to refer to
+the new commit. Specifically, 'git commit' creates a new commit 'd', whose
+parent is commit 'c', and then updates branch 'master' to refer to new
+commit 'd'. HEAD still refers to branch 'master' and so indirectly now refers
+to commit 'd':
+
+------------
+$ edit; git add; git commit
+
+               HEAD (refers to branch 'master')
+                |
+                v
+a---b---c---d  branch 'master' (refers to commit 'd')
+    ^
+    |
+  tag 'v2.0' (refers to commit 'b')
+------------
+
+It is sometimes useful to be able to checkout a commit that is not at
+the tip of any named branch, or even to create a new commit that is not
+referenced by a named branch. Let's look at what happens when we
+checkout commit 'b' (here we show two ways this may be done):
+
+------------
+$ git checkout v2.0  # or
+$ git checkout master^^
+
+   HEAD (refers to commit 'b')
+    |
+    v
+a---b---c---d  branch 'master' (refers to commit 'd')
+    ^
+    |
+  tag 'v2.0' (refers to commit 'b')
+------------
+
+Notice that regardless of which checkout command we use, HEAD now refers
+directly to commit 'b'. This is known as being in detached HEAD state.
+It means simply that HEAD refers to a specific commit, as opposed to
+referring to a named branch. Let's see what happens when we create a commit:
+
+------------
+$ edit; git add; git commit
+
+     HEAD (refers to commit 'e')
+      |
+      v
+      e
+     /
+a---b---c---d  branch 'master' (refers to commit 'd')
+    ^
+    |
+  tag 'v2.0' (refers to commit 'b')
+------------
+
+There is now a new commit 'e', but it is referenced only by HEAD. We can
+of course add yet another commit in this state:
+
+------------
+$ edit; git add; git commit
+
+         HEAD (refers to commit 'f')
+          |
+          v
+      e---f
+     /
+a---b---c---d  branch 'master' (refers to commit 'd')
+    ^
+    |
+  tag 'v2.0' (refers to commit 'b')
+------------
+
+In fact, we can perform all the normal Git operations. But, let's look
+at what happens when we then checkout master:
+
+------------
+$ git checkout master
+
+               HEAD (refers to branch 'master')
+      e---f     |
+     /          v
+a---b---c---d  branch 'master' (refers to commit 'd')
+    ^
+    |
+  tag 'v2.0' (refers to commit 'b')
+------------
+
+It is important to realize that at this point nothing refers to commit
+'f'. Eventually commit 'f' (and by extension commit 'e') will be deleted
+by the routine Git garbage collection process, unless we create a reference
+before that happens. If we have not yet moved away from commit 'f',
+any of these will create a reference to it:
+
+------------
+$ git checkout -b foo   <1>
+$ git branch foo        <2>
+$ git tag foo           <3>
+------------
+
+<1> creates a new branch 'foo', which refers to commit 'f', and then
+updates HEAD to refer to branch 'foo'. In other words, we'll no longer
+be in detached HEAD state after this command.
+
+<2> similarly creates a new branch 'foo', which refers to commit 'f',
+but leaves HEAD detached.
+
+<3> creates a new tag 'foo', which refers to commit 'f',
+leaving HEAD detached.
+
+If we have moved away from commit 'f', then we must first recover its object
+name (typically by using git reflog), and then we can create a reference to
+it. For example, to see the last two commits to which HEAD referred, we
+can use either of these commands:
+
+------------
+$ git reflog -2 HEAD # or
+$ git log -g -2 HEAD
+------------
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 65bd1bc50d..25887a6087 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -306,138 +306,7 @@ leave out at most one of `A` and `B`, in which case it defaults to `HEAD`.
 
 DETACHED HEAD
 -------------
-HEAD normally refers to a named branch (e.g. 'master'). Meanwhile, each
-branch refers to a specific commit. Let's look at a repo with three
-commits, one of them tagged, and with branch 'master' checked out:
-
-------------
-           HEAD (refers to branch 'master')
-            |
-            v
-a---b---c  branch 'master' (refers to commit 'c')
-    ^
-    |
-  tag 'v2.0' (refers to commit 'b')
-------------
-
-When a commit is created in this state, the branch is updated to refer to
-the new commit. Specifically, 'git commit' creates a new commit 'd', whose
-parent is commit 'c', and then updates branch 'master' to refer to new
-commit 'd'. HEAD still refers to branch 'master' and so indirectly now refers
-to commit 'd':
-
-------------
-$ edit; git add; git commit
-
-               HEAD (refers to branch 'master')
-                |
-                v
-a---b---c---d  branch 'master' (refers to commit 'd')
-    ^
-    |
-  tag 'v2.0' (refers to commit 'b')
-------------
-
-It is sometimes useful to be able to checkout a commit that is not at
-the tip of any named branch, or even to create a new commit that is not
-referenced by a named branch. Let's look at what happens when we
-checkout commit 'b' (here we show two ways this may be done):
-
-------------
-$ git checkout v2.0  # or
-$ git checkout master^^
-
-   HEAD (refers to commit 'b')
-    |
-    v
-a---b---c---d  branch 'master' (refers to commit 'd')
-    ^
-    |
-  tag 'v2.0' (refers to commit 'b')
-------------
-
-Notice that regardless of which checkout command we use, HEAD now refers
-directly to commit 'b'. This is known as being in detached HEAD state.
-It means simply that HEAD refers to a specific commit, as opposed to
-referring to a named branch. Let's see what happens when we create a commit:
-
-------------
-$ edit; git add; git commit
-
-     HEAD (refers to commit 'e')
-      |
-      v
-      e
-     /
-a---b---c---d  branch 'master' (refers to commit 'd')
-    ^
-    |
-  tag 'v2.0' (refers to commit 'b')
-------------
-
-There is now a new commit 'e', but it is referenced only by HEAD. We can
-of course add yet another commit in this state:
-
-------------
-$ edit; git add; git commit
-
-	 HEAD (refers to commit 'f')
-	  |
-	  v
-      e---f
-     /
-a---b---c---d  branch 'master' (refers to commit 'd')
-    ^
-    |
-  tag 'v2.0' (refers to commit 'b')
-------------
-
-In fact, we can perform all the normal Git operations. But, let's look
-at what happens when we then checkout master:
-
-------------
-$ git checkout master
-
-               HEAD (refers to branch 'master')
-      e---f     |
-     /          v
-a---b---c---d  branch 'master' (refers to commit 'd')
-    ^
-    |
-  tag 'v2.0' (refers to commit 'b')
-------------
-
-It is important to realize that at this point nothing refers to commit
-'f'. Eventually commit 'f' (and by extension commit 'e') will be deleted
-by the routine Git garbage collection process, unless we create a reference
-before that happens. If we have not yet moved away from commit 'f',
-any of these will create a reference to it:
-
-------------
-$ git checkout -b foo   <1>
-$ git branch foo        <2>
-$ git tag foo           <3>
-------------
-
-<1> creates a new branch 'foo', which refers to commit 'f', and then
-updates HEAD to refer to branch 'foo'. In other words, we'll no longer
-be in detached HEAD state after this command.
-
-<2> similarly creates a new branch 'foo', which refers to commit 'f',
-but leaves HEAD detached.
-
-<3> creates a new tag 'foo', which refers to commit 'f',
-leaving HEAD detached.
-
-If we have moved away from commit 'f', then we must first recover its object
-name (typically by using git reflog), and then we can create a reference to
-it. For example, to see the last two commits to which HEAD referred, we
-can use either of these commands:
-
-------------
-$ git reflog -2 HEAD # or
-$ git log -g -2 HEAD
-------------
+include::detach-head.txt[]
 
 ARGUMENT DISAMBIGUATION
 -----------------------
-- 
2.20.0.rc1.380.g3eb999425c.dirty

