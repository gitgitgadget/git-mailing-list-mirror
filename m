Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7959F1FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 17:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751024AbdFSR4Q (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 13:56:16 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:53322 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750925AbdFSR4P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 13:56:15 -0400
Received: from lindisfarne.localdomain ([92.22.42.39])
        by smtp.talktalk.net with SMTP
        id N0uGdKeNKHGLwN0uLdVs9P; Mon, 19 Jun 2017 18:56:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1497894974; bh=yFfex8YrM/uzOxtfnyRATb565pa4SbMsgii7I0ApedI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=cWs1eqTsYfSbZgEbKjfKjJpZB+vmBbOyWpsr4xKQKoN6760L+lr62ysshvt0CqvnH
         UDyK2vG/wHOpNJkhyonDgcU2SDkb5BU8iZaKldqa8aE5Gr25futDnKr0oCTCSQ4PkY
         JBJyThV1qrjwMy+cwe8TKCWV6tDNRcNSebYFNm94=
X-Originating-IP: [92.22.42.39]
X-Spam: 0
X-OAuthority: v=2.2 cv=dsCZMBo4 c=1 sm=1 tr=0 a=0UCMmuyk8Ln1ykD6Z38Clg==:117
 a=0UCMmuyk8Ln1ykD6Z38Clg==:17 a=evINK-nbAAAA:8 a=I9Gm4MIX2lyHsYBHcgoA:9
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 0/4] Add regression tests for recent rebase -i fixes
Date:   Mon, 19 Jun 2017 18:56:01 +0100
Message-Id: <20170619175605.27864-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170531104213.16944-1-phillip.wood@talktalk.net>
References: <20170531104213.16944-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfG3oOdyNwpXYQvInG++D56KFdpAewMEtO1vTkL3FDlKAEOG/LiAz0ylGMDMltksgCulUUB1BcaQZ9D/5YzD8NK79LS/qHGFJyC0GIa645aIutc6gdDeM
 d9rcUj8Izw+TbDAasrlA+CXrVbOy5Ya1cbRH0d7alBR80QJzxXw1pR+wsaaDK8rHLPzQcaFtRbLurMD/jVGdoLkT0O2Xmt9idOsyrBA8ZaCM0CBptg9QVu7R
 QUYd9ktaPpN2LIaxp/IfCcLlVg1AuPOkk5hn4iFgeJez/6MPctjXOQq1ENDgWq+QMWQIKlFakdpQB7RFpwPABg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

I've updated the second two tests to be portable using q_to_cr() as
Johannes suggested and added his patch to fix the autostash messages
going to stdout rather than stderr. The reflog message test is
unchanged. Thanks to Johannes for his help and to Junio for picking up
the bashism in the last iteration.

Johannes Schindelin (1):
  sequencer: print autostash messages to stderr

Phillip Wood (3):
  rebase -i: Add test for reflog message
  rebase: Add regression tests for console output
  rebase: Add more regression tests for console output

 git-rebase.sh                 |   4 +-
 sequencer.c                   |  11 ++--
 t/t3404-rebase-interactive.sh |   7 +++
 t/t3420-rebase-autostash.sh   | 136 ++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 147 insertions(+), 11 deletions(-)

-- 
2.13.0

