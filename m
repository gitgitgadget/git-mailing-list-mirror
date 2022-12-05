Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78645C47089
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 23:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbiLEXbi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 18:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiLEXbh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 18:31:37 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C4213F40
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 15:31:36 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id 130so12918048pfu.8
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 15:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SuuufUYL0KPfNi8WMrVons8RGyyvqYBl+OB0UuHg1c8=;
        b=CSmnNrVbJhNY1/sEhMzd+hH+5QL4lCiYZIa1H6+wYcHV5OmcmGKl+oxItfVIVuFza0
         01r+YuSCE3qiH162ZsE8F6eAc9feD4AijEBvrIO8c2ME0VtQTcrCc9yrqSq8o/lJuXSX
         smaw+SQ+xaLYFyXGhNy2fkMOcYVvPMnT5dZZslNQid85FKA3PmZobqM3qf8DnbfcZ6q1
         eqXWoMZksfrs2byzc5cGRqqg6T7QTEFMNTJFH9tDb8kYh/uueRVbhJ5HEuI0Hg0CcGqW
         VflmA44c9Dgd6h3gfENN3wOyXQaLho6FAkWo+UX41+8A5Uf+dCJAJXzdjRAFt1u0JEWi
         K/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SuuufUYL0KPfNi8WMrVons8RGyyvqYBl+OB0UuHg1c8=;
        b=Qwi/yrsIrXr6R1YHSucBzG9hOWITD91ghh79DK6KTTuNDtRBjGb6OUSvbXSaAbgFH/
         /5roJN2PMy+pcIjA985mCreyLfPCAjyx6V/773/GlPjSgzufheL89L5MvEnTtnYEBsAt
         01HIU7P5iUn0rxDV4w7+UFXwHiRUpZMAyxJ3zmsYhwe9WdgRFod1jeqAN7w5P+XoE1AD
         mxdA4yhShSpYOUb3frgfnJvxDrtNL4n5kFaH6BLswFig5Alh8smKg5PA6430iRTEzp0k
         znXkdMX98apKCrsq2bnqfX6wj5NDxYAVHiVCXEvKK+MR3eAQLcph+WmiMHToVOlRKtYF
         D6Rg==
X-Gm-Message-State: ANoB5pmj6IX7IJSVG9GwjkRBKm/t5HnM28Fts02nkeNFvTOoVs9clrsd
        S6lKUk48AcvG7f3dou7Rz/2y
X-Google-Smtp-Source: AA0mqf7zMaXJ1rSG98v2i5Gtd4AwDMe30C+Ha35JcFenVHuCFN3HeThHHFELUaLuwmrgcjJ4CCMXKw==
X-Received: by 2002:a63:5b01:0:b0:477:e3df:13ac with SMTP id p1-20020a635b01000000b00477e3df13acmr44820351pgb.321.1670283095811;
        Mon, 05 Dec 2022 15:31:35 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id a9-20020a17090a6d8900b0020aacde1964sm11427252pjk.32.2022.12.05.15.31.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 15:31:35 -0800 (PST)
Message-ID: <e68b4b9e-5925-bf7b-4ffb-3f72adc970dc@github.com>
Date:   Mon, 5 Dec 2022 15:31:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v3 01/11] protocol v2: add server-side "bundle-uri"
 skeleton
Content-Language: en-US
To:     =?UTF-8?Q?=c3=86var_Arnfj=c3=b6r=c3=b0_Bjarmason_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com, Derrick Stolee <derrickstolee@github.com>
References: <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
 <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
 <beae335b85586ff88f89c551af62f91a04086781.1670262639.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <beae335b85586ff88f89c551af62f91a04086781.1670262639.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason via GitGitGadget wrote:
> diff --git a/Documentation/gitprotocol-v2.txt b/Documentation/gitprotocol-v2.txt
> index 59bf41cefb9..10bd2d40cec 100644
> --- a/Documentation/gitprotocol-v2.txt
> +++ b/Documentation/gitprotocol-v2.txt
> @@ -578,6 +578,207 @@ and associated requested information, each separated by a single space.
>  
>  	obj-info = obj-id SP obj-size
>  
> +bundle-uri
> +~~~~~~~~~~

Apologies for not following up on this patch when you updated it for v2.
This version is much clearer in describing the bundle URI command protocol,
especially how the 'bundle.*' config is used:

> +When the client issues a `command=bundle-uri` request, the response is a
> +list of key-value pairs provided as packet lines with value
> +`<key>=<value>`. Each `<key>` should be interpreted as a config key from
> +the `bundle.*` namespace to construct a list of bundles. These keys are
> +grouped by a `bundle.<id>.` subsection, where each key corresponding to a
> +given `<id>` contributes attributes to the bundle defined by that `<id>`.
> +See linkgit:git-config[1] for the specific details of these keys and how
> +the Git client will interpret their values.
> +
> +Clients MUST parse the line according to the above format, lines that do
> +not conform to the format SHOULD be discarded. The user MAY be warned in
> +such a case.
> +

and the response types/formats:

> +URI CONTENTS::
> +The content at the advertised URIs MUST be one of two types.
> ++
> +The advertised URI may contain a bundle file that `git bundle verify`
> +would accept. I.e. they MUST contain one or more reference tips for
> +use by the client, MUST indicate prerequisites (in any) with standard
> +"-" prefixes, and MUST indicate their "object-format", if
> +applicable.
> ++
> +The advertised URI may alternatively contain a plaintext file that `git
> +config --list` would accept (with the `--file` option). The key-value
> +pairs in this list are in the `bundle.*` namespace (see
> +linkgit:git-config[1]).
> +

Regarding your point about examples in [1]: after reading the remainder of
the series, I agree that the test cases in the later patches do a good job
of documenting the behavior.

Thanks!

[1] https://lore.kernel.org/git/ca11478b-7b44-3018-04d8-0b84c4f43b56@github.com/

