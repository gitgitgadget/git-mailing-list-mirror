Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F19241F461
	for <e@80x24.org>; Tue, 20 Aug 2019 18:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbfHTSA5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 14:00:57 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:44186 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfHTSA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 14:00:56 -0400
Received: by mail-vs1-f68.google.com with SMTP id c7so4147920vse.11
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 11:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=RLOWyWIkc61nQhY691N8/CB8qVKYsR6G9Xk22HShzak=;
        b=vVXRk69Y5WLimdX6D4QZq8oDXuHuTEbsT+wwS5F142ZodykZXUjKWTsULx9pMU5dGw
         eZr8WulqbngikmG4wAkiJJMr34KGAXKem+E7LDiaEYqn/d4MWktOKA3rSqGGJuHV2JZC
         TKUjhjuCSV5OqkhK6666uIw2K7Fdos5nEa8hhkGbuIkVZMCH2gt2+2TVTrC6Ff8NlpRl
         MmXuaKXIl0EOqAqVJgmcmApm6GeOhwmO+KoYp0wZC8NOX44/k5vrVLkd/qP6cvIFk/S+
         WIruwtJCXQbQIQi76MkZPjwMhFGqy3yhdM7hWGF99ZV1iEgVf0vXlBdZs8jO4XvuMdx6
         uCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RLOWyWIkc61nQhY691N8/CB8qVKYsR6G9Xk22HShzak=;
        b=P6bSddWpoYh/bckjzLonFKvmnwbzP6wLG1WqhwkIK8RyO+Ar1Zat3HnX1GLeTwWeN4
         ebGLjd6Hv3IGunSgshZI3K7pgNPkK2/3dD9JwOW8yTTVMvH7IyT349D8zS0DBcXcxYUy
         WMhBsbs6+VBFLb1x2UVMTOrXx1gmb5g2ADDEPGsbQIbzvdpFlqZYG0BKtB4Z2Spbb8pl
         GO0pG2T7S1KH88v3pw+0b3Wsks9N6tORuFaeyaCu61PTAKMMmEpVt9ZPbBaA7UZY4YdL
         W1gB2vXeuDUauiu0qEXeRucfjRiY/7hhiXyuiHmDUWTjO2ORR1fLnhiIbFin/y/Ny7+j
         p71A==
X-Gm-Message-State: APjAAAVf1TxdwS+rlaRcXwjyY+5lePqQP+kUmc7i2jUc65Jg5gQLwFWS
        qrl7h61yz6PcifO1PYVECVrfo5A2
X-Google-Smtp-Source: APXvYqzayun5lkLyS1vNLFjC1bTo8hjJZ/YnVjAaqduEyJdszOJKSlylzg3eF1xzLX1ppq04rPxDFA==
X-Received: by 2002:a67:f3d6:: with SMTP id j22mr17379637vsn.95.1566324055217;
        Tue, 20 Aug 2019 11:00:55 -0700 (PDT)
Received: from [192.168.1.254] (c-73-217-142-143.hsd1.sc.comcast.net. [73.217.142.143])
        by smtp.gmail.com with ESMTPSA id b202sm3769451vkf.45.2019.08.20.11.00.54
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2019 11:00:54 -0700 (PDT)
Subject: Re: Only track built files for final output?
To:     git@vger.kernel.org
References: <477295c5-f817-e32b-04fd-a41ddfbbac0a@gmail.com>
 <20190820174640.n3elekpi6l4vwamp@localhost.localdomain>
From:   Leam Hall <leamhall@gmail.com>
Message-ID: <f899594c-4f57-b941-f4f1-fd3b8f81136a@gmail.com>
Date:   Tue, 20 Aug 2019 14:01:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820174640.n3elekpi6l4vwamp@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/20/19 1:46 PM, Pratyush Yadav wrote:
> On 20/08/19 08:21AM, Leam Hall wrote:
>> Hey all, a newbie could use some help.
>>
>> We have some code that generates data files, and as a part of our build
>> process those files are rebuilt to ensure things work. This causes an issue
>> with branches and merging, as the data files change slightly and dealing
>> with half a dozen merge conflicts, for files that are in an interim state,
>> is frustrating. The catch is that when the code goes to the production
>> state, those files must be in place and current.
>>
>> We use a release branch, and then fork off that for each issue. Testing, and
>> file creation, is a part of the pre-merge process. This is what causes the
>> merge conflicts.
>>
>> Right now my thought is to put the "final" versions of the files in some
>> other directory, and put the interim file storage directory in .gitignore.
>> Is there a better way to do this?
>>
> 
> My philosophy with Git is to only track files that I need to generate
> the final product. I never track the generated files, because I can
> always get to them via the tracked "source" files.
> 
> So for example, I was working on a simple parser in Flex and Bison. Flex
> and Bison take source files in their syntax, and generate a C file each
> that is then compiled and linked to get to the final binary. So instead
> of tracking the generated C files, I only tracked the source Flex and
> Bison files. My build system can always get me the generated files.
> 
> So in your case, what's wrong with just tracking the source files needed
> to generate the other files, and then when you want a release binary,
> just clone the repo, run your build system, and get the generated files?
> What benefit do you get by tracking the generated files?

For internal use I agree with you. However, there's an issue.

The generated files are used by another program's build system, and I 
can't guarantee the other build system's build system is built like 
ours. It seems easier to provide them the generated files and decouple 
their build system layout from ours.


