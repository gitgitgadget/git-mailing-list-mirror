Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68AFF1F404
	for <e@80x24.org>; Sat,  3 Mar 2018 15:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932148AbeCCPj3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 10:39:29 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53713 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932140AbeCCPj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 10:39:26 -0500
Received: by mail-wm0-f66.google.com with SMTP id t74so8328113wme.3
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 07:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=QE+RWuiGeoXd7wBA4ekJW5xigyTDYoTD1Le1rIL94LY=;
        b=cJKlN5mOAmeVlueCmLXtqBgqDB5YI5lg4v2K4CYrl/4Ejfu4LQlnKMJ2B0eVdmJRBS
         iLsgkLzv37xRpluhwn1O3KtdF30fRoJMUfBAo8AsDllIvKBMFd7vlBJSCGFe4YwrLtoU
         KiRPJNKT/CpsyORvAgS1SpLG4fNSMBnrRLvbvdpkDW7KMt4rqkFRTyDY6QsKshW9QMIR
         MXei2X2Mabt4G8zMouN08m32ZgxcN5T4CHjd27hlToYTWad+Im5dQvVJJH8pWUEqULYN
         VSia/waD0yooSyPQ1SbVFD2mvm3HH78Dnf8VjuIpDenuiNY11P88iKmh0f0mwwEPHIDo
         fEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QE+RWuiGeoXd7wBA4ekJW5xigyTDYoTD1Le1rIL94LY=;
        b=eiUx2PoJmk7kIFikZFtlJ5AiJ9UUJAfDN1X0g7IPmfmP/Vo0uINLlFL4pT7amOanv8
         0CMgZLtI+azgWhW8hWBoQBkSBzX2qeXuV2pdAfe1ha+UWfbVbOqW2LUz4T8TAy0XVAvf
         gKW7bidC4TDGJlZnYtuCXapZsG+4UHLadPHmRZBKpRNntbSd9ePEMcpz6/QvnIF09hjf
         aPfyyAnrsMNAN5G7zoZfZxo1Hx4m4LkeUPiBcX/cYEyP64gFHpymc+ZO33UrTc1fWl5Q
         QeFx9y2rCxAfdLdeTQAtJnsZNJYqI7nhez+gdlYoBcmckDS7/vuQXRXrSSm8GCBxrNku
         Us3g==
X-Gm-Message-State: AElRT7FAcGpNQ9HNlg/l3Z8qfjpVE+N0dHck8PLaeH4XaLa/yR7kDlDQ
        qVCTh+2c6u77be6Cf2031NfEDy+O
X-Google-Smtp-Source: AG47ELvg7zbsQKg5tKJkABqVx5ckDu81mZ6xZSisAWCfn5fRJ2jKn6Wb2JR/1EC8AbKOj73dD9oZIw==
X-Received: by 10.28.190.19 with SMTP id o19mr4088087wmf.53.1520091564581;
        Sat, 03 Mar 2018 07:39:24 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y1sm6899379wrh.80.2018.03.03.07.39.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 07:39:23 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>, Petr Baudis <pasky@ucw.cz>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Todd Zullinger <tmz@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "Randall S . Becker" <rsbecker@nexbridge.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 12/13] Makefile: add NO_PERL_CPAN_FALLBACKS knob
Date:   Sat,  3 Mar 2018 15:38:16 +0000
Message-Id: <20180303153817.20270-13-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180303153817.20270-1-avarab@gmail.com>
References: <20180303153817.20270-1-avarab@gmail.com>
In-Reply-To: <20180225194637.18630-1-avarab@gmail.com>
References: <20180225194637.18630-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Todd Zullinger <tmz@pobox.com>

We include some perl modules which are not part of the core perl
install, as a convenience.  This allows us to rely on those modules in
our perl-based tools and scripts without requiring users to install the
modules from CPAN or their operating system packages.

Users whose operating system provides these modules and packagers of Git
often don't want to ship or use these bundled modules.  Allow these
users to set NO_PERL_CPAN_FALLBACKS to avoid installing the bundled
modules.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Makefile b/Makefile
index 026b9fb6d6..cbf0bc2344 100644
--- a/Makefile
+++ b/Makefile
@@ -296,6 +296,12 @@ all::
 #
 # Define NO_PERL if you do not want Perl scripts or libraries at all.
 #
+# Define NO_PERL_CPAN_FALLBACKS if you do not want to install bundled
+# copies of CPAN modules that serve as a fallback in case the modules
+# are not available on the system. This option is intended for
+# distributions that want to use their packaged versions of Perl
+# modules, instead of the fallbacks shipped with Git.
+#
 # Define PYTHON_PATH to the path of your Python binary (often /usr/bin/python
 # but /usr/bin/python2.7 on some platforms).
 #
@@ -2307,8 +2313,10 @@ LIB_CPAN_GEN := $(patsubst perl/%.pm,perl/build/lib/%.pm,$(LIB_CPAN))
 
 ifndef NO_PERL
 all:: $(LIB_PERL_GEN)
+ifndef NO_PERL_CPAN_FALLBACKS
 all:: $(LIB_CPAN_GEN)
 endif
+endif
 
 perl/build/lib/%.pm: perl/%.pm
 	$(QUIET_GEN)mkdir -p $(dir $@) && \
-- 
2.15.1.424.g9478a66081

