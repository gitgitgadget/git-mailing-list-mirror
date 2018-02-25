Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF52D1F404
	for <e@80x24.org>; Sun, 25 Feb 2018 19:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751973AbeBYTrh (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 14:47:37 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33080 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751945AbeBYTrU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Feb 2018 14:47:20 -0500
Received: by mail-wm0-f65.google.com with SMTP id s206so14153226wme.0
        for <git@vger.kernel.org>; Sun, 25 Feb 2018 11:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=/ygaY3lDYxQBoJk65BzqonVAssYfwwbhbfWJu7zVayA=;
        b=LunMyK3sqKPduovczv5Lx4ZCRtq73pFs5SPvoWvs4N4Clg2uEIso9d06JSRImnkrRj
         miSpW0/uv/hC1PYMTqOS7TPvTr4yRKNQismZGtcexYAb1UOOkY6ayXMtx0EwYJQJR/rv
         sWRiwM+3SZKg9tE5jIL4e/7YOPFkI8doTZ6altVmcgowhOXN4XxiiRRhsD5PM2zdg/kq
         j482G/pL6pqKAMDCuhU7v0YfTypEf+CLg83HwNNHI1rExb6De3V9/0nCgvWY5fGKwhdp
         QLuWzYqYc0hfJisIOm2dRkxQIikcvKhj7MHCHyKip11Z0iTlkE4u94PvjvRWZyJ+9ban
         J6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/ygaY3lDYxQBoJk65BzqonVAssYfwwbhbfWJu7zVayA=;
        b=p83s+TGmgITW0LoYfh/lkuFKWXMGcDjYC//NdjzgPIOMb6Ak1j3+8j3vPcSo3pGQmb
         wOI0alpRU1z43D966VkE1AQWlRSLMHWxjbQ57XNWLALbN/b/7Nm0hY19VjAkfDckvFQq
         pzEKGf88l4+jPLKlj9bofna7BmRq9iTNTeApkZnh90Qnk7wnNcGdCsDbfRmTRunZkeL/
         EUOS0Dw1lUTM6sxtxcD33UXz8Ia9/q6EpequtoA4L85OnYgzyOtqopYMzTRYsE9ldpJA
         ljZFxMFKjyDU2WUkR4H5KTLkZ6tJbgqP2bsZoP7o4Vd8bHAE1PrP9u7uft55hCKqbQvD
         jJEQ==
X-Gm-Message-State: APf1xPDfR1yTxpfUU7Pd39PJVRB0j7RYjVufeKiGYpuOsXMeDOjxZjWY
        Wl98QfPUULIm6wM5O7oR/74jfbln
X-Google-Smtp-Source: AG47ELvw1WwaZMLgGcAtWh8qpTJsZ1XpXHfIa5RXxKhzc+QdekxnpmmzPdcaUoPkqhfDXEzaCC6gbw==
X-Received: by 10.28.69.65 with SMTP id s62mr6602372wma.78.1519588038987;
        Sun, 25 Feb 2018 11:47:18 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b66sm4394003wmg.28.2018.02.25.11.47.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Feb 2018 11:47:18 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>, Petr Baudis <pasky@ucw.cz>,
        Benoit Bourbie <bbourbie@slb.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Todd Zullinger <tmz@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "Randall S . Becker" <rsbecker@nexbridge.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 12/13] Makefile: add NO_PERL_CPAN_FALLBACKS knob
Date:   Sun, 25 Feb 2018 19:46:36 +0000
Message-Id: <20180225194637.18630-13-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180225194637.18630-1-avarab@gmail.com>
References: <20180225194637.18630-1-avarab@gmail.com>
In-Reply-To: <20180214222146.10655-1-avarab@gmail.com>
References: <20180214222146.10655-1-avarab@gmail.com>
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
index 7b97699864..518c5f6be0 100644
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
@@ -2305,8 +2311,10 @@ LIB_CPAN_GEN := $(patsubst perl/%.pm,perl/build/lib/%.pm,$(LIB_CPAN))
 
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

