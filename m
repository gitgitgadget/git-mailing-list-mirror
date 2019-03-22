Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A37B20248
	for <e@80x24.org>; Fri, 22 Mar 2019 09:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbfCVJdF (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 05:33:05 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35750 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727919AbfCVJdE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 05:33:04 -0400
Received: by mail-wm1-f67.google.com with SMTP id y197so1437344wmd.0
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 02:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HWjU33OyEdr/osAHjqAJgkK11bvMFRIpeWMq+fsTe9Y=;
        b=WtXfjHzxASDx/Sgl3u8nqZDrhmyHqE5tPPGqLjixsg1kZbFcKiyChAs7f5C+IVgEJR
         wFQ7ypB6MnbxTFFlB7hoP5D7LO0BpAPA348ktPlUSCGyr5dCKmAnr/df3ZAHJRm4e91z
         LkZ8OXzkX7uMXAH5QOcCG3n+gfA1s5ByQfwYpV5JKGUTKhiqkRIVusZe+USQ3ouW/TCG
         566M+hEl8mcfa9mX/s5IF/iPfCg3DqHoQcVyX6fyq4K1+cFBvM3I/4G8x44ABs4t9cRI
         xt8sog96tfqYmEYKQBvTF4Gw5nIw83o7SZy1JHzZgOCne/m+euUEjYzdk1rqWWb7bBbV
         lsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HWjU33OyEdr/osAHjqAJgkK11bvMFRIpeWMq+fsTe9Y=;
        b=ViyNOmVQ4ywKoveQcqQEKIz+uNqSIyf1Z0ujImOUXrCPaTzUb1CFvI9wkll37OVlst
         bfMiw5Yge40lQd8nF4ea6+O8k0eZnGP7sFMkqn9zX4Ro1E3LVGMWiCoqDWX3p3icqL3O
         Oxp+fl2rR1vlY6vOVqYCUBN678G/P/5qH3JvQhKz9wo+gLjzjUM66QxKHS6ceQBtrOJD
         7n2fJS9oPAM49jU/w0G6/JGDjF1HOcHp8qSgCY1tefo/PE5zJ6Kb4bsvZ78B/h//8Vjt
         975h5d1+9L2dGZa7w2c/nhtf7QxzHOhvG9iJqmVGNFc194Ysnmaaw1IFRV8MBw8b2iLx
         EutA==
X-Gm-Message-State: APjAAAUbq1vTRmX9DF3TWcyC338NBU442KHR6YbhVVaJYDDQ/AGFp1B6
        bvW2hIjVeupP2bu7QGumpZyXETmB5Js=
X-Google-Smtp-Source: APXvYqyrmJthCcTO4+2FJVeMa7+hliV2e6qwX9Qtzgr8mlnHDOjWf4AUnntW7Aw5GNMlMUsZGz8urA==
X-Received: by 2002:a1c:f115:: with SMTP id p21mr2433330wmh.93.1553247182902;
        Fri, 22 Mar 2019 02:33:02 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y197sm3521447wmd.34.2019.03.22.02.33.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 22 Mar 2019 02:33:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 02/11] gc docs: stop noting "repack" flags
Date:   Fri, 22 Mar 2019 10:32:33 +0100
Message-Id: <20190322093242.5508-3-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190321205054.17109-1-avarab@gmail.com>
References: <20190321205054.17109-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the mention of specific flags from the "gc" documentation, and
leave it at describing what we'll do instead. As seen in builtin/gc.c
we'll use various repack flags depending on what we detect we need to
do, so this isn't always accurate.

More importantly, a subsequent change is about to remove all this
documentation and replace it with an include of the gc.* docs in
git-config(1). By first changing this it's easier to reason about that
subsequent change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-gc.txt | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index dd22eecc79..c56f4f7cde 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -52,14 +52,13 @@ OPTIONS
 +
 If the number of loose objects exceeds the value of the `gc.auto`
 configuration variable, then all loose objects are combined into a
-single pack using `git repack -d -l`.  Setting the value of `gc.auto`
+single pack.  Setting the value of `gc.auto`
 to 0 disables automatic packing of loose objects.
 +
 If the number of packs exceeds the value of `gc.autoPackLimit`,
 then existing packs (except those marked with a `.keep` file
 or over `gc.bigPackThreshold` limit)
-are consolidated into a single pack by using the `-A` option of
-'git repack'.
+are consolidated into a single pack.
 If the amount of memory is estimated not enough for `git repack` to
 run smoothly and `gc.bigPackThreshold` is not set, the largest
 pack will also be excluded (this is the equivalent of running `git gc`
-- 
2.21.0.360.g471c308f928

