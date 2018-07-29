Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4000208EB
	for <e@80x24.org>; Sun, 29 Jul 2018 21:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731852AbeG2XFY (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jul 2018 19:05:24 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44019 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731776AbeG2XFX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jul 2018 19:05:23 -0400
Received: by mail-wr1-f65.google.com with SMTP id b15-v6so10630036wrv.10
        for <git@vger.kernel.org>; Sun, 29 Jul 2018 14:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NAOi7PPQdhfa31kDAyTfcKQp26w/ie91YACV3FBhIT8=;
        b=SQQ6QebtJU0YXFndpb/1bXFLjo+c0LJHxO5/UcfzOHl6dcLcs6lLzv/37RK6+kIS2f
         LawiAskwEK4OWrNEzDzV+NmPh4cDJVe9rM12Wkn88CB1/74h0kpkDDlD3VBS04xwaNLk
         Txvyx6vZOpqaeg6Q2ZKdKc4LiInO3uoUMj50DbfatrJgklP7Uqu4RnC3EDsOt6PImEbc
         XACUBMhLu9b/8fOwpb9rvAyERfsoaiG0jw9LEeejrKdnmo2zunm7n2n8/M+34mbmGA8y
         JbA8Ci6lEedakCxAUfmx/0Q1cumPDqAPO04FMD9hgYqXSl1crbkiP/oMei/p7x59Vm+8
         jLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NAOi7PPQdhfa31kDAyTfcKQp26w/ie91YACV3FBhIT8=;
        b=Y/MoHOc/ajsVGcnzn+1/rhUIX4uVQU3T/9ELJUd+jchrVMP41ECi+5ZhEUzapNDGMu
         zHpgvCcoLmt74pJEzfdlyfhZ+M6kZaLPTUZVAfGIGlpvgtcLEexG75nT42Ici5+ugwyg
         qFEydzjOUNvGMpW+ukxibzbDwIUrAmntMlTCQXjxJSGf40jrNuQb2mLBd8AzrIryqeVI
         pTKmHhwAo03XFIzxiuF/02OI7pjwGa9IYgZCI3BJl9WZRejCVYU0TtvKJ8/hDvn3G1nu
         lvoY0MQvcdprx3QV8UQCylRpqvWPC5LLDbh8cn3+cXeiCCJOplymteXMX+pevidUf0yW
         etNA==
X-Gm-Message-State: AOUpUlH+s2nYRnPh6Q6mSnaQZLf/rZWMe+DTqxf8xzdMgV1vf9OX9IDB
        xb/SSLdy+bBD17mjWzgDSh1NJvPp
X-Google-Smtp-Source: AAOMgpf+1OFKhO8fjxyuZSw+WYm0gutVg+RSA1hPv1yunugS+BLqC1/5vwBzNzqv5nhGs6otKJS5Kw==
X-Received: by 2002:adf:9465:: with SMTP id 92-v6mr15814216wrq.283.1532900007107;
        Sun, 29 Jul 2018 14:33:27 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id d7-v6sm11317548wro.92.2018.07.29.14.33.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Jul 2018 14:33:26 -0700 (PDT)
Date:   Sun, 29 Jul 2018 22:33:25 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 20/21] range-diff: make --dual-color the default mode
Message-ID: <20180729213325.GC9955@hank.intra.tgummerer.com>
References: <pull.1.v3.git.gitgitgadget@gmail.com>
 <pull.1.v4.git.gitgitgadget@gmail.com>
 <b370468e71af2b8c7ffa0e31f3a3910d15897ab4.1532210683.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b370468e71af2b8c7ffa0e31f3a3910d15897ab4.1532210683.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/21, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> After using this command extensively for the last two months, this
> developer came to the conclusion that even if the dual color mode still
> leaves a lot of room for confusion about what was actually changed, the
> non-dual color mode is substantially worse in that regard.
> 
> Therefore, we really want to make the dual color mode the default.

Ah and here we're making it default, so I wouldn't need a
`rangeDiff.dualColor` config variable anymore.  Even better!

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  Documentation/git-range-diff.txt       | 32 +++++++++++++++-----------
>  builtin/range-diff.c                   | 10 ++++----
>  contrib/completion/git-completion.bash |  2 +-
>  3 files changed, 25 insertions(+), 19 deletions(-)
> 
> [...]
