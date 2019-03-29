Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5330E20248
	for <e@80x24.org>; Fri, 29 Mar 2019 12:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbfC2Mfi (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 08:35:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43949 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729523AbfC2Mfh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 08:35:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id k17so2390766wrx.10
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 05:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dw8XUQv31vGhlc/arzk1yLc2F1VrYfPHX1YMJ4abEnM=;
        b=rEpCCQ+lpyVAWgL6J0l0seNjTpEvYp+AB5V9L+M6WQRGQhhYO+ry92xTCwzIRdV6iU
         1gKRDFRqTUDatXvW3k1Mx0vyAU21OCrHeVUZT7s1ESpmBjrr6cd6yuJTJ1evcHHp3+2h
         o12WE5MuuXlLbW07bWxEFgaQShgT8p4Xcmz435Z3ZD3xiQE25Wg2qYI6T/V2z3pYus3G
         3gg5PPPOdUDevAHBMu03nTxquhg9/XWCc5Jf433Q5VxLhQOaS1Wgiv2EtmErJIIPywYI
         YU+3UeeA16/HsIfiBXOYOKEYlCTRuO4hHqOIFXBb4F+g+F8lsUrylfdDMFkenCOcoHG8
         gFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dw8XUQv31vGhlc/arzk1yLc2F1VrYfPHX1YMJ4abEnM=;
        b=FmRzopZQ9qRQWkeXL5wKesJNeG4Qyh4jAYytc/qL5iw0XrlNRqMZqGYncDgjddEkze
         dCCQaOEroH3T2RMeYAPOCOyr+ud+jLyEuez14ywh7UYK1rl+ehBZG7qvgp0quy7bGhod
         TKF+TQNuknLkpZQ4G9KyMnTldwQk3+JwTZE9fBCgIrQTnP6H5ynYCWyDxhgb2zyAeZC3
         Kuu31u4Ioa01AZC+JTH+8XP2icC2hR7OBID7r3tEGdAVJPhw9GNNKKRKE4RNYFlt6Pv7
         COeXQCMOwOCeA5j4mCPKC1BIO+fVMniO2bQ8ox/B7e/7rj2PRsV6BHKCiw6bHWuRW9v0
         LuSQ==
X-Gm-Message-State: APjAAAUSrjnfZBSU3X++OT6M5uezVQpCK6OeheFusp8R49dbwCpNcVFf
        WYs4d361dnpQXr9QhXcAOwVzfAEl
X-Google-Smtp-Source: APXvYqwiB4BkyJ8vdpJZnMegaN6Uwta8JMbCaQFxHRexwCNEctxHjjKzf32N4GLNOD1GLcktsD+/cg==
X-Received: by 2002:a5d:400c:: with SMTP id n12mr30775769wrp.31.1553862935406;
        Fri, 29 Mar 2019 05:35:35 -0700 (PDT)
Received: from localhost.localdomain (x4dbd3bb2.dyn.telefonica.de. [77.189.59.178])
        by smtp.gmail.com with ESMTPSA id 61sm7341781wre.50.2019.03.29.05.35.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Mar 2019 05:35:34 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Todd Zullinger <tmz@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 4/6] ci: install Asciidoctor in 'ci/install-dependencies.sh'
Date:   Fri, 29 Mar 2019 13:35:18 +0100
Message-Id: <20190329123520.27549-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.21.0.539.g07239c3a71.dirty
In-Reply-To: <20190329123520.27549-1-szeder.dev@gmail.com>
References: <20190324215534.9495-1-szeder.dev@gmail.com>
 <20190329123520.27549-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When our '.travis.yml' was split into several 'ci/*' scripts [1], the
installation of the 'asciidoctor' gem somehow ended up in
'ci/test-documentation.sh'.

Install it in 'ci/install-dependencies.sh', where we install other
dependencies of the Documentation build job as well (asciidoc,
xmlto).

[1] 657343a602 (travis-ci: move Travis CI code into dedicated scripts,
    2017-09-10)

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/install-dependencies.sh | 3 +++
 ci/test-documentation.sh   | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index d64667fcbf..76ec308965 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -54,6 +54,9 @@ StaticAnalysis)
 Documentation)
 	sudo apt-get -q update
 	sudo apt-get -q -y install asciidoc xmlto
+
+	test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
+	gem install asciidoctor
 	;;
 esac
 
diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
index be3b7d376a..8f91f48c81 100755
--- a/ci/test-documentation.sh
+++ b/ci/test-documentation.sh
@@ -5,9 +5,6 @@
 
 . ${0%/*}/lib.sh
 
-test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
-gem install asciidoctor
-
 make check-builtins
 make check-docs
 
-- 
2.21.0.539.g07239c3a71.dirty

