Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7452D1F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 21:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753984AbdAZVsw (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 16:48:52 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:5320 "EHLO bsmtp5.bon.at"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753735AbdAZVst (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 16:48:49 -0500
Received: from bsmtp3.bon.at (unknown [192.168.181.104])
        by bsmtp5.bon.at (Postfix) with ESMTPS id 3v8bBD2Xbhz5v8c
        for <git@vger.kernel.org>; Thu, 26 Jan 2017 22:47:48 +0100 (CET)
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 3v8b906KFLz5tm2;
        Thu, 26 Jan 2017 22:46:44 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 465FC1E70;
        Thu, 26 Jan 2017 22:46:44 +0100 (CET)
Subject: Re: [PATCH] git-bisect: allow running in a working tree subdirectory
To:     marcandre.lureau@redhat.com
References: <20170126183030.28632-1-marcandre.lureau@redhat.com>
Cc:     git@vger.kernel.org, chriscool@tuxfamily.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <96afaa1d-31d7-0b7e-d2b3-77a455158638@kdbg.org>
Date:   Thu, 26 Jan 2017 22:46:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170126183030.28632-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.01.2017 um 19:30 schrieb marcandre.lureau@redhat.com:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>
> It looks like it can do it.
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  git-bisect.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/git-bisect.sh b/git-bisect.sh
> index ae3cb013e..b0bd604d4 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -1,5 +1,6 @@
>  #!/bin/sh
>
> +SUBDIRECTORY_OK=Yes
>  USAGE='[help|start|bad|good|new|old|terms|skip|next|reset|visualize|replay|log|run]'
>  LONG_USAGE='git bisect help
>  	print this long help message.
>

Does it also work to drive git bisect from a subdirectory and pass a 
file name (or pathspec) that is relative to that subdirectory rather 
than relative to the root of the worktree? Can `git bisect good` or `git 
bisect bad` of later bisection steps be invoked from different 
subdirectories or the root?

-- Hannes

