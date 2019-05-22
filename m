Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50EBD1F462
	for <e@80x24.org>; Wed, 22 May 2019 18:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbfEVS7h (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 May 2019 14:59:37 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:37210 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbfEVS7h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 May 2019 14:59:37 -0400
Received: by mail-qt1-f173.google.com with SMTP id o7so3727927qtp.4
        for <git@vger.kernel.org>; Wed, 22 May 2019 11:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=kJtkZK0F2yHwPGUJullg7rwlD3GhQsNeVRRjuL73agA=;
        b=YYObIGp0ys3CkJuySkTGZI1PiooJS/fQe3l1bLa/fLAZ3CGwmnwBjQAeXeHtxRGN92
         NosfZk0NspLX6AmtC1YW8u5EZmKT2y/ngE5D4g2lqcpU9hQUWS8N+4JKVeOlesJfKhTi
         NFg23NHYjzd6KbIhzjJeMIw05UsAwCjHpjWiX0LPY9idnpw4xrh8x3dReE735FaiaH0N
         IPJaHbKK6fsRW66o/Lf8mZZfEIedsU4w1fggK265eZ9XzLVZqjsLTsNi66MYxKYPKnQY
         pduajNRJcFwX0bB8Mk+kMHkmLvOTwDuUX4N4Z1F90I6KxWL1TPER7HYKWjg3z8FRCHcw
         lhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kJtkZK0F2yHwPGUJullg7rwlD3GhQsNeVRRjuL73agA=;
        b=RmeXjwmwx1hmRhyMl25RCOGRjx7WTQLRJVwguas3GYjdwKMYjD1lABnDTFSteW025P
         C4x/aW7DxBdRGD8kETb0crgO9ttcae40+xlhF9UpW4LgS51epCjIHzJwpdqoQlKkOTOF
         JWwewDMspDp58yJOJBJ0ExqqzrqHXWy+AZKpWr/asM7slt6mfCFF72X1uVVQe5IMOk4t
         4RAVKsEyY9+GoRqX6pCOWj5dHeRilC3ka4vU7e/77MVQ9qcKoBDCbuC+i+NSCahE8SFf
         1JBULMINL4WERRVlrfv4//lgN2+HX5yMsTjy4deiayBnA5achFrt5G1yptA9CNt4XsmR
         L0Qw==
X-Gm-Message-State: APjAAAXOTs546F9rRiD6MZYnHcpsMEAlGweQpgCuN1w3vaaK48/8myrG
        zt3zDLcLTexBrWqh8zBac9hGDrXsJNc=
X-Google-Smtp-Source: APXvYqyc74J+jwloQ1k8xERak7GBoJBeXXmoUD0G0cVqCtrZCLS4eg058kngqDlB1jBfopnd2MqIhQ==
X-Received: by 2002:ac8:3884:: with SMTP id f4mr78015423qtc.300.1558551575841;
        Wed, 22 May 2019 11:59:35 -0700 (PDT)
Received: from [10.0.1.13] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id b123sm11503400qkd.45.2019.05.22.11.59.34
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 11:59:35 -0700 (PDT)
Subject: Re: standalone library/tool to query commit-graph?
To:     Karl Ostmo <kostmo@gmail.com>, git@vger.kernel.org
References: <CAECbv94KF9MhzZqa8BR-RL93mh0NuD3vA69pAT-sY5O74e_duQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <be719a37-ffa0-26d3-eb9c-0f5ccde52e7f@gmail.com>
Date:   Wed, 22 May 2019 14:59:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <CAECbv94KF9MhzZqa8BR-RL93mh0NuD3vA69pAT-sY5O74e_duQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/22/2019 2:49 PM, Karl Ostmo wrote:
> After producing the file ".git/objects/info/commit-graph" with the
> command "git commit-graph write", is there a way to answer queries
> like "git merge-base --is-ancestor" without having a .git directory?
> E.g. is there a library that will operate on the "commit-graph" file
> all by itself?

You could certainly build such a tool, assuming your merge-base parameters are
full-length commit ids. If you try to start at ref names, you'll need the .git
directory.

I would not expect such a tool to ever exist in the Git codebase. Instead, you
would need a new project, say "graph-analyzer --graph=<path> --is-ancestor <id1> <id2>"

Thanks,
-Stolee
