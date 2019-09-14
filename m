Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CAEE1F463
	for <e@80x24.org>; Sat, 14 Sep 2019 00:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389243AbfINA0G (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 20:26:06 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:53744 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388921AbfINA0G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 20:26:06 -0400
Received: by mail-yw1-f73.google.com with SMTP id x198so16892994ywg.20
        for <git@vger.kernel.org>; Fri, 13 Sep 2019 17:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6b1C42YvL9wG9RGJeCyzR9B8B/irrmKx1OFJgRPpUFo=;
        b=CJ+nUzTL9BZ0KZTGqg6u7tD70CqiWvTR9s7ALBLTptH/YeqY9HhLzTkP4CBTkyIaBF
         PG+tvYntiwsmdWH6jU6JPMhGUjp1hZRespcrR7y2BrsMn+lW4vUNUJYqGWx8LsX/qZNZ
         bNlptKmTjb96MwBa9mmfOdlLqjtHWwiiYtv/VLVyxWTwzP+7QgumdrKrC9K1PNVmw4+W
         PCwvNpHSiUTeypVYXTRjyNA7fYcFS8grZBop5LTR0Bv6VHOdPOQ9yM7m4ixiGtf1DjXX
         7hmLS6d4juq5f0hjvEB1dZ3pZIj1vBXayQg4fLoylhmxoPKSOR/EO1Akwl/FIGPP6pyS
         QlSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6b1C42YvL9wG9RGJeCyzR9B8B/irrmKx1OFJgRPpUFo=;
        b=oXOzZ8UatT/69Hg4/O6poONw684vpJc3XBxTSdN2JRLvmvWuK0CtfZ14+tc9twBigU
         aumPJXiXlpmk9IE8dtDEJN+BhiqfnkzQwVcrsAJn6V43vU6bxQAGSpf7dyf5locws+5W
         zHWMJJCjvuZtAaS05mwglm4z8tX10xVcyUGHcxY+WXX/Tmr6fC6BUKlsrQVRYeJoL0zc
         KA8CBlL1HGI8Rk1RZES4Ahn1M/95qrtG/SKXrubHtC/zK9/jYtKiiMfpBX6pHBVM+rDv
         V80aY0tzmMWIWyPETr4sS6meSBOmh0+XycUvpGBlQEy/inXjIo3HyGixw+vbvymllfgM
         GKBQ==
X-Gm-Message-State: APjAAAU2iOCnrdG+qGtUyfcfHVZvo5XBLZjPjVIOuUd8Wlz1XNym56xy
        VxPNN879U8sIOiaSQf/Jb8C5m7cYZ8YS8JTTCGrqvAJKiNZOBjs66sK/l6Ij//+diYyoL5Qeecr
        31oaFYrBWh1kPDNPKWCspHt79/JwHW37K9Zzhe9vpQZN1gfCF9M7Tr9fv+uV/iVs=
X-Google-Smtp-Source: APXvYqyTOWcOecKzA7cQ5WzaKAttkB847PNUYfhp7C4IJB2f/baA+o7S7Q8JoGaXU45iKtjpQX1GD+LLcj6/sw==
X-Received: by 2002:a81:794f:: with SMTP id u76mr8338698ywc.467.1568420765477;
 Fri, 13 Sep 2019 17:26:05 -0700 (PDT)
Date:   Fri, 13 Sep 2019 17:25:58 -0700
In-Reply-To: <cover.1568419818.git.steadmon@google.com>
Message-Id: <eacffe250d2029f190d04144c9242ae25b8fb094.1568419818.git.steadmon@google.com>
Mime-Version: 1.0
References: <99e4a0fe409a236d210d95e54cd03fce61daa291.1564438745.git.steadmon@google.com>
 <cover.1568419818.git.steadmon@google.com>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
Subject: [RFC PATCH v3 1/3] docs: mention trace2 target-dir mode in git-config
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, git@jeffhostetler.com, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the description of trace2's target-directory behavior into the
shared trace2-target-values file so that it is included in both the
git-config and api-trace2 docs. Leave the SID discussion only in
api-trace2 since it's a technical detail.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Documentation/technical/api-trace2.txt | 7 +++----
 Documentation/trace2-target-values.txt | 4 +++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index 71eb081fed..80ffceada0 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -142,10 +142,9 @@ system or global config value to one of the following:
 
 include::../trace2-target-values.txt[]
 
-If the target already exists and is a directory, the traces will be
-written to files (one per process) underneath the given directory. They
-will be named according to the last component of the SID (optionally
-followed by a counter to avoid filename collisions).
+When trace files are written to a target directory, they will be named according
+to the last component of the SID (optionally followed by a counter to avoid
+filename collisions).
 
 == Trace2 API
 
diff --git a/Documentation/trace2-target-values.txt b/Documentation/trace2-target-values.txt
index 27d3c64e66..3985b6d3c2 100644
--- a/Documentation/trace2-target-values.txt
+++ b/Documentation/trace2-target-values.txt
@@ -2,7 +2,9 @@
 * `0` or `false` - Disables the target.
 * `1` or `true` - Writes to `STDERR`.
 * `[2-9]` - Writes to the already opened file descriptor.
-* `<absolute-pathname>` - Writes to the file in append mode.
+* `<absolute-pathname>` - Writes to the file in append mode. If the target
+already exists and is a directory, the traces will be written to files (one
+per process) underneath the given directory.
 * `af_unix:[<socket_type>:]<absolute-pathname>` - Write to a
 Unix DomainSocket (on platforms that support them).  Socket
 type can be either `stream` or `dgram`; if omitted Git will
-- 
2.23.0.237.gc6a4ce50a0-goog

