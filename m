Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1862B1F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 20:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfHLU24 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 16:28:56 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:34284 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfHLU24 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 16:28:56 -0400
Received: by mail-wm1-f41.google.com with SMTP id e8so754827wme.1
        for <git@vger.kernel.org>; Mon, 12 Aug 2019 13:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xOv4KKKxeIYcbDh9nt/CmQg7pMgUrJfzd9sLQ50dHBU=;
        b=BtiwP+lg9CYGcd5GlcyDWFCLGcJHxpupGldqRdYx5IRb/ZHZGstoICDcL3q6uoY6UY
         KgUg2Gdzh8bwG+2KoRuQ4y2hHuj6ZdSYl0xS4MTDQ15i0fB1w3JNbZj9lOrt3xpWfCDR
         p30rH9aDQj3s5n8xjgHsi/+/i/CrMroJwHyZDxXfoEVJO2I5J95N26pK1TrGiuVzW1p2
         3/MoBbBHv250s/j8EpkPM+VmtF5leQ+zdhbMEztj6zeJh5p9LSxGLnPHwUMsPX0qmY4V
         qq+DVcpBUHaggSs9GLKjAdL7J1Dq0uYa5No1MSRLIq0GLVn2qDTzezz3E0gxghrKBimH
         GGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xOv4KKKxeIYcbDh9nt/CmQg7pMgUrJfzd9sLQ50dHBU=;
        b=mEMUu9EvoRDxh6t990P/5UYH/wqbGGaNEKA1mvVJPckna2N7Gk+1bfcSudGe+uX+TH
         MP0AvARiYPDK6p1JESLg5WE9ETutT9N3zOO2rwGhCbqYZC52bCsfGeFd6OXBLNq38D+x
         twjV7dUQHZwphOq+fL9bTOHpCbQqgQE+QcPjnXsIK4fJMfz+6Nixngcw9JDSLtKSGAc9
         FKsQMWVsh82xJHhYuILfU3C30p+Kpt11xXxRHmhysdjEooIYtEIyUBrQfx/zdsJ3+o5N
         9bUP/wk6/QjUoH9AYboeiOsGP+ZTTbPVsTipRh4APlg2dNiQjmrqOFr1QPv0dA79MeAH
         0HoQ==
X-Gm-Message-State: APjAAAVP2aYWigUH9GinIG9nztfQPr6cUw7h6LarK52BT8BqDnQH9h4m
        JacQDhFMKUQ2TLgSEjhfH2NJ0Q1o
X-Google-Smtp-Source: APXvYqxlbqtnJjdzowDyAZMY2QDZZPJYV6WWCbvuqBakth/906xUGJkJWb7rLoxdu+TiJ1W7wr3yhw==
X-Received: by 2002:a7b:c313:: with SMTP id k19mr967192wmj.2.1565641734270;
        Mon, 12 Aug 2019 13:28:54 -0700 (PDT)
Received: from [192.168.1.18] (host-78-148-43-8.as13285.net. [78.148.43.8])
        by smtp.gmail.com with ESMTPSA id k1sm13381632wru.49.2019.08.12.13.28.53
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 13:28:53 -0700 (PDT)
Subject: Re: minor interactive rebase regression: HEAD points to wrong commit
 while rewording
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
References: <20190812175046.GM20404@szeder.dev>
From:   Phillip Wood <phillip.wood123@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Message-ID: <2a7d69a9-cb3e-eb84-188f-5713876f6d78@gmail.com>
Date:   Mon, 12 Aug 2019 21:28:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812175046.GM20404@szeder.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-HK
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/08/2019 18:50, SZEDER Gábor wrote:
> 
> When running interactive rebase to reword a commit message, I would
> expect that the commit whose message I'm rewording is checked out.
> This is not quite the case when rewording multiple subsequent commit
> messages.
> 
> Let's start with four commits, and start an interactive rebase from
> the first commit:
> 
>    $ git log --oneline
>    5835aa1 (HEAD -> master) fourth
>    64ecc64 third
>    d5fad83 second
>    384b86f first
>    $ git rebase -i 384b86f
> 
> Update the instruction sheet to edit the log messages of two
> subsequent commits:
> 
>    r d5fad83 second
>    r 64ecc64 third
>    pick 5835aa1 fourth
> 
> Now, after the editor opens up the second commit's log message, start
> a new terminal and check where HEAD is pointing to:
> 
>    ~/tmp/reword (master|REBASE-i 1/3)$ head -n1 .git/COMMIT_EDITMSG
>    second
>    ~/tmp/reword (master|REBASE-i 1/3)$ git log --oneline -1
>    d5fad83 (HEAD) second
> 
> So far so good.

Because the sequencer can fast-forwarded to second from first it does 
that and then run 'commit --amend' to do the reword.

> Save the updated commit message, and after the editor opens up the
> third commit's log message, check again where HEAD is pointing to now:
> 
>    ~/tmp/reword (master +|REBASE-i 2/3)$ head -n1 .git/COMMIT_EDITMSG
>    third
>    ~/tmp/reword (master +|REBASE-i 2/3)$ git log --oneline -1
>    c3db735 (HEAD) second - updated

As second has been updated the sequencer cannot fast-forward to third so 
it cherry-picks third and then passes --edit when it runs 'git commit' 
to commit the cherry-pick. HEAD is updated once the reworded commit has 
been created.

I think the scripted rebase always ran cherry-pick and then ran 'commit 
--amend' afterwards if the commit was being reworded. The C 
implementation is more efficient as it avoids creating an redundant 
commit but has the side effect that HEAD is not updated before the 
reword which was surprising here.

I don't think I've ever looked at HEAD while rewording, my shell prompt 
gets the current pick from .git/rebase-merge/done so does not look at 
HEAD. While it might seem odd if the user looks at HEAD it's quite nice 
not to create a new commit only to amend it straight away when it's 
reworded. We have REBASE_HEAD which always points to the current pick - 
HEAD is also an unreliable indicator of the current pick if there are 
conflicts.

Best Wishes

Phillip

> As you can see, HEAD still points to the (now rewritten) second
> commit.
> 
> It's only HEAD, though: notice the '+' in the git prompt, indicating
> that both the worktree and index are dirty.  And indeed, they both
> already match the state of the currently reworded, i.e. third, commit:
> 
>    ~/tmp/reword (master +|REBASE-i 2/3)$ cat file
>    third
> 
> This is good, because even though HEAD has not been updated yet, it
> already allows users to take a look at the "big picture", i.e. actual
> file contents, in case the diff included in the commit message
> template doesn't show enough context.
> 
> This behavior changed in commit 18633e1a22 (rebase -i: use the
> rebase--helper builtin, 2017-02-09); prior to that HEAD pointed to the
> third commit while editing its log message.
> 
> It's important to reword subsequent commits.  When rewording multiple,
> but non subsequent commits (e.g. reword, pick, reword in the
> instruction sheet), then HEAD is pointing to the right commits during
> both rewords.
> 
> 
