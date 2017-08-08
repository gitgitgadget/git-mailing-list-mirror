Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A0D71F991
	for <e@80x24.org>; Tue,  8 Aug 2017 07:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751583AbdHHHrX (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 03:47:23 -0400
Received: from 3.mo64.mail-out.ovh.net ([46.105.34.112]:46911 "EHLO
        3.mo64.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbdHHHrW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 03:47:22 -0400
X-Greylist: delayed 63329 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Aug 2017 03:47:22 EDT
Received: from ex2.mail.ovh.net (gw1.ex2.mail.ovh.net [164.132.80.186])
        by mo64.mail-out.ovh.net (Postfix) with ESMTPS id CA49A6E399
        for <git@vger.kernel.org>; Tue,  8 Aug 2017 09:30:06 +0200 (CEST)
Received: from [10.0.2.127] (86.200.136.234) by EX7.indiv2.local (172.16.2.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Tue, 8 Aug
 2017 09:30:06 +0200
From:   Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Subject: [PATCHv2 0/4] imap-send: Fix and enable curl by default
To:     <git@vger.kernel.org>
Message-ID: <3637fd31-3120-eca0-b7ee-8e6e324b6b58@morey-chaisemartin.com>
Date:   Tue, 8 Aug 2017 09:30:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:55.0) Gecko/20100101
 Thunderbird/55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Language: fr-xx-classique+reforme1990
Content-Transfer-Encoding: 7bit
X-Originating-IP: [86.200.136.234]
X-ClientProxiedBy: EX1.indiv2.local (172.16.2.1) To EX7.indiv2.local
 (172.16.2.7)
X-Ovh-Tracer-Id: 7529455627569719261
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelkedrkedvgdduvdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenuc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v1:

- Add patch fo fix return value of the curl_append_msgs_to_imap
- Patch #2: server_fill_credentials takes a credential struct as a parameter so they can be approved later
- Dropped the s/server/srvc/ cleanup (previous patch #3)
- Patch #4: Only use curl as the default if it's available

Nicolas Morey-Chaisemartin (4):
  imap-send: return with error if curl failed
  imap-send: add wrapper to get server credentials if needed
  imap_send: setup_curl: retreive credentials if not set in config file
  imap-send: use curl by default

 imap-send.c | 52 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 20 deletions(-)

