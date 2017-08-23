Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C6CC1F5A8
	for <e@80x24.org>; Wed, 23 Aug 2017 21:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932792AbdHWVRw (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 17:17:52 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36411 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932668AbdHWVRv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 17:17:51 -0400
Received: by mail-qk0-f194.google.com with SMTP id p2so705179qkf.3
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 14:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=nFOqSSNWWGTNLZ/uPsNlbD43AMEZTl2KzJ2sOtip74c=;
        b=iuBNnB4YelPKey0rUvSsJe7P+9PoHyr+fvTGSA+WAuoeqDj19BU19PUQv11bAmM2F+
         t5O1Q3A5yzKc4N4z3q+eSq0GHWrE768JW5UetTQYUadS6Au+BE1M+vLND5dB0DewBOol
         yWekLfk7qLDKhVb54BCbCHq7JJZwkN26c3nipk7wEypbnuXy3PGKhEYGBxvS7sRomhmR
         cev29TsBpbgMTZyREA+2jPlNmcxegm7R+qB3aXV51ed/Ox5+joquEGK+imVEdHrmmlPt
         3SnOLAGXjMMJDahrPLQeAS6xche9YUbHTLSZ+ZXcH499mFF/NFS6Jc8PO/zv6NRGyuMd
         VSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=nFOqSSNWWGTNLZ/uPsNlbD43AMEZTl2KzJ2sOtip74c=;
        b=gbfzTTby8QaVFoN0stoTG0jJhz7Vqy6++kz32L7u4Fsz9GDLcDp3L3H7GEbwXGQAXu
         JmUNBb3D4fN1z+JRFjCSI6FpBQrPhLgra98+uIf5PLQHnIMW/GahCVNJiupqY6JKPmEd
         vznaIE963Z8eYNL6lvqAl8FZAy0X7MJfamauggHd6nnLT4Qw3/IuQvAv8u1avccCT3PQ
         wyKPFEGJWZBNaAPFHHdncSo94kO/Z/Oy37EjuRcCP2fTddZeVgVkSfBMNV42xyjlD68h
         AHHHKx+R5wlP5uPrIPqCjatBnuErjuIuwF8eFuGVhTM9V1EB2KT0hWmqGfZJoYk9Vne6
         S49A==
X-Gm-Message-State: AHYfb5i1vs4eE/6WZXYuZsBeV+hRjGydZ/+eR3UmBixrS0Lo5yED/1Iz
        u0piJdM/x0ULGw==
X-Received: by 10.55.96.6 with SMTP id u6mr5924895qkb.104.1503523070422;
        Wed, 23 Aug 2017 14:17:50 -0700 (PDT)
Received: from localhost (tripoint.kitware.com. [66.194.253.20])
        by smtp.gmail.com with ESMTPSA id h141sm1499560qke.16.2017.08.23.14.17.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Aug 2017 14:17:49 -0700 (PDT)
From:   Ben Boeckel <mathstuf@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Ben Boeckel <mathstuf@gmail.com>
Subject: [PATCH] Documentation: mention that `eol` can change the dirty status of paths
Date:   Wed, 23 Aug 2017 17:17:41 -0400
Message-Id: <20170823211741.9633-1-mathstuf@gmail.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20170822174918.GA1005@megas.kitware.com>
References: <20170822174918.GA1005@megas.kitware.com>
In-Reply-To: <20170822174918.GA1005@megas.kitware.com>
References: <20170822174918.GA1005@megas.kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When setting the `eol` attribute, paths can change their dirty status
without any change in the working directory. This can cause confusion
and should at least be mentioned with a remedy.

Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 Documentation/gitattributes.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index c4f2be2..3044b71 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -151,7 +151,11 @@ unspecified.
 
 This attribute sets a specific line-ending style to be used in the
 working directory.  It enables end-of-line conversion without any
-content checks, effectively setting the `text` attribute.
+content checks, effectively setting the `text` attribute.  Note that
+setting this attribute on paths which are in the index with different
+line endings than the attribute indicates the paths to be considered
+dirty.  Adding the path to the index again will normalize the line
+endings in the index.
 
 Set to string value "crlf"::
 
-- 
2.9.5

