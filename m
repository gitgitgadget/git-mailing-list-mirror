Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 098B5208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 16:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389101AbeHGSa5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 14:30:57 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:56041 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731069AbeHGSa5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 14:30:57 -0400
Received: from [192.168.2.240] ([92.22.26.195])
        by smtp.talktalk.net with SMTP
        id n4eGf3liOpXFjn4eHfZBH9; Tue, 07 Aug 2018 17:15:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1533658554;
        bh=8GH5PMOVFPvtjpg2fkUQ8I7JbflN4K6eOuCEw+bFLNY=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=oQQ1QvUcuwfpx+2UnGTclrR+k+434yXv+LEc449f7BRUUyaq2Jt+GoQR8SLI8RQbI
         qRjk0JeHii3frh+OkYBHzpTiv+sMxIygxSk7YnMFi0GkDsWa75h0AfzrQu0XtlTFXz
         m9JBlJPj6GLEkX5veT2bBfBlVjE9/aEFouJdODZo=
X-Originating-IP: [92.22.26.195]
X-Spam: 0
X-OAuthority: v=2.3 cv=Ob228CbY c=1 sm=1 tr=0 a=8bf3kEuDtVJeVZALKX4IsA==:117
 a=8bf3kEuDtVJeVZALKX4IsA==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=3m-pOZQshecqAkykS6AA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v5 02/20] rebase -i: rewrite append_todo_help() in C
To:     Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Alban Gruin <alban.gruin@gmail.com>, git <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <20180724163221.15201-1-alban.gruin@gmail.com>
 <20180731180003.5421-1-alban.gruin@gmail.com>
 <20180731180003.5421-3-alban.gruin@gmail.com>
 <d83efc2e-3538-9547-244f-ca7653498c22@talktalk.net>
 <CAP8UFD3KbDrvU3zj24F7FF9ui2X75Vih4CoYE=cCZEWMsKP9Fw@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <6832700d-d7be-1df1-8b24-6e0290de63ed@talktalk.net>
Date:   Tue, 7 Aug 2018 17:15:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAP8UFD3KbDrvU3zj24F7FF9ui2X75Vih4CoYE=cCZEWMsKP9Fw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBlaLlVxxnpdJ3boW93rmF4tbpZl34T9pSmD+EsSB6pBtcsHS0ndTRy8DA+SEXf4HXZWtOWO16kKW3EwfbrQ1/zi1rXmIBjR+5R4/Tbvv594nhUAcb9e
 9omLL82pUQrkjMvCLTB+7vnb9Rp+FYSsgrdtle2kmQeA3wGMB1JU/YHUs1x3/IOMJOMgYGrO4JGIX6ydfbn8ncxLhTkq3nX3G8OlI5l9Ead3bAsCDJs2br2j
 AtYqnBIS+QC9FQIvgFQu9OyA+44POz6JUmRRJHW2064XOE27Ud6Ga//lBYZvWxbyMU0Z14TOtXhM50t0hfIUjbbun+2nEX0XAEZGP7DsK6Kxru/17o0NR/dd
 UvNWxGrsygnNtm9WjsMfVjmQGe3Tq5BmPgvlNO3R0eXcDEdcN/1V8f9gXo6nx0x/yS9Zq4hc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian
On 07/08/18 16:25, Christian Couder wrote:
> Hi Phillip,
> 
> On Tue, Aug 7, 2018 at 3:57 PM, Phillip Wood <phillip.wood@talktalk.net> wrote:
>>
>> On 31/07/18 18:59, Alban Gruin wrote:
>>>
>>> +
>>> +     ret = fputs(buf.buf, todo);
>>
>> It is not worth changing the patch just for this but strbuf_write()
>> might be clearer (you use it in a later patch)
>>
>>> +     if (ret < 0)
>>> +             error_errno(_("could not append help text to '%s'"), rebase_path_todo());
>>> +
>>> +     fclose(todo);
>>
>> You should definitely check the return value and return an error if
>> appropriate as fputs() might not actually write any data until you try
>> and close the file.
> 
> I agree about checking the return value from fputs(), but it seems to
> me that we don't usually check the value of fclose().

A quick grep shows you're right, there are only a handful of places 
where the return value of fclose() is checked (there aren't many checks 
for the return value of close() either), I'm don't think that is safe 
though given that write errors may only show up when the file gets 
flushed by closing it.

Best Wishes

Phillip

> Thanks,
> Christian.
> 

