Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 089AE1F403
	for <e@80x24.org>; Thu,  7 Jun 2018 05:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752861AbeFGFJB (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 01:09:01 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33507 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752788AbeFGFJA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 01:09:00 -0400
Received: by mail-pl0-f66.google.com with SMTP id n10-v6so5289284plp.0
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 22:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sDcNk02Qy1qZt1KHlSM9ADFN2o0iir5o/oUMFLUjUhA=;
        b=dKnnMsmaMW+BDd6qimproCiNV/ryj1AHN3Fo6PN+5tGsKYVS3cVTgZiOY4WUl8i2G4
         BKXrEqw/WF9YrM/XEs7BQbB3CZneMHwyRx4OhXA/wdhr5RzKVXdXVezT/niGzELYeukn
         f8R321b4Rhf+t6TITwHSU1DzQkFQUk7/9hpBLkjh1Oq5xDk0kOmO0UjaR+q8LikqeVh+
         dsrLG9fBydGjbUvr3ObtErpXVEkPSUdqrxQlsTnIfWxQnBDPGI+cCVinWs8rjuY9gbyl
         eBKoE3JQyDCoisdMQ1aVbtnW4wBuADEFaWHaKRNRbwvo/CKTBQrtHgxFWasg68cIb3XL
         3ihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sDcNk02Qy1qZt1KHlSM9ADFN2o0iir5o/oUMFLUjUhA=;
        b=mNvQPHWAvfRkQrvWuHDUlr+Dk1/czgmw7gR0Yfy0wqSO+LVG+jtVrOmBZXjPu4/4Mt
         S7uF1NyEo7y3tI26js82k71cy6tKsUb9FE6YGqCVxe9bhK0CZKBBaRKGT1YPSdXRzr/c
         9yRUhI6Fw1XwjlKJpmIbQqJ3zjZf33wZuNf/x7vOabbBnvzkfLhShyaX1T502k4mnN2p
         j1UV3xlZNklNMstOFl5HVGOTGv+wrPvKN2ZJjHQnnz7JdmPcA7vzvxGmth8G8htNcK/5
         qmYgtu2lrLR1W414/A6Ob8X5WD8K7JDqEuh7XZY6mbXGjCScRDHAIL7+GW6/RVZtFIZw
         7K5Q==
X-Gm-Message-State: APt69E1uAyeqZjDdIDm+r9e8zvUCsZg+99YPtVJtv9dj9WtDgXD9Y9pv
        E3Rc3Ww9t7hNKxv3CrDEz70=
X-Google-Smtp-Source: ADUXVKKx4N3zv7OigFBGJ/21j/nmu6jmc4jrK2EEmhJTh3FeBoeZkAO6d25eyuodOD4z9gwPD3YIlw==
X-Received: by 2002:a17:902:125:: with SMTP id 34-v6mr488464plb.42.1528348139502;
        Wed, 06 Jun 2018 22:08:59 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id x8-v6sm17909818pfa.87.2018.06.06.22.08.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 22:08:58 -0700 (PDT)
Date:   Wed, 6 Jun 2018 22:08:54 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Rick van Hattem <wolph@wol.ph>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] Use ZSH_NAME instead of ZSH_VERSION because it's
 redefined by git-completion.zsh
Message-ID: <20180607050854.GA6567@aiede.svl.corp.google.com>
References: <01020163c683e753-04629405-15f8-4a30-9dc3-e4e3f2a5aa26-000000@eu-west-1.amazonses.com>
 <xmqqr2ln5ide.fsf@gitster-ct.c.googlers.com>
 <CAJAwA=xjS6bWO2Cy+-pz-Es_RjvSyno9JNBGdPAve1L9ctOy-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJAwA=xjS6bWO2Cy+-pz-Es_RjvSyno9JNBGdPAve1L9ctOy-A@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Rick van Hattem wrote:
> On 4 June 2018 at 05:40, Junio C Hamano <gitster@pobox.com> wrote:

>> Overlong line, lack of sign-off.
>
> Apologies for the long lines, I wrote the message on Github where this
> message is properly formatted, apparently the submitgit script can be
> considered broken as it truncates the message when converting to email.
>
> The original message can be found here: https://github.com/git/git/pull/500
>
> Below is the original message with proper formatting:
>
>> A recent change (94408dc) broke zsh for me (actually segfault zsh when
>> trying to use git completion)
>>
>> The reason is that the `git-completion.zsh` sets the `ZSH_VERSION`
>> variable to an empty string:
>>     ...
>>     ZSH_VERSION='' . "$script"
>>     ...
>>
>> I'm not sure if @szeder or @gitster used a different zsh version for
>> testing commit 94408dc but it segfaults zsh 5.5.1
>> (x86_64-apple-darwin15.6.0) on my OS X 10.11.6 machine.
>>
>> The proposed fix is quite simple and shouldn't break any backwards
>> compatibility.
>
> Hopefully that clears a little bit of the confusion.

Thanks.  That helps a little, but it's missing a crucial piece: may we
forge your sign-off?  See Documentation/SubmittingPatches section
[[sign-off]] ("Certify your work") for more details about what this
means.

Thanks,
Jonathan
