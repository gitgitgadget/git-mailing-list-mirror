Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 048E020248
	for <e@80x24.org>; Wed, 13 Mar 2019 23:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfCMXpf (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 19:45:35 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:34094 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbfCMXpf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 19:45:35 -0400
Received: by mail-pg1-f172.google.com with SMTP id v12so2660722pgq.1
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 16:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grande.coffee; s=omgwhathaveyoudone;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GbZhMsi6Q9vUEEY+9XioGDFQOzhffZBtcMi/10pV6rM=;
        b=jPkwcr6d+3Qzw+3qIRie8QPXgDmpItzJph0OeLNBxIGgQS3uWmr4MPquSwpcRJKS2c
         cOJmhx0HaeFS6Mq6+7Kc+wbwBb3pj6qf9rPALB6s/MNtB61txbAfaQPU0YEnhZ6Nr0Xu
         9LCifCF4mATPF4WQXYq7P9keyXxhqt6O6DucutOUYGJg+UyaOWr/0wMPGxDdvxDP2KPv
         VGplOXpiBcRqvCIYqah0GgMTPBwUJqVzOkIygOAz8wDeV1jypUIl7SjK11FXsbWwMNnX
         YdGjQtLm1CRGf2cojAHbvuOE7xWF1+B/ENJSWy76d2pUNENygWI5k7AkTDDBTHnJgMHi
         3qUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GbZhMsi6Q9vUEEY+9XioGDFQOzhffZBtcMi/10pV6rM=;
        b=qO8jLlMXMk+jKLaUKTJTtw9SwVDeA5l12BIL3zeUUAJwqfco1qhgnV119xs9tS3R/G
         MjI47jderVprFcSAPRtG/jedE53uZTHrL+2kSnne1z9U/LE6ZaxkfjR4a0wjzY0YJM2h
         ErvBhETe6/nJRe6JD2rhE4mge8JYohVDBpe3ftNSGWUJHVplEppaz/IVLJRHSfo0RkpI
         yMxU4wpMAgUYU1ANR9YiUkwbpKxd1ZDiRZUG3xODQhmHBs3ZdSeFaCntVl5hBDjI66C/
         M3w+SIuYvbNd7jFnmkHeZb5LqxZQVUnfXlBUpp4k1+nAGDAHv/p6G4kzIsiTqHZbIYqH
         HJzg==
X-Gm-Message-State: APjAAAXZI6o6JRU1KmUWTU7XQDrLXPA2SZ7gW0eQLmt5I7eEG28zKzMx
        zjBy/gBcpWjWM1zaQqSDq0Dbkg==
X-Google-Smtp-Source: APXvYqyFLFnKATz3LI8Ml5scYFIGMuyngGQZLG0yA1DOUVHcRzptSoO+xyGCmqUJOk1HCrpJIZDpVw==
X-Received: by 2002:a17:902:a704:: with SMTP id w4mr12848252plq.251.1552520734151;
        Wed, 13 Mar 2019 16:45:34 -0700 (PDT)
Received: from chabuduo ([198.41.129.7])
        by smtp.gmail.com with ESMTPSA id y8sm25592574pge.35.2019.03.13.16.45.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 16:45:33 -0700 (PDT)
Date:   Wed, 13 Mar 2019 23:45:24 +0000
From:   Alexander Huynh <alex@grande.coffee>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [BUG] fetching all remote branches results in failed multiple
 updates
Message-ID: <20190313234524.GA3053@chabuduo>
References: <20190307214447.GA4909@chabuduo>
 <20190307234015.GD28939@szeder.dev>
 <20190308000810.GA8044@chabuduo>
 <xmqqef7ikw9f.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqef7ikw9f.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I appreciate the help offered in identifying what I was doing incorrectly.

Upon further investigation, I remembered why I added the original
`origin.fetch` parameter: I was compensating for shallow clones not fetching
all remote refs.

Here's the use case that I have:

    [root@chabuduo ~]# useradd -m git-test -s /bin/bash
    [root@chabuduo ~]# sudo --preserve-env=SSH_AUTH_SOCK -u git-test -i
    [git-test@chabuduo ~]$ git clone --depth=1 git@github.com:git/git.git
    Cloning into 'git'...
    The authenticity of host 'github.com (192.30.255.112)' can't be established.
    RSA key fingerprint is SHA256:nThbg6kXUpJWGl7E1IGOCspRomTxdCARLviKw6E5SY8.
    Are you sure you want to continue connecting (yes/no)? yes
    Warning: Permanently added 'github.com,192.30.255.112' (RSA) to the list of known hosts.
    remote: Enumerating objects: 3664, done.
    remote: Counting objects: 100% (3664/3664), done.
    remote: Compressing objects: 100% (3282/3282), done.
    remote: Total 3664 (delta 276), reused 1921 (delta 232), pack-reused 0
    Receiving objects: 100% (3664/3664), 8.31 MiB | 9.61 MiB/s, done.
    Resolving deltas: 100% (276/276), done.
    [git-test@chabuduo ~]$ cd git/
    [git-test@chabuduo git]$ git branch -a
    * master
      remotes/origin/HEAD -> origin/master
      remotes/origin/master

Running a shallow clone results in only the remote `HEAD` ref being fetched,
as observed by the last `git branch -a`.

No additional refs are fetched, even when promoting the shallow repository to
a full one:

    [git-test@chabuduo git]$ git pull --unshallow
    remote: Enumerating objects: 255783, done.
    remote: Counting objects: 100% (255777/255777), done.
    remote: Compressing objects: 100% (62079/62079), done.
    remote: Total 253423 (delta 193725), reused 249056 (delta 189413), pack-reused 0
    Receiving objects: 100% (253423/253423), 94.28 MiB | 33.96 MiB/s, done.
    Resolving deltas: 100% (193725/193725), completed with 2155 local objects.
    remote: Enumerating objects: 709, done.
    remote: Total 709 (delta 0), reused 0 (delta 0), pack-reused 709
    Receiving objects: 100% (709/709), 363.70 KiB | 12.12 MiB/s, done.
    From github.com:git/git
     * [new tag]             gitgui-0.10.0    -> gitgui-0.10.0
     * [new tag]             gitgui-0.10.1    -> gitgui-0.10.1
    ...
    Already up to date.
    [git-test@chabuduo git]$ git branch -a
    * master
      remotes/origin/HEAD -> origin/master
      remotes/origin/master

How I've managed to work around the issue is by force fetching all refs, as
explained in the example at https://git-scm.com/docs/git-fetch#CRTB:

    [git-test@chabuduo git]$ git fetch origin '+refs/heads/*:refs/remotes/origin/*'
    remote: Enumerating objects: 1218, done.
    remote: Counting objects: 100% (1218/1218), done.
    remote: Total 7699 (delta 1218), reused 1218 (delta 1218), pack-reused 6481
    Receiving objects: 100% (7699/7699), 4.31 MiB | 17.22 MiB/s, done.
    Resolving deltas: 100% (4881/4881), completed with 435 local objects.
    From github.com:git/git
     * [new branch]            maint      -> origin/maint
     * [new branch]            next       -> origin/next
     * [new branch]            pu         -> origin/pu
     * [new branch]            todo       -> origin/todo

This populates the missing references from a shallow clone:

    [git-test@chabuduo git]$ git branch -a
    * master
      remotes/origin/HEAD -> origin/master
      remotes/origin/maint
      remotes/origin/master
      remotes/origin/next
      remotes/origin/pu
      remotes/origin/todo

I've created an alias that allows for filling out refs for future shallow
clones:

    % git config --global alias.fetcha '!f() { remote="${1:-origin}"; git fetch "$remote" "+refs/heads/*:refs/remotes/$remote/*"; }; f'

I'm also interested in more efficient ways to obtain all refs from shallow
clones, if anyone has better ideas.

Thanks for taking the time to help me understand,
Alex
