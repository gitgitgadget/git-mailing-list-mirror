Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53C0B20285
	for <e@80x24.org>; Wed, 30 Aug 2017 13:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751484AbdH3NaW (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 09:30:22 -0400
Received: from siwi.pair.com ([209.68.5.199]:10847 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751357AbdH3NaU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 09:30:20 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 5259D845B9;
        Wed, 30 Aug 2017 09:30:19 -0400 (EDT)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 47E1A845B6;
        Wed, 30 Aug 2017 09:30:18 -0400 (EDT)
Subject: Re: [RFC 0/7] transitioning to protocol v2
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com, gitster@pobox.com, jonathantanmy@google.com
References: <20170824225328.8174-1-bmwill@google.com>
 <20170825172901.kvquxafudhelxqq3@sigill.intra.peff.net>
 <20170825173550.GJ13924@aiede.mtv.corp.google.com>
 <2ff0ead4-e13a-220e-f858-36ab206c1485@jeffhostetler.com>
 <20170830030612.qjss3ygouardxi6k@sigill.intra.peff.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <3a2694ca-b5e6-7258-de01-c9898cfa60a2@jeffhostetler.com>
Date:   Wed, 30 Aug 2017 09:30:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170830030612.qjss3ygouardxi6k@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/29/2017 11:06 PM, Jeff King wrote:
> On Tue, Aug 29, 2017 at 04:08:25PM -0400, Jeff Hostetler wrote:
> 
>> I just wanted to jump in here and say I've done some initial
>> testing of this against VSTS and so far it seems fine.  And yes,
>> we have a custom git server.
> 
> Great, thank you for checking.
> 
>> VSTS doesn't support the "git://" protocol, so the double-null trick
>> isn't an issue for us.  But "https://" worked just fine.  I'm still
>> asking around internally whether we support passing SSH environment
>> variables.
> 
> The key thing for ssh is not whether you support passing environment
> variables. It's whether you quietly ignore unknown variables rather than
> cutting off the connection.
 >
> To support the v2 protocol you'd need to pass the new variables, but
> you'd also need to modify your server to actually do something useful
> with them anyway. At this point we're mostly concerned with whether we
> can safely pass the variables to current implementations unconditionally
> and get a reasonable outcome.

Right.  I just spoke with our server folks and, currently, our SSH
support quietly eats ALL variables.   So we're safe :-)

I'm starting a conversation with them to pass them thru so we can
be ready for this.  (Assuming we choose to go this way.)

Thanks,
Jeff


