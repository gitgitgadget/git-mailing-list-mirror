Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47F452021E
	for <e@80x24.org>; Thu,  3 Nov 2016 14:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752002AbcKCOej (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Nov 2016 10:34:39 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:36225 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750970AbcKCOei (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2016 10:34:38 -0400
Received: by mail-lf0-f51.google.com with SMTP id t196so40268460lff.3
        for <git@vger.kernel.org>; Thu, 03 Nov 2016 07:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=F+FJmwjHVm3stXnqBobreFUO8B+czRWBPQIIfUMSXgc=;
        b=HYocxCx8aY8BnUsuBxRmO5aYZAOjfIF409oeeCRy/3Oy8Y8mYZL2yU07IqAkbDsW9w
         i0hV2FG/4AJBAXjRWVjS+IZklcgcXIjr2nMyWc1K9hhbyZGVvHXCxJwvsZUXDR7qWMwo
         x0H+3nYMbqOQ+paHbf33DkJoeJ9745oJI16AS0pTMCHJc9dwgp0mc1HsmHknjYR37S5S
         QbyTxb7T7PKmIasVM+ojqOLMWl6rAItTStPxkur+RY11mRpsAnifYwFWneo2MJ9EIij6
         b+6NWozFzuRbIgnAQZbotamqFRpHc24ZzuCIi7o9RQ2HxCfS6gtnZOC3/VKkPkZMGt0b
         DS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=F+FJmwjHVm3stXnqBobreFUO8B+czRWBPQIIfUMSXgc=;
        b=Nf4JBsu8ES8+QXJpW2n5qIPYNjUhbTbY3GgKED1w6YJqqKcv2KtvQ44KlZE+vYqIPd
         /McwsXS8XEw5QiGeSXq4S5q3PPH2I7jG8JcKqcD2N/XQJ2AIaoCRkxBTeB5dIaSl0+ZZ
         wEEzK4E2FiYtEPheqJ6iQ2x8USwF9yh0HwwnbMH5JCNsgZYeO1Lt5Ujj9Q28fbE1RH9R
         gCK0BwQHVQr1sKlywfFV+j+Fdws2Mec2OoGA1kxQ+w1uQLnRxnkwRVgfb8GuM2qsEsJH
         rGvp+ZNfQM6p0f6fPzhc0P756wuhNdl9yjOIA2j2dBlTVGzTj3ge6Sd1MBQr1B2mDClf
         ZSog==
X-Gm-Message-State: ABUngve0On5742eF5v7OvCSj5n56EV+0xXZuq96S6xBxS97Z0X1AXse8DIbOHRG3Bc+9whe/8fC31wTjRTJiSw==
X-Received: by 10.25.159.141 with SMTP id i135mr5667994lfe.123.1478183676632;
 Thu, 03 Nov 2016 07:34:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.163.84 with HTTP; Thu, 3 Nov 2016 07:34:36 -0700 (PDT)
In-Reply-To: <CACsJy8Be-_n_5Aen2-7sod=wkCbXCGxoakf_H-1Cfb4Mg=T9QA@mail.gmail.com>
References: <20161023092648.12086-1-chriscool@tuxfamily.org> <CACsJy8Be-_n_5Aen2-7sod=wkCbXCGxoakf_H-1Cfb4Mg=T9QA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 3 Nov 2016 15:34:36 +0100
Message-ID: <CAP8UFD2sVHS2J6ZXshDqbV_D5Ydht5cH3egYyUN5SZSaBRD9ZQ@mail.gmail.com>
Subject: Re: [PATCH v1 00/19] Add configuration options for split-index
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 25, 2016 at 12:52 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Oct 23, 2016 at 4:26 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> Goal
>> ~~~~
>>
>> We want to make it possible to use the split-index feature
>> automatically by just setting a new "core.splitIndex" configuration
>> variable to true.
>
> Thanks. This definitely should help make split index a lot more
> convenient for day-to-day use. The series looks ok (well, except the
> pruning logic being discussed elsewhere in this thread, but I still
> think it's a good strategy).

Thanks for your review.

>> This can be valuable as split-index can help significantly speed up
>> `git rebase` especially along with the work to libify `git apply`
>> that has been recently merged to master
>> (see https://github.com/git/git/commit/81358dc238372793b1590efa149cc1581d1fbd98).
>
> I remember this. Since the apply libification work has landed, we can
> now think about not writing index out after every apply step, which
> gives the same (or more) speed up without the complication of
> split-index. But if split-index is good enough for you, we can leave
> it for another time.

Yeah, I think they are separate things that can be done.
When people do a lot of small rebases for example, then split-index
will speed up all the index writing, including the index writing at
the end of each rebase.
