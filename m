Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D005208E9
	for <e@80x24.org>; Sun, 29 Jul 2018 22:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731659AbeG3ASc (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jul 2018 20:18:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33305 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731611AbeG3ASc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jul 2018 20:18:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id g6-v6so10762491wrp.0
        for <git@vger.kernel.org>; Sun, 29 Jul 2018 15:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=q1r9Cfap6yrRoQqNzcJxhROuYSngxJaZwG3sUa/7lAE=;
        b=QW0ts8fhy1jeAu9jQpEwrC2bxr4ouGqevkYjL960/f04R+Uqj07BlXSyZ4Oclfcxb8
         l+/8d+ka+8whwildA2vNgjqCMEcz/ZrgF6Y/nJUlekrFEwQHezhqBdznSVoFSok5a69p
         8B0atEn7XAOujDrqw5roVJOIZkP9sLUOG09HqkqUPXOpud8A7txTQ1k2nxIRMJQdEoVo
         OO9o+ygt2iEkGlaUCSzrIDrnOKk9LAqvskAjnizfK/sxqDhDh9Y0OY+i3FRD7mNoOMfq
         iR4UfR+H2b00MdGtT5Uyp6uhkWFL3ew2ShHDv0BZubIiQvl51DEZdmcindGYAeiIyyr4
         IQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=q1r9Cfap6yrRoQqNzcJxhROuYSngxJaZwG3sUa/7lAE=;
        b=nfmH+8TCr9OYQRZJPjlXn1OvE4GKfrAzL/BkYQ3oDQ51GdFh0w7mGrX5vX/gB2YXPy
         NeXZv9DJiZENSkS3c3uHYn8NGKWrVgKQrG/3wBrjFUZdOUP6uAfPB4lWQvAtLlCJuWlM
         2swggwvJPsqnNPToViOYW0T5QLDPFu3zM0f1Z2een9ZI4+snfmc6HVm8lIOyxOcOk7Mw
         co/9gVStezFkmH4MtSI+PSDVRv5guJJHObkWk1/PjgyJSsQFWIRgHy2LisjIff8M0ffC
         xpcaeSXinUBQyFLMCU4P8U1EAIL2JOlRCCz1p1c65k/vGJdzdx3tG2kj3BOpF2fHusMi
         CxpA==
X-Gm-Message-State: AOUpUlF4NAl2ON+6ZOTv6q+RKGun58C/lrcYmJJa6aACb/Na7JiJrGy/
        1z/NuxMdz2gf9iVGMBWD9XB/RcPK
X-Google-Smtp-Source: AAOMgpecFwpelpSo+MaU1kNQayDpGfxolcaysXJyELq5tMvGCrZNbJ2P0XmOqHu2uBQRnNRFf5nTBA==
X-Received: by 2002:adf:f390:: with SMTP id m16-v6mr14446264wro.279.1532904383483;
        Sun, 29 Jul 2018 15:46:23 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abuo246.neoplus.adsl.tpnet.pl. [83.8.186.246])
        by smtp.gmail.com with ESMTPSA id z14-v6sm15805274wrr.71.2018.07.29.15.46.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Jul 2018 15:46:22 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/8] commit-graph: not compatible with uninitialized repo
References: <pull.11.git.gitgitgadget@gmail.com>
        <5314a5a93dfc224edd995fa12d195087c4685208.1531926932.git.gitgitgadget@gmail.com>
Date:   Mon, 30 Jul 2018 00:46:21 +0200
In-Reply-To: <5314a5a93dfc224edd995fa12d195087c4685208.1531926932.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 18 Jul 2018
        08:15:44 -0700 (PDT)")
Message-ID: <86600x7j9e.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

[I hope that the rest of replies would make it all right through
GitGitGadget]

> From: Derrick Stolee <dstolee@microsoft.com>
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-graph.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 5097c7c12..233958e10 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -60,6 +60,9 @@ static struct commit_graph *alloc_commit_graph(void)
>  
>  static int commit_graph_compatible(struct repository *r)
>  {
> +	if (!r->gitdir)
> +		return 0;
> +

Nice catch.

I wonder if this is the problem because of the following tests (in which
case this test should probably be earlier in this series), or not (and
it doesn't need to).

I wonder how this issue was caught.

>  	prepare_commit_graft(r);
>  	if (r->parsed_objects && r->parsed_objects->grafts_nr)
>  		return 0;

No tests?
