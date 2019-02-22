Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B67420248
	for <e@80x24.org>; Fri, 22 Feb 2019 14:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfBVOlr (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 09:41:47 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:50492 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfBVOlr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 09:41:47 -0500
Received: by mail-wm1-f53.google.com with SMTP id x7so2186528wmj.0
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 06:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tch+rR4heKSelh7R9yZAXzfWicJAI1834Pdg9GQ/7fI=;
        b=F883w93dbBi6LC17QWCOIUsd2B6wyTK1qDoHvIW2VO9Xh2hcNhJhQTPKRhC0vadA+w
         yXpFu+VA2hPEELT8hVNcW290HRCPC9Hfg01SAOnnh+Sz8f/iNgzy94RxBfXNnNSln32P
         XyMu2IOS1wCXtzQObOkZpOTeSW88B+drAjgddcDqrveaebzPrqfrxvWMxlu40gs7eO+z
         Asf58rmlW48IyE/j/TaENOQtlc/z3SAypBsYQTYK+exS6cxd4ztPAKH+a5ZmS9xY4a+G
         8TijE5OnSuWhhP5PfppPnanhXJVZxP7TL/4DhHtWprszA8dQ/sbfps0Ip+w3AEKaBNp1
         h9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tch+rR4heKSelh7R9yZAXzfWicJAI1834Pdg9GQ/7fI=;
        b=bl3+1FirkLk/Nxk2n+1wVTjQA/wUnMr9b5IDkS29+TLttqT3iXLQcn0ZwWHGYLUCD8
         UpDxGSbZxUgCIPXr5vrTVHTud4beKIT1BjEebSwtTBa6yZJpdqkqBM7JA461kvoMuJVj
         /difv6YF4khMTalYrNerv2TDoDTjwqYe3GN/w6yWbNSxvCgh6DuJZWpTMJJA060G32Ku
         DDp2isrTsb0Ow05aQbPI1BwPZZSdGqwUAL7r3BSaP5uhuPc+ahinrBnIm9mH4TUlbjHQ
         qdauTTRXhbw/1/AvElJLhjuaJQlIm9v6prTtApjcWcO59QmWXMQTTCGKyUI7lqu64LD7
         2wRA==
X-Gm-Message-State: AHQUAuau0/gbuCYc18C/G3ISROkQhP4jOgba9aK6gWHjOlGGRAhbqNWt
        WcAAEy7n1Cj9v7eVWqW8XlerObTZIbE=
X-Google-Smtp-Source: AHgI3Ibb2JZcV6nZr+nmbAqcOI0UuzJpoPtkBzIUG0dRXe8J4s1321jX6CQ/J/u36v8B27sepg4g0Q==
X-Received: by 2002:a1c:dc0a:: with SMTP id t10mr2748152wmg.101.1550846504492;
        Fri, 22 Feb 2019 06:41:44 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z15sm1481689wmi.46.2019.02.22.06.41.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 22 Feb 2019 06:41:43 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Lars Schneider <larsxschneider@gmail.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/6] Makefile: add/remove comments at top and tweak whitespace
Date:   Fri, 22 Feb 2019 15:41:24 +0100
Message-Id: <20190222144127.32248-4-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b
In-Reply-To: <20190222105658.26831-1-avarab@gmail.com>
References: <20190222105658.26831-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The top of the Makfile is mostly separated into logical steps like set
default configuration, set programs etc., but there's some deviation
from that.

Let's add mostly comments where they're missing, remove those that
don't add anything. The whitespace tweaking makes subsequent patches
smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index c53727e44b..0870fd4651 100644
--- a/Makefile
+++ b/Makefile
@@ -507,15 +507,14 @@ GIT-VERSION-FILE: FORCE
 -include GIT-VERSION-FILE
 
 # CFLAGS and LDFLAGS are for the users to override from the command line.
-
 CFLAGS = -g -O2 -Wall
 LDFLAGS =
 ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
-
-# Create as necessary, replace existing, make ranlib unneeded.
 ARFLAGS = rcs
 
+# Set our default configuration.
+#
 # Among the variables below, these:
 #   gitexecdir
 #   template_dir
@@ -560,6 +559,7 @@ perllibdir_relative = $(patsubst $(prefix)/%,%,$(perllibdir))
 
 export prefix bindir sharedir sysconfdir gitwebdir perllibdir localedir
 
+# Set our default programs
 CC = cc
 AR = ar
 RM = rm -f
@@ -587,10 +587,6 @@ SP_EXTRA_FLAGS =
 
 SPATCH_FLAGS = --all-includes --patch .
 
-
-
-### --- END CONFIGURATION SECTION ---
-
 BASIC_CFLAGS = -I.
 BASIC_LDFLAGS =
 
-- 
2.21.0.rc2.1.g2d5e20a900.dirty

