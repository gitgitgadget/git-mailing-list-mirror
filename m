Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2ED91F404
	for <e@80x24.org>; Sat, 24 Mar 2018 00:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751962AbeCXA4G (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 20:56:06 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:44000 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751883AbeCXA4D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 20:56:03 -0400
Received: by mail-qt0-f193.google.com with SMTP id s48so14424862qtb.10
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 17:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ngBFxE3epv+FqYlGgqdw5fPyRY9am/2NACjkRvP8Ous=;
        b=BRZE4j0y/D7sjNRplcbwVWtGPphLTDO9tJzHWDAje8FRNqdh6E4263a5yT/12rjazL
         vdF+VHdc2638MmPJFtn3+DX5aC4u2Phx8zGiyjdkUQSRketY1wSzHxGYuFK4cupCLtBw
         AreKZcSF7jeq9raJv3shXWoBeQi7Ia0wk/sAaTbS6jljpr0g/jZ+J2GwK7Ocj7YuuEto
         3cUlcHmZSKxAI2WBYV+k9jQ5sPQ+eSHe/R8ipeutx0qSTIX7TqiJzwL1R8QWLhvEkcve
         vEKxAr1OPOC2SzG82o93lPgTEHLRxrfwEHelFw6xDsu6qxlofVN/Zk7A4x7P8rGLPEJ4
         BODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ngBFxE3epv+FqYlGgqdw5fPyRY9am/2NACjkRvP8Ous=;
        b=VWWD25IoN9g5bEm6l8nxNXNXD4yi1wQp3xkuLzRsHxo9QYOEaMW1F+b8Yr0Hy1PBYn
         nm1064w90bIxX6wuPo/j0CFWtAYL8pnX0lJniewKMzpXRSwPNRn6r9HBESMpTxvmZgZE
         NQkUU7dLJD7jpDNs+f1ft8Z4UPh06GMpcsfRvuc5NMdySh2uZ01D1ywYNhRn5f/q7Pf0
         1XfcJMrTll9vq57JIekjREPIQnDju4XqqG5Yz9+o/nmSdncWRpO9Cq3rYdrjnCxEv2Ex
         GOOTIwBZIhV2EOkRzIBetWyI9xD+1CvHOh3K17pEFfeSNAKuPeK0SL7M8VZ16jACFUtz
         Wn7A==
X-Gm-Message-State: AElRT7EYI2bCAZ4CihQSChrwIDmYKsvYFz/W9Wrj2Otc+r9dQ181X5zm
        rhvyr+3D8xXa4WZwimer44dgmw==
X-Google-Smtp-Source: AIpwx4/EK/LnpLe/zeLoLqe5Q6N8laLATJGgwcoMzAv4OU64KFk0H1m9fJJ+KXZDwI3lD8mBIBg/TQ==
X-Received: by 10.237.42.123 with SMTP id k56mr11123358qtf.302.1521852962499;
        Fri, 23 Mar 2018 17:56:02 -0700 (PDT)
Received: from localhost (u-of-rochester-128-151-150-17.wireless.rochester.edu. [128.151.150.17])
        by smtp.gmail.com with ESMTPSA id f6sm7104054qth.44.2018.03.23.17.56.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 17:56:01 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        sunshine@sunshineco.com
Subject: [PATCH v2 2/4] Documentation: list all type specifiers in config prose
Date:   Fri, 23 Mar 2018 20:55:54 -0400
Message-Id: <20180324005556.8145-3-me@ttaylorr.com>
X-Mailer: git-send-email 2.16.2.440.gc6284da4f
In-Reply-To: <20180324005556.8145-1-me@ttaylorr.com>
References: <20180306021729.45813-1-me@ttaylorr.com>
 <20180324005556.8145-1-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation for the `git-config(1)` builtin has not been recently
updated to include new types, such as `--bool-or-int`, and
`--expiry-date`. To ensure completeness when adding a new type
specifier, let's update the existing documentation to include the new
types.

Since this paragraph is growing in length, let's also convert this to a
list so that it can be read with greater ease. We provide a minimal
description of all valid type specifiers, and reference the <<OPTIONS>>
section where each specifier is described in full detail.

This commit also prepares for the new type specifier `--color`, so that
this section will not lag behind when yet more new specifiers are added.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-config.txt | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index d9e389a33..d9d45aca3 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -38,12 +38,25 @@ existing values that match the regexp are updated or unset.  If
 you want to handle the lines that do *not* match the regex, just
 prepend a single exclamation mark in front (see also <<EXAMPLES>>).
 
-The type specifier can be either `--int` or `--bool`, to make
-'git config' ensure that the variable(s) are of the given type and
-convert the value to the canonical form (simple decimal number for int,
-a "true" or "false" string for bool), or `--path`, which does some
-path expansion (see `--path` below).  If no type specifier is passed, no
-checks or transformations are performed on the value.
+A type specifier option can be used to force interpretation of values and
+conversion to canonical form.  Currently supported type specifiers are:
+
+`bool`::
+    The value is taken as a boolean.
+
+`int`::
+    The value is taken as an integer.
+
+`bool-or-int`::
+    The value is taken as a boolean or integer, as above.
+
+`path`::
+    The value is taken as a filepath.
+
+`expiry-date`::
+    The value is taken as a timestamp.
+
+For more information about the above type specifiers, see <<OPTIONS>> below.
 
 When reading, the values are read from the system, global and
 repository local configuration files by default, and options
-- 
2.16.2.440.gc6284da4f

