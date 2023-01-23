Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F4AC38142
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 09:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjAWJBW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 04:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjAWJBV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 04:01:21 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDEAEB58
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 01:01:18 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id mg12so28605103ejc.5
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 01:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pel2bdzHR0e+v6DTwDiiqrM4SWH0ldeYeTmDNJHkGs4=;
        b=WYwoTDwGnIVoNaDX419zQN6j35KKbjtU3ENYdx1l4baB7vr7sP0QCEhKUUAFllInQX
         NKlXhQnTOdmq+hnn18bBa7d/flrFN8fG4c1HKUFl2YMw2x9dUyDhSReQqZD8LSFe2q9X
         0Ds2GH5mCy5Q/4HU8QB/rLykxSR+mQsgvmBVuqrlYn5mv+GKGeTw/eAkgFYllkzRei2t
         ilyJkIflLknDCKsC2Pt7gUdkUN2GCkL5ZZxQjZ9vrlYJ1kI3cP4h5JScDfGxHR2lu5Pl
         CjKM8Nf5chCFVeE1Li7UuqKxjYPyuLvasUvUg5OkzI3lxpMm3Rskdgi2S7bETZISYAMH
         acrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pel2bdzHR0e+v6DTwDiiqrM4SWH0ldeYeTmDNJHkGs4=;
        b=RAPi4zj5ycigW6IfpsiPhzDEqlqOqJFjKgmdCbdaQrruBeJ7lj8ttMgIv2fdJIKDg5
         tkTkaD6v7WfwUu67ejU6+NQo52xXWg9un9DOJS6UUEXhUdhJPSNauJFGrZQDU8gwCtm3
         UYwbWAz/0zONnFrJXe3AHaTmi5KyNSAgKc/mgiHwzxN695wqKxAa8qTSDqByHkVB4Z9L
         G61Q7xgtoJ7mOxaDT3iwRvMqxHW8WEDXGFhIPTYtPpuNdeEg3oOlnbuTh+h8Q2+vOPsQ
         +slTMk1MFzvl2Gq3UuBn8zOv2kge34gU3jvjaxhtYbergJreAZcl5OYEfPh8kca/cmap
         RzHQ==
X-Gm-Message-State: AFqh2koHXrQg5hSNv1rMBiZXbW4i4mp59FApSGoRA9mqlrdaJPjQqB6O
        W0PNgeynek4fNKFBRq7pTQyh+NF3HXReZqra
X-Google-Smtp-Source: AMrXdXuwPLCfUYnq2aCV5nyFyStiL4K4/enaZxDp1xs3re1ea0I6001phDQ8n6O2KTXq99QlmzLxpg==
X-Received: by 2002:a17:906:354c:b0:86e:2dd4:6655 with SMTP id s12-20020a170906354c00b0086e2dd46655mr22268120eja.51.1674464476806;
        Mon, 23 Jan 2023 01:01:16 -0800 (PST)
Received: from titov.fritz.box ([45.88.97.214])
        by smtp.gmail.com with ESMTPSA id d9-20020a1709063ec900b007bd9e683639sm21668721ejj.130.2023.01.23.01.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 01:01:16 -0800 (PST)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2] Documentation: render dash correctly
Date:   Mon, 23 Jan 2023 10:01:14 +0100
Message-Id: <20230123090114.429844-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230122165628.1601062-1-rybak.a.v@gmail.com>
References: <20230122165628.1601062-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Three hyphens are rendered verbatim in documentation, so "--" has to be
used to produce a dash.  Fix asciidoc output for dashes.  This is
similar to previous commits f0b922473e (Documentation: render special
characters correctly, 2021-07-29) and de82095a95 (doc
hash-function-transition: fix asciidoc output, 2021-02-05).

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---

On 2023-01-23T09:19, Martin Ågren wrote:
> I suspect these were identified by greping for " --- ", spaces included.

Indeed.

> We seem to have some "---" that aren't surrounded by spaces. They're
> perhaps a bit more tedious to find,

Not really:

    git grep -P -i '[^-][a-z0-9]+---[a-z0-9]+[^-]' -- Documentation/

The "[^-]" part is needed to exclude many examples of commit graphs.

The following:

    The horizontal line of history A---Q is taken to be the first parent of each
    merge.

also comes up in 'Documentation/rev-list-options.txt', but it might be better to
leave "A---Q" as is to be similar to the commit graph example above it (there
are commits between A and Q in the graph, but still).

