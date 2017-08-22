Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5109208D0
	for <e@80x24.org>; Tue, 22 Aug 2017 15:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751116AbdHVPzZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 11:55:25 -0400
Received: from 8.mo176.mail-out.ovh.net ([46.105.58.67]:36305 "EHLO
        8.mo176.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbdHVPzY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 11:55:24 -0400
Received: from ex2.mail.ovh.net (gw1.ex2.mail.ovh.net [164.132.80.186])
        by mo176.mail-out.ovh.net (Postfix) with ESMTPS id 5F43E81BA6;
        Tue, 22 Aug 2017 17:55:21 +0200 (CEST)
Received: from [10.0.2.127] (86.200.136.234) by EX7.indiv2.local (172.16.2.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Tue, 22
 Aug 2017 17:55:20 +0200
From:   Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Subject: [PATCH v3 0/4] imap-send: Fix and enable curl by default
To:     <git@vger.kernel.org>
CC:     <peff@peff.net>
Openpgp: preference=signencrypt
Message-ID: <087f5907-6558-ce32-2f5c-2e418522c030@morey-chaisemartin.com>
Date:   Tue, 22 Aug 2017 17:55:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:56.0) Gecko/20100101
 Thunderbird/56.0
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Language: fr-xx-classique+reforme1990
Content-Transfer-Encoding: 7bit
X-Originating-IP: [86.200.136.234]
X-ClientProxiedBy: CAS1.indiv2.local (172.16.1.1) To EX7.indiv2.local
 (172.16.2.7)
X-Ovh-Tracer-Id: 6046363976334305271
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelledrtddtgdejkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v2:
Patch 3 reject credit when curl failed:
 - when a login error  is returned (curl >= 7.13.1)
 - for any curl error in older versions

Nicolas Morey-Chaisemartin (4):
  imap-send: return with error if curl failed
  imap-send: add wrapper to get server credentials if needed
  imap_send: setup_curl: retreive credentials if not set in config file
  imap-send: use curl by default

 imap-send.c | 60 ++++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 20 deletions(-)

-- 
2.14.0.1.gd9597ce13

