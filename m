Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FCAF2021E
	for <e@80x24.org>; Tue, 15 Nov 2016 14:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752232AbcKOO4z (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 09:56:55 -0500
Received: from smtprelay06.ispgateway.de ([80.67.31.102]:41889 "EHLO
        smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751981AbcKOO4x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 09:56:53 -0500
Received: from [84.46.92.130] (helo=localhost)
        by smtprelay06.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1c6fAG-0002o3-EB; Tue, 15 Nov 2016 15:56:49 +0100
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>, Jens.Lehmann@web.de,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: [PATCH v3 0/4] Speedup finding of unpushed submodules
Date:   Tue, 15 Nov 2016 15:56:13 +0100
Message-Id: <cover.1479221071.git.hvoigt@hvoigt.net>
X-Mailer: git-send-email 2.10.1.386.gc503e45
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

You can find the second iteration of this series here:

http://public-inbox.org/git/cover.1475851621.git.hvoigt@hvoigt.net/

All mentioned issues should be fixed. I put the NEEDSWORK comment in a
seperate patch since it seemed to me as if we did not fully agree on
that. So in case we decide against it we can just drop that patch.

Cheers Heiko

Heiko Voigt (4):
  serialize collection of changed submodules
  serialize collection of refs that contain submodule changes
  batch check whether submodule needs pushing into one call
  submodule_needs_pushing() NEEDSWORK when we can not answer this
    question

 submodule.c | 120 +++++++++++++++++++++++++++++++++++++++++++++++-------------
 submodule.h |   5 ++-
 transport.c |  29 +++++++++++----
 3 files changed, 118 insertions(+), 36 deletions(-)

-- 
2.10.1.386.gc503e45

