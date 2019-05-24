Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF6DD1F462
	for <e@80x24.org>; Fri, 24 May 2019 18:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391372AbfEXSt2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 14:49:28 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:38288 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390929AbfEXSt1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 14:49:27 -0400
Received: by mail-wm1-f53.google.com with SMTP id t5so10181367wmh.3
        for <git@vger.kernel.org>; Fri, 24 May 2019 11:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/fLeie0V63G1HFf6jFyTHRq/Bf8/Ax25oLymDlttN8w=;
        b=Hy7B48ee+mLBxYPtCSvVWbPM7EtQ9YXtJwXv2aN72BNZDMxgzetTvkhwJ3MwowGfEs
         Zc7p+92EPHXcK2IeLt9EAak+cQXHmh8RMZYvWRZwNwZe2VaASxjlU4xoW4fFsuiOws6m
         1tM+sT40a9dyvzOAsfBr+xw32LthR/YD7SDcG3ZfL4uKL/TXwWlSXhE13PZX4J5omVIs
         q3FbpkqPYiqTvTp76rqarehFUsSwE7x+JFkbPbEXaqeuuo8zVQfrA7+30pYa/9A5a3yR
         /iE2aimzrYnc6Edkq9q5FcR/6+JHRlGZ1A4EZhSR2KDJP05DBfphPlHxKNNE3fnpb8LK
         kodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/fLeie0V63G1HFf6jFyTHRq/Bf8/Ax25oLymDlttN8w=;
        b=arNax8UMWQ/G/Vup+RpX9UddbdGeq3pKY/zgB/F3mFa1hphtpmYssrMh3M4/f+9486
         tp/NNGBp/V94dzrRkpiXpwNu0vMpb/jryWnqEh9EVQb6Az4QE3cDTb0k2zqWwSGnv1cH
         4R7GXVKoBFbGzJjpmYK7uh8VnLNO9Hx9HuDzWYpFB3sB+7Y5zNIZ0AaE85xvy+OyS+j0
         5YNn9Sog8uVUyr+SAyKFu3FL2GlMNW9nKcuFR7vGgQbEEy0Ybgf8XRBnSGJWdJkroMck
         OzhwyUNT0nBGPep4mS2s5vB+7esEtihHSnR0uZcgV5mo3eLy0gIatM0NPsIs+//kPaQb
         qOLw==
X-Gm-Message-State: APjAAAVkUjw7bH0g9ugAZ7Jw8L94em1hmqr2niSHghXFTRT8LHc1xUgY
        hUtz/qeBNhmM/a7leOrADWTpjixX
X-Google-Smtp-Source: APXvYqyNQFxma1sVmn6jM0YUFIogIEJEoCSSxxd8SS1uyMtdjTm1b6+YknIPXJ1dMYkm1Gwb1BCZiw==
X-Received: by 2002:a1c:1b4a:: with SMTP id b71mr913259wmb.177.1558723765746;
        Fri, 24 May 2019 11:49:25 -0700 (PDT)
Received: from szeder.dev (x4db30b59.dyn.telefonica.de. [77.179.11.89])
        by smtp.gmail.com with ESMTPSA id z5sm4703340wmi.34.2019.05.24.11.49.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 11:49:24 -0700 (PDT)
Date:   Fri, 24 May 2019 20:49:22 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: Re: git bundle verify segfaults
Message-ID: <20190524184922.GJ951@szeder.dev>
References: <20190524174835.GA2068@chatter.i7.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190524174835.GA2068@chatter.i7.local>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 24, 2019 at 01:48:35PM -0400, Konstantin Ryabitsev wrote:
> I seem to be getting a segfault trying to verify bundles created from
> linux.git. It's easy to reproduce:
> 
> $ cd linux
> $ git show-ref master
> c50bbf615f2f0028ad1771506ef8807130ccc2ce refs/heads/master
> $ git bundle create /tmp/linux.bundle master
> Enumerating objects: 6705678, done.
> Counting objects: 100% (6705678/6705678), done.
> Delta compression using up to 8 threads
> Compressing objects: 100% (1037089/1037089), done.
> Writing objects: 100% (6705678/6705678), 1.19 GiB | 97.81 MiB/s, done.
> Total 6705678 (delta 5657955), reused 6664576 (delta 5622679)
> $ cd /tmp
> $ git bundle verify linux.bundle
> BUG: refs.c:1750: attempting to get main_ref_store outside of repository
> Aborted (core dumped)

'git bundle verify' needs a repository to check "that the prerequisite
commits exist and are fully linked in the current repository" (quoting
its manpage).  I presume your '/tmp' is not a git repository, so Git
complains, though it definitely shouldn't just BUG(), but rather say
"fatal: not a git repository (or any of the parent directories): .git"
instead.

However, if the bundle is self-contained (like the one you created
above), then there are no prerequisite commits to check, and a
repository is not strictly necessary to verify the bundle's integrity,
so 'git bundle verify' could actually get the job done even outside of
a repository.  And it used to work until commit b1ef400eec
(setup_git_env: avoid blind fall-back to ".git", 2016-10-20), so I add
Peff to Cc...


