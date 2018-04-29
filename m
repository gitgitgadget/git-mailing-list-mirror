Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E35141F428
	for <e@80x24.org>; Sun, 29 Apr 2018 20:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754288AbeD2UVf (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 16:21:35 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37362 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754228AbeD2UV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 16:21:28 -0400
Received: by mail-wm0-f65.google.com with SMTP id l1so11167015wmb.2
        for <git@vger.kernel.org>; Sun, 29 Apr 2018 13:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=OqOkrBST17flSYK+vPnmVdPIh6HWZ0X+Ekm7TF9Kso8=;
        b=M/uwY/wbtg/OzefIcbYXRsMeD1zSp1GzkHjqfb/DJ6eIB1cr756LOmduZObCKXi4+F
         VfAki02lgKi/liJIWnMMBM16KvtnbRVRZ5f7xBaSnzAkoxylXvg/zPW3Sn2H6a1p7sDl
         N3zZrJFsw29EvSXH5rgeYK0FA1nnGdUHhW7lPFQ86a381aGhUs6SE1W8/g5oUG2Jp38b
         aPaN5/f/j8RmSL1Rw0TWaJxT6G8BoiPnGG18qWS5qJQQ+2To1c+0u09SyGwPUruSRbPF
         9gm147qpIpLc+M2SX2AQ28JJ4po6o85ZgjByhjpPFejZpLXl238/SzLzqtTiOzGwwTPS
         Y68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OqOkrBST17flSYK+vPnmVdPIh6HWZ0X+Ekm7TF9Kso8=;
        b=t7KkN3QPR4PdlJJ/f8ZGUmdMoMwNdfNbb+RixYVrm6LYQVbmKutFOPWjst02cKQnKL
         aLmU+nnr85TtLlC4YyuAGmfuSVZ1D0X+C2rSB2f+J1MW08v707Ql4wZCA9pY7zl1M0y1
         ozuT7/Ek9DCEwFiW/LQ2fsuqkWATSmqwdDjy27fxdL9VhW2fInfLc9YeDCECna9ivIir
         W+SwZo+tEG1ew8hpQK93q4VPMaDncZ3JzxVZ6W561Q330LrWMrW7dfbowE9KfP+TIY8m
         Jigj950rq+5FcFZnYmxxMmyNMQg/YgWLAUhMd1y8lmmooPpx/THtcNAHjS/FAdJNMrwZ
         lzew==
X-Gm-Message-State: ALQs6tBVVdmOq+DTbjd2T9+5Ev06IlcFgYlrvBkHj0Qd4E74LeJ1XJAY
        2hGPSVPK8FBDbRjAqRbDGV69pL9V
X-Google-Smtp-Source: AB8JxZrIWJMv9EnKN/jaUNYQD1waXjnV2jjghJCKK8hCkg9RZkziamplYDYtm4YeemclLbRfS7JpRA==
X-Received: by 10.28.105.15 with SMTP id e15mr5611182wmc.34.1525033286862;
        Sun, 29 Apr 2018 13:21:26 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y42-v6sm8134917wry.21.2018.04.29.13.21.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Apr 2018 13:21:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/8] push doc: correct lies about how push refspecs work
