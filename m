Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 580F61F453
	for <e@80x24.org>; Fri,  3 May 2019 10:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfECKGm (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 May 2019 06:06:42 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40695 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfECKGl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 May 2019 06:06:41 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so7101316wre.7
        for <git@vger.kernel.org>; Fri, 03 May 2019 03:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8QG1GYO2KDSt8yuDCFKx8VdwRgn+h4JIUKTjytGHJUk=;
        b=qA5NYL+FkbWxc6BfsJeuNo75yij9GfYbyIzbEmardoVqjCV/4ejzbYDJqFR2ybRFSW
         lH1XC7mPS3OyKZ6/ngN/5yPGc/FO29f8NhqkUfo1UzXy5KLhO6gvqkB8hcrlQG8Lrhpp
         gzbfI0is2drTwLgF29prCNF4RkcG+yKNwcTEwgfVZpgPMUNukR45OyMKtUJpwdr21M8k
         Fn/OePpk/xAm3GeWlZ/k+GE85wmsDiDnYorczN3BhoeR7G/DPejzzkNG7hTmbcWEhSpM
         eKNbvDFbSdlYL0nP7pa4iEw/NwKcXe2tmsMpMYOLRR6OPSjhnylaP0gbThhOEhZtEkgP
         PjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8QG1GYO2KDSt8yuDCFKx8VdwRgn+h4JIUKTjytGHJUk=;
        b=d9GeaKaMlYrBJlLEPXcp9R7+vR1RHxA6NCSE9tPViPsV5gSAITqoZ0Em0CzCuGFGzq
         NaEpKC6SzCNLYV6sBpT/wsUYjry4kdHQpX79R6mMFFSnzcafX0yCQQG/yiQo3+l3Nbnb
         cKApuBpAFX/MT9zM/orxV9ZzdlLjuOHfeoROqAODTdL/WOZ3A8YNDofOKIN6Ltdm6AIj
         J60oWWdRYFkEXpjSk856nrDfr+iHXN7speLz5nVQ3M+AKjy9+s3SailV6V3hV4TEz9Bh
         uQMwczX0vQr7OY9O2dIfZmvmDu9yQ8sScgnAMoX2B/JRvatKt1q1e/dHGQOm3IR8o6ep
         +g3w==
X-Gm-Message-State: APjAAAVz4l3k8VYgmDY5X+0/zOHigHTaOQyBwQZOYB5BzYwo9qastHvO
        8DHmlroVJoNndfqEUworvNc=
X-Google-Smtp-Source: APXvYqzHiq6gw/igyHL7OAIRw4ZqocxaMA8o/Szde0086oq7IQZ5vgPYHT9r//L2oEOw0sQLVDqYLw==
X-Received: by 2002:a5d:4ec9:: with SMTP id s9mr5608213wrv.223.1556877999946;
        Fri, 03 May 2019 03:06:39 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id 17sm2268410wrk.91.2019.05.03.03.06.38
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 03:06:39 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase --abort: cleanup refs/rewritten
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <20190426103212.8097-1-phillip.wood123@gmail.com>
 <nycvar.QRO.7.76.6.1904291207040.45@tvgsbejvaqbjf.bet>
 <a3d5dd8c-12a6-a1d8-a41f-ef75c15df024@gmail.com>
 <nycvar.QRO.7.76.6.1904301848510.45@tvgsbejvaqbjf.bet>
 <4d486504-7f64-95fb-b7eb-51d424f3e6cc@gmail.com>
 <nycvar.QRO.7.76.6.1905031117500.45@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <e7adc1ec-3db3-654c-4ee1-e1a93ec84a99@gmail.com>
Date:   Fri, 3 May 2019 11:06:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1905031117500.45@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 03/05/2019 10:21, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Wed, 1 May 2019, Phillip Wood wrote:
> 
>> On 30/04/2019 23:49, Johannes Schindelin wrote:
>>>
>>> On Tue, 30 Apr 2019, Phillip Wood wrote:
>>>
>>>> On 29/04/2019 17:07, Johannes Schindelin wrote:
>>>>>
>>>>> On Fri, 26 Apr 2019, Phillip Wood wrote:
>>>>>
>>>>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>>>>
>>>>>> When `rebase -r` finishes it removes any refs under refs/rewritten
>>>>>> that it has created. However if the rebase is aborted these refs are
>>>>>> not removed. This can cause problems for future rebases. For example I
>>>>>> recently wanted to merge a updated version of a topic branch into an
>>>>>> integration branch so ran `rebase -ir` and removed the picks and label
>>>>>> for the topic branch from the todo list so that
>>>>>>        merge -C <old-merge> topic
>>>>>> would pick up the new version of topic. Unfortunately
>>>>>> refs/rewritten/topic already existed from a previous rebase that had
>>>>>> been aborted so the rebase just used the old topic, not the new one.
>>>>>>
>>>>>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>>>> ---
>>>>>
>>>>> Makes a ton of sense, and I feel a bit embarrassed that I forgot about
>>>>> that item on my TODO list. The patch looks obviously correct!
>>>>
>>>> Thanks, after I sent it I realized that --quit should probably clear
>>>> refs/rewritten as well, so I'll re-roll with that added. (One could argue
>>>> that
>>>> a user might want them after quitting the rebase but there is no way to
>>>> clean
>>>> them up safely once we've deleted the state files and I suspect most users
>>>> would be suprised if they were left laying around)
>>>
>>> I am not so sure. `--quit` is essentially all about "leave the state
>>> as-is, but still abort the rebase".
>>
>> I think it depends on what you mean by "state" `--quit` is about removing
>> state specific to rebases while preserving HEAD, the index and worktree.
> 
> I guess the fault is mine for bleeding out internal rebase state into the
> refs namespace.

I wouldn't feel bad about that, I guess it would be possible to get gc 
to read a list of objects not to collect from a file in 
.git/rebase-merge but creating a refs for labels seems like a sensible 
way to stop them from being collect by gc.

> While I cannot really imagine any harm from this patch in practice, it is
> slightly worrisome that deleting refs also deletes their reflogs,

Yes it's a shame there's no way to get a ref back once it's been deleted 
(though I'm not sure how long we'd want to keep any reflog of a deleted 
ref before gc'ing the objects). In any case refs/rewritten only has a 
reflog if the user has explicitly enabled it.

> which
> makes it an unrecoverable problem *iff* any user runs into trouble with
> this.

I guess "rebase --quit" could print a warning listing the refs that are 
being deleted so the user can cut and paste if they need to. I'm not 
sure how likely they are to need that though.

Best Wishes

Phillip

> Ciao,
> Dscho
> 
