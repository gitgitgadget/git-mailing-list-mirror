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
	by dcvr.yhbt.net (Postfix) with ESMTP id 42F611F4C0
	for <e@80x24.org>; Thu, 10 Oct 2019 17:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfJJRy7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 13:54:59 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40145 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfJJRy7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 13:54:59 -0400
Received: by mail-qt1-f195.google.com with SMTP id m61so9950404qte.7
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 10:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/mQKdUf8/xbySizGl+P4HI1kzQ0YWqQORsaVZ3Kugsw=;
        b=kHiyUPFULJSYfXzda0DCqMsHdLBKNs8B1IxX8Fu1d6yixJJNzpfA8FdzncKMmpdxgb
         iLRZ8Axx3K4LgZgFH23pP3lOYDI3ryL8VpijBhPhluGE3zyT3FnWISbqBnFG6OlX/wCg
         G5RNobxFV4VtXtiSQ4CEdlHajR0E8vY/rOMvhZ+sn9VMz4BMotTixJAp1Ldje+/2dMBt
         9nGuxW+ZUQ8/Uvvi6O6UoYBpuj7rAsCMs1Q4h4RheWpODVf+2c8uoqlFq+6WPPkI4Wce
         V8To6btImapAtp8ng0qc6zSwLF3Mlx+00gc8JhrFyR0jTZYfRC5GBPnxr3Andmka12/A
         sImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/mQKdUf8/xbySizGl+P4HI1kzQ0YWqQORsaVZ3Kugsw=;
        b=gi9jvEDxFffBE7i+vqiiJNp2uK5T8cZ6XTO/BqW/nM3++yHF8zOvMiuXNpGxXpOvbe
         ADoXSrF6esgJfjZbh6ANzWXKwTmKNO0MSzdRwa+6jX761uSpaH3rO8ilza1D0MRfh3qX
         esduMaQH+GyObYkGX/GdwArjhkTfTro1EHCRQ0lPtBo6LxzEI4PnCuE8onrcN73eVwZh
         NC8lnPK06zoRZb0FikZFR9pBBp0iR4IEACTw/hngMDljLrl9ror9FMsd72yP2f1u4NjM
         LCKuaLRG/7QzrTZJzxLyRVxHbwnGVSLKGMdgoB4EjJ2mRY0WW7HJVT8tQic1k1r+4VNP
         pF1A==
X-Gm-Message-State: APjAAAWQpg5KKG2Nk5u8Rux8mXxdT9S9O/Ot2FR2rviV2m5k5zfa04E7
        U9G7qpvEpv2XjHzStasMf5k=
X-Google-Smtp-Source: APXvYqxAkpPM8Ilz2G89T4pqsEhZnwKnefdRZKb4NUFMBmqjT2MU1oCfhVv2CwSYNwlQY0nKgeMFew==
X-Received: by 2002:a0c:e5c6:: with SMTP id u6mr11388207qvm.106.1570730098146;
        Thu, 10 Oct 2019 10:54:58 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:2da2:a6da:62ea:75d9? ([2001:4898:a800:1010:ded7:a6da:62ea:75d9])
        by smtp.gmail.com with ESMTPSA id k17sm4072421qtk.7.2019.10.10.10.54.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2019 10:54:57 -0700 (PDT)
Subject: Re: [PATCH 00/11] Improve the readability of log --graph output
To:     James Coglan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <pull.383.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0a35a944-cbf4-06c8-f327-26728f95fbed@gmail.com>
Date:   Thu, 10 Oct 2019 13:54:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <pull.383.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/10/2019 12:13 PM, James Coglan via GitGitGadget wrote:
> This series of patches are designed to improve the output of the log --graph
> command; their effect can be summed up in the following diagram:
> 
>     Before                    After
>     ------                    -----
> 
>     *
>     |\
>     | *                       *
>     | |\                      |\
>     | | *                     | *
>     | | |                     | |\
>     | |  \                    | | *
>     | *-. \                   | * |
>     | |\ \ \                  |/|\|
>     |/ / / /                  | | *
>     | | | /                   | * |
>     | | |/                    | |/
>     | | *                     * /
>     | * |                     |/
>     | |/                      *
>     * |
>     |/
>     *

I took a brief look through your series, and I think this is a really
cool improvement. I use "git log --graph" all the time and those kinks
have bothered me, too.

I'd give you extra bonus points if your first patch added the case on
the left as an expected output and we watch it get simpler as you modify
the behavior in pieces.

I do really like how you isolated different transformations into
different commits. I would have given more specific feedback if I
was more familiar with graph.c. I'll need to play with it more to
give more substantive feedback.

The only thing I could complain about in the first glance is some
test file formatting stuff, like how you split a test case into
"setup" "create expected output" and "test the output". That would
be better as one test. Also you add a space between your redirect
character and your file ("> expect" instead of ">expect").

Those nits aside, I look forward to digging into the code more
soon.

Thanks,
-Stolee
