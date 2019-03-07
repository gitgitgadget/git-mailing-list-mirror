Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E3E820248
	for <e@80x24.org>; Thu,  7 Mar 2019 23:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfCGXkV (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 18:40:21 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33929 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfCGXkU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 18:40:20 -0500
Received: by mail-wr1-f65.google.com with SMTP id f14so19437523wrg.1
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 15:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g48Z4VCw0JuljOXGs/NlZnMaQpe7AThgEileh958Xq8=;
        b=b6fORBL2b6pK1b8kKzYJRU6ykg3OR9JOai2Y+lWkU3shrDTE/jWoHWZwJshHpEe2YU
         2NIqfnapj+jBlJP2dOMNNQfmDmqyJyQkgpwfldVJr53NowPgpe/Uy+V5gFHjdLNDqaOc
         5USJeEoNurfe8n28kZ5pRzAjEwjBnGK/nvu4QegaXT41iy1J8vR89QU3Gxa0B2JN7R5S
         Uxu7buLROScfiY7Xwqh8AKW3265L3QiCnZ0wavNUOut/mGvAxTRHWeOxpgZol6Xos+RA
         rvqyKCKiO+AIyA+vKWA/vpM+yA5kjRwOA2Mf8u8/6FT8vDMsXMrx3Va/9B0O8e81XKDA
         v0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g48Z4VCw0JuljOXGs/NlZnMaQpe7AThgEileh958Xq8=;
        b=ieDp1zJ9HWKTjYl8kz/razYzJMpPtuTlZyS1l94UmdzzbGZCuyxGXGYfFYaEFYHAaO
         cdmsN7091Rx/3MClpG/pFCd94K/6WOYLZK2+oZ4WSSU/unU36rwUHuW98OhoHlSYywum
         2mYZJrGTTQwz+iTtwHs74p6tgRJcphfJfGTOUt4lqtaJa6I2pHlCn5SP/HUTeCtMJ8zf
         fgIuthSB5QZJxZK8fUkWBQjaS/yZr7ymH7CvopEtXix0uWqMVe9bl6AiaRGJ2rShXU6b
         2zEEcqFoE1WQtkrVbifbX8tkj3aY2ddFG4eEJ/ifhYl83rBxRC5GdJVCOnp4AvzC43tg
         /2yA==
X-Gm-Message-State: APjAAAW2Cwvokx5pRtzwkfTg+Qqy5vuzZa7sPd2n8059c0o8mHqPEQU0
        Oh4aBcNn2vm9Aui1fhVSBx/Vg0Tb
X-Google-Smtp-Source: APXvYqzFXwn8ypcb2hwrSED98OMTX/TGZFC94WB6myCnlwAZhk9WI16RosX+Sigw1LpDRwykMtn4Jg==
X-Received: by 2002:adf:b784:: with SMTP id s4mr8530243wre.155.1552002018766;
        Thu, 07 Mar 2019 15:40:18 -0800 (PST)
Received: from szeder.dev (x4db9392a.dyn.telefonica.de. [77.185.57.42])
        by smtp.gmail.com with ESMTPSA id h137sm12362331wmg.41.2019.03.07.15.40.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 15:40:17 -0800 (PST)
Date:   Fri, 8 Mar 2019 00:40:15 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Alexander Huynh <alex@grande.coffee>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] fetching all remote branches results in failed multiple
 updates
Message-ID: <20190307234015.GD28939@szeder.dev>
References: <20190307214447.GA4909@chabuduo>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190307214447.GA4909@chabuduo>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 07, 2019 at 09:44:47PM +0000, Alexander Huynh wrote:
> Hello all,
> 
> When running the latest release of git, I receive an error when attempting to
> fetch all remote branches from a repo:
> 
>     fatal: multiple updates for ref 'refs/remotes/origin/maint' not allowed
> 
> The specific ref that it fails on changes depending on the repository, but the
> end result is the repo isn't cloned.
> 
> The specific configuration that causes this bug is the `remote.origin.fetch`
> option, specifically:
> 
>     [remote "origin"]
>     	fetch = +refs/heads/*:refs/remotes/origin/*
> 
> These settings are listed as an example in "CONFIGURED REMOTE-TRACKING
> BRANCHES" of git-fetch(1), as well as expanded upon in
> https://stackoverflow.com/a/40739835.
> 
> I'm running git version 2.21.0.
> 
> Full reproduction steps are below:
> 
>     [root@chabuduo ~]# useradd -m git-test -s /bin/bash
>     [root@chabuduo ~]# sudo --preserve-env=SSH_AUTH_SOCK -u git-test -i
>     [git-test@chabuduo ~]$ git --version
>     git version 2.21.0
>     [git-test@chabuduo ~]$ cat > ~/.gitconfig
>     [remote "origin"]
>     	fetch = +refs/heads/*:refs/remotes/origin/*

Why do you do this?

First, this is the default refspec configuration that clone will fetch
and set up in the clone's config file anyway.  You don't have to set
it.

Second, setting repository-specific stuff like the default fetch
refspec in the global configuration is not such a good idea.

So the simplest workaround is:

  rm ~/.gitconfig; git clone git@github.com:git/git.git

>     [git-test@chabuduo ~]$ cat ~/.gitconfig
>     [remote "origin"]
>     	fetch = +refs/heads/*:refs/remotes/origin/*
>     [git-test@chabuduo ~]$ git clone git@github.com:git/git.git
>     Cloning into 'git'...
>     Warning: Permanently added the RSA host key for IP address '192.30.255.112' to the list of known hosts.
>     remote: Enumerating objects: 265113, done.
>     remote: Total 265113 (delta 0), reused 0 (delta 0), pack-reused 265113
>     Receiving objects: 100% (265113/265113), 113.20 MiB | 5.49 MiB/s, done.
>     Resolving deltas: 100% (196542/196542), done.
>     fatal: multiple updates for ref 'refs/remotes/origin/maint' not allowed

Anyway, this is a side-effect of 515be83382 (clone: respect additional
configured fetch refspecs during initial fetch, 2018-11-14).  Since
then the same refspec comes up twice in remote->fetch, once from the
configuration and once the explicitly added default refspec.  And
since 'git clone' doesn't run a fully-fledged 'git fetch' and has its
own simple refs-to-refspec matching logic, it ends up trying to write
each ref twice, once for each of the two refspecs, in a single ref
transaction.



