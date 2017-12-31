Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C0331F406
	for <e@80x24.org>; Sun, 31 Dec 2017 16:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751027AbdLaQC3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Dec 2017 11:02:29 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33448 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750985AbdLaQC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Dec 2017 11:02:28 -0500
Received: by mail-wm0-f67.google.com with SMTP id g130so11158807wme.0
        for <git@vger.kernel.org>; Sun, 31 Dec 2017 08:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LH/LZ9x6B7dTWyA+COGSOKRoNXIE38KAyv6SvT6lyzU=;
        b=n9vYq4kClOijs7EmmshX5y/LNIRTUJ9a+ZEW+iWRvIITiOM4ra0cPlA5FAYSvBshW9
         76ds2mk671PRS03oMNdNug4W8N03WqnYEdEr7i6e+KBAxhyjm0JWruTKCPzvysKYAh1D
         h9cXziKv3cds8q6p29oXk2+I1eBBxQtpy+lj2JsnCSvX91ATB0+R2na/BzKbhUishF2R
         zj1ZAu2rxQeH6PXO6sQ/INW7cTytL+YE/iDVaCGTZuf3bDeBjbViYMq2vut99EB0RMyz
         8qSnUeZ2FqXAoPHsQhE4wg9RECTH1tpRKShpdS9Rf8ln+vpb8zrTMcAJllEvZHN10N/u
         ypfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LH/LZ9x6B7dTWyA+COGSOKRoNXIE38KAyv6SvT6lyzU=;
        b=FqbcqHOQqdFprjgS0pQImPuEJHUL3/S+GfcM/NxN+hEDx1RwwzNhY7bAdsQ7GBVoLM
         HRfogIe90R8FLGHYJpTH2eMrJPXRYpp2wto8nEFusy/IoYVAUGslXmK35BQ0wkD4ysNP
         GSmu8QQ/16ARqj06N2OZCJehjcdj4RbjpU1868lIPZ+vfBCFqpS1p1AY4S8yRQd7MvRh
         QRjOWT7C/XXkpqTZcdujdAmRAEn3vUSS+UnSrrdntlDIaawCQJMqAjhYkJ3QYFEDxGtG
         FBZvYl/2H5er1F+e73tIxhBRY7GnDo2uNzMyowKS+ZNyCQ4zjPCRun/YMhpX1asCxiZ8
         m3AA==
X-Gm-Message-State: AKGB3mKXjqO5QleY8H5YBhxYfmNbL6l56C9xYj8R6f3+/hFu5ZMIZkOw
        THqA3AJWbHu51hFOQljcDmpfsg==
X-Google-Smtp-Source: ACJfBosrUcD1oYmZvY7O3YRKTCajKJnvZtluWFWE3zz5PCP0zzz0M3leIOYbNjGEqyOYJWbQsWc9kA==
X-Received: by 10.28.142.75 with SMTP id q72mr31594400wmd.45.1514736146904;
        Sun, 31 Dec 2017 08:02:26 -0800 (PST)
Received: from localhost.localdomain (94-21-23-100.pool.digikabel.hu. [94.21.23.100])
        by smtp.gmail.com with ESMTPSA id x88sm12906174wrb.4.2017.12.31.08.02.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 Dec 2017 08:02:26 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 0/2] Travis CI: check unignored build artifacts
Date:   Sun, 31 Dec 2017 17:02:04 +0100
Message-Id: <20171231160206.19481-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.0.rc0.67.g3a46dbca7
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Every once in a while our explicit .gitignore files get out of sync when
our build process learns to create new artifacts, but the .gitignore
files are not updated accordingly.  It was recently that we got a report
about unignored test helper executables, see 44103f419 (t/helper: ignore
everything but sources, 2017-12-12).

This short patch series teaches our Travis CI build scripts to detect
unignored build artifacts at the end of builds, in the hope to catch
these issues earlier.

These patches should go on top 'sg/travis-skip-identical-test'.  The two
patch series are conceptually independent, but would have a couple of
conflicts when applied separately and then merged together, and I don't
think it's worth carrying them in separate branches.


SZEDER Gábor (2):
  travis-ci: don't store P4 and Git LFS in the working tree
  travis-ci: check that all build artifacts are .gitignore-d

 ci/lib-travisci.sh       | 14 ++++++++++++--
 ci/run-linux32-docker.sh |  2 ++
 ci/run-tests.sh          |  2 ++
 ci/test-documentation.sh |  6 ++++++
 4 files changed, 22 insertions(+), 2 deletions(-)

-- 
2.16.0.rc0.67.g3a46dbca7

