Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198ACC433EF
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 15:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbiGVPBv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 11:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiGVPBt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 11:01:49 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57E76E8AC
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 08:01:48 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id r70so3814339iod.10
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 08:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=76lhTm6SpLnJwQke5+6CUcXiyB97NTOW0wMVqCc50hc=;
        b=DmijuL1D06s9LQQtYKrCh7IQLTwjC7nKQl7BQ4ZG/TbKbftuM8d16YdYBfmeVtogRh
         C5MCQgCa36swaof7xn5FuTiF8QxOJ3M1X8DAO0yhtBONyb7NJjLvvCDXHDjPMhPreNVL
         RUiczvlo2t7Eq71/r9zuLz4o8bgfdgAL+sbop06pgq05lf2r9Hy4eIrHXYVVlAocY9GT
         5InIzFfPE2czI5XpQimmbwZ8nCIji1obuvwHn1GFjCFOWfL0xCSAGGbedtqL1gsDEjNo
         onykMgq0QsHmcKpmtCBvXL69G3VYINrtpnDlH+lCKH8dujiWvuIXF3m8x92n8Zcgd/7p
         TEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=76lhTm6SpLnJwQke5+6CUcXiyB97NTOW0wMVqCc50hc=;
        b=Q6bK5FZeiwRaLhkjo4AV/elwIFbgbMt+ZdnCSYKEoYO+XnzXJ95WrwTkEnAU/Gg2VF
         ukjrTRHZnSfhL+3au/TRgdIFpBHsjwIyd3uxNJ6YuSpJtXH/iAg5wAfakTOb/SLsoPJg
         3h/Zg2VJm6QXjU75pdD4R9Oiup3iH4SYa2IRSMQ7vSeCaYkqkthSa2MgPaFJc6b8dDFc
         CGy3yKy0LIKaHhqCni7J6RSZkkB9UyVx56hrqjQrvnOrEznS0xyGgGIP8TdizA7g9IZ2
         5XxSVQITVA392bZdWSXSVE5rq4nmPsWMf3idxUJyi1nwDDeIVNM9/0/nHvHEXtUpFbVB
         mDOg==
X-Gm-Message-State: AJIora9pvR3r+q37QJnFt/tVWpRoBrwjKgiaOA6G6qbz1iSXhqe74Q8D
        kJ5KAb7rH8jFO5SGJaWszS+k
X-Google-Smtp-Source: AGRyM1u0/E/hnW4ylCJpY4mJBbghQ/XFiFK5aSl0D3ZN2bt+Se/zQbw2qHUHD7uRkIn0kBMpQJ0srQ==
X-Received: by 2002:a05:6638:441:b0:33f:6393:bb3f with SMTP id r1-20020a056638044100b0033f6393bb3fmr216624jap.1.1658502108144;
        Fri, 22 Jul 2022 08:01:48 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:89e1:7440:c819:d192? ([2600:1700:e72:80a0:89e1:7440:c819:d192])
        by smtp.gmail.com with ESMTPSA id e14-20020a056602044e00b0067bcf7bf3c1sm2255252iov.14.2022.07.22.08.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 08:01:47 -0700 (PDT)
Message-ID: <23622824-6029-01e7-5f3b-06cb0dbadd0c@github.com>
Date:   Fri, 22 Jul 2022 11:01:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/6] docs: document bundle URI standard
Content-Language: en-US
To:     Josh Steadmon <steadmon@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, avarab@gmail.com, dyroneteng@gmail.com,
        Johannes.Schindelin@gmx.de
References: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
 <pull.1248.v2.git.1656535245.gitgitgadget@gmail.com>
 <d444042dc4dcc1f9b218ca851fcf603a3afce92f.1656535245.git.gitgitgadget@gmail.com>
 <YtnHeUUnaLn6mSYK@google.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <YtnHeUUnaLn6mSYK@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/21/2022 5:39 PM, Josh Steadmon wrote:
> On 2022.06.29 20:40, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <derrickstolee@github.com>

>> +* A bundle download during a `git fetch` contains objects already in the
>> +  object database. This is probably unavoidable if we are using bundles
>> +  for fetches, since the client will almost always be slightly ahead of
>> +  the bundle servers after performing its "catch-up" fetch to the remote
>> +  server. This extra work is most wasteful when the client is fetching
>> +  much more frequently than the server is computing bundles, such as if
>> +  the client is using hourly prefetches with background maintenance, but
>> +  the server is computing bundles weekly. For this reason, the client
>> +  should not use bundle URIs for fetch unless the server has explicitly
>> +  recommended it through the `bundle.flags = forFetch` value.
> 
> The "Bundle Lists" section above doesn't mention `bundle.flags` at all;
> has this been replaced by `bundle.heuristic`?

You and Matthew both caught this. I first thought that absolutely this
was a replacement I missed. Then I re-checked my future steps and the
very last patch implements `bundle.flags = forFetch`. However, the
reason it exists is for the ability to incrementally fetch even if the
`bundle.heuristic` value is not set. That requires the "download only
the headers" feature, so should be delayed to that implementation.

I'll remove it from the design doc and instead implement the logic to
store the bundle URI for fetching if `bundle.heuristic=creationToken`,
which can be extended later.

Thanks,
-Stolee
