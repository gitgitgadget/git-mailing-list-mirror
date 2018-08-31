Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B7C81F404
	for <e@80x24.org>; Fri, 31 Aug 2018 20:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbeIAATf (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 20:19:35 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36387 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbeIAATe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 20:19:34 -0400
Received: by mail-wm0-f66.google.com with SMTP id j192-v6so6421086wmj.1
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 13:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=omKI1z34P7Yb4w3ORzLURpXlEaoDbxTWmDpyYl/szcw=;
        b=aBt/Uevf2qGWLlbW6u9P/mU6SPebFwCGKthtvbtmK9T2/t2MtloKqV9f/Zex9VIKac
         /H4D5b1H0OirXhPrF5f/ij5kQUn1H6lbIVBTpkC31bqYZXMjNqxxNSG2JBOOrq23CS+A
         FcNW3lL91WhgYsKNcMmwVzdZPQpRYrvsmMDN/CkQeS7nG/9CTrtAp28a5oH9KecJv5x/
         9V20RCaE98olIcx5jjsq1ShFSjNfiZeVaqgdi9GK87oYxOcA7OaQTK6C5cBI1MsOr1db
         k5hVPpTym5+Mfi7cykOOYK2LNKUgzn9oLWL5MR78Zao5YUI7LGBJKj+MpUd1pe4MjQye
         MZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=omKI1z34P7Yb4w3ORzLURpXlEaoDbxTWmDpyYl/szcw=;
        b=cL2aJDx/LX25WjZY8UaDnvjkmzSGrCoPB/bCYOZabFg7oHQXRZIb2MW7k/O6lExuO5
         mbHaV+1T8Plf2fGSu1JLXHlWIUJXylooXBxEc1aYMaT0OiHjlSugAdbraa3TEV/udxLp
         Pnr7OHAOE0Vb7+FtusEPlxbV5VCkdaVpAKcSHUzvSiCsLQE2s2CR/Q8WeK7WjLRil0LK
         DJk9kI6KxaILbaK6FTVOAbsVjjLQt5Urb6huAtqpxrl/wMRzvD5GMiLG+824sVPwKCbW
         He6B/vXFTdrTuCTYVKba+gMLtQat/XC2vxjASpl8GFPrHFq1hQxkjp5GuADfQS5cXwlO
         9szQ==
X-Gm-Message-State: APzg51CGw8UU4k3VZpLIiMUP2wXuhKu7/KBH8NJZlsE+u8RujymStWkV
        yConXlxLguMuHn+EdYjj+4YUvvwkz6c=
X-Google-Smtp-Source: ANB0VdYGLHeKpGxA4bvpJS57QFA2f2194kEEHDXFfl2v41+g82H9HSZOFsnqFOHeQF64RZGR9TJE0A==
X-Received: by 2002:a1c:5e08:: with SMTP id s8-v6mr5994731wmb.88.1535746228300;
        Fri, 31 Aug 2018 13:10:28 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l16-v6sm4486753wmc.38.2018.08.31.13.10.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 13:10:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Marc Branchaud <marcnarc@xiplink.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 7/9] push doc: correct lies about how push refspecs work
Date:   Fri, 31 Aug 2018 20:10:02 +0000
Message-Id: <20180831201004.12087-8-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1
In-Reply-To: <20180830201244.25759-1-avarab@gmail.com>
References: <20180830201244.25759-1-avarab@gmail.com>
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
 Documentation/git-push.txt     | 52 ++++++++++++++++++++++++++++------
 Documentation/gitrevisions.txt |  7 +++--
 2 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 71c78ac1a4..f345bd30fc 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -74,14 +74,50 @@ without any `<refspec>` on the command line.  Otherwise, missing
 `:<dst>` means to update the same ref as the `<src>`.
 +
 The object referenced by <src> is used to update the <dst> reference
-on the remote side.  By default this is only allowed if <dst> is not
-a tag (annotated or lightweight), and then only if it can fast-forward
-<dst>.  By having the optional leading `+`, you can tell Git to update
-the <dst> ref even if it is not allowed by default (e.g., it is not a
-fast-forward.).
-+
-Pushing an empty <src> allows you to delete the <dst> ref from
-the remote repository.
+on the remote side. Whether this is allowed depends on where in
+`refs/*` the <dst> reference lives as described in detail below, in
+those sections "update" means any modifications except deletes, which
+as noted after the next few sections are treated differently.
++
+The `refs/heads/*` namespace will only accept commit objects, and
+updates only if they can be fast-forwarded.
++
+The `refs/tags/*` namespace will accept any kind of object (as
+commits, trees and blobs can be tagged), and any updates to them will
+be rejected.
++
+It's possible to push any type of object to any namespace outside of
+`refs/{tags,heads}/*`. In the case of tags and commits, these will be
+treated as if they were the commits inside `refs/heads/*` for the
+purposes of whether the update is allowed.
++
+I.e. a fast-forward of commits and tags outside `refs/{tags,heads}/*`
+is allowed, even in cases where what's being fast-forwarded is not a
+commit, but a tag object which happens to point to a new commit which
+is a fast-forward of the commit the last tag (or commit) it's
+replacing. Replacing a tag with an entirely different tag is also
+allowed, if it points to the same commit, as well as pushing a peeled
+tag, i.e. pushing the commit that existing tag object points to, or a
+new tag object which an existing commit points to.
++
+Tree and blob objects outside of `refs/{tags,heads}/*` will be treated
+the same way as if they were inside `refs/tags/*`, any update of them
+will be rejected.
++
+All of the rules described above about what's not allowed as an update
+can be overridden by adding an the optional leading `+` to a refspec
+(or using `--force` command line option). The only exception to this
+is that no amount of forcing will make the `refs/heads/*` namespace
+accept a non-commit object. Hooks and configuration can also override
+or amend these rules, see e.g. `receive.denyNonFastForwards` in
+linkgit:git-config[1] and`pre-receive` and `update` in
+linkgit:githooks[5].
++
+Pushing an empty <src> allows you to delete the <dst> ref from the
+remote repository. Deletions are always accepted without a leading `+`
+in the refspec (or `--force`), except when forbidden by configuration
+or hooks. See `receive.denyDeletes` in linkgit:git-config[1] and
+`pre-receive` and `update` in linkgit:githooks[5].
 +
 The special refspec `:` (or `+:` to allow non-fast-forward updates)
 directs Git to push "matching" branches: for every branch that exists on
diff --git a/Documentation/gitrevisions.txt b/Documentation/gitrevisions.txt
index 1f6cceaefb..d407b7dee1 100644
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
2.19.0.rc1.350.ge57e33dbd1

