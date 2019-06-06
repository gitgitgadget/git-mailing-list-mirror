Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FFE71F462
	for <e@80x24.org>; Thu,  6 Jun 2019 12:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfFFMXt (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 08:23:49 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42777 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfFFMXt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 08:23:49 -0400
Received: by mail-qk1-f196.google.com with SMTP id b18so1276428qkc.9
        for <git@vger.kernel.org>; Thu, 06 Jun 2019 05:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SYCFpIvLYmlsjRI7H3NIbbVPfvWGg6PKCFs0B8RPvBQ=;
        b=dkFll+KPq4FfVTc7KW9BhoLIDb7dCmuylC5shcvVnpMhhEa8ndmjVNFAW48SzPn7m/
         Fegs9mo6VCOllHxZN+Wl/y+AYq4GlbQa6UVYRGvyaxYrlFEeYZJHKKbYwfwbNKse0hxH
         v/QbD/BqN5Wb4iyhZydzP7WADXfzuwultrZFtryNHQJWRxuZKWdjU5MK6HFbj9IaeSJS
         jsXB8pMGc0nZpDby2PDYhzwbi12d2MlQcazbfnQ8rLT8ZDKzh/HUPxbvqFOWUQpwDAmm
         8XZYF7Y/rP2QsHlAC37uHy/ejAPrNFULlZGSmFskEvv8wl6V3luiINo1AcbyzTENQP79
         mAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SYCFpIvLYmlsjRI7H3NIbbVPfvWGg6PKCFs0B8RPvBQ=;
        b=JsBsXfuAHHSPVVReRmfHmRwIvnfkx34c/zpdfIlpQtJJcbdoKFUNqixrb89zHSWKnJ
         Bzs6DZx7b0ekU00wbT25GVM4D0PnPs6WV2rRuSYiVjUgBNKtiae/9PiOq2k4dlVmCiYD
         QhDD7WLtY2mVIu1RbXZWLAepY/emj77sraSemmZmhv7N/g7NID/EscpakuVmGVuizXO1
         g76bt9gSm+mQ3+ZKhwhy4Ro+PUC+T9YbRBiyOAgoG+MX0Zj217xnpwvCRC+lgIr9sxeW
         yTM6S6s4E0e4rAKHXPdwJNeM1vRql4YjEqxMorxiELZZiusG2y6WxNS3Jfji5fdnaM1z
         UJdQ==
X-Gm-Message-State: APjAAAWn758ubsLaKSWCXzZgWLoOZmNnBhzhrauEjmSvrjfUgwlH2vHO
        UcQWuClR8H0hD7dlpP3Hdr/Pu2OT1dc=
X-Google-Smtp-Source: APXvYqyzFGLKb7KVpkR6HS86WUEsuR1w6X9QpdW0EF1nWZhhno03KkP3qZLzdgnqAodQDeSGqNeGXQ==
X-Received: by 2002:a37:bd46:: with SMTP id n67mr30621800qkf.266.1559823828068;
        Thu, 06 Jun 2019 05:23:48 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:f8bc:cb1d:88e9:2127? ([2001:4898:a800:1012:a9f0:cb1d:88e9:2127])
        by smtp.gmail.com with ESMTPSA id o33sm956473qtk.67.2019.06.06.05.23.46
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 05:23:46 -0700 (PDT)
Subject: Re: [PATCH 00/11] [RFC] Create 'core.size=large' setting to update
 config defaults
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.254.git.gitgitgadget@gmail.com>
 <xmqqftonsr6a.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <741a4e37-e5d6-829a-75ee-b9bc3f3b17b2@gmail.com>
Date:   Thu, 6 Jun 2019 08:23:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <xmqqftonsr6a.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/5/2019 4:39 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> This patch series includes a few new config options we created to speed up
>> certain critical commands in VFS for Git. On their own, they would
>> contribute little value as it is hard to discover new config variables.
>> Instead, I've created this RFC as a goal for probably three sequential patch
>> series:
>>
>>  1. (Patches 1-3) Introduce a new 'core.size' config setting that takes
>>     'large' as a value. This enables several config values that are
>>     beneficial for large repos. We use a certain set in VFS for Git (see
>>     [1]), and most of those are applicable to any repo. This 'core.size'
>>     setting is intended for users to automatically receive performance
>>     updates as soon as they are stable, but they must opt-in to the setting
>>     and can always explicitly set their own config values. The settings to
>>     include here are core.commitGraph=true, gc.writeCommitGraph=true,
>>     index.version=4, pack.useSparse=true.
> 
> ... and not the configuration introduced by the other two points in
> this list?

They are added to the config setting after they are introduced. See
patches 7 (status.aheadBehind) and 11 (fetch.showForcedUpdates).

> "If you set this, these other configuration variables are set to
> these default values" is a very valuable usability feature.  It
> looks a lot more "meta" or "macro", and certainly is not a good idea
> to call it as if it sits next to variables in any existing hierarchy.
> 
> I also wonder if this is something we would want to support in
> general; random things that come to mind are:
> 
>  - should such a "macro" configuration be limited to boolean
>    (e.g. the above core.size that takes 'large' is a boolean between
>    'large' and 'not large'), or can it be an enum (e.g. choose among
>    'large', 'medium' and 'small', and core.bigFileThreshold will be
>    set to 1G, 512M and 128M respectively---this silly example is for
>    illustration purposes only), and if so, can we express what these
>    default values are for each choice without writing a lot of code?

That's a good point that we could include recommended values for
other non-boolean variables if our "meta" config setting is also
non-boolean. This fits in with the "ring" ideas discussed earlier [1].
Taking in a few ideas from your message, perhaps we create a new "meta"
category for this setting and use an integer value for "how big do I
think my repo is?" and we can apply different settings based on thresholds:

 0: no config defaults changed
 3: safe defaults (core.commitGraph, index.version=4)
 6: behavior-modifying defaults (status.aheadBehind, fetch.noShowForcedUpdates)

Using 3 and 6 here to allow for finer gradients at a later date.

[1] https://public-inbox.org/git/xmqqftonsr6a.fsf@gitster-ct.c.googlers.com/T/#m8dbaedc016ce7301b9d80e5ceb6a82edfa7bafac

>  - if we were to have more than just this 'core.size' macro, can two
>    otherwise orthogonal macros both control the same underlying
>    variable, and if so, how do we express their interactions?
>    "using these two at the same time is forbidden" is a perfectly
>    acceptable answer for the first round until we figure out the
>    desired semantics, of course.

To borrow from linear algebra, I would recommend that two orthogonal
config settings have disjoint _bases_ (i.e. the set of config settings
they use are disjoint). Of course, this can be discussed in more
detail when someone suggests a second meta-config setting. Such a
second setting would need justification for why it doesn't work with
our first setting.
 
>  - perhaps we may eventually want to allow end users (via their
>    ~/.gitconfig) and system administrators (via /etc/gitconfig)
>    define such a macro setting (e.g. setting macro.largeRepoSetting
>    sets pack.usebitmaps=true, pack.useSpars=true, etc.) *after* we
>    figure out what we want to do to the other points in this list.
>
>  - even if we do not allow end users and system administrators futz
>    with custom macros, can we specify the macros we ship without
>    casting them in code?

Are you suggesting that we allow some config values to be pulled from
the repo contents? If we could identify some config options as "safe"
to include in the Git data, then a repo administrator could commit a
"/.gitconfig" file _and_ some existing config option says "look at the
config in the repo".

I see value in making some "safe" settings available in the repo, but
also see that it can be very tricky to get right. Further, I think it
is independent of the current direction. In fact, I would imagine the
meta-config setting be one of the "safe" settings that we could put in
this committed config file.

Thanks,
-Stolee
 

