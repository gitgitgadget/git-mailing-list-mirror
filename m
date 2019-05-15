Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9E161F461
	for <e@80x24.org>; Wed, 15 May 2019 06:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbfEOGn3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 02:43:29 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:19485 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbfEOGn3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 02:43:29 -0400
Received: from [192.168.1.22] ([92.1.197.142])
        by smtp.talktalk.net with SMTP
        id QndPhxCf7draxQndPhzzM8; Wed, 15 May 2019 07:43:27 +0100
X-Originating-IP: [92.1.197.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=QfUYQfTv c=1 sm=1 tr=0 a=gH7h/AuSNjzKVpz8AWYPeg==:117
 a=gH7h/AuSNjzKVpz8AWYPeg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=anyJmfQTAAAA:8 a=3hWsQWrtkictX63ojR8A:9 a=QEXdDO2ut3YA:10
 a=YJ_ntbLOlx1v6PCnmBeL:22
Subject: Re: [PATCH] git.c: show usage for accessing the git(1) help page
To:     Jeff King <peff@peff.net>, Emily Shaffer <emilyshaffer@google.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
References: <3cd065d1-9db5-f2e6-ddff-aa539746d45e@iee.org>
 <20190514152450.15220-1-philipoakley@iee.org>
 <20190515001717.GA138048@google.com>
 <20190515015331.GC13255@sigill.intra.peff.net>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <7bd330d7-81f1-52b4-52d3-b74b128af83a@iee.org>
Date:   Wed, 15 May 2019 07:43:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515015331.GC13255@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfIdlSoJC4lys7NFUBtxMPCsqhUG1p2u6Vx/mVwHdoujt/RTyJyrRxS67HRdLQnYZrBZ9Xfp1uBaBXnbLbu7zBgHtYH47BqAT3F0KA4aVhfGbsl5CzZf5
 6p/Fi2X8lYwsUyDzfAP6Zovkq5bhC4Lz863yWnMBB4CdY3qFAAM/AnVzVCQQtZXZ3HJgshhPgJqro06iQmXui8N1g20bLzs66uqoVbiN0jltAeANL5DJWQ1Q
 CyW2sYB5hIia/opQQuPFdc4ZIC5qDXexLjHsIeztm0In00yBekBK/b+JwzhJosLelLEqURaSMfT78dxlOeaKuFSJzde/tqbIkCX5NamYmEs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On 15/05/2019 02:53, Jeff King wrote:
> On Tue, May 14, 2019 at 05:17:17PM -0700, Emily Shaffer wrote:
>
>>>   const char git_more_info_string[] =
>>>   	N_("'git help -a' and 'git help -g' list available subcommands and some\n"
>>>   	   "concept guides. See 'git help <command>' or 'git help <concept>'\n"
>>> -	   "to read about a specific subcommand or concept.");
>>> +	   "to read about a specific subcommand or concept. Or use 'git help git'.");
>> I'm not sure the wording makes sense here. It sounds like you're saying,
>> "Or use 'git help git' to read about specific subcommands or concepts."
>> which isn't really what I think you're trying to say.
>>
>> What about, "Or, use 'git help git' for a detailed guide of the Git
>> system as a whole."
> I had a similar reaction on reading Philip's patch. I think your
> suggestion is better. We could even shorten it to just:
>
>    Use 'git help git' for an overview of the system.
That is a lot better. I like it. Concise and effective. I'll create a v2.
>
> Looking at "git help git" I actually think the DESCRIPTION section could
> do a better job of being a first entry-point for new readers of the
> documentation. But I don't think that needs to be a blocker for what
> we're discussing here.
I'd agree for both points.
>
>> (I'm still not sure that's quite it - since `git help git` mostly
>> details the flags you can pass to git before invoking a subcommand. But
>> I'm not sure that `git --help` is the place to say that...)
> Yeah, I almost suggested something like:
>
>    Use 'git help git' for options and environment variables that affect
>    all subcommands.
>
> I'm not sure if that points people in a useful direction, or if it is
> getting too much into the weeds (again, probably the description section
> of git(1) could talk about how to find which documentation where.
>
> I also think it should point to git-scm.com for the hyper-linked
> documentation, since it's less ugly than the stuff at git.github.io, but
> that's really getting off-topic. :)
>
> -Peff
Interestingly, try seeing if you can use tab completion to type in 'git 
help git'. It's nearly as hard to find as the user-manual, which isn't a 
man(1) page ;-)

Philip
