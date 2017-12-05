Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C75B20A40
	for <e@80x24.org>; Tue,  5 Dec 2017 15:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753060AbdLEPpb (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 10:45:31 -0500
Received: from siwi.pair.com ([209.68.5.199]:43000 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752732AbdLEPpa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 10:45:30 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 10D09844D9;
        Tue,  5 Dec 2017 10:45:30 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id B2B3E844D4;
        Tue,  5 Dec 2017 10:45:29 -0500 (EST)
Subject: Re: [PATCH v5 10/10] gc: do not repack promisor packfiles
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20171121210720.21376-1-git@jeffhostetler.com>
 <20171121210720.21376-11-git@jeffhostetler.com>
 <CAP8UFD10YsCQtiFtLtzQ-PKsY93QaDC4zsO+k1tfauBs8ntt1w@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <12409f04-5dd3-a823-6193-e17e9157ae16@jeffhostetler.com>
Date:   Tue, 5 Dec 2017 10:45:28 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD10YsCQtiFtLtzQ-PKsY93QaDC4zsO+k1tfauBs8ntt1w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/2/2017 12:39 PM, Christian Couder wrote:
> On Tue, Nov 21, 2017 at 10:07 PM, Jeff Hostetler <git@jeffhostetler.com> wrote:
>> From: Jonathan Tan <jonathantanmy@google.com>
> 
>>   pack_as_from_promisor () {
>>          HASH=$(git -C repo pack-objects .git/objects/pack/pack) &&
>>          >repo/.git/objects/pack/pack-$HASH.promisor
>> +       echo $HASH
>>   }
> 
> Now the exit code of the above function will always be the exit code
> of "echo $HASH".
> It seems to me that it would be better to add "&&" at the end of the
> line above the "echo $HASH".
> 

Fixed. Thanks.
Jeff
