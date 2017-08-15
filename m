Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 267FF208B8
	for <e@80x24.org>; Tue, 15 Aug 2017 17:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752583AbdHORJJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 13:09:09 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:35499 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751702AbdHORJI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 13:09:08 -0400
Received: by mail-wr0-f170.google.com with SMTP id k71so5043015wrc.2
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 10:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=igkX1wbE4XdGmk7n972UZbgOWVOlM26ELk74JwXL7/E=;
        b=SgcGNb8kENRZzBkgPWv2UBhGo6d6h69lpSvC9XVyQyS9KtAkUbaezFDdrnkXd5sMjL
         /2/h5xaaEBMCECQEIYgeo2dZmEQabouwbelREePpZr/G1nMdNf+F/2w+yB67jHCtxvt8
         k1IxLYn/c5sS+wIfGXrDiVnxKjEIluB4o18moiQeL5w42jpTmQ6qicHoO/Xx4+EXAy8X
         dem4muBMwfqzUwlW+dbvmvmu+rrjGFHtdVu3vHAYFatBG9zWkKqitGsvOpUat7eiNKGR
         P14wTxfA/qIScroPzr/BkG/5PZYJ74Oq4OhAA8uno7dHbTXg46+VWVw6M4WuKdMxI9Eb
         RgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=igkX1wbE4XdGmk7n972UZbgOWVOlM26ELk74JwXL7/E=;
        b=Z+wnzLJo6UMu6w3aDG+MTwR90VTGTzlg+XU69H15r+kdgK62A1CX2N7IG8iF3xN7LR
         3+qrT0nGMnTGjEwbaWJf78ozr1V2DH2O1bMHa8QGA6uSPArM4BA+tGjhTSDuW2JwMRUM
         ekE+QS7c0chTHHXKz/P3fHAmS5jtTr3Svcz9K7p1G1jcj2rRKxI8jrM89C9aSgJvpF54
         U1XEbD+jqCJLBwEoMPc3h0feqCVyYNuKonPKoyNlpwYUEew1UTAE/2sgYHM647pLE4zz
         sjeiQX7YahOzi3BiBnmTFUIGN/Ms7dqaZq7Zx3vu9BI6FV+2y7J7wz2VAMFU9ZcXPptL
         Ggcg==
X-Gm-Message-State: AHYfb5i5+E3/o4Ywsxr2X/OpN8JV50iZmj7JFYerZ7qtSYuIA5iXHDEZ
        6tMLrvEL2EiyBdQpzSA=
X-Received: by 10.223.133.140 with SMTP id 12mr18851109wrt.102.1502816947135;
        Tue, 15 Aug 2017 10:09:07 -0700 (PDT)
Received: from [192.168.5.102] (cable-24-135-63-71.dynamic.sbb.rs. [24.135.63.71])
        by smtp.gmail.com with ESMTPSA id e137sm2794456wma.29.2017.08.15.10.09.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Aug 2017 10:09:06 -0700 (PDT)
Subject: Re: Bug: `git remote show <remote>` reports different HEAD branch
 than refs/remotes/<remote>/HEAD
To:     Jason Karns <jason.karns@gmail.com>, git@vger.kernel.org
References: <CAKNmmv3_K4gB6FbcmAjXyviMbU2Ts7Rh7txkOof+-36rF_1+Gw@mail.gmail.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <bad7dafc-247c-bf5e-8cfd-5445badeef1c@gmail.com>
Date:   Tue, 15 Aug 2017 19:09:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAKNmmv3_K4gB6FbcmAjXyviMbU2Ts7Rh7txkOof+-36rF_1+Gw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jason,

On 15/08/2017 16:26, Jason Karns wrote:
> I have a git repo that shows a different branch in
> `.git/refs/remotes/origin/HEAD` than is reported by `git remote show
> origin`.
> 
> The branch is `github-rename` in refs/remotes/origin/HEAD, but shows
> `master` in output of git-remote-show
> 
> ```
> $ cat .git/refs/remotes/origin/HEAD
> ref: refs/remotes/origin/github-rename
> 
> $ git remote show origin
> * remote origin
>   Fetch URL: git@XXXX.git
>   Push  URL: git@XXXX.git
>   HEAD branch: master
>   Remote branches:
>     github-rename     tracked
>     master            tracked
>     qa                tracked
>     refactor-test     tracked
>   Local branches configured for 'git pull':
>     github-rename merges with remote github-rename
>     master        merges with remote master
>   Local refs configured for 'git push':
>     github-rename pushes to github-rename (up to date)
>     master        pushes to master        (up to date)
> ```
> 
> git version 2.14.1
> 
> 
> Background:
> 
> Prior to my repo being cloned, the default branch was configured to be
> `some-random-branch` on github. My repo was cloned and the HEAD branch
> was set to `some-random-branch` correctly (in `refs/`). However,
> git-remote-show reported `master` as the HEAD branch.
> 
> Later, `some-random-branch` was deleted from the remote. It _remained_
> as the HEAD branch locally according to `refs/`.
> 
> In order to test the remote-show command, I changed the HEAD branch to
> a branch that actually existed by running `git remote set-head origin
> github-rename`. It changed the HEAD branch in `refs/` but remote-show
> continues to report `master` as the remote's HEAD. 

I am no expert here, but reading the docs, it seems like you may have 
wrong expectations.

Documentation for "git remote set-head"[1] explains that this command 
is used to set default remote branch (locally), where later you can 
use remote name only to specify that specific (remote) branch instead.

Example shows that for remote named "origin", if you set default 
branch name to "master" (actually being "origin/master" locally), 
then whenever you want to type "origin/master", you can type "origin" 
only instead (set default branch name is implied).

For the given example, that is what you can see inside 
"refs/remotes/origin/HEAD", being set to "refs/remotes/origin/master".

So it is something _you_ set _locally_ to aid you in working with the 
remote repository.

On the other hand, what "git remote show" outputs for HEAD is a name 
of actually checked-out branch inside that remote repository - it`s 
what`s stored inside HEAD file of the remote repository root.

So it is something set on the _remote_ end, you can`t influence it 
from your local repository.

What you _could_ do in your specific case, as you mention using 
GitHub, is following their help page for "setting the default 
branch"[2] for your GitHub repository (which you track locally as 
"origin") to "github-rename".

(in general, non-GitHub repository case, one could usually run there 
either `git checkout github-rename`, if it`s not a bare repository, 
or `git symbolic-ref HEAD refs/heads/github-rename`, if it`s a bare 
repository)

Afterwards, running `git remote show origin` inside your local 
repository should output "github-rename" as HEAD value, as desired.

p.s. To set your default remote branch locally to checked-out branch 
on the remote end automatically, you can use `git remote set-head 
origin --auto`, as documented[1]. It will inspect what`s inside 
"HEAD" of the remote named "origin", and update your local 
"refs/remotes/origin/HEAD" accordingly.

[1] https://git-scm.com/docs/git-remote#git-remote-emset-headem
[2] https://help.github.com/articles/setting-the-default-branch/

Regards,
Buga
