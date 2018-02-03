Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16E561F404
	for <e@80x24.org>; Sat,  3 Feb 2018 01:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751803AbeBCBng (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 20:43:36 -0500
Received: from mail-ua0-f170.google.com ([209.85.217.170]:34070 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750805AbeBCBne (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 20:43:34 -0500
Received: by mail-ua0-f170.google.com with SMTP id g5so3610113uac.1
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 17:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=t/Qq2x5bRoGrq68Z3LMOpDF21xuJYAEXRmLzMEYF74M=;
        b=qf2f4XYzDD/kGHVBOTfBY2yTX2e/glLALgusVuK2W/F+QZ1Sy79CUl7cleGeK5p8qi
         XLmQ+Gsg/T4ffdZ6KhjrF39ulfGhPcVPZgFtTpoMrQfhGvWd+sg/6GbS8mb+wOtIfyPv
         zHYu3VSqz9h5cpbkmTu9XtEbS8LAgglNHPNoNBQbF2sC6camplulH7YLurQZY0Ec6n2z
         PnobBGAkXNkIu1Zhg60H5gaCEaQs6NGrhwiHGX5JQ1SagGac4pFGwuTZnL/J/495GxM6
         zEiR7/IC3zwbohnuswA61pwF06hIn+xHQnf+8Wh+PTDGzWVC0Ty9jwEgfIiFbynciK7u
         iUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=t/Qq2x5bRoGrq68Z3LMOpDF21xuJYAEXRmLzMEYF74M=;
        b=D23o1iJ2EwPdi1wL67cbtyvI7MuLwLmJaeWf7L9g6NFD571nXxMgrjU+LyUnE3fE7M
         OTgpU3UWZzw5un76n5LD8w5emLASlA9dcHfCt6q0cetb5GQ65tIw0xd5PHy0Gyg4+HAX
         TjfcaTpUf0GI7fbjkwiOtT4SoFW6WUF8KhBRqZ5qkFu+8NdvqrIheSrAIx81E3LtfRL/
         8mRRHvooc9J3zmlCBmg6HKi6UgnT3BYIet49lusma6y8ECgQmQnEi9Rjn4CZK/K+0zcs
         p4jME3NBeTOIBnT5xKLiU/9H+av9UvtsR1WFtdl+3yiKIZwNhhY/fLoNYks0g9nxRr57
         JODQ==
X-Gm-Message-State: AKwxytcGtz+OUOnUm85Z13G9OJH1Hu8vkc6zHyoQJWkExA37KkTvMYZA
        ijhQUPbJyuvVIGdkCBnFygAXVw+vMSUkE79Rn7E=
X-Google-Smtp-Source: AH8x22565pCSPpyy6c4AHQ5aI7dDPVA/M6dwjJdvvt3icbp4TTdR3O/Zi+WgfvoNl16ltrPy91TyZa1P/1N+BoaHlD8=
X-Received: by 10.159.40.35 with SMTP id c32mr34262339uac.40.1517622213818;
 Fri, 02 Feb 2018 17:43:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.8.83 with HTTP; Fri, 2 Feb 2018 17:43:33 -0800 (PST)
In-Reply-To: <CAGZ79kaB-RAP8f4Ea8bDkdVtkmfLSQ4=aA5bYMV_gXOk3qk-zQ@mail.gmail.com>
References: <20180130232533.25846-1-newren@gmail.com> <20180130232533.25846-17-newren@gmail.com>
 <CAGZ79kaB-RAP8f4Ea8bDkdVtkmfLSQ4=aA5bYMV_gXOk3qk-zQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 2 Feb 2018 17:43:33 -0800
Message-ID: <CABPp-BGkboijQJ9_pyCGDNPFxR0vEpqPhn+txzLrn0siqgHVSg@mail.gmail.com>
Subject: Re: [PATCH v7 16/31] merge-recursive: split out code for determining diff_filepairs
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 2, 2018 at 4:06 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Jan 30, 2018 at 3:25 PM, Elijah Newren <newren@gmail.com> wrote:

>> +       ret = malloc(sizeof(struct diff_queue_struct));
>
> Please use xmalloc() and while at it, please use "*ret" as the argument
> to sizeof. The reason is slightly better maintainability, as then the type
> of ret can be changed at the declaration and the sizeof computation is still
> correct.

Will do.

>> +       ret->queue = diff_queued_diff.queue;
>> +       ret->nr = diff_queued_diff.nr;
>> +       /* Ignore diff_queued_diff.alloc; we won't be changing size at all */
>> +
>> +       opts.output_format = DIFF_FORMAT_NO_OUTPUT;
>> +       diff_queued_diff.nr = 0;
>> +       diff_queued_diff.queue = NULL;
>> +       diff_flush(&opts);
>
> The comment is rather meant for the later lines or the former lines
> (where ret is assigned), the empty line seems like it could go before
> the comment?

Perhaps I should just replaced the first three lines, including the
comment, with
  *ret = diff_queued_diff;
?  I was probably thinking along that track, which is why I had the
comment grouped with lines above it, but was for whatever reason just
assigning each value and then noting that one of them was actually
unnecessary.  But it wouldn't hurt to copy either.
