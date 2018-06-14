Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54DDA1F403
	for <e@80x24.org>; Thu, 14 Jun 2018 20:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755523AbeFNUYk (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 16:24:40 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35092 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754695AbeFNUYj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 16:24:39 -0400
Received: by mail-wm0-f68.google.com with SMTP id j15-v6so110790wme.0
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 13:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jI6uJ0QOhItUp7Rm9HqgIzTdLfPFoeUZIoqNRNgUF9Q=;
        b=bHW3dQdwMrviQ3iG0bueUAQ60dm0BSA83PmGwUiKXnAYHjWylR5wuQTFhiE1TwEdFi
         8knlsiwNBtTZGgbsvqFqsFIg130cCJEuUr+A1kNBP2N2l8HK3Iq8rdgopSZLNvz/XQ7C
         JB2Uf0ubEG9ArrryRUbukXEZ3VOfm3ZVKQ/IS+xOSW5E+Jni21JgHCjRJ0bpHH51Zv80
         h8y8Gs+dGCZJ8v8ea5mdFnjnUlfupDXctkdG37SPbM8hI5PJv8YZzULgu2nGgEhbcQj6
         BrHptcxJiekymoWOVr0n2mw0X5NbWOI8WYrS2d/f3dDYhwoppnozWpzm43SPgdUUcJ9A
         kIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jI6uJ0QOhItUp7Rm9HqgIzTdLfPFoeUZIoqNRNgUF9Q=;
        b=gS62uubpLK3/IJak8lfSzNAvea20/ALHLZLPcDGkjLkVdPpaM/qpPBDpMH0zIneRFX
         Ep8+w4YJCXZrx89rJaBSPn3cEgO6RxV/tp74ZvLOQNm3cEDNkk3hh63kR5jWElZhUjSD
         +qupYC5e5ud9WfB7jvww3UK9e6DWrc+QWjGFAMUeK+OU14Vs/t+zwSlpnubQp63d8QLO
         30Zt8bUzwBdx5NW5v2Kq0rXBSb2FisvtcuMv6eeiN8JII6cGcxXzok1Oq0L7aAXQnqUO
         6ivbb66uXjza7/eAxZ8rXHADKS9fmB0Q5yqMXq7J2mCvNzYEBEKBilpTmsDG3/tuurHM
         eeBA==
X-Gm-Message-State: APt69E11iBi/g5VoMfxTSAi82sA6ETaDcfVZddhZtETV5xi2y5OwVQnj
        Lhpf1+2mv39b16wICaWyCxzR7DHZ
X-Google-Smtp-Source: ADUXVKJ9etHDeeuyODM+OMuWFcHVfmCbN19g0twjynrLKBbhLon7oSSVtAninmrZUc1WBrL7xS7iLg==
X-Received: by 2002:a1c:2807:: with SMTP id o7-v6mr2816584wmo.11.1529007878216;
        Thu, 14 Jun 2018 13:24:38 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-40-196.w86-221.abo.wanadoo.fr. [86.221.119.196])
        by smtp.gmail.com with ESMTPSA id h193-v6sm21912wmd.25.2018.06.14.13.24.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 13:24:37 -0700 (PDT)
Subject: Re: [GSoC][PATCH v2 2/2] rebase--interactive: rewrite the edit-todo
 functionality in C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>
References: <20180611135714.29378-1-alban.gruin@gmail.com>
 <20180613152211.12580-1-alban.gruin@gmail.com>
 <20180613152211.12580-3-alban.gruin@gmail.com>
 <xmqqlgbh2khq.fsf@gitster-ct.c.googlers.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <e5e50510-8297-6e1b-d446-d717b021c6f0@gmail.com>
Date:   Thu, 14 Jun 2018 22:24:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqlgbh2khq.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 14/06/2018 à 22:14, Junio C Hamano a écrit :
> Alban Gruin <alban.gruin@gmail.com> writes:
> 
>> diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
>> index ded5e291d..d2990b210 100644
>> --- a/builtin/rebase--helper.c
>> +++ b/builtin/rebase--helper.c
>> @@ -12,12 +12,12 @@ static const char * const builtin_rebase_helper_usage[] = {
>>  int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>>  {
>>  	struct replay_opts opts = REPLAY_OPTS_INIT;
>> -	unsigned flags = 0, keep_empty = 0, rebase_merges = 0, write_edit_todo = 0;
>> +	unsigned flags = 0, keep_empty = 0, rebase_merges = 0;
> 
> Sorry, but where does "write_edit_todo = 0" in the preimage come from?
> 

It comes from my conversion of append_todo_help()[0], on which this
series is based.

[0]
https://public-inbox.org/git/20180607103012.22981-1-alban.gruin@gmail.com/

Cheers,
Alban

