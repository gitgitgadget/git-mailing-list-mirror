Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36D3B20248
	for <e@80x24.org>; Thu, 21 Mar 2019 20:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfCUUvN (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 16:51:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44371 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbfCUUvN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 16:51:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id w2so41388wrt.11
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 13:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+qdcbY4knywdY0KgKM7U5q/OHcbFDdWPUwgxeXJGnTw=;
        b=mDOANsOkdpEEgLokY+9urpmZbm1uRcabR5t467NMqvjzCgqv3DKeiI4WpwU/+F3Xi0
         0Yt9KB6QQ3InISbOpnzvsyeFm5bjJoIikrAt3P2QL8UrfaOjqrvjzX2iDBWVX9oQa8cX
         o/XZP435IgkM9nmuZH4NO75PmE874IvZdszPfpWH4bcQZdRd9TLAY+V8UMUdoCOwtWPx
         iB819tit5YsBjat4B1j1sIwuNcbhR9VKOl8MHtEKc4y2LNgtso26qerdvxetp3gFOjoq
         pkR02/wEA0r1yAptqKCbHPgsMaleYmHlSKqbpSpjI8+3g4HSLTupRh5NF7B5PVU6D1vI
         2mnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+qdcbY4knywdY0KgKM7U5q/OHcbFDdWPUwgxeXJGnTw=;
        b=oaxI+lAuzVULAxJxzRQXC3ROD+giB3w55RYWiVF9xPxKaTZg8U+6DOVEStR9WUYkR6
         Xb5Vf+eIDMolYQleb0XBgEdeU4wCnccaVE0azrprFohXPJWs1aqBaYce+ZDVKchUt88x
         G3b81/k7Zzv0LQr8Et5AjfE2ZhMYmgdwLsp14puOrODvzlNlDk8lvD5UAOLsCkVfC4RL
         PUpQDd2oTaNqhn/dJ/HhxGFCMrj+G6T6VwXbPdKXCpdTKqHgfp+S4WScsFyGBQOpfc89
         XJ9wjFVcCUK0pJtuEfshIs+jLG1v46GQl1vnqG9WMaH9U3NG826O1rPM4hY5mu0hWToj
         gqlQ==
X-Gm-Message-State: APjAAAV+yIM96nBu+hkGo6Zyw3EhGcK5cy4wivZU73w7fOVxuS/h9aIj
        nWLnHYe7Nia+wzJvxI78pTuf7bCj
X-Google-Smtp-Source: APXvYqzPGzrHkgLqC+9a4tfL670mxBkDSsPlTCXse5mdMJM0xTd9Ww47B0pf54o6/NNPe3kbixI3Xg==
X-Received: by 2002:adf:eaca:: with SMTP id o10mr3997638wrn.273.1553201470714;
        Thu, 21 Mar 2019 13:51:10 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b4sm6053978wmj.3.2019.03.21.13.51.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 21 Mar 2019 13:51:09 -0700 (PDT)
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
Subject: [PATCH v2 05/10] gc docs: re-flow the "gc.*" section in "config"
Date:   Thu, 21 Mar 2019 21:50:49 +0100
Message-Id: <20190321205054.17109-6-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190318161502.7979-1-avarab@gmail.com>
References: <20190318161502.7979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Re-flow the "gc.*" section in "config". A previous commit moved this
over from the "gc" docs, but tried to keep as many of the lines
identical to benefit from diff's move detection.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/gc.txt | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/Documentation/config/gc.txt b/Documentation/config/gc.txt
index a255ae67b0..3e7fc052d9 100644
--- a/Documentation/config/gc.txt
+++ b/Documentation/config/gc.txt
@@ -53,9 +53,9 @@ will be repacked. After this the number of packs should go below
 gc.autoPackLimit and gc.bigPackThreshold should be respected again.
 +
 If the amount of memory estimated for `git repack` to run smoothly is
-not available and `gc.bigPackThreshold` is not set, the largest
-pack will also be excluded (this is the equivalent of running `git gc`
-with `--keep-base-pack`).
+not available and `gc.bigPackThreshold` is not set, the largest pack
+will also be excluded (this is the equivalent of running `git gc` with
+`--keep-base-pack`).
 
 gc.writeCommitGraph::
 	If true, then gc will rewrite the commit-graph file when
@@ -115,12 +115,11 @@ gc.<pattern>.reflogExpireUnreachable::
 	in the middle, the setting applies only to the refs that
 	match the <pattern>.
 +
-These types of entries are generally created as
-a result of using `git commit --amend` or `git rebase` and are the
-commits prior to the amend or rebase occurring.  Since these changes
-are not part of the current project most users will want to expire
-them sooner, which is why the default is more aggressive than
-`gc.reflogExpire`.
+These types of entries are generally created as a result of using `git
+commit --amend` or `git rebase` and are the commits prior to the amend
+or rebase occurring.  Since these changes are not part of the current
+project most users will want to expire them sooner, which is why the
+default is more aggressive than `gc.reflogExpire`.
 
 gc.rerereResolved::
 	Records of conflicted merge you resolved earlier are
-- 
2.21.0.360.g471c308f928

