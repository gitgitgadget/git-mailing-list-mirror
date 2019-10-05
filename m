Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 322891F4BD
	for <e@80x24.org>; Sat,  5 Oct 2019 20:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729664AbfJEUQs (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Oct 2019 16:16:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33029 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727980AbfJEUQs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Oct 2019 16:16:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id q1so5758156pgb.0
        for <git@vger.kernel.org>; Sat, 05 Oct 2019 13:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=O+a0BZaESm3oiCPY94zDdc5YZUQ0SKRaGxxWvlMvqmU=;
        b=poRPaCzJyhoH/ySoSYN67Imqo1wPYC5klAw5fXOWKoIQq2RslEP002oHX6Po870x5f
         SH0VeHbVuRJr+K280Tn8XevIsLM1p3gzoEMSEr1JeVgNCj3rZ5lJXAwvw651z24tEONq
         v8SibVkm7aQ03QWVd3TKTbUnmMMs3uy+w5SK2Nw9mC3R2GyhOS3xiPmiv4l5ZrmwD6Wv
         zAMz71Uk/lCAWkooyD9/ceFQ1+JAte8GSD+wfxnwZPo/1U/Kx4qogVGF/MdACChmMrNL
         DMSMmXHeR3HqhwQBMpp9j5Q3Gh4gw8hhq+02T+UimF6YfrqZEYjjpVqODY8v9M8YRVGr
         BaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=O+a0BZaESm3oiCPY94zDdc5YZUQ0SKRaGxxWvlMvqmU=;
        b=Q5zqCQSFEQjokF/k7paMDixaeylh+YLUNGTXOAp98W7J63FrWFsPMjmKDuRqTVCu2n
         od05A5yg2NoLFjcPehwQtthCoRFj1xD7hbkzB/eFXU+mkdDm/MYcTzxMYFB8zZ0S4LqK
         G2h62s9fWYm1woGkdp333HtPyy5CxZgsdDgCEV507zHAYCPR9GtLE3xeAGiujoMQ/xmq
         c3aUulxPSKNObTSpoHyfjRLehlzNf8fRQW/LfjaGc+IMBtdKOkyRz+QkzxB4SxYtc7dE
         KY7K+Oqn09QGj+TfbDBRc3BaTA6fy2qj3QWRxZvaGxqxHI7WIUNwCXYtAe00AvCQxBPf
         dwzA==
X-Gm-Message-State: APjAAAXBQwhP3JTXw3qpYYIhOZKtU1O/6v1B4P5J8m4DBV9d5DAuUGHE
        Kw2vTidrHPpDbwIo6L1lOtI=
X-Google-Smtp-Source: APXvYqyWHalkkJFRmcIDkQbklvye5CvJqM1LPiSTy132nxjgdwDNlRgg+RdjQDeD1smXqnBmPSlhWw==
X-Received: by 2002:a63:c7:: with SMTP id 190mr21573708pga.186.1570306607416;
        Sat, 05 Oct 2019 13:16:47 -0700 (PDT)
Received: from ?IPv6:2409:4073:2012:1c57:a6db:30ff:fee2:b535? ([2409:4073:2012:1c57:a6db:30ff:fee2:b535])
        by smtp.gmail.com with ESMTPSA id cx22sm8231420pjb.19.2019.10.05.13.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 13:16:46 -0700 (PDT)
Message-ID: <149a83fd40b71896b134b16c2b499ff472c6234e.camel@gmail.com>
Subject: Re: [PATCH] Feature: custom guitool commands can now have custom
 keyboard shortcuts
From:   Harish Karumuthil <harish2704@gmail.com>
To:     Pratyush Yadav <me@yadavpratyush.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>
Date:   Sun, 06 Oct 2019 01:46:41 +0530
In-Reply-To: <20191004120107.kpskplwhflnsamwu@yadavpratyush.com>
References: <01020153c22ab06b-e195b148-37cc-4f89-92f3-f4bed1915eb9-000000@eu-west-1.amazonses.com>
         <20160331164137.GA11150@gmail.com>
         <CACV9s2MFiikZWq=s8kYQ+qwidQ=oO-SHyKWAs4MUkNcgDhJzeg@mail.gmail.com>
         <CACV9s2MQCP04QASgt0xhi3cSNPSKjwXTufxmZQXAUNvnWD9DSw@mail.gmail.com>
         <20191003214422.d4nocrxadxt47smg@yadavpratyush.com>
         <nycvar.QRO.7.76.6.1910041046000.46@tvgsbejvaqbjf.bet>
         <20191004120107.kpskplwhflnsamwu@yadavpratyush.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

From https://www.kernel.org/doc/html/v4.10/process/email-clients.html, I
understood that, my current email client ( that is gmail web ) is not good
for submitting patches. So I was tying to setup a mail client which is
compatible with `git send-mail`. But I was not able to get a satisfactory
result in that.

For now, I followed the instruction of Johannes Schindelin and submitted a
pull request . Please see https://github.com/gitgitgadget/git/pull/376

---------
@ Pratyush: Regarding your comments,


> A pretty nice way of doing it. But I would _really_ like it if there was
> an option in the "create tool" dialog to specify the shortcut. People of
> a gui tool shouldn't have to mess around with config files as much as
> possible.

I agree with this, But that may require some more profficiency in TCL/TK
programming which I don't have. This is the first time I am looking into a
TCL/TK source code.
Any way I will try to integrate the gui gradually in feature. But
unfortunatly, I may not be able to do that now.



> David has advocated inter-operability between git-gui and git-cola.
> While I personally don't know how many people actually use both the
> tools at the same time, it doesn't sound like a bad idea either.
>
> So, sharing shortcuts with git-cola would be nice. Of course, it would
> then mean that we would have to parse the config parameter before
> feeding them to `bind`. I don't suppose that should be something too
> complicated to do, but I admit I haven't looked too deeply into it.

IMHO, Using a uniform shortcut-key code/foramat for both application can be
considered as nice feature.
But, whether we should share common shortcut-scheme with both application is
a different question.
Currently, both apps don't have a common shortcut-scheme. So in this
situation, only sharing custom-tool's shortcut-scheme with both applications
doesn't look like a good  idea to me 


> Are you sure that is a good idea? I think we should at least make sure
> we are not binding some illegal sequence, and if we are, we should warn
> the user about it. And a much more important case would be when a user
> over-writes a pre-existing shortcut for other commands like "commit",
> "reset", etc. In that case, the menu entires of those commands would
> still be labelled with the shortcut, but it won't actually work.

I agree with you. It is an important point. After reading this, I checked
current status of these issues. What I found is given below.

1. When user provides an invalid sequence for the shortcut, it will cuase the
entire gitgui application to crash at the startup

2. When user tries to overwrite existing shortcut, it will not have any
effect. Because, built in shortcuts will overwrite user provided one. But
still, wrong menu accelerator label will persist for custom tools

Since #1 is a serious issue, I tried to find out the function which does the
keycode validation, but I haven't succeded till now. ( I found the C function
name  which is "TkStringToKeysym" from TK source, but I couldn't find its TCL
binding ). It will be helpful if any one can help me on this.

