Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACC221F403
	for <e@80x24.org>; Tue, 12 Jun 2018 00:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933759AbeFLALx (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 20:11:53 -0400
Received: from lang.hm ([66.167.227.134]:48349 "EHLO bifrost.lang.hm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932688AbeFLALw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 20:11:52 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
        by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id w5C0BDep007454;
        Mon, 11 Jun 2018 17:11:13 -0700
Date:   Mon, 11 Jun 2018 17:11:13 -0700 (PDT)
From:   David Lang <david@lang.hm>
X-X-Sender: dlang@asgard.lang.hm
To:     =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>, agl@google.com, keccak@noekeon.org
Subject: Re: Hash algorithm analysis
In-Reply-To: <878t7kx5t3.fsf@evledraar.gmail.com>
Message-ID: <alpine.DEB.2.02.1806111708540.23278@nftneq.ynat.uz>
References: <20180609205628.GB38834@genre.crustytoothpaste.net>        <20180609224913.GC38834@genre.crustytoothpaste.net>        <20180611192942.GC20665@aiede.svl.corp.google.com>        <CA+55aFw+E9GT7TKC_EgPTVcvHR8HDSipNPa7VQ1ASeL1M68xMQ@mail.gmail.com>
 <878t7kx5t3.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="680960-1779319140-1528762278=:23278"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--680960-1779319140-1528762278=:23278
Content-Type: TEXT/PLAIN; format=flowed; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 12 Jun 2018, Ævar Arnfjörð Bjarmason wrote:

>> From a performance standpoint, I have to say (once more) that crypto
>> performance actually mattered a lot less than I originally thought it
>> would. Yes, there are phases that do care, but they are rare.
>
> One real-world case is rebasing[1]. As noted in that E-Mail of mine a
> year ago we can use SHA1DC v.s. OpenSSL as a stand-in for the sort of
> performance difference we might expect between hash functions, although
> as you note this doesn't account for the difference in length.

when you are rebasing, how many hashes do you need to calculate? a few dozen, a 
few hundred, a few thousand, a few hundered thousand?

If the common uses of rebasing are on the low end, then the fact that the hash 
takes a bit longer won't matter much because the entire job is so fast.

And at the high end, I/O will probably dominate.

so where does it really make a human visible difference?

David Lang
--680960-1779319140-1528762278=:23278--
