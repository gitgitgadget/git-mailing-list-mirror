Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D69C433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 20:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238285AbiEXUQN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 16:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbiEXUQL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 16:16:11 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B35B5FE8
        for <git@vger.kernel.org>; Tue, 24 May 2022 13:16:10 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id y15so11299298qtx.4
        for <git@vger.kernel.org>; Tue, 24 May 2022 13:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tyYlaNBHaXLs3qLTtWxaYq84JFJCypmq6Bu5zSJhRZA=;
        b=IYCeVuAmoNQXdqRoIiskYFGqXu56gVzWj6ZeigsltiJ+yXtB7BiUHpt9ycaGyaa2Zo
         5K6RvzDAfbMAgrKq8t2cD0hqQZT7SEGy7+uzbgCfFfqaY2Z8dUcr/CHOPIbxSVd4eUvo
         6wi7uhU1mcHcfnB4AjxWmB/gawFPVx7xTr3YgWer+y5KJuQYuxFD+dS4IixkS7UC135/
         MURlNCAIJazK1L1VyqwYR6Q4D+S4uanO/BziEB+tpGsqXJArt55gQR6nthpaCWZcXBzu
         OmGD8oaUc17wBt0XLZGvg7orVPJ40ETehEsZfFKRv0bFUrIRE4zx1Ev2ljWTDSYR6mLU
         nX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tyYlaNBHaXLs3qLTtWxaYq84JFJCypmq6Bu5zSJhRZA=;
        b=EpOoWs3tz2gr2y+VzRVP9uvaRyzonPRobC1mIazmykHoeKHe8RfPwmkUu/Y6Tgz6Dm
         hhoUCSE/WHNEXLpC3xt6ESLuoRW6c2BhaKLqIFqTIDmGrV84T0Pp5FdRLntQYEkdTJCZ
         KVsSgrsccIvmv2gKD6WAuMcLW8fprLNtWplc959gwRz+CHeXykPRZgoc3BHG2/usObf8
         y23krxB34+OfNk9TXVY1Itl4ACDJ5l/f59PKKpr47JZ3QVYklz2eq+Jsmb3anZ64bnsn
         fGbF8OqKI+s+HoL9qGfHeu/35AxCQZfqK88M5F8i+IEQJ+bOSRtryjPj7VG4oUswIMzj
         gf2Q==
X-Gm-Message-State: AOAM530HmMShI5CijdXzqzsAcP6AG0RjBwQoVpzDdCx59FMzyCGE7nij
        sbeXDiIxWptKO/VdbNIBF6cV
X-Google-Smtp-Source: ABdhPJwyNWsjOPDEHOfe04IuonP0mCinzunniH86kiOsJ/oMFivTdq07MMtn+lQoYc4PJGsbftnl3g==
X-Received: by 2002:a05:622a:1489:b0:2f3:e404:f707 with SMTP id t9-20020a05622a148900b002f3e404f707mr21530548qtx.414.1653423369358;
        Tue, 24 May 2022 13:16:09 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:9dd7:2c4b:2dbd:828e? ([2600:1700:e72:80a0:9dd7:2c4b:2dbd:828e])
        by smtp.gmail.com with ESMTPSA id g21-20020ae9e115000000b006a371ba1fa5sm135490qkm.32.2022.05.24.13.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 13:16:09 -0700 (PDT)
Message-ID: <14f71d47-e2c1-2a43-6434-af6f23d18754@github.com>
Date:   Tue, 24 May 2022 16:16:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] urlmatch: create fetch.credentialsInUrl config
Content-Language: en-US
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        me@ttaylorr.com, avarab@gmail.com, christian.couder@gmail.com,
        jrnieder@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Robert Coup <robert.coup@koordinates.com>
References: <pull.1237.git.1653329044940.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2205241339440.352@tvgsbejvaqbjf.bet>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <nycvar.QRO.7.76.6.2205241339440.352@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/24/2022 7:42 AM, Johannes Schindelin wrote:
> Hi Stolee,
> 
> On Mon, 23 May 2022, Derrick Stolee via GitGitGadget wrote:
>> +	at_ptr = strchr(url, '@');
>> +	colon_ptr = strchr(url + scheme_len + 3, ':');
> 
> How certain are we that `url + scheme_len + 3` is still inside the
> NUL-separated `url`?

I'll update the method comment to make this clear.
 
>> +
>> +	if (!colon_ptr)
>> +		BUG("failed to find colon in url '%s' with scheme_len %"PRIuMAX,
>> +		    url, (uintmax_t) scheme_len);
> 
> Wouldn't this mean that `https://github.com/git/git` with a `scheme_len`
> of 5 would hit that `BUG()` code path?

Yes. The method is about what to do once we've detected a URL
with a "username:password@" combination after the scheme. I
mentioned in a different reply, but I'll make this clear with
a comment.

Thanks,
-Stolee
