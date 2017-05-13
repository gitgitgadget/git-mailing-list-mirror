Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BCD020188
	for <e@80x24.org>; Sat, 13 May 2017 23:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757787AbdEMXPk (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 19:15:40 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36391 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757648AbdEMXPi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 19:15:38 -0400
Received: by mail-qt0-f195.google.com with SMTP id j13so11203518qta.3
        for <git@vger.kernel.org>; Sat, 13 May 2017 16:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ihzpD4+OFPWbMxJZIbF5doRzeJ3HBeUhU8J70apcUko=;
        b=qP3h+XpdFEzfXFQGs9ZZco/Jg7oYqxL8aJE/RyOKf2ticHucrIf3rWSRVCMLHKJ9v2
         3IXIiqiP9+gOlAn6EhDpJfGPhfb+6/jdGM02avW1NQ8KG2Ng0gg7hbSzNoqUPUnA+0/9
         8ZSBEOAW0seUw62FOeAXRrgDJa0Bo+KIxjTC7E4O5u/gLGQGH3kf3UXY5p1F2EJEKkjM
         v57ReI0c6mgAveYjypfYMr8HqdmZxzsX+gaDmvCSisTyk0uHdHYO7k9EEEOYbTpViJeE
         nSGKW4miXLQ8r8wSxllHSg3Qx1a5Go0c7zCf3L3b/7OTUDHtalHGRsKpiwiJJz2T2z5u
         gOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ihzpD4+OFPWbMxJZIbF5doRzeJ3HBeUhU8J70apcUko=;
        b=AjUtpUOJODY92gjgH4WLKtyi0JB0XQTrNx3R9UDDv4EZTlbLEjsc/HxGLCNkACCTlS
         VOLgC90KqUj2t/k+AioTGhvARUkL2SH/CB1LndTc8w7TCm4PM+m3ePkWPJ1OHQYPc1Tn
         cDmt7RnRpxkWhyKdMNmIcl2tmTohYbnios48DWG04P4Gy9j1o59s1CGrUJzb/+pAGDGc
         lFAkZ0ZIcmqvejSiW3oTtZJYcdQXKQULitOdr0DCjtu6QoKKrpU+DbHCtnE+VhezLr5G
         4NF6W1KJlP+9nvW54C9oF+HgctD3cOD7+mqixKm1yVukJCh/ZalbnZcUVr87aRLzgw1g
         iFpA==
X-Gm-Message-State: AODbwcA33ex5f7tL+kH45pfNgfByIaPMKs0/b8k3AngJcJx/gOfQ4r/p
        mkOmTPrbSPcf/g==
X-Received: by 10.237.35.134 with SMTP id j6mr9912945qtc.256.1494717337854;
        Sat, 13 May 2017 16:15:37 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k86sm5574840qkh.12.2017.05.13.16.15.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 16:15:36 -0700 (PDT)
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
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 02/29] grep & rev-list doc: stop promising libpcre for --perl-regexp
Date:   Sat, 13 May 2017 23:14:42 +0000
Message-Id: <20170513231509.7834-3-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170513231509.7834-1-avarab@gmail.com>
References: <20170513231509.7834-1-avarab@gmail.com>
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

Saying "libpcre" means that we're talking about libpcre.so, which is
always going to be v1. This change is part of an ongoing saga to add
support for libpcre2, which comes with PCRE v2.

In the future we might use some completely unrelated library to
provide perl-compatible regular expression support. By wording the
documentation differently and not promising any specific version of
PCRE or even PCRE at all we have more wiggle room to change the
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
index a02f7324c0..a46f70c2b1 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -92,8 +92,12 @@ endif::git-rev-list[]
 	pattern as a regular expression).
 
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

