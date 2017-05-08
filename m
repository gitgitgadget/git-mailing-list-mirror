Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3B7520188
	for <e@80x24.org>; Mon,  8 May 2017 03:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751522AbdEHDFg (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 May 2017 23:05:36 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34412 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751250AbdEHDFf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2017 23:05:35 -0400
Received: by mail-pf0-f195.google.com with SMTP id w69so2284450pfk.1
        for <git@vger.kernel.org>; Sun, 07 May 2017 20:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vAwzdTz+vLzi4dZN9Xji4df23oOvtgYn36LGEEIy+C4=;
        b=EINtfYaRy0uYP8HXmmKn/16WCA8oRPijBh+QPTh28YV/OORG4dRxNOV+s+bCc7q029
         tHbUXI4VDKQs0VoJMpJP2RLn/BPpS9h+I8LqLLqw278N9k3y5MDGQeY8XTqHO7ZaoFWG
         gwUsgXMPcXKv8eDHPMa+ScQFVlKs6/kZ2wNqlaKVfh97owys68BrFQDS7YYhyFEYhVMz
         PDGHfADCMkJtqfwbZlFAwDA3G+pFUWb8kRJ6LMi8nSvb3Z14wsomRWp9UPJePxQHha1Y
         F/kBt7txiBdVIPfPe0uTuDeDQTvmA32+ukm3GhVOIWhRS3ytrjED+l0oyETEop9ks8df
         FuzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vAwzdTz+vLzi4dZN9Xji4df23oOvtgYn36LGEEIy+C4=;
        b=TZz1iFE9fOE47l5gHJwGvRMyN0sNtfs2+sY4ZvyB+5BNPx+ZPPcEAAxBRnCx4MFKE8
         R5UvMuH4x2YDeOpEzmVnLZzuVaeSFu9qQ3gC41ALPWK8OQaOm2YelucTJLjnWKRc/SuC
         3TgDfe7EHWADkJYL11UR2Efnk4TxAmViViBvRoGUB1v/Vf7hxZJ7AreZ5aLMVQ/8+5XQ
         B5Bx2z7KgvODKUGaj7ibqnOnx9VyHyzZ6kO0hA+buP2dgETk3X28I7uPeYc34NR1q6QM
         lZhbqnXQz4qYAAO2JYc0dyf62cVg5vhK/u8S9Dnq3TOe7bxUlz1RdoPzpL4w7vWnb+Ln
         FjWQ==
X-Gm-Message-State: AN3rC/47LQrkGLy1ttktouclzECFuiZ7afzsx4ySmwWuyzodbxlQSLEn
        V7uYN7RSVphKNQ==
X-Received: by 10.84.232.141 with SMTP id i13mr51510513plk.143.1494212734978;
        Sun, 07 May 2017 20:05:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3011:642f:81a0:efbd])
        by smtp.gmail.com with ESMTPSA id g66sm19833679pfj.11.2017.05.07.20.05.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 07 May 2017 20:05:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yubin Ruan <ablacktshirt@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] Add warning when git discard changes on another branch?
References: <20170507233512.GA9332@HP>
Date:   Mon, 08 May 2017 12:05:31 +0900
In-Reply-To: <20170507233512.GA9332@HP> (Yubin Ruan's message of "Mon, 8 May
        2017 07:35:14 +0800")
Message-ID: <xmqqzieo9hfo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yubin Ruan <ablacktshirt@gmail.com> writes:

> I think it would be better if git can warn use if we switch to another branch
> without committing the modification. Git will warn if the modification is based
> on a commit different from where the checkout happened.
>
> For example, say I am now on branch 'master' and all files *clean*. Now if I do:
>     $ git checkout -b issue
> and make some changes to a file:
>     $ echo "modification on branch issue" >> lala.txt
> and then switch back to branch 'master':
>     $ git checkout master
> and git can see the changes:
>     $ git status
>       On branch master
>       Changes not staged for commit:
>         (use "git add <file>..." to update what will be committed)
>         (use "git checkout -- <file>..." to discard changes in working directory)
>       
>       	modified:   lala.txt
>       
>       no changes added to commit (use "git add" and/or "git commit -a")
>       
> Now, if I do "git checkout -- lala.txt", then I will lose that change on branch
> 'issue' too!!! 

There may be a fundamental misunderstanding here.  In Git, changes
you make in the working tree do *not* belong to any branch.  The
request "git checkout -- lala.txt" you made in this step does *not*
say "Hey, Git, these changes to lala.txt are not necessary in the
'master' branch".  It says "I started editing lala.txt, but it turns
out that I do not need that change at all, anywhere, please remove
it."

If you meant the changes while you were on "issues" branch were not
yet ready to be committed, but now you want to work on "master"
branch without having to worry about these changes, "git stash" may
be a useful tool.  Alternatively, you can just create a temporary
commit while on "issues" branch before checking out "master" branch
to work on something else, and when you are ready to continue
working on the "issues" branch, check out "issues" branch and either
(1) start with "reset HEAD^" or (2) just continue working on it and
conclude with "commit --amend".

