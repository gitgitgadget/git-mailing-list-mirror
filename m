Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 811702042F
	for <e@80x24.org>; Wed, 16 Nov 2016 15:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932201AbcKPPME (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 10:12:04 -0500
Received: from smtprelay05.ispgateway.de ([80.67.31.99]:39787 "EHLO
        smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753670AbcKPPMD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 10:12:03 -0500
Received: from [84.46.92.130] (helo=localhost)
        by smtprelay05.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1c71sU-00016n-Kl; Wed, 16 Nov 2016 16:11:58 +0100
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Jens.Lehmann@web.de, Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: [PATCH v4 0/4] Speedup finding of unpushed submodules
Date:   Wed, 16 Nov 2016 16:11:03 +0100
Message-Id: <cover.1479308877.git.hvoigt@hvoigt.net>
X-Mailer: git-send-email 2.10.1.386.gc503e45
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

You can find the third iteration of this series here:

http://public-inbox.org/git/cover.1479221071.git.hvoigt@hvoigt.net/

All comments from the last iteration should be addressed.

Cheers Heiko

Heiko Voigt (4):
  serialize collection of changed submodules
  serialize collection of refs that contain submodule changes
  batch check whether submodule needs pushing into one call
  submodule_needs_pushing() NEEDSWORK when we can not answer this
    question

 submodule.c | 123 +++++++++++++++++++++++++++++++++++++++++++++++-------------
 submodule.h |   5 ++-
 transport.c |  29 ++++++++++----
 3 files changed, 121 insertions(+), 36 deletions(-)

-- 
2.10.1.386.gc503e45

