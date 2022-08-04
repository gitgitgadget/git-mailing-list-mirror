Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F5DC19F2A
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 14:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238009AbiHDO1C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 10:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiHDO1A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 10:27:00 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3BA65E4
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 07:26:59 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id l4so25483455wrm.13
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 07:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aq1ZlsP1P/+BGRfhbiyMiAW3tsKIAOOduiDahjbOlTE=;
        b=V6fvaoKzyQBlJNXjQKYtAPxbBwuSFkOjZDByxm84Lzt44zsAh+bVThPfQ1gKiqmrB9
         oO/xm8vRqIzUVmJXG6PpQ+V8SQkVe3Fz/Kra2EHJS2+tHRDkU03XcX5PF9Jg6pHxZwGM
         cpg0YQYYGGt9wIdIoDg/wIPSYshIYE6vEfFrVfkh11IzWc8wTnIc0DKp2ZDWcBsqnUIM
         gJgKOjIXI0tyZfioU+YcyVG7A0h5bF0zvz2wVbxDhHmS1Xp95e/T0EBsppRkdBGN7DRf
         WuiFAcwWa7e3rnv3vrlznWduPC2+8nGEthTjJn9sAvxIm1Qv4bGZeNaz2VqzOLTPPvA7
         X7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aq1ZlsP1P/+BGRfhbiyMiAW3tsKIAOOduiDahjbOlTE=;
        b=WUqVFEm+w9zWOuZj6mAqUWBExF6IGl56j+P0siScU2sizPBo199qb3SBYipuR5G/10
         gB4r37Y4ZQeX/xz10Skqgvx5kPkh28IGjjmTzrb9M/wsLSWEHBRzDZ7TYA1iPPLhQH3V
         v/9t5WziJTRgXK+r8FAZbLXvTIkCnQgc6DA26A+OCGJwsk8XnmZJ54Fp/C1uXi6aCYRy
         fdSwNdezwMoogTFmp1tVQpGz4DkvMJMzCcsbKqZFu/Ie0c/ROHnAs0xQzduu8KqMl6Tk
         Qz2frdzdGktpAjMOd4mG8fHHEdkzLz5/8FQHOu+QtMZ5nR9EN2d9n/Xfm3QXSS+UnKou
         1CWw==
X-Gm-Message-State: ACgBeo1VoRLjs1g5K0zb0vvxsrbs1Z6T0gwice+fbNYX4JUXDwJ47q8m
        fEkWmN7Y/7PMX0U6ILd46S91WpsZV5A=
X-Google-Smtp-Source: AA6agR75MDYpbMQZbxgphi3kILyhi+Jx5hxzRPCq1ahtNia+I6rdvyXCCRO/VURzFy6KRaQErLwZpQ==
X-Received: by 2002:a5d:4852:0:b0:21f:17e:bffd with SMTP id n18-20020a5d4852000000b0021f017ebffdmr1602036wrs.542.1659623218230;
        Thu, 04 Aug 2022 07:26:58 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id c10-20020adffb4a000000b0021f1ec8776fsm1252279wrs.61.2022.08.04.07.26.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 07:26:57 -0700 (PDT)
Message-ID: <fd0dcbcd-87dd-57e8-f7ec-418d2b726309@gmail.com>
Date:   Thu, 4 Aug 2022 15:26:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] tests: cache glibc version check
Content-Language: en-GB-large
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1311.git.1659620305757.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1311.git.1659620305757.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/08/2022 14:38, Phillip Wood via GitGitGadget wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> 131b94a10a ("test-lib.sh: Use GLIBC_TUNABLES instead of MALLOC_CHECK_
> on glibc >= 2.34", 2022-03-04) introduced a check for the version of
> glibc that is in use. This check is performed as part of
> setup_malloc_check() which is called at least once for each test. As
> the test involves forking `getconf` and `expr` cache the result and
> use that within setup_malloc_check() to avoid forking these extra
> processes for each test.
> 
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>      tests: cache glibc version check
>      
>      A recent discussion on the list[1] reminded me that this patch was
>      waiting to be sent
[1] https://lore.kernel.org/git/YuL7EotrIpnOn5BT@coredump.intra.peff.net/

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1311%2Fphillipwood%2Fwip%2Ftest-cache-glibc-tunables-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1311/phillipwood/wip/test-cache-glibc-tunables-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1311
> 
>   t/test-lib.sh | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 7726d1da88a..ad81c78fce7 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -557,14 +557,19 @@ then
>   		: nothing
>   	}
>   else
> +	_USE_GLIBC_TUNABLES=
> +	if _GLIBC_VERSION=$(getconf GNU_LIBC_VERSION 2>/dev/null) &&
> +	   _GLIBC_VERSION=${_GLIBC_VERSION#"glibc "} &&
> +	   expr 2.34 \<= "$_GLIBC_VERSION" >/dev/null
> +	then
> +		_USE_GLIBC_TUNABLES=YesPlease
> +	fi
>   	setup_malloc_check () {
>   		local g
>   		local t
>   		MALLOC_CHECK_=3	MALLOC_PERTURB_=165
>   		export MALLOC_CHECK_ MALLOC_PERTURB_
> -		if _GLIBC_VERSION=$(getconf GNU_LIBC_VERSION 2>/dev/null) &&
> -		   _GLIBC_VERSION=${_GLIBC_VERSION#"glibc "} &&
> -		   expr 2.34 \<= "$_GLIBC_VERSION" >/dev/null
> +		if test -n "$_USE_GLIBC_TUNABLES"
>   		then
>   			g=
>   			LD_PRELOAD="libc_malloc_debug.so.0"
> 
> base-commit: 23b219f8e3f2adfb0441e135f0a880e6124f766c
