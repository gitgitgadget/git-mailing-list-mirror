Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F309D1FCA5
	for <e@80x24.org>; Wed, 28 Dec 2016 09:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751219AbcL1JlU (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Dec 2016 04:41:20 -0500
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35236 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751145AbcL1JlT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2016 04:41:19 -0500
Received: by mail-yw0-f193.google.com with SMTP id b66so24198583ywh.2
        for <git@vger.kernel.org>; Wed, 28 Dec 2016 01:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7nxaXi57mpKZHu9ZDf/KqKAdGcViu920fQzp3YtwS/M=;
        b=rAV5T5II5zPu/Sw9kgCv+1WRACydfUIM7htyZ5o4oCayKmRwLG6ZhvA6t64ks6BRPr
         znUuX+QxMeWy+Rx57ikUTQ2s4kZM+57ioYUijBsZoyFrB4IwlgpS5/H2mCxKtfnEYmEP
         RYtp14cMRSjPa48yS+8HbtFtJM2oBxPcegLvpVuYRrAu4asnDu/W/P7ea35wavNRabrB
         5PUwyuhHk1OlHm7L18w/uUg46NbNs2LFEesvXtiv4wVxL1KTQXpCrf+ULKYa1Px/OYug
         GgkanzmiDUgQN75JuzzU3pMjmQjKzonVJ5G9dOB3dEZAuWI4u68N764Im864lTy8HbrZ
         vxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7nxaXi57mpKZHu9ZDf/KqKAdGcViu920fQzp3YtwS/M=;
        b=I6dJdK633c8zR/I/BaJX6VufmuYxCwsYpFk837owNKg7HEPYAjDh5kCzGZbpb3+3rq
         BcA4vqcjQhVlS3RnXb3OInJHUB1UDOPA1EvKVt4Akd13EWs7KBGrUNAqTF5pR7NVTS0B
         /ixZVO3vvfu3+wz5hbnBpPT9L22rfKFDv7pIvRNuGzIPV7SGWowdCbMjPNSvpsszmT/C
         UuFwlVhKskmzzopIutiP/WBtUePu1lV1jTtgRgI8hQN894GU8CHnz4Q5D6R1klAmL6nX
         j4ZgUWBssiRYe3jt37rYGinWiyg+bZB4fAGPME2MhDVu4r7frmIl0MIxpODkoL0rSGbl
         agUw==
X-Gm-Message-State: AIkVDXKfECtu6hTmML8SadOmoK7zk5M1s9I/37i2LO8eS99q4acmxaSv36KgH3VWboAPvxcmaBObCe8g+4OkGg==
X-Received: by 10.13.229.70 with SMTP id o67mr28207244ywe.131.1482918034848;
 Wed, 28 Dec 2016 01:40:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.129.19.214 with HTTP; Wed, 28 Dec 2016 01:40:04 -0800 (PST)
In-Reply-To: <xmqqinq56phu.fsf@gitster.mtv.corp.google.com>
References: <20161227162357.28212-1-Karthik.188@gmail.com> <20161227162357.28212-20-Karthik.188@gmail.com>
 <xmqqinq56phu.fsf@gitster.mtv.corp.google.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Wed, 28 Dec 2016 15:10:04 +0530
Message-ID: <CAOLa=ZTPMbhzv_9mLv63UvPu__JqwQrpd2d8ogXuz5wNKb70Dw@mail.gmail.com>
Subject: Re: [PATCH v9 19/20] branch: use ref-filter printing APIs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 28, 2016 at 2:47 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>  static char branch_colors[][COLOR_MAXLEN] = {
>> -     GIT_COLOR_RESET,
>> -     GIT_COLOR_NORMAL,       /* PLAIN */
>> -     GIT_COLOR_RED,          /* REMOTE */
>> -     GIT_COLOR_NORMAL,       /* LOCAL */
>> -     GIT_COLOR_GREEN,        /* CURRENT */
>> -     GIT_COLOR_BLUE,         /* UPSTREAM */
>> +     "%(color:reset)",
>> +     "%(color:reset)",       /* PLAIN */
>> +     "%(color:red)",         /* REMOTE */
>> +     "%(color:reset)",       /* LOCAL */
>> +     "%(color:green)",       /* CURRENT */
>> +     "%(color:blue)",        /* UPSTREAM */
>>  };
>
> The contents of this table is no longer tied to COLOR_MAXLEN.  The
> above entries used by default happen to be shorter, but it is
> misleading.
>
>         static const char *branch_colors[] = {
>         "%(color:reset)",
>         ...
>         };
>
> perhaps?
>
> More importantly, does this re-definition of the branch_colors[]
> work with custom colors filled in git_branch_config() by calling
> e.g. color_parse("red", branch_colors[BRANCH_COLOR_REMOTE]), where
> "red" and "remote" come from an existing configuration file?
>
>         [color "branch"]
>                 remote = red
>
> It obviously would not work if you changed the type of branch_colors[]
> because the color_parse() wants the caller to have allocated space
> of COLOR_MAXLEN.
>
> But if filling these ANSI escape sequence into the format works OK,
> then doesn't it tell us that we do not need to have this change to
> use "%(color:reset)" etc. as the new default values?

Good point, this would overwrite the existing configuration based setup
existing in builtin/branch.c.

I think it'd make sense to use the existing branch_colors[] definition without
any changes. That's mean that instead of using %(color:<color>). We hard
code the colors by calling  branch_get_color(). This is ok with me since,
users who which to have their own formats will anyways use --format option.

-- 
Regards,
Karthik Nayak
