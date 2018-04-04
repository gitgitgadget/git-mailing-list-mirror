Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE5231F424
	for <e@80x24.org>; Wed,  4 Apr 2018 08:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750916AbeDDIJK (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 04:09:10 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:41534 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750736AbeDDIJI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 04:09:08 -0400
Received: by mail-qt0-f196.google.com with SMTP id d3so18863546qth.8
        for <git@vger.kernel.org>; Wed, 04 Apr 2018 01:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=SSxNo1E8lCGU/GjMWQG6k6HNU60+DboOxPp6AHMPIIg=;
        b=afHwIC91QedI09/pLh6eEqxGLyAUgw54DIx5zZlKzvw1A8XE7T7Sg5t1/L2PKQQ4Vd
         YGwdBnIJLmMzn8EPj0U++Oi1wzYIepp0ntph5kgM1z9GAt3LwQfIU+H8cy+TYteIQxZC
         DIo21o9L3jzD1LstSR64DNU/vO4ACxH+jh+vOmupTJHqvsRHNprVBYo1BeOitC/Ku95h
         HjTMjib9qdXSIHbpVwxM/9qkjnoH4uPjVle7QWALyZqPHQ0p8YOVTfMqey03C392DbwV
         kfZPaq+DUXvkRDE8a1nMuZjKcTbQBrG6zkZZ4UhbsjyWU3Dj95PhlYvkwHufCpLSPP4S
         jUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=SSxNo1E8lCGU/GjMWQG6k6HNU60+DboOxPp6AHMPIIg=;
        b=DCGWD3BVo4JNsz+w3SOyicycFD0xAeC/fiRKNNv3KVRmn+oZ3NndDlL3cLfedgfXuT
         RCYvVRsDeBYI247CsRqQctfhC2uDwR0+p25EcNu5qUQbpmgr75c8qwkERjgL4KmW9v9l
         ODcYPC/4CXU85MeBJnKNMarEFrGUTWVVJwvtESYVCHx1bRZlP0WvWT9pBkVBvP4C1vB3
         FRUj/vLEZ6ClAIQy8tjHZzyS0VzgH2EROsIUS546Bft+9VojsVx3t/VABdlyYjVCJauN
         o8js3jBW+imovxTkI4JAVUToMkYsHw8ynVh2gVhV3De1f5ucEt6SezEe5Zp5BURp5ZI1
         SAtw==
X-Gm-Message-State: ALQs6tCfPtOqHTCnpz+gOpGWFebF38Itzt549Azk1VmLcJdBaoJtEyOK
        FpnqyhZXZ3hvYHdh7/QrlutBO7QJlOlGPvgLQpg=
X-Google-Smtp-Source: AIpwx49XKWLQyCnMvV3Sv+GJpphD4nA+vjIiSj1ooogku10wShmRVzN+mdZlLQ5Ya+gU+3BmnPq6fQ0FNXW0Xu6ZC1Y=
X-Received: by 10.200.80.78 with SMTP id h14mr25980016qtm.154.1522829347962;
 Wed, 04 Apr 2018 01:09:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Wed, 4 Apr 2018 01:09:07 -0700 (PDT)
In-Reply-To: <20180403144715.11174-1-kaartic.sivaraam@gmail.com>
References: <CAPig+cSrAN2LgL1dAEUoR4PJk-rUzHdqTusXm8MYUn7p6G4puQ@mail.gmail.com>
 <20180403144715.11174-1-kaartic.sivaraam@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 4 Apr 2018 04:09:07 -0400
X-Google-Sender-Auth: ONZ_mDG8u9nCxrFSWzqtaB6lRBI
Message-ID: <CAPig+cSGZunGDU5yOngwsDfH9w=TNGP1fUq94j1qfb_iaC2oZQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] t3200: verify "branch --list" sanity when rebasing
 from detached HEAD
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 3, 2018 at 10:47 AM, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> From: Eric Sunshine <sunshine@sunshineco.com>
>
> "git branch --list" shows an in-progress rebase as:
>
>   * (no branch, rebasing <branch>)
>     master
>     ...
>
> However, if the rebase is started from a detached HEAD, then there is no
> <branch>, and it would attempt to print a NULL pointer. The previous
> commit fixed this problem, so add a test to verify that the output is
> sane in this situation.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>

Thanks. This re-roll looks fine.

> ---
>  t/t3200-branch.sh | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 503a88d02..89fff3fa9 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -6,6 +6,7 @@
>  test_description='git branch assorted tests'
>
>  . ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-rebase.sh
>
>  test_expect_success 'prepare a trivial repository' '
>         echo Hello >A &&
> @@ -1246,6 +1247,29 @@ test_expect_success '--merged is incompatible with --no-merged' '
>         test_must_fail git branch --merged HEAD --no-merged HEAD
>  '
>
> +test_expect_success '--list during rebase' '
> +       test_when_finished "reset_rebase" &&
> +       git checkout master &&
> +       FAKE_LINES="1 edit 2" &&
> +       export FAKE_LINES &&
> +       set_fake_editor &&
> +       git rebase -i HEAD~2 &&
> +       git branch --list >actual &&
> +       test_i18ngrep "rebasing master" actual
> +'
> +
> +test_expect_success '--list during rebase from detached HEAD' '
> +       test_when_finished "reset_rebase && git checkout master" &&
> +       git checkout master^0 &&
> +       oid=$(git rev-parse --short HEAD) &&
> +       FAKE_LINES="1 edit 2" &&
> +       export FAKE_LINES &&
> +       set_fake_editor &&
> +       git rebase -i HEAD~2 &&
> +       git branch --list >actual &&
> +       test_i18ngrep "rebasing detached HEAD $oid" actual
> +'
> +
>  test_expect_success 'tracking with unexpected .fetch refspec' '
>         rm -rf a b c d &&
>         git init a &&
> --
> 2.17.0.484.g0c8726318
