Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C0B020248
	for <e@80x24.org>; Mon,  4 Mar 2019 03:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbfCDDWn (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 22:22:43 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38634 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfCDDWn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 22:22:43 -0500
Received: by mail-wm1-f68.google.com with SMTP id a188so3204053wmf.3
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 19:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nMXvDJnlWYw9KeFGEDKWMb5YsHvmQtPJgD51j+rWvF4=;
        b=ADLkWZF5mqU7aFp0ooIb2QFm47qV2XMUCq3wc1FtQehDxCJ5WhxmdlhWzq3lvsLURB
         8WskcQhBAfessAvCJTeXvHexJFA/lLzcMPEP942MgYSi/VNiCX1kEHB5N8n+6HS1G2Ea
         o6MmgCNHvGa2DmDmNeDzqEbjP4XDKJ9erKQ1b9GynlhMcGgsS2DLEb3N8rEtj5d0tTSF
         S+EH1jllLSw9wpw4m6e/ZIkvuctri7H942jX2xja8MlAmkVXEbkuhmAQijjKcPUsSoUF
         F/y1FYF+upC//O4c6XLv3zVW9H4WOXN50Yr/9IC05/qJNAujUpux1KYR9kHOas8B+N3z
         LfmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nMXvDJnlWYw9KeFGEDKWMb5YsHvmQtPJgD51j+rWvF4=;
        b=KR3enoWpq3rrFaJY8cM4OEFv1Sxb9HTND4/62CAVaiDP+Xsxld09QxlQMnz02cB5ZW
         g6D3jlO/2XHByXDYc8NzJNWPQZF2X+dmX4kvURyn7GCNFCQbxfATksMCaHLt+ahqOeMb
         XhdfUby9NKviFjrwWjeOf1UHwBHZuy8oNSEXHRY19ayUknwd+Uysah31D2qe56CJmAJu
         C18Tz0yltkV0novWkCv4hb1N9KM/U/zakaUx38SWBHYOErPDqj9d1iIv7e/FypTTT3sc
         GoTqDcjzdabwMFYJ5p//nYSGfEE83HsXoCLi337My6XHOJ36oUhZVxDOWlwC20Smrigc
         Lbjg==
X-Gm-Message-State: AHQUAua7PXFkyej+TNhnSDiVOJXdqyGJFKbcnkS5azqcUM3dXdcEVmPV
        i6NqQFoOIEGn/4SqfnmCiRc=
X-Google-Smtp-Source: AHgI3IZzU6r6IFmY0XerFDVVijIcKrw/2qkWYGL6fnmtOmaEC9xVP4Xx1d+KEIhSxcj81NmGmx0X8Q==
X-Received: by 2002:a1c:7a1a:: with SMTP id v26mr9410237wmc.129.1551669760932;
        Sun, 03 Mar 2019 19:22:40 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b195sm5326378wmg.36.2019.03.03.19.22.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Mar 2019 19:22:40 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 2/2] tests: introduce --stress-jobs=<N>
References: <pull.155.git.gitgitgadget@gmail.com>
        <pull.155.v2.git.gitgitgadget@gmail.com>
        <074628c22b2df82280b06db604196f25300e8f87.1551624293.git.gitgitgadget@gmail.com>
        <CAPig+cS1URdnRb0RM0HYQhtmXWn5knx6Ee1Y96Gc9dt_9LmRKA@mail.gmail.com>
Date:   Mon, 04 Mar 2019 12:22:39 +0900
In-Reply-To: <CAPig+cS1URdnRb0RM0HYQhtmXWn5knx6Ee1Y96Gc9dt_9LmRKA@mail.gmail.com>
        (Eric Sunshine's message of "Sun, 3 Mar 2019 10:00:32 -0500")
Message-ID: <xmqqfts3z5kw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sun, Mar 3, 2019 at 9:45 AM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> [...]
>> Let's introduce a separate option for that, whose name makes it more
>> obvious what it is about, and let --stress=<N> error out with a helpful
>> suggestion about the two options tha could possibly have been meant.
>>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
>> diff --git a/t/README b/t/README
>> @@ -187,11 +187,10 @@ appropriately before running "make".
>>         variable to "1" or "0", respectively.
>>
>>  --stress::
>> ---stress=<N>::
>
> Shouldn't the "--stress=<N>" line be removed?

Eyes can easily be tricked by the patch format, but the above hunk
does remove that line ;-)  I had the same reaction when I saw your
message for the first time (before seeing the patch itself).

>
>>         Run the test script repeatedly in multiple parallel jobs until
>>         one of them fails.  Useful for reproducing rare failures in
>>         flaky tests.  The number of parallel jobs is, in order of
>> -       precedence: <N>, or the value of the GIT_TEST_STRESS_LOAD
>> +       precedence: the value of the GIT_TEST_STRESS_LOAD
>>         environment variable, or twice the number of available
>>         processors (as shown by the 'getconf' utility), or 8.