Date:   Sun, 29 Apr 2018 20:20:57 +0000
Message-Id: <20180429202100.32353-6-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180429202100.32353-1-avarab@gmail.com>
References: <20180429202100.32353-1-avarab@gmail.com>
In-Reply-To: <CACBZZX7HFnEMD8PKWj0c7VWqv=yeYCXYJjy-5YPZnF_pJAy0jw@mail.gmail.com>
References: <CACBZZX7HFnEMD8PKWj0c7VWqv=yeYCXYJjy-5YPZnF_pJAy0jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's complex rules governing whether a push is allowed to take
place depending on whether we're pushing to refs/heads/*, refs/tags/*
or refs/not-that/*. See is_branch() in refs.c, and the various
assertions in refs/files-backend.c. (e.g. "trying to write non-commit
object %s to branch '%s'").

This documentation has never been quite correct, but went downhill
after dbfeddb12e ("push: require force for refs under refs/tags/",
2012-11-29) when we started claiming that <dst> couldn't be a tag
object, which is incorrect. After some of the logic in that patch was
changed in 256b9d70a4 ("push: fix "refs/tags/ hierarchy cannot be
updated without --force"", 2013-01-16) the docs weren't updated, and
we've had some version of documentation that confused whether <src>
was a tag or not with whether <dst> would accept either an annotated
tag object or the commit it points to.

This makes the intro somewhat more verbose & complex, perhaps we
should have a shorter description here and split the full complexity
into a dedicated section. Very few users will find themselves needing
to e.g. push blobs or trees to refs/custom-namespace/* (or blobs or
trees at all), and that could be covered separately as an advanced
topic.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-push.txt     | 30 ++++++++++++++++++++++--------
 Documentation/gitrevisions.txt |  7 ++++---
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 5b08302fc2..806c3d8c65 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -60,8 +60,10 @@ OPTIONS[[OPTIONS]]
 	by a colon `:`, followed by the destination ref <dst>.
 +
 The <src> is often the name of the branch you would want to push, but
-it can be any arbitrary "SHA-1 expression", such as `master~4` or
-`HEAD` (see linkgit:gitrevisions[7]).
+it can be any arbitrary "SHA-1 expression" referring to a branch, such
+as `master~4` or `HEAD` (see linkgit:gitrevisions[7]). It can also
+refer to tag objects, trees or blobs if the <dst> is outside of
+`refs/heads/*`.
 +
 The <dst> tells which ref on the remote side is updated with this
 push. Arbitrary expressions cannot be used here, an actual ref must
@@ -74,12 +76,24 @@ without any `<refspec>` on the command line.  Otherwise, missing
 `:<dst>` means to update the same ref as the `<src>`.
 +
 The object referenced by <src> is used to update the <dst> reference
-on the remote side.  By default this is only allowed if <dst> is not
-a tag (annotated or lightweight), and then only if it can fast-forward
-<dst>.  By having the optional leading `+`, you can tell Git to update
-the <dst> ref even if it is not allowed by default (e.g., it is not a
-fast-forward.)  This does *not* attempt to merge <src> into <dst>.  See
-EXAMPLES below for details.
+on the remote side. Whether this is allowed depends on what where in
+`refs/*` the <dst> reference lives. The `refs/heads/*` namespace will
+only accept commit objects, and then only they can be
+fast-forwarded. The `refs/tags/*` namespace will accept any kind of
+object, but there commit objects are known as lightweight tags, and
+any changes to them and others types of objects will be
+rejected. Finally and most confusingly, it's possible to push any type
+of object to any namespace outside of `refs/{tags,heads}/*`, but these
+will be treated as branches, even in the case where a tag object is
+pushed. That tag object will be overwritten by another tag object (or
+commit!) without `--force` if the new tag happens to point to a commit
+that's a fast-forward of the commit it replaces.
++
+By having the optional leading `+`, you can tell Git to update the
+<dst> ref even if it is not allowed by its respective namespace
+clobbering rules (e.g., it is not a fast-forward. in the case of
+`refs/heads/*` updates) This does *not* attempt to merge <src> into
+<dst>.  See EXAMPLES below for details.
 +
 `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.
 +
diff --git a/Documentation/gitrevisions.txt b/Documentation/gitrevisions.txt
index 27dec5b91d..1b79cf1634 100644
--- a/Documentation/gitrevisions.txt
+++ b/Documentation/gitrevisions.txt
@@ -19,9 +19,10 @@ walk the revision graph (such as linkgit:git-log[1]), all commits which are
 reachable from that commit. For commands that walk the revision graph one can
 also specify a range of revisions explicitly.
 
-In addition, some Git commands (such as linkgit:git-show[1]) also take
-revision parameters which denote other objects than commits, e.g. blobs
-("files") or trees ("directories of files").
+In addition, some Git commands (such as linkgit:git-show[1] and
+linkgit:git-push[1]) can also take revision parameters which denote
+other objects than commits, e.g. blobs ("files") or trees
+("directories of files").
 
 include::revisions.txt[]
 
-- 
2.17.0.290.gded63e768a

