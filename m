Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC92B202BB
	for <e@80x24.org>; Fri,  5 Apr 2019 11:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730702AbfDELPS (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 07:15:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54785 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730624AbfDELPS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 07:15:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id c1so6213132wml.4
        for <git@vger.kernel.org>; Fri, 05 Apr 2019 04:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vZmZIMqkRYDhLEET8WqLJxgIP18pkhpvT6vX0ONUW9I=;
        b=qSIt2uOrTVBJeb5UoTSG4Sh0SE8LJe4C6zznpeVUyyJt79HuZHBKFMl4S+4xSdweIQ
         AQFVnFffzjk3sPZND0WMxiNyzdQOA4WJIHuAS/FgWpgBmMeWCqJVwXbSO7BsUwMQ9FnB
         WUlXG4gPI6A2S/sr5lrOqih85YOENgb5tYh1OKctpmnWhJB89RsmeWysAzjGuV1d6Atv
         6iLupWfNrqcPg8q457G7R+5H7nDS+UDX6IDmbxkPmpDlFvaWuurwjYOZYZFGrNQOeXdR
         G44eo1sWFAJY1+IpmNXqFioPddxHdF6fT08sUZb3FPUzGbsq9iynL8PYDkpXqe9MJkq6
         ZQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vZmZIMqkRYDhLEET8WqLJxgIP18pkhpvT6vX0ONUW9I=;
        b=HQ4s+xhiTomKit+ShypxXa8D4xougBAsx23AGp/GCiPgNBZdHNHGFzHen+0yCGZ5kG
         Xl248TZ3/PI6opRn7LWvHOWfSR3rC3usK3WpeXUMfwk/M+rRZ0fALM3hTugjJWoqzyKd
         DLKevngUjmU6cPSPc7dQMnAuYwNUSSiGLVvaMCz5muU31O50srAXW8Qd4HRk7xdBabbz
         pAFtf9+eggJqzhEkrjSN9iUl6C6BJjWxs5au0f34yfJXuT74ouIbADO11u5A7+qEpPho
         d5cS9nLLe3rhTtJCEwM2v9UgLv7iCjFrhCt25GGJEKcUgtVxasGi6nnJPRSWY+93A+hh
         dlSA==
X-Gm-Message-State: APjAAAVUm9nN0rDP7CkEA1TMiKs8oRNG8zW7E/6iWqPVqyaVD+RgVNvP
        FPWzdJciu0NxyyUUvtuQiB0=
X-Google-Smtp-Source: APXvYqwuMgryl7evR5RhzlbJUFcMbXtbw2yZ5Iz8kXq/2Im9v0QdfcmnjegXSMsdPLz+kkEGQgtyAw==
X-Received: by 2002:a1c:2d91:: with SMTP id t139mr7506090wmt.102.1554462916410;
        Fri, 05 Apr 2019 04:15:16 -0700 (PDT)
Received: from szeder.dev (x4d0c3c70.dyn.telefonica.de. [77.12.60.112])
        by smtp.gmail.com with ESMTPSA id 67sm1758426wmz.41.2019.04.05.04.15.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 04:15:15 -0700 (PDT)
Date:   Fri, 5 Apr 2019 13:15:13 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 1/4] t3431: add rebase --fork-point tests
Message-ID: <20190405111513.GU32732@szeder.dev>
References: <20190328221745.GA3941@dev-l>
 <cover.1554151449.git.liu.denton@gmail.com>
 <234ac9f024bf4e6b4944fd8f3912cf6367cf828b.1554151449.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <234ac9f024bf4e6b4944fd8f3912cf6367cf828b.1554151449.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 01, 2019 at 01:51:57PM -0700, Denton Liu wrote:
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  t/t3431-rebase-fork-point.sh | 53 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100755 t/t3431-rebase-fork-point.sh
> 
> diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
> new file mode 100755
> index 0000000000..8e2483b73e
> --- /dev/null
> +++ b/t/t3431-rebase-fork-point.sh
> @@ -0,0 +1,53 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2019 Denton Liu
> +#
> +
> +test_description='git rebase --fork-point test'
> +
> +. ./test-lib.sh
> +
> +# A---B---D---E       (master)
> +#     \
> +#      C*---F---G (side)
> +#
> +# C was formerly part of master but is side out
> +#
> +test_expect_success setup '
> +	test_commit A &&
> +	test_commit B &&
> +	test_commit C &&
> +	git branch -t side &&
> +	git reset --hard HEAD^ &&
> +	test_commit D &&
> +	test_commit E &&
> +	git checkout side &&
> +	test_commit F &&
> +	test_commit G
> +'
> +
> +test_rebase() {
> +	expected="$1" &&
> +	shift &&
> +	test_expect_success "git rebase $@" "
> +		git checkout master &&
> +		git reset --hard E &&
> +		git checkout side &&
> +		git reset --hard G &&
> +		git rebase $@ &&
> +		test_write_lines $expected >expect &&
> +		git log --pretty=%s >actual &&
> +		test_cmp expect actual
> +	"
> +}
> +
> +test_rebase 'G F E D B A' ''

It appears that this last empty argument triggers some bug in Bash
v4.2 and older (and on macOS such an old Bash is the default /bin/sh),
as it turns that empty argument into something else, which in turn
fails the test with:

  <...>
  ++ git rebase $'\177'
  fatal: invalid upstream '?'
  error: last command exited with $?=128
  not ok 2 - git rebase

https://travis-ci.org/git/git/jobs/516070862#L2276

Omitting that empty argument avoids this issue, and the test still
checks what it was supposed to.

> +test_rebase 'G F D B A' '--onto D'
> +test_rebase 'G F C E D B A' '--no-fork-point'
> +test_rebase 'G F C D B A' '--no-fork-point --onto D'
> +test_rebase 'G F E D B A' '--fork-point refs/heads/master'
> +test_rebase 'G F D B A' '--fork-point --onto D refs/heads/master'
> +test_rebase 'G F C E D B A' 'refs/heads/master'
> +test_rebase 'G F C D B A' '--onto D refs/heads/master'
> +
> +test_done
> -- 
> 2.21.0.695.gaf8658f249
> 
