Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B623E2021E
	for <e@80x24.org>; Tue, 15 Nov 2016 23:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161022AbcKOXLS convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 15 Nov 2016 18:11:18 -0500
Received: from mxo2.nje.dmz.twosigma.com ([208.77.214.162]:41087 "EHLO
        mxo2.nje.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932927AbcKOXLS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 18:11:18 -0500
Received: from localhost (localhost [127.0.0.1])
        by mxo2.nje.dmz.twosigma.com (Postfix) with ESMTP id 3196710006A;
        Tue, 15 Nov 2016 23:11:16 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo2.nje.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo2.nje.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id P0-MhRdvlHaB; Tue, 15 Nov 2016 23:11:16 +0000 (GMT)
Received: from exmbdft8.ad.twosigma.com (exmbdft8.ad.twosigma.com [172.22.2.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo2.nje.dmz.twosigma.com (Postfix) with ESMTPS id 210498002E;
        Tue, 15 Nov 2016 23:11:16 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft8.ad.twosigma.com (172.22.2.84) with Microsoft SMTP Server (TLS) id
 15.0.1156.6; Tue, 15 Nov 2016 23:11:15 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::9966:e831:c693:7cef]) by
 exmbdft7.ad.twosigma.com ([fe80::9966:e831:c693:7cef%17]) with mapi id
 15.00.1156.000; Tue, 15 Nov 2016 23:11:15 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Stefan Beller' <sbeller@google.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "bmwill@google.com" <bmwill@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "jrnieder@gmail.com" <jrnieder@gmail.com>,
        "mogulguy10@gmail.com" <mogulguy10@gmail.com>
Subject: RE: [PATCH 02/16] submodule: modernize ok_to_remove_submodule to use
 argv_array
Thread-Topic: [PATCH 02/16] submodule: modernize ok_to_remove_submodule to use
 argv_array
Thread-Index: AQHSP5T4bfL7FTmdgkO5LEiTqvYB6qDaq2aQ
Date:   Tue, 15 Nov 2016 23:11:15 +0000
Message-ID: <e19fbbca91d5446e8fe308e847f53ae3@exmbdft7.ad.twosigma.com>
References: <20161115230651.23953-1-sbeller@google.com>
 <20161115230651.23953-3-sbeller@google.com>
In-Reply-To: <20161115230651.23953-3-sbeller@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.14]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -		"-u",
...
> +	argv_array_pushl(&cp.args, "status", "--porcelain", "-uall",

This also changes -u to -uall, which is not mentioned in the commit message.  That should probably be called out.
