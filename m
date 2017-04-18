Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FC6E1FE90
	for <e@80x24.org>; Tue, 18 Apr 2017 10:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754919AbdDRKI3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 06:08:29 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:36048 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753239AbdDRKI1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 06:08:27 -0400
Received: by mail-wr0-f177.google.com with SMTP id c55so98909253wrc.3
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 03:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=v4WZNTU7c07qb0q+qVFN2QYr25Ti2N5nsjcQs5nGTog=;
        b=gMQa7wizD/McZYp2AwXHv0lQYWLLYDx2u0M+7bLtElceyvH+gkbPOE+FkCc++wtzw9
         XQ4dia8eXVL/9NJWNSFhuPTf+8RNtWJQsdqVA1Zkz3wyisQgUZiqrjvf+heO8C7AU1nJ
         iyTXuhoIgkcZH17/7GcxxLi0ObdV6wqJVNkTZ6qYLBRfWbzGRJWWTjXdwQAyIMYUPmyP
         6KkZUbf8rJB5LG7yXLwD9gWAGv38pSmIB5i4CZ4+aMaaxSo5h1ecjR9EYtwjoEHcMrOt
         0E4zVq60N6ib5Qkrnv8i2RrfUe1ckoHkCGZ5ydLjMX7w0Ei4H0gX0C/cr0NJ3mz3X5/6
         1+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=v4WZNTU7c07qb0q+qVFN2QYr25Ti2N5nsjcQs5nGTog=;
        b=fjoToKkR5sDXejVaU080HO7BZcPGZKsPgEIgMgXoy3RfWQheE2M//UpEDNK5Qo8/qB
         gmSUAr50tdYihMNO8WMWadrTeLTZHlU1EN4qPGZnVXXPr9k2nVDW5qbRXLVe5y1Ml7+R
         pSFfv/+GllllUwpIybpYIBehHgiTXkCbuDQzvQcc7eTmovnMhuXc9ira6W3RY/+T6XGS
         /5VhHCUGoEDnFTqb7kj+9Y8+Pxc0HLFGOKfiU3OanRrOiuvzUnRumtEpbYG/7ZUxnhZl
         RBqULIYd1fGOVkuZE8XX3QpNU/H/7GJ07lwF1XR9JVOk18KVs9OTrl94dE64k+tVUhfV
         cArw==
X-Gm-Message-State: AN3rC/4t3uABKvNKnSjG7ojoonlqTzJrM9PrieQ/YtSBTzvl67aC6jCH
        xILLRJaSDyqJgNgSQTY+Ow/xrC2OFw==
X-Received: by 10.223.163.68 with SMTP id d4mr20858409wrb.134.1492510106513;
 Tue, 18 Apr 2017 03:08:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.142.26 with HTTP; Tue, 18 Apr 2017 03:08:25 -0700 (PDT)
In-Reply-To: <CAJZjrdXBbBiy0f=RJ2m7iHnh70Nz97-tdHWkSJtYbW6CKBr5ow@mail.gmail.com>
References: <CAJgfmqU+1Ex1YkP94H2amXV+oqscbQwvb-CueuCiM7-n0AAP8Q@mail.gmail.com>
 <CACBZZX4fDu-o+ERiTyjVq2rWkXK6rjErU4KyW33qMx1_6vjMCQ@mail.gmail.com>
 <xmqqpogblvfr.fsf@gitster.mtv.corp.google.com> <CAJgfmqWf9j=R1=qy-kGTL4+y_40O+8S5q=VZuD3A-DbfRJer2Q@mail.gmail.com>
 <CACsJy8BASVSxJ4RzNKVpj9MyD=fMR-fpspMdET1bT45yMrf_0w@mail.gmail.com>
 <CAJgfmqW4ck9SwBrT_Z7bTOzM2zG==_ONUhTfhbLJtRu=vT+wyg@mail.gmail.com>
 <xmqq60i2im72.fsf@gitster.mtv.corp.google.com> <CAJgfmqXqfp3A+A74dfkKjQb_26ZNH9anY52-G2L5ipg=+6--2w@mail.gmail.com>
 <CAJZjrdXBbBiy0f=RJ2m7iHnh70Nz97-tdHWkSJtYbW6CKBr5ow@mail.gmail.com>
From:   "Fred .Flintstone" <eldmannen@gmail.com>
Date:   Tue, 18 Apr 2017 12:08:25 +0200
Message-ID: <CAJgfmqX_syWNOno+sKm5PpsbZQkP7VPTp_qraG-Pwv9gjias5w@mail.gmail.com>
Subject: Re: Feature request: --format=json
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

But a repository or branch can have thousands of commits, so running
`git commit-file <commit>` seems maybe not be a wide idea.
But parsing `git cat-file --batch` is difficult, because there seems
to be no reliable way to discern when a commit starts and ends.

I don't code in C though. A JSON formatter option would need a JSON library.
But maybe there should be raised a discussion about JSON in Git if
there are other people interested in this?

On Tue, Apr 18, 2017 at 11:39 AM, Samuel Lijin <sxlijin@gmail.com> wrote:
> If for some reason your use case is so performance intensive that you
> can't just `git cat-file commit` every entry in `git rev-list --all`
> individually, then you can also pipe input into `git cat-file --batch`
> and read output as you pipe input in, which will give you a very
> simple mechanism for delimiting the cat-file output.
>
> In any case, as developers, it's rare to have our job done for us.
> That's why we write code.
>
> I'm sure people would be happy to help if you submitted patches to
> support --format=json.
>
> On Tue, Apr 18, 2017 at 3:44 AM, Fred .Flintstone <eldmannen@gmail.com> wrote:
>> Well the easiest way to work with that would be JSON.
>> So the best would be if Git could output the data I want in JSON format.
>> Then it would be easy for me to work with data.
>>
>> With git rev-list and git-cat file, its not so easy to reliably parse
>> that output.
>>
>> On Tue, Apr 18, 2017 at 2:38 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> "Fred .Flintstone" <eldmannen@gmail.com> writes:
>>>
>>>> So I would either have to do:
>>>> git rev-list --all
>>>> Then iterate over each line and do git-cat-file commit <commit-id>.
>>>>
>>>> Or do:
>>>> git rev-list --all | git cat-file --batch
>>>>
>>>> If I do it in a batch, then it will be tricky to reliably parse since
>>>> I don't know when the message body ends and when the next commit
>>>> starts.
>>>>
>>>> JSON output would have been very handy.
>>>
>>> I am somewhat puzzled.  I thought that you were trying to come up
>>> with a way to produce JSON output and people are trying to help you
>>> by pointing out tools that you can use for that.
