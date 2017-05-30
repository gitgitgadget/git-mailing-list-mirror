Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67DCF2027C
	for <e@80x24.org>; Tue, 30 May 2017 18:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751175AbdE3SF5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 14:05:57 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34805 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750925AbdE3SF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 14:05:56 -0400
Received: by mail-qt0-f196.google.com with SMTP id l39so13311878qtb.1
        for <git@vger.kernel.org>; Tue, 30 May 2017 11:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MgJO/lpTPKI83LXRkdB6i69FZ7EwKcNF6xhg5zlacFI=;
        b=WOliFxee4vAqCwATky+p1W3k5e3FsQxw+eulkTd0KHjzoJoVoE5mOwkh1zwvtZuo8a
         p4rSQLXwyKAjigFu+swDtfTE+QWO9nY9jD1Q2xl7CxZOu7WTXSn9UQMdvc6sEA/HP20K
         YcfjdW1LwqWEptaRXjZiwI9MIKNZ8AozroPata9yEzPF3zqfXwo2X/lZ/4GtSY0fTf12
         Xm0vmYmw9bgmsR+hM3iDO3PgROLN24TR+/IzQRQ5ciUA6S9f6Y7/ueXXi0J2J1GPxC0/
         qP3p4X0UBydFEuhP4leen13rsu3mEi6b/ALMOga9gy4ZaUCocxyxDAUELa2Pnb+bYy9p
         FWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MgJO/lpTPKI83LXRkdB6i69FZ7EwKcNF6xhg5zlacFI=;
        b=LsFwq0V6zK+mLwS651INGCDUyKO62CWmR07oY4UbvOmc/h4Vff3vtF2wEgoE4hgcqr
         Bn+JJ4c6Sna6CcS9+hcMF2U/EyRHuK272FmTs/Z9PizetBoiDvbB7NNHKZFkueMQu4b2
         1U8iZeEvbZg9YvHJk40njiNRFWWl5gG/imTD6fOfstddnPR1K1NO/WNRNi60Z607EAVz
         wk0G4g51ys5zI7THRlYcU8GWn3PyBKwSm0yHezMeAhH0ShWUvESO3PzYkRdZ59Lxjdd8
         3eMc0wkyis/+6ZCyp/6juwfUjc6SKmbblCZoaeOdY0dlhjmmQrd+pEpBRzkrr4QrHCrg
         oH5Q==
X-Gm-Message-State: AODbwcAZaOuqS4o82Kqyrsr54Iy8nvvZGI/5o+bCZjdUklTIDmydPpLk
        eazTpDU7fsK17LcEWGk=
X-Received: by 10.237.53.3 with SMTP id a3mr24509546qte.207.1496167555138;
        Tue, 30 May 2017 11:05:55 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id d136sm1098142qkg.50.2017.05.30.11.05.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 May 2017 11:05:54 -0700 (PDT)
Subject: Re: [PATCH v2 0/6] Fast git status via a file system watcher
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        Jeff King <peff@peff.net>
References: <20170518201333.13088-1-benpeart@microsoft.com>
 <CAP8UFD20gvTZqCOcpd1iozNDHOZR1sUKRwi062wL52FNHWNC3w@mail.gmail.com>
 <ab37d437-2a4e-b6ed-621f-5978083cd15b@gmail.com>
 <CAP8UFD1L+caWyLS5KCX3QqToVuzii+0tX81=eGA=1_+L6O7ynA@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <8ac721a5-a90d-3d58-e9dd-a3eb2199d387@gmail.com>
Date:   Tue, 30 May 2017 14:05:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CAP8UFD1L+caWyLS5KCX3QqToVuzii+0tX81=eGA=1_+L6O7ynA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/27/2017 2:57 AM, Christian Couder wrote:
> On Thu, May 25, 2017 at 3:55 PM, Ben Peart <peartben@gmail.com> wrote:
>>
>>
>> On 5/24/2017 6:54 AM, Christian Couder wrote:
>>>>
>>>> Design
>>>> ~~~~~~
>>>>
>>>> A new git hook (query-fsmonitor) must exist and be enabled
>>>> (core.fsmonitor=true) that takes a time_t formatted as a string and
>>>> outputs to stdout all files that have been modified since the requested
>>>> time.
>>>
>>>
>>> Is there a reason why there is a new hook, instead of a
>>> "core.fsmonitorquery" config option to which you could pass whatever
>>> command line with options?
>>
>>
>> A hook is a simple and well defined way to integrate git with another
>> process.  If there is some fixed set of arguments that need to be passed to
>> a file system monitor (beyond the timestamp stored in the index extension),
>> they can be encoded in the integration script like I've done in the Watchman
>> integration sample hook.
> 
> Yeah, they could be encoded in the integration script, but it could be
> better if it was possible to just configure a generic command line.
> 
> For example if the directory that should be watched for filesystem
> changes could be passed as well as the time since the last changes,
> perhaps only a generic command line would be need.

Maybe I'm not understanding what you have in mind but I haven't found 
this to be the case in the two integrations I've done with file system 
watchers (one internal and Watchman).  They require you download, 
install, and configure them by telling them about the folders you want 
monitored.  Then you can start querying them for changes and processing 
the output to match what git expects.  While the download and install 
steps vary, having that query + process and return results wrapped up in 
an integration hook has worked well.

> 
> I am also wondering about sparse checkout, as we might want to pass
> all the directories we are interested in.
> How is it supposed to work with sparse checkout?
> 

The fsmonitor code works well with or without a sparse-checkout.  The 
file system monitor is unaware of the sparse checkout so will notify git 
about any change irrespective of whether git will eventually ignore it 
because the skip worktree bit is set.

>>>> A new 'fsmonitor' index extension has been added to store the time the
>>>> fsmonitor hook was last queried and a ewah bitmap of the current
>>>> 'fsmonitor-dirty' files. Unmarked entries are 'fsmonitor-clean', marked
>>>> entries are 'fsmonitor-dirty.'
>>>>
>>>> As needed, git will call the query-fsmonitor hook proc for the set of
>>>> changes since the index was last updated. Git then uses this set of
>>>> files along with the list saved in the fsmonitor index extension to flag
>>>> the potentially dirty index and untracked cache entries.
>>>
>>>
>>> So this can work only if "core.untrackedCache" is set to true?
>>>
>>
>> This works with core.untrackedCache set to true or false.  If it is set to
>> false, you get valid results, you just don't get the speed up when checking
>> for untracked files.
> 
> Great!
> 
