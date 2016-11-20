Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D1E61FE4E
	for <e@80x24.org>; Sun, 20 Nov 2016 07:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751952AbcKTHIr (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Nov 2016 02:08:47 -0500
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36225 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750871AbcKTHIr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2016 02:08:47 -0500
Received: by mail-yw0-f196.google.com with SMTP id r204so24161678ywb.3
        for <git@vger.kernel.org>; Sat, 19 Nov 2016 23:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fp6ZVQIrkaJQhQh5yZl5EAR52YbVtLgGjO6XvH3Q4jk=;
        b=BV8VYW2iR8wVJxATm6ot4wHRvjDYwLUA4YngFLgmzWobcGotgsRxn8IvxvyJaE5OfQ
         td7ZVOyc05BgZ95UWIWwbDEz9h7D19jm9bbINxDefCdPbSFsPr7zBxjyW0CWH+mfWvZq
         rxRnAvR8YuKjfTh9mzVA75KGZuJxihfwTuFeVM6uAiQde/wLWIRWImSo5us7WIYW1ivy
         VklqWf2UqEGdMhzxBevFHPLExyAcsZY31KGylairurQDuoDbH3L5xW64twRjTbQmDSb4
         aO+1/RBMKDCZhtgN7r5CDIkoAIH8KLpsZmH8revv9CTebjAFltxfyj8O/qjz5299byLj
         dmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fp6ZVQIrkaJQhQh5yZl5EAR52YbVtLgGjO6XvH3Q4jk=;
        b=kOEWBtGdg1R8VVMNHk9WNv3j0nzAv2akE7QytfJxkuEI2/unsRU5x4I9jvPWFau5ts
         6SwSfrSwuMnJvCnRnmIpZc18C5WU+b6MXhiLs+2wEAsvpvhPDCM6YZ9SHQQqI0fmmvid
         F5JhFROXzKVu4JEFquZSd8xE0XUh+nADMtsd4NiK0Mw8aE/CCy0+7cGDJLM4ZR9lCsdY
         3IYQbCiVBJhQT/a4byFXtHZ3ZugPza+X2rHKyVHVB8yEDPZ6gowLfUq7Thi+VHp5nLD2
         r57t6R8WLoMED43uJs/EZwQsxohCJpZhy4GxrQubInJfebisRTlkg129VqjNVWkfy8SN
         R1hw==
X-Gm-Message-State: AKaTC00qDClqfASnJhgrwA49JFqLpI1kasHmbX6S7DLoBSt+ipO70ZJKgNqIeD4Mm5E4JqS11iyABmks5K5mhQ==
X-Received: by 10.129.85.11 with SMTP id j11mr7302350ywb.123.1479625726094;
 Sat, 19 Nov 2016 23:08:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.207.69 with HTTP; Sat, 19 Nov 2016 23:08:15 -0800 (PST)
In-Reply-To: <xmqqd1hsl5zm.fsf@gitster.mtv.corp.google.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <xmqqbmxgtqxv.fsf@gitster.mtv.corp.google.com>
 <CAOLa=ZQtmQWpFMPa-SD29N7hASHAPp8SGGJsLu+AW_Kv-1LqwA@mail.gmail.com> <xmqqd1hsl5zm.fsf@gitster.mtv.corp.google.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Sun, 20 Nov 2016 12:38:15 +0530
Message-ID: <CAOLa=ZSa7+N04wevEjHSnToub-12biJC5eeMpAFCcCwSsxHG_g@mail.gmail.com>
Subject: Re: [PATCH v7 00/17] port branch.c to use ref-filter's printing options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 19, 2016 at 5:01 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Thanks, will add it in.
>
> OK, here is a reroll of what I sent earlier in
>
>     http://public-inbox.org/git/<xmqq7f84tqa7.fsf_-_@gitster.mtv.corp.google.com>
>
> but rebased so that it can happen as a preparatory bugfix before
> your series.
>
> The bug dates back to the very original implementation of %(HEAD) in
> 7a48b83219 ("for-each-ref: introduce %(HEAD) asterisk marker",
> 2013-11-18) and was moved to the current location in the v2.6 days
> at c95b758587 ("ref-filter: move code from 'for-each-ref'",
> 2015-06-14).
>

I'll rebase on this patch. Thanks for your efforts.

I assume you'll be merging it in before my series, so I wont be making
it a part of my series.

-- 
Regards,
Karthik Nayak
