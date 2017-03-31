Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54D821FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 13:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933157AbdCaNXx (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 09:23:53 -0400
Received: from siwi.pair.com ([209.68.5.199]:57840 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933241AbdCaNXv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 09:23:51 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 24EEB845E9;
        Fri, 31 Mar 2017 09:23:40 -0400 (EDT)
Subject: Re: [PATCH v3 0/2] read-cache: call verify_hdr() in a background
 thread
To:     Jeff King <peff@peff.net>, Thomas Gummerer <t.gummerer@gmail.com>
References: <20170328190732.59486-1-git@jeffhostetler.com>
 <20170328191628.dprziuhpv7khvocu@sigill.intra.peff.net>
 <35f220df-aa63-b80f-8970-429850202cdd@jeffhostetler.com>
 <20170328195605.xy4pnhy74s6wgwps@sigill.intra.peff.net>
 <20170330200648.GH27158@hank>
 <20170330203916.ckp62syupioo3hxc@sigill.intra.peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <094f16d2-e1d9-1478-df6a-4f24f17e184e@jeffhostetler.com>
Date:   Fri, 31 Mar 2017 09:23:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170330203916.ckp62syupioo3hxc@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/30/2017 4:39 PM, Jeff King wrote:
> On Thu, Mar 30, 2017 at 09:06:48PM +0100, Thomas Gummerer wrote:
>
>>> Yeah, I think that would be fine. You _could_ write a t/perf test and
>>> then use your 400MB monstrosity as GIT_PERF_LARGE_REPO. But given that
>>> most people don't have such a thing, there's not much value over you
>>> just showing off the perf improvement in the commit message.
>>
>> Sorry if this was already discussed, but we already do have a perf
>> test for the index (p0002), and a corresponding helper program which
>> just does read_cache() and discard_cache().  Maybe we could re-use
>> that and add a second test running the same using the new config?
>
> Oh, indeed. Yes, I would think the results of p0002 would probably show
> off Jeff's improvements.
>
> -Peff
>

Let me re-roll it with Junio's cleanup, update fsck to force it on,
and look at using p0002.

Thanks,
Jeff
