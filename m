Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BCFB1F404
	for <e@80x24.org>; Mon,  5 Mar 2018 18:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752646AbeCESoC (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 13:44:02 -0500
Received: from mail-qk0-f178.google.com ([209.85.220.178]:37932 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751490AbeCESoB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 13:44:01 -0500
Received: by mail-qk0-f178.google.com with SMTP id s198so21843624qke.5
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 10:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=LXX6k6USvZSepiYOwY78TOs0BO9+pFJSl/emJhtW2vc=;
        b=ZPmHgBclDUyQZ/o0lKiCwtQyxaslpvNJmWNqNlLJq6FUwBcOocKnrCcKUBT629V2hl
         kLbHY4yJ0ueapUY0PGR/dD5tBQE85kRfcHMiHR1Ls5/60HDioqnqdR6MkD42KRlgOqce
         WZ0hg5dX+AIwjPvpcA143y4XNxQrCKONoqDySJBiByu2/Bun9YE40za9N0IGqueVu8MO
         lJ7B3UfozdKQs4mlNaHe/QqlPnD6dezzy0jxWGV50utSWHQZut1lApyvcm2MlkJVB0RW
         pvpZdkVQGDRi9NUPjM2Wz8ldgmmdPLWmgiGv1NqoivwePDtbYnkQhmSGeg+sJ7InkDpk
         7mIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=LXX6k6USvZSepiYOwY78TOs0BO9+pFJSl/emJhtW2vc=;
        b=QLXrUJUUH79Igr1keFHGzKV+wu1hOE5bb+4pBNAevBk9LaAnyGtCj0WCEVkhnvy/No
         p+/GIJGAt3YZDYVEiDJcITlFEg1Sa0JS076EJVW418hVLOqtqYwfZOgh4UKbNGqckacA
         qyfplGbSqaYXPdoXy1RXCYxtay8rtuTUIXOZ0VrLbPb3nCgn19JVBjCf+k4CCCC7DR+y
         HiBCaM8LHVsZyQbWhS+HYMIDl6MnnUOEJmIVVjWzZ90t/M1rzmy5GXiLcgAfCUnR8T/v
         GiYs7n0TDz3FS5nBTijwWk7XChCvK7+Gu4NdypYM2j+YCxUyrBmoVJWXc3e9HgGkP/Su
         JtvQ==
X-Gm-Message-State: AElRT7HhqOG61Ih7cIPuWsCuY68RzSCIhybuSEYwIcy7kYPMsXJI/GIj
        jhhM+D/l5x60bTsyX2GFlRKc6Dl3r3uTH4NCPCE=
X-Google-Smtp-Source: AG47ELsPyvpjwkFzRcUCbgvn2nU6u6aaw3220bhqhEiVdKnUjeyDDXo+3miw2EHUlAd3GjaILB7xZp8t+bFxLxDiDeA=
X-Received: by 10.55.133.131 with SMTP id h125mr24165190qkd.79.1520275440878;
 Mon, 05 Mar 2018 10:44:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Mon, 5 Mar 2018 10:44:00 -0800 (PST)
In-Reply-To: <xmqqh8pu9xmq.fsf@gitster-ct.c.googlers.com>
References: <20180212094940.23834-1-pclouds@gmail.com> <20180304052647.26614-1-sunshine@sunshineco.com>
 <20180305124848.7272-1-szeder.dev@gmail.com> <xmqqh8pu9xmq.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 5 Mar 2018 13:44:00 -0500
X-Google-Sender-Auth: To0PEVYpPAmu4iK_024iHuIwT4I
Message-ID: <CAPig+cQLmYQeRhPxvZHmY7gApnbE25H_KoSWs-ZjuBo4BruimQ@mail.gmail.com>
Subject: Re: [PATCH] t2028: fix minor error and issues in newly-added
 "worktree move" tests
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 5, 2018 at 1:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>
>> Could you please save 'git worktree's output into an intermediate
>> file, and run 'grep' on the file's contents?
>
> Here is what I tentatively came up with, while deciding what should
> be queued based on Eric's patch, as a possible squash/fixup.

Thanks for saving a round-trip. One comment below...

> diff --git a/t/t2028-worktree-move.sh b/t/t2028-worktree-move.sh
> @@ -74,8 +75,10 @@ test_expect_success 'move worktree' '
>         toplevel=3D"$(pwd)" &&
>         git worktree move source destination &&
>         test_path_is_missing source &&
> -       git worktree list --porcelain | grep "^worktree.*/destination" &&
> -       ! git worktree list --porcelain | grep "^worktree.*/source" &&
> +       git worktree list --porcelain >out &&
> +       grep "^worktree.*/destination" out &&
> +       git worktree list --porcelain >out &&
> +       ! grep "^worktree.*/source" out &&

The second "git worktree list --porcelain >out" can be dropped,
leaving the two grep's back-to-back since it they can test the same
'out' file

>         git -C destination log --format=3D%s >actual2 &&
>         echo init >expected2 &&
>         test_cmp expected2 actual2
