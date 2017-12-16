Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B662D1F406
	for <e@80x24.org>; Sat, 16 Dec 2017 12:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753278AbdLPMye (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Dec 2017 07:54:34 -0500
Received: from mail-wr0-f171.google.com ([209.85.128.171]:44153 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752388AbdLPMyd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Dec 2017 07:54:33 -0500
Received: by mail-wr0-f171.google.com with SMTP id l11so4162440wrc.11
        for <git@vger.kernel.org>; Sat, 16 Dec 2017 04:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BSHJHIlj3mhWan9dGfTcmn6la45tXGec1AbbTaMkFR8=;
        b=Bvzjshg/IZCHeQNCnDYm0If5LQ/RdUp5sTJi2lXODW4kKFqXTpJyejJ9HzmucV/1Fc
         Ppp8G34OMCNWP+7qDWLVmA0Bhz6GisJJcOUUJlqhrq7Ae+hGPXH9n1Q3d0K66CPk7ikJ
         yfI6hjHJ4k26XXxN9Evun+hc7R2bubPq6hTw7ayF+uh49g3iRweGzkwVpoUfrPNQ/Ptc
         KmkoOdgeRLZPqooSOT0g81UD86/+fS5Ho6ANkKC15mvuqVyN1NSMZusL1JJkqpnAn4Mz
         4r/IbyyCdkH4BfOHwSMkUFfROgN4fiAcbb6uv+hQrEp1XI5aRhO0UqIff3EuGGBDbUxY
         NZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BSHJHIlj3mhWan9dGfTcmn6la45tXGec1AbbTaMkFR8=;
        b=H+MpNktOEPKRB5XhcIJ6jZZBAW+AYguA9NbT5CZBUpRgjjWFHiwRBimjmgcT6fMyTM
         tNsoAzsoZZZ4BVhKiYub9x1+hHYgWfv2zRUkDMYyezTVzet0FPC/vU/ZrQRKM6IARdo3
         kj89n1HdoDSgFe+PQDcjSs7t1/rhk3w5jvhiDh5155stUzvkH6nOxhJhgZitkjOs+rKB
         3Z2VIGdv8Kq1PFgESRr+AmVjrljpKJvQSESlTpYKMsCg+VqMH8DVrzUo74vU1ry1SvQ0
         wQIfByYIcE69BmY21BvJGldUTaozNmITo+pasziPBN0M+OG18seN6ce2NWebQtDmepRb
         8qKA==
X-Gm-Message-State: AKGB3mKWaPgkCOasuXYa/mjIc2dUt1kZTpY1pW8LKZO5oNRKuksLiiTa
        HmX4WCqdqsT3i0jxN27+xCA=
X-Google-Smtp-Source: ACJfBotwxtMfzeSoa2x5kujrBM0WpdyJWx7aKlfx/c/M3RQZ8ODpFLEf4eUsX2kpR1MEapvpgTcp/w==
X-Received: by 10.223.157.27 with SMTP id k27mr11099168wre.153.1513428871986;
        Sat, 16 Dec 2017 04:54:31 -0800 (PST)
Received: from localhost.localdomain (x590e5997.dyn.telefonica.de. [89.14.89.151])
        by smtp.gmail.com with ESMTPSA id u33sm11236485wrb.68.2017.12.16.04.54.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Dec 2017 04:54:31 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 0/8] Travis CI cleanups
Date:   Sat, 16 Dec 2017 13:54:17 +0100
Message-Id: <20171216125418.10743-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.15.1.429.ga000dd9c7
In-Reply-To: <20171211233446.10596-1-szeder.dev@gmail.com>
References: <20171211233446.10596-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a reroll of 'sg/travis-fixes'.

Changes since the previous round:

 - Patch 1 got updated following the discussion:

   - I went with enabling tracing executed commands everywhere,
     including the Windows build job, except where we know it causes way
     too much clutter, which is currently only
     'ci/print-test-failures.sh'.

   - Also enable this tracing in 'ci/run-linux32-build.sh', which
     doesn't source 'ci/lib-travisci.sh' as it's run inside a Docker
     container.

   - The commit message got updated accordingly, including a note about
     the Windows build job's secret token.
     I would like to get an Acked-by: from Dscho on this patch before it
     gets merged.

 - Patches 5-8 are new.  They are various fixes/cleanups unrelated to
   the Travis CI scriptification, but I don't think it's worth to have
   them in separate patch series.

SZEDER Gábor (8):
  travis-ci: use 'set -x' in select 'ci/*' scripts for extra tracing
  travis-ci: introduce a $jobname variable for 'ci/*' scripts
  travis-ci: move setting environment variables to 'ci/lib-travisci.sh'
  travis-ci: set GIT_TEST_HTTPD in 'ci/lib-travisci.sh'
  travis-ci: don't install default addon packages for the 32 bit Linux
    build
  travis-ci: don't install 'language-pack-is' package
  travis-ci: save prove state for the 32 bit Linux build
  travis-ci: only print test failures if there are test results
    available

 .travis.yml                | 28 ++++++----------------------
 ci/install-dependencies.sh |  8 +++-----
 ci/lib-travisci.sh         | 38 ++++++++++++++++++++++++++++++++++----
 ci/print-test-failures.sh  |  9 +++++++++
 ci/run-linux32-build.sh    |  3 +++
 ci/run-linux32-docker.sh   |  1 +
 6 files changed, 56 insertions(+), 31 deletions(-)

-- 
2.15.1.429.ga000dd9c7

