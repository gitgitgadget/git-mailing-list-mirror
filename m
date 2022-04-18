Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54526C433F5
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 18:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347395AbiDRSkx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 14:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiDRSkw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 14:40:52 -0400
Received: from smtp-out-4.talktalk.net (smtp-out-4.talktalk.net [62.24.135.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D180411A2C
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 11:38:11 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.talktalk.net with SMTP
        id gWGFnys7MW5NogWGGnuTwO; Mon, 18 Apr 2022 19:38:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1650307089;
        bh=GOom4bj1HQnafqxEvgFrnVhTZTx4U0Wu/ZtvqkAPqV0=;
        h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To;
        b=S9SQjo6zepRi83AQXXTrdu7uYmn33GxYVj7QFlwn5lMxHqHnOK41vSQjzNvlszya2
         0+7ZJ0W22ZJNxRhrcd85WGV7Mh6Zz9B58qiBhVhVv+63ZBozsWFgkbp4mvkEUrjGj+
         TjC3O3B0+r4Vs14xzMEEEJP6ZP5MoY7B+E2LPEpU=
X-Originating-IP: [31.185.185.192]
X-Spam: 0
X-OAuthority: v=2.3 cv=LeRCFQXi c=1 sm=1 tr=0 a=BhDTt+XCViy/yeGwkgzVOQ==:117
 a=BhDTt+XCViy/yeGwkgzVOQ==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=Ydq8CWi30aKBOekM5k0A:9 a=QEXdDO2ut3YA:10
Message-ID: <55271bbe-7b6e-7c92-7337-2439a2f5be26@talktalk.net>
Date:   Mon, 18 Apr 2022 19:38:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 30/31] CI: have osx-gcc use gcc, not clang
Content-Language: en-GB-large
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
 <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
 <patch-v4-30.31-94abb826627-20220418T132809Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
In-Reply-To: <patch-v4-30.31-94abb826627-20220418T132809Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfGURfz4LQR0VCsM1xvR+KXF/PmV5m3ZtzFgC+xTLPip7lzmq9+AMY/CpApgzonIx76tqvpo4y+I0wDr6F5Ld98dCiPo+y9sgIE6LSvKZktxnpA7S6pD+
 hEov3Gl3gWlGU2rO5iSSpL5hqRM+MQI/Ztm4Xwgisv4q2/7nK9XI1vDwThOB89tRoG6OUHDTiHkUrOXOFfPYC9Ud6NxH9vEDg+1IFWUuA5t1oj5ETTFP6MJF
 8qTxKqDBvfTZari0ZgFbqVa8vKmBAu41m00YZSqVtEZreXL7K5EYP3UK6nAxepQeaxV05N7nwsXwB4oJfzIbm/jyDZRAKvPLPPP9S6xDDuZ2Z/T7GCKFc6tw
 mBOqdrGQQN7a6MO1UMl7BvKLNuMjHyrpcsNMd/ciNCirkzoSxgdG5Wy17hjjWAWWlRc7tmCrUtpAy3AXPFNJWzWaBwNe0k5Z7v1AVKjqDbglw91L8R9Ak73r
 YclDkwI7RU6+QeBOJENlEDon6YQ3xLCcLmZOiAVc4DkU2clcp6OlZYMyjNU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/04/2022 17:29, Ævar Arnfjörð Bjarmason wrote:
> Fix a regression in 707d2f2fe86 (CI: use "$runs_on_pool", not
> "$jobname" to select packages & config, 2021-11-23). In that commit I
> changed CC=gcc from CC=gcc-9, but on OSX the "gcc" in $PATH points to
> clang, we need to use gcc-9 instead.

As this is fixing a bug in master, perhaps it would be better as a 
separate patch that can be merged before this series (this series could 
be rebased on to the fix)

Best Wishes

Phillip

> Reported-by: Carlo Arenas <carenas@gmail.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   ci/lib.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/ci/lib.sh b/ci/lib.sh
> index ab7546800e0..8f80be4c3df 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -179,7 +179,7 @@ linux-TEST-vars)
>   	;;
>   osx-gcc)
>   	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
> -	CC=gcc
> +	CC=gcc-9
>   	;;
>   osx-clang)
>   	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python2)"

