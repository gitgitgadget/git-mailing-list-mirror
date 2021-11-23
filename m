Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D8BC433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 18:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239830AbhKWSkA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 13:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbhKWSj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 13:39:59 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC6EC061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 10:36:50 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id bu11so15678911qvb.0
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 10:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=KPejQYHws9AT2w4jrmDgqBsY4yphhWU1NA9RwenKSBc=;
        b=mNY9ab0MUokE5yAbMemrMQ43j0rdWXgjWzJW/oHxSlVF/nznyV6Z4l+FN+o20qOodh
         4U196YrCus3oltO23/qBU7DjKgHRxDeBtXLkniPuV7ypyRbROtLgh21hu6X772RxefAp
         KGqyBZzJcOo82y5Cl5tS4Jz68NzfPpc4BOJ/zk4D/Iq+XYHvlbaKb03fcmVfJYEuQQ1v
         1NPiEdnjPvtlbleBceT7erZ5Pp6azzKxlQrZ7XJyxxvq23bVhERyKnKyZcyK+WAJ4YsY
         kIoWsWRMb1WbHxMWU4mHGz7rpXrZrQYwaVtCEcHFrEU5WeE/A0qIcKKSIKMKvQaTqp1w
         0oFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KPejQYHws9AT2w4jrmDgqBsY4yphhWU1NA9RwenKSBc=;
        b=inBf8VaD21uXIjVSFO2P/gcICsT4tRsvecCFChFivt6+Jwmh6rQqRgVwQbDnlD8lQl
         JUghApsjZrBA40wzI/M7C1aWvz816YN6kFjWExXNrezCnj6U1MGXGaz5c1R1b17TkfW4
         xhXki18S1trmx5DOkpg4/Ub9K5s1r0FqOhZl8NL91xMgGX5UFXWAJXucGn9E239cbJyH
         ssxgdYu9gII0nmOj1bKhdzLEMEYnm1oifkAT3oK3IvEMVJASz4mjYZ4+ArfAXEhi/yaW
         pwmeLgVxsYR/5n4nwMdVOq+mU1dJnnj1wrX6+YaXv7AignvnA8/Vuf+Qqhv2ivZwFlXx
         wkFA==
X-Gm-Message-State: AOAM530kmTw12ZaTJ8eJ1+NI/QqrTELVneJQtLVYiPm+mFEq9P7jjUdo
        mFLRA8AT0ubDqtD0Wjk1ibGIT55xIiY=
X-Google-Smtp-Source: ABdhPJxwPP/MuPQzwr/ArG/2kDb3qekSLQ6UlBU+Z0R7/DoQgydLPCfUy3mddqrAVkzBAaG0GdzFAA==
X-Received: by 2002:a05:6214:2306:: with SMTP id gc6mr9233344qvb.34.1637692609740;
        Tue, 23 Nov 2021 10:36:49 -0800 (PST)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id d19sm6678916qtb.47.2021.11.23.10.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 10:36:49 -0800 (PST)
Subject: Re: [RFC] Branches with --recurse-submodules
To:     Glen Choo <chooglen@google.com>, git@vger.kernel.org
References: <kl6lv912uvjv.fsf@chooglen-macbookpro.roam.corp.google.com>
 <bb9c0094-8532-c463-47a2-442b225ad52e@gmail.com>
 <kl6lr1bhtf67.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <30f6ee13-8db7-e983-fb87-ef038a3487a2@gmail.com>
Date:   Tue, 23 Nov 2021 13:36:48 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <kl6lr1bhtf67.fsf@chooglen-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Glen,

Le 2021-11-15 à 14:03, Glen Choo a écrit :
> Thanks so much Philippe, your responses are very thoughtful.
> 
> Philippe Blain <levraiphilippeblain@gmail.com> writes:
> 
>>> * `git branch --recurse-submodules topic` should create the branch
>>>     `topic` in each of the repositories.
>>
>> I guess for some workflow this would be the good, but for others you might
>> not need to create submodule branches for each new superproject branch you
>> create.  I think I pointed that out before; I don't necessarily think that
>> creating branches in all submodules should *not* be the default behaviour,
>> but I think that it should be configurable. I mean that if I have 'submodule.recurse'
>> set to true, I would not like 'git branch topic' to create a 'topic' branch
>> in each submodule. So I wish I'll be able to add 'branch.recurseSubmodules = false'
>> to my config (or something similar) to have more granularity in behaviour.
> 
> Yes, as we discussed earlier, this behavior may not be desirable for
> different workflows. I've come to suspect that the branching behavior
> that I proposed should be the default, but I'm ambivalent on being able
> to opt out of the branching.
> 
> In favor of letting users opt out: I'd imagine that behavior might be
> disruptive to users who make frequent changes on the submodule and may
> not appreciate having two sets of branch names (one from the
> superproject and one from the submodule's remotes). I'm not clear on
> whether or not this is disruptive primarily because it is a breaking
> change, or if this just an objectively bad fit for what these users
> want.
> 
> In favor of not letting users opt out: exposing fewer switches to users
> makes it easier for them to get a good user experience. Instead of
> giving users the ability to build-your-own UX, maintaining a small
> configuration surface makes configuration easy and puts the onus back on
> Git (or me, really :P) to make sure that the UX really works well for
> all users, instead of opting out and saying "oh the user has
> branches.recurseSubmodules=false, so I'll choose not to support them".
> I think this stance is good from a product excellence perspective, but
> it's an obvious risk.
> 
> A way forward might be:
> 
> * mitigate the breaking changes by flagging this with
>    feature.experimental
> * test this behavior with real users (aka internal) and iterate from
>    there
> 
> Does that make sense? I'd like to make sure I'm not missing something
> very big here.

It does, but I think that we can still build a flexible product without
compromising UI/UX :)

> 
>> Also, I assume the new behaviour would carry over to 'git checkout -b' and
>> 'git switch -c' ?
>>> * `git switch --recurse-submodules topic` should checkout the branch
>>>     `topic` in each of the repositories
>>
>> Nit: I guess you also include 'git checkout --r topic' here also ?
> 
> Yes and yes (I believe --r refers to --recurse-submodules?).

Yes, and it works on the command-line ! ;) long options can be shortened
if unambiguous, see 'man gitcli'.
