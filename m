Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C604A1F803
	for <e@80x24.org>; Thu, 10 Jan 2019 20:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbfAJUHs (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 15:07:48 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]:40144 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729482AbfAJUHs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 15:07:48 -0500
Received: by mail-ed1-f48.google.com with SMTP id g22so11228980edr.7
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 12:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aTFhx8vyHng/HXtGRqMzqkSmor8XoOtY8jj85mimIXE=;
        b=t6fmvToN87ZNRi7rzLe0thQ0Zx+V2XhqD8mEaeDN9l0G69ObSY3gl89NsVF64ym6so
         HzT1RDKEcGSWucCgeaMqYDycHG8JbVrWDItHkigSk32l9cbUvyP8MSXNpib/uid8tJ3i
         cEjpId3tlhMQPir84S9/XWglO9WDAyKG3BkCn+7ODRiEsdhkAmGXq5imPtWsf1SCC4xl
         ElzjV5d46YgmVt5wgwOcoXeBKTIom9dFVD7jZ4EBz7Erclyn57xfkhx5J3AL9nLPwvjD
         FeeMWivu5xHp5inPkXAf/JX17/jNWA6l6FQI9bG1huNi6tcEieRDN76wLfIs99kyxfkl
         d0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aTFhx8vyHng/HXtGRqMzqkSmor8XoOtY8jj85mimIXE=;
        b=ixND2mQUFwciK6MbQkowYFgYxjmspWOlWB28TWmb/Sm/yAXXl5fRE9hmp7LKnIo68A
         LY7Oz2JKBZX92nhgjYl2CXJ2+Yk7DZY1/Htq4w4bIvMTEIeIKcGEqDbv9mWt/tmnDrSN
         HZs7aie2QsUaJp3LVijbFLxzhk1qFZZMe771p3yhfkd306BrOjPE4LFB4gIVyeQYiTk5
         hqCAUNAGx5sdRaj5BaMGzzHv1yWNW0TK8EhdbgDdwlu4GKtU4FzRq2GGV2VOCqgUwnNW
         wGgfQotG34cWhYAcyDHv+7Nvyoo0blBnt2bLT++kVZ/g4M1kuMKwj+h3neEdJggFcdWz
         xMSw==
X-Gm-Message-State: AJcUukc5/X9GP8lUHKLeX2KWBnJahstX33fry6OFmkViADLfrK8+pA7p
        Z2dN+FRnxcY06HYUdQquSjR3H4ujkXFVAPPr0b3xyQ==
X-Google-Smtp-Source: ALg8bN7fSefIDHAfTtuibuY/ou9jx/lGXdnSD6qaeshY7XWZHSD7vKwJCzdVg3bmbRLnCSdgJtOawiOZ0bf8oJ5WhY8=
X-Received: by 2002:a17:906:5a11:: with SMTP id p17-v6mr9516617ejq.43.1547150865592;
 Thu, 10 Jan 2019 12:07:45 -0800 (PST)
MIME-Version: 1.0
References: <CAG0vfyQeA3Hm7AsYgYtP4v-Yg0=rKXW0YYfg_emAwEscZha4VA@mail.gmail.com>
 <CAGZ79kZBwocC=UzjW+DxodwJkQZ2mNMYNjsk6sL4SCqdhGoQ7w@mail.gmail.com> <CAG0vfyR3KnDDBrpyG-n-RFbu-xgCLFUa6HUXQ+dk8E4HutR+ow@mail.gmail.com>
In-Reply-To: <CAG0vfyR3KnDDBrpyG-n-RFbu-xgCLFUa6HUXQ+dk8E4HutR+ow@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 10 Jan 2019 12:07:34 -0800
Message-ID: <CAGZ79kZ9ibM4eDyK=M6YWEDsjt+JfqJH-Gm56+092VATGuZDaw@mail.gmail.com>
Subject: Re: Regression: submodule worktrees can clobber core.worktree config
To:     =?UTF-8?Q?Tomasz_=C5=9Aniatowski?= <tsniatowski@vewd.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I had a look at https://gitlab.com/pclouds/git/commits/submodules-in-work=
trees,
> and it doesn't seem to be quite all okay.
>
> The submodule update step of the repro (that breaks the config on 2.20) e=
mits
> an error message instead, and leaves the config unchanged:
>    git -C b2 submodule update
>    fatal: could not set 'core.worktree' to '../../../../../../b2/a'
> It looks a bit like it's still trying to do the wrong thing, but errors o=
ut
> during the attempt (repo_config_set_worktree_gently returns false).

There is more than just that. After adding the worktrees,
(and after the first status call)

    $ cat b2/.git
gitdir: /u/git/t/trash directory.t7419-submodule-worktrees/b/.git/worktrees=
/b2
    $ cat b2/a/.git
gitdir: /u/git/t/trash
directory.t7419-submodule-worktrees/b/.git/modules/a/worktrees/a

Are worktrees using absolute path for their gitlinks?
Submodules themselves try really hard to use relative path:

    $ cat b/a/.git
gitdir: ../.git/modules/a

> Curiously, even though it says "fatal", it will then perform the actual
> submodule update if it's required.

Oh. :/ I think we should solve that by either warning
(but that gives bad UX) or actually aborting, by adding
a "|| exit 1" in git-submodule.sh in cmd_update where we
call "git submodule--helper ensure-core-worktree".

When we run "git -C b2 submodule update", it calls
"git submodule--helper ensure-core-worktree a" which
currently would make sure that b2/a/.git points to
b2/.git/modules/a, but that is not the case as b2 and b2/a
are worktrees, whose git directories are housed in
b/.git/worktrees.

So maybe we need to be a bit more careful and check
if b2/a/.git resolves to a worktree and if so we'd not
touch it at all (and warn about it?).


>
> Same behavior on master with a subset of that branch cherry-picked, that =
is:
> https://gitlab.com/pclouds/git/commit/94751ada7c32eb6fb2c67dd7723161d1955=
a5683
> along with two others it needed to build:
> https://gitlab.com/pclouds/git/commit/d26ab4c5013f6117814161be3e87c8d2b73=
561a4
> https://gitlab.com/pclouds/git/commit/b2e21eece6b35e00707ed3a8377a84a95da=
6b778
>
> --
> Tomasz =C5=9Aniatowski
