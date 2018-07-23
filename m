Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AD5F1F597
	for <e@80x24.org>; Mon, 23 Jul 2018 13:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388129AbeGWOxS (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 10:53:18 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39020 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387940AbeGWOxS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 10:53:18 -0400
Received: by mail-ed1-f68.google.com with SMTP id h4-v6so1030366edi.6
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 06:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i2Yu263LUkSLklS9WA8GJsPOIf7Kz73vZf0PoFt0FYI=;
        b=OIb8cOcm3LbA3qE9axvKpXxWbAX8wvp/zV5l0XuySKi3xHq1w2363QfwvXarvmjG6i
         0hu2PzTop4pBqj5eXOHIn5hZMJpzQYNcRq/P21IFX+a+Xg5bR1uj3ZeGs0mlQwOHzeuQ
         +XFjjkkiuG6rDY1GOW1plBc1dhePOE6Ask7hrnxz5t8kfSc4zYUyTo2fFwaMShSUMvvm
         7ueCEwQ9HoImTY4I/w9t4iqqvbENkUxJiY5PYfvTxpGdhh9sX0i9lUWgMDjnSGsWZh3C
         uoi2gcCPrKMDCGts/IUuNrurm4u7xEtTwQxCUAK4GWMQq0+L3eAsbzw1Mn05DA7Kb+HX
         /98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i2Yu263LUkSLklS9WA8GJsPOIf7Kz73vZf0PoFt0FYI=;
        b=gN9SRrJ3bqTLjcT1VHsH+gUNzqHI+sPRB7eAV8fBqAEF+jDFhAbg2l1qhqGEHgYx/k
         yr2JLxb71jwb6ES5cT7AJfAiudqsnsFfvwLkenj4GkXXMWjMDgXpmC6p/bTTyVbeAjP0
         gNWL0amvwVSFI1cQ+OPbFmdDFMx7cXjGsgu0h9AOQfS60nvLlDUDxfg6FJhu7c1MIwA+
         NXOZ4Tp8CQ5HHN63Weq1UcotdzmdBf8wNydLI/S8QtuWIV4VyVxQUXn/N6JPv2KwfiqQ
         57B1EG6sjZAz1TqjnB2cU08yVA7FPXhLMVnC84h9O7ed5ZHn/hazv++yErqn4jAK7ar+
         mQuw==
X-Gm-Message-State: AOUpUlHYfcBVs2gBq9fqtPYRFk1avmvJ3UBZBXGEv6ChYoOBzuiKR4GN
        q45SPmz/KX1XU//8ckGMR0k=
X-Google-Smtp-Source: AAOMgpdd6pyCYRxEWLaTHqytyJOAsA8yg6YBVzCVIbkZ/RrDdMF+cwE8pEHrbF3nRdzvQDMS/FIQwQ==
X-Received: by 2002:a50:c19a:: with SMTP id m26-v6mr13856477edf.151.1532353915447;
        Mon, 23 Jul 2018 06:51:55 -0700 (PDT)
Received: from localhost.localdomain (x590d0011.dyn.telefonica.de. [89.13.0.17])
        by smtp.gmail.com with ESMTPSA id a11-v6sm494277edn.95.2018.07.23.06.51.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jul 2018 06:51:54 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 5/5] coccinelle: extract dedicated make target to clean Coccinelle's results
Date:   Mon, 23 Jul 2018 15:51:00 +0200
Message-Id: <20180723135100.24288-6-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.408.g42635c01bc
In-Reply-To: <20180723135100.24288-1-szeder.dev@gmail.com>
References: <20180723135100.24288-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sometimes I want to remove only Coccinelle's results, but keep all
other build artifacts left after my usual 'make all man' build.  This
new 'cocciclean' make target will allow just that.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Makefile | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 72ea29df4e..aee629cbaf 100644
--- a/Makefile
+++ b/Makefile
@@ -2903,7 +2903,10 @@ profile-clean:
 	$(RM) $(addsuffix *.gcda,$(addprefix $(PROFILE_DIR)/, $(object_dirs)))
 	$(RM) $(addsuffix *.gcno,$(addprefix $(PROFILE_DIR)/, $(object_dirs)))
 
-clean: profile-clean coverage-clean
+cocciclean:
+	$(RM) contrib/coccinelle/*.cocci.patch*
+
+clean: profile-clean coverage-clean cocciclean
 	$(RM) *.res
 	$(RM) $(OBJECTS)
 	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(VCSSVN_LIB)
@@ -2915,7 +2918,6 @@ clean: profile-clean coverage-clean
 	$(RM) -r $(GIT_TARNAME) .doc-tmp-dir
 	$(RM) $(GIT_TARNAME).tar.gz git-core_$(GIT_VERSION)-*.tar.gz
 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
-	$(RM) contrib/coccinelle/*.cocci.patch*
 	$(MAKE) -C Documentation/ clean
 ifndef NO_PERL
 	$(MAKE) -C gitweb clean
@@ -2931,7 +2933,7 @@ endif
 	$(RM) GIT-USER-AGENT GIT-PREFIX
 	$(RM) GIT-SCRIPT-DEFINES GIT-PERL-DEFINES GIT-PERL-HEADER GIT-PYTHON-VARS
 
-.PHONY: all install profile-clean clean strip
+.PHONY: all install profile-clean cocciclean clean strip
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
 .PHONY: FORCE cscope
 
-- 
2.18.0.408.g42635c01bc

