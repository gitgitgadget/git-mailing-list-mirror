Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4EC21FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 16:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965411AbdDSQJC (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 12:09:02 -0400
Received: from avasout08.plus.net ([212.159.14.20]:49720 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753718AbdDSQHb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 12:07:31 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout08 with smtp
        id AG7U1v0021keHif01G7VkB; Wed, 19 Apr 2017 17:07:29 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=B5zJ6KlM c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=CFEPcICK-Rigl86eZYUA:9 a=QEXdDO2ut3YA:10
 a=6kGIvZw6iX1k4Y-7sg4_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v3 08/12] refs: remove dead for_each_*_submodule()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170419110145.5086-1-pclouds@gmail.com>
 <20170419110145.5086-9-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael Haggerty <mhagger@alum.mit.edu>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <bc3795da-4d9e-ac57-a011-28017494a71d@ramsayjones.plus.com>
Date:   Wed, 19 Apr 2017 17:07:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170419110145.5086-9-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 19/04/17 12:01, Nguyễn Thái Ngọc Duy wrote:
> These are used in revision.c. After the last patch they are replaced
> with the refs_ version. Delete them (except for_each_remote_ref_submodule
> which is still used by submodule.c)
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  Documentation/technical/api-ref-iteration.txt |  7 ++-----
>  refs.c                                        | 29 ---------------------------
>  refs.h                                        |  9 ---------
>  3 files changed, 2 insertions(+), 43 deletions(-)
> 
> diff --git a/Documentation/technical/api-ref-iteration.txt b/Documentation/technical/api-ref-iteration.txt
> index 37379d8337..c9e9a60dbd 100644
> --- a/Documentation/technical/api-ref-iteration.txt
> +++ b/Documentation/technical/api-ref-iteration.txt
> @@ -32,11 +32,8 @@ Iteration functions
>  
>  * `for_each_glob_ref_in()` the previous and `for_each_ref_in()` combined.
>  
> -* `head_ref_submodule()`, `for_each_ref_submodule()`,
> -  `for_each_ref_in_submodule()`, `for_each_tag_ref_submodule()`,
> -  `for_each_branch_ref_submodule()`, `for_each_remote_ref_submodule()`
> -  do the same as the functions described above but for a specified
> -  submodule.
> +* Use `refs_` API for accessing submodules. The submodule ref store could
> +  be obtained with `get_submodule_ref_store().

missing ` ? ------------------------------------^

ATB,
Ramsay Jones

