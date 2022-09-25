Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7439C04A95
	for <git@archiver.kernel.org>; Sun, 25 Sep 2022 08:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiIYIkL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Sep 2022 04:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiIYIkE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2022 04:40:04 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C0B1093
        for <git@vger.kernel.org>; Sun, 25 Sep 2022 01:40:02 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id x18so5978959wrm.7
        for <git@vger.kernel.org>; Sun, 25 Sep 2022 01:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=7CJcCyqmxpppAwdlkT7b1zLFRU8WDUG4hEHdHJlsDjI=;
        b=alLmE0VngSWjuGSbZMTEHygFMyQXTpPHAJVr3kYhlGB4cHW5P07SS5qkzimipbHlsA
         0RUq9qKeeLX/zCxwNOlTg5CdQd/Re+VhfQxm+IbL05yM6jAVOGLSuIBBo4AQEC8ib521
         SOqP6n/mGQ6GXg2uRees4iwdiFH9V+lfMsv/py/CQFg+knz/b9MNpcRiZ7c/U4/c8fEj
         yDiO17kwETo/siFSvJakY2u/K1dmaFlqq8pIkn7H8zFD4o4sdsurJZtluQkPZYWha9/j
         cCXNGtGEgw0XgkOuSzZr1dcteDck7euYawmGhK+jRdRgwaEJSfjPm1GwW7OnTGK4vcN3
         Q31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=7CJcCyqmxpppAwdlkT7b1zLFRU8WDUG4hEHdHJlsDjI=;
        b=uhhHf5NQWeBaxMIwdkaSG+A76yIFYIYUWSNSDhMUWxorvdkm/FYD3ZRuJsv/U9qYQo
         LpK352PN4mN38nl6NxilSTzOylJh5Ubqpv6AXHmc/lJrB9I6BzgZKCmQpcU3x8Q/iU7M
         2WwiR8l23pAXO6vNt1i51mcuKm8g/6dPBhDSziGXBER+OZH3hh0iySYmpVdB70bFv/ms
         Dt81D3q8/oO8BepsK320xOfTreFfv6cUP+QOooxhOWSDW1dVlnWR4Kqm57sgYcgpnB0O
         3UVjiHehjCLm51BB6EjaMeqaSAMGYmBcmWvAWKHvllaJTq2nYGWxuScIv0FFVxlvnEMF
         GzCQ==
X-Gm-Message-State: ACrzQf3FUzWAAYli/m9kFpbwNzosl6aefG6I2xST4vjKvaKp+8HCv75P
        vLLqOB20kgZ6jA/ixaJi8w0=
X-Google-Smtp-Source: AMsMyM4oVCtu0bGfCVuqRFPstUqYzV3oP6PiR2ZGAI/ch+WsuU8dLOq2jnmn2TMlkkZ54GDkybV50A==
X-Received: by 2002:a05:6000:a17:b0:22a:2da9:e233 with SMTP id co23-20020a0560000a1700b0022a2da9e233mr9730581wrb.248.1664095201352;
        Sun, 25 Sep 2022 01:40:01 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c2ca600b003b4c40378casm7828953wmc.39.2022.09.25.01.39.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Sep 2022 01:40:01 -0700 (PDT)
Message-ID: <e301d4c1-8f80-b9cf-142b-cd7bd183d625@gmail.com>
Date:   Sun, 25 Sep 2022 09:39:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 00/10] Add the Git Change command
Content-Language: en-GB-large
To:     Christophe Poucet via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Christophe Poucet <christophe.poucet@gmail.com>
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christophe

On 23/09/2022 19:55, Christophe Poucet via GitGitGadget wrote:
> I'm reviving the original git evolve work that was started by
> sxenos@google.com
> (https://public-inbox.org/git/20190215043105.163688-1-sxenos@google.com/)
> 
> This work is intended to make it easier to deal with stacked changes.
> 
> The following set of patches introduces the design doc on the evolve command
> as well as the basics of the git change command.

Thanks for picking this up, having an evolve command would be a really 
useful addition to git. I read the final four patches as I was 
interested to see how a user would use "git change" to track changes to 
a set of commits. Unfortunately because there are no tests and scant 
documentation there are no examples of how to do this. Looking at the 
patches I felt like it would have been helpful to mark them as RFC to 
indicate that the author is requesting feedback but does not consider 
them ready for merging.

I'm confused as to why the command is called "change" (which I don't 
find particularly descriptive) when every patch subject is "evolve". It 
definitely makes sense to request feedback on a large topic like this 
before everything is implemented but I'd be nervous of merging the early 
stages before there is a working evolve command. For an example of a 
successful multipart topic see 
https://lore.kernel.org/git/pull.1248.git.1654545325.gitgitgadget@gmail.com/ 
Knowing the author of that series the commit messages should also give 
you a good idea of the level of detail expected.

Best Wishes

Phillip

> Chris Poucet (4):
>    sha1-array: implement oid_array_readonly_contains
>    ref-filter: add the metas namespace to ref-filter
>    evolve: add delete command
>    evolve: add documentation for `git change`
> 
> Stefan Xenos (6):
>    technical doc: add a design doc for the evolve command
>    evolve: add support for parsing metacommits
>    evolve: add the change-table structure
>    evolve: add support for writing metacommits
>    evolve: implement the git change command
>    evolve: add the git change list command
> 
>   .gitignore                         |    1 +
>   Documentation/git-change.txt       |   55 ++
>   Documentation/technical/evolve.txt | 1051 ++++++++++++++++++++++++++++
>   Makefile                           |    4 +
>   builtin.h                          |    1 +
>   builtin/change.c                   |  342 +++++++++
>   change-table.c                     |  179 +++++
>   change-table.h                     |  132 ++++
>   git.c                              |    1 +
>   metacommit-parser.c                |  110 +++
>   metacommit-parser.h                |   19 +
>   metacommit.c                       |  404 +++++++++++
>   metacommit.h                       |   58 ++
>   oid-array.c                        |   12 +
>   oid-array.h                        |    7 +
>   ref-filter.c                       |   10 +-
>   ref-filter.h                       |    8 +-
>   t/helper/test-oid-array.c          |    6 +
>   t/t0064-oid-array.sh               |   22 +
>   19 files changed, 2418 insertions(+), 4 deletions(-)
>   create mode 100644 Documentation/git-change.txt
>   create mode 100644 Documentation/technical/evolve.txt
>   create mode 100644 builtin/change.c
>   create mode 100644 change-table.c
>   create mode 100644 change-table.h
>   create mode 100644 metacommit-parser.c
>   create mode 100644 metacommit-parser.h
>   create mode 100644 metacommit.c
>   create mode 100644 metacommit.h
> 
> 
> base-commit: 4b79ee4b0cd1130ba8907029cdc5f6a1632aca26
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1356%2Fpoucet%2Fevolve-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1356/poucet/evolve-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1356
