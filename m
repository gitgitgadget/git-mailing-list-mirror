Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFB8D2070F
	for <e@80x24.org>; Mon, 19 Sep 2016 18:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752330AbcISSzA (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 14:55:00 -0400
Received: from ikke.info ([178.21.113.177]:38792 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751543AbcISSy7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 14:54:59 -0400
Received: by vps892.directvps.nl (Postfix, from userid 182)
        id CDA2F4400C7; Mon, 19 Sep 2016 20:54:57 +0200 (CEST)
Received: from io.ikke (unknown [10.8.0.30])
        by vps892.directvps.nl (Postfix) with ESMTP id E8F7F4400B7;
        Mon, 19 Sep 2016 20:54:56 +0200 (CEST)
From:   Kevin Daudt <me@ikke.info>
To:     git@vger.kernel.org
Cc:     Kevin Daudt <me@ikke.info>, Swift Geek <swiftgeek@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/2] Handle escape characters in From field.
Date:   Mon, 19 Sep 2016 20:54:38 +0200
Message-Id: <20160919185440.18234-1-me@ikke.info>
X-Mailer: git-send-email 2.10.0.86.g6ffa4f1.dirty
In-Reply-To: <20160916210204.31282-1-me@ikke.info>
References: <20160916210204.31282-1-me@ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v2:
- detach from input parameter to reuse it as an output buffer
- don't return error when encountering another open bracket in a comment
- test escaping in comments

Kevin Daudt (2):
  t5100-mailinfo: replace common path prefix with variable
  mailinfo: unescape quoted-pair in header fields

 mailinfo.c                   | 46 +++++++++++++++++++++++++++++
 t/t5100-mailinfo.sh          | 70 +++++++++++++++++++++++++++-----------------
 t/t5100/comment.expect       |  5 ++++
 t/t5100/comment.in           |  9 ++++++
 t/t5100/quoted-string.expect |  5 ++++
 t/t5100/quoted-string.in     |  9 ++++++
 6 files changed, 117 insertions(+), 27 deletions(-)
 create mode 100644 t/t5100/comment.expect
 create mode 100644 t/t5100/comment.in
 create mode 100644 t/t5100/quoted-string.expect
 create mode 100644 t/t5100/quoted-string.in

-- 
2.10.0.86.g6ffa4f1.dirty

