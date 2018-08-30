Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E46471F404
	for <e@80x24.org>; Thu, 30 Aug 2018 20:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbeHaAQ4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 20:16:56 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37949 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbeHaAQ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 20:16:56 -0400
Received: by mail-wm0-f66.google.com with SMTP id t25-v6so3226095wmi.3
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 13:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C3Nyt67bfhAKjo4cSBRQCyvYHtKRp8IrNR5oo+tg6iU=;
        b=ozmTSKzqtBuBzDNSqF/9mQBXaAZ3Diw8mKuCt/R5B5KydYsIaFkMcHVIq/qlOoXSbY
         kuwzhvMq0ZKiq0MQ5UNtJ6zW9THBFmiWrjMkDMm5pfmETIQzelQVs6u01xWi4DY9gYSp
         YpkTVmmxYdfTc0fG3GN1GMVCNTE4E7++/EWpCRrA4I/z08xbpWRXMhJlyZhDf8kuWvyb
         XOwAh1ubAKn91lKYm737fowgUpbOSGArkzUCPv9s7LXtW/+FCXmUkwlPHa5l5UgE/sVs
         VeSZ81nHBfSD/nuSAgqxk0TslZNiPPAGNY7QadQ4PuJzgi9ocQc9XYS9YDwL2xTtkpJA
         yofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C3Nyt67bfhAKjo4cSBRQCyvYHtKRp8IrNR5oo+tg6iU=;
        b=VRroiGddSMnu9aWze2wqvi5iq7JhJbFEJBCos7DQpSxsPdEJ8/eyfEVcpewhQnCHsK
         Uqp6TpdLfqBa+hsqUB1lLvYdnmA+lXEbOWChYU3jWR1CYsadhBjuyA/bxKk4CK6pWSv2
         f76C8Sk50a2rxpnZCsNzgtlhNg689e5Sy+HP818ynFW7ciS3gOhO/+Bwx39U9SNmqSnm
         GZ7FyC23qav7DOCS5CoCFkEUBZv5AqZ89fLuXAKwx86gEhfHFjOtAXw2y+T1mKUlMukZ
         zcCn1V51Dvgbz9+N5qFGGwDYawv5QDGJ8AotpPVJttu+R3o58hkuE/F9NLtY6+Wqc3xA
         T3Dg==
X-Gm-Message-State: APzg51AskbOuCL/8C8WQ5tKbCaMHD50X5KJEILg+u1xemV+lo7taaqB4
        B0aeR8PjnZqRoclsK5lZ8I5ca43nBzk=
X-Google-Smtp-Source: ANB0VdYFubqxU6gpkTHpz+nGFlQeJN1LbWimRMeHo/4Ojm8IKekS5S1Lb3KMzgL7FnNZIxdUJHCPbA==
X-Received: by 2002:a1c:c14:: with SMTP id 20-v6mr2939307wmm.117.1535659982439;
        Thu, 30 Aug 2018 13:13:02 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b10-v6sm4903639wrr.88.2018.08.30.13.13.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 13:13:01 -0700 (PDT)
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
        =?UTF-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 4/6] push doc: correct lies about how push refspecs work
Date:   Thu, 30 Aug 2018 20:12:42 +0000
Message-Id: <20180830201244.25759-5-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1
In-Reply-To: <20180813192249.27585-1-avarab@gmail.com>
References: <20180813192249.27585-1-avarab@gmail.com>
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
 Documentation/git-push.txt     | 41 +++++++++++++++++++++++++++++-----
 Documentation/gitrevisions.txt |  7 +++---
 2 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 55277a9781..0f03d36f1e 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -74,12 +74,41 @@ without any `<refspec>` on the command line.  Otherwise, missing
 `:<dst>` means to update the same ref as the `<src>`.
 +
 The object referenced by <src> is used to update the <dst> reference
-on the remote side.  By default this is only allowed if <dst> is not
-a tag (annotated or lightweight), and then only if it can fast-forward
-<dst>.  By having the optional leading `+`, you can tell Git to update
-the <dst> ref even if it is not allowed by default (e.g., it is not a
-fast-forward.)  This does *not* attempt to merge <src> into <dst>.  See
-EXAMPLES below for details.
+on the remote side. Whether this is allowed depends on where in
+`refs/*` the <dst> reference lives as described in detail below. Any
+such update does *not* attempt to merge <src> into <dst>. See EXAMPLES
+below for details.
++
+The `refs/heads/*` namespace will only accept commit objects, and only
+if they can be fast-forwarded.
++
+The `refs/tags/*` namespace will accept any kind of object (as
+commits, trees and blobs can be tagged), and any changes to them will
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
+the same way as if they were inside `refs/tags/*`, any modification of
+them will be rejected.
++
+All of the rules described above about what's not allowed as an update
+can be overridden by adding an the optional leading `+` to a refspec
+(or using `--force` command line option). The only exception to this
+is that no amount of forcing will make the `refs/heads/*` namespace
+accept a non-commit object.
 +
 `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.
 +
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

