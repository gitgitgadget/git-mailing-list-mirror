Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4595B1F4BD
	for <e@80x24.org>; Thu, 10 Oct 2019 17:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfJJRT4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 13:19:56 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43335 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfJJRTz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 13:19:55 -0400
Received: by mail-qt1-f195.google.com with SMTP id t20so4449990qtr.10
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 10:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CQCIe5aG4DZ0AfHrKDd+gMimqH0atRhcLd5P2VsKSSM=;
        b=U6eb+qHsZrBTJwg5yaW+kDyxtjy/YpjU9vBSta2bpve6KzmddzHcR26uJChgq2mP+/
         sYmPGVvmYLuTbe8EtX3v+2UcgfumX934TGUuR4onRW8wz45NGbReM41SCkAmyDUKwo/H
         EAW9BEt+nutk/CQ+EYeo24DqneLvTXAN3oT8XA/lOy/h+7Ntb5VlGB+TlmZXNyvMCtJ0
         780YcamTioxCm9B4OoIXM6wI5f9RXlQDjkxhmldJw1NYCMjuBRDhuTWaKZ5uNyca3llV
         XE+QeTUpkZ50bUrrgQOqASZtaiN+0SI4BgPk503ahZi3we0URo5qdca7oom3eqPL53C0
         /chQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CQCIe5aG4DZ0AfHrKDd+gMimqH0atRhcLd5P2VsKSSM=;
        b=c30mZJARYL33+wF7RhW0lEz29io+NqXUKv6Uq55b8ADmVlAqt1bDdV62OrpXewUtki
         rVth2zSQZVDPO/mRJ/0ZaMhSAXYpcHUyuK6Hnn+6Y8rNZXpcBml1vN3IE8a0OZT5ij/b
         lT1RTCOacM083axCLtB6yobXIIjq72vMoXLq08mudG/xJIhy4yAcElzvxq4PVkXz9Hvh
         DtVYM91fSnuZCTMbN+SMSLei+iyhCYK/QfXPKSpYrJA9WGreOmwfhSOhabm8ok34SsrQ
         1eEl0MmX9HlYg/f5/bkfaM+xl3bsVwdnOpvIos4RZW2MQiBCO45R0+dXVc1u2I4ETREt
         ffuw==
X-Gm-Message-State: APjAAAXB4gnOsJHFppd0KSJsymPjXRI5LyHc7Xx+JH2sRdGloi5kyxPA
        aTIzmxmTX67l8rpK0wBumd5RiKfzvFs=
X-Google-Smtp-Source: APXvYqx2NvmZjOJiuIFqS4Ixka08vkFyoUfyt7xQN5zToWopFeQ6UqN+yZ0VCdSfXRcSN9Zw5GSeJw==
X-Received: by 2002:a0c:e64a:: with SMTP id c10mr3641621qvn.96.1570727994735;
        Thu, 10 Oct 2019 10:19:54 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:2da2:a6da:62ea:75d9? ([2001:4898:a800:1012:ded5:a6da:62ea:75d9])
        by smtp.gmail.com with ESMTPSA id j17sm2763528qki.99.2019.10.10.10.19.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2019 10:19:54 -0700 (PDT)
Subject: Re: [PATCH 06/11] graph: tidy up display of left-skewed merges
To:     James Coglan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        James Coglan <jcoglan@gmail.com>
References: <pull.383.git.gitgitgadget@gmail.com>
 <12c0916cb1ef033f917dc065cc1f18c0477296b8.1570724021.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5c688030-6351-93a3-89bd-e666d02d12d9@gmail.com>
Date:   Thu, 10 Oct 2019 13:19:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <12c0916cb1ef033f917dc065cc1f18c0477296b8.1570724021.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/10/2019 12:13 PM, James Coglan via GitGitGadget wrote:
> From: James Coglan <jcoglan@gmail.com>
> 
> Currently, when we display a merge whose first parent is already present
> in a column to the left of the merge commit, we display the first parent
> as a veritcal pipe `|` in the GRAPH_POST_MERGE line and then immediately
> enter the GRAPH_COLLAPSING state. The first-parent line tracks to the
> left and all the other parent lines follow it; this creates a "kink" in
> those lines:
> 
>         | *---.
>         | |\ \ \
>         |/ / / /
>         | | | *
> 
> This change tidies the display of such commits such that if the first
> parent appears to the left of the merge, we render it as a `/` and the
> second parent as a `|`. This reduces the horizontal and vertical space
> needed to render the merge, and makes the resulting lines easier to
> read.
> 
>         | *-.
>         |/|\ \
>         | | | *
> 
> If the first parent is separated from the merge by several columns, a
> horizontal line is drawn in a similar manner to how the GRAPH_COLLAPSING
> state displays the line.
> 
>         | | | *-.
>         | |_|/|\ \
>         |/| | | | *
> 
> This effect is applied to both "normal" two-parent merges, and to
> octopus merges. It also reduces the vertical space needed for pre-commit
> lines, as the merge occupies one less column than usual.
> 
>         Before:         After:
> 
>         | *             | *
>         | |\            | |\
>         | | \           | * \
>         | |  \          |/|\ \
>         | *-. \
>         | |\ \ \
> 

Thank you for adding these careful diagrams both to the message
and the code. These concepts are hard to track without a visual
aid.

[snip]

> +++ b/t/t4215-log-skewed-merges.sh
> @@ -0,0 +1,42 @@
> +#!/bin/sh
> +
> +test_description='git log --graph of skewed merges'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup left-skewed merge' '


Could you skew this example to include a left-skewed octopus merge
(and use fewer Git processes) with the following:

	git checkout --orphan _a && test_commit A &&
	git switch -c _b _a && test_commit B &&
	git switch -c _c _a && test_commit C &&
	git switch -c _d _a && test_commit D &&	git switch -c _e _b && git merge --no-ff _c _d E &&
	git switch -c _f _a && git merge --no-ff _d -m F &&	git checkout _a && git merge --no-ff _b _c _e _f -m G
and I think the resulting output will be:

*-----.   G
|\ \ \ \
| | | | * F
| |_|_|/|
|/| | | |
| | | * | E
| |_|/|\|
|/| | | |
| | |/  * D
| |_|__/
|/| |
| | * C
| |/
|/|
| * B
|/
* A



