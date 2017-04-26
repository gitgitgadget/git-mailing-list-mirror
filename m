Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 059F6207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 19:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966099AbdDZTTB (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 15:19:01 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36576 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965488AbdDZTTA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 15:19:00 -0400
Received: by mail-wm0-f46.google.com with SMTP id u65so59651607wmu.1
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 12:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kdzrxPY1X3HhVqw0mh3WKU9pH+4sXgxRMGl6WRyf5Rg=;
        b=Nl9yG7Ue5WFrPvRvzkTEA6zZuUKA9kvSBr70TlYz2Zxdnm7hmUcJbtrqAX5Pia6wDj
         Z074fytoUzb7G2JSCXTA45pZtVzZ8l0YgQHxZxY3C9GA30CJ/XfY31ifCdsDA/aPpg9O
         Y7TRycq3ejIiZXzvOUP1LYm5Gv/FrmXJJez5qHZPimrXnWOG0ZswFih8PbGnpeKqUTCD
         fUohoEUbwcCm53rEa3gcKNBxI01f005RRWHZVYgJ3vtqFI4yr+qPUBdRx7k284wffxhI
         khGGxQwMbbrOuH2AmAplAbV11hZtZShPZEhPu94mFB7FFPdKWtl0Is8L8qg4F/hx3OEe
         neDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kdzrxPY1X3HhVqw0mh3WKU9pH+4sXgxRMGl6WRyf5Rg=;
        b=AEzqmI1vMcydF8imNAKFlMND7AQ+P4UpMl9Y2QVsNoM41g0Yelr7ofK0BPvyaKgBFe
         uMOTYAj+5hzT2GAacj9AEwx7zEuFukEEFqzqAtgkV5ISiqvgdqUY42uGUumKv+HMN/1u
         AyKHcBIIMs1VH06e+dwB5E1yrIbYGAOQ1sCZ8x0rSZs72KQSSMCwQ/z9GX/9A+ipVqM1
         1qeKYWf0M5NaXzTygzKRJRHCTB6eetNk9PmnWv7W6Zc8bmY0+vVg7XqZPh5Eufmu4nJW
         6UWhmOMjaIgkUBZrdSOS8UGhfSHFecyxiZ2AKpzWOhwrzxo18xqvTq+N0hFlOWaIEStZ
         aghQ==
X-Gm-Message-State: AN3rC/5m9w2Gyk5c3ShyLq7W5BlVwHr8zSs1hUsD8axPU7h4KVQerw0x
        r9NZz0oNZ0fTYAOC
X-Received: by 10.80.147.89 with SMTP id n25mr2031699eda.69.1493234338691;
        Wed, 26 Apr 2017 12:18:58 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id 4sm157580edt.64.2017.04.26.12.18.57
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 26 Apr 2017 12:18:58 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v1] travis-ci: set DEVELOPER knob for Linux32 build
Date:   Wed, 26 Apr 2017 21:18:57 +0200
Message-Id: <20170426191857.27928-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.12.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The Linux32 build was not build with our strict compiler settings (e.g.
warnings as errors). Fix this by passing the DEVELOPER environment
variable to the docker container.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

Notes:
    Base Ref: master
    Web-Diff: https://github.com/larsxschneider/git/commit/67bf8334d6
    Checkout: git fetch https://github.com/larsxschneider/git travisci/linux32-dev-v1 && git checkout 67bf8334d6

 .travis.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.travis.yml b/.travis.yml
index c757a111ce..658a219ee1 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -61,6 +61,7 @@ matrix:
         - >
           docker run
           --interactive
+          --env DEVELOPER
           --env DEFAULT_TEST_TARGET
           --env GIT_PROVE_OPTS
           --env GIT_TEST_OPTS

base-commit: e2cb6ab84c94f147f1259260961513b40c36108a
-- 
2.12.2

