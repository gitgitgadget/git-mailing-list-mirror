Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9292C433FE
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 15:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiJGPuW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 11:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJGPuU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 11:50:20 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9314C003
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 08:50:13 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r13so7874809wrj.11
        for <git@vger.kernel.org>; Fri, 07 Oct 2022 08:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tbsM9XgZzGRHkDKDQnjqBhF06ZQyB55Zz4XAUs1AmJo=;
        b=AF9nu237nISW2GQaMg5hedu4DwNGdAgFQ2VO1XrhBzma0QvD+WGKyw4BYomVzm36j8
         vgObaSuYl9qsE0YIWQIW5ru2E8Wd99g6I0BFQp/hjkYBiqiBBHbc5b9kvGQa4ix7CXoO
         H4ASlaTcHpYz/Z6RSTpSmruPx2cxvAJ0nYwKdTCtQuDhCs22aMLn+AK/y5oJHsR6dd7B
         i5p4cHKQQHQL94qEwcTIqJCzFZpvLwJMsgC+UYizvfQWI3gBzecwOb6sBfxXF/r0kZt8
         Xlqk35AB6mHCYavZqcP6xRD9kBz+O1V/q/iFOXuTR934UYWuvU0b5nmN2ymu5gmWNMym
         e4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tbsM9XgZzGRHkDKDQnjqBhF06ZQyB55Zz4XAUs1AmJo=;
        b=oNPkjfMwTD/igexWNCBa9TtnL34lVxj2d/esTZw4tqwZ1YTLqNzQlKUDk4exO3ZKfb
         UYxZckA6rxlGlNgfMBo5DRuC2uswEeRPqLPRj+PY2MYokitT8anD6ReRlkOcLkrPRZ5E
         QJTunMi/M9TUSsz4rs5pLAThYZ9KWsL4vmptpNMuxgvcP0MJwbmnxan8hwXEOlB3/IG1
         cohWqBRRGL5hSeSCFtgFswMaC+DpsSAyDP9zxXfsgM8i+Q/E6D8fHOvSNbeOiWRLT/qR
         oH+IrwwCWZfu91dG06HOyqmhPUWn6DFOwyJyENe71AERYXfDt5o/LN+Gw9iIDjs95lOp
         z0bg==
X-Gm-Message-State: ACrzQf0LDPh6ao2Iq8fVHZtjvBCc5ya76juDfGJSmr0cfgsRjb9yZY7Y
        xejaPNrBQmbpd7oo2iLRjOyTdJRmJyo=
X-Google-Smtp-Source: AMsMyM4HsLs9pX1cqry5QHyCZhD4PVt5yifB4vFd7DudS7GnD+H9Wvv3BI3+tyZik3FVun+98UnYbQ==
X-Received: by 2002:a05:6000:2ce:b0:22a:f2dc:1531 with SMTP id o14-20020a05600002ce00b0022af2dc1531mr3838987wry.370.1665157811313;
        Fri, 07 Oct 2022 08:50:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o18-20020a1c7512000000b003b492753826sm2415850wmc.43.2022.10.07.08.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 08:50:10 -0700 (PDT)
Message-Id: <pull.1377.git.1665157810025.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 07 Oct 2022 15:50:09 +0000
Subject: [PATCH] bundle-uri: fix technical doc issues
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, philipoakley@iee.email,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Two documentation issues exist in the technical docs for the bundle URI
feature.

First, there is an extraneous "the" across a linebreak, making the
nonsensical phrase "the bundle the list" which should just be "the
bundle list".

Secondly, the asciidoc update treats the string "`have`s" as starting a
"<code>" block, but the second tick is interpreted as an apostrophe
instead of a closing "</code>" tag. This causes entire sentences to be
formatted as code until the next one comes along. Simply adding a space
here does not work properly as the rendered HTML keeps that space.
Instead, restructure the sentence slightly to avoid using a plural,
allowing the HTML to render correctly.

Reported-by: Philip Oakley <philipoakley@iee.email>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
    bundle-uri: fix technical doc issues
    
    Thanks, Philip, for bringing this to my attention [1]
    
    [1]
    https://lore.kernel.org/git/fb8172a1-004c-1316-7a26-f030d377c141@iee.email/
    
    Thanks,
    
     * Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1377%2Fderrickstolee%2Fbundle-uri-tech-doc-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1377/derrickstolee/bundle-uri-tech-doc-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1377

 Documentation/technical/bundle-uri.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/technical/bundle-uri.txt b/Documentation/technical/bundle-uri.txt
index 18f2dedd400..b78d01d9adf 100644
--- a/Documentation/technical/bundle-uri.txt
+++ b/Documentation/technical/bundle-uri.txt
@@ -153,8 +153,8 @@ bundle.<id>.filter::
 
 bundle.<id>.creationToken::
 	This value is a nonnegative 64-bit integer used for sorting the bundles
-	the list. This is used to download a subset of bundles during a fetch
-	when `bundle.heuristic=creationToken`.
+	list. This is used to download a subset of bundles during a fetch when
+	`bundle.heuristic=creationToken`.
 
 bundle.<id>.location::
 	This string value advertises a real-world location from where the bundle
@@ -234,8 +234,8 @@ will interact with bundle URIs according to the following flow:
    making those OIDs present. When all required OIDs are present, the
    client unbundles that data using a refspec. The default refspec is
    `+refs/heads/*:refs/bundles/*`, but this can be configured. These refs
-   are stored so that later `git fetch` negotiations can communicate the
-   bundled refs as `have`s, reducing the size of the fetch over the Git
+   are stored so that later `git fetch` negotiations can communicate each
+   bundled ref as a `have`, reducing the size of the fetch over the Git
    protocol. To allow pruning refs from this ref namespace, Git may
    introduce a numbered namespace (such as `refs/bundles/<i>/*`) such that
    stale bundle refs can be deleted.

base-commit: 3dcec76d9df911ed8321007b1d197c1a206dc164
-- 
gitgitgadget
