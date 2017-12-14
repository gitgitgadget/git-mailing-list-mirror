Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55A1C1F404
	for <e@80x24.org>; Thu, 14 Dec 2017 21:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752966AbdLNVCk (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 16:02:40 -0500
Received: from siwi.pair.com ([209.68.5.199]:49306 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752361AbdLNVCk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 16:02:40 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 9F2478450E;
        Thu, 14 Dec 2017 16:02:39 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 1A03D8450D;
        Thu, 14 Dec 2017 16:02:39 -0500 (EST)
Subject: Re: [PATCH v2] partial-clone: design doc
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20171214152404.35708-1-git@jeffhostetler.com>
 <20171214152404.35708-2-git@jeffhostetler.com>
 <xmqq1sjxuq0a.fsf@gitster.mtv.corp.google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <c5d24342-e459-2a5b-6e53-69cddd948140@jeffhostetler.com>
Date:   Thu, 14 Dec 2017 16:02:38 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <xmqq1sjxuq0a.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/14/2017 1:24 PM, Junio C Hamano wrote:
> Jeff Hostetler <git@jeffhostetler.com> writes:
> 
>> +- On the client these incomplete packfiles are marked as "promisor pacfiles"
> 
> s/pacfiles/packfiles/
> 
>> +  These "promisor packfiles" consist of a "<name>.promisor" file with
>> +  arbitrary contents (like the "<name>.keep" files), in addition to
>> +  their "<name>.pack" and "<name>.idx" files.
>> +
>> +  In the future, this ability may be extended to loose objects in case
>> +  a promisor packfile is accidentally unpacked.
> 
> Hmph.
> 
> Because we cannot assume that such an "accidental" unpacking would
> do anything extra to help us tell the loose objects created out of a
> promisor pack from other loose objects, you would end up making any
> and all loose objects to serve as if they came from a promisor
> remote?  I am not sure if that makes much sense.
> 
> Do we really need to write this "in the future" down, before we have
> thought things through enough to specify the design at a bit more
> detailed level?
> 

good point.  i'll move this to the bottom and elaborate on the
problem rather than the solution.

Jeff
