Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC3A61F45F
	for <e@80x24.org>; Tue,  7 May 2019 10:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfEGKCE (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 06:02:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37967 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfEGKCE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 06:02:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id f2so14261403wmj.3
        for <git@vger.kernel.org>; Tue, 07 May 2019 03:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kA8onY7K4QMsPa/jyxwi1Ja+6G7xV+pbiBojRn2vqh4=;
        b=TwDxxkLK3qOrqtFednFkCNvkFQiw4+MXudt39hxl7rdex4+ZtEpXZPsFi+bOdcEL/M
         Qnpif7tKkEJKex8HJFykJVoW6LKW7Grz6LQ8E8lVXFk3X0SZEgga8vSPyrN4pjrdi7fv
         qs0INDH0gZSmecP5O/uBrA3Dp1LcX/zrZ+UaXiZ0qSxVbfRQ1bNxrHbBHMOEJdIoMGt0
         MET58SdGAeBNySktLfSg5ZcCLRbieAseUU+4czSt+L/zKU6H86M8DLDO5bwcP+fq6ef8
         hZhWfofZbxuyrkR66+AwlXd3aoMan2BcYyQ4/IdlybH+HeHXomZyqH4qu83bq9f9Yjb8
         9Gww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=kA8onY7K4QMsPa/jyxwi1Ja+6G7xV+pbiBojRn2vqh4=;
        b=WByAnHHpcGO+jIP+YMdV5gyy8fftafZpK0PY5D5jpGSUrnRA59rxf/ZdFW/O+PP5ak
         zYOu5F44wBzVC/tFrmf3iWa7W6mnjCJVhp5KEVyoxv9dgySqDWIpa8xSvgidOScPh3AU
         MAQXYgWIqS7jOuSxV2LpjRKO2XhWq7MbRvXxo0wTO6MF9Tm9wVX5kEtvYhgOhloX7QGO
         30JIhwJZu+E0KbKaIERApob/qZEo6H2UMDTOUcRvZsJoPc4JikRSiVxJ3UXdoPmIR+u6
         qQ0O6mws/Go8R+i0Bdp4A8d0pzsfuISXRl7i5BW6mu0qL0UHPJzFFSskTjfICsuQXv6S
         XZDw==
X-Gm-Message-State: APjAAAUQzyKxEXR4aWKUBEYpba07XAIFrlaOoqe9nT1AyWZ4YI5RwbXB
        XFjxO/YIwFnC36FyD0qsdEjokvER
X-Google-Smtp-Source: APXvYqyzroqqyymgSS/XSErhdxsr6FmT44qJRVNYymLQRPyVWEzueugdaz6jmUunSeOnJ+GFzPJkDQ==
X-Received: by 2002:a1c:f310:: with SMTP id q16mr21259648wmq.102.1557223321807;
        Tue, 07 May 2019 03:02:01 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id y3sm4302186wrh.90.2019.05.07.03.02.00
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 03:02:01 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/2] read-tree: improve untracked file support
To:     Duy Nguyen <pclouds@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <20190501101403.20294-1-phillip.wood123@gmail.com>
 <CACsJy8CNUEBXmBcQnRHqdeFJtTvBuZ9thP7QPAw-ZOD+2ty3VA@mail.gmail.com>
 <d4c36a24-b40c-a6ca-7a05-572ab93a0101@gmail.com>
 <CACsJy8AAj8cRAc+PnS4OJy8M=K7FjCHUsL6Cx-6+RTAbTA_1fQ@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <994d4687-39ed-91b9-cdf9-d4be39cbb2ba@gmail.com>
