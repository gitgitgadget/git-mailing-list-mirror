Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01E6820705
	for <e@80x24.org>; Tue,  6 Sep 2016 01:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752072AbcIFBJh (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 21:09:37 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33561 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751884AbcIFBJg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 21:09:36 -0400
Received: by mail-yw0-f193.google.com with SMTP id g192so4139943ywh.0
        for <git@vger.kernel.org>; Mon, 05 Sep 2016 18:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pHbyI8ci0Mv+N1qLsod4TcM/Bx2sY1WITQx3wAaPRI8=;
        b=MJCRVr09nIudqsqSQHUSmjviHeVyUmAFYHYSqRBSw3dm8NP5Jl1IRSkGMIt1i+L3oW
         fK54JbiOBrAz7d7pofcjG3ayPSqurrqy6+PACK2daU4LuGYEFfKCw3GfSxYBoKSNay+k
         qUs33hTVO97jBmi4EKHnvzb3MrSSLgwEnVzLBTDUfjhXESg3uBUghffYjcPxrTx7hBMV
         w+jkYKI/oIZbVsfOxov387EOpkgijJG/4torlB/6aB1IqsgVHuZkfQ8ogLaYDZY2y3tZ
         TUTT8Tnu+hLPpUo/M40kiR13sLVd3pQIEFvvLoZJJCrMgB+jzWBoHrBjRGAFnFB/PSYp
         xzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pHbyI8ci0Mv+N1qLsod4TcM/Bx2sY1WITQx3wAaPRI8=;
        b=lAe+gC77L/ffQeawJysuJzQbIaKn9FBa08oWptvb1ht1o4oko4mQfGoyHzAEZWBlit
         ij84yUUjrBpWQSMyH4lFRs9ygZwuwmEnO4xbrWdKLc//dK7DA9pPFIz5wJeqfblPTz4T
         tm8dxlf/fYtt4Ulle1IDLqo5FSoeM+lD29oEu0ssHGTqVKTh0zfI+LwyV0nqZ93IZ0HL
         UQz08BaaWWm2GBOurSysEHtYUloxy4Q+14rChDkhUDfrZz+ddkMo47P7pgykOTNqoJfL
         f5KbW8Xkl3PAzgjwU2MmqMQ51Kz81F2XtYlKOHBS2PrOKgP32LN+JTT/6qfygdDNSLZ7
         LKFg==
X-Gm-Message-State: AE9vXwM6uqutopQtHx2HnZp5lihrNcH1nhlLtotrJ9PiAoF6CxzmaqAa/S2ppHe0hTAXmo3c69rEWNpYI6Ctqg==
X-Received: by 10.13.249.135 with SMTP id j129mr32094924ywf.267.1473124175588;
 Mon, 05 Sep 2016 18:09:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Mon, 5 Sep 2016 18:09:15 -0700 (PDT)
In-Reply-To: <xmqq1t0yqinr.fsf@gitster.mtv.corp.google.com>
References: <20160904191435.14144-1-stefanbeller@gmail.com> <xmqq1t0yqinr.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 5 Sep 2016 18:09:15 -0700
Message-ID: <CA+P7+xqx4PHHoKT_PK5s5eOtZMG9QJTSHED_=+BHZ=U330AQtw@mail.gmail.com>
Subject: Re: [WIP PATCH v2] diff.c: emit moved lines with a different color
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 5, 2016 at 11:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <stefanbeller@gmail.com> writes:
>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index 0bcb679..f4f51c2 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -980,8 +980,9 @@ color.diff.<slot>::
>>       of `context` (context text - `plain` is a historical synonym),
>>       `meta` (metainformation), `frag`
>>       (hunk header), 'func' (function in hunk header), `old` (removed lines),
>> -     `new` (added lines), `commit` (commit headers), or `whitespace`
>> -     (highlighting whitespace errors).
>> +     `new` (added lines), `commit` (commit headers), `whitespace`
>> +     (highlighting whitespace errors), `moved-old` (removed lines that
>> +     reappear), `moved-new` (added lines that were removed elsewhere).
>
> Could we have a config to disable this rather costly new feature,
> too?

That seems entirely reasonable, though we *do* have a configuration
for disabling color altogether.. is there any numbers on how much more
this costs to compute?

>> +static struct hashmap *duplicates_added;
>> +static struct hashmap *duplicates_removed;
>> +static int hash_previous_line_added;
>> +static int hash_previous_line_removed;
>
> I think these should be added as new fields to diff_options
> structure.

Agreed, those seem like good choices for diff_options.

Thanks,
Jake
