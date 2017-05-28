Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E80D1FD09
	for <e@80x24.org>; Sun, 28 May 2017 14:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750815AbdE1Ode (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 May 2017 10:33:34 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36575 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750776AbdE1Odd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2017 10:33:33 -0400
Received: by mail-wm0-f68.google.com with SMTP id k15so11739714wmh.3
        for <git@vger.kernel.org>; Sun, 28 May 2017 07:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=A1eDtJ2M+nEto+a0Ko+hD46iaCjTJZjDt73j2H5Y40g=;
        b=VUKZGDbPxFAnzBdKY8pf8W4WSAJSjDRIugJHSzOw78WDQX9ws9B0s2Ip3s9kAf8IH9
         +wlI3gOtbzkg2vB0TG3YAJ9BmVsuTVsmjxQmTEP3e0/6zesBNGO3VACGHm6JgHt5K0XI
         srL4Y2NBZycfv6KghIT8Ps7MxXYSMjBCJRkzTiqnyF6ZjUO+7CPqwwwoI4FT4yUWeeuj
         vsoq77xanKhKIMy1jWo5DwF8M4giyqcBvHOVUqg4yT+fDJIj/Wofxa8yggpGoUav30QL
         2lJuk60utWb6t00q0tsk1HNDmgEBwSyMCQ9pWhmv5/ygfaCLQZooZtRMhz/KIs6ooo2V
         ID8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=A1eDtJ2M+nEto+a0Ko+hD46iaCjTJZjDt73j2H5Y40g=;
        b=S7yUSrT3nHVEKERqXWtQizV3RyLvWajLYBz1iczhMcwK9IhQXw/GSgq0gkwWkjxsEv
         XD3UNz0CfR8JWPYShov9YrcpxKfTS5DA5fwjbElEVuBlElB3ZtfZ2HjvMfeWXxrNHQk5
         WiGQRG/b18VVKJYWl5vqfMgF8yGu+44uenmFmk3OnsOj7Xx9lPGXZ28pNZi6cTlen7Hc
         h1Ea/54JjwjiSbLT9ki0RdgT8zN1K7mNd1nhLtiABNnia1uiw64nWqeZlhDs4pQwKkph
         xzDK+BTPEZZVM1VVoUEE6GQ9IwMxvESWVV4VUAS35Xp+Vx9j3+Px0me/NpSfzVP5oFQm
         6Mkw==
X-Gm-Message-State: AODbwcAdRm19esGI1MCqrREOzzn+fBTinCuwMuVwrAZvl9BH3TRYqnXi
        u43fsfkkn75sMw==
X-Received: by 10.223.154.195 with SMTP id a61mr4571943wrc.47.1495982011995;
        Sun, 28 May 2017 07:33:31 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a61:340d:9a00:d8e7:1456:52e6:2cef])
        by smtp.gmail.com with ESMTPSA id l70sm27771790wma.11.2017.05.28.07.33.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 May 2017 07:33:30 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     gitster@pobox.com, git@vger.kernel.org
Cc:     Andreas Heiduk <asheiduk@gmail.com>
Subject: [PATCH] doc: Improve description for rev-parse --short
Date:   Sun, 28 May 2017 16:33:22 +0200
Message-Id: <20170528143322.8580-1-asheiduk@gmail.com>
X-Mailer: git-send-email 2.13.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

First: `git rev-parse --short` without a number does use a fixed default but
`core.abbrev` which in turn uses `find_unique_abbrev` internally.

Second: `--short` implies `--verify` since the beginning (d50125085a), so
it cannot be used for bulk-shortening ids unfortunately.

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 Documentation/config.txt        | 1 +
 Documentation/git-rev-parse.txt | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e0b9fd0bc..158cb588b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -862,6 +862,7 @@ core.abbrev::
 	computed based on the approximate number of packed objects
 	in your repository, which hopefully is enough for
 	abbreviated object names to stay unique for some time.
+	The minimum length is 4.
 
 add.ignoreErrors::
 add.ignore-errors (deprecated)::
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index c40c47044..7a7421c8e 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -140,7 +140,9 @@ can be used.
 --short=number::
 	Instead of outputting the full SHA-1 values of object names try to
 	abbreviate them to a shorter unique name. When no length is specified
-	7 is used. The minimum length is 4.
+	the effective value of the configuration variable `core.abbrev` (see
+	linkgit:git-config[1]) is used.  The minimum length is 4.  The length
+	may be exceeded to ensure unique object names.	Implies `--verify`.
 
 --symbolic::
 	Usually the object names are output in SHA-1 form (with
-- 
2.13.0

