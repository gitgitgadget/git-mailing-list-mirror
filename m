Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CB2B1F404
	for <e@80x24.org>; Mon, 22 Jan 2018 13:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751224AbeAVNcm (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 08:32:42 -0500
Received: from mail-wr0-f176.google.com ([209.85.128.176]:42819 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750955AbeAVNcl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 08:32:41 -0500
Received: by mail-wr0-f176.google.com with SMTP id e41so8656057wre.9
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 05:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IilgHkdnPsQ6ZPa043J6nZpakE6RzjvhQNwSdJmRc1E=;
        b=KH6NyPvBhqy3DjsCxUeanADGgY/k2/GPb6rO1IsSQFgmtN+h2TbkvBKqId18AWNq+K
         aHqLqDsg3r9SqTjNtsPuv1uVkKTeHO8DeTFEE2yD7FVWjBSf2h8XchKKoa0VhIXYuiXx
         Aer5Icg66Polel7H5ZRaN6ZlQEDzDM077qHRsmWGe4Lu31HW1bT8uwdpPZXSTCZZSOzK
         OrvjVL00MsoLUysnPwbRJjTkMVwKhojnFeL44OyWHPyBAx1V+ebrCqxVUANW02LoEH3x
         PUfPKmbX2xfqUzv9/bEVT14ZJw5oVOKdZ/EGKhENNqqptCL6l30d89kjcDTtxkxK0yGv
         CJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IilgHkdnPsQ6ZPa043J6nZpakE6RzjvhQNwSdJmRc1E=;
        b=neU1Z6rdjSKCJPuIGLxDYS0qApJQw649NHlGOaBQo7gnyHBNuHNboYR91zX6SdUhFE
         lRdH+rlH0c50rZXevByMoRI2rKUdvD7tR14tiWQyEUK/qRV/DjUFsr99CiBxgUSyXQoO
         cGBKn3TO7l8LgKciUu8UrLoJlLoKDvelstciVfRCsjhNX1gAn2MF56fIKxhdQp0gVQhc
         AbbW4wrMJ7R0++zhvczQBuAWMBf6OpAQI/Z4jPV4LJRrh81QZVjOK2Yzi2bhyZl8wSBM
         qMBBapUNGDJSSY+Ouxivd5GtSg1Sgrpb98Eil71A5fRRV5UMIfNAvb15Hbt8jmhWZJiz
         wBYA==
X-Gm-Message-State: AKwxytfepUd9nPKcfCdnR38WOkgNVFmoJodKWc0IUJIRDJ5CTwgr9iXN
        TGXbwareRTXIC38t+WsqE/zOFR35
X-Google-Smtp-Source: AH8x224wmaBJt88QeDjQJ2/ee+8B7YG3I0+IGrhEsxFXNgDlT5mp1MHttXC+fvx3B38sUeA6gCTnMg==
X-Received: by 10.223.136.110 with SMTP id e43mr6112360wre.98.1516627960671;
        Mon, 22 Jan 2018 05:32:40 -0800 (PST)
Received: from localhost.localdomain (x590e64ec.dyn.telefonica.de. [89.14.100.236])
        by smtp.gmail.com with ESMTPSA id c54sm24284520wrg.68.2018.01.22.05.32.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Jan 2018 05:32:40 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 0/5] Travis CI: don't run the test suite as root in the 32 bit Linux build
Date:   Mon, 22 Jan 2018 14:32:15 +0100
Message-Id: <20180122133220.18587-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.80.gc0eec9753d
In-Reply-To: <CAM0VKjmAjw0a2JzsY1BaAwZcCp8ge+jQaGN6L_nKTLugHeWyvQ@mail.gmail.com>
References: <CAM0VKjmAjw0a2JzsY1BaAwZcCp8ge+jQaGN6L_nKTLugHeWyvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


The important one is patch 4, which fixes the issue of running the test
suite as root, with a bit of sugar on top to make sure that a future
"non-root" build job can cope with a root-written cache directory from
the past.

The rest is a collection of small cleanups and improvements to make the
debugging this Docked-based build more convenient.

SZEDER Gábor (5):
  travis-ci: use 'set -x' for the commands under 'su' in the 32 bit
    Linux build
  travis-ci: use 'set -e' in the 32 bit Linux build job
  travis-ci: don't repeat the path of the cache directory
  travis-ci: don't run the test suite as root in the 32 bit Linux build
  travis-ci: don't fail if user already exists on 32 bit Linux build job

 ci/lib-travisci.sh        |  7 +++---
 ci/run-build-and-tests.sh |  2 +-
 ci/run-linux32-build.sh   | 55 +++++++++++++++++++++++++++++++++++------------
 ci/run-linux32-docker.sh  |  7 ++++--
 4 files changed, 51 insertions(+), 20 deletions(-)

-- 
2.16.1.80.gc0eec9753d

