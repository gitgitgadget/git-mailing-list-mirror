Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E2921F404
	for <e@80x24.org>; Tue, 28 Aug 2018 00:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725754AbeH1ELN (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 00:11:13 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:59723 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725198AbeH1ELN (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Aug 2018 00:11:13 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 9573F397;
        Mon, 27 Aug 2018 20:22:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 27 Aug 2018 20:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stason.org; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=TNtEwMA5bfVnIM2AiBi+JynwW/M/g
        Od+0g277yl6HWA=; b=aNf4iKs+No4rT7fB6Yk7WYhTyz27fXnmCQqHElFyQGZ9e
        dQ+ROCur1NCC41rXoP1EWDMWiszhyGz/t2IPDzQYylYr0DJ8YTpEF4U+FYkF/EQC
        CwWVTNs3t7FTOauGevSPLH1FcpeG0lmZEtCtIA3pWsn4aCyPZ2bCc/6a6SLqmVnR
        +AXHV1mpuH87LboXhRydltSFwehw56LfPVd45ulyo34865vDPl01QAZHQCXaW/2+
        VdxgR2Tx8318azJyYRZqVSMhMEF2ccj/1OdoQY0j+fG1kHFUtnqcMGcxEvImYynI
        sFVfb0KRTLpIVn+fHtYiVNN454/iSh4dQw2CWWZWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=TNtEwM
        A5bfVnIM2AiBi+JynwW/M/gOd+0g277yl6HWA=; b=ZUDQ6Y3e44dvfF9FMdwT6z
        mkiQvpT4POcMmXzF0nFph82xdyW4qqzwRXZrsRGbNZsi1OEXTmYiuWjBQgyX7onB
        +VQidZlSMRduDfTeOXEDMAR8/Ygczx+12PAEHWsLrBb+0pxmqQq55QVsNAhEpBko
        fdElJsS4t2egdMez/LtJLxphnRsxV8mUa40rbN4VHAzAdmen41gk9klDjcfNfkN8
        +Uv4MXEbWasPO4Fj/5kMimvlH70xI4OD5YQwY42DTEf5x4yxzIK+CJ5+SXRx+1LD
        cTRvnhyUKlrWBPIXfLfCuVEcm5ovczutbM5j55JuZg57UVOl6qw20eegYu0MOc+A
        ==
X-ME-Proxy: <xmx:t5WEW68KhsYWEl-ej-xrQbJ5m5k6E8vJzX1Fep4d7bN-Oa9T1A8Cjg>
    <xmx:t5WEW668SMRdU1u-bi3djmMmSvNIL3q5kHOoOaC6UjVjopNQMJIExg>
    <xmx:t5WEWx3zvui1mhhcCNL3gsXuRC2lJEMFUvwF9rQqC96gPrPeFWgODw>
    <xmx:t5WEWxAPPNYXp6ex6gFhVpTSz6l7_C_Vv0lQk4MYuK74KqAjy59ZnQ>
    <xmx:t5WEWz21co0odBGJMu2mJE86DeFo4vywp5F-YpcWd0tEBUD3-VkqtQ>
    <xmx:t5WEWz4YIItYX1M6XIJNIXlDE-ttD3-xKTuVPPUM1WDuKS_fKqamXg>
X-ME-Sender: <xms:tpWEWyr8Xbh88mBpK_uzOTdrdjOMOcmVvJMl_-xhGpckc8xiwhSFww>
Received: from [192.168.0.10] (s0106f0f249e4dad3.gv.shawcable.net [96.54.245.187])
        by mail.messagingengine.com (Postfix) with ESMTPA id 783CAE405E;
        Mon, 27 Aug 2018 20:22:14 -0400 (EDT)
Subject: Re: GIT_TRACE doesn't show content filter files it's operating on
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <3fdc0c24-bbee-e7b3-ec43-7e926cee71e1@stason.org>
 <20180827235321.GB11663@sigill.intra.peff.net>
From:   Stas Bekman <stas@stason.org>
Organization: Hope, Humanized
Message-ID: <28045b26-4822-b00c-30f3-1076d2e49d1f@stason.org>
Date:   Mon, 27 Aug 2018 17:22:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180827235321.GB11663@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-08-27 04:53 PM, Jeff King wrote:
> On Mon, Aug 27, 2018 at 04:23:34PM -0700, Stas Bekman wrote:
[...]
>> How can I get GIT_TRACE's run_command to show the arguments passed to
>> the filter? I looked at various other debug environment variables in
>> git's manual, but I don't see anything that would enable that level of
>> debug.
[...]
> You can work around it with some shell hackery:
> 
>   git config filter.foo.clean 'f() { echo >&2 "cleaning $1"; myfilter ...; }; f %f'
> 
> and then even without GIT_TRACE, you get:
> 
>   $ git add .
>   cleaning .gitattributes
> 
> Or if you really just want to trigger for GIT_TRACE, try just this:
> 
>   $ git config filter.foo.clean 'f() { myfilter; }; f %f'
>   19:52:52.874064 [pid=14719] git.c:415             trace: built-in: git add .
>   19:52:52.875115 [pid=14719] run-command.c:637     trace: run_command: 'f() { myfilter; }; f '\''.gitattributes'\'''

Your suggestions do the trick, Jeff. Thank you.

1. To benefit others who might be looking for something similar may I
post your suggestions as an answer to:
<https://stackoverflow.com/questions/51995773/getting-git-to-show-specific-filenames-it-is-running-content-filters-on>?

2. Is there no way to get git to do the filename reporting as a normal
GIT_TRACE behavior? I don't know anything about its internal workings,
but it surely must knows which file it operates on when it opens it and
sends its data as stdin to the content filter. It makes the debugging so
much easier when one can see what files are being worked on. So perhaps
this utility can be made available to all not just as a hack/workaround.


-- 
________________________________________________
Stas Bekman       <'))))><       <'))))><
https://stasosphere.com  https://chestofbooks.com
https://experientialsexlab.com https://stason.org
https://stasosphere.com/experience-life/my-books
