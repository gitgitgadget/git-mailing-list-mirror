Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D0DC433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 19:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiCDTUK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 14:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiCDTUG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 14:20:06 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0037FEBBB0
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 11:19:10 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id f21so7196955qke.13
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 11:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Z77oDzyX/wOLZ6q63WM9E1ozmC+PbxP8XjtVOB9hwUY=;
        b=VpPtqEYeMcHM6Rk5aPWGTGWL3ChL2X0tOQ/hNJ2XrXpH+tNbJ/I2fVCjW0PCLNrDWE
         TsKZ7yisZMZzQ/Itmt22Fbil3Bl+WgqC1N2ute+YCTWZ6dxZrnr8cEqJtwmC5X4QD4cz
         XRu0bvC8tGdSW0XvxE7oNTRaQ/9D0uG1gRmyvd1vTgo0nlRzHJ1/QYEAL20HdczKGDab
         67x2TBoM4peoJqUso0eOfe7YtTq+vh6fRjeLUqUdDKifQOUq2HdnvPJcdmmI7fDAtlQE
         xbElQ70VgCo6FTx1GiDTU31gSmp5/zbny87MXWfu/cmhuIHi9OqF6BKY9iBZqhtQ2ogk
         K2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Z77oDzyX/wOLZ6q63WM9E1ozmC+PbxP8XjtVOB9hwUY=;
        b=O14O/2+K1S55QtSt4xJ9j5K2GZQV7uJuHa1iDvGDQk4MFKY3xN6WCC06G3MaDzUkuD
         HruntnrOqszvc50d7IZlGof3NNrz1eBMh5QNruEXUZIahh4mbB2ilonqJgF43Iy6th4J
         gDcn91cUEa/pMHFZHi0bRg3ZIpufdKTGHH7tfu3gIAnxPskc2BggiQrL1YFmgVDBqK/q
         nYZtLaSF6rF7koA2Y0t71I6hfoVJA/JMW9qtr+3HZvcgDrFbIjnOGJUm9mfQpu/lxbUo
         4QekNfEaWhhROmCl7VotjPSsfn1SDm6qWRna/HtOzGrJ1fbBtq29GzBioAfeTFPx73wq
         VhLg==
X-Gm-Message-State: AOAM5306IglIMvsdai9RI1DYaVAwKcHMiLz4dHD8O73rRPq4IxFXp5YB
        pF68r6BzLBi5krCWzBK1yHug
X-Google-Smtp-Source: ABdhPJyz3Xz2ti6wTwDYNXKKs97KzEjhDm9D4EPivW0GatNnr0kVEvzPrBfIX1AAAAGYI1wgU+5VwQ==
X-Received: by 2002:a05:620a:20c8:b0:475:d0cb:e6eb with SMTP id f8-20020a05620a20c800b00475d0cbe6ebmr97048qka.612.1646421549106;
        Fri, 04 Mar 2022 11:19:09 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id s8-20020a05622a1a8800b002de08a30becsm3862617qtc.80.2022.03.04.11.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 11:19:08 -0800 (PST)
Message-ID: <6442a1ce-d3ef-d564-ef98-a621e88a0b02@github.com>
Date:   Fri, 4 Mar 2022 14:19:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 00/11] Partial bundles
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     stolee@gmail.com, avarab@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/23/2022 12:55 PM, Derrick Stolee via GitGitGadget wrote:
> While discussing bundle-URIs [1], it came to my attention that bundles have
> no way to specify an object filter, so bundles cannot be used with partial
> clones.
> 
> [1]
> https://lore.kernel.org/git/7fab28bf-54e7-d0e9-110a-53fad6244cc9@gmail.com/
> 
> This series provides a way to fix that by adding a 'filter' capability to
> the bundle file format and allowing one to create a partial bundle with 'git
> bundle create --filter=blob:none '.
> 
> There are a couple things that I want to point out about this implementation
> that could use some high-level feedback:
> 
>  1. I moved the '--filter' parsing into setup_revisions() instead of adding
>     another place to parse it. This works for 'git bundle' but it also
>     allows it to be parsed successfully in commands such as 'git diff' which
>     doesn't make sense. Options such as '--objects' are already being parsed
>     there, and they don't make sense either, so I want some thoughts on
>     this.
> 
>  2. If someone uses 'git clone partial.bdl partial' where 'partial.bdl' is a
>     filtered bundle, then the clone will fail with a message such as
> 
> fatal: missing blob object '9444604d515c0b162e37e59accd54a0bac50ed2e' fatal:
> remote did not send all necessary objects
> 
> This might be fine. We don't expect users to clone partial bundles or fetch
> partial bundles into an unfiltered repo and these failures are expected. It
> is possible that we could put in custom logic to fail faster by reading the
> bundle header for a filter.
> 
> Generally, the idea is to open this up as a potential way to bootstrap a
> clone of a partial clone using a set of precomputed partial bundles.

Thanks Jeff, for providing a review of this series. I hope that at
least one other reviewer could take a look sometime.

Thanks,
-Stolee
