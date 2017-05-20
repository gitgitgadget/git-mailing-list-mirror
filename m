Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AA0E201A7
	for <e@80x24.org>; Sat, 20 May 2017 21:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756279AbdETVmz (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 17:42:55 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35968 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755988AbdETVmw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 17:42:52 -0400
Received: by mail-wm0-f66.google.com with SMTP id k15so23157165wmh.3
        for <git@vger.kernel.org>; Sat, 20 May 2017 14:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RpOs+Qsx26eUZBOHmbQzWwS3gG1cGlAR17HYSboDiSY=;
        b=S2xEYSLTwt1IcF2ceqeEGzvOATzz/EAR1Ar56nLfnSZ2nXjKUGOcttbVhI7mridyHm
         r9jW6pNUEAc4JPVkMO51jLA6jYjh4IRsPqhVIJ/8BjFij5O1pmejK6QHq8fsmdiN7yWb
         LWgw6Y7ihItzAtRN9dmWy7gckb/H/5bqP5yNZTN+gZYxXvwaY72S2IOTX1Xt1Z6mivd/
         YUQxvU7OW+opE41uKQxRrigH1hxLcsUBlhecn060hgrW4IGlXQX8zMggDW8hoR5o3qG8
         Hjd3fEW0vSnanSK91V1wv21QFm+2BQHO9oD2pqH4Pbt0eEM9HJWTIqz5LkaR/m+FhJxF
         FK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RpOs+Qsx26eUZBOHmbQzWwS3gG1cGlAR17HYSboDiSY=;
        b=hmsWT9E9OTadSS/rBnfJs/ilEnDDwz5lGPDpR/PkMnRlmt9ewjETOTrCtAmd6Jsatm
         bQVDGqbU5B6YSmFUoPq24hOBhp13Pvr0/HJFHYcyeio48zChAP2mkXjMlBjNvXXmnXyd
         4ZfomoZW1tQqxi5s2SlNNaF0QapH9wM85l8OnM2dLBe/GdP6+RqhMvCaL6RBKrn0I/NO
         k9ynbhuTiQ0OlXvBqEiGiw1581rb4yVNMm6g5mMNgGqcGUct3DHtkloqFOHr1do59hMn
         3nJ+LH5Fu9RR6SrC3iF50xYxMlMjMZxY/CHRWSVJknd+uP2r4/oUfdKkQaydFdECWP8w
         WKfw==
X-Gm-Message-State: AODbwcAGgmLkdr6x5GDTZK77C7bGxPHIrN0jHY2BMPA/Fzvf2rWQwlFr
        evreEHQAZ/wpuw==
X-Received: by 10.28.57.6 with SMTP id g6mr22220556wma.112.1495316571498;
        Sat, 20 May 2017 14:42:51 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e73sm25666835wmd.1.2017.05.20.14.42.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 May 2017 14:42:50 -0700 (PDT)
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
Subject: [PATCH v3 02/30] grep & rev-list doc: stop promising libpcre for --perl-regexp
Date:   Sat, 20 May 2017 21:42:05 +0000
Message-Id: <20170520214233.7183-3-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170520214233.7183-1-avarab@gmail.com>
References: <20170520214233.7183-1-avarab@gmail.com>
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

