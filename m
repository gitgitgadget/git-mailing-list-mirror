Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E05A21F404
	for <e@80x24.org>; Wed, 12 Sep 2018 10:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbeILPOi (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 11:14:38 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:46650 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbeILPOi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 11:14:38 -0400
Received: from lindisfarne.localdomain ([89.242.190.162])
        by smtp.talktalk.net with SMTP
        id 026Ygd54KdJAe026fgxHAu; Wed, 12 Sep 2018 11:10:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1536747046;
        bh=ISOj8r1lNNWBbFge7Vbc//zNerGrPIlBo0r9VffEVGk=;
        h=From:To:Cc:Subject:Date:Reply-To;
        b=EUnML01IExUAnaAXKxJ4L5yRMWtPqkWeHVinkZguXFh5KZ+j02OyOYG2Cie3gF5lT
         6TxD4zSfAitlu9Qkg2GPfTHzZeWA/TbM0fXc91tm6YDPxcb5iI1MTQbob/fD20Y2E0
         frRc0pa7uBaa5fv8399A0dR0fl18wSgAwNYCozVk=
X-Originating-IP: [89.242.190.162]
X-Spam: 0
X-OAuthority: v=2.3 cv=V8BTL9vi c=1 sm=1 tr=0 a=yWw/b5KBQb65dAU66aqL/Q==:117
 a=yWw/b5KBQb65dAU66aqL/Q==:17 a=evINK-nbAAAA:8 a=iuGNbSBixgLDAZXCjX4A:9
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 0/3] am/rebase: share read_author_script()
Date:   Wed, 12 Sep 2018 11:10:26 +0100
Message-Id: <20180912101029.28052-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.18.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfKTlQrVK9RgUgUVgy0iDHaN0t/MGdm2iQIWyKdBU6LI1hh8sQZirrq/yGYx5/WXZNDYNZYHSQoC6OK8FvpSJ2BsmkE7MBOBGZcZrxGKTLkE45m9b9lgV
 7ImYHez8Lvhm8ZUHWDvt+mxzmcHjBRM0KmrQstvjoGwveA1Ca31yUgj3F3rVJSdaGLjXaMRySgPDJRjkHg7SR4jPncX2VIhmN2eN6PcL/3JsYo2ulcwhrEtW
 TIrDeRyNbniR/GrYIc4q1vvNkJcu40lx1TOu9hya2n0w4BnN5F/Tr3pUNCYENdRnPX/xqpP5wg25+/z9s9rZGWSNwttvAvldRMlTK45UXZQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This is a follow up to pw/rebase-i-author-script-fix, it reduces code
duplication and improves rebase's parsing of the author script. After
this I'll do another series to share the code to write the author
script.

Phillip Wood (3):
  am: rename read_author_script()
  add read_author_script() to libgit
  sequencer: use read_author_script()

 builtin/am.c |  61 ++------------------
 sequencer.c  | 160 ++++++++++++++++++++++++++++-----------------------
 sequencer.h  |   3 +
 3 files changed, 96 insertions(+), 128 deletions(-)

-- 
2.18.0

