Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBEBE20284
	for <e@80x24.org>; Thu, 25 May 2017 19:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1036666AbdEYTqF (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 15:46:05 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34235 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964973AbdEYTqA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 15:46:00 -0400
Received: by mail-wm0-f67.google.com with SMTP id d127so55392417wmf.1
        for <git@vger.kernel.org>; Thu, 25 May 2017 12:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RpOs+Qsx26eUZBOHmbQzWwS3gG1cGlAR17HYSboDiSY=;
        b=Ccdir4khsfl848ZHtL3l+OajUE8dpG3tOWhxpuliSgcU7iMFLlUXkRN8PHw9CUU1r3
         +nUnPcpDuWdEFk+I942BFXxRSSkdFGH5UI7azaSFH/i/uJ7nS/dt1uUjuOXTUG59/Loe
         6EKtwLSGotTwWXbsSTV2FYIzBwI/tfmcN2DASR06Vkh9ghnCczZ29wNOwJ80YYST924n
         nLkqVJl5qea8ZYzQbcfmnRSBjks4ZvC+LXu6nM/OwlibUzT5U4noPIHRI6TrPqWKIdBP
         2/wT55tsBOALNWCnsq6TtrNc1ezz1oCdTC1N9/p/66ku0mSLhDkKxN5xEFQFXGSG8Wbm
         EqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RpOs+Qsx26eUZBOHmbQzWwS3gG1cGlAR17HYSboDiSY=;
        b=UCcpF3b3l/hXI4wMblKwLy+3W5U+rBOV26k3FRU/v4lFS/OwI3pFUPhPwENR/jzLIh
         XZvhnPgyds4+aU8Mt01a3G7AIbP0WHUS0Cnmu/S7Wp6B/m5WqIHLg6wbkMXe2MGvkF6l
         WBwtO2o+fDHimrX6489TFWZlBeQcEwWH7WcqZum1w+FofXgA1HUd7HJ5GCBpHVmAoOS+
         8NejBEDvppUNeTbwrg/dBRmI7n0QssAI+BhGFT5SIgzKYjBjzEPSu1Mk02Qigdw/HM87
         c/ylbEvhkj0XFsnwuM7W8epZ5YwJoIqIPFhUIAvz7yKUpGpN8R0qR6OcNP1Pw054haXk
         zd4w==
X-Gm-Message-State: AODbwcBTDOy55DjQvScDOmMQSqw40dWipWeujmNSkayWHoKR/n9uRXxB
        BhQgSzlVrzZraw==
X-Received: by 10.28.211.85 with SMTP id k82mr1687474wmg.48.1495741559153;
        Thu, 25 May 2017 12:45:59 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q203sm8387273wme.0.2017.05.25.12.45.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2017 12:45:58 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 02/31] grep & rev-list doc: stop promising libpcre for --perl-regexp
Date:   Thu, 25 May 2017 19:45:06 +0000
Message-Id: <20170525194535.9324-3-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170525194535.9324-1-avarab@gmail.com>
References: <20170525194535.9324-1-avarab@gmail.com>
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
2.13.0.303.g4ebf302169

