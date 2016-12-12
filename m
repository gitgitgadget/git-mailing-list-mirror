Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DC1E203C1
	for <e@80x24.org>; Mon, 12 Dec 2016 19:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752760AbcLLTve (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 14:51:34 -0500
Received: from mout.web.de ([212.227.15.3]:60346 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752492AbcLLTvd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 14:51:33 -0500
Received: from [192.168.178.36] ([79.213.118.247]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MBH5Z-1cOSZi3cF3-00AETH; Mon, 12
 Dec 2016 20:51:15 +0100
Subject: Re: [PATCH 1/3] compat: add qsort_s()
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <3083fbf7-d67e-77e4-e05f-94a7e7e15eba@web.de>
 <fc602a66-a06c-203e-b50b-55fd7b258b54@web.de>
 <20161201193556.j2odwy3sepaxxq5a@sigill.intra.peff.net>
 <xmqq7f7j9zkd.fsf@gitster.mtv.corp.google.com>
 <xmqqy3zz8kmq.fsf@gitster.mtv.corp.google.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <b8aa28b1-e645-4cea-cc91-96f62fee6118@web.de>
Date:   Mon, 12 Dec 2016 20:51:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <xmqqy3zz8kmq.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:ySpFQ1btvCyE/rPdQiXTppOYUFSp3qMSlALYn2a/AiYYl+IB8QD
 Y6+BNFx5/lGRDmsO7TdNRN/GHreFSGub4/EQ0D8/hyWfhKX7eiSWhOenvVeCwmySP5+Jzv7
 VOo4LpFVNpGJfMfKfgzEkUepb7W1qDpDHTW3e+YvS6Us+YAjPj2C520Hb/cO09X9frkUUH7
 yOUZexKSvUR9EK0rfekBA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8GifRcfUH4I=:YsRRNrKYyW5DGT8O7faVLi
 QQ5W1NIiplLTHFg5+ItN9eMMMtLYLd2A3Nd+5ESQsN5DD89oKN6fKU94S/eA9qNe7wHpdQxG0
 ERfuTPITP8ia0pqJV6Vv4SfBN4+gft6IU9Ru1rCFaZglntVH4OGyjLsgJ0cTmwPhKFvi6GizU
 V4W11fIPSBrf8CVJALgIdn2HuFDv5U6qCc/ZZiy8gVBhwJKlrQ5SbHfB90tqO3UpMm4oysqf8
 5V7TZMDNtW1r55NzDNp7p+UvdQjgkzHmlhVhCentYN0eMTD8GRCt/Zd4NSmKnOsvRVjQiTsmA
 VkDdY6bDIcPrsT+gC+mEHK/oi0d45xVAbVK/7FEdBxEJA56K51WxJliV7NpBcaaIRsyqcQfGo
 +jn2l1vF6/UodJ3eL0k6FRqJGeWmsKNIC7CKo4iJqNRsJY+KssJh4gvEQhlhN3P23VrGcfMV5
 QUnZ9XfzM2kGo3HLIWBek80qlpL+e3sKzIqxXAHJSV0SbW8VHCqk4Jyv0aF374BJAP36o35p3
 QnkloQTJGwOQHWhUYkzadT6p8j8eUnO6DJIBwhwLunnjocUoOrP3DXHEDzpIMIT7HRsd2VJB/
 ujsLe0M3ftOAnCiojaYVQx7Qe2q/px5dok/ORXeB4CY/Tcw85tB91ZaIhG4QIHHgIK3naok5G
 1glDxc1ePEUbAc1DIM7cec3yYAutXbC+kvYaGSgdUDL09fZUGskQAw6CdoD+bo3gmvB+BqfIC
 h06k1k3uRn8PEMcwQohWaeMIZoy1NSpKNNOBhI+MZRX70acOvnnefhvFn8/8xMrebamtqtXHr
 6mCwfRk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.12.2016 um 21:22 schrieb Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Eh, wait.  BSD and Microsoft have paramters reordered in the
>> callback comparison function.  I suspect that would not fly very
>> well.
>
> Hmm.  We could do it like this, which may not be too bad.

It's kinda cool to have a bespoke compatibility layer for major 
platforms, but the more I think about it the less I can answer why we 
would want that.  Safety, reliability and performance can't be good 
reasons -- if our fallback function lacks in these regards then we have 
to improve it in any case.

Text size could be a valid reason, but the full function only adds a bit 
more than 2KB to the unstripped git binary.

The flip side is we'd build an ifdef maze that's harder to read and a 
lot more difficult to test.

What do we get in return for that additional complexity?

> #if APPLE_QSORT_R
> struct apple_qsort_adapter {
> 	int (*user_cmp)(const void *, const void *, void *);
> 	void *user_ctx;
> }
>
> static int apple_qsort_adapter_cmp(void *ctx, const void *a, const void *b)
> {
> 	struct apple_qsort_adapter *wrapper_ctx = ctx;
> 	return wrapper_ctx->user_cmp(a, b, wrapper_ctx->user_ctx);
> }
> #endif
>
> int git_qsort_s(void *b, size_t n, size_t s,
>       	   int (*cmp)(const void *, const void *, void *), void *ctx)
> {
> 	if (!n)
> 		return 0;
> 	if (!b || !cmp)
> 		return -1;
> #if GNU_QSORT_R
> 	qsort_r(b, n, s, cmp, ctx);
> #elif APPLE_QSORT_R
> 	{
> 		struct appple_qsort_adapter a = { cmp, ctx };
> 		qsort_r(b, n, s, &a, appple_qsort_adapter_cmp);
> 	}
> #endif

Nit: The fallback for non-GNU, non-Apple systems is missing here, but 
the idea is illustrated clearly enough.

>       return 0;
> }
>

