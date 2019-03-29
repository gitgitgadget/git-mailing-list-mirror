Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8721120248
	for <e@80x24.org>; Fri, 29 Mar 2019 12:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbfC2Mfk (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 08:35:40 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40911 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729438AbfC2Mfi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 08:35:38 -0400
Received: by mail-wm1-f67.google.com with SMTP id z24so2642447wmi.5
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 05:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mMemE2tYx2P4r8MS44OzkruoH1ouuk/8t5m3Z4hLimw=;
        b=tjc+H3sH44W8ZrglfbKUnXWiLa7EDD72ngsmZtxx9t0dkeck2voCe/ep3z7dL6gYti
         5zxYqF6cOx7zYxd9/E95/Xx521DofoOjnwwS9C4++HuBU+m0QiaCSSGNwq/ILFVnzavt
         iSNm+yUS1bWr0p0OOujpxu4gLLrBBoIQtcbh7G1OVXyLKTcDlMP8yLlgZHQ15LNpAceE
         m3/WY2Mkmbs161uFwFYeYX7eCtetgzY+fH2pEizbTM69ZgLcGaRNbc25MyuXtSRKNKFK
         Jbu3cS4dpUYWgK2gexXt126taWwrtzchGUl/wI+Malye32XhdNxAvqwH7bAdpxsOmiLS
         xiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mMemE2tYx2P4r8MS44OzkruoH1ouuk/8t5m3Z4hLimw=;
        b=pUnd3bEon2VaIMoeHEjI6odajcVHCiNf96Pi6fR8NpNQzfy9ixo6ZDJ6t5liXzG/dr
         LPVuBwEonaBsPqwzZSfNX3MvczngKE8cGqmyz65fnKHSgkn+erY8ZCbwPVnIc8QBYbwp
         GrwcmLK9xmSoDYdJHi+j9etvNYcrbMKvoBPH6U9YncifRF9rHkXIGhJwpvVDNC44+eQX
         fBElC8VQ3DQ56I4JoyOe0q1mu4we3K+LoT5/t2wAQt23TfPZiYy2ifmC81mHM9nGmUn4
         HCZ146S9QeCEBxJpm/jb3ZWAeehodz51c/tBDKtnUFdwhKDAv2vY94+ORjQWZZHn4tG8
         8jVQ==
X-Gm-Message-State: APjAAAV/feQmPcSxFLC7Zy+vkWRR+dWTXHSsKC6Hntd9CXHpAh0IIFvE
        TAdD7rpyp76LJFDv/XecI0Y=
X-Google-Smtp-Source: APXvYqyKeNvy1+RW7iWTfB1L5f7QTZQrVxANbrI4O9+n+xKh2mqO25cVl15nSbW56nKYrMwI/NCYLA==
X-Received: by 2002:a1c:a8d3:: with SMTP id r202mr3693101wme.106.1553862936502;
        Fri, 29 Mar 2019 05:35:36 -0700 (PDT)
Received: from localhost.localdomain (x4dbd3bb2.dyn.telefonica.de. [77.189.59.178])
        by smtp.gmail.com with ESMTPSA id 61sm7341781wre.50.2019.03.29.05.35.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Mar 2019 05:35:35 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Todd Zullinger <tmz@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 5/6] ci: stick with Asciidoctor v1.5.8 for now
Date:   Fri, 29 Mar 2019 13:35:19 +0100
Message-Id: <20190329123520.27549-6-szeder.dev@gmail.com>
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

The release of Asciidoctor v2.0.0 two days ago broke our documentation
build job on Travis CI, where we 'gem install asciidoctor', which
always brings us the latest and (supposedly) greatest.  Alas, we are
not ready for that just yet, because it removed support for DocBook
4.5, and we have been requiring that particular DocBook version to
build 'user-manual.xml' with Asciidoctor, resulting in:

      ASCIIDOC user-manual.xml
  asciidoctor: FAILED: missing converter for backend 'docbook45'. Processing aborted.
    Use --trace for backtrace
  make[1]: *** [user-manual.xml] Error 1

Unfortunately, we can't simply switch to DocBook 5 right away, as
doing so leads to validation errors from 'xmlto', and working around
those leads to yet another errors... [1]

So let's stick with Asciidoctor v1.5.8 (latest stable release before
v2.0.0) in our documentation build job on Travis CI for now, until we
figure out how to deal with the fallout from Asciidoctor v2.0.0.

[1] https://public-inbox.org/git/20190324162131.GL4047@pobox.com/

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/install-dependencies.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 76ec308965..52a44c690a 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -56,7 +56,7 @@ Documentation)
 	sudo apt-get -q -y install asciidoc xmlto
 
 	test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
-	gem install asciidoctor
+	gem install --version 1.5.8 asciidoctor
 	;;
 esac
 
-- 
2.21.0.539.g07239c3a71.dirty

