Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C76D20248
	for <e@80x24.org>; Thu, 21 Mar 2019 17:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbfCURrZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 13:47:25 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:40182 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbfCURrY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 13:47:24 -0400
Received: by mail-vs1-f73.google.com with SMTP id x72so2455168vsc.7
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 10:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=eFPx/ayqxOOt3wq5JriLGrPqNaVlN2xLH3sXtnM2t54=;
        b=NFNnNH9Y+a4B3lMekIzYxstc5q1n2TBjD1AxVbQ+tl6P8QgbrzuZ6qEhRqW7xaDLeA
         jPWnwzCH1qPRXqzI6H96p9zkrOkk6kKjCfwJIFTuxRS02gl/Lr7UdAS7vchD22e4Y8tF
         exc+05GwMV7GNfrJYKkRTUtjRIWoZeqiL+9zbyfbkph56U7tlQeJT6//ocyNVGTEvEDM
         67wNZfwIyuc8vii7bmJobWf8ONuWEtHAO6TifQsl8flhOC7X937IVVZVdgQpKOuVyZXR
         bIqAnxBTv+2D3sc1wU1/rIUPvbTwKIMexK9HgVv5ItSYm8CmXuIuvIOn9gd5dpXbjUyd
         EIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=eFPx/ayqxOOt3wq5JriLGrPqNaVlN2xLH3sXtnM2t54=;
        b=aSdXm6GkR6Fso2y5HL6Gc13Hgzp9VzsSVaE7izE4eWVkS/WjjySt7E0YsKyYrwe94c
         krgju5SAYevTR7d8jUXMinGGIgslhh//VHuJGyLHptxRTkJe/odwyfGkEumdxYqRyZ/U
         haZDbMCni8k1l0gZGc2a4IZG4Pgm50XGHKfG9LJJ9rAa0XhmVR5J1OEnWwNP5fXB+OX5
         3U6ItTwboQFUwwlageW61i0wbF6mH9jAKZdUxWqD7uUUk4ZWbvUiFQBFpGIJx4xYrOLv
         /sCmV8pb8gQBXQO1TGxgbxhsAzSAFfj292bmYkIQEEGjqXhE7Zr0VvkWk7QbReOJBS6T
         95RQ==
X-Gm-Message-State: APjAAAULCWL8ruIrwKJ0I85nP/u/gBxCRymQW3+JXGuHc+nzNKyXheSP
        lbcyepslIvF5LVb8naLS4LMszq/7tqX+4HUWbkalgFZO69GAndcd3SP5fVR66hjDkq+2d5QcB/+
        hFBCw0fyzvWU03Mt+7El4OSYr/3WlZ5XXJG1nyNGJG6JSDizpRdG+Lz2u+I8PoLqNeRB6HDjZDw
        Ub
X-Google-Smtp-Source: APXvYqyHe2eKvxW70PMahp2Ga7GY3K+Si8SW3C/NsHSYMhJEcqm4xb1bA4sAJMzblpKP6SQ9WBhdnVJ80aMyvV4bMTUI
X-Received: by 2002:a1f:4f44:: with SMTP id d65mr3047022vkb.58.1553190443497;
 Thu, 21 Mar 2019 10:47:23 -0700 (PDT)
Date:   Thu, 21 Mar 2019 10:47:19 -0700
Message-Id: <20190321174719.151877-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.155.ge902e9bcae.dirty
Subject: [RFC PATCH] t5551: delete auth-for-pack-but-not-refs test
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net
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

2e736fd5e9 ("remote-curl: retry failed requests for auth even with
gzip", 2012-10-31) added a test for this, stating that this leaks
information about the repository but makes it occasionally more
convenient for users that use manual credential entry.

Protocol v2 does not support this, because both ref and pack are
obtained from the git-upload-pack path.

Because this configuration is not supported by all protocol versions,
and because this configuration seems to be of limited usefulness (only
useful for people who use manual credential entry and on servers that
are OK with exposing refs but not objects, and even in this case, helps
only in a no-op fetch), delete the test that verifies that this
configuration works.

This issue was discovered by the GIT_TEST_PROTOCOL_VERSION patches.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
This is on master. (It is reasonable to apply it even in the absence of
GIT_TEST_PROTOCOL_VERSION.)

Marking this as RFC, because my opinion is that the usefulness of this
feature is limited (as you can see in the commit message), but others
may have a use case that I haven't thought about.

The alternative is to add GIT_TEST_PROTOCOL_VERSION=0 to this test (and
rebase it to a branch that has GIT_TEST_PROTOCOL_VERSION).
---
 t/t5551-http-fetch-smart.sh | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index ba83e567e5..3be9c0063b 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -149,12 +149,6 @@ test_expect_success 'clone from auth-only-for-objects repository' '
 	test_cmp expect actual
 '
 
-test_expect_success 'no-op half-auth fetch does not require a password' '
-	set_askpass wrong &&
-	git --git-dir=half-auth fetch &&
-	expect_askpass none
-'
-
 test_expect_success 'redirects send auth to new location' '
 	set_askpass user@host pass@host &&
 	git -c credential.useHttpPath=true \
-- 
2.21.0.155.ge902e9bcae.dirty

