Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CE3C1F453
	for <e@80x24.org>; Mon, 24 Sep 2018 11:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbeIXREx (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 13:04:53 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:22278 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbeIXREx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 13:04:53 -0400
Received: from [192.168.2.201] ([92.28.142.68])
        by smtp.talktalk.net with SMTP
        id 4Oe7gLfDmVlGZ4Oe8gJ6Tn; Mon, 24 Sep 2018 12:03:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1537787000;
        bh=te4G4TlPxYlboiylsnE9ntDFRHPhkHBAnUyXl8JfZNU=;
        h=Reply-To:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=Tix+/dcw4GgG7pI4iKE2o+fr/XJg0JGOFDPMvFq9fqfTPRMVs4ti5jpEzlSXkbrOK
         PiWcbzYDRclDbT0g0G+Z3dj3kF01bZG86J/Q8jOZjMOEDflbrQ709JPYim/aY1DBQM
         sj5W5pD0ah07FD1FrBY26XpLgXWU7Fu5qW3a5+GE=
X-Originating-IP: [92.28.142.68]
X-Spam: 0
X-OAuthority: v=2.3 cv=JcuSU3CV c=1 sm=1 tr=0 a=UGDAwvN9cmeZh0o4udnnNw==:117
 a=UGDAwvN9cmeZh0o4udnnNw==:17 a=IkcTkHD0fZMA:10 a=evINK-nbAAAA:8
 a=HQ39BNQE6yf-fLrwKi4A:9 a=QEXdDO2ut3YA:10 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC PATCH 0/3] diff --color-moved-ws: allow mixed spaces and
 tabs in indentation change
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20180924100604.32208-1-phillip.wood@talktalk.net>
Message-ID: <c5edcdcb-0c15-0c03-2dd0-4c7c8c0289ec@talktalk.net>
Date:   Mon, 24 Sep 2018 12:03:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180924100604.32208-1-phillip.wood@talktalk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOikX3F5LAkz48Iokmi9qXz+iZ+uYpW41S61fHp3bM/Bv4eeD0L2xMBv9T2bTGSHlkn1zJG0ONVnMbRtclYutW889H5WDU5R9+eJ9Otx7Ek4sAh2dX1L
 YbBE7g0j+5zL3dSjVWrfYjgDiE8UVmyZV/y/34CXWmKFuT2PojghgL/R4WI4e8rAZUv8licy1uY6yHyWa3ZFOelArvragqSGP5m/MEm08AOlfxLwZG+i3WQJ
 A9qxHBNk0jB6am8CDhjfbA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/09/2018 11:06, Phillip Wood wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> When trying out the new --color-moved-ws=allow-indentation-change I
> was disappointed to discover it did not work if the indentation
> contains a mix of spaces and tabs. This series adds a new option that
> does. It's and RFC as there are some open questions about how to
> proceed, see the last patch for details. Once there's a clearer way
> forward I'll reroll with some documentation changes.
> 

I should have said that this series is based on top of fab01ec52e
("diff: fix --color-moved-ws=allow-indentation-change", 2018-09-04), the
result merges into current master without conflicts.

Best Wishes

Phillip

> Phillip Wood (3):
>   xdiff-interface: make xdl_blankline() available
>   diff.c: remove unused variables
>   diff: add --color-moved-ws=allow-mixed-indentation-change
> 
>  diff.c                     | 124 ++++++++++++++++++++++++++++++++-----
>  diff.h                     |   1 +
>  t/t4015-diff-whitespace.sh |  89 ++++++++++++++++++++++++++
>  xdiff-interface.c          |   5 ++
>  xdiff-interface.h          |   5 ++
>  5 files changed, 208 insertions(+), 16 deletions(-)
> 

