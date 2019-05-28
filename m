Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 968A21F462
	for <e@80x24.org>; Tue, 28 May 2019 16:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfE1QRx (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 12:17:53 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:38211 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfE1QRx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 12:17:53 -0400
Received: from [192.168.1.22] ([78.148.161.28])
        by smtp.talktalk.net with SMTP
        id VenOhndlLgI7iVenOhFjGm; Tue, 28 May 2019 17:17:51 +0100
X-Originating-IP: [78.148.161.28]
X-Spam: 0
X-OAuthority: v=2.3 cv=KYisTjQD c=1 sm=1 tr=0 a=ujKALdKAi7z8notBBWqKeA==:117
 a=ujKALdKAi7z8notBBWqKeA==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=xtxXYLxNAAAA:8 a=--dH522_RBiTyUreODEA:9 a=QEXdDO2ut3YA:10
 a=xts0dhWdiJbonKbuqhAr:22
Subject: Re: [PATCH] doc branch: provide examples for listing remote tracking
 branches
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GitList <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>
References: <CACsJy8CwY8gzeWa9kNRX3ecez1JGiQiaOknbAoU7S+hiXBoUGQ@mail.gmail.com>
 <20190528121315.2604-1-philipoakley@iee.org>
 <xmqq5zpuel4m.fsf@gitster-ct.c.googlers.com>
 <d44cbf49-dea9-c518-17e3-f9b252f2dd06@iee.org>
 <48b03739-b8f7-4d94-15dd-cf7936215a0e@iee.org>
 <xmqqftoy60hq.fsf@gitster-ct.c.googlers.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <2ea35ad4-4b33-0ece-4de4-b2e92a100d9a@iee.org>
Date:   Tue, 28 May 2019 17:17:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqftoy60hq.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfLGZA9rOQ2orUEhAm9Ot1tlQoJdoE8FYDvjWEIw2rVKpd3N6psonbvZlPANweIomjqUlH1r4i8yjfgmJv/TdKru8dpqZI9KC+vRqviszBwpsaUuscz/K
 hFGTGHJVAoh+lWv3briHe2pbvdX6d+5eaimRjybXRrSF6xq4DNfVaN0PWEgMtTWpQcXuIbXN4NTvJ0mwjxhFvM6L6ltDuginZXLpilcvMLjp+NwyanOvuWmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/05/2019 16:51, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.org> writes:
>
>> However, isn't `-r <pattern>` broken?
> No.
Then why does it say:
     fatal: -a and -r options to 'git branch' do not make sense with a 
branch name

when there is no `-a` given?
>
>> phili@Philip-Win10 MINGW64 /c/git-sdk-64/usr/src/git (branch-patterns)
>> $ git branch -a -l 'junio/*'
> You are asking "branch --all --list" here.
>
>> $ git branch -a -r 'junio/*'
>> fatal: -a and -r options to 'git branch' do not make sense with a
>> branch name
> You wanted to ask "branch --remote --list" instead of "branch --all
> --remote", no?
>
The initial expectation was that a simple "--remote <pattern>" would be 
all that was required to list the rtbs with the sub-pattern (see fatal 
above, which is maybe how Ævar got his -a formulation). But it now 
appears that we/I need the --list, to allow a pattern, and either -a, or 
-r, to include the rtbs in the list.

So ultimately, yes, to just get the rtbs of a specific remote one needs 
your "branch --remote --list `<remote>/*' "formulation.

Philip
