Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 167F01F453
	for <e@80x24.org>; Tue, 22 Jan 2019 18:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfAVSaM (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 13:30:12 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40850 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfAVSaL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 13:30:11 -0500
Received: by mail-qk1-f194.google.com with SMTP id y16so14784755qki.7
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 10:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=QDSykz8bLcw3FOqAvtw/nkG1ocTjSZGWq5n15/weBWg=;
        b=jD9eUGQBRWv5wIJuvFoZncKyuZNE1eT1mxQAkVKwHJXeYRbp+Ls1MBArfLNM03Utdt
         sNkJHns4FbK0MtrYfVah1bKyabNqb8DTDzN2PcevaBMtT33ISW2d4uEA7cyL8VkJZ6tY
         xz1/Z46ujwkQ7hwPJMJSWEeW0metH9sc9t4+SXbp9ixRejDZw0nJDLMDLLZ7jyEJTIL+
         4ecTfBj7i9vsD5mkopzeV/WUFA208m6kjW5GK2M8rfYgU0lKr1pehQy9VQCphT0/gGC9
         PzYOGg4gGeUmQ9CaDXJCxkL8WYxqVYKMNd+Y9bzyjc8kkYhsHCWCmr7aC20Jl3YVW3Ys
         V3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QDSykz8bLcw3FOqAvtw/nkG1ocTjSZGWq5n15/weBWg=;
        b=l8aOKNr5dEq/tcfm/65KIYvhJgHQY8Nzp8Uu2n8njoJi9MSOtOCsNyHFv4U150svT5
         WLT7oHK7LX2hhC+1hABUi8IrFygFekkc+aEXy4d4xdMz3dF5b+kuRG0whEuB6mD6uCLi
         Pm+5otvHyQafIPUsZasobbp9pBEB4HAYnwYKYUxqx6mxNLmDrDqth4mkCJnCmb19JuBZ
         KQQCrTe7dKoRAvRg5O0znSP4XD+luA6ryTIlaRWDY0iUxFGnuPE5MWqRhABns8czrI4G
         Oj1XNNOgcOV2EeXWxWOZeVuo7xXOVURyUpLVhSFbuGyFwWcclujxy1rUYwXFQ4tU5kKR
         2dJw==
X-Gm-Message-State: AJcUukccVCShdtExz9GVVM+gasqTGlSLGX73uinm1rStJ6lisH1upE8V
        lPkMvfFRXXs/HZyaVV1hoio=
X-Google-Smtp-Source: ALg8bN4kYIly4tNsvwGqZXxz0V0UhO/eX83HF22kC+nqWV5Q6cn5Qv5G1JcBnY0maptrRwkjYh6piQ==
X-Received: by 2002:a37:8882:: with SMTP id k124mr28755184qkd.1.1548181810313;
        Tue, 22 Jan 2019 10:30:10 -0800 (PST)
Received: from [10.0.1.23] ([98.122.160.2])
        by smtp.gmail.com with ESMTPSA id e17sm71684574qte.12.2019.01.22.10.30.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 10:30:09 -0800 (PST)
Subject: Re: [PATCH v6 00/10] commit-graph write: progress output improvements
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20190116132947.26025-1-avarab@gmail.com>
 <20190119202121.3590-1-avarab@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <09f8fc01-898c-58f7-f14c-7a843e2e34b9@gmail.com>
Date:   Tue, 22 Jan 2019 13:30:07 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <20190119202121.3590-1-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/19/2019 3:21 PM, Ævar Arnfjörð Bjarmason wrote:
> Improvements since v6:
>
>   * Integrate my "commit-graph write: use pack order when finding
>     commits" patch, and per Junio's suggestion put it at the start so
>     it's easier to split the two apart.
>
>   * A signed-off-by of mine was missing on that patch. Fixed.
>
>   * Replace SZEDER's two patches with his re-roll at
>     https://public-inbox.org/git/20190118170549.30403-1-szeder.dev@gmail.com/
>     for convenienc, since mine needed rebasing on top of his.
>
>   * SZEDER rightly pointed out that I was doing some work for nothing
>     in https://public-inbox.org/git/20190118171605.GM840@szeder.dev/;
>     fixed.
>
> SZEDER Gábor (2):
>    commit-graph: rename "large edges" to "extra edges"
>    commit-graph: don't call write_graph_chunk_large_edges() unnecessarily
>
> Ævar Arnfjörð Bjarmason (8):
>    commit-graph write: use pack order when finding commits
>    commit-graph write: add "Writing out" progress output
>    commit-graph write: more descriptive "writing out" output
>    commit-graph write: show progress for object search
>    commit-graph write: add more descriptive progress output
>    commit-graph write: remove empty line for readability
>    commit-graph write: add itermediate progress
>    commit-graph write: emit a percentage for all progress

I'm a few days late, but I took another look through the patches and 
they look good to me. Thanks!

-Stolee

