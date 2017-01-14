Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FB062079E
	for <e@80x24.org>; Sat, 14 Jan 2017 10:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751952AbdANKC4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jan 2017 05:02:56 -0500
Received: from mail-yb0-f195.google.com ([209.85.213.195]:33489 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751948AbdANKCz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2017 05:02:55 -0500
Received: by mail-yb0-f195.google.com with SMTP id 123so2615546ybe.0
        for <git@vger.kernel.org>; Sat, 14 Jan 2017 02:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=r8Cc5tdiOfGeSy6bY1vJdrnZS6DRjJRKr68YZaMK4YI=;
        b=p8haz6RzcEWtvLkS2wz0Cj9FbVF4JtzkcbDFAQM+SbFEqmrkIcUrF5h2EURlSEHDgW
         NF3JKqgGfSmPh1jfXN+XFxXfJf7+AJiJ5ac1FeWXxdVLVe3hSfcMCCnZwqxdR0Z2Rkxm
         4PLQQrojSx9P70EXbdwAg5nkY5Nn2jEz6+t/qbqDtpvlvbW09khQaaPAXSLIu9QElcBG
         qN3fPhRXC//HEuzYRN4KU9vNmfEm76IwH1LOc9eX6y8x6ovc6u0t2MZSLFwFiTCtnW8m
         VkBXiXSXdwZyxGgRNaAezfvPKVkJgAMkyQ3pkJa+83Ll15REG4Rbf8HWjfGenVskivUD
         63Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=r8Cc5tdiOfGeSy6bY1vJdrnZS6DRjJRKr68YZaMK4YI=;
        b=ajdVoA8HE1i85PMBTz8+UIVI5s1lBJs/VJnKVOZJLHcXRku74tx1a4g0LlxD6VuCuT
         cXlzzIqcKCcumCythHdlIAryP8HhqbZkyBTdVbpln8CqTZ9QNVZUZC3OZMguCoJIoUbr
         mQhfQId8OSy+IfmSq1v9Px/Mblk2E8FrbVZqD7gI4n+9uF0/rGF/WPoNIXCM2WFZu9Go
         j0PfrbiR/uBstfddKs1rHWuflVW5aUZAP3TG6/8m3ARlMTLF6VYrrFaLV+9wPYr7+Kbs
         VFnNvBJ9M/pHFGW18mynivZgxZ6rHtFaUluUyF7LvxULRR9EI9nbAbfRDJ3OCr8RSrxC
         0R2Q==
X-Gm-Message-State: AIkVDXK4trSj7ZDYOhRIQA53Jkmf2obGsokUWMKnNlecvdJelRRtoIVr1dEZVI/AtXF6odyVFwnxY0nzjPq6Qw==
X-Received: by 10.37.203.151 with SMTP id b145mr15854405ybg.110.1484388174983;
 Sat, 14 Jan 2017 02:02:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.129.19.214 with HTTP; Sat, 14 Jan 2017 02:02:24 -0800 (PST)
In-Reply-To: <xmqqfukqr6ep.fsf@gitster.mtv.corp.google.com>
References: <20170110084953.15890-1-Karthik.188@gmail.com> <20170110084953.15890-4-Karthik.188@gmail.com>
 <xmqqfukqr6ep.fsf@gitster.mtv.corp.google.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Sat, 14 Jan 2017 15:32:24 +0530
Message-ID: <CAOLa=ZRd3eNA_YO7zeALuxWO3F4_=OuH3ZPr-30Jf7m07c4jcw@mail.gmail.com>
Subject: Re: [PATCH v10 03/20] ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Wed, Jan 11, 2017 at 2:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +                     if_then_else->condition_satisfied = 1;
>> +     } else  if (if_then_else->cmp_status == COMPARE_UNEQUAL) {
>
> Please, no space before tabs (locally fixed--no need to resend).

Thanks.

-- 
Regards,
Karthik Nayak
