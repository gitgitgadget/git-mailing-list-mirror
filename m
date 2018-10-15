Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C4611F97E
	for <e@80x24.org>; Mon, 15 Oct 2018 00:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbeJOIVI (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 04:21:08 -0400
Received: from avasout03.plus.net ([84.93.230.244]:41180 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbeJOIVI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 04:21:08 -0400
Received: from [10.0.2.15] ([80.189.70.193])
        by smtp with ESMTPA
        id Bqtjgw8qpO2g2BqtkgZmT9; Mon, 15 Oct 2018 01:38:16 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=DKChHRFb c=1 sm=1 tr=0
 a=wSR+GDtF+fsrIzE5OYgxVg==:117 a=wSR+GDtF+fsrIzE5OYgxVg==:17
 a=IkcTkHD0fZMA:10 a=updfGnVDxfHR-Zj7dXAA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [RFC/PATCH] headers: normalize the spelling of some header guards
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <2804aa4e-c078-c981-be93-27e6e58b2042@ramsayjones.plus.com>
 <20181014235950.GA13510@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <f04c2f71-fe0f-a935-d49d-c71684b7558c@ramsayjones.plus.com>
Date:   Mon, 15 Oct 2018 01:38:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181014235950.GA13510@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNrtcrP1ZnqPx852wKnmT1mmvD9cAMlWPf3yENfzlmLjEVDqh8JvbLPcj+aAiAjMUOpYcbq69Yz6q2x1WZ9O3lMRxGNvEG+2GvhVear6aSt/C3YWxgj7
 6ofqqYbeAkP6t9AnR4X5uk5qoTlzwb8KLRTmoRg0ktQANhlhl387QCDa+tECDnu32Otqwr7XyZpmgg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 15/10/18 00:59, Jeff King wrote:
> On Sun, Oct 14, 2018 at 09:13:09PM +0100, Ramsay Jones wrote:
> 
>> This patch is marked RFC because I am not aware of any policy with
>> regard to header guard spelling. Having said that, apart from the
>> fetch-negotiator.h header, all of these headers are using a reserved
>> identifier (see C99 Standard 7.1.3).
>>
>> These headers were found, thus:
>>
>>   $ git grep -n -E '^#ifn?def ' -- '*.h' | grep 'h\:1\:' | grep -v '^compat' | grep -v -E '[A-Z_]*_H$'
>>   alias.h:1:#ifndef __ALIAS_H__
>>   commit-reach.h:1:#ifndef __COMMIT_REACH_H__
>>   fetch-negotiator.h:1:#ifndef FETCH_NEGOTIATOR
>>   midx.h:1:#ifndef __MIDX_H__
>>   t/helper/test-tool.h:1:#ifndef __TEST_TOOL_H__
>>   vcs-svn/fast_export.h:1:#ifndef FAST_EXPORT_H_
>>   vcs-svn/line_buffer.h:1:#ifndef LINE_BUFFER_H_
>>   vcs-svn/sliding_window.h:1:#ifndef SLIDING_WINDOW_H_
>>   vcs-svn/svndiff.h:1:#ifndef SVNDIFF_H_
>>   vcs-svn/svndump.h:1:#ifndef SVNDUMP_H_
> 
> I think the ones with a trailing underscore are actually OK according to
> the standard (not sure if your "all of these" was including the ones in
> vcs-svn ;) ).

Yes, trailing underscore is fine - "all of these" meant the
headers in the patch, with the noted exception of fetch-negotiator.h.

> I'm in favor of normalizing even the ones that aren't illegal, though
> I'm OK either way on the vcs-svn bits if they're going away anyway.

I wasn't sure about vcs-svn, but assumed that they might go
away soon (hence the cc: list). I will be happy to add them
to the patch, if that is not the case.

Thanks.

ATB,
Ramsay Jones

