Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02343C433F5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 10:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEF4261181
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 10:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238047AbhJFKfM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 06:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237836AbhJFKfM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 06:35:12 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95388C061749
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 03:33:20 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id a11so1429662plm.0
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 03:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xqx/ouvN/PO/2wj/IYyhY5hDvsZYJWiL6TeA7r9etH0=;
        b=kxvAR4QzmKxp4+vVZXlws26fLYriMGX6H6ZJADIPy1x2NhVSvwQhcQH1ngqaWil0pM
         dbmQ3aePv7jvm6y6lgWOajmiczHNcXQU/d9E2t4JpSdrol89fxwAyvcjJE7eq/ACTIqt
         PwcvOisTjCms5BOcwb+eL6cioGmpp6xJkB2VKqpsWwMk1VD8CLWoyBrtEokaC50z//Sz
         wawMfGx5oehR2rfrQdQMy5C82WBFl+Mncn5kFpZL4I+jxZ6D8EoPCmcXZ+T+jWBwubv/
         42sEiK61IajEbGZZC5VoIFvKpCbMatoke5t2qEFNNUHa7oLastXtl74KYBSyARd+Uy/P
         xfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xqx/ouvN/PO/2wj/IYyhY5hDvsZYJWiL6TeA7r9etH0=;
        b=Inu/UBP2LGii+DFjPL7znU0QfP8NvxH5KnXAPkQCaa0nZPxlINAyTIuKwQd1n6Jd9z
         IlDglZLj1nyRDZKlvoxo3DentDfGK6GH0NQ2Vd9N9Nk5ujPBVdpzo+OyhaMd80g7si8n
         I8VURn3mxFEuxvFls+5x79raRWXAZzUyeH7YcLalQreskx6NLHZTY/UnMAo3BNXNjMkD
         bqktKox6LsXcaT10JSWx1/vK5OFoSVJSiXr/X67q+GzK3un0SStJm22t6KpetyMkC5bs
         4ojJTa0XKWuUt4jqigNYWRW1tHWVTOCdRPiqL+yR75nHsWVTduG6DWt+Nd5xT+bNjjZB
         L3nA==
X-Gm-Message-State: AOAM530a+EJVtTcnSglufPMNaQGLD84LjHSHS2nNe3ZHhXCfZ6mH84DI
        HgfYUjv3Z/Bw1KeAtQUkAos=
X-Google-Smtp-Source: ABdhPJzcnGSF7BoA4c0Ag9Kv/8BXu97s54RP6Lo5v3I4O4Po5p4yOIcSIl/baG5oUojkH3iu/61Ojw==
X-Received: by 2002:a17:90a:4414:: with SMTP id s20mr9956878pjg.144.1633516399923;
        Wed, 06 Oct 2021 03:33:19 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-73.three.co.id. [180.214.233.73])
        by smtp.gmail.com with ESMTPSA id t9sm4757434pjm.36.2021.10.06.03.33.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 03:33:19 -0700 (PDT)
Subject: Re: [PATCH v2 2/7] update-index: add --force-full-index option for
 expand/collapse test
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>, Victoria Dye <vdye@github.com>
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
 <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
 <f7cb9013d46731855c3ed42add62b021c0ad0c73.1633440057.git.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <f30504f5-e4a3-1b93-08dc-fb9137d36f65@gmail.com>
Date:   Wed, 6 Oct 2021 17:33:16 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <f7cb9013d46731855c3ed42add62b021c0ad0c73.1633440057.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/10/21 20.20, Victoria Dye via GitGitGadget wrote:
> From: Victoria Dye <vdye@github.com>
> 
> Add a new `--force-full-index` option to `git update-index`, which skips
> explicitly setting `command_requires_full_index`. This lets `git
> update-index --force-full-index` run as a command without sparse index
> compatibility implemented, even after it receives sparse index compatibility
> updates.

`... explicitly setting ...` or `... explicitly set ...`? I thought of 
the latter.

-- 
An old man doll... just what I always wanted! - Clara
