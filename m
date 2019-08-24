Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D9BC1F461
	for <e@80x24.org>; Sat, 24 Aug 2019 13:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfHXN7E (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Aug 2019 09:59:04 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:56718 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727546AbfHXN7E (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Aug 2019 09:59:04 -0400
Received: from [92.7.169.237] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1i1WZI-0002hl-Cg; Sat, 24 Aug 2019 14:59:01 +0100
Subject: Re: [PATCH v3 13/13] format-patch: learn --infer-cover-subject option
To:     Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <cover.1566258525.git.liu.denton@gmail.com>
 <cover.1566285151.git.liu.denton@gmail.com>
 <de599f7ca9b5fe7e298bba0bb8c5d05f2f5cf34f.1566285151.git.liu.denton@gmail.com>
 <xmqq8srms4ak.fsf@gitster-ct.c.googlers.com>
 <20190823181545.GA14048@archbookpro.localdomain>
 <d8a02cfd-2250-44ce-b559-dbec742b7cdf@iee.email>
 <xmqq1rxbmy8r.fsf@gitster-ct.c.googlers.com>
 <20190824080328.GA9726@archbookpro.localdomain>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <1eccefe4-8002-4664-3bc2-8332fb7bd697@iee.email>
Date:   Sat, 24 Aug 2019 14:59:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190824080328.GA9726@archbookpro.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/08/2019 09:03, Denton Liu wrote:
> On Fri, Aug 23, 2019 at 01:18:44PM -0700, Junio C Hamano wrote:
>> Philip Oakley <philipoakley@iee.email> writes:
>>
>>> Perhaps the `--infer-cover-subject` the config option needs to be
>>> multi-valued to include:
>>>       "subject" (always expect short first lines) or
>>>       "message" (always the long paragraph description, still use
>>> ***Subject Here***),
>>>       with the "true" being used when expecting both as previously
>>> described.
> Good idea, I like this a lot!
>
>> The idea to have three choices feels that this is getting better,
>> but I notice that the choice is no longer about "subject".
>>
>> I've always felt that the name of this option is way suboptimal.
>> One reason is because the option only says it is about the subject
>> of the cover (letter), and the verb "infer" conveys almost no
>> information---especially it does not say anything about what affects
>> the inference (hint: the branch description value gets used, in a
>> single hardcoded ways right now, but now with the patch we have a
>> choice to control how it gets used).
> Perhaps something like
> --cover-subject-from-description={true,auto,false}?

maybe --cover-letter-from-description={true,auto,subject,message,false}? 
to cover most eventualities (i.e. letter rather than subject).

I haven't looked at what happens on Windows (CRLF usage?) for multi-line 
descriptions. The common assumption is LF in repo, with attributes etc, 
but the branch description is a bit free format in terms of guidance ;-)

Philip

