Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F07F1F453
	for <e@80x24.org>; Wed,  3 Oct 2018 13:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbeJCUbZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 16:31:25 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]:44263 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbeJCUbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 16:31:25 -0400
Received: by mail-qt1-f179.google.com with SMTP id c56-v6so5893308qtd.11
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 06:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2P1Ac2MooRGg4IMS6MFQSpgWoH88jD7QKfTvFbNmQwo=;
        b=C9kPrZVOCv1qUj43aQ+/xPErO2aJU/jcjkSPHFVUDPjXj/+PS1b/fU6Zo4b2WLKVKc
         MnILVzQdl6hBnaGDI7QJ+yqnfPTsH3leTYXL/oyXoxH41YWKzh7MO2qqdD8i2Gi4mn/8
         tesN4pS5/4MSgG3fLWIkyYb6wBHNL+lTAhyI7hSPimpwdJSdtbDMwIg5zJG0J0tPALbw
         NRb/DRzDYg/YlbkLXymxl3LmErZrlcDcJrNbft5EE/63U+7uJ/Wq1niuD9yO0P9MqY/F
         2Tvcq0cufVYMfaUKnQg3z5I9F77+gHmC7Qced0siVhXa2r3zemBTaoHSeqV2jEnUUeYI
         e48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2P1Ac2MooRGg4IMS6MFQSpgWoH88jD7QKfTvFbNmQwo=;
        b=GnLzQvgNBWJZsLIzFEWy+alPNo1+O3douNFf5KNBkYwFA2raRxMBP/t+FZVGPv0jvs
         LPcLyiH0nMUfplTHWqQ1ghr2jr24Caq1e1Cwfb54jvalBZGp7YXZ0bn5gB3sG4c+b8HZ
         rQttjeDxK9KbzoG0Jcar0+KwGxQdC57UCM0NB2B8OUeIrqFkjv62G9oapeKZH3f5kvMI
         /c0y0s35ekNhNOZ7+mzkAGGwwECmfdJXYEq0WMNvh6fRkqo7OmO7UVDVMvCL65SRSIPs
         CVLr7c1fb7Jb5IFQAkESejulusaAz3MJ8o48RzJ0XG8VNPxZVXfqtgBZjxHSAh4uGz7U
         LUJQ==
X-Gm-Message-State: ABuFfoga6622HTzhzbQQSpZppjp0z1FLZkhZ0ujp9v62OsZnrwPKW9ih
        UyWnh/ucAn53USSPDqeMHlU=
X-Google-Smtp-Source: ACcGV61PIzPoUhGhke8pB9IkuN4PsBAJo/02juQA2O7Z2SJL6kwOM+7/E+YGGg3BM+UKiNihY6R0Cg==
X-Received: by 2002:a0c:eb10:: with SMTP id j16-v6mr1243010qvp.95.1538574176417;
        Wed, 03 Oct 2018 06:42:56 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:81f3:8f89:2be9:a31b? ([2001:4898:8010:0:6b29:8f89:2be9:a31b])
        by smtp.gmail.com with ESMTPSA id c85-v6sm551306qke.89.2018.10.03.06.42.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 06:42:55 -0700 (PDT)
Subject: Re: We should add a "git gc --auto" after "git clone" due to commit
 graph
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= =?UTF-8?Q?_Duy?= 
        <pclouds@gmail.com>
References: <87tvm3go42.fsf@evledraar.gmail.com>
 <20181003133650.GN23446@localhost>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <836a8d28-0879-73a5-7e0b-75f438ff6785@gmail.com>
Date:   Wed, 3 Oct 2018 09:42:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181003133650.GN23446@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/3/2018 9:36 AM, SZEDER Gábor wrote:
> On Wed, Oct 03, 2018 at 03:23:57PM +0200, Ævar Arnfjörð Bjarmason wrote:
>> Don't have time to patch this now, but thought I'd send a note / RFC
>> about this.
>>
>> Now that we have the commit graph it's nice to be able to set
>> e.g. core.commitGraph=true & gc.writeCommitGraph=true in ~/.gitconfig or
>> /etc/gitconfig to apply them to all repos.
>>
>> But when I clone e.g. linux.git stuff like 'tag --contains' will be slow
>> until whenever my first "gc" kicks in, which may be quite some time if
>> I'm just using it passively.
>>
>> So we should make "git gc --auto" be run on clone,
> There is no garbage after 'git clone'...

And since there is no garbage, the gc will not write the commit-graph.

>
>> and change the
>> need_to_gc() / cmd_gc() behavior so that we detect that the
>> gc.writeCommitGraph=true setting is on, but we have no commit graph, and
>> then just generate that without doing a full repack.
> Or just teach 'git clone' to run 'git commit-graph write ...'

I plan to add a 'fetch.writeCommitGraph' config setting. I was waiting 
until the file is incremental (on my to-do list soon), so the write is 
fast when only adding a few commits at a time. This would cover the 
clone case, too.

Thanks,
-Stolee
