Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DA1D1F404
	for <e@80x24.org>; Wed, 24 Jan 2018 18:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965109AbeAXSyi (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 13:54:38 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:46809 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964999AbeAXSye (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 13:54:34 -0500
Received: by mail-wm0-f47.google.com with SMTP id 143so10294314wma.5
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 10:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=6pwCPA9IGV6viHQzYwoAigXYxe8FZolJWck2CAPRcpk=;
        b=OKGZ2dOBCtXxJ3aV5PDE3KyWzqxtxQS5p6Vj8GZbdkSGynKGeuF3hJyjqfG4iP+5Rb
         +JwMc1QupNTiNe4UrXtXb69vnrHdcUVE1MPVfxF5We8YO70hw6euFGq0dMmmH+RQW1dK
         etGvq2N7O5x1naMSK7UqYegMMLGo9Mljg0YrQX/hpFZ/oyq1NjuRgQKGMshX4AKyKgmP
         8WeuiGMfeUN6WrWa6TcZNTre1NKmAZK/Bh9xipq1d4bTulXgjTz4Doa9PCe8FXEQ11Zj
         rnZfizGYObt/fdhSC7oY/8d0wH23AtVlGDFv+WJaU5mJcn79j9oo0Tgwd2myvAs3zqOU
         b5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6pwCPA9IGV6viHQzYwoAigXYxe8FZolJWck2CAPRcpk=;
        b=MsIq0j3qvp83tEowSdlTzW+Mz8noHnHkfr//HDhr2pqR1UbQPuTU2UbATColUbG0HN
         Ll5ysh1OAXUgfk4B4OnzsSZz/py/IhK/qT5HRoMaA8ejRYvLghcnxn15ZC0bFCFokvID
         hw2kYu3E+7OqG9Ez6xQr0j/ZZFVyaqWEmpEfHDmLeLpy1nKB0MncQJy92nB1JMJqQKxm
         NMg6ajrv6EFu3jGRlnXZO9L43kJVEzCY7qdmLZTI+/xO/iAzgv4/8Z3HNdNSF9zUytfO
         cdxwqztVqzQEiWnAMz84MMVR9DWGbO/rC6PP6tCy0crlNAi0CtXlJaT2+SbJgy2NF0o7
         15Tw==
X-Gm-Message-State: AKwxyteiFkOc469hOL2W8xbpZVN8QnQWz0lS6FqzZuoX+wgqidTNsm/i
        XxuUQU0Ihbdv3vnUFSkg8rq/MLVD
X-Google-Smtp-Source: AH8x224C0ZNxwH0gcqQSh4HvrJ3gkDBOMNaucvZkyFAhif+Ae6D11hmgzcfTLUgjhOymrv/X7p0jDQ==
X-Received: by 10.28.245.25 with SMTP id t25mr5229963wmh.77.1516820072416;
        Wed, 24 Jan 2018 10:54:32 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id q195sm1013572wmb.33.2018.01.24.10.54.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jan 2018 10:54:31 -0800 (PST)
Subject: Re: [BUG] git pull with pull.rebase and rebase.autoStash is not
 working anymore in 2.16
To:     Dimitriy <dimitriy.ryazantcev@gmail.com>, git@vger.kernel.org
References: <CAPUT4mS+p+2n85dB-iWtae+0SDkUoYA5bqtUs+6OaFchjJJeuA@mail.gmail.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <25ce5341-1200-c54c-eb69-eccfcc088155@gmail.com>
Date:   Wed, 24 Jan 2018 19:54:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAPUT4mS+p+2n85dB-iWtae+0SDkUoYA5bqtUs+6OaFchjJJeuA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dimitriy,

On 24/01/2018 13:19, Dimitriy wrote:
> 
> Looks like regression in 2.16.
> Worked fine before update.
> Seems like git stash is not always working.
> Any ideas?

Could this be the same one as reported as Git for Windows issue 
#1437[1] ("`git status` reports (non-existent) modifications after 
`git stash push`", 2018-01-20), fixed in Git for Windows v2.16.1...?

Care to try it out? :)

Regards, Buga

[1] https://github.com/git-for-windows/git/issues/1437

> $ git --version
> git version 2.16.0.windows.2
> 
> $ git config pull.rebase
> true
> 
> $ git config rebase.autoStash
> true
> 
> $ git status
> On branch develop
> Your branch is behind 'origin/develop' by 3 commits, and can be fast-forwarded.
>   (use "git pull" to update your local branch)
> 
> Changes not staged for commit:
>   (use "git add <file>..." to update what will be committed)
>   (use "git checkout -- <file>..." to discard changes in working directory)
> 
>         modified:   source_work/xxxxx.cpp
> 
> no changes added to commit (use "git add" and/or "git commit -a")
> 
> $ git pull
> Created autostash: 7ddcdf2ba
> HEAD is now at ba14a4c3f some commit
> Cannot rebase: You have unstaged changes.
> Please commit or stash them.
> 
> $ git status
> On branch develop
> Your branch is behind 'origin/develop' by 3 commits, and can be fast-forwarded.
>   (use "git pull" to update your local branch)
> 
> You are currently rebasing.
>   (all conflicts fixed: run "git rebase --continue")
> 
> Changes not staged for commit:
>   (use "git add <file>..." to update what will be committed)
>   (use "git checkout -- <file>..." to discard changes in working directory)
> 
>         modified:   source_work/xxxxx.cpp
> 
> no changes added to commit (use "git add" and/or "git commit -a")
> 
> $ git rebase --abort
> Applied autostash.
> 
> $ git stash
> Saved working directory and index state WIP on develop: ba14a4c3f  some commit
> 
> $ git status
> On branch develop
> Your branch is behind 'origin/develop' by 3 commits, and can be fast-forwarded.
>   (use "git pull" to update your local branch)
> 
> Changes not staged for commit:
>   (use "git add <file>..." to update what will be committed)
>   (use "git checkout -- <file>..." to discard changes in working directory)
> 
> 
>         modified:   source_work/xxxxx.cpp
> 
> no changes added to commit (use "git add" and/or "git commit -a")
> 
> $ git stash
> Saved working directory and index state WIP on develop: ba14a4c3f  some commit
> 
> $ git status
> On branch develop
> Your branch is behind 'origin/develop' by 3 commits, and can be fast-forwarded.
>   (use "git pull" to update your local branch)
> 
> nothing to commit, working tree clean
