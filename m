Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA0B31F461
	for <e@80x24.org>; Fri, 30 Aug 2019 17:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbfH3Rpq convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 30 Aug 2019 13:45:46 -0400
Received: from mxo2.nje.dmz.twosigma.com ([208.77.214.162]:36865 "EHLO
        mxo2.nje.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbfH3Rpo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 13:45:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by mxo2.nje.dmz.twosigma.com (Postfix) with ESMTP id 46Kn2H6pHvz7t8C;
        Fri, 30 Aug 2019 17:45:43 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo2.nje.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo2.nje.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4rI7nqki5hNW; Fri, 30 Aug 2019 17:45:43 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (exmbdft7.ad.twosigma.com [172.22.2.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo2.nje.dmz.twosigma.com (Postfix) with ESMTPS id 46Kn2H693zz3wZ3;
        Fri, 30 Aug 2019 17:45:43 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft7.ad.twosigma.com (172.22.2.43) with Microsoft SMTP Server (TLS) id
 15.0.1365.1; Fri, 30 Aug 2019 17:45:43 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%19]) with mapi id
 15.00.1365.000; Fri, 30 Aug 2019 17:45:43 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     =?iso-8859-1?Q?Martin_=C5gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: RE: [PATCH] clarify documentation for remote helpers
Thread-Topic: [PATCH] clarify documentation for remote helpers
Thread-Index: AQHVX1k9GlQGo8OOjkuzhV2FyVjf1acT9eFA
Date:   Fri, 30 Aug 2019 17:45:43 +0000
Message-ID: <c6c737c6a37c4cf7aa77e5c5ffd7a86f@exmbdft7.ad.twosigma.com>
References: <20190829210301.18467-1-dturner@twosigma.com>
        <CAN0heSosCnn5msMX18YPwrKJzWkSWptWSFRunQdLE7T7Lc4-OA@mail.gmail.com>
        <88d9063060644dd99122bf0933f23fa9@exmbdft7.ad.twosigma.com>
 <xmqqv9uey2tb.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqv9uey2tb.fsf@gitster-ct.c.googlers.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.189.105]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Junio C Hamano <gitster@pobox.com>
> Sent: Friday, August 30, 2019 1:35 PM
> To: David Turner <David.Turner@twosigma.com>
> Cc: Martin Ågren <martin.agren@gmail.com>; Git Mailing List
> <git@vger.kernel.org>
> Subject: Re: [PATCH] clarify documentation for remote helpers
> 
> David Turner <David.Turner@twosigma.com> writes:
> 
> > I was confused, because I read "a file under GIT_DIR/objects/pack"
> > to mean "just the filename".  Some of the things that deal with packs
> > take just the filename (e.g. --keep-pack for git repack).
> > I'll fix the under under and add $, but I do want to clarify that it's
> > the full path.
> 
> I think that the phrase wanted to say that the file named with the option must
> live under that directory, without any implication that the directory is used as
> the base when a relative path is used.  If the helper MUST give a full pathname
> and a pathname relative to that directory is not accepted, it is a good idea to
> spell it out (also if it must end with ".keep", that also should be documented---
> is there any other restrictions?).

The only other restriction I see is: in order for the connectivity-skipping 
optimization to be used, the file with s/.keep/.idx/, and the corresponding 
pack, must exist.  Do you think that's worth mentioning? It seems to be 
implied by the rest of the text.


