Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA2241F404
	for <e@80x24.org>; Tue, 10 Apr 2018 22:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755353AbeDJWrH (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 18:47:07 -0400
Received: from mail-yw0-f169.google.com ([209.85.161.169]:38119 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754472AbeDJWrF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 18:47:05 -0400
Received: by mail-yw0-f169.google.com with SMTP id x20so4583073ywg.5
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 15:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LeDth4Y4186Z9liRV3j+IwQ8TwtzUbAN1gn5uwj4hA0=;
        b=BACqpNmrY+1OeN0OPbcIXtfpxfBlieDwBgNXL4zgCvr7N3UwUwTrRjHLhMkI5IsS6Q
         /xdAplq+qZhUaf8pPNxKbNq1X52I4K9PB8HajT3HW1CeU0N/MLKCCAwqqkOlMw2skVm8
         foTZEj3vcsKHkQ1/IxvzLLzLFGKLznbBaT1t8PYdbY/L0yqkJYfntYw5/nh4e1ZT5/Jj
         SSYD54TVrWyoqt0gUL2MjRj5I+bI6oqDwsbJBHEI286iLxphwxjqyexZlCrCmAIW/Vyq
         BzPSImNwmr101Zglc71aVr+afsz5RD2T6Drqq+Ue3FGE9iMElEWyYS5iEeBsbLWEEusV
         +lUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LeDth4Y4186Z9liRV3j+IwQ8TwtzUbAN1gn5uwj4hA0=;
        b=PE9YaPVMDza8luzk+2ExOVz1JYPOVKj9IPpNySaiAYjqd0WbNNBnUHUiLMLJpTcsep
         x1KdH/LRzMhO8nnRkJ7zgQNWgyTQwv9tPZBYEJRo1J5vI1hY1C7lQcuVY0KFZTMDGVOc
         E6kj3hSNi+s3oXfe7sX5KJ2l52x7g/q/rV6yoT5cQJdaoDuduxvRHv+U29KVNKzIQ7LS
         C3MxU9DpjfXGeA9bqp3e5LzvAuUAelZlW5JD5Jsne0W482HJsdo5QaQpumhHV86uacUC
         5ld/S17glT7QxO5bhgOpLNpW+VZugz2YaudtYJsSbtYDbVhEhUWDwHwO7vlwukU3g/9W
         N4DQ==
X-Gm-Message-State: ALQs6tD7RL4gyKUHH4aT/HSCVpeHf1MDMVLBc/jMdin9A0oRZHQDgOu+
        Gz12C73YoL3S0sCZSBuXWuN7Q627+16UWQIB9v66xw==
X-Google-Smtp-Source: AIpwx4+rFeqolDdagaHGs0AiRY6Wc5iPODjw+P85in1K5IIlz9XuZvZ8IZdpUMDA6jB9IR5Xx1xu2H2BPdXsBNwToEo=
X-Received: by 10.129.86.5 with SMTP id k5mr1254272ywb.345.1523400424122; Tue,
 10 Apr 2018 15:47:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Tue, 10 Apr 2018 15:47:03
 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1804110038230.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <xmqqbmer4vfh.fsf@gitster-ct.c.googlers.com> <20180410212621.259409-1-sbeller@google.com>
 <nycvar.QRO.7.76.6.1804110038230.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 10 Apr 2018 15:47:03 -0700
Message-ID: <CAGZ79kakGDwK_NgF0Y77mjj0mskgqed6ffu0UYdSnVquC-ef9w@mail.gmail.com>
Subject: Re: [PATCH 0/6] Rename files to use dashes instead of underscores
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On Tue, Apr 10, 2018 at 3:39 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Stefan,
>
> On Tue, 10 Apr 2018, Stefan Beller wrote:
>
>> This is the followup for
>> https://public-inbox.org/git/xmqqbmer4vfh.fsf@gitster-ct.c.googlers.com/
>>
>> We have no files left with underscores in their names.
>
> Yaaay!
>
>> Stefan Beller (6):
>>   write_or_die.c: rename to use dashes in file name
>>   unicode_width.h: rename to use dash in file name
>>   exec_cmd: rename to use dash in file name
>>   sha1_name.c: rename to use dash in file name
>>   sha1_file.c: rename to use dash in file name
>>   replace_object.c: rename to use dash in file name
>
> These are all obviously correct (I did not apply the series and used `git
> grep` to verify that nothing underscored is left there, but I trust you to
> have done that already).

Yes and I did not tell the full story.

There is still 'check_bindir' as compile output, such that I ignored it.

And there was sha1dc_git.{h, c} which I also ignored as it is unclear
to me how our relationship with the DC library is.
I think that could also be converted as it seems to be a shallow wrapper
around that lib.
