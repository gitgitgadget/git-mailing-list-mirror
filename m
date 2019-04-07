Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AE8B20248
	for <e@80x24.org>; Sun,  7 Apr 2019 19:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfDGTwp (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Apr 2019 15:52:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33528 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfDGTwo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Apr 2019 15:52:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id q1so13871825wrp.0
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 12:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AaTauwKkVFivjx3/WKqbYHYkQv9/qpLAgnujxe8DuB8=;
        b=QezNQcR/uS/6zoVD4NXZG5EdOdPUm2S6sAIxqntXxdIyyQNF8Nq5yycq7nB5fm8tx7
         VqgE9cYym5xDCDn8+KZnSykDNDUyjguELREqhDk7X4QCltzovUsM6FpUK2Op5mPnL4b4
         67uf0jXNSq9taFQG15ik59Nknszu66G+Gb5EtwwVNJQFVbVWutWPtuQYAFkK7YfXTD8S
         2OKDkr/zni5bj8xld8S9fAJglGfL0Um2uh1PA/an11IaR5hKE+7pdzR2pKDGacsMd8ZR
         YvpzTUaxeFFv8T+BzDEep8tbHtXtcZ6ZWEZMgL/i5RKA15YrMycyUHndifoKkG+cg+UQ
         QwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AaTauwKkVFivjx3/WKqbYHYkQv9/qpLAgnujxe8DuB8=;
        b=o3aJe+DAHd+6xXW4Mdsk+fBuoTLAAwFQ+lkcGeKrJQh5fE9osg1vH5UNs7wvNs9LJE
         ZxUYKkhRqNcWcTGINz7zYMjFn0xDQoJKK8M1t5meeeJOykCY3dJqQYi/jBGMm06YTuRo
         dwfKBP2bj31Rtbw3TY4cDYBwtQ01SyQTdnIgZrgv6isheN2XNZnd5mtty+kwqr3GbB7H
         xvgUZtFz0YAknoVDq+Ouq+4ulJ2GZkNTQ86JL8dlUZOyl2awMYdL7g3Jd4Z5gTZijgtx
         CMP8yBbVSQ5dVinIu8GL7L9qswVPDZJ6g+l5r5U3oQ5icoyzsOUeepVKZ5q4LP/nJ3SH
         FrDQ==
X-Gm-Message-State: APjAAAU/uUK1whWmnokFxtDRZyx6cgABECRFLC+h6h+D+g8WERjYnqfq
        3ih75Li+uMeImUcoCftjqKmzbVfScnk=
X-Google-Smtp-Source: APXvYqyh6vXVDymsTIfMEWbpGn9wPpvlQ9plBah9GKR8vWZ7Mk3rAk4s8fzhUs+90ZbiZwudNNk3eA==
X-Received: by 2002:adf:efc3:: with SMTP id i3mr16302335wrp.92.1554666762471;
        Sun, 07 Apr 2019 12:52:42 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e16sm41815402wrs.0.2019.04.07.12.52.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 07 Apr 2019 12:52:41 -0700 (PDT)
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
        Johannes Sixt <j6t@kdbg.org>, Todd Zullinger <tmz@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 05/11] gc docs: re-flow the "gc.*" section in "config"
Date:   Sun,  7 Apr 2019 21:52:11 +0200
Message-Id: <20190407195217.3607-6-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e
In-Reply-To: <20190322093242.5508-5-avarab@gmail.com>
References: <20190322093242.5508-5-avarab@gmail.com>
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
2.21.0.392.gf8f6787159e

