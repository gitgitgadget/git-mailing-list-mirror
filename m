Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B70011F404
	for <e@80x24.org>; Tue, 13 Feb 2018 04:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933410AbeBMEmx (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 23:42:53 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36895 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933218AbeBMEmx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 23:42:53 -0500
Received: by mail-qk0-f193.google.com with SMTP id c128so21126533qkb.4
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 20:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=zz/nGhGhk1EhVkJpUzHuyJRuBTNzdhXZ18elcZdEnFM=;
        b=kjAtkWLtfDXoRw5TiYt+F2sbiSoHYi32yCOP1YsvmAxHvXmhFhoVzxXuMZwqNXnE/h
         +gqtTrFt98F6sq8fd/or8uQuAyAnXpO8Zh9+xn+sYdfWyXaRn8+mnJsA16hYM3oOdWOL
         E7JyEAneUzgLikCrsqVoWrSzc3busLow7SJ8Un0U7pqQvLTy8ri8VNBqONKRaMr0HK9j
         iSEdGkSsoFTT0BJq8xbgDc1AdB3D2uCIcnVLV9fcEivRyQ1h9VCI73dpLIq3eWWR2KfG
         +xrxxwHn8u3XZaTknxAQIgBslY03O1uAKi2nsEiLv8SHuyUusizPcW/Q/VX+mzy53f/7
         SNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=zz/nGhGhk1EhVkJpUzHuyJRuBTNzdhXZ18elcZdEnFM=;
        b=A9mCGMfx9AekivdugNKKrh/sHTc/2B66pJLJ5V2tO9a2KMJ3WqL8P+cYiWOg0T0c7A
         LiQc7ma1MUjJW6yWewZ1A6GyeuUtzuJiC5+DcKo18RKnftK4rwCAIAdYaAa+BLemazB0
         uQ3RHvjaIDyjQJjwYzL0e8LVPM+bDYWXJw1xObw+CUWbgettpgwulAaIEAtpN/73RETi
         XSprn54YOzR9eItA+U+zWe9jIs7/3+8De/w8TAuAdK4knKppxQzdNVNzCVcSO920QYLY
         0ioL/W4oZv+bQZ6XcIGInuFU9f13OFoD/nBcYW18Jv0kfgu8b8L7ISGBB52yvqf7We9I
         8Hbw==
X-Gm-Message-State: APf1xPBdeTBdFt+jk22RNekQBO4SZiSmnINwpogfpQlMStQY439wsvU/
        n5vjGwqPEloEbSk7PdrQqjtPB/kyNNExQsIOzjg=
X-Google-Smtp-Source: AH8x226ADkjU5RWXWpj7w1Kx+MGLHUbgNF12QFvrQr71SpY4ddxjTlM8Lqsikr6Bhi3lciVrQJHC1BeFo8v3Cz1KnfU=
X-Received: by 10.55.221.198 with SMTP id u67mr21831018qku.91.1518496972261;
 Mon, 12 Feb 2018 20:42:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.128.40 with HTTP; Mon, 12 Feb 2018 20:42:51 -0800 (PST)
In-Reply-To: <C2FFE6FB-4B3C-4246-9BCA-272EC874FA8B@gmail.com>
References: <20180210010132.33629-1-lars.schneider@autodesk.com>
 <20180212031526.40039-1-sunshine@sunshineco.com> <20180212031526.40039-3-sunshine@sunshineco.com>
 <C2FFE6FB-4B3C-4246-9BCA-272EC874FA8B@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 12 Feb 2018 23:42:51 -0500
X-Google-Sender-Auth: wvQ3cL6jhx8Oca1CV1xrp8n_Wpg
Message-ID: <CAPig+cTLQ6h+stLLns-837hP0nNOpE3vwu8_ZeO2GoAaDs7buw@mail.gmail.com>
Subject: Re: [PATCH 2/2] worktree: add: change to new worktree directory
 before running hook
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git <git@vger.kernel.org>,
        "Gumbel, Matthew K" <matthew.k.gumbel@intel.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 12, 2018 at 3:01 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>> On 12 Feb 2018, at 04:15, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> Fix this by changing to the new worktree's directory before running
>> the hook, and adjust the tests to verify that the hook is indeed run
>> within the correct directory.
>
> Looks good but I think we are not quite there yet. It does not work
> for bare repos. You can test this if you apply the following patch on
> top of your changes.

Thanks for providing a useful test case.

The problem is that Git itself exports GIT_DIR with value "." (which
makes sense since "git worktree add" is invoked within a bare repo)
and that GIT_DIR leaks into the hook's environment. However, since the
hook is running within the worktree, into which we've chdir()'d, the
relative "." is wrong, and setup.c:is_git_directory() (invoked
indirectly by setup_bare_git_dir()) correctly reports that the
worktree itself is not a valid Git directory. As a result, 'rev-parse'
run by the hook fails with "fatal: Not a git repository: '.'". The fix
is either to remove GIT_DIR from the environment or make it absolute
so the chdir() doesn't invalidate it.

However, it turns out that builtin/worktree.c already _does_ export
GIT_DIR and GIT_WORK_TREE for the commands it invokes ('update-ref',
'symbolic-ref', 'reset --hard') to create the new worktree, which
makes perfect sense since these commands need to know the location of
the new worktree. So, a second approach/fix is also to use these
existing exports when running the hook. The (minor) catch is that they
are relative and break upon chdir() but that is easily fixed by making
them absolute.

So, either approach works: removing GIT_DIR or using "worktree add"'s
existing GIT_DIR and GIT_WORK_TREE. I favor the latter since it is
consistent with how "worktree add" invokes other command already and,
especially, because it also addresses the issue Junio raised of
user-defined GIT_DIR/GIT_WORK_TREE potentially polluting the hook's
environment.

> Please note that also '"add" within worktree invokes post-checkout hook'
> seems to fail with my extended test case.

Also fixed by either approach.
