Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29B301F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 16:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756959AbcHXQfM (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 12:35:12 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:34881 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755347AbcHXQfL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 12:35:11 -0400
Received: by mail-it0-f48.google.com with SMTP id x131so220052064ite.0
        for <git@vger.kernel.org>; Wed, 24 Aug 2016 09:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jygU4o+Sq3RfTRZd7AwOLm1UNok1Rqhg6P/qpOesW94=;
        b=HOVskIfdxfdQ82W2TUtNzNy/8MyyViitRKwDvka7WYOwCa03np9XHo86IDGIgEb/2f
         JTu1da6sQ4Mrz1OQgxu2kI0fvUWyl/9RjDQQSfIiwmumrb+CmlLqmPuOZJr/S7ab8EWr
         POhqe/q3xcWrSTM/CkzVbeGLvwch/eC4KAxW0pXD5SXaptO7wD0JGXiLmecwEaCq06B3
         8aKjbNG12Y8+AQSWxvW5EMvTQGKsoB1PE/NsxNsiqY3v6H9iy9yqJyvHkHdzrYYDUJQx
         zSMQeGK84BvXfngiuR0+VyKdrYhvQVsF6Q0A8vM9yK52UdG4yHDxKuIgKcQwpxknocOz
         FRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jygU4o+Sq3RfTRZd7AwOLm1UNok1Rqhg6P/qpOesW94=;
        b=ZR+1MeNJqqhMyy1/XV58uTYkfuZMh331gPT+QZQddGVLncwkA+WY6fqQmVRxWBqtdu
         wMFuwOc9HeE6LMIcSBYqQ/T2HdwThzDIjgVPtz3q3Gyw3mnSfMruJm3a/TPUhZG03weR
         mvSZeuBRzYE4rnE1YZJ6uC5I5+xxTUX6XoPNHwFxeGHk0TGq0leU53FVgweHLK2AkXyN
         yrDDhTZS7VfMcQfKzL0+HJyteGWVym4exQyaQEF61bYzi1FgyaBppky8dhZlANDRIbWm
         u0sFwQwcZoyPr1Favf1yetWYYrx3n8TQfaNv/cUt+X6JKlezArgErQSSmicJnMD1gsEs
         iwMA==
X-Gm-Message-State: AEkooutCFY493TqGkbKkoM4rFGTxsNyusIWxZ4KNpuQWCG+4eA4sdGA1/lYah+T1UQml42zvGXwuOuKoQQHx80c1
X-Received: by 10.36.189.76 with SMTP id x73mr17883838ite.97.1472056510530;
 Wed, 24 Aug 2016 09:35:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 24 Aug 2016 09:35:10 -0700 (PDT)
In-Reply-To: <20160824122828.0c2688e8@labs-064.localdomain>
References: <20160823214008.32331-1-sbeller@google.com> <20160824122828.0c2688e8@labs-064.localdomain>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 24 Aug 2016 09:35:10 -0700
Message-ID: <CAGZ79kb1ur=s+FYcdCh+obKyfaozX=adAPESu9G9FQxVtLTDbg@mail.gmail.com>
Subject: Re: [PATCH] transport: report missing submodule pushes consistently
 on stderr
To:     Leandro Lucarella <leandro.lucarella@sociomantic.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Heiko Voigt <hvoigt@hvoigt.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 24, 2016 at 3:28 AM, Leandro Lucarella
<leandro.lucarella@sociomantic.com> wrote:
> On Tue, 23 Aug 2016 14:40:08 -0700
> Stefan Beller <sbeller@google.com> wrote:
>> The surrounding advice is printed to stderr, but the list of
>> submodules is not. Make the report consistent by reporting everything
>> to stderr.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>
>>   This fixes one of the bugs mentioned in
>>   https://public-inbox.org/git/CAGZ79kbkyupBJfvyX3Hj_R5ZW36+3ufOnnLC-Dpic40nPJAxDA@mail.gmail.com/T/#t
>>
>>   How to fix the other was not as obvious to me as I do not
>> understand the philosophy on verbosity in the transport code.
>
> I had a look and I would say just enclose all the fprintf() inside a:
>
>         if (transport->verbose > 0)
>
> But then this is the first time I look at the code. I was about to send
> a patch too but it will conflict with this one :)

Well you can still send a patch :)

We have

    int verbose = (transport->verbose > 0);
    int quiet = (transport->verbose < 0);

So you're suggesting to only print these warnings when the
user asked for explicit verbose?

A few lines before the call to die_with_unpushed_submodules we have

     die ("Failed to push all needed submodules!");

which would also need a wrapping like

    if (quiet)
        return -1;
    else
        die(...);

Thanks,
Stefan
