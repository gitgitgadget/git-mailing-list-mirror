Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DABF1F424
	for <e@80x24.org>; Fri, 20 Apr 2018 08:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754001AbeDTIDo (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 04:03:44 -0400
Received: from mout.gmx.net ([212.227.17.22]:59293 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753777AbeDTIDh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 04:03:37 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MCtLD-1fIXhZ3KnD-009l6R; Fri, 20
 Apr 2018 10:03:30 +0200
Date:   Fri, 20 Apr 2018 10:03:14 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Dan Jacques <dnj@google.com>
Subject: [PATCH 0/3] Some add-on patches on top of dj/runtime-prefix
Message-ID: <cover.1524211375.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DAwqhPfakyD6WLiD/lbdTJazx3NNsvoTLV+XZ2MlqpE40A4NTFS
 J4LqU/WFzoJSl3Cle/07LjfRxx7Y27qeQ1d4HHLkb5w+yVvVQPDzZzkY9IxLHaruaTVfpo2
 +trngtpptUrQCFtOMSHBph6gignSc/r1grEOzhMIPUt23qjeIyA95hVHCfXmRrimhbJMxFY
 Vbl3Px62Sq1g4YiidiyAA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Oez7aG2Ii04=:0/fo4wOGS2eIIDztCDTdQG
 5F8SIY2Q2zHWUbQC0B2PZTkYtf8gF0k0fz/L3xNrhpCmaaU5lsk6UBUpmRNdl6upybMc4Ffdu
 6Co4lmFqpBLPxjHt/boJkenqHp/qUOoJoR1axVlUIgB1XlUlT3JZQg1vz9JA8nZ1BQlGq1fc2
 icPI8Y0Wu72R0EiOdavvBtCAS6eb6b5/ZbcayDEDMWUcMmQcMT5bfSNlDoT4L8z3MEf5LZo4j
 gD0OW3E/oofcb3wzMh2S304su6EQlaY+GC1c7qCK1JBNrkad8HzMaUJ9Y9GRnMTZXQrJt1vbs
 EG/ufj0iW1i/XLN9gWBhNT2vN/1GF8eBKS6xbbHYbpeuIUGVjgOs887IXRWuR5tGKXpjF9p/l
 PSF8XIoIZfKNdzKTlbTEuYnwXLNI5EYFARJPB4ZJuYn0PAgLkS16NjqsuVbwFJKDbNUkLutjM
 kyfppeK73IJ6CfFaz0Ek5rFukcnK6yoPEJlGtFOCTzOfhdStHCkckPRkcaCRvWIieQdu00Rx9
 Bl5y7OpnXPlVV7SA2NSq3Ti5XZAWQ3A7HFYjNBrysJAx2ecfoZiLG2exnvjB/ichf/THCyW4u
 Lc0XDVDH8wruVpxNBdqtfg1Ic2qjDjLLlDZ1oQ54muS3dA/fRM3NP/ZLP8ubOKyVui7JdzQQN
 f3mgokn0ZXzTeZHUqE7DRoDLNW/ZzoYa1ek82E7OVJE3d2veY4NhlcOo+hxZr+8UftI/5oSis
 o2TD3Ku0e87fwjchD2ohWWh6CFUoK/Eqdq9kzWFAqwS91AMXS+w+uIGE2018j9WDhrHH6dSxI
 Aqnlx7DNq74N15mMvaeciPgv6O3i1qw6VGdtaAwLHie/g7pktU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We carried a slightly different version of the git_setup_gettext() patch
(which took care of releasing the buffer allocated by system_path()),
and we carry two more patches that touch the same area, so now that
dj/runtime-prefix hit `next`, it seems a good time to contribute those,
too.


Johannes Schindelin (2):
  gettext: avoid initialization if the locale dir is not present
  git_setup_gettext: plug memory leak

Philip Oakley (1):
  Avoid multiple PREFIX definitions

 Makefile   |  2 +-
 exec-cmd.c |  4 ++--
 gettext.c  | 10 +++++++++-
 sideband.c | 10 +++++-----
 4 files changed, 17 insertions(+), 9 deletions(-)


base-commit: 8a3641ab3abcf492e9443f88d82a7a22fa8b4816
Published-As: https://github.com/dscho/git/releases/tag/runtime-prefix-addons-v1
Fetch-It-Via: git fetch https://github.com/dscho/git runtime-prefix-addons-v1
-- 
2.17.0.windows.1.15.gaa56ade3205

