Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3060920984
	for <e@80x24.org>; Tue, 13 Sep 2016 23:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759490AbcIMXnL (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 19:43:11 -0400
Received: from ikke.info ([178.21.113.177]:41028 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752289AbcIMXnK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 19:43:10 -0400
Received: by vps892.directvps.nl (Postfix, from userid 182)
        id D71BF4400C0; Wed, 14 Sep 2016 01:43:08 +0200 (CEST)
Received: from io.ikke (unknown [10.8.0.30])
        by vps892.directvps.nl (Postfix) with ESMTP id 645FD4400B7;
        Wed, 14 Sep 2016 01:43:08 +0200 (CEST)
From:   Kevin Daudt <me@ikke.info>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>
Subject: [RFC 0/1] de-quote quoted-strings in mailinfo
Date:   Wed, 14 Sep 2016 01:42:40 +0200
Message-Id: <20160913234241.22687-1-me@ikke.info>
X-Mailer: git-send-email 2.10.0.rc2
Reply-to: kevin@lists.ikke.info
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is my first 'big' C patch, so first an RFC. 

This patch implements RFC2822 dequoting of quoted-pairs in quoted
strings, which was not done yet. This means removing the "\" as escape
character from header fields, but only quoted strings, and comments
(text between braces).

According to the RFC, comments can also appear in square brackets in the
e-mail domain, but that has not been implemented. In fact, just like
other functions, it just looks at the whole header line.

Please let me know what you think.

Kevin Daudt (1):
  mailinfo: de-quote quoted-pair in header fields

 mailinfo.c                 | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 t/t5100-mailinfo.sh        |  5 +++++
 t/t5100/quoted-pair.expect |  5 +++++
 t/t5100/quoted-pair.in     |  9 +++++++++
 t/t5100/quoted-pair.info   |  5 +++++
 5 files changed, 70 insertions(+)
 create mode 100644 t/t5100/quoted-pair.expect
 create mode 100644 t/t5100/quoted-pair.in
 create mode 100644 t/t5100/quoted-pair.info

-- 
2.10.0.rc2

