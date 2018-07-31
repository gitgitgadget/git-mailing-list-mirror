Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A23B51F597
	for <e@80x24.org>; Tue, 31 Jul 2018 13:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732244AbeGaOsC (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 10:48:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35839 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731962AbeGaOsB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 10:48:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id a3-v6so16576550wrt.2
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 06:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TKUIcgW6B3ZENH1ufM7IqW4jrUQ2M+NSC2He/Nkvb8g=;
        b=cambFB0mwt3oOsv3fe01M1Gr/K+bofOXExHTonw1kC2sIPpbv/vh5PVZKHgVJ4vwlM
         bj7hkEXzvVriVcECdmOFbboivR2UomZskInyEpV2ZyKbei6+0fV3OgIBOyG/LiLSDqDy
         9gP2d44PJqVkBI80AVqZB9y/fTYyQ2Qw14R0lvN/Fxyiz+fpGlAuNTXUGwJmM72naeU6
         iWVfA3IeaBVeVZXnurLKQmaAPmsH/Hhjyi9HlV6WKuCGhjIfO0GJI9ZufN/rCdT2fCqC
         Q/7OXh9+0LwUWsO6OYeaFjXy+696NGPEgLPDJPSGXfI6aA14uZkG8R16kyaZhW/khH9i
         7Aqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TKUIcgW6B3ZENH1ufM7IqW4jrUQ2M+NSC2He/Nkvb8g=;
        b=fAcq9LmFnnNeErxnWfCpK1OXmaIBP+yWBJFl81DWqDk3sbMdi6OD6nTbNDiTQ7xVX9
         dI+BoxzNhXPFcWObMU8g+vz3EIlU3rw1HQD5B951k5ua+l7sSxmf62dkLjPCqlJWbQBq
         0V0xJyxF51/LzLnW0khRX4rbDmJqRArmuiLtmIOjENKoQj0vx+XUAhvAieesmQJLilLX
         YgaJd8C1tA3JLnqsY85soye7YBQh1OuZHYLGTfzqBsavlrHky9k1dZ49I6hG0nv29vnS
         qkaw7V2B2P7b1+xiXg7HcQr12aJPZNT06LDfl+vcIHJ93AR6yL+5eto3UpzQk8k58Ibk
         fmZQ==
X-Gm-Message-State: AOUpUlHWP+C0lUW5uJcJeT02MVGRL5VckJLX9s5iNrgmc6/A+Qssr3f/
        YHiO8EMC2YJoy2KIYDrB4u9mhYuehLg=
X-Google-Smtp-Source: AAOMgpf8W5MqfVx1qKeSO5+cKTQNthmGtOHJ6eIhrwxkOp6RTmQZVrtN45E+SSzhV1le47JbTsUsRA==
X-Received: by 2002:adf:f485:: with SMTP id l5-v6mr3267200wro.259.1533042464722;
        Tue, 31 Jul 2018 06:07:44 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id p25-v6sm894081wmc.29.2018.07.31.06.07.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 06:07:43 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/10] push doc: correct lies about how push refspecs work
Date:   Tue, 31 Jul 2018 13:07:14 +0000
Message-Id: <20180731130718.25222-7-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3
In-Reply-To: <20180429202100.32353-1-avarab@gmail.com>
References: <20180429202100.32353-1-avarab@gmail.com>
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
index 55277a9781..fe654482dc 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -60,8 +60,9 @@ OPTIONS[[OPTIONS]]
 	by a colon `:`, followed by the destination ref <dst>.
 +
 The <src> is often the name of the branch you would want to push, but
-it can be any arbitrary "SHA-1 expression", such as `master~4` or
-`HEAD` (see linkgit:gitrevisions[7]).
+it can be any arbitrary expression to a commit, such as `master~4` or
+`HEAD` (see linkgit:gitrevisions[7]). It can also refer to tag
+objects, trees or blobs if the <dst> is outside of `refs/heads/*`.
 +
 The <dst> tells which ref on the remote side is updated with this
 push. Arbitrary expressions cannot be used here, an actual ref must
@@ -74,12 +75,25 @@ without any `<refspec>` on the command line.  Otherwise, missing
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
+`refs/*` the <dst> reference lives. The `refs/heads/*` namespace will
+only accept commit objects, and then only they can be
+fast-forwarded. The `refs/tags/*` namespace will accept any kind of
+object, and any changes to them and others types of objects will be
+rejected. Finally, it's possible to push any type of object to any
+namespace outside of `refs/{tags,heads}/*`, but these will be treated
+as branches for the purposes of whether `--force` is required, even in
+the case where a tag object is pushed. That tag object will be
+overwritten by another tag object (or commit!) without `--force` if
+the new tag happens to point to a commit that's a fast-forward of the
+commit it replaces.
++
+By having the optional leading `+` to a refspec (or using `--force`
+command line option) you can tell Git to update the <dst> ref even if
+it is not allowed by its respective namespace clobbering rules (e.g.,
+it is not a fast-forward. in the case of `refs/heads/*` updates) This
+does *not* attempt to merge <src> into <dst>.  See EXAMPLES below for
+details.
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
2.18.0.345.g5c9ce644c3

