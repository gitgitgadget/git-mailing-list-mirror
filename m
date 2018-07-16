Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F3641F597
	for <e@80x24.org>; Mon, 16 Jul 2018 21:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbeGPVx4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 17:53:56 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:38260 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbeGPVx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 17:53:56 -0400
Received: by mail-yw0-f181.google.com with SMTP id r3-v6so14731039ywc.5
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 14:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lEBx8DKhExDZF5IJNPk+wnebP0kHsMGMmc8QgPDQDUY=;
        b=RR/CkwH7U8ptygupwHAW2WLigrV+NLu7Ca3uh6OJjri8k/veH6bqbfEEOL0t5c2Y7C
         rFqjSvxRCIbWTEFNEuBz4FTCUwmN4vpFLuyhy+scAlREbu2XVLBRvn0V8hskwcngGtz/
         OgCw7E0KsX/8B+OnMz+o1qWQ/1peyEbQ8J+mOTqakg1xJ3vCudZMpQiERt6+gkm/ruX5
         XSlchLdceqGiSB4NBjr357YxNbO53l6qKHBwXXcCN+yhlyDAFvNUvfexCDloJfPD1MD+
         PTeJcTFqMEc7G4084I39Ssqh8ejiG5z3XcwhKFL7gdansuPchnV359KK7nDfBIPpsLtt
         7tTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lEBx8DKhExDZF5IJNPk+wnebP0kHsMGMmc8QgPDQDUY=;
        b=hoHWA7kJz5CWen8Sae78x6nsoB31M0vpjPHyt+BIQEcpa7nqGSGpzR5ncRaN7lqHub
         AExMeYpaxdwJUTNSnqNeBdYK1a1/+oBoceVI8SlVm/TpPAbKx5mZpzLcEFGQLgUoHzhb
         VGBbCdNEOXo1qRSh23njGzjJUlGd76TxN1t6nr4Ig/Jug2E1k6MX1b/4pdyGxIr1ENPX
         ppc2125E+0Su3PVg/dCIPz4PJJfUTcpY3o11ejj7Lx0DQbFwjdp3C9gok6G9k1GfYrP/
         y1XSL4fu20CDPbWynuffc8km4LrhVJ+P9Y1QIUBzBF20ULYxtsq2AhJ5D6QGQMQrxrvC
         3WjQ==
X-Gm-Message-State: AOUpUlEqULs+EHmb1atGPcYmBQvpp8h8URsKAqE7bfkkzmFGhLQuf882
        3vxzW1Uifh5Nj7A7NJHHAiJX7QPIRe/jIktDXNC0nw==
X-Google-Smtp-Source: AAOMgpdETTiwcCc4m0VbaXPgj/9SFOajiRWkeeMWwwuO/3fgmnkTAXu13iOUoDQsmL2msQWBnOMdaWgiNMmOc/jk9wc=
X-Received: by 2002:a81:af67:: with SMTP id x39-v6mr8901369ywj.33.1531776280973;
 Mon, 16 Jul 2018 14:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <pull.10.git.gitgitgadget@gmail.com> <7a3e3815c585dd3972e9bea6798a7664232157a3.1531746012.git.gitgitgadget@gmail.com>
In-Reply-To: <7a3e3815c585dd3972e9bea6798a7664232157a3.1531746012.git.gitgitgadget@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 16 Jul 2018 14:24:30 -0700
Message-ID: <CAGZ79ka921=OxV9FUQWx2=yxeoSsWPzVMLYQR_2zq=DJ6=puRA@mail.gmail.com>
Subject: Re: [PATCH 11/16] test-reach: test get_merge_bases_many
To:     gitgitgadget@gmail.com
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +test_expect_success 'get_merge_bases_many' '
> +       cat >input <<-\EOF &&
> +               A:commit-5-7
> +               X:commit-4-8
> +               X:commit-6-6
> +               X:commit-8-3
> +       EOF
> +       {
> +               printf "get_merge_bases_many(A,X):\n" &&
> +               git rev-parse commit-5-6 &&
> +               git rev-parse commit-4-7

Please call rev-parse only once, giving both tips as argument, i.e.

               printf "get_merge_bases_many(A,X):\n" &&
               git rev-parse commit-5-6 \
                             commit-4-7

ought to produce the same output

Thanks,
Stefan
