Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF99C4332F
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 09:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiKCJmj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 05:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiKCJmh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 05:42:37 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A533CDF98
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 02:42:36 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id bk15so1715227wrb.13
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 02:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GB6StLQ8Kemhudeait7yGDeSuL600NpMuz9YRXeEMA4=;
        b=Ncpa8Jfk8pBgTHuec9BWY+iMdyIRDjghPh5ps6fTIG58HjyVmIxqdz92Nt3OFbyb5s
         j67Jl+QjusohWjgyTXSywg0vzhYkxwlmlslxboNUUaAU2nkNOUdWJJxptYu7l9wtpBDJ
         cvBQ/BKrl/PMOsH69EJn+AiSkpQFhfkAOVw7l/HVed9ecLbkBSPlv16u2aqqQtBL9f2i
         A13k1XbtTAL4qD1+PuxYLRqoOVDXCMA7EUporPaKL1A3pwvU1YOnabMKRy0cUFjZDAvs
         KxOlAhKPkHi7Jf2fHTcsnTgvvFeW2SdcB0SaKbPE4X9aw2So0a0g0JdtLZaOjm4w39Nh
         eS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GB6StLQ8Kemhudeait7yGDeSuL600NpMuz9YRXeEMA4=;
        b=NmGdKK+BOjeLL2RViqB5kKUBNviO6JorCriUSszTxPM7y/cHj7i5gh1LJUhN8YIJ7S
         6WYHDh09DP0fJZup+MQwRyTF4/wC8SQ2/hQ1Uj7e5UG8dybkvpSoaOdDuw8x2wReNQzM
         fwUD2XCSOaLMMFRHrkJWXhBnPe1nzIBS/NU1gQ5VqYbxzVaHxfqZbLTRAIaja+x5r51n
         seqa7CA7p/iQPvwdCguEC/3pxInF0Orqpka4H1mJq9mrsL/7QJFkWcM9yxa3b6KWJRe2
         3+PYaxmwKT4gNRBmhE+mvljq1dv/mzoNNR8YufD3m8R7NScM9kNl2DJuxOwDCRmSonmE
         e9eQ==
X-Gm-Message-State: ACrzQf36Pvep8X0WJYhoZ7GJfQGSuetSucc3gRSTLTUCYzG89GF7p+wk
        es0w7SUINI2BPlUrnFjDGNg=
X-Google-Smtp-Source: AMsMyM4PmFcfuXwNZq5ps/CW7XydHLrRPmH2diLe20X++hcnAyLg9ltJOXBLroiI8ZQPVMvrZe+R8A==
X-Received: by 2002:adf:fc12:0:b0:236:9b2e:4843 with SMTP id i18-20020adffc12000000b002369b2e4843mr17735229wrr.620.1667468555249;
        Thu, 03 Nov 2022 02:42:35 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id l2-20020a05600c1d0200b003cf878c4468sm5686761wms.5.2022.11.03.02.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 02:42:34 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <059cf6aa-d288-6584-4d48-90f831de5344@dunelm.org.uk>
Date:   Thu, 3 Nov 2022 09:42:33 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 02/12] cmake: update instructions for portable
 CMakeLists.txt
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>
References: <cover-v2-00.11-00000000000-20221027T032622Z-avarab@gmail.com>
 <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com>
 <patch-v3-02.12-7a21f4aa24c-20221101T225022Z-avarab@gmail.com>
In-Reply-To: <patch-v3-02.12-7a21f4aa24c-20221101T225022Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/11/2022 22:51, Ævar Arnfjörð Bjarmason wrote:
> The instructions for running CMake went back & forth between *nix,
> Windows and Visual Studio instructions Let's create headings and split
> the existing instructions up into those new sections.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   contrib/buildsystems/CMakeLists.txt | 66 +++++++++++++++++++++--------
>   1 file changed, 48 insertions(+), 18 deletions(-)
> 
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index 494da807c53..7bc123da315 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -4,7 +4,48 @@
>   
>   #[[
>   
> -Instructions how to use this in Visual Studio:
> +== Overview ==
> +
> +The top-level Makefile is Git's primary build environment, and a lot
> +of things are missing (and probably always will be) from this CMake
> +alternative.
> +
> +The primary use-case for maintaining this CMake build recipe is to
> +have nicer IDE integration on Windows. To get Visual Studio-specific
> +instructions see "== Visual Studio & Windows ==" below.

If that is the primary use-case (which I agree it is) then it perhaps we 
should but the instructions for that use at the top of the document.

> +
> +== Creating a build recipe ==
> +
> +To create the build recipe run:
> +
> +    cmake -S contrib/buildsystems -B contrib/buildsystems/out -DCMAKE_BUILD_TYPE=Release
> +
> +For alternative "-DCMAKE_BUILD_TYPE=<type>" flags see instructions
> +under the "== -DCMAKE_BUILD_TYPE=<type> ==" heading below.

Rather than forcing the reader to jump back and forth, perhaps we could 
document -DCMAKE_BUILD_TYPE and -GNinja here.

Best Wishes

Phillip
