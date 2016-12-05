Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70A6D1FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 20:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751895AbcLEUap (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 15:30:45 -0500
Received: from avasout06.plus.net ([212.159.14.18]:33900 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751485AbcLEUam (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 15:30:42 -0500
Received: from [10.0.2.15] ([143.159.212.40])
        by avasout06 with smtp
        id GLWH1u0080srQBz01LWJEa; Mon, 05 Dec 2016 20:30:19 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Xom4AhN9 c=1 sm=1 tr=0
 a=8Z0saNXTz8GoXi/9Q5ysMA==:117 a=8Z0saNXTz8GoXi/9Q5ysMA==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=aROOY3qcNw5Mhn4uapMA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [RFC PATCH] GIT-VERSION-GEN: set --abbrev=9 to match auto-scaling
To:     Junio C Hamano <gitster@pobox.com>
References: <22e9dfa0-47fb-d6fd-caf4-c2d87f63f707@ramsayjones.plus.com>
 <20161205053258.jtnqq64gp5n7vtni@sigill.intra.peff.net>
 <ab1e7ce9-1022-0c72-2f72-63e3b9182bc9@ramsayjones.plus.com>
 <xmqq7f7e5jsy.fsf@gitster.mtv.corp.google.com>
Cc:     Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <e74163ee-e7d4-bcbd-e65f-368bc2ee9a2d@ramsayjones.plus.com>
Date:   Mon, 5 Dec 2016 20:30:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <xmqq7f7e5jsy.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 05/12/16 18:10, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> Heh, that was the first version of the patch. However, I got to thinking
>> about why --abbrev=7 was there in the first place; the only reason I
>> could think of was to defeat local configuration to get a measure of
>> reproducibility.
>>
>> Unfortunately, you can't get the 'auto' behaviour from --abbrev
>> (on the pu branch):
>>
>>     $ ./git describe --abbrev=-1
>>     v2.11.0-286-g109e8
>>     $ ./git describe --abbrev=0
>>     v2.11.0
>>     $ ./git describe
>>     v2.11.0-286-g109e8a99d
>>     $
> 
> What is the reason why the last one is undesirable?  Is it because
> the user may have core.abbrev set to some value in the configuration
> and you want to override it to force "auto"?

As I said, the original version of the patch just removed the
--abbrev=7, but then I started to think about why you might have
used --abbrev in the first place (first in commit 9b88fcef7 and
again in commit bf505158d). Making sure to override the configuration
was the only thing I could come up with. So, I was hoping you could
remember why! :-P

(I assumed it was to force a measure of uniformity/reproducibility).

ATB,
Ramsay Jones


