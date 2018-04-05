Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45D111F404
	for <e@80x24.org>; Thu,  5 Apr 2018 23:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751362AbeDEXer (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 19:34:47 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:38075 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbeDEXeq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 19:34:46 -0400
Received: by mail-it0-f66.google.com with SMTP id 19-v6so6421571itw.3
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 16:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OHQO/yySVNGjq83LsbOv5ilMQeZ/HSwSP2WF+AxEaTE=;
        b=wpi/IVOQDpKG3dKzSZn615vH5IX+9qJj7MbbYQhM/MT9/4b1pnI5mL/7eF7lmFlXMG
         w94HlXmUCO0zTwzlis9/5y0Zyb5O1iXzOtf3lGBxrdIEmahIqLmkAWJoNNQO++znSdtg
         IPlKWfDJwex/a2uJx8XzIznpgBhknEQNT3dJKuFM16Ls/W5nZYAtP1DM1V2xU4U99Qch
         ETRCRxfvJ+c1Lq3QqZ7SHhyURNQheLGrI+kc6m9/7jJM5TG4yDmGZ8VH/SRLNZ28aeVI
         QotOO91px09d56svAFwnKy3oPLAY/NY6V1aOV8QfkQIoP18TBu6j4YwoUNs4B5mT5bOk
         dsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OHQO/yySVNGjq83LsbOv5ilMQeZ/HSwSP2WF+AxEaTE=;
        b=My8q9gn8/Fo7EtN41RPjhLRyvxMKX2gI5S2Ievbiqdl3v9zotVCQQJaFm1fA7IMEOL
         +Bg0wmeLv/Fw5FE1TR5FI6jXHQB9LJb1qL/CEnvek8KLTv1oxFPllrEJnhAXc6eYvw16
         EWs0g56MxsfbmpsO1ctGSLrnHTYf0hj+TCiVNJ7L10LKZ/mAzUNU1ZWEij6srkXbDcsf
         JV5Fz9b2Vfy2ktmU/VAR6wS+WLI8v1Yin7inqMHC9CBv9CiTu7czE4lBfb5y2u3y8Vdj
         KqK2q4/KhbK+RT9dgViWGOlX1ajA/GqN+bTkg7pf/JqNQRSimZysrbLP8VQquHeBzSc6
         CAmA==
X-Gm-Message-State: AElRT7F5OmXsUeAV4L4tmu66405WALlg42PmJT2zSYnB/j345ts8PujV
        2h3U8sA2eIAoE7/erCobwx0l0c6J5wNVNByfXoo4yg==
X-Google-Smtp-Source: AIpwx4//B4s8YBF76yQlLvqZJZIxWWxvoPlRFdXhJMGxHh9xOE6oq0bCz/BSBZL+qnxAfKAmhD0d5zYb8WB+f2Jnyn0=
X-Received: by 2002:a24:624b:: with SMTP id d72-v6mr16752562itc.70.1522971285633;
 Thu, 05 Apr 2018 16:34:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.97.20 with HTTP; Thu, 5 Apr 2018 16:34:45 -0700 (PDT)
In-Reply-To: <CAGyf7-E9=Mm1oJdhwHTmg2byrOxMRFVEjmYHCFGqqP8pvK=vJg@mail.gmail.com>
References: <5AC67C43.9080500@connotech.com> <CAGyf7-E9=Mm1oJdhwHTmg2byrOxMRFVEjmYHCFGqqP8pvK=vJg@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Thu, 5 Apr 2018 16:34:45 -0700
Message-ID: <CAGyf7-GZgTpYXt4s+NURABYLBr8HQAZWxsrpLLVKnsOf2SYcBQ@mail.gmail.com>
Subject: Re: Self-inflicted "abort" in a newbie attempt at read-only
 exploration of a cloned repository?
To:     Thierry Moreau <thierry.moreau@connotech.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 5, 2018 at 4:18 PM, Bryan Turner <bturner@atlassian.com> wrote:
> On Thu, Apr 5, 2018 at 12:42 PM, Thierry Moreau
> <thierry.moreau@connotech.com> wrote:
>> Dear GIT enthusiasts!
>>
>> This ends up with a "git checkout" command aborting. A bit frustrating at
>> the early stage of GIT learning curve.
>>
>> My first goal is to clone repositories locally in order to explore the
>> various linux kernel versions, with the rich GIT metadata.
>>
>> Thus, I clone:
>>
>> $  git clone --branch linux-4.16.y
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
>> linux-stable
>> $  git -C linux-stable/ branch
>> * linux-4.16.y
>>
>> So far so good. Then, I want to extract an earlier kernel version into a tmp
>> dir:
>>
>> $  mkdir tmp
>> $  git -C linux-stable/ --work-tree $PWD/tmp/ checkout linux-4.15.y
>> $  git -C linux-stable/ branch
>> * linux-4.15.y
>>   linux-4.16.y
>
> The documentation for --work-tree says:
>
> --work-tree=<path>
>
> Set the path to the working tree. It can be an absolute path or a path
> relative to the current working directory. This can also be controlled
> by setting the GIT_WORK_TREE environment variable and the
> core.worktree configuration variable (see core.worktree in
> git-config(1) for a more detailed discussion).
>
> So passing --work-tree tells Git where to store your _files_, but it's
> still using the same .git directory.
>
> If your goal is to have worktrees for various versions, that implies
> the git worktree [1] command might be more along the lines of what
> you're looking for. An invocation based on above might look like this:
> $ git -C linux-stable/ worktree add $PWD/tmp/ checkout linux-4.15.y

Apologies, I didn't mean to have the "checkout" in that.
$ git -C linux-stable/ worktree add $PWD/tmp/ linux-4.15.y

>
> That should leave linux-4.16.y checked out in linux-stable, while
> creating a full work tree in $PWD/tmp that has 4.15.y checked out.
>
> Note that worktree is a newer git command. 2.17 has it, but old
> versions like 2.1 won't.
>
> [1] https://git-scm.com/docs/git-worktree
>
> Hope this helps!
> Bryan
