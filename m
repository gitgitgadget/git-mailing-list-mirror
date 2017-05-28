Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97F461FD09
	for <e@80x24.org>; Sun, 28 May 2017 17:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750955AbdE1R6K (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 May 2017 13:58:10 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:35587 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbdE1R6J (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2017 13:58:09 -0400
Received: by mail-it0-f67.google.com with SMTP id 67so5526063itx.2
        for <git@vger.kernel.org>; Sun, 28 May 2017 10:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=clu/P+PX/QupVjRsPe0Lce170f9KuXMruuAljJCecBs=;
        b=vHzSR0+S1A3JGaPRemQlgwte8il6sef8J/4ZRnsCvq26CQZryap7tHpGAlaqqj2AVi
         EuzqEx9mRGDBSEq4FeqZZQWe5wfK3iVN9vJwfZtt904/wUVI+wBqjKm9NP36RD9x8TxY
         ovFdxtCJS42FwmKO5022W0Dyn5W95wuqWlC8Gz8qfrP37+Q2AmGbT6JtKVcq9LvedDZT
         j+wzx4krS2RZKwovIS4w9Tf0nE3PoVIj8DmjGdHRbWuyGXr9q8j7fhx29QRtvYMs5pJD
         LqyeAQ9x1eyzEJDZdvS5m+a0DTMsKXBccM1+6ofu34L6p5CfU0RCkEmmnsLlBpPT1cxv
         3jSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=clu/P+PX/QupVjRsPe0Lce170f9KuXMruuAljJCecBs=;
        b=c2G+EqjvIXqHVSmO9134+6+2I+W9lD+wODXeRe8nQW4GXHZgJYz394+HjT5uhr2xae
         sErLg4ye/A9fyE7Nea3LGJ90tHT7+q4gS7Y7ndzpg0S+VJ4HXB8G02xTm7and6b+xGHY
         PLfY3PK4FXbhyrgs9VMV1kd0p4SE486vPwRUONEk+n2JPSpvUI3V93QbTB8Gz0xb6PoL
         qL7Kt/EKyjecvVfpWp+TngAU1OWUWBou2E3RRDM4P/4nuCvJzhbNBOp/i93g3ywpkaet
         cHIsG4XZ3fiXldKqVqq0GieKbkpJlTts0vLBY3C5uD0JA3SZ84YzHb4/QlmFnGwnnCLF
         WLxA==
X-Gm-Message-State: AODbwcDjONXL0peetRe31NLYbqSRqCtc8+No0UnvA5EISy3J66jikeSO
        UktGJ7HQFLIMcWh9Bwg1ak8YnTHW1Q==
X-Received: by 10.36.166.4 with SMTP id q4mr11116916ite.66.1495994288736; Sun,
 28 May 2017 10:58:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Sun, 28 May 2017 10:57:48 -0700 (PDT)
In-Reply-To: <20170528165642.14699-3-joel@teichroeb.net>
References: <20170528165642.14699-1-joel@teichroeb.net> <20170528165642.14699-3-joel@teichroeb.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sun, 28 May 2017 19:57:48 +0200
Message-ID: <CACBZZX4anGGe1i-jtasPbfRbye-OXQMyWO5T1oFdJajnS=d1rA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] stash: add test for stashing in a detached state
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     Git Mailing List <git@vger.kernel.org>, t.gummerer@gmail.com,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 28, 2017 at 6:56 PM, Joel Teichroeb <joel@teichroeb.net> wrote:
> Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
> ---
>  t/t3903-stash.sh | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index aaae221304..b86851ef46 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -808,6 +808,17 @@ test_expect_success 'create with multiple arguments for the message' '
>         test_cmp expect actual
>  '
>
> +test_expect_success 'create in a detached state' '
> +       test_when_finished "git checkout master" &&
> +       git checkout HEAD~1 &&
> +       >foo &&
> +       git add foo &&
> +       STASH_ID=$(git stash create) &&
> +       echo "WIP on (no branch): 47d5e0e initial" >expect &&
> +       git show --pretty=%s -s ${STASH_ID} >actual &&
> +       test_cmp expect actual

I thought this needed test_i18ncmp, turns out it didn't, neither the
original stash code nor your replacement translates this. That's fine,
just a note to other reviewers...

> +'
> +
>  test_expect_success 'stash -- <pathspec> stashes and restores the file' '
>         >foo &&
>         >bar &&
> --
> 2.13.0
>
