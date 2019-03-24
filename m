Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D08C4202BB
	for <e@80x24.org>; Sun, 24 Mar 2019 21:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbfCXVzy (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 17:55:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43301 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfCXVzx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 17:55:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id d17so7890003wre.10
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 14:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SCIr/TB+jM1CYAcBRe+9fOnzhirLLs7fyiJlgw3UgHo=;
        b=osIwjkYJpwAcQIa6LH03ZmhUTkvvgD8qwbuUqy0oTwifIYF4SB+UtBj5/X2SeTUCyd
         UhugAGFQ4rzcrJ29SNi7IuiiN6N8FkNrbWDqOyk+mT/8aNiBWc3Az8Jp/+zPYm3aNZRw
         tPRJSGBaQ9PMrEDnWvXsAFOIfipm7ryFYDsO7YFm6Jyyw/pWTIyH73UEVF1DQe6P909O
         rQ32U8Tf5NUoDTcvCBQtBGo/sF1GpuX30JVsw9mxhmvgGJVJTzS1Sil3+8PbR9kI4cOD
         huZaYykPnI0/dsEkLCuVS9/6BhmwCcbRHAVgDWAOEc6ZSrugNdL6mS6MAKPlF/qBdO3l
         AC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SCIr/TB+jM1CYAcBRe+9fOnzhirLLs7fyiJlgw3UgHo=;
        b=TFzK1M9U/SpKyDZWmFpIadB0do4IzpSHTzUCfQJooxI1HQKeA8g59sr2ErCLJThxSd
         gfqc1LbIgBlzd82rPkvLE6Uy545xhAL+AZZeCdjM7h+YuBVK5ruiWEC4iAH5GWrVFOF5
         oSwS8ajGLdd9VE9Qvgbd4g+98/3qui7lBDNd+PURr2bw53hhB6qtwa14mtGUrnj9p6Fz
         hfy1WdexYAJGWa6zC+/bV8navQ9LXAPOXFqUFiKRsb9hiqBH2DcIyiZHp4G4/X7koTMw
         sVQWb6lss+d5X9pK8u7F2Sr/LzaU+eEjdS3n2jKJ6p/Xz2Byq1WL1T2tbxS5YrWkICEd
         MjOw==
X-Gm-Message-State: APjAAAVSQw6R8HC3q5YS1iitaoPuSASJPn0Sm3AZZBM8j+ncAvdcCRoU
        UC/dLrL06EHU9zI5reMNCyHCjK2P
X-Google-Smtp-Source: APXvYqwEkNws/I0SSQEfI3Lx5OyMj3rEIDWtv6bBB6FpMNqsCVAFnPOT5JiOX9bpCT8i3ZmW+KJDyQ==
X-Received: by 2002:adf:9c85:: with SMTP id d5mr13444217wre.68.1553464551681;
        Sun, 24 Mar 2019 14:55:51 -0700 (PDT)
Received: from localhost.localdomain (x4d0c479e.dyn.telefonica.de. [77.12.71.158])
        by smtp.gmail.com with ESMTPSA id o17sm15023530wrw.73.2019.03.24.14.55.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Mar 2019 14:55:51 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Todd Zullinger <tmz@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 4/6] ci: install Asciidoctor in 'ci/install-dependencies.sh'
Date:   Sun, 24 Mar 2019 22:55:32 +0100
Message-Id: <20190324215534.9495-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.21.0.539.g07239c3a71.dirty
In-Reply-To: <20190324215534.9495-1-szeder.dev@gmail.com>
References: <20190324155219.2284-1-szeder.dev@gmail.com>
 <20190324215534.9495-1-szeder.dev@gmail.com>
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

Install it in 'ci/install-dependencies.sh', where we install
everything else.

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

