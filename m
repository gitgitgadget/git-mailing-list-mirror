Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7C6C28CF5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 07:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237534AbiAZHAF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 02:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237537AbiAZG7x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 01:59:53 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFDBC061744
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 22:59:52 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id h23so20343343pgk.11
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 22:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dLTDyxqtjY4t/uhtPCwNlIXoWkblxxKWlv7XjnLdgQw=;
        b=BYlOW/YA1v/zZu4z5CHiWNX2w4a5hHJFGDnDj7LTNJlHgxYBGX5So/dFGw98CZ4Rug
         xRAVnsc/6Hyoij9hp5MEcf1tv0CTEAQY26pQcNvB2APhjWHBA9pLGbd/HN3BllGKlO2O
         PlT6YOUEmppis6LATFYz0ZGpxJa6LrgrlBjGrFo1JLaU4VKgh6Yl7QYvo4PKOL1FaLMj
         hT3CRrRwGJdzIGmQGEuFk5qOevZ/mJk0Pedpjk7u38IkGElgy5i1kcrkBNYlWeBj5uMg
         jHhwlkqD37rxmmVfAfVMV6WKHQTf+bDJW4t7C4OKPHlExqnRMEFtgXmhAfl5iucpPLCZ
         7eLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dLTDyxqtjY4t/uhtPCwNlIXoWkblxxKWlv7XjnLdgQw=;
        b=b5hiic+SyC0anLirvAznXRFZ2FHfnCTV3DD2ZQRg/JYgFBMl0eG3Pxw+j3UI3dFHXL
         2VGZhxvU+IQ6EDOTEnizMi5p1ZLBE45rXRP0JWt2DNMDZDd9M0jbTlCdDKrku4bOaSIt
         oItDJDNA8kwm/HKZ5+KATS7tK3Nvpv7o/DZn8lq8fYEwyELbg9KXXSlRwbJpgHZW6Ohw
         RlUoFDjz5rXAvDogz0L/SuGAq+wz+4u+lEGEcXa3WAnj8cxIeuiTr1rpJT/AQI8+YsMb
         Wd+SgRRSm/OQ0p3yt0XfugHKdMc03w5y0n2NCdbXCk38p4AFcvoe29RygttmkOc5oHqj
         SThg==
X-Gm-Message-State: AOAM531Ayqc96d8Hbwa/0nkoIbI09F+LYhyJ5bTxC/yvZtscb4PfV+aM
        Ecohj05ybi2541rtih6MUGfUZVRmK+U=
X-Google-Smtp-Source: ABdhPJwemaXq6VL/B/Yc2n2S4+39SkWjSqkT1E40FDEzYflYIQ3fq2ZfTghXmK5YoWkwDTE/VSOB4g==
X-Received: by 2002:a63:a619:: with SMTP id t25mr18066670pge.235.1643180392370;
        Tue, 25 Jan 2022 22:59:52 -0800 (PST)
Received: from [192.168.43.80] (subs03-180-214-233-28.three.co.id. [180.214.233.28])
        by smtp.gmail.com with ESMTPSA id l20sm1025934pfc.53.2022.01.25.22.59.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 22:59:52 -0800 (PST)
Message-ID: <0e8ef47b-7bb7-df38-1d97-90fda4471bbb@gmail.com>
Date:   Wed, 26 Jan 2022 13:59:46 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 1/5] Documentation: add extensions.worktreeConfig
 details
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     stolee@gmail.com, sunshine@sunshineco.com, allred.sean@gmail.com,
        gitster@pobox.com, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com>
 <pull.1101.v4.git.1643136134.gitgitgadget@gmail.com>
 <459e09dedd71fcb64b9796bac52c3812d78f2405.1643136134.git.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <459e09dedd71fcb64b9796bac52c3812d78f2405.1643136134.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/01/22 01.42, Derrick Stolee via GitGitGadget wrote:
> As documented in 11664196ac ("Revert "check_repository_format_gently():
> refuse extensions for old repositories"", 2020-07-15), this extension
> must be considered regardless of the repository format version for
> historical reasons.
> 
...
> +For historical reasons, `extensions.worktreeConfig` is respected
> +regardless of the `core.repositoryFormatVersion` setting.

This implies `extensions.worktreeConfig` become integral part of every
repository format version, from the past until now and to the future,
right?

-- 
An old man doll... just what I always wanted! - Clara
