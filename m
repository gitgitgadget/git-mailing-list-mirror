Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAB1C433EF
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 16:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237892AbiB1QYW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 11:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbiB1QYV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 11:24:21 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466AE4BBAE
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 08:23:42 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id g6-20020a9d6486000000b005acf9a0b644so9883723otl.12
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 08:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=sCMZWsoxvv3XB8wc85L7xJq/hZbd+9mQRtOlF9qkbO8=;
        b=K+vsRw4DAntKSc2/YOqiwmpRgffeknqLc2x7PH+AbZD+pVJEqEnExTaLNhGP6OYu4z
         pA3r9bfc+eWQnIZo1I29IDPPuteeviuijbYQI7r+mBd/Et/ZdSYXiGeX003SLxzYqyAZ
         mr5YWaSesaU9CUHGkMebAhCpRBMPclDdKi5NpiWI5OtbpdZA/EHh6WqFb0mN36QwnhLu
         zT8lzCUPwxefIbk3kH6kU5DgqKu9nhSwG0h8aGUNdf4rn44bs3SOFcehdEu0ivdcpfip
         9hKQPtqA6Pg285inlFeb8eH0UA+3bNDiF5kBkXyhv0yyTbxwPGqdU7+hMQiJYQun9Hdg
         Irhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sCMZWsoxvv3XB8wc85L7xJq/hZbd+9mQRtOlF9qkbO8=;
        b=bYDWGpxAYxmY6UZ7lVchxf/IxleldJnCDtdlne1EagFpo8M4A0uRWzvUPS5baxn0NJ
         gvir9xH8T7QK2z5byn/mpugr3eGPycIx7GO3sfgx6fKo7FBFGpN3eErp1UQ3Ppd2/Hga
         4taQwUKUBjCUpGrDDaUdkrx1OJ0iYO9IdS83r0vbkINWLLfYiZAxcIS8J/YbL1MRMwgC
         RQIoC2cI5q4BmN2owjGrMsZ+pwSAQEAkomvJQZnGxuIGRF5dOqAdpWrUKgzcw+C4uonk
         lv1R4v9Laq/j7h9XFSvWDTJwsckYnkNVXF9YK8pZssW7hrNHoWTsPO+zQvDp8pBXnkX4
         gRNg==
X-Gm-Message-State: AOAM531rTWFtwn3GK39vlstZXBa7HdeiwlBPPSAb9Ix0G4vO9k53aPHk
        mOU+qrMf1L9/eFpS2/cCyNV9
X-Google-Smtp-Source: ABdhPJy/uYY752KPPsyvXS3cYlRsbw1AzB5CB1PbXFO2QqVNfxDK7gNFhnC7MWduOn3/c5cVr/EuiA==
X-Received: by 2002:a9d:77d7:0:b0:5af:1655:80c9 with SMTP id w23-20020a9d77d7000000b005af165580c9mr9448539otl.384.1646065420730;
        Mon, 28 Feb 2022 08:23:40 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id bx10-20020a0568081b0a00b002d70da1ac54sm6467492oib.19.2022.02.28.08.23.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 08:23:40 -0800 (PST)
Message-ID: <e29ec01f-3039-6992-8ade-800ad32fcf34@github.com>
Date:   Mon, 28 Feb 2022 11:23:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 3/7] commit-graph: start parsing generation v2 (again)
Content-Language: en-US
To:     Patrick Steinhardt <ps@pks.im>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        abhishekkumar8222@gmail.com
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
 <a3436b92a32f7f6dd02ad61eb2337a4d088d5e9c.1645735117.git.gitgitgadget@gmail.com>
 <YhzkdMxrIGlNutr6@ncase>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <YhzkdMxrIGlNutr6@ncase>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/28/2022 10:18 AM, Patrick Steinhardt wrote:
> On Thu, Feb 24, 2022 at 08:38:32PM +0000, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <derrickstolee@github.com>
...
>> diff --git a/commit-graph.c b/commit-graph.c
>> index a19bd96c2ee..8e52bb09552 100644
>> --- a/commit-graph.c
>> +++ b/commit-graph.c
>> @@ -407,6 +407,9 @@ struct commit_graph *parse_commit_graph(struct repository *r,
>>  			&graph->chunk_generation_data);
>>  		pair_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW,
>>  			&graph->chunk_generation_data_overflow);
>> +
>> +		if (graph->chunk_generation_data)
>> +			graph->read_generation_data = 1;
>>  	}
>>  
>>  	if (r->settings.commit_graph_read_changed_paths) {
> 
> I wanted to test your changes because they seem quite exciting in the
> context of my work as well, but this commit seems to uncover a bug with
> how we handle overflows. I originally triggered the bug when trying to
> do a mirror-fetch, but as it turns it seems to trigger now whenever the
> commit-graph is being read:
> 
>     $ git commit-graph verify
>     fatal: commit-graph requires overflow generation data but has none
> 
>     $ git commit-graph write --split
>     Finding commits for commit graph among packed objects: 100% (10235119/10235119), done.
>     fatal: commit-graph requires overflow generation data but has none
> 
>     $ git commit-graph write --split=replace
>     Finding commits for commit graph among packed objects: 100% (10235119/10235119), done.
>     fatal: commit-graph requires overflow generation data but has none
> 
> I initially assumed this may be a bug with how we previously wrote the
> commit-graph, but removing all chains still reliably triggers it:
> 
>     $ rm -f objects/info/commit-graphs/*
>     $ git commit-graph write --split
>     Finding commits for commit graph among packed objects: 100% (10235119/10235119), done.
>     fatal: commit-graph requires overflow generation data but has none
> 
> I haven't yet found the time to dig deeper into why this is happening.
> While the repository is publicly accessible at [1], unfortunately the
> bug seems to be triggered by a commit that's only kept alive by an
> internal reference.
> 
> Patrick
> 
> [1]: https://gitlab.com/gitlab-com/www-gitlab-com.git

Thanks for including this information. Just to be clear: did you
include patch 4 in your tests, or not? Patch 4 includes a fix
related to overflow values, so it would be helpful to know if you
found a _different_ bug or if it is the same one.

Thanks,
-Stolee
