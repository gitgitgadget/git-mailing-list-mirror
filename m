Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB61E20248
	for <e@80x24.org>; Fri, 22 Mar 2019 19:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbfCVTBp (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 15:01:45 -0400
Received: from mail-oi1-f202.google.com ([209.85.167.202]:47871 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbfCVTBp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 15:01:45 -0400
Received: by mail-oi1-f202.google.com with SMTP id n84so1286533oia.14
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 12:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KSz58BxTb5teM3FS7ZBwvlIthV6GcG/S7imUNnQJhJE=;
        b=O7BeSweBUklqEuGANMAYiHh7ZpApXT6RR/fgd5vT84wTzfYO8zBPCBo/VAYuaFnDPR
         kXYX5Ftyznc7byG0o1m6eii1t3Z3d/SmNGznvaPPbyEpRFTMb4cV8ceJSBJ2zgx+i/1g
         o/6Mv8nBy0FGGspV77i1y74RIT5T/m/DDj20bIzq6lM8aHb+aP/56W6OoDKTxJ5m/h5Q
         FkUnjwYYnBimumHDMZnkBfq1159TMA0iL0S6MJ+aGXFHGOliVNYsLf28eRpJgnyW2jhg
         ZQenAjd013bieG+n48Bm+m/ySxj7EwjqEHP5YQq+McAFROEhBeREKiCHFRyAyDAAT1mO
         zClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KSz58BxTb5teM3FS7ZBwvlIthV6GcG/S7imUNnQJhJE=;
        b=nKE9iu/HMCZTsKarVp1lFS7H4W7H/3lfHeJ5ALOYnMk7HH/MHJfQZcAnPgwRy+H9os
         0ULf+xbNOCCq9uzYUhcoI9p5GWrO6/3cYiUKk9UTIWfKiYDQTbhOLwVnTLOksu6dqX60
         GhD3mFevbSWKdCLh0NpSHRanUdR5ruy0KM1EwyVTSoFsUW5DT3GqFrNXJ++NTgdZYEsi
         v0hF7hdWASZiyYr1wspaamLlTO/BvZE0qIbA8wrwDf0doBArXIsnmaRrBEzwoSVP7SXg
         XKBAJeLEAmhBgiylqzg2sDg0hspGrCGKOpkTHz6+BgT+3PYkLKCbHZytg3w/4RB8V0SN
         bZcg==
X-Gm-Message-State: APjAAAWekPqxVYqipu/504zey7H1GdQZNoVmlcyDoCx0Bjd46EqtPKEM
        o+5SudRledCmO+dLXxaxn0IEDfXQocZ3axEtybQIloT3zOZUbYGHR+oae5gKl6twU6D8r8opvU7
        UTD0lgRi6AkE69l+WlSZwekjEygz0bFYUeB2pLGZpkUSD8FQ5kFljtWKEiwWpGdYNwgSlSti8dT
        Qu
X-Google-Smtp-Source: APXvYqzZjF2jlk/lO6YIJineFgZRkaD5dUICCKoPE4b05iJBjD7cXnTCc1oSIbyNXxMAtqmdSHQ5liVTAD3nfjyDSHZL
X-Received: by 2002:aca:f410:: with SMTP id s16mr2981091oih.87.1553281304283;
 Fri, 22 Mar 2019 12:01:44 -0700 (PDT)
Date:   Fri, 22 Mar 2019 12:01:39 -0700
In-Reply-To: <20190321174719.151877-1-jonathantanmy@google.com>
Message-Id: <20190322190139.151189-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190321174719.151877-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.21.0.155.ge902e9bcae.dirty
Subject: [PATCH v2] t5551: mark half-auth no-op fetch test as v0-only
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using protocol v0, upload-pack over HTTP permits a "half-auth"
configuration in which, at the web server layer, the info/refs path is
not protected by authentication but the git-upload-pack path is, so that
a user can perform fetches that do not download any objects without
authentication, but still needs authentication to download objects.

But protocol v2 does not support this, because both ref and pack are
obtained from the git-upload-pack path.

Mark the test verifying this behavior as protocol v0-only, with a
description of what needs to be done to make v2 support this.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
This is based on master + jt/test-protocol-version, but should apply
cleanly to many places.

After reading Peff's and Junio's replies, it seems that it would be
better to retain this test. So here's a version that retains the test
but just marks it as v0, with an explanation as to what needs to be done
to make v2 be compatible with it.
---
 t/t5551-http-fetch-smart.sh | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index a685d3edb6..c760514716 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -164,7 +164,17 @@ test_expect_success 'clone from auth-only-for-objects repository' '
 
 test_expect_success 'no-op half-auth fetch does not require a password' '
 	set_askpass wrong &&
-	git --git-dir=half-auth fetch &&
+
+	# NEEDSWORK: When using HTTP(S), protocol v0 supports a "half-auth"
+	# configuration with authentication required only when downloading
+	# objects and not refs, by having the HTTP server only require
+	# authentication for the "git-upload-pack" path and not "info/refs".
+	# This is not possible with protocol v2, since both objects and refs
+	# are obtained from the "git-upload-pack" path. A solution to this is
+	# to teach the server and client to be able to inline ls-refs requests
+	# as an Extra Parameter (see pack-protocol.txt), so that "info/refs"
+	# can serve refs, just like it does in protocol v0.
+	GIT_TEST_PROTOCOL_VERSION=0 git --git-dir=half-auth fetch &&
 	expect_askpass none
 '
 
-- 
2.21.0.155.ge902e9bcae.dirty

