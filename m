Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC80E1F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 16:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757032AbcHXQ0d (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 12:26:33 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:36251 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757021AbcHXQ0c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 12:26:32 -0400
Received: by mail-it0-f45.google.com with SMTP id e63so219872414ith.1
        for <git@vger.kernel.org>; Wed, 24 Aug 2016 09:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JiK4i/mDd/14khMu8Qf7im+lOVACo9gqTp/jhNqI9L8=;
        b=GTR/5lUQhNfNJGNlSpJbRkQOHqRkAx0EITVZL3JGn7dsamNvLDeOB3C/oQybLsL6Wn
         2RAxWRziLgRpZDFxgp7DdyI79jT6TghnFOcsRyaXuOP8Rk3X1xo/PeYVgBeizZZA9k8E
         rgCLvTuNu8zG+xsuhp+vjQgoX7g3eJemgO+YOvLjMHzklarifkYedFavOQGLGqYHz923
         Y/y4N5i5hIqGCbp+YtAFKQmvGPPH52vU8hHiRFCDgI3WS3jlitAC0lx/g5u/hWYWcLKk
         i9hdqdRTKTUCDFCSVfJvxpOEzmhrpjDElaeYS/QQPlPnLS6uIliv35AOXxfubKrovdzq
         LrbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JiK4i/mDd/14khMu8Qf7im+lOVACo9gqTp/jhNqI9L8=;
        b=QSo4DgOrjsgHPI8r1Lyiba3JB0wpAY4xwWkoYXY3z/tGEliH+i+P1lUSl906kkJ5YB
         euzGFee9kc4PZru/Azr7tAQN7tqqxq0x4nJ6ZIKOOhtmbN2tBovxwOVM8PUY0+I70iZi
         EpfyRJ2sFYIBiqBszUdACHfeWkrvvMpbgok1DZAkG1ptspjfjxxiOa9Brsi+FZWbRp5F
         NyoBhXVo6P0ivnr/GcE5m6xYhky999uY+I6AiFjt2r22znVxmUi3XzZjG6SMLeZoL75a
         2cDBi1cxlCJqHdrgxCEb3CiG/Ipw7DE/jGoc+JcTAUWKRbopYCsSXuvTbEkfm4/0BHMY
         Ugyg==
X-Gm-Message-State: AE9vXwPasdPwEng/MBN5xfgVC9O11apYyAeNpzlUqVpmpYMRHuod05RYj/TbJme8xIL2h2MgyQM0D8W1NX41CJ6t
X-Received: by 10.36.227.134 with SMTP id d128mr636531ith.97.1472055991376;
 Wed, 24 Aug 2016 09:26:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 24 Aug 2016 09:26:30 -0700 (PDT)
In-Reply-To: <20160824142024.xnaehfo2spw26apj@x>
References: <9bad3d13-3257-2077-a734-f985c375b8d3@gmail.com>
 <20160821142634.dorgzldjvc3qiaby@x> <ab6e29c1-ea6d-c1c5-e69f-867c16cc736a@gmail.com>
 <20160823065359.34cirqig56fugnwy@x> <b2f7ff11-23b4-1065-2207-43f736c91988@gmail.com>
 <xmqq60qqu3rl.fsf@gitster.mtv.corp.google.com> <b264e17a-12ff-69ca-f130-78d2635a0f85@gmail.com>
 <20160824142024.xnaehfo2spw26apj@x>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 24 Aug 2016 09:26:30 -0700
Message-ID: <CAGZ79kbz2WfbJ=uEV3irg8DREaEhJJzEX0_m9FGWiik8e9=w=g@mail.gmail.com>
Subject: Re: Extending "extended SHA1" syntax to traverse through gitlinks?
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 24, 2016 at 7:20 AM, Josh Triplett <josh@joshtriplett.org> wrote:
> Depends on which cases you want to handle.  In the most general case,
> you'd need to find and process the applicable .gitmodules file, which
> would only work if you started from the top-level tree, not a random
> treeish.  On the other hand, in the most general case, you don't
> necessarily even have the module you need, because .git/modules only
> contains the modules the *current* version needed, not every past
> version.

The code in submodule-config.{c,h} allows exactly that:

    submodule_from_path(commit_sha1, path)

returns information about the submodule recorded in a .gitmodules
file of a specific revision of the superproject.

Ideally the .git/modules contains all the modules that existed, ever.
Well "ideally" is the wrong word, but it is at least possible as the
submodules git dir is kept even when you remove the outdated
submodules working dir. (That's why the git dir is in the superprojects
git dir in the first place).

But as you say, it is possible of not having the submodule available.

>
> As an alternate approach (pun intended): treat every module in
> .git/modules as an alternate and just look up the object by hash.  Or,
> teach git-submodule to store all the objects for submodules in the
> supermodule's .git/objects (and teach git's reachability algorithm to
> respect refs in .git/modules, or store their refs in
> .git/refs/submodules/ or in a namespace).

This is a sensible thing to do no matter the outcome of this discussion.

>>  * recorded in ref / commit in supermodule
>>  * recorded in the index in supermodule
>>  - recorded in ref / commit in submodule
>>  - recorded in the index in submodule
>>  - state of worktree in submodule
>>
>> The last three can be easyly acessed by cd-ing to submodule.  The first
>> two are not easy to get, AFAIUC.
>
> Right.  I primarily care about those first two cases, especially the
> first one: given a commit containing a gitlink, how can I easily dig
> into the linked commit?

What do you exactly need? (What is digging here?)

See for example the series, that Jake Keller currently tries to land:
    "submodule inline diff format"
https://public-inbox.org/git/20160822234344.22797-1-jacob.e.keller@intel.com

That would enhance all the log/diff/show things.

Reading the original message, do you want to create patches in
the submodule from the superproject?

Thanks,
Stefan
