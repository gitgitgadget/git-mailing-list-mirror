Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35EA91F404
	for <e@80x24.org>; Tue, 27 Mar 2018 21:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751088AbeC0Vt5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 17:49:57 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:45739 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751008AbeC0Vt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 17:49:56 -0400
Received: by mail-wr0-f172.google.com with SMTP id u11so326336wri.12
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 14:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=LlTfRS0x7jVhKZe1e+YK4UzGHe8orOvRtA1ZXqFqJsk=;
        b=RlPIDfnsOHBDwXI6UqkkOuYViiuaoAdzKSmPeFuRY5eIVF+FUauhhWy93fbW5/Ku96
         bhuoVuP89LI89HuXkThIVHy5fAQYbrRQMBMmo+3QugMBK5Xj4FPvQ+pFcSSQsqVOh9RD
         CQrYWuUOc3aJBYNo0ew0cAAlvyBPKK6c4a28iLic3I/ly6nXPTQqFcWzl0h68KXnG0wH
         NDEEcGSJOGh4b5YTvFG87ebImAIg57iXNRTPShwlo/GON5OnXxsCqn3Z9p6OYtlxEFxm
         2vfE09xmtD8I6lkXXkj1459PuUfqMWdqthbO91i/f9lVjV6dBxTcFqiTa8E7bGKmMfmV
         gB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=LlTfRS0x7jVhKZe1e+YK4UzGHe8orOvRtA1ZXqFqJsk=;
        b=r3FlIsmB11i9/LuFzMCJL25TmV3t537AA5yHC7gT35EiintU830UZz+COKI3tql/0k
         HBmLy1ZO6w+v+LxDg1TUtNZXX3JI5Ik3qnEC5uCgRpQJVbBsi/UkfmZ4uoP92YReMkpo
         xapXzdI345TFhjb/jAj0PitY9w+a7acXcZGnkngCdhiTm1bZj3SlDOtQEGLogrQqz6vt
         3lBwGsEDA2G1YclcrdedIwgi9dvneQixNF2Q+kgjAFK/lB7EQEQ1a7WbflrZspNISt4Z
         v7z22v+f71KFW2mXa+SFVaHYnQ2FH/5Pl82y6lcRvtCiz/hdiPkucAUXIkCJfaTv5Ijh
         tDXw==
X-Gm-Message-State: AElRT7HcnhqQek8l69aM21Nziy9Smded8qRUx56Pda7KsC7s2qpYoqsB
        +ClucMX9hThhlHnInWYX3tk=
X-Google-Smtp-Source: AIpwx4+uSrG7F+8RlIvHpipZuVi7io3ZLHyTE64wIi9PQ4AtrF+fue+4pAflSnqq0Gm1em0Ul8lGQw==
X-Received: by 10.223.141.162 with SMTP id o31mr799888wrb.167.1522187394905;
        Tue, 27 Mar 2018 14:49:54 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id b9sm2265017wrc.85.2018.03.27.14.49.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Mar 2018 14:49:53 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jason Frey <jfrey@redhat.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: Bug: duplicate sections in .git/config after remote removal
References: <CAP6Vx84GRRxgMZF5P6tb6F4rJ8ozxx-d0o_LsNe=kEYVRkBTKQ@mail.gmail.com>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <CAP6Vx84GRRxgMZF5P6tb6F4rJ8ozxx-d0o_LsNe=kEYVRkBTKQ@mail.gmail.com>
Date:   Tue, 27 Mar 2018 23:49:52 +0200
Message-ID: <87r2o5w5mn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 27 2018, Jason Frey wrote:

> While the impact of this bug is minimal, and git itself is not
> affected, it can affect external tools that want to read the
> .git/config file, expecting unique section names.
>
> To reproduce:
>
> Given the following example .git/config file (I am leaving out the
> [core] section for brevity):
>
>     [remote "origin"]
>         url = git@github.com:Fryguy/example.git
>         fetch = +refs/heads/*:refs/remotes/origin/*
>     [branch "master"]
>         remote = origin
>         merge = refs/heads/master
>
> Running `git remote rm origin` will result in the following contents:
>
>     [branch "master"]
>
> Running `git remote add origin git@github.com:Fryguy/example.git` will
> result in the following contents:
>
>     [branch "master"]
>     [remote "origin"]
>         url = git@github.com:Fryguy/example.git
>         fetch = +refs/heads/*:refs/remotes/origin/*
>
> And finally, running `git fetch origin; git branch -u origin/master`
> will result in the following contents:
>
>     [branch "master"]
>     [remote "origin"]
>         url = git@github.com:Fryguy/example.git
>         fetch = +refs/heads/*:refs/remotes/origin/*
>     [branch "master"]
>         remote = origin
>         merge = refs/heads/master
>
> at which point you can see the duplicate sections (even though one is
> empty).  Also note that if you do the steps again, you will be left
> with 3 sections, 2 of which are empty.  This process can be repeated
> over and over.

This can be annoying and result in some very verbose config files when
we automatically edit them, e.g.:

    (rm -v /tmp/test.ini; for i in {1..3}; do git config -f /tmp/test.ini foo.bar 0 && git config -f /tmp/test.ini --unset foo.bar; done; cat /tmp/test.ini)
    removed '/tmp/test.ini'
    [foo]
    [foo]
    [foo]

But it's not so clear that it should be called a bug, yes we could be a
bit smarter and not add obvious crap like the example above (duplicate
sections at the end), but it gets less obvious in more complex cases,
see my c8b2cec09e ("branch: add test for -m renaming multiple config
sections", 2017-06-18) for one such example.

Git has a config format that's hybrid human/machine editable. Consider a
case like:

    [gc]
    ;; Here's all the gc config we set up to avoid the great outage of 2015
    autoDetach = false
    ;; Our aliases
    [alias]
    st = status

Now, if I run `git config gc.auto 0` is it better if we end up with:

    [gc]
    ;; Here's all the gc config we set up to avoid the great outage of 2015
    autoDetach = false
    auto = 0
    ;; Our aliases
    [alias]
    st = status

Or something that makes it more clear that a machine added something at
the end:

    [gc]
    ;; Here's all the gc config we set up to avoid the great outage of 2015
    autoDetach = false
    ;; Our aliases
    [alias]
    st = status
    [gc]
    auto = 0

Most importantly though, regardless of what we decide to do when we
machine-edit the file, it's also human-editable, and being able to
repeat sections is part of our config format that you're simply going to
have to deal with.

The external tool (presumably some generic *.ini parser) you're trying
to point at git's config is broken for that purpose if it doesn't handle
duplicate sections. You're probably better off trying to parse `git
config --list --null` than trying to make it work.

I don't think we'd ever want to get rid of this feature, it's *very*
useful. Both for config via the include macro, and for people to
manually paste some config they want to try out to the end of their
config, without having to manually edit it to incorporate it into their
already existing sections.
