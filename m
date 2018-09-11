Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C13B31F404
	for <e@80x24.org>; Tue, 11 Sep 2018 15:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbeIKUNq (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 16:13:46 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:38466 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeIKUNp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 16:13:45 -0400
Received: by mail-it0-f68.google.com with SMTP id p129-v6so1948642ite.3
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 08:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Mk2+DkR1viKvPjpA1AawVTT2zQWE7WE07Fvxew1fjuU=;
        b=EMkuJx0TlYMovSp+63+BsaHXuM/rMYpt9ls36lQYNJ+/XmLeYPQ3cjwpKjuCM7/9kd
         AjRfk1lG8niHb8QEreaRQV1zRcpg3l0I2Xy0Ln6muJUB/dMm/PvL3ovHogstMjPyxWCE
         J5CADTZr77b0M0Pwz/sOpV5imze/AkZhoq2+iYS9W1py55uiZdTSR57LSQZlvCNp9bQj
         Chcs/zNJJo0RE/3U4xsfAaBWAFZNzMVatBxkM2UX3hUN5lD/YoQ8vWEoAFUOBljnEG9p
         VxOuaxr9y+vGkZ+gTZqpRuoVmOLW5jrO+TGOBcS0ySVPrByKK9CbUotMv4fqvpijrexe
         4NHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Mk2+DkR1viKvPjpA1AawVTT2zQWE7WE07Fvxew1fjuU=;
        b=mll6eTE2hOwwfDAmUyYUUGSyvvDPqR/H31HKgjBuUtPsZ3j+p/nAUawrDS6zGdaK0A
         5hUG18x5dnpGLY7Mq010IqeVJ+03fuJBoBCzawahzvdsj9TtAA4dLXdKe2nkWNA7tuD/
         ZmZGcE5dq5qoxzxdvbCcmz37AE4PSw2nOacjPrYq1+WVU81oL3tiNcBWWl19f8nJqx/B
         E0EI0dPddwJQBjbp/1Zd5flzbpykSQlhjRCZ7BVkw7TuuFYl0FZQ4MmtN+HcOpRIRwd9
         yqdGuLRm+fzEJW24gR1p04cpnV2dNbBGiqQdBcAOIpwqmoo+AT40yPzZVD/3UQzmeEKw
         4KSQ==
X-Gm-Message-State: APzg51Cw4zqNaRi8e4vqQL++FWrDEIpW2yN9B69ThV6iVWyG3xL3slBI
        xa9ztJbtSaWVU6vHP0qBGUSeJIb7mYFcTbR0LzU=
X-Google-Smtp-Source: ANB0VdYFABHCd8sMz+CQg28Qy2KejmnTVXSIiSq84gQU2WAYIb1//9onu7Fijbl7fWG/rJUeh/u6v1cGL6ntlIVZxxY=
X-Received: by 2002:a24:cfd7:: with SMTP id y206-v6mr1956102itf.112.1536678840228;
 Tue, 11 Sep 2018 08:14:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22a7:0:0:0:0:0 with HTTP; Tue, 11 Sep 2018 08:13:59
 -0700 (PDT)
In-Reply-To: <69879118-2753-971e-9818-3ebd4a927ffc@gmail.com>
References: <20180608135548.216405-1-dstolee@microsoft.com>
 <20180627132447.142473-1-dstolee@microsoft.com> <20180627132447.142473-21-dstolee@microsoft.com>
 <CAP8UFD3kzZo8qQqj=8T-TXbvb9b-KD=Ok7TgdV--Cb8MT4NCiA@mail.gmail.com> <69879118-2753-971e-9818-3ebd4a927ffc@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 11 Sep 2018 17:13:59 +0200
Message-ID: <CAP8UFD3Fm2ZHH8TtmpZNnWn2_LvFWKaB+HzAcrWK0ea1HyOE+Q@mail.gmail.com>
Subject: Re: [PATCH v7 20/22] commit-graph: add '--reachable' option
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Jakub Narebski <jnareb@gmail.com>, marten.agren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 11, 2018 at 1:19 PM, Derrick Stolee <stolee@gmail.com> wrote:
> On 9/11/2018 1:22 AM, Christian Couder wrote:

>> It would be nice if the "Future Work" section of
>> Documentation/technical/commit-graph.txt had something about
>> integration with 'git gc'.
>
> I'm a bit confused about this statement, because at the point in time of
> this patch we had a spot in the "Future Work" section about automatically
> updating the graph _somewhere_. The "future integration with 'git gc'" I
> refer to in this patch is implemented in PATCH 21/22. In PATCH 22/22 we
> removed this section from the technical doc:

Yeah, sorry I had not seen PATCH 21/22. I was interested in an update
about the commit graph feature and especially to know if the way to
use it had been simplified in v2.19.0, so I took a look at the
Documentation/technical/commit-graph.txt and
Documentation/git-commit-graph.txt, but I didn't find anything there
except the `--reachable` option. So I thought that integrating with gc
was still something that needed to be worked on.

> Now that this feature is shipped in Git 2.19.0, this no longer belongs in
> "Future Work".

This is great!

It would be nice though to have something in
Documentation/technical/commit-graph.txt and perhaps also
Documentation/git-commit-graph.txt about it, as it is easy to overlook
the gc.writeCommitGraph documentation in Documentation/config.txt.

>> The "EXAMPLES" section still contains:
>>
>> * Write a graph file containing all reachable commits.
>> +
>> ------------------------------------------------
>> $ git show-ref -s | git commit-graph write --stdin-commits
>> ------------------------------------------------
>>
>> I wonder if this should have been changed to use `--reachable`.
>>
>> Thanks!
>
> This is a good idea. I can work on that.

Thanks,
Christian.
