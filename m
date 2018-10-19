Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79FEB1F453
	for <e@80x24.org>; Fri, 19 Oct 2018 17:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbeJTBSZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 21:18:25 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33040 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbeJTBSY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 21:18:24 -0400
Received: by mail-qt1-f196.google.com with SMTP id q40-v6so39145574qte.0
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 10:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hrmomQYlT9sLv95O3ytuiABp6JXieNDhcivN46RwhFA=;
        b=IFAJFez4GiCl3pqI0DX7e30AsFOPOHM0RZM7GofF7rRAmH9tKsbGQ6MgrVfgEGBLMc
         E+KWZh8htQ8r0ECAbXpKhmAR2NisMyV4KhjScL5e0WswpBLU0i4e0rQEtEDZXGRwTY1s
         dtEz/oPakWygapS8XGgPS8n797gSi07gt4Pw2G0qXuzMR644pfBwHMNu42b138bVEuNe
         zrt9nANqocue7WLW62RJvWu+Ab6KwBsAvUDlw+PKWiEs7z1b8MqofTLdqZTQt6LKLQjA
         8Ld/SrPoDRfEfJdDgw8mjKtMlcWtbYIFDXI6y6jpU2chzLWi+UVYKUOYeJNlekEX7uVy
         BnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hrmomQYlT9sLv95O3ytuiABp6JXieNDhcivN46RwhFA=;
        b=HTzdtuq4HhUzsBjl46D/0DzhE0cre3WtdMr/yPHUgiDqnB7FnuUSa4Hatlokdc7vGr
         1xWYSsIM/jk2BlmgfAOL1ygHf2vtAKzzE7OAUqdhTlgg0aZnBY8CM6R4FDigiExESEls
         lFBewAxguuJd4HrW8PfrWsDY2GJB0GxL/A3SfbCdm7koOsDoeBceqGYr8EM2vxEJYRC9
         y8r/rH0osmA4o5i94yTtmoV76wm1npSodx7i/CdRy+Q3lZDsEN1SbhyXSjCDzs9nikQa
         pHxVS3tmST66r6BX2LUiQizSdzHP2C0yfn0IZFX5v4t1aCfYwNMvR8qNhfkliJ11RQJB
         N5FA==
X-Gm-Message-State: ABuFfoj47Ioi7S6r8qMZAQ44GAhTb7yXq3rTyFr5liPvM/aSyqJtpZYh
        CXUKPRsiB6mJVQUsZl56b0Q=
X-Google-Smtp-Source: ACcGV62VnG1qw+u92zZ5WM4YtkE/ZJQOUFKCPF1Ew/+xhCQauKb7dop5RcDwRNOGWG8d8vqdZmvr2Q==
X-Received: by 2002:a0c:b584:: with SMTP id g4-v6mr34952681qve.88.1539969085991;
        Fri, 19 Oct 2018 10:11:25 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id a21-v6sm1689946qte.41.2018.10.19.10.11.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 10:11:25 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] reset: add new reset.quiet config setting
To:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
References: <20181017164021.15204-1-peartben@gmail.com>
 <20181019161228.17196-1-peartben@gmail.com>
 <20181019161228.17196-3-peartben@gmail.com>
 <CAPig+cSL9=mmvdq9J9VXF67=010E1eZBjrYYaYQDN1z1OEf0CA@mail.gmail.com>
 <20181019164631.GB24740@sigill.intra.peff.net>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <5594e9d0-cfe2-f29f-a788-bebbd8d2b151@gmail.com>
Date:   Fri, 19 Oct 2018 13:11:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181019164631.GB24740@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/19/2018 12:46 PM, Jeff King wrote:
> On Fri, Oct 19, 2018 at 12:36:44PM -0400, Eric Sunshine wrote:
> 
>> On Fri, Oct 19, 2018 at 12:12 PM Ben Peart <peartben@gmail.com> wrote:
>>> Add a reset.quiet config setting that sets the default value of the --quiet
>>> flag when running the reset command.  This enables users to change the
>>> default behavior to take advantage of the performance advantages of
>>> avoiding the scan for unstaged changes after reset.  Defaults to false.
>>>
>>> Signed-off-by: Ben Peart <benpeart@microsoft.com>
>>> ---
>>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>>> @@ -2728,6 +2728,9 @@ rerere.enabled::
>>> +reset.quiet::
>>> +       When set to true, 'git reset' will default to the '--quiet' option.
>>
>> How does the user reverse this for a particular git-reset invocation?
>> There is no --no-quiet or --verbose option.
>>
>> Perhaps you want to use OPT__VERBOSITY() instead of OPT__QUIET() in
>> builtin/reset.c and document that --verbose overrides --quiet and
>> reset.quiet (or something like that).
> 
> I think OPT__QUIET() provides --no-quiet, since it's really an
> OPT_COUNTUP() under the hood. Saying "--no-quiet" should reset it back
> to 0.
> 

Thanks Peff.  That is correct as confirmed by:


C:\Repos\VSO\src>git reset --no-quiet
Unstaged changes after reset:
M       init.ps1

It took 6.74 seconds to enumerate unstaged changes after reset.  You can
use '--quiet' to avoid this.  Set the config setting reset.quiet to true
to make this the default.


> -Peff
> 
