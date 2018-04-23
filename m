Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FAA51F424
	for <e@80x24.org>; Mon, 23 Apr 2018 13:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755271AbeDWNWo (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 09:22:44 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:38200 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755206AbeDWNWn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 09:22:43 -0400
Received: by mail-qk0-f196.google.com with SMTP id b39so16081696qkb.5
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 06:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=znRzOjs1sZf+9EDV2ok97pEm4IMcea0tgh822rc3Lxs=;
        b=Wca6n6jBe3ulsAIjKIXnIGIEiQLzyNGaEMuRkTgQE3dQoO46ZypTCGYdGu3ncaP+IG
         o/VSLWAuDZn+0/ZaL6XACqEHL+hoX0kvpLumpXVVsjqrvcXk64/QS5mimB6uGdpwfVti
         ePqjBw9Xwud41ipQsmpTTiNqOaRwACFL9Vgaee0QocHv8vSkO/e69GXkYiWRUXTVBPjl
         09P3OkeeRL4IhavpV9LqEJHQFOGdQurZF318QDMPJ1aw2zgw18pOdic8dpDFW2ej9+/0
         A/w3jjpsnFR1SzLsQowoDszpEKqsjifQSzHi9xk1spEClymR0Wl2ptlZ5nd/ADOfVz9M
         etqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=znRzOjs1sZf+9EDV2ok97pEm4IMcea0tgh822rc3Lxs=;
        b=VRhElMvRLhgbI2cIXX7IavKDnIZFtq5uSsfvbDQFNwKZ0BzDZixfgWKgLEH81hkmZv
         LRbl/A3PcAenCXLUTQpl3IZAgn982kzZUzDPTffcr8raf1HJ3Oa/WIM7B90VF4lLxvZ7
         ms3MEVm17yteQLZgi1QB/aLDTsU8sVYgSbSzOlBKHBrvVj03C2z8gbQxa9xyu0p8Tdt6
         LjXegm5673ougXBBTGpJlkWHu71r8ZOcsGutbtlghAuswb/VXw3pMbZSO7Na3quhf8zo
         CIWDwHP+aoF6Egrx0nMMGppfFfN6n0cAPMDicoY8/v1KjZU7EcAnPJWOg6XB4CHogS5m
         HHPg==
X-Gm-Message-State: ALQs6tAEyFnA/nko9cY5PR+SSvpx6cjQ2npUcjVWwmlYIbIC6428bQWK
        CNwv0CoGuRrveYC39ZOuR8c=
X-Google-Smtp-Source: AIpwx4+Bhi3e5xAP2acaZvlzOd3WDas8JlZTelXUXTP1zE4/LqtaE8TbTlZS6ds58jsusxlS3cllgg==
X-Received: by 10.55.119.196 with SMTP id s187mr22173170qkc.171.1524489762511;
        Mon, 23 Apr 2018 06:22:42 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id z24-v6sm11327071qtz.66.2018.04.23.06.22.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Apr 2018 06:22:41 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] merge: Add merge.renames config setting
To:     Elijah Newren <newren@gmail.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>
References: <20180420133632.17580-1-benpeart@microsoft.com>
 <20180420133632.17580-2-benpeart@microsoft.com>
 <CABPp-BFANBs=tOhS5BFfTMkdQsNYbUDExWK8QB0V=qD9YwZyWw@mail.gmail.com>
 <cd49481c-9665-124a-5f94-791f1a16657d@gmail.com>
 <CABPp-BFqj2TFiHUDsysafq0NHC4MV-QYZVxOZe1TNRrXMOQfng@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <1e57021a-2a99-c3a7-f203-e3c9b0546876@gmail.com>
Date:   Mon, 23 Apr 2018 09:22:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BFqj2TFiHUDsysafq0NHC4MV-QYZVxOZe1TNRrXMOQfng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/20/2018 2:34 PM, Elijah Newren wrote:
> Hi Ben,
> 
> On Fri, Apr 20, 2018 at 10:59 AM, Ben Peart <peartben@gmail.com> wrote:
>>
>> On 4/20/2018 1:02 PM, Elijah Newren wrote:
>>>
>>> On Fri, Apr 20, 2018 at 6:36 AM, Ben Peart <Ben.Peart@microsoft.com>
>>> wrote:
>>>>
>>>> --- a/Documentation/merge-config.txt
>>>> +++ b/Documentation/merge-config.txt
>>>> @@ -37,6 +37,11 @@ merge.renameLimit::
>>>>           during a merge; if not specified, defaults to the value of
>>>>           diff.renameLimit.
>>>>
>>>> +merge.renames::
>>>> +       Whether and how Git detects renames.  If set to "false",
>>>> +       rename detection is disabled. If set to "true", basic rename
>>>> +       detection is enabled. This is the default.
>>>
>>>
>>> One can already control o->detect_rename via the -Xno-renames and
>>> -Xfind-renames options.
> 
> This statement wasn't meant to be independent of the sentence that
> followed it...
> 
>> Yes, but that requires people to know they need to do that and then remember
>> to pass it on the command line every time.  We've found that doesn't
>> typically happen, we just get someone complaining about slow merges. :)
>>
>> That is why we added them as config options which change the default. That
>> way we can then set them on the repo and the default behavior gives them
>> better performance.  They can still always override the config setting with
>> the command line options.
> 
> Sorry, I think I wasn't being clear.  The documentation for the config
> options for e.g. diff.renameLimit, fetch.prune, log.abbrevCommit, and
> merge.ff all mention the equivalent command line parameters.  Your
> patch doesn't do that for merge.renames, but I think it would be
> helpful if it did.
> 
> Also, a link in the documentation the other way, from
> Documentation/merge-strategies.txt under the entries for -Xno-renames
> and -Xfind-renames should probably mention this new merge.renames
> config setting (much like the -Xno-renormalize flag mentions the
> merge.renomralize config option).
> 

I'm all in favor of having more information in the documentation.  I'm 
of the opinion that if someone has made the effort to actually _read_ 
the documentation, we should be as descriptive and complete as possible.

I'll take a cut at adding the things you have pointed out would be helpful.

> I agree that's the pre-existing behavior, but prior to this patch
> turning off rename detection could only be done manually with every
> invocation.  I'm slightly concerned that users might be confused if
> merge.renames was set to false somewhere -- perhaps even in a global
> /etc/gitconfig that they had no knowledge of or control over -- and in
> an attempt to get rename detection to work they started passing larger
> and larger values for renameLimit all to no avail.
> 
> The easy fix here may just be documenting the diff.renameLimit and
> merge.renameLimit options that they have no effect if rename detection
> is turned off.

I can add this additional documentation as well.  While some might think 
it is stating the obvious, I'm sure someone will benefit from it being 
explicitly called out.

> 
> Or maybe I'm just worrying too much, but we (folks at $dayjob) were
> bit pretty hard by renameLimit silently being capped at a value less
> than the user specified and in a way that wasn't documented anywhere.
> 
