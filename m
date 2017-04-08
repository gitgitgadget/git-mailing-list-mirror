Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D57120970
	for <e@80x24.org>; Sat,  8 Apr 2017 13:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752627AbdDHN0R (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Apr 2017 09:26:17 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34964 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752226AbdDHN0O (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2017 09:26:14 -0400
Received: by mail-wr0-f194.google.com with SMTP id t20so23482922wra.2
        for <git@vger.kernel.org>; Sat, 08 Apr 2017 06:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xKkiTbDmXZD34qtqhAKtsJapKh+8t8k1kyYzogRUqpE=;
        b=KOzcVaV623TMFVGk2b7vv7xZH1C6YLUqqc43nOrOFC4AWIRx+uf0yE4yejs1RId7fq
         2zYnuOGTIrx4rFKdvV2be33bVS0vn2DL7jWwdJpbOAeCBGOo7i6+MoT3G+dUQUa0sjv9
         ZOSYXZbwPcdYQq2JZMZVgaYI65QQywb5BDtKeU6p6xFanGwTVvgSQ0nPpl97adlOltWd
         J19TR7Gm51syguh9FoxIWQM7l3J9krzA+dVnKPGUbTp28+IRpVDkEtKKsYCFzyGuXmCw
         T5fnrZi8vfU1Mt+Logq6w7WisR0QKC0+Tt+qSc8sBZQGROpvMzmLnJIM6rV2mx/bvXb+
         sMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xKkiTbDmXZD34qtqhAKtsJapKh+8t8k1kyYzogRUqpE=;
        b=fNOBTmVh36NzzGMuBrl9enl0+p9qIc4xENA2UuvPnAIH7JWi/Kzu6001hmlZcGrfVC
         nuMGLzawyAm+cFuAX3wwGCn1YkxhDJ/3XmmW8FJq8ylWwUIGWDGA+6K6JDhkHUsePvm+
         Y3qv+dPuz+qgpE0aTPVd2LaS4Gea5a951Of5VrnrdP68fV8n6rGn8vo7ycknZNBpZgHo
         i17LXH1gC8RXiV3IfwhYL7Fvws6rA/mZmsVhXzI+FzfGwwiHrZGfCaYoCUlxcmR+yj4L
         ytJvzmvsIZASjdY7aYPmQ7f/14ve2R2NfmypeV6CWv9544PEPewJ/z12dHDISTH0i112
         MVsg==
X-Gm-Message-State: AN3rC/4qG/KMeS5mMG67rtddP/1HQwGOXJTl1jJFvER0piSdqkbSS2819bWmrJX9QyUk3Q==
X-Received: by 10.223.157.23 with SMTP id k23mr1887185wre.28.1491657968096;
        Sat, 08 Apr 2017 06:26:08 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id v14sm2744864wmv.24.2017.04.08.06.26.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Apr 2017 06:26:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/12] grep & rev-list doc: stop promising libpcre for --perl-regexp
Date:   Sat,  8 Apr 2017 13:25:01 +0000
Message-Id: <20170408132506.5415-8-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170408132506.5415-1-avarab@gmail.com>
References: <20170408132506.5415-1-avarab@gmail.com>
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
index 7b52e3fbc4..1c01154dbe 100644
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

