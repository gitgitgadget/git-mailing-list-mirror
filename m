Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB6F120D0C
	for <e@80x24.org>; Tue, 13 Jun 2017 21:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753683AbdFMVvn (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 17:51:43 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:32823 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753643AbdFMVvm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 17:51:42 -0400
Received: by mail-io0-f193.google.com with SMTP id j200so10002938ioe.0
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 14:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zIW8z45ipQmPtxl/tnMsGOXrj7jfu4el7NMwD7aT4wU=;
        b=Qjt9RNOOAdihVlVdyqEW04ywR212Z5S1b2gD6bZQC0TL4xIxdE4ZxxcAtViExnYs2+
         fLKj72LLUZX93ZKc8PcbkQUZRpwO8szb2gOVOYcDKATj6RB1Z9dD2+ZX/i6/FUNSnFad
         KsHQm3O8zyo2tdHryCCoiXhn8GYhwm0lYeS1mTrPnjkdfAjjU2uzDyUqFA7fx+dg1xAM
         05VsE9wAbZcQ/i+NXfT1NT6mErJqDOWfhxUyDvYsicw3EIvUcmE+G4lPCf+LrQtXM9nQ
         o7aC/JbdqDr7MUzR58ooOqamSK14r9nnlb3G6fihkiKkOz9p3Cya64sGqInMF4e09w2F
         Jz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zIW8z45ipQmPtxl/tnMsGOXrj7jfu4el7NMwD7aT4wU=;
        b=gUvItG9ux9MXsR/ZdmccUo2hEMGrV5x2s8yEUJltMm8dBMYSSlSAFGGGJJER0qkYDV
         QWlC3BxrM54Nh64rgIaPJ5BlOcjo9BXB5yclseyscnb/SALaahmxMgSCd0fVxECKA4a+
         6NCiSifMoGFoiJXv2QSkSg0g+AAlS7TvKAz67F5QxKZmETo7GsU7jc6+QL09ORMFZTWD
         Arb2CraoAQx80bioRRzjjJ5T4zBBKbYC5jLluw764zzSISgkeoa+ReVisqfsMBZckeLE
         IjY47lCxaTuoJ++U62qwgrr4OzxbFCW/+qhvgR5bAfB0Xtzg9lL76bvy9CFc6O3phoYs
         kyJw==
X-Gm-Message-State: AKS2vOz5kD5FYTywlwhm/zqwrCQdx//gNJSxffP6NSSOjGj6FwK28pZR
        fd1gkNdgdRPvnw==
X-Received: by 10.107.149.69 with SMTP id x66mr1775017iod.104.1497390701708;
        Tue, 13 Jun 2017 14:51:41 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:8130:47b0:791f:5985])
        by smtp.gmail.com with ESMTPSA id 65sm2575925itm.1.2017.06.13.14.51.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 14:51:40 -0700 (PDT)
Date:   Tue, 13 Jun 2017 14:51:38 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de,
        peff@peff.net
Subject: Re: [PATCH v2 4/6] config: don't implicitly use gitdir
Message-ID: <20170613215138.GM133952@aiede.mtv.corp.google.com>
References: <20170612213406.83247-1-bmwill@google.com>
 <20170613210321.152978-1-bmwill@google.com>
 <20170613210321.152978-5-bmwill@google.com>
 <20170613210806.GJ133952@aiede.mtv.corp.google.com>
 <20170613213815.GP154599@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170613213815.GP154599@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:
> On 06/13, Jonathan Nieder wrote:
>> Brandon Williams wrote:

>>> Commit 2185fde56 (config: handle conditional include when $GIT_DIR is
>>> not set up) added a 'git_dir' field to the config_options struct.  Let's
>>> use this option field explicitly all the time instead of occasionally
>>> falling back to calling 'git_pathdup("config")' to get the path to the
>>> local repository configuration.  This allows 'do_git_config_sequence()'
>>> to not implicitly rely on global repository state.
>>>
>>> Signed-off-by: Brandon Williams <bmwill@google.com>
>>> ---
>>>  builtin/config.c | 2 ++
>>>  config.c         | 6 ++----
>>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> The same comments as before still apply:
>>
>> - this changes API to make opts->git_dir mandatory, which is error prone
>>   and easily avoidable, e.g. by making git_dir an argument to
>>   git_config_with_options
>
> I still don't agree with this.  I have looked at all callers and ensured
> that 'git_dir' will be set when appropriate in the 'config_options'
> struct.  I find the notion ridiculous that I would need to change a
> function's name or arguments every time the internals of the function
> are adjusted or when an options struct obtains a new field.  Plus, there
> is already an aptly named parameter of type 'config_options' with which
> to hold options for the config machinery.  This struct is also added to
> in a later patch to include commondir so that the gitdir vs commondir
> issue can be resolved.

What is the next step, then?  You can find the notion ridiculous but
it's how this project has worked in my experience (and how other
projects with similar patch-based workflows work).

I also don't really understand why it is so bad to have to care about
API compatibility when it is so simple to do --- change the function
signature or change the function name.  That's all it takes.

>> - the commit message doesn't say anything about to git dir vs common dir
>>   change.  It needs to, or even better, the switch to use common dir
>>   instead of git dir can happen as a separate patch.
>
> There really isn't any switching in this patch.  One of the following
> patches in this series addresses this problem in more detail though.

There is, because of the gitdir: behavior change.

Jonathan
