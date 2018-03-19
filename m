Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3884B1F404
	for <e@80x24.org>; Mon, 19 Mar 2018 17:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966128AbeCSRb5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 13:31:57 -0400
Received: from siwi.pair.com ([209.68.5.199]:64181 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966140AbeCSRbx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 13:31:53 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id B53C03F4025;
        Mon, 19 Mar 2018 13:31:52 -0400 (EDT)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 7F62B3F4023;
        Mon, 19 Mar 2018 13:31:52 -0400 (EDT)
Subject: Re: [PATCH 0/2] routines to generate JSON data
To:     Jacob Keller <jacob.keller@gmail.com>, Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        lars.schneider@autodesk.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180316194057.77513-1-git@jeffhostetler.com>
 <20180316211837.GB12333@sigill.intra.peff.net>
 <CA+P7+xpGWZaFMWhN72beUVaV_HuECAAEYhf+UT-CPZUV+Gew4Q@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <d814130f-dce7-4513-02a5-469c97464715@jeffhostetler.com>
Date:   Mon, 19 Mar 2018 13:31:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:59.0) Gecko/20100101
 Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <CA+P7+xpGWZaFMWhN72beUVaV_HuECAAEYhf+UT-CPZUV+Gew4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/17/2018 3:38 AM, Jacob Keller wrote:
> On Fri, Mar 16, 2018 at 2:18 PM, Jeff King <peff@peff.net> wrote:
>>    3. Some other similar format. YAML comes to mind. Last time I looked
>>       (quite a while ago), it seemed insanely complex, but I think you
>>       could implement only a reasonable subset. OTOH, I think the tools
>>       ecosystem for parsing JSON (e.g., jq) is much better.
>>
> 
> I would personally avoid YAML. It's "easier" for humans to read/parse,
> but honestly JSON is already simple enough and anyone who writes C or
> javascript can likely parse and hand-write JSON anyways. YAML lacks
> built-in parsers for most languages, where as many scripting languages
> already have JSON parsing built in, or have more easily attainable
> libraries available. In contrast, the YAML libraries are much more
> complex and less likely to be available.
> 
> That's just my own experience at $dayjob though.

Agreed.  I just looked at the spec for it and I think it would be
harder for us to be assured we are generating valid output with
leading whitespace being significant (without a lot more inspection
of the strings being passed down to us).

Jeff