> but I see there are two in
> gitformat-signature.txt and technical/rerere.txt. Maybe it would be
> worthwhile addressing them too in this patch.
> 
> Martin

Thank you for review, here's v2.

Changes from v1:

 - Added two fixes in gitformat-signature.txt and technical/rerere.txt, as
   suggested by Martin Ågren.

 Documentation/git-apply.txt                          | 2 +-
 Documentation/git-read-tree.txt                      | 2 +-
 Documentation/git.txt                                | 2 +-
 Documentation/gitformat-signature.txt                | 2 +-
 Documentation/technical/hash-function-transition.txt | 2 +-
 Documentation/technical/rerere.txt                   | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 1d478cbe9b..5e16e6db7e 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -208,7 +208,7 @@ behavior:
 * `warn` outputs warnings for a few such errors, but applies the
   patch as-is (default).
 * `fix` outputs warnings for a few such errors, and applies the
-  patch after fixing them (`strip` is a synonym --- the tool
+  patch after fixing them (`strip` is a synonym -- the tool
   used to consider only trailing whitespace characters as errors, and the
   fix involved 'stripping' them, but modern Gits do more).
 * `error` outputs warnings for a few such errors, and refuses
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 7567955bad..b09707474d 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -219,7 +219,7 @@ see which of the "local changes" that you made were carried forward by running
 `git diff-index --cached $M`.  Note that this does not
 necessarily match what `git diff-index --cached $H` would have
 produced before such a two tree merge.  This is because of cases
-18 and 19 --- if you already had the changes in $M (e.g. maybe
+18 and 19 -- if you already had the changes in $M (e.g. maybe
 you picked it up via e-mail in a patch form), `git diff-index
 --cached $H` would have told you about the change before this
 merge, but it would not show in `git diff-index --cached $M`
diff --git a/Documentation/git.txt b/Documentation/git.txt
index f9a7a4554c..74973d3cc4 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -613,7 +613,7 @@ The file parameters can point at the user's working file
 (e.g. `new-file` in "git-diff-files"), `/dev/null` (e.g. `old-file`
 when a new file is added), or a temporary file (e.g. `old-file` in the
 index).  `GIT_EXTERNAL_DIFF` should not worry about unlinking the
-temporary file --- it is removed when `GIT_EXTERNAL_DIFF` exits.
+temporary file -- it is removed when `GIT_EXTERNAL_DIFF` exits.
 +
 For a path that is unmerged, `GIT_EXTERNAL_DIFF` is called with 1
 parameter, <path>.
diff --git a/Documentation/gitformat-signature.txt b/Documentation/gitformat-signature.txt
index a249869faf..d8e3eb1bac 100644
--- a/Documentation/gitformat-signature.txt
+++ b/Documentation/gitformat-signature.txt
@@ -37,7 +37,7 @@ line.
 This is even true for an originally empty line.  In the following
 examples, the end of line that ends with a whitespace letter is
 highlighted with a `$` sign; if you are trying to recreate these
-example by hand, do not cut and paste them---they are there
+example by hand, do not cut and paste them--they are there
 primarily to highlight extra whitespace at the end of some lines.
 
 The signed payload and the way the signature is embedded depends
diff --git a/Documentation/technical/hash-function-transition.txt b/Documentation/technical/hash-function-transition.txt
index e2ac36dd21..ed57481089 100644
--- a/Documentation/technical/hash-function-transition.txt
+++ b/Documentation/technical/hash-function-transition.txt
@@ -562,7 +562,7 @@ hash re-encode during clone and to encourage peers to modernize.
 The design described here allows fetches by SHA-1 clients of a
 personal SHA-256 repository because it's not much more difficult than
 allowing pushes from that repository. This support needs to be guarded
-by a configuration option --- servers like git.kernel.org that serve a
+by a configuration option -- servers like git.kernel.org that serve a
 large number of clients would not be expected to bear that cost.
 
 Meaning of signatures
diff --git a/Documentation/technical/rerere.txt b/Documentation/technical/rerere.txt
index 35d4541433..be58f1bee3 100644
--- a/Documentation/technical/rerere.txt
+++ b/Documentation/technical/rerere.txt
@@ -99,7 +99,7 @@ conflict to leave line D means that the user declares:
     compatible with what AB and AC wanted to do.
 
 So the conflict we would see when merging AB into ACAB should be
-resolved the same way---it is the resolution that is in line with that
+resolved the same way--it is the resolution that is in line with that
 declaration.
 
 Imagine that similarly previously a branch XYXZ was forked from XY,
-- 
2.39.0

