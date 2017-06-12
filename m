Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1B151F8CF
	for <e@80x24.org>; Mon, 12 Jun 2017 17:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752578AbdFLRuM convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 12 Jun 2017 13:50:12 -0400
Received: from mxo2.nje.dmz.twosigma.com ([208.77.214.162]:47185 "EHLO
        mxo2.nje.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751984AbdFLRuL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 13:50:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by mxo2.nje.dmz.twosigma.com (Postfix) with ESMTP id 69491100058
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 17:50:05 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo2.nje.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo2.nje.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OZzGUxd8N0A6 for <git@vger.kernel.org>;
        Mon, 12 Jun 2017 17:50:05 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (exmbdft7.ad.twosigma.com [172.22.2.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo2.nje.dmz.twosigma.com (Postfix) with ESMTPS id 5A3118002E
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 17:50:05 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft7.ad.twosigma.com (172.22.2.43) with Microsoft SMTP Server (TLS) id
 15.0.1263.5; Mon, 12 Jun 2017 17:50:05 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%19]) with mapi id
 15.00.1263.000; Mon, 12 Jun 2017 17:50:05 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: bug? fetching from empty unnamed remote repos
Thread-Topic: bug? fetching from empty unnamed remote repos
Thread-Index: AdLjpFKjAwNVsg7XQvGhI+L8Qm06+A==
Date:   Mon, 12 Jun 2017 17:50:05 +0000
Message-ID: <b3d0d39fe9d443fd8202b8b055d31f86@exmbdft7.ad.twosigma.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.9]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

$ git init empty-1
$ git init empty-2 
$ cd empty-1
$ git fetch ../empty-2
fatal: Couldn't find remote ref HEAD
fatal: The remote end hung up unexpectedly

But:
$ git init empty-1
$ git init empty-2 
$ cd empty-1
$ git remote add other ../empty-2
$ git fetch other
# this works

I haven't spent a lot of time looking into the code, because we can use the second option.  But it does seem weird.
