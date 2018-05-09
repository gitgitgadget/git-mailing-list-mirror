Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 395B01F424
	for <e@80x24.org>; Wed,  9 May 2018 16:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965055AbeEIQCi (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 12:02:38 -0400
Received: from mail-ot0-f175.google.com ([74.125.82.175]:40907 "EHLO
        mail-ot0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935419AbeEIQCh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 12:02:37 -0400
Received: by mail-ot0-f175.google.com with SMTP id n1-v6so40741784otf.7
        for <git@vger.kernel.org>; Wed, 09 May 2018 09:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PGFPX4gYl6cvbhxiuHx6FERpFrBTov3iuesUvleLVJc=;
        b=Q9b2FV1hbMQyqDcOcUzjIpFQ1nnWx2FJg5xIgtuxMWpuTW19xtfSG9a8RvVXbo4guv
         KYfOpQkmK38muHwzCfQMWdDfYrkxa8bTadH0z6pzSJFutoU8OjHvROLcC9sLd2SYL4Ji
         ErnH+ByAIhbPPPpGa9X2C1LYHgJHDE16UEVRXuk8r2QOpS6wRjrcxut6/0JDl/lLxuW7
         8c+JyuSO1VeEyFD0J2K6HCwXMFDlE25KLpwtxuXi9rVqc8dAzmcpid84+WpQLyCZgnmt
         bNpUpvBuHETPn0ZBBu/hgACqykcazpxuc+6673hfXF3Vzx9qkHyp6DzaOrEjrYkArJ30
         aJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PGFPX4gYl6cvbhxiuHx6FERpFrBTov3iuesUvleLVJc=;
        b=bz0gA7eh3Vp19pR96mklnx396RPoHaAO9S3CUAxSJK/eKYozh4VEs/3IzxTQEhpmE2
         GafFkvy8Rc4/EhHDJL37CHid3hjDancDzthG9tgz/6TImgUBHYMD1YcznxCjpI0Ym7w6
         oLOIyazUXepaxZjxvRYfy7ky0ByUALcZi8GNNBPCA97SXyupnjoacsLW2O1xerysGMe4
         0o0lPfbl6RX68KrmQNpBPlkhShIR/gabg4pPyy8AAptuhQxkQbZb/TjnL6b+6Ieg3hmU
         2MwaktJSJbPiTcDh5pJwrKWgtgTnA1yYXZAJSNipguty+NL3PkSjFFZ8Ht1PJubLgzlJ
         1xCg==
X-Gm-Message-State: ALQs6tAHMxN+w7IXxi3qvT5Didv1KKIZVgyJySuNbX0/albyYuKmrn3Y
        OESkISVKXQPgF3Q5dOV5hH9urGLLuAoLubXhKG8=
X-Google-Smtp-Source: AB8JxZq+FtjSJVxIJn/5DEKE2zHUpM0R9HyJcdX+Eh4zUBQs9dr70ASuK3kmLTeOtecyNe9QVjEkN/KDjI0fIvGYCqg=
X-Received: by 2002:a9d:49ad:: with SMTP id g45-v6mr14050935otf.65.1525881755356;
 Wed, 09 May 2018 09:02:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Wed, 9 May 2018 09:02:04 -0700 (PDT)
In-Reply-To: <20180509141523.89896-1-dstolee@microsoft.com>
References: <20180509141523.89896-1-dstolee@microsoft.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 9 May 2018 18:02:04 +0200
Message-ID: <CACsJy8CLF=sjJTw3ut1q9R3=qASwaDrm_dQGQfGDWar2LMwSkQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] Fix UX issue with commit-graph.lock
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "stolee@gmail.com" <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 9, 2018 at 4:15 PM, Derrick Stolee <dstolee@microsoft.com> wrote:
> We use the lockfile API to avoid multiple Git processes from writing to
> the commit-graph file in the .git/objects/info directory. In some cases,
> this directory may not exist, so we check for its existence.
>
> The existing code does the following when acquiring the lock:
>
> 1. Try to acquire the lock.
> 2. If it fails, try to create the .git/object/info directory.
> 3. Try to acquire the lock, failing if necessary.
>
> The problem is that if the lockfile exists, then the mkdir fails, giving
> an error that doesn't help the user:
>
>   "fatal: cannot mkdir .git/objects/info: File exists"
>
> While technically this honors the lockfile, it does not help the user.
>
> Instead, do the following:
>
> 1. Check for existence of .git/objects/info; create if necessary.
> 2. Try to acquire the lock, failing if necessary.
>
> The new output looks like:
>
>   fatal: Unable to create '/home/stolee/git/.git/objects/info/commit-graph.lock': File exists.
>
>   Another git process seems to be running in this repository, e.g.
>   an editor opened by 'git commit'. Please make sure all processes
>   are terminated then try again. If it still fails, a git process
>   may have crashed in this repository earlier:
>   remove the file manually to continue.

This to me is a much better description than the current commit
message in 1/1 and probably should be the commit message of 1/1.
-- 
Duy
