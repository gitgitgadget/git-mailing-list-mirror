Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6B461F404
	for <e@80x24.org>; Wed, 27 Dec 2017 16:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752004AbdL0QgT (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 11:36:19 -0500
Received: from mail-wr0-f171.google.com ([209.85.128.171]:38604 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751457AbdL0QgS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 11:36:18 -0500
Received: by mail-wr0-f171.google.com with SMTP id o2so37150560wro.5
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 08:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CCThhU3VZaOzIJGpqGASg/yOFCtd4zT75XyBpLG9OVg=;
        b=DwS+JMVxDhVrGzvsr53d3ntEBO6A7vW2vaijr1dndhGxHmdu7PUNPEsCNtXug3yJL1
         0zO9F5izH/MMjH17PybrwuPwjtps/dpTEpOXp5r1NzNntd2btvwuzB8gPauRHruhH1jz
         /yzms05EB6gSHqAfTESiGp7TCShGUnfO50GDA5L9FRUpv+hpcHvyWfbcn5L8ho6oeujK
         v2uomZoAlUs7CLy63/WpSXCo+zMdbA5q8E76nhiu4B3ICUdh1rw9BiTuEJFqp5KVJZs8
         P7QqGI2wcW4r2R7Za23dcUX5A+tbKgdnGkB53cA5zyDL8gOXQQlZJi3DWeysj8Zivc1/
         0F9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CCThhU3VZaOzIJGpqGASg/yOFCtd4zT75XyBpLG9OVg=;
        b=Rh+IPDNNxIPNLJEc5hmev90upjdlTkwlTwPe751jMu7vVpsbKuz9h5CqKEQeG3W54d
         hobxKN4gQvZCl8yn1DWJDQMZPkDugNFoMLwHuqOdgnPWxzQ7V0DSL+qvPewM6hnPzFwj
         /XURKvv1rR++aJtCXhaBXEobN2dW3G4B5dRElLckEUJ2autoh+NS7xMZxL+sAZ3IZ7c9
         WFxhPGL6JyUFpFfP0RPcc1BXVmA5OBrTTOqnlZCjlxyZQqp7eGzqZo0AdON/BoSuXkz2
         pzUZ9etVpgnWoQsN8YsyxdqJJc5qIWF76wTKp3B6hOxV3rlI9PIVmWrWDs13dgRsAPT3
         7fpw==
X-Gm-Message-State: AKGB3mIIryV/1Di6/rgsORBBvTu2YSmssUeI6XjPcQOB9I1+H8Ihv33b
        j/9L77V305bJ9mv2KjtC0Cg=
X-Google-Smtp-Source: ACJfBosXbTk+raVPqCfxZ20g5bH1g805g+8cEWcCaOdw+ou/2nFyDsK3y2uSTLmEWyAgGecf7oS8lg==
X-Received: by 10.223.184.18 with SMTP id h18mr26933489wrf.11.1514392577461;
        Wed, 27 Dec 2017 08:36:17 -0800 (PST)
Received: from localhost.localdomain (62-165-236-58.pool.digikabel.hu. [62.165.236.58])
        by smtp.gmail.com with ESMTPSA id l1sm8400557wmh.13.2017.12.27.08.36.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Dec 2017 08:36:16 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 0/4] Rest of the Travis CI fixes
Date:   Wed, 27 Dec 2017 17:35:59 +0100
Message-Id: <20171227163603.13313-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.15.1.500.g54ea76cc4
In-Reply-To: <20171216125418.10743-1-szeder.dev@gmail.com>
References: <20171216125418.10743-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These are the rest of the fixes that were in the second half of the v2
patch series but not already in 'sg/travis-fixes', which was already
merged to next, perhaps a bit prematurely.

Patch 1/4 fixes some rough edges related to tracing executed commands
according to the discussion.
Patches 2/4, 3/4 are the same as patches 5/8 and 7/8 in v2, while patch
4/4 includes the small update I sent out as v2.1 of patch 8/8.

I dropped v2's patch 6/8 (travis-ci: don't install 'language-pack-is'
package) for now: these locale-related things require more
investigation.

v2: https://public-inbox.org/git/20171216125418.10743-1-szeder.dev@gmail.com/
v1: https://public-inbox.org/git/20171211233446.10596-1-szeder.dev@gmail.com/

SZEDER Gábor (4):
  travis-ci: fine tune the use of 'set -x' in 'ci/*' scripts
  travis-ci: don't install default addon packages for the 32 bit Linux
    build
  travis-ci: save prove state for the 32 bit Linux build
  travis-ci: only print test failures if there are test results
    available

 .travis.yml               | 1 +
 ci/lib-travisci.sh        | 4 +++-
 ci/print-test-failures.sh | 9 +++++++++
 ci/run-linux32-build.sh   | 3 +++
 ci/run-linux32-docker.sh  | 1 +
 ci/run-windows-build.sh   | 5 +++++
 6 files changed, 22 insertions(+), 1 deletion(-)

-- 
2.15.1.500.g54ea76cc4

