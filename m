Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94F501FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 22:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1765362AbdDSWll (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 18:41:41 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35765 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1765220AbdDSWli (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 18:41:38 -0400
Received: by mail-wm0-f65.google.com with SMTP id d79so7522823wmi.2
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 15:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6lCnf4R6ei7dakrgagWRhOCNPQqQTawMTmI1QsoKIDY=;
        b=eN8uY0vcaGBP9CnCvaAZ92TmU4eRQQhhPnnAa7XFNp5hBqWZ5aIJKi31ZoW9xKChX1
         6ozhCY5iXebrhEeJFyExrFuxy4L5U7N25YotZJ2LuLj5kbYvm/LzMSNXJtTQGkJ5UTog
         wJEkc1KAGXSW0irx9HjfkFoLsexXb/4UPJ2d/jWkJJJmHPxuwxqDJ6G2D3XzAqQS8kqu
         gwS5i2E5nqfhoXYNq5brQII6kKX7yIfscUyjxpgEYKoW/cWw8qLKPLJzIfUzY+RbEEVN
         xCszTBLkZeydXiMmGiZ2UuoExhLmzw0q5Ret45TRqtb+of+Qsd3vkbq5q3Jsl2YnFSXU
         l6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6lCnf4R6ei7dakrgagWRhOCNPQqQTawMTmI1QsoKIDY=;
        b=aeyZDH8UD4djGFOjFbrYUq6hMB2ZHwYH81bYoV+zWo1OFMgxVZxppNANTIBr0IPgwJ
         r851XUarzeTFHiwmTs84+AdQOPhT8zMj5xoVCKT1nb7rkg9oY/73z9h/LFeASh2a4Kvz
         ezDIm7Jk2cS1qQuxSdYF06PokwmCjGKBa7QhVAojf4K+0RLCJxUudBBPTc8eN5ENQ06k
         6ipwr63i++D9kTbASlM7tIkjXmwdm0B5i86hB+ZiQaLd4eynqjK5uLXLlVhYMO5y83V3
         zmTIctHR9zybhd52MWTf2sAp4b1hm1AvLJggHJETuLrrhdO0qZ0q9Pz4PGZe5HTm9ImB
         eQxw==
X-Gm-Message-State: AN3rC/5q4QBqbHAilbBLAeWMwneqxJIMl772+m2qr4keuG81DzfKXY8C
        4WclsGajQw1dJg==
X-Received: by 10.28.0.142 with SMTP id 136mr215554wma.123.1492641697030;
        Wed, 19 Apr 2017 15:41:37 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q130sm21128996wmd.29.2017.04.19.15.41.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Apr 2017 15:41:36 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/13] grep & rev-list doc: stop promising libpcre for --perl-regexp
Date:   Wed, 19 Apr 2017 22:40:46 +0000
Message-Id: <20170419224053.8920-7-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170419224053.8920-1-avarab@gmail.com>
References: <20170419224053.8920-1-avarab@gmail.com>
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
using "the PCRE library". Saying "libpcre" strongly suggests that we
might be talking about libpcre.so, which is always going to be v1.

Not only do does the documentation now align more clearly with future
plans, but it should be more easily readable to the layman.

This is for preparation for libpcre2 support, which in the future may
be powering the --perl-regexp option by default, depending on how Git
is compiled.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-grep.txt         | 4 ++--
 Documentation/rev-list-options.txt | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 71f32f3508..e42ba83c42 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -161,8 +161,8 @@ OPTIONS
 
 -P::
 --perl-regexp::
-	Use Perl-compatible regexp for patterns. Requires libpcre to be
-	compiled in.
+	Use Perl-compatible regular expressions for patterns. Uses the
+	PCRE library, which Git needs to be compiled against.
 
 -F::
 --fixed-strings::
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 5b7fa49a7f..565cde636e 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -93,8 +93,9 @@ endif::git-rev-list[]
 
 -P::
 --perl-regexp::
-	Consider the limiting patterns to be Perl-compatible regular expressions.
-	Requires libpcre to be compiled in.
+	Consider the limiting patterns to be Perl-compatible regular
+	expressions. Uses the PCRE library, which Git needs to be
+	compiled against.
 
 --remove-empty::
 	Stop when a given path disappears from the tree.
-- 
2.11.0

