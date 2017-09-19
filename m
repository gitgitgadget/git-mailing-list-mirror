Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C86372047F
	for <e@80x24.org>; Tue, 19 Sep 2017 19:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751040AbdISTcq convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 19 Sep 2017 15:32:46 -0400
Received: from mxo2.dft.dmz.twosigma.com ([208.77.212.182]:39428 "EHLO
        mxo2.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbdISTcq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 15:32:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by mxo2.dft.dmz.twosigma.com (Postfix) with ESMTP id E4C92100059;
        Tue, 19 Sep 2017 19:32:44 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo2.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo2.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HupIPOOBOeQa; Tue, 19 Sep 2017 19:32:44 +0000 (GMT)
Received: from exmbdft6.ad.twosigma.com (exmbdft6.ad.twosigma.com [172.22.1.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo2.dft.dmz.twosigma.com (Postfix) with ESMTPS id D2B2D8002E;
        Tue, 19 Sep 2017 19:32:44 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft6.ad.twosigma.com (172.22.1.5) with Microsoft SMTP Server (TLS) id
 15.0.1263.5; Tue, 19 Sep 2017 19:32:44 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%19]) with mapi id
 15.00.1263.000; Tue, 19 Sep 2017 19:32:44 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Ben Peart' <benpeart@microsoft.com>
CC:     "'avarab@gmail.com'" <avarab@gmail.com>,
        "'christian.couder@gmail.com'" <christian.couder@gmail.com>,
        "'git@vger.kernel.org'" <git@vger.kernel.org>,
        "'gitster@pobox.com'" <gitster@pobox.com>,
        "'johannes.schindelin@gmx.de'" <johannes.schindelin@gmx.de>,
        "'pclouds@gmail.com'" <pclouds@gmail.com>,
        "'peff@peff.net'" <peff@peff.net>
Subject: RE: [PATCH v6 10/12] fsmonitor: add test cases for fsmonitor
 extension
Thread-Topic: [PATCH v6 10/12] fsmonitor: add test cases for fsmonitor
 extension
Thread-Index: AQHTLlfecTYo8c+6f0G9yk1v0OUKpKK2aI1AgAY2lBA=
Date:   Tue, 19 Sep 2017 19:32:44 +0000
Message-ID: <2f3593f790f5423e853f3bcb0a601ef9@exmbdft7.ad.twosigma.com>
References: <20170610134026.104552-1-benpeart@microsoft.com>
 <20170915192043.4516-1-benpeart@microsoft.com>
 <20170915192043.4516-11-benpeart@microsoft.com>
 <dc1506689d3d4639b56f0489e4219054@exmbdft7.ad.twosigma.com>
In-Reply-To: <dc1506689d3d4639b56f0489e4219054@exmbdft7.ad.twosigma.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think my comment here might have gotten lost, and I don't want it to because it's something I'm really worried about:

> -----Original Message-----
> From: David Turner
> Sent: Friday, September 15, 2017 6:00 PM
> To: 'Ben Peart' <benpeart@microsoft.com>
> Cc: avarab@gmail.com; christian.couder@gmail.com; git@vger.kernel.org;
> gitster@pobox.com; johannes.schindelin@gmx.de; pclouds@gmail.com;
> peff@peff.net
> Subject: RE: [PATCH v6 10/12] fsmonitor: add test cases for fsmonitor
> extension
> 
> > -----Original Message-----
> > +dirty_repo () {
> > +	: >untracked &&
> > +	: >dir1/untracked &&
> > +	: >dir2/untracked &&
> > +	echo 1 >modified &&
> > +	echo 2 >dir1/modified &&
> > +	echo 3 >dir2/modified &&
> > +	echo 4 >new &&
> > +	echo 5 >dir1/new &&
> > +	echo 6 >dir2/new
> 
> If I add an untracked file named dir3/untracked to dirty_repo  (and
> write_integration_script), then "status doesn't detect unreported
> modifications", below, fails.  Did I do something wrong, or does this turn up a
> bug?


