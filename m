Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB1192021E
	for <e@80x24.org>; Tue, 15 Nov 2016 20:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751790AbcKOUut (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 15:50:49 -0500
Received: from avasout03.plus.net ([84.93.230.244]:40672 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750772AbcKOUut (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 15:50:49 -0500
Received: from [10.0.2.15] ([194.75.29.46])
        by avasout03 with smtp
        id 8Lqm1u0010zhorE01LqnA8; Tue, 15 Nov 2016 20:50:47 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=YLLd8lOx c=1 sm=1 tr=0
 a=g54qAj+LxVGqXy9pVcJ+0w==:117 a=g54qAj+LxVGqXy9pVcJ+0w==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=ekSazU26hfyfeYyj8koA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] worktree: fix a sparse 'Using plain integer as NULL
 pointer' warning
To:     Nguyen Thai Ngoc Duy <pclouds@gmail.com>
References: <5b7d7d0b-8a6c-d516-4eb9-4e4ea13dce73@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <2bfa7559-7448-39a7-8da8-a539c7397d74@ramsayjones.plus.com>
Date:   Tue, 15 Nov 2016 20:50:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <5b7d7d0b-8a6c-d516-4eb9-4e4ea13dce73@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 15/11/16 20:28, Ramsay Jones wrote:
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
> 
> Hi Duy,
> 
> If you need to re-roll your 'nd/worktree-move' branch, could you
> please squash this into the relevant patch [commit c49e92f5c
> ("worktree move: refuse to move worktrees with submodules", 12-11-2016)].
> 
> Also, one of the new tests introduced by commit 31a8f3066 ("worktree move:
> new command", 12-11-2016), fails for me, thus:
> 
>   $ ./t2028-worktree-move.sh -i -v
>   ...
>   --- expected	2016-11-15 20:22:50.647241458 +0000
>   +++ actual	2016-11-15 20:22:50.647241458 +0000
>   @@ -1,3 +1,3 @@
>    worktree /home/ramsay/git/t/trash directory.t2028-worktree-move
>   -worktree /home/ramsay/git/t/trash directory.t2028-worktree-move/destination
>    worktree /home/ramsay/git/t/trash directory.t2028-worktree-move/elsewhere
>   +worktree /home/ramsay/git/t/trash directory.t2028-worktree-move/destination
>   not ok 12 - move worktree
>   #	
>   #		git worktree move source destination &&
>   #		test_path_is_missing source &&
>   #		git worktree list --porcelain | grep "^worktree" >actual &&
>   #		cat <<-EOF >expected &&
>   #		worktree $TRASH_DIRECTORY
>   #		worktree $TRASH_DIRECTORY/destination
>   #		worktree $TRASH_DIRECTORY/elsewhere
>   #		EOF
>   #		test_cmp expected actual &&
>   #		git -C destination log --format=%s >actual2 &&
>   #		echo init >expected2 &&
>   #		test_cmp expected2 actual2
>   #	
>   $ 
> 
> Is there an expectation that the submodules will be listed in

Er, that should read 'worktrees', of course! :(

ATB,
Ramsay Jones

