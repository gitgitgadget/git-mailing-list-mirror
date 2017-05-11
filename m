Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 245C01FF34
	for <e@80x24.org>; Thu, 11 May 2017 09:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754876AbdEKJS5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 05:18:57 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36736 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754528AbdEKJSz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 05:18:55 -0400
Received: by mail-wm0-f68.google.com with SMTP id u65so5446308wmu.3
        for <git@vger.kernel.org>; Thu, 11 May 2017 02:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ihzpD4+OFPWbMxJZIbF5doRzeJ3HBeUhU8J70apcUko=;
        b=oIrq9Prv7tq5GtoAgw5tAH+gVCp7yqtdftNLPCBbRaXnA3KLu+1m5fg2nlE3iS/3Xt
         g1mwE4G+EUuysBJoDE/iBLdlT/AhESIkj2EWnI/ztn9OxCgjoD7yc2EYFUJQTOG2aNBY
         0qhJPOEAxVzZQ1MjZ4k4RdaVxJrkPJQu7HjV8niM1YTba8dWHLp4ykUWSg3Y7ZcXXiQY
         /kGdgoUqTV64+oH61aEbB3ArZkGZlVuhMccgrR5TXEliCKvdUDWkmRmY2IwP2k9PbjRG
         TdP3N7OFC7MggKpbOQh7411frfAkHj17xlLlwLBARCOGTNG6vKBM80PUF3tSB1tRExFR
         36DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ihzpD4+OFPWbMxJZIbF5doRzeJ3HBeUhU8J70apcUko=;
        b=FuK/LVaM5Xbb4lnEy1F5/mvt6qi8VJ2TINErcgSSE3cQk2Sb6tJZWMNQRaKfjWizrf
         Vs8JbboluSK4M7zUF5iMhfYs1Dx+bl3/ks/o/WSja+nOE4hQrUvSAQIq1Ugo6ByOTFlT
         /F8XT1WnhhCsaIOH7mkMIETEkLFnMLhdGWlqWTDnQfHFx7AmpYJg7eLklBbiNJOYN2H2
         M6xN3PLjek5YHj6K2cLbzw7wgziWrs9Y7VDW4tKl+rbEDnAtdmQ3NXJ5np54Na4iNRDy
         Pl/WXQTCBm1tAzvl9+zEVLN8RehwI5oJLTQnFlFrhDyWKdYIXjME55KVOeNG2SKQYM7l
         svog==
X-Gm-Message-State: AODbwcBd9SyylGG545Aov+qM7J5jsVm3cqC2kZsyqsglA5kDd4tVA/ae
        kpZTbhlmmWi2dQ==
X-Received: by 10.80.146.211 with SMTP id l19mr19638eda.160.1494494333126;
        Thu, 11 May 2017 02:18:53 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b3sm8341ede.9.2017.05.11.02.18.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2017 02:18:52 -0700 (PDT)
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
Subject: [PATCH 02/29] grep & rev-list doc: stop promising libpcre for --perl-regexp
Date:   Thu, 11 May 2017 09:18:02 +0000
Message-Id: <20170511091829.5634-3-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170511091829.5634-1-avarab@gmail.com>
References: <20170511091829.5634-1-avarab@gmail.com>
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

