Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 553401F87F
	for <e@80x24.org>; Sun, 18 Nov 2018 20:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbeKSGkK (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 01:40:10 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:35674 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbeKSGkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 01:40:09 -0500
Received: by mail-yw1-f67.google.com with SMTP id h32so6087617ywk.2
        for <git@vger.kernel.org>; Sun, 18 Nov 2018 12:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=pqXBob541QCnAonBBJ3mfuoSHnkDOktz8PTuZxxutuc=;
        b=YrV3hu4aaqoDhObWyw1E/BVq0bkirhdR/0SFzYE4822ux9lRKeH0SW9eqbKNr4cdUn
         PxwcYSciP5zHjea4xE4WXLsF3QDQEvntbI4GCB65IltgraQ8MU/st0xcwfrI6qC+ibSL
         I/NwbB9vvyqQMR85PUFY4bTS0N/96D+Cah3cFDXkIoktziPPkbuhaTkmY9uE83/U5Dml
         gKqED++T7mE+gOV2z90CfSmXCEw/W2xe3hYZgJa2MXA2OPk+OWgR/lIG6z6xW+eJrdTG
         JMr135su5PyFZ/XqeajTmAzYZ4kiD/uXxh2IpqlsGHPBv6WSpjl/R5/pGh9kZivZNAlX
         QIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pqXBob541QCnAonBBJ3mfuoSHnkDOktz8PTuZxxutuc=;
        b=Y5aEwjAfoU5X7xvDHuhbQiHhAhV6Px4Zc1kK5VWNLYgaPO4fEC2ZdgNG/uJFkaHgBt
         s7rtADNsu22OM3TGBVNqlKoW5joO6YuzMxU4ot9ukMWlwfAIVAN1TsG1X/peC0XcFVBw
         8P9dEY3fcMARGkcN4gwjfpzG11rcp4siKBN5z9SkI8TZ7+/hFgn8VQYobhTgK7RYu4D4
         lyD6Rldi+pdW1dHBgnDNxqRd20Fw1zqxIfjQJnAg8CvG+FwDpvYcFbgRlyGkHhEZYVNU
         +CL/0zLhySUG5U+MC2WHIaBJry5supSXunwN/Pj+P61+DD/m3uTIzkrb6+YSnkWCFEAo
         85tA==
X-Gm-Message-State: AGRZ1gLtzrOE9ezLLtkWno8WZ9k3ec0D4XMPVWO4atiqeudrA6M1Y0jW
        WPJMdKPesadi5SRX9feQt8pcG1Xc
X-Google-Smtp-Source: AJdET5chckQOxqdQuHEFUkmwl6ousY2pfeFLjWxaJapoCor2omdKJf+nbaEPCzGMGuMczKiNHa9LYQ==
X-Received: by 2002:a0d:f505:: with SMTP id e5-v6mr18558583ywf.304.1542572334364;
        Sun, 18 Nov 2018 12:18:54 -0800 (PST)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id 80-v6sm8140989ywh.55.2018.11.18.12.18.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 12:18:53 -0800 (PST)
Subject: Re: [PATCH/RFC v1 1/1] Use size_t instead of unsigned long
To:     tboegi@web.de, git@vger.kernel.org
References: <20181117151139.22994-1-tboegi@web.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c09938cf-7631-ef89-d8fc-d952f9b121c8@gmail.com>
Date:   Sun, 18 Nov 2018 15:18:52 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20181117151139.22994-1-tboegi@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/17/2018 10:11 AM, tboegi@web.de wrote:
> From: Torsten Bögershausen <tboegi@web.de>
>
> Currently Git users can not commit files >4Gib under 64 bit Windows,
> where "long" is 32 bit but size_t is 64 bit.
> Improve the code base in small steps, as small as possible.
> What started with a small patch to replace "unsigned long" with size_t
> in one file (convert.c) ended up with a change in many files.
>
> Signed-off-by: Torsten Bögershausen <tboegi@web.de>
> ---
>
> This needs to go on top of pu, to cover all the good stuff
>    cooking here.

Better to work on top of 'master', as the work in 'pu' will be rewritten 
several times, probably.

> I have started this series on November 1st, since that 2 or 3 rebases
>    had been done to catch up, and now it is on pu from November 15.
>
> I couldn't find a reason why changing "unsigned ling"
>    into "size_t" may break anything, any thoughts, please ?

IIRC, the blocker for why we haven't done this already is that "size_t", 
"timestamp_t" and "off_t" are all 64-bit types that give more implied 
meaning, so we should swap types specifically to these as we want. One 
example series does a specific, small change [1].

If we wanted to do a single swap that removes 'unsigned long' with an 
unambiguously 64-bit type, I would recommend "uint64_t". Later 
replacements to size_t, off_t, and timestamp_t could happen on a 
case-by-case basis for type clarity.

It may benefit reviewers to split this change into multiple patches, 
starting at the lowest levels of the call stack (so higher 'unsigned 
long's can up-cast to the 64-bit types when calling a function) and 
focusing the changes to one or two files at a time (X.c and X.h, 
preferrably).

Since you are talking about the benefits for Git for Windows to accept 
4GB files, I wonder if we can add a test that verifies such a file will 
work. If you have such a test, then I could help verify that the test 
fails before the change and succeeds afterward.

Finally, it may be good to add a coccinelle script that replaces 
'unsigned long' with 'uint64_t' so we can easily fix any new 
introductions that happen in the future.

Thanks! I do think we should make this change, but we must be careful. 
It may be disruptive to topics in flight.

-Stolee

[1] https://public-inbox.org/git/20181112084031.11769-1-carenas@gmail.com/

