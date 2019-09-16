Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E1711F463
	for <e@80x24.org>; Mon, 16 Sep 2019 19:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732853AbfIPTAw (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 15:00:52 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40358 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfIPTAw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 15:00:52 -0400
Received: by mail-lf1-f66.google.com with SMTP id d17so818304lfa.7
        for <git@vger.kernel.org>; Mon, 16 Sep 2019 12:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RonXXUa1BfCEMjRNE8XfYd6dtxm3Y6HWnEz0sNI4IIQ=;
        b=GyvjU+8yAGaSbsf5Wu8NqIn2Z9+S9zuyXBNkOAumHUKnX7riOccwAdTMuHi+/oprjs
         4b733fdw/RSZV/oUvFX9pPMp2bl4ERczPh2z/lOh8jzVDibiElHI0HLitxnGpUQKcXpS
         u6UUQCtVCKzcIsm/LU/Cqw6KUBNWpFK5Cxzi5ND/BMrkFtmiZEycJ50vhJHbs7NPDVLA
         ImcppUyEI4yxdy9hDbqHXrE6a39D5IHQQV5OKTONrqgBGy7kS72eslrpBb4cdxF72bR+
         n5AT2w/kKEeV9h8nAyFHn+EwNeoKPYiI9bBGP8Rg+fRIn08KY7F9XO7R6UJoMBzw3uC9
         x1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RonXXUa1BfCEMjRNE8XfYd6dtxm3Y6HWnEz0sNI4IIQ=;
        b=Ck6OwNm+7TFJw9jbzOL/lxsPK0gn9VJiTPuzBQd7qP+7SW0uEQ8fpsqvNSvf/8uNiF
         QXM9lIoXllBX//xjm/nlb4mlXCQWJwd94Ll2OD/1H53RotRdfzVNBF31k+K22EIlC7gg
         njXjDHZXE+Ie+IvSam9A6Y4IWCsxugJlTHxTq+aLSJP//uuEYXRV9CcmJ9Pozwtbipey
         uE2lF1aAWRNqt/U57IlIwWbrZRFZfMmucPHEtIDfGOSRrqWyaA4maMLrqFYOMiPMAAEi
         p2/hOCjrsmtCfGL6DJTA94qZ3lFmDMr+TWmuVejdRetSQP/IBj8OMWZhbpPjDepjnXG0
         y4Hw==
X-Gm-Message-State: APjAAAUHbbf1oCbW9KWO03/KggIoYrNAIpdMYeuQlsyIRvNhTHvYdVLJ
        +THpBtYze9ROznh9gEP6vmdfkoCU
X-Google-Smtp-Source: APXvYqx0GSWucxRY7q29K5jS5qi7n+YXNevAwZtIo7bHA96EItPBRXlZtLYtdRIvCIBMYKMW32f5xA==
X-Received: by 2002:ac2:5925:: with SMTP id v5mr515079lfi.8.1568660449987;
        Mon, 16 Sep 2019 12:00:49 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id j28sm9127608lfh.57.2019.09.16.12.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 12:00:49 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Todd Zullinger <tmz@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/3] Doc/Makefile: give mansource/-version/-manual attributes
Date:   Mon, 16 Sep 2019 21:00:26 +0200
Message-Id: <bf80b9a66f23a287c447509a33dbb2ec97ac2a64.1568658269.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568658269.git.martin.agren@gmail.com>
References: <cover.1567534373.git.martin.agren@gmail.com> <cover.1568658269.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rather than hardcoding "Git Manual" and "Git" as the manual and source
in asciidoc.conf, provide them as attributes `manmanual` and
`mansource`. Rename the `git_version` attribute to `manversion`.

These new attribute names are not arbitrary, see, e.g., [1].

For AsciiDoc (8.6.10) and Asciidoctor <1.5.7, this is a no-op. Starting
with Asciidoctor 1.5.7, `manmanual` and `mansource` actually end up in
the xml-files and eventually in the rendered manpages. In particular,
the manpage headers now render just as with AsciiDoc.

No versions of Asciidoctor pick up the `manversion` [2], and older
versions don't pick up any of these attributes. -- We'll fix that with a
bit of a hack in the next commit.

[1] https://asciidoctor.org/docs/user-manual/#man-pages

[2] Note how [1] says "Not used by Asciidoctor".

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/Makefile      | 3 ++-
 Documentation/asciidoc.conf | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index dbf5a0f276..a67bc04ae8 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -122,7 +122,8 @@ ASCIIDOC_HTML = xhtml11
 ASCIIDOC_DOCBOOK = docbook
 ASCIIDOC_CONF = -f asciidoc.conf
 ASCIIDOC_COMMON = $(ASCIIDOC) $(ASCIIDOC_EXTRA) $(ASCIIDOC_CONF) \
-		-agit_version=$(GIT_VERSION)
+		-amanversion=$(GIT_VERSION) \
+		-amanmanual='Git Manual' -amansource='Git'
 TXT_TO_HTML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_HTML)
 TXT_TO_XML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_DOCBOOK)
 MANPAGE_XSL = manpage-normal.xsl
diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index 2c16c536ba..8fc4b67081 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -78,9 +78,9 @@ template::[header-declarations]
 <refmeta>
 <refentrytitle>{mantitle}</refentrytitle>
 <manvolnum>{manvolnum}</manvolnum>
-<refmiscinfo class="source">Git</refmiscinfo>
-<refmiscinfo class="version">{git_version}</refmiscinfo>
-<refmiscinfo class="manual">Git Manual</refmiscinfo>
+<refmiscinfo class="source">{mansource}</refmiscinfo>
+<refmiscinfo class="version">{manversion}</refmiscinfo>
+<refmiscinfo class="manual">{manmanual}</refmiscinfo>
 </refmeta>
 <refnamediv>
   <refname>{manname}</refname>
-- 
2.23.0

