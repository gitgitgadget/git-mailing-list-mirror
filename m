Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5B3C433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 15:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239108AbiEXPzB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 11:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbiEXPzA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 11:55:00 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4925B91549
        for <git@vger.kernel.org>; Tue, 24 May 2022 08:54:59 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id AE2BB3F414D;
        Tue, 24 May 2022 11:54:58 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 7D30A3F412C;
        Tue, 24 May 2022 11:54:58 -0400 (EDT)
Subject: Re: [PATCH 0/4] ci: fix windows-build with GCC v12.x
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1238.git.1653351786.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <a9062373-5347-4bfc-226a-fc9e892384f2@jeffhostetler.com>
Date:   Tue, 24 May 2022 11:54:57 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <pull.1238.git.1653351786.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/23/22 8:23 PM, Johannes Schindelin via GitGitGadget wrote:
> A recent update of GCC in Git for Windows' SDK (a subset of which is used in
> Git's CI/PR builds) broke the build.
> 
> These patches address that, and they are based on maint-2.34 (earlier
> maintenance tracks would have a trivial merge conflict due to 013c7e2b070
> (http: drop support for curl < 7.16.0, 2021-07-30) removing support for
> USE_CURL_MULTI).
> 
> Johannes Schindelin (4):
>    compat/win32/syslog: fix use-after-realloc
>    nedmalloc: avoid new compile error
>    http.c: avoid danging pointer to local variable `finished`
>    dir.c: avoid "exceeds maximum object size" error with GCC v12.x
> 
>   compat/nedmalloc/nedmalloc.c |  1 -
>   compat/win32/syslog.c        |  2 ++
>   dir.c                        |  9 +++++++++
>   http-walker.c                |  4 ----
>   http.c                       | 15 +++++++--------
>   http.h                       |  2 +-
>   6 files changed, 19 insertions(+), 14 deletions(-)
> 
> 
> base-commit: 2f0dde7852b7866bb044926f73334ff3fc30654b
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1238%2Fdscho%2Ffix-win-build-with-gcc-12-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1238/dscho/fix-win-build-with-gcc-12-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1238
> 

This looks good to me.  I reviewed it earlier in one of our
downstream forks.

Jeff
