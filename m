Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AE0C1F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 19:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752902AbcI1Ttq (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 15:49:46 -0400
Received: from ikke.info ([178.21.113.177]:47890 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752032AbcI1Ttp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 15:49:45 -0400
Received: by vps892.directvps.nl (Postfix, from userid 182)
        id 43ACA4400C7; Wed, 28 Sep 2016 21:49:43 +0200 (CEST)
Received: from io.ikke (unknown [10.8.0.30])
        by vps892.directvps.nl (Postfix) with ESMTP id 7D2DC4400BD;
        Wed, 28 Sep 2016 21:49:41 +0200 (CEST)
From:   Kevin Daudt <me@ikke.info>
To:     git@vger.kernel.org
Cc:     Kevin Daudt <me@ikke.info>, Junio C Hamano <gitster@pobox.com>,
        Swift Geek <swiftgeek@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 0/2] Handle RFC2822 quoted-pairs in From header
Date:   Wed, 28 Sep 2016 21:49:37 +0200
Message-Id: <20160928194939.7706-1-me@ikke.info>
X-Mailer: git-send-email 2.10.0.372.g6fe1b14
In-Reply-To: <20160925210808.26424-1-me@ikke.info>
References: <20160925210808.26424-1-me@ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v3:
- t5100-mailinfo: Reverted back to capital $DATA
- t5100-mailinfo: Moved quotes to around the entire string, instead of the
  variable, as per Junio's suggestion


Kevin Daudt (2):
  t5100-mailinfo: replace common path prefix with variable
  mailinfo: unescape quoted-pair in header fields

 mailinfo.c                   | 82 ++++++++++++++++++++++++++++++++++++++++++++
 t/t5100-mailinfo.sh          | 82 ++++++++++++++++++++++++++------------------
 t/t5100/comment.expect       |  5 +++
 t/t5100/comment.in           |  9 +++++
 t/t5100/quoted-string.expect |  5 +++
 t/t5100/quoted-string.in     |  9 +++++
 6 files changed, 159 insertions(+), 33 deletions(-)
 create mode 100644 t/t5100/comment.expect
 create mode 100644 t/t5100/comment.in
 create mode 100644 t/t5100/quoted-string.expect
 create mode 100644 t/t5100/quoted-string.in

-- 
2.10.0.372.g6fe1b14

