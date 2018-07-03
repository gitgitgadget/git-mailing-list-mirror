Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B5B61F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 22:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932128AbeGCW6p (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 18:58:45 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:33421 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753183AbeGCW6n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 18:58:43 -0400
Received: by mail-yb0-f194.google.com with SMTP id e84-v6so1370281ybb.0
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 15:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=YyUpELwPlxiDcaO1vAqVWb45xclcfFjfRCvBo9/qW2U=;
        b=gwB5Wa70BsZwGzD36e1B5JMmxGWOix0uEtrE4+L0SifciNbGYfK56T/CEP18UrJ0ky
         hMe2GG+QiQPff3MaV7rSNcoVdjI3jDM0oXsq5+Y3BZTi4lmE9fLSy7zYwgwrzLXf4CiN
         16LxUMbngYGVsIOhu5+EQ1KfV9cCi7Mk/ccMGhjzhGr7OwyY/eCnkx/qfO/2cYJ7b6Ns
         4r9Of3VUTj5QrQPrFjKEH+4knsDhFeIOIx8YapHy7nLX1NEHKVmgf3PDWw0mH5ihGHAc
         R65zZ4iRp1Sj/8mrQP0DLyJYzdraDi68YTjmReZ82gJ3/v7I8qdFC9qAMCGzA5iUvdVd
         A/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=YyUpELwPlxiDcaO1vAqVWb45xclcfFjfRCvBo9/qW2U=;
        b=YiNS2IBl6PhtGWP3Cz+GoBzuh/LaWU6Y+WKe/OxyYitTp0fsFPPUrzpek6o6xettAd
         KEiNbeAnzDKfmO7TrCp4hyCsSKt3v6X2L2WM3LzwOHxOYd0jIpXH3c0IZDBhTjWEEQKC
         BOA5f/O6qqhwls0SD2UyN4QNk3yc3AK9NHM41C604+L5rwDG7L2wzVz+BP4p18yGImvM
         dbR+L4eT7IVan8ZTFxR78DOps5PStlIcy4sD+Xc/EsL+PXjtHWVvhYhApqu8ZF6srTid
         d5bXemoO7jezCbb53NGfVJhwPbW2nhjf9guzsTApWSuO5wmQAPzzHoH7CAGl0Vcv0x98
         41Tg==
X-Gm-Message-State: APt69E1CQOzcQXbsnRJd1m5737uo14QNjNSPvjk3x3gbMbDKTA0XQNqZ
        +ijnoRibnf0iz6GLF+ZzydQ5nbJN
X-Google-Smtp-Source: ADUXVKLTgfsXb9sZC8x5xXvsqdzJGtpr+dZoPhEITCoizhp7ivh5ASQP6nbmXuP/k2MxbrfGFeGJgQ==
X-Received: by 2002:a25:ab2f:: with SMTP id u44-v6mr16908653ybi.41.1530658722561;
        Tue, 03 Jul 2018 15:58:42 -0700 (PDT)
Received: from [10.20.131.237] ([70.63.112.210])
        by smtp.gmail.com with ESMTPSA id q8-v6sm844434ywb.6.2018.07.03.15.58.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 15:58:42 -0700 (PDT)
Subject: Re: [PATCH 1/3] ls-tree: make <tree-ish> optional
To:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <20180703035802.24060-1-jyn514@gmail.com>
 <CABPp-BFu+m-7Fyf4kj8hUO33vhAxKuAu5JnyL5Tzc7c6Kq+Hjg@mail.gmail.com>
 <xmqqbmbonff3.fsf@gitster-ct.c.googlers.com>
 <CABPp-BGJjJGhOEBiJJ5J5rnMXfLndKgwU-4_JVqumBB81DUHpQ@mail.gmail.com>
From:   Joshua Nelson <jyn514@gmail.com>
Message-ID: <808212de-91c1-eabf-cb69-e9899834f075@gmail.com>
Date:   Tue, 3 Jul 2018 18:58:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BGJjJGhOEBiJJ5J5rnMXfLndKgwU-4_JVqumBB81DUHpQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Agreed, ls-tree when called with no arguments was the main use case I
wrote this for; the rest was mostly because other commands allow greater
ambiguity and I wanted to make the syntax consistent.

I don't mind doing this for rev-list as well if that's a useful feature.


On 07/03/2018 06:55 PM, Elijah Newren wrote:
> On Tue, Jul 3, 2018 at 3:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Elijah Newren <newren@gmail.com> writes:
>>
>>> On Mon, Jul 2, 2018 at 8:58 PM, Joshua Nelson <jyn514@gmail.com> wrote:
>>>> use syntax similar to `git-checkout` to make <tree-ish> optional for
>>>> `ls-tree`. if <tree-ish> is omitted, default to HEAD. infer arguments as
>>>> follows:
>>>>
>>>> 1. if args start with --
>>>>         assume <tree-ish> to be HEAD
>>>> 2. if exactly one arg precedes --, treat the argument as <tree-ish>
>>>> 3. if more than one arg precedes --, exit with an error
>>>> 4. if -- is not in args
>>>>         a) if args[0] is a valid <tree-ish> object, treat is as such
>>>>         b) else, assume <tree-ish> to be HEAD
>>>>
>>>> in all cases, every argument besides <tree-ish> is treated as a <path>
>>> Cool, this is something I've wanted a few times.
>> Hmph, is it, and why?
> Default <tree-ish> of HEAD when nothing is specified is certainly
> something I wanted.  To be honest, I wanted it for rev-list too.
> Despite dozens if not hundreds of times of typing 'git ls-tree -r' or
> 'git rev-list' expecting to see the results for HEAD (just as git log
> does), and getting git's error message reminding me that I need to
> specify HEAD, I can't seem to get it through my head to remember that
> I need to specify it.
>
>> I'd prefer *not* to have such a DWIM in a command like ls-tree, aka
>> plumbing commands, where predictability is worth 1000 times more
>> than ease of typing.
> Fair enough.  However, what if no <tree-ish> or <path> are specified,
> though -- would you be okay with the HEAD being assumed instead of
> erroring out in that case?
