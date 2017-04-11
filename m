Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDC611FAFB
	for <e@80x24.org>; Tue, 11 Apr 2017 07:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753903AbdDKH0l (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 03:26:41 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34400 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751527AbdDKH0k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 03:26:40 -0400
Received: by mail-wm0-f65.google.com with SMTP id x75so13291378wma.1
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 00:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wWKLnhc3KgOSpRGYuIyEXB+Q7hEPfFr0w7id3mO6kUA=;
        b=DX21gbpTRH/KxwXeg1fxPERPx55tpjKZ5qeprSBlz/df8yCKUu9ZuPos6nYocqbTts
         JWRoIXtYIFrVWBG5teyYbvg+J8pUSNtU6Kvin6tbI4HTFA2/obVPjNzQD+TLu9y8ch0D
         ICAuti3Y9uA2QXnjhpn0IU6PYLQ6A8owC0aC6Bm73P7As5fff8zXfi1yAjHh5v2zKNco
         N8O2TAJ42PKTp6Io1lcW7t92XonQRpzOCgpPjpbJ99GgikGtTQJDyUK1F/c2CAHpGbHN
         xEG9+r2nfUwBILttjCayEdvtWUgZe6ASqNgUs6i6/YpWrVu1VNAYR9+NcBQNNTMuQuGT
         3k0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wWKLnhc3KgOSpRGYuIyEXB+Q7hEPfFr0w7id3mO6kUA=;
        b=eeHbVhZOrfKo0RQBeQWBQolpvZMeNUI22Srx6DsjvcwySNIW1wH2koqUM4ohFJDARm
         RFCbxN0+sfOdGUhujs8Scf54A0YbyNAMkl8IyEWh8b/d4eeM3V8ZtEbJmrDCOR7TNl7+
         ZBrQVwWSLnfMp3Z9Yu/eNNGwLfjycR+aqsanejMWG/skZK+613F9jk3fUzbfTEfMBiHZ
         FS6zLdTuzeOrh2HcHUlSGP2oS5hPJ5qoqGqPg8aD5LWE87x1gSwt2jSvhsXATZYijqMv
         xdqLYaiaD9IpLkXN3+SrCaVloEiUErSsxV5ON1EgQt7iJeIzeavi2YSmHsPFPKsMnalX
         bIdg==
X-Gm-Message-State: AN3rC/56wQKeKfRlns7bRWIhrIY7Uj2/Nfy9G0+NqrXvnbloX1ivlvYK
        zQjrpqUZA9i3XA==
X-Received: by 10.28.214.3 with SMTP id n3mr13443319wmg.67.1491895599273;
        Tue, 11 Apr 2017 00:26:39 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB53F4.dip0.t-ipconnect.de. [93.219.83.244])
        by smtp.gmail.com with ESMTPSA id l132sm1288171wmd.10.2017.04.11.00.26.38
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 11 Apr 2017 00:26:38 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, l.s.r@web.de
Subject: [PATCH v1] travis-ci: add static analysis build job to run coccicheck
Date:   Tue, 11 Apr 2017 09:26:37 +0200
Message-Id: <20170411072637.57369-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.12.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a dedicated build job for static analysis. As a starter we only run
coccicheck but in the future we could run Clang Static Analyzer or
similar tools, too.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

Notes:
    Base Ref: master
    Web-Diff: https://github.com/larsxschneider/git/commit/f191458df1
    Checkout: git fetch https://github.com/larsxschneider/git travisci/cocci-v1 && git checkout f191458df1

 .travis.yml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 591cc57b80..52855c806c 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -60,6 +60,18 @@ matrix:
         # Use the following command to debug the docker build locally:
         # $ docker run -itv "${PWD}:/usr/src/git" --entrypoint /bin/bash daald/ubuntu32:xenial
         # root@container:/# /usr/src/git/ci/run-linux32-build.sh
+    - env: Static Analysis
+      os: linux
+      compiler:
+      addons:
+        apt:
+          packages:
+          - coccinelle
+      before_install:
+      script:
+        # "before_script" that builds Git is inherited from base job
+        - make coccicheck
+      after_failure:
     - env: Documentation
       os: linux
       compiler: clang

base-commit: b14f27f91770e0f99f64135348977a0ce1c7993a
-- 
2.12.2

