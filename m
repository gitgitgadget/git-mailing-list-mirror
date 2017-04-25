Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CD4B207E4
	for <e@80x24.org>; Tue, 25 Apr 2017 21:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1954727AbdDYVGi (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 17:06:38 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36669 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1954722AbdDYVGe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 17:06:34 -0400
Received: by mail-wm0-f65.google.com with SMTP id u65so28343857wmu.3
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 14:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JfCYM2Gka7T05W3/fCxcT/aYN1GNDyZPE2H/S9PKxUE=;
        b=iLAvPDYuAKx+LcKxuXr3m3Zd/XofTJ6UQWxo/4tCj2bog/Y0JP06tl781YuX1n2BIv
         st8L2PTqrL+j0SGZfnJFmOszRuxl7XY8tA9a2ybFfrRQ8Y9+rjpDNjsUE5Y1XHw9Cyr0
         p9zCxObN4weDCuNg6Aa/ektgdiYUtlGDenvXqSHSMzj0WOzTjeTURflJgfyESFdPgtPl
         3vxtrvOgGJAIXBvFSUyeUyrDXE5WHsSwYZjcRmoXYgmGCEBfOmTD9l8PZouohyGhJTOx
         75AP4MB9EozZ6l9NXEALgs9NGeTC/y8ldTbH6KLB961DXA8lnwzXb3fU/aJnRBY+LZE/
         AEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JfCYM2Gka7T05W3/fCxcT/aYN1GNDyZPE2H/S9PKxUE=;
        b=QOGpldMSVeIXO4WY5MxYipxyyRF82oQbqzu9Npq6b68td5njRu3KVyzbBzOazJxMww
         RyliqdsURR/4Vgf8yIx5eZfLKC9E7vKvmmyyeF7xBWXsFUZ5adv20g/5y6DhiEzAStCA
         /BhC+GQW0ZRrLp7EXyPWSXxc3+u6efF4w4z2vRV9MhcuebiuHKzGue1ahzKpr1GQvdHz
         pJEvirMXHv0TE9k1yNC9WRCQRG/lDK34Hl+9xqgKc3waRvWil2AYue54VqhqUemS+KTH
         kKKapW40qnNZjbYQAFpjXUBy77nU93oyrSEkPGyIyfIsaXwrOdIK5MTJwX8pB7KwjVzb
         ADFg==
X-Gm-Message-State: AN3rC/4LZ81nMYefjaYsmwmTu39UkpmJG/jekrceXZ4os3AJrVpQmab3
        kiUh6TB2Nf+wKA==
X-Received: by 10.28.113.73 with SMTP id m70mr14878876wmc.12.1493154392400;
        Tue, 25 Apr 2017 14:06:32 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id i71sm27519917wri.0.2017.04.25.14.06.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2017 14:06:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        =?UTF-8?q?Zolt=C3=A1n=20Herczeg?= <hzmester@freemail.hu>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 10/19] grep & rev-list doc: stop promising libpcre for --perl-regexp
Date:   Tue, 25 Apr 2017 21:05:39 +0000
Message-Id: <20170425210548.24612-11-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170425210548.24612-1-avarab@gmail.com>
References: <20170425210548.24612-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stop promising in our grep & rev-list options documentation that we're
always going to be using libpcre when given the --perl-regexp option.

Instead talk about using "Perl-compatible regular expressions" and
using these types of patterns using "a compile-time dependency".

Saying "libpcre" strongly suggests that we might be talking about
libpcre.so, which is always going to be v1. This change is part of a
series to add support for libpcre2 which comes with v2 of PCRE.

In the future we might use some completely unrelated library to
provide perl-compatible regular expression support. By wording the
documentation differently and not promising any specific version of
PCRE or ever PCRE at all we have more wiggle room to change the
implementation.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-grep.txt         | 7 +++++--
 Documentation/rev-list-options.txt | 8 ++++++--
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 71f32f3508..5033483db4 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -161,8 +161,11 @@ OPTIONS
 
 -P::
 --perl-regexp::
-	Use Perl-compatible regexp for patterns. Requires libpcre to be
-	compiled in.
+	Use Perl-compatible regular expressions for patterns.
++
+Support for these types of regular expressions is an optional
+compile-time dependency. If Git wasn't compiled with support for them
+providing this option will cause it to die.
 
 -F::
 --fixed-strings::
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 5b7fa49a7f..9c44eae55d 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -93,8 +93,12 @@ endif::git-rev-list[]
 
 -P::
 --perl-regexp::
-	Consider the limiting patterns to be Perl-compatible regular expressions.
-	Requires libpcre to be compiled in.
+	Consider the limiting patterns to be Perl-compatible regular
+	expressions.
++
+Support for these types of regular expressions is an optional
+compile-time dependency. If Git wasn't compiled with support for them
+providing this option will cause it to die.
 
 --remove-empty::
 	Stop when a given path disappears from the tree.
-- 
2.11.0

