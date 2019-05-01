Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECFF21F453
	for <e@80x24.org>; Wed,  1 May 2019 15:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfEAPg3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 11:36:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35778 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfEAPg2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 11:36:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id f7so16489169wrs.2
        for <git@vger.kernel.org>; Wed, 01 May 2019 08:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mxyvT5IZ9DtClXpBElYg67dN0Wc8G1cGHxmLuehU7kY=;
        b=tIdsFaV+2lt3wx24DVBJ0Kr6F2FLW1lt1KcuwEcrW/PT9fbeirRaF7+jNaL067r5Jf
         Hf/sDYLg6iaOwzvbn3Zu9rXGomHWLGsUuOuj/fc21fSuuFpH0/3LtAs5fn12MF0EPz2g
         p1Q/KKDlhCwGltkgGS38FXEFxZh2Xac6mH8h7HV5WMPefY+fGTOkAyENRSR17QhzSLfa
         RT5DZ13WNgIt52m9FdUcQbOVvkoSR1DVwTZXga9wIP6NuLQK7lzOKxo6qMBVCocwASiF
         PBAlskQ8KUf4K81asz0rvEzaWWram29583EHPkbkOpLJjyNoeUmjoyWF2L7Z4GdmC3jU
         2vsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mxyvT5IZ9DtClXpBElYg67dN0Wc8G1cGHxmLuehU7kY=;
        b=tUtCBrjbzaCRBfiZcj8WVW4YlAa3tGU+qMIeJcic7j5Ang2VeASRuTovFi7/qvZ9xt
         au5eFkdU403CJC3QEfNOYEbM6oELDQ1irurobmmx89jAicovrada9CraL2EOHwT+8+o/
         53NwOdYMSmiWdVbz+bdVEYDIoA4gXA30VursgQIeomD8D+717ICKvSMRrG3a9FqpEQ45
         gvOekMtff72aS4sZR0irMJrGPp6CUMq4XL26U4P0KA3W8emCjjXxtWB2OamztBptmEC2
         AnL1mEdt089sPpZgBXugLJ5BLIAowcWKHKpqXYPbigRb1R84m/socgfP1gSTE32yMMKC
         usjA==
X-Gm-Message-State: APjAAAVGYZwqfPjXgReBreK7r4/fMX/TAb1QowIa8ZzchFWx5PWWrrQQ
        kcX1BZenO9aK59DcuRMf2Bn13DV+
X-Google-Smtp-Source: APXvYqy0VtiGA7xKQhNnpcSkTVBVoJ0MneQswx0PBJvIiOGX1VGIr9sr6RrXH3jEB1Sm+lvdgEBIjA==
X-Received: by 2002:adf:dcc7:: with SMTP id x7mr13610105wrm.197.1556724986734;
        Wed, 01 May 2019 08:36:26 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id c20sm47642344wre.28.2019.05.01.08.36.25
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 08:36:26 -0700 (PDT)
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
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <4d486504-7f64-95fb-b7eb-51d424f3e6cc@gmail.com>
Date:   Wed, 1 May 2019 16:36:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1904301848510.45@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 30/04/2019 23:49, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Tue, 30 Apr 2019, Phillip Wood wrote:
> 
>> On 29/04/2019 17:07, Johannes Schindelin wrote:
>>>
>>> On Fri, 26 Apr 2019, Phillip Wood wrote:
>>>
>>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>>
>>>> When `rebase -r` finishes it removes any refs under refs/rewritten
>>>> that it has created. However if the rebase is aborted these refs are
>>>> not removed. This can cause problems for future rebases. For example I
>>>> recently wanted to merge a updated version of a topic branch into an
>>>> integration branch so ran `rebase -ir` and removed the picks and label
>>>> for the topic branch from the todo list so that
>>>>       merge -C <old-merge> topic
>>>> would pick up the new version of topic. Unfortunately
>>>> refs/rewritten/topic already existed from a previous rebase that had
>>>> been aborted so the rebase just used the old topic, not the new one.
>>>>
>>>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>> ---
>>>
>>> Makes a ton of sense, and I feel a bit embarrassed that I forgot about
>>> that item on my TODO list. The patch looks obviously correct!
>>
>> Thanks, after I sent it I realized that --quit should probably clear
>> refs/rewritten as well, so I'll re-roll with that added. (One could argue that
>> a user might want them after quitting the rebase but there is no way to clean
>> them up safely once we've deleted the state files and I suspect most users
>> would be suprised if they were left laying around)
> 
> I am not so sure. `--quit` is essentially all about "leave the state
> as-is, but still abort the rebase".

I think it depends on what you mean by "state" `--quit` is about 
removing state specific to rebases while preserving HEAD, the index and 
worktree. When "rebase --quit" was introduced in 9512177b68 ("rebase: 
add --quit to cleanup rebase, leave everything else untouched", 
2016-11-12) the start of the log message reads

     rebase: add --quit to cleanup rebase, leave everything else untouched

     There are occasions when you decide to abort an in-progress rebase and
     move on to do something else but you forget to do "git rebase --abort"
     first. Or the rebase has been in progress for so long you forgot about
     it. By the time you realize that (e.g. by starting another rebase)
     it's already too late to retrace your steps. The solution is normally

         rm -r .git/<some rebase dir>

     and continue with your life.


So `--quit` is used when the user has forgotten to run "rebase --abort". 
They have moved onto something else and want to remove the rebase state 
without changing the current HEAD, index or worktree, they are not 
looking to use the refs under refs/rewritten. I think the refs rebase 
creates under refs/rewritten is an implementation detail of "rebase -r" 
and should be treated like files under .git/rebase-merge. I'm worried 
that if we leave them lying around after --quit they will cause trouble 
for future rebases in the same way they have after "rebase --abort"

Best Wishes

Phillip

> So if I were you, I would *not* remove the `refs/rewritten/` refs in the
> `--quit` case.
> 
> Ciao,
> Dscho
> 
