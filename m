Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 785DD201A7
	for <e@80x24.org>; Fri, 19 May 2017 10:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751460AbdESKCn (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 06:02:43 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:50680 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750731AbdESKCm (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 May 2017 06:02:42 -0400
X-AuditID: 12074413-0c9ff70000001dc3-75-591ec2c1170f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 12.1B.07619.1C2CE195; Fri, 19 May 2017 06:02:41 -0400 (EDT)
Received: from [192.168.69.190] (p57BCCC1C.dip0.t-ipconnect.de [87.188.204.28])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4JA2c2D008011
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Fri, 19 May 2017 06:02:39 -0400
Subject: Re: [PATCH 22/23] ref-filter: limit traversal to prefix
To:     Jeff King <peff@peff.net>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
 <1f50142ccbb84a4e5d7a1cd67e6f9d30edc1d73a.1495014840.git.mhagger@alum.mit.edu>
 <20170517133835.s3m3giccjo3jqstg@sigill.intra.peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <c02b630d-1936-aa21-d79c-03e42b103bb7@alum.mit.edu>
Date:   Fri, 19 May 2017 12:02:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170517133835.s3m3giccjo3jqstg@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42IRYndR1D14SC7S4O0ZKYu1z+4wWXRd6Way
        aOi9wmyx5OFrZovuKW8ZLX609DBbbN7czuLA7rFz1l12jwWbSj262o+weTzr3cPocfGSssfn
        TXIBbFFcNimpOZllqUX6dglcGUf3HGAqmCdQsXRDL1MD42WeLkZODgkBE4kb05qZuhi5OIQE
        djBJXJ5xmw3COc8k8XTSalaQKmEBB4kFa26ygdgiArIS3w9vZASxhQQOMUr0zQoBsZkFNjFJ
        bD1rD2KzCehKLOoBmcrJwStgLzFz+SewehYBVYnvy5axgNiiAhESDzt3sUPUCEqcnPkELM4p
        4CLRNP8XO8RMdYk/8y4xQ9jyEtvfzmGewMg/C0nLLCRls5CULWBkXsUol5hTmqubm5iZU5ya
        rFucnJiXl1qka66Xm1mil5pSuokREubCOxh3nZQ7xCjAwajEw/tghWykEGtiWXFl7iFGSQ4m
        JVHeGQFykUJ8SfkplRmJxRnxRaU5qcVAn3MwK4nwft4OlONNSaysSi3Kh0lJc7AoifOqLVH3
        ExJITyxJzU5NLUgtgsnKcHAoSfDuPwjUKFiUmp5akZaZU4KQZuLgBBnOAzR8B0gNb3FBYm5x
        ZjpE/hSjopQ473mQhABIIqM0D64XloZeMYoDvSLM2wxSxQNMYXDdr4AGMwENbn4gDTK4JBEh
        JdXAuOptaEuhxxL9KqXVl1P2rG3a7bh6YtCax2mMc2rWHbfa/rvIb9aWgL3hGewtV08HRPPs
        eqogH+7hlv4+VrR2uYVG/NTFscWsLqs54h5zvzo996z8Mi5Vo4e/JMsuzKnvajcNXe72ds3c
        JbcOGt7Vni2VdZaxPu61LecKdbV8lUnLHFo1fjjPV2Ipzkg01GIuKk4EAGo7KE0eAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/17/2017 03:38 PM, Jeff King wrote:
> On Wed, May 17, 2017 at 02:05:45PM +0200, Michael Haggerty wrote:
> 
>> From: Jeff King <peff@peff.net>
> 
> This patch did originate with me, but I know you had to fix several
> things to integrate it in your series. So I'll review it anyway, and
> give you full blame for any bugs. :)
> 
>> When we are matching refnames "as path" against a pattern, then we
>> know that the beginning of any refname that can match the pattern has
>> to match the part of the pattern up to the first glob character. For
>> example, if the pattern is `refs/heads/foo*bar`, then it can only
>> match a reference that has the prefix `refs/heads/foo`.
> 
> That first sentence confused me as to what "as path" meant (I know
> because I worked on this code, and even then it took me a minute to
> parse it).
> 
> Maybe just "When we are matching refnames against a pattern" and then
> later something like:
> 
>   Note that this applies only when the "match_as_path" flag is set
>   (i.e., when for-each-ref is the caller), as the matching rules for
>   git-branch and git-tag are subtly different.

That is clearer. I'll make the change.

>> +/*
>> + * Find the longest prefix of pattern we can pass to
>> + * for_each_fullref_in(), namely the part of pattern preceding the
>> + * first glob character.
>> + */
>> +static void find_longest_prefix(struct strbuf *out, const char *pattern)
>> +{
>> +	const char *p;
>> +
>> +	for (p = pattern; *p && !is_glob_special(*p); p++)
>> +		;
>> +
>> +	strbuf_add(out, pattern, p - pattern);
>> +}
> 
> If I were reviewing this from scratch, I'd probably ask whether it is OK
> in:
> 
>   refs/heads/m*
> 
> to return "refs/heads/m" as the prefix, and not stop at the last
> non-wildcard component ("refs/heads/"). But I happen to know we
> discussed this off-list and you checked that for_each_ref and friends
> are happy with an arbitrary prefix. But I'm calling it out here for
> other reviewers.

I'll add a comment about this, too.

Thanks,
Michael

