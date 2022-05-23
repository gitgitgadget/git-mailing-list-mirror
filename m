Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA56C433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 19:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiEWTnW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 15:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbiEWTky (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 15:40:54 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6CE35245
        for <git@vger.kernel.org>; Mon, 23 May 2022 12:33:23 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id y15so9024703qtx.4
        for <git@vger.kernel.org>; Mon, 23 May 2022 12:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IQQYR+biojZ+QpWlA7W2m0ANaoa5I7nfPIm424mdlCw=;
        b=J4hcWGBcDXmS++klpK5+0XA0yyNmFUdoRyI1w613NV/RYSD9iMX9vPCyapf2y3FNo7
         NlQSXhhpRbgGq1DiURK/HqOD6LO90tizGhQ1cClDFFrpGSzNW0adlqvuDq83zi0OzJGK
         +Mf0L0O7MizS+Avs9N14uYSnrvDHk7pm6qDW9JxJNUkOisc0q8dqDaCijmFq5lv5PNHn
         9/J0/QcdvoUDJ7vVETWqtYJbpY7of0bHeMLZDM7HWkv4x00K2qsMdHOnynuHIthi/hpa
         eRK1TfnvqN1pgT++vhvYAgaratm1QWtODtOZAaMlNfj65cvv0B5jWEeu5L5UBbOI/8Cs
         leiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IQQYR+biojZ+QpWlA7W2m0ANaoa5I7nfPIm424mdlCw=;
        b=N5OxrnT1t0iOXu5scxUMcuktBCgTyfw9+8Qll5sbsvLN4PXLMs1HfOAXdJTSwZk3Tj
         n/vtw319MUimr+DnCpjH9KZVFgFmz/L3TSk0xjtojRPS7ulPUbCwum6LNDKl2XffcqPu
         S7moeWxfpSITne0t4I67BIW0/GhSBrMfrelET6aVKcdNp80sSlPATAlq6CbXH0vlXTAe
         YIPdAshnHoapOqgZqsA4h8XoKNp6h6cguvfMBZ091Jz9rIfmCLALLs6oNCKspERGQrnq
         o5gDR0H3z413KCsJgvDmVhnSyI7SaH3W6jb12BoGJyM+g4+69+hkPpHcykYoTSHgasSl
         CjkQ==
X-Gm-Message-State: AOAM533HGhYwEr8psY1DCI6YxVBZuNXS5v/05rU2FgBEO1YWmCl6JCct
        7Xh4v2gISobRE7aBr9ZoN8ow
X-Google-Smtp-Source: ABdhPJzgZVe4e9lsHQrImlxnZIV6FGub1wOLDtyXqJrAZf1BYAo7sj4yeS0UIPJpNr0YQEYQ/KVgVg==
X-Received: by 2002:ac8:5848:0:b0:2f3:b4ea:537 with SMTP id h8-20020ac85848000000b002f3b4ea0537mr17494763qth.282.1653334402526;
        Mon, 23 May 2022 12:33:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:71ba:8ad9:40cd:d364? ([2600:1700:e72:80a0:71ba:8ad9:40cd:d364])
        by smtp.gmail.com with ESMTPSA id u3-20020a05622a198300b002f92a5a396esm5236737qtc.3.2022.05.23.12.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 12:33:22 -0700 (PDT)
Message-ID: <c795733a-fcf2-9ca3-3f31-b347b191f725@github.com>
Date:   Mon, 23 May 2022 15:33:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH v2 0/2] stash clear: added safety flag for stash clear
 subcommand
Content-Language: en-US
To:     Nadav Goldstein via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Nadav Goldstein <nadav.goldstein96@gmail.com>
References: <pull.1232.git.1652649537647.gitgitgadget@gmail.com>
 <pull.1232.v2.git.1653286345.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1232.v2.git.1653286345.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/23/22 2:12 AM, Nadav Goldstein via GitGitGadget wrote:
> PLAN: Add a flag to git stash clear (-i|--interactive), which prompts the
> user to confirm he indeed wants to clear the stash, otherwise it will abort.
> 
> I found it useful as a frequent stash clear user which means my terminal
> always have it in recent commands, which could mean accidental erase of
> work. This flag ensures accidental fires won't clear hard work :)
> 
> I also thought it would be better to do it opt in, to not change the way the
> command works in prod, only add to it.
> 
> Changes since v1:

It looks like you completely changed your approach here. It's perfectly
fine to use the same PR and keep the Git mailing list thread intact.

However, it would be good to keep the cover letter and title up-to-date
with what you are submitting. (Now that you have multiple patches, GGG
will split the PR Title and Description into your cover letter message.)

What you actually implement is a refactor to make 'git clean's
interactive menu be implemented in libgit.a.

> Removed temporarily the interactive flag from stash. introduced add-menu lib
> to the project, which is simply the extracted code that responsible for
> presenting the menu in the clean command, and made the clean command use it.
> 
> This change was made to allow stash to use interactive as well, with the
> same style as git clean.

It is interesting that you'd model 'git stash -i' after 'git clean -i'
instead of something like 'git add -p'. It would be interesting to see
your intended 'git stash' menu based on this API before we commit to
the extraction.

Thanks,
-Stolee
