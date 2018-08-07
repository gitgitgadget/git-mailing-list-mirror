Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4175D208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 09:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeHGLsf (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 07:48:35 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:21562 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbeHGLsf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 07:48:35 -0400
Received: from lindisfarne.localdomain ([92.22.26.195])
        by smtp.talktalk.net with SMTP
        id myOIfyQGYbZX5myOOf3snz; Tue, 07 Aug 2018 10:35:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1533634505;
        bh=cUh7Slbq3sMG4B17wSF2X3iN1ytAoy/YWXIzNLBvhu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=W3R9rEY33h8fGV+Hd1K/ZQ/rTVgoJ0hVXeptrasixV/zijxLyPyVKEAC9kdClaLJv
         WVw+WuQVvm6jdKQHKu8TdbtH82d5fckXbA6N4BZAJvuL9otim8SpgujFV8WxDmgnVZ
         EiEGwVB8VV9IVsWinAQ2sUxUcw7QrcvDSIKfyqHw=
X-Originating-IP: [92.22.26.195]
X-Spam: 0
X-OAuthority: v=2.3 cv=Poq9kTE3 c=1 sm=1 tr=0 a=8bf3kEuDtVJeVZALKX4IsA==:117
 a=8bf3kEuDtVJeVZALKX4IsA==:17 a=evINK-nbAAAA:8 a=ICvPtI4uR5dP65KTLLcA:9
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 0/2] fix author-script quoting
Date:   Tue,  7 Aug 2018 10:34:50 +0100
Message-Id: <20180807093452.22524-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731073331.40007-1-sunshine@sunshineco.com>
References: <20180731073331.40007-1-sunshine@sunshineco.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfCNrUlIXKAws6yufJhVexNMocJ2JtkEx3uFsmx79wJWxP2nFK859FIPCt2sokeCuPwkHiAJ/4l07SpOTKyH8KVggVLT05+8L/WC3XKjznX9aybKYU9a1
 m+F7g35ysv+Iq2P4udqLL0iNyhqow4XB205dDhSzotwK9/BEHrK3h7AlsKa2J2Nv2mmjdfilOo9eIA8Fil91frd1DnZ7d8LcSDAhwrYL+8NSExo9kXz+o76V
 tXE3FF5uk+8EwJOEc4jmqXs/nwOulqlZacC6ZgMHZjHmKSjNjLK2q530mQs9leOyvDLpHWNZfj93EJ6nSDElPLDKzdvZMG9EK6rsrAcPPpU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

I've updated these based on Eric's suggestions, hopefully they're good
to go now. Thanks Eric for you help.

Phillip Wood (2):
  sequencer: handle errors from read_author_ident()
  sequencer: fix quoting in write_author_script

 sequencer.c                   | 47 ++++++++++++++++++++++++++++-------
 t/t3404-rebase-interactive.sh | 18 +++++++++++---
 2 files changed, 53 insertions(+), 12 deletions(-)

-- 
2.18.0

