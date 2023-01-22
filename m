Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E271C25B4E
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 16:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjAVQ4e (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Jan 2023 11:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjAVQ4d (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2023 11:56:33 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BD2196B7
        for <git@vger.kernel.org>; Sun, 22 Jan 2023 08:56:32 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id v10so12017180edi.8
        for <git@vger.kernel.org>; Sun, 22 Jan 2023 08:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HzQ1ufQiFYRqmK/lk/x+MMhsGbw7S22XsKQXhaGmPzE=;
        b=kXVxiWHxjMiAmno80jI+qUHN26GU778DDZ6F94BbKvP57qJalLhkMKk5vcw0qIBoIR
         EQUbwbt+ptbZrbAUVuaF4EsAS7mYN0BobSZoeodrXkwg7oaUak/Cl/iaj73lJGk6/4Au
         dBhqWPi4oY0PcmwNZIBKtaGQC2vjmlCqRe43jmiwpeCTalyIFzmrCFNR6t/9reEjcwy8
         85gSC/TsHNh4bF97uDHZsobiZbNOlzLeZB1TVmj5yqEbDAJjzQOElWZuDzkzCbpmcaRK
         jnDioZf2rbSiNqzQksy2kftndMNuzBiDQtTtaauh/BM/OaZP2EuyMGla34QJNrbXl4g4
         H0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HzQ1ufQiFYRqmK/lk/x+MMhsGbw7S22XsKQXhaGmPzE=;
        b=HzdvFzgfadfzEWgFGpe+i2/ACUSyqur0g9D+k1tRDgz4yuauIypdJlBthNamOGDOuK
         iyxwd78RXQaIhVym379WS0yxzuszkz6hl0YGo7wzoqGHaLS5lGiMXtIGNSqjPKHJClaA
         bE3PDzyM9zEwqX/kM9aLiWXPkj0c9CEfmz5SzaQVl30NmQXwLTynVmfUO/THRbFdDmG2
         LtyjKqTbUCJKEc+KcmzpMiptQME/1FW2XyQjonp7dMjvraBKVBnoraQ6lW+ctByClkd/
         8Y8T2EfRXAB03HrIVY1+euAS2PO7Au5J0V0mgf7m6rjYWVTHL9iUE76iRca+DZR/NPie
         r5tw==
X-Gm-Message-State: AFqh2krazVkyrosnrlxx5XhnWhM9XOgSrKezLzs2HBgDySrbjv+LYrcw
        eBViHiLgfHDpwIe2zYSOkwNbX2e36RDGUnPk
X-Google-Smtp-Source: AMrXdXumF0NHMUr0aEe5/YspvUnuxAFC+1euhY3/aC8PXzNWWXnrCMWQvtAFT0zC6Qpzh3QudsePTA==
X-Received: by 2002:a05:6402:32b:b0:49e:ef4:51c3 with SMTP id q11-20020a056402032b00b0049e0ef451c3mr13967429edw.16.1674406590281;
        Sun, 22 Jan 2023 08:56:30 -0800 (PST)
Received: from titov.fritz.box ([212.102.57.98])
        by smtp.gmail.com with ESMTPSA id v17-20020a170906293100b007be301a1d51sm20829299ejd.211.2023.01.22.08.56.29
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 08:56:29 -0800 (PST)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH] Documentation: render dash correctly
Date:   Sun, 22 Jan 2023 17:56:28 +0100
Message-Id: <20230122165628.1601062-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
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
 Documentation/git-apply.txt                          | 2 +-
 Documentation/git-read-tree.txt                      | 2 +-
 Documentation/git.txt                                | 2 +-
 Documentation/technical/hash-function-transition.txt | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

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
-- 
2.39.0