Date:   Tue, 7 May 2019 11:01:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8AAj8cRAc+PnS4OJy8M=K7FjCHUsL6Cx-6+RTAbTA_1fQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/05/2019 11:53, Duy Nguyen wrote:
> On Wed, May 1, 2019 at 9:58 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>> On 01/05/2019 11:31, Duy Nguyen wrote:
>>> On Wed, May 1, 2019 at 5:14 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>>>
>>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>>
>>>> These two patches teach read-tree how to avoid overwriting untracked
>>>> files when doing '--reset -u' and also how to respect all of git's
>>>> standard excludes files. I'd like to see the porcelain commands stop
>>>> overwriting untracked files, this is a first step on the way. I'm not
>>>> sure if we want to add options to the porcelain commands to protect
>>>> untracked files or just change their behavior and add an option to
>>>> override that. I'm leaning towards the latter but I'd be interested to
>>>> hear what others think.
>>>
>>> For new commands like git-restore, it's definitely a good thing to not
>>> overwrite untracked files.
>>
>> I agree, unfortunately this series does not help with git-restore, only
>> git-switch. For restore on an index without conflicts I think it could
>> just use the pathspec in struct unpack_trees_options and set opts.rest =
>> UNPACK_RESET_PROTECT_UNTRACKED but that does not help if we want to
>> handle conflicted paths differently to non-conflicted paths.
> 
> Right. I got confused. You did mention "git checkout <rev> :/" in 1/2,
> which is the same as "git restore --source <rev> --staged --worktree
> :/" and  can also potentially overwrite untracked files, even though
> it does not use unpack-trees and cannot be fixed with this. Never
> mind. Let's leave git-restore out of the discussion for now.
> 
>>> For existing commands I guess we have to go
>>> over them one by one. For "git reset --hard", it should really just
>>> overwrite whatever needed to get back to the known good state. "git
>>> checkout -f" , not so sure (seems weird that we need force-level-two
>>> option to override the protection provided by -f, if we change default
>>> behavior)
>>
>> I think it's fine for "checkout -f" to overwrite untracked files (and if
>> "switch --discard-changes" does not then there is no pressing need to
>> add such a mode to checkout), --force is a good name for an option that
>> nukes everything that gets in it's way. For "reset --hard" I'm not so
>> sure, if I have changes to an untracked file I don't wont them
>> overwritten by default. There is no porcelain equivalent to "read-tree
>> --reset --protect-untracked -u" and I was hoping "reset --hard" may
>> become that porcelain equivalent with a new --force or
>> --overwrite-untracked option.
> 
> My (biased, obviously) view is that "git reset --hard" is very
> dangerous and I'm not trying to change that, especially when its
> behavior has been like this since forever and I'm sure it's used in
> scripts.
> 
> Instead "git restore" should be used when you need "git reset --hard
> HEAD", the most often use case. And since it's new, changing default
> behavior is not a problem. Which brings us back to git-restore :)

Does restore clean up the branch state like reset? It's tricky because 
you only want to do that if there is no pathspec (or the pathspec is :/ 
or equivalent - I can't remember if restore always requires paths or not)

> But either way, git-restore or git-reset, I still don't see why
> untracked files are more valuable in this case than tracked ones to
> change the default. 

My issue is that is easy to see what changes you're going to lose in 
tracked files by running diff. For untracked files diff just says a new 
file will be created, it ignores the current contents as the path is in 
the index so it is easy to overwrite changes without realizing. There's 
also a philosophical point that git should not be stomping on paths that 
it is not tracking though that's a bit moot if a path is tracked in one 
revision but not another.

> I can see that sometimes you may want to restore
> just tracked files, or untracked files, almost like filtering with
> pathspec.
> 
>> For the various "foo --abort" some (most?) are using "reset --merge"
>> which I think declines to overwrite untracked files but rebase uses
>> "reset --hard" which I'd like to change to protect untracked files in
>> the same way that rebase does for the initial checkout and when picking
>> commits. I haven't thought about stash.
> 
> Yeah it looks like cherry-pick and revert use "reset --merge" too
> (reset_for_rollback function). That's all of them. Probably a stupid
> question, why can't rebase just use "rebase --merge" like everybody
> else?

I'm not sure - if --merge works for the others I can't see why it 
shouldn't work for rebase as well.

Best Wishes

Phillip
>> Best Wishes
>>
>> Phillip
>>
> 
> 
