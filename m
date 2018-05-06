Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9A97200B9
	for <e@80x24.org>; Sun,  6 May 2018 05:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750961AbeEFFR0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 01:17:26 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:41637 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750824AbeEFFRZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 01:17:25 -0400
Received: by mail-wr0-f181.google.com with SMTP id g21-v6so24680133wrb.8
        for <git@vger.kernel.org>; Sat, 05 May 2018 22:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xWLWyP8yPwGtYFlE0zTVKmQoT5yt7TYTA7NL8nP+O6Q=;
        b=PE2Ys/gkBb6qSQaKke37OESqugsANYyD2kuZHu71wuHVQUdBVGQskAR9UNZVbwX4PC
         ec8vD4+iuUtXIHK6azMZ4kNgi1/3OHvxQ18Ak/uRfoLcxMb2U66Z68/7hr6FXjIBy9oZ
         IyS3oLoz9MWo027DG1lBxmYQkIfskW+vzzPoSlpP3nb6vUBemjZEDNWWrjXusiAjQRfi
         HSfy+vedDOXh3CQG4tmuLPvm78cT2zLITxNWXoqlSYYc+FBpgHng+fvsPZuki4Q8Hg5Y
         1AtVjaCWlgj/ghvNPGbKIZbza/dJsQ23S1oHhwv6rh0wzQTkysQpGgMV6hSmW7r1z5EG
         CxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xWLWyP8yPwGtYFlE0zTVKmQoT5yt7TYTA7NL8nP+O6Q=;
        b=nb4JqfshAfoR44Se507X1CH9tGAV3qLJx7CO08/xe4hezq6P8zC42N6/Aa7ELvFIH1
         tZKLmLhJlmZkXS+n2kkUvgHaTMlodCzDum+2dZfZOywbxGnMRwVRrahcj0sRPjFb3iW+
         OAdenXyVMzcWwhF0mK2UI4wKVIDewWMgIB8lc6+4IxmHh5uVUEFPZwDLvxU9c/oKAr/j
         a5jv3b4Tw8yZVvnsdkGkfO//L3ZS7oEfbKESazI6yNEAvbnkQzJTYAGLAJiIAgaBSfPm
         /H7l7+zDQ43KjN6OTMTB1+ROHTz59kdT+hZl+Dbz3L+sQLDI+DJ3jirGQqiYNbHP8idj
         ISZQ==
X-Gm-Message-State: ALQs6tDb9PPKqVg0SoHvcAoPean+SwTnnnEsc+/RjkqxqO5dn/xqHKZk
        ADf0a7GXeXXQkJ/n8AzEftxvkPtNnq47MuLL63FaeA==
X-Google-Smtp-Source: AB8JxZqBzsWKqRw7cM6CBVcH7wuLZua6YXkmxm2aVy4++RUkmKJxgWR+MsgXrI8BhVJ8S5d4t6Y/U3IoDKB4q43+nrk=
X-Received: by 2002:adf:b0c1:: with SMTP id j1-v6mr23966733wra.3.1525583844139;
 Sat, 05 May 2018 22:17:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.152.138 with HTTP; Sat, 5 May 2018 22:17:03 -0700 (PDT)
In-Reply-To: <xmqqd0y9sdei.fsf@gitster-ct.c.googlers.com>
References: <CAFU8umjvEATZguGDmcRMcfAkqn4LW7vf_B9qpLD7uc-E_7qR9g@mail.gmail.com>
 <xmqqd0y9sdei.fsf@gitster-ct.c.googlers.com>
From:   Ilya Kantor <iliakan@gmail.com>
Date:   Sun, 6 May 2018 08:17:03 +0300
Message-ID: <CAFU8umjw-gz1UGHwiopHRJ-+v+KS2USqXV-9Qs0ieW8GaLpUsA@mail.gmail.com>
Subject: Re: cherry-pick --no-commit does not work well with --continue in
 case of conflicts
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's say master..feature has 2 commits: A and B.

Then `git cherry-pick -n master..feature` should pick-up A and then B
into the working directory and the index.

If applying A leads to a conflict, then it stops on A, like here:
>>> git cherry-pick -n master..feature
>> error: could not apply 2c11f12... Run work

Then I add the fix to the index, and should be able to continue on (B
is yet unpicked):

>>> git add .
>>> git cherry-pick --continue
>> error: your local changes would be overwritten by cherry-pick.
>> fatal: cherry-pick failed

Now it fails.
Expected behavior: should continue with picking B.

P.S. I assume, `cherry-pick -n <commits>` is meant to merge given
commits' changes into the current working directory and the index,
without making new commits, for any given set of commits, hope that's right?

Then we should be able to --continue in case of a conflict without committing.
