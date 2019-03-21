Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40A3420248
	for <e@80x24.org>; Thu, 21 Mar 2019 14:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbfCUOkL (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 10:40:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45616 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfCUOkL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 10:40:11 -0400
Received: by mail-wr1-f68.google.com with SMTP id s15so2004785wra.12
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 07:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GS0+873nniqpYqjjXzl50pwtclpwgQwXrtaC2fexWR0=;
        b=KbDBNj9AFzi9ppd6MM9dpgf1Tro9yC9FDbwRaImscMtATqYM5SGELIK3mc2nWORnlI
         LW+HDZkxAufivwmVb2mFl7vYeQayRjANnE+fyCySImF6rcpJw1w5HfPq5fORQIOeLYGc
         oX/TX34nKWortezqQWfOLPbXvyP3E44gyfNn/TQMyGdKTeq75/NVqAqNk7E5SZOr0wus
         flwLyIb43hDgX0ZoTWpoeyi7q8EpbNVUxHuf3t9+FNNFy+rnNP6ZXVknzUIIak1ICR1+
         GYpT1iXwDzitYkENmw15L4ZngfiYYOPyO/OYCt6iaTgzqa0D4EmvMMNkitO9RYzYwVXA
         KCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GS0+873nniqpYqjjXzl50pwtclpwgQwXrtaC2fexWR0=;
        b=DJyYPBnt59eSqxwlL7ty0+fPAo4/fcEIEwwTZ2LLMSeggtW5XBFrwfhN9ObCQ0tzZT
         3WDI388wxux7p4NWL4MS5PrJj3aICWz5wAmrqrCf2fJ9kba8ijo8iiu7Ayil7eB8mh1b
         NKLTnR37wPwS6GP4lj3VHOHQ10AZLVRouUIBiNSDagXghfDEzfWi0CtDw5P6m5Zcd659
         LPnshgGp9qMU6125hYKOJpONmTDpfeuyWtz2NZqw1xNnELeXi+FvTkMduvGBd/oeVbF+
         3njNGmd366VPmJm0VnZWjKCgiH7uMU/ustDosuIjol5ae01cUqpIZqOSLg7OMSGkvvnw
         Gl1g==
X-Gm-Message-State: APjAAAWAp6FzjW5C8v7FRjGAHS0zip24GCJ57xRCtCEiE9Ts84IV8eES
        af/7y2TBh7tLkEZ6DeE+so0=
X-Google-Smtp-Source: APXvYqxDtDpJ5UZGxhY3+M4YPkJcTH8ca8OuUnR483b5CU2TYoNhXH3lsFAXdzwVWGOt29baaKAsyg==
X-Received: by 2002:adf:da42:: with SMTP id r2mr2843755wrl.62.1553179209759;
        Thu, 21 Mar 2019 07:40:09 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-184-133.as13285.net. [89.242.184.133])
        by smtp.gmail.com with ESMTPSA id a20sm8761082wmb.17.2019.03.21.07.40.08
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 07:40:09 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 00/11] rebase -i run without forking
 rebase--interactive
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190319190317.6632-1-phillip.wood123@gmail.com>
 <87y359cfjj.fsf@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <0f1ee77b-90e6-ef61-0aee-ff182c20a98c@gmail.com>
Date:   Thu, 21 Mar 2019 14:40:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <87y359cfjj.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 20/03/2019 23:05, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Mar 19 2019, Phillip Wood wrote:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> When the builtin rebase starts an interactive rebase it parses the
>> options and then repackages them and forks `rebase--interactive`. This
>> series refactors rebase--interactive so that interactive rebases can
>> be started by the builtin rebase without forking. My motivation was to
>> make it easier to debug the sequencer but this should help future
>> maintainability.
>>
>> This series involves some code movement so viewing the diffs with
>> --color-moved is recommended.
>>
>> These patches are based on a merge of master [e902e9bcae ("The second
>> batch", 2019-03-11)] and ag/sequencer-reduce-rewriting-todo ed35d18841
>> ("rebase--interactive: move transform_todo_file()", 2019-03-05). They
>> can be fetched from the tag rebase-i-no-fork/rfc at
>> https://github.com/phillipwood/git.git
> 
> Just a that the t/perf/*rebase* numbers look much better with this. I
> don't have these in front of me anymore, but over 10 runs with -O3 one
> of those long-runnings test was 30% faster.

That's surprising I wouldn't expect that much change as the time taken 
to fork shouldn't be that significant compared to the overall running 
time. I'll make a note to have a look at those tests.

> Another one (rebase -i) went from 0.02 to 0.01 sec, with that short
> amount of time I wonder (but didn't dig) if the test itself is broken...

Yeah, that sounds suspicious

Thanks for sharing those results

Phillip
