Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9067C433FE
	for <git@archiver.kernel.org>; Tue, 10 May 2022 13:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242592AbiEJNWX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 09:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242687AbiEJNUe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 09:20:34 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285DD261952
        for <git@vger.kernel.org>; Tue, 10 May 2022 06:13:32 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id x18so23808208wrc.0
        for <git@vger.kernel.org>; Tue, 10 May 2022 06:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=audNiqmfcR/Z+TQF2OlvcFxFrCCdAx+nK5nS/HK2veI=;
        b=naWT6IICwtupdXTqsxalvPJH2WQXeEcs7VIq8IJBVMyBCfeQI7hAcD8qb+BVwdH2uS
         9RZZsYgsE8ihMT0DD+Od2IiIhCt89KCsBs3X6u8zxu2HmpKOYurIxb70jdSdOwked+oa
         gzrh7Ej0/lJ5bbM0AwZkq5IjRVc1MOA5cV9KO7SEJMY9PpHMwlQ1YIp+5Muw8KsFchFO
         2K7vmNwQW4Sb7M7FwEE81dYdolp5dcDoYLjaoufVLzNEJhrZYS98U0EDf7HTKwEWDKmn
         lDNVP2JgQMNqcksHI38OyDbaCGQksdqG6bOyGOI7a+bB5/ux4p2at89cu4Fh2Jfyppql
         uyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=audNiqmfcR/Z+TQF2OlvcFxFrCCdAx+nK5nS/HK2veI=;
        b=NYOWAU1jO5D2I3MYr5xfl1f+cgPt+bJjgN/gUZmX+96UK0V4XneEuXs3II9bLROLK8
         YnQTbs+//2amHd9OS7clBaicRWBKpXxRqIB2UiWVegmziUFYBp3cXLWz5Vslu4J5r1mZ
         wq7UwcE6vngBsKMwGcCBclR8jLQajU7aq7n380ZpvW3mPrebMmgVCNgivvt1EPdltxeI
         OlqCXqhDLkyHQvtAGJXSShr2r9QYJV9ATfqQWTfIfYNSjt1vB4Zk0VC7Ql0U0+X/mCEd
         2ruWqMuTukcHM/xt7Ue8ag2OMdjbG0yHHOLpyqPqqMNl8ruH2s3051kVzjxZbYp2Mnz4
         n4Pw==
X-Gm-Message-State: AOAM531G/N6HHb3xQAp7U1gaZqx3pS0uQdbZ2bRGeCFR8WNEzscEt53N
        0m+8Ut24WyOJS1u0xv3dMukTesQ8/JA=
X-Google-Smtp-Source: ABdhPJwBHES90W+VckJu+wcToN5VE4F/8FqgpCJ3HTzJ1gajjh2rHlG9jdKhby7iechg8pxJWMUGQQ==
X-Received: by 2002:a05:6000:144d:b0:20c:7829:2a44 with SMTP id v13-20020a056000144d00b0020c78292a44mr18564315wrx.663.1652188410502;
        Tue, 10 May 2022 06:13:30 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id bv7-20020a0560001f0700b0020c5253d8d7sm13648399wrb.35.2022.05.10.06.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 06:13:30 -0700 (PDT)
Message-ID: <f6a5f7b5-a4e6-6e64-6e2e-e089618fbd80@gmail.com>
Date:   Tue, 10 May 2022 14:13:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 00/15][GSoC] iterate dirs before or after their
 contents
Content-Language: en-US
To:     Plato Kiorpelidis <kioplato@gmail.com>, git@vger.kernel.org
Cc:     avarab@gmail.com
References: <20220509175159.2948802-1-kioplato@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20220509175159.2948802-1-kioplato@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/05/2022 18:51, Plato Kiorpelidis wrote:
> This is the second version of a patch series which implements pre-order and
> post-order iteration over directories. In this version I use the new iteration
> scheme to convert entry.c remove_subtree() function from using opendir/readdir/
> closedir API to dir-iterator API.
> 
> v1: https://lore.kernel.org/git/20220410111852.2097418-1-kioplato@gmail.com/
> 
> Fork: https://github.com/kioplato/git/tree/dir-iterator-v2
> CI: https://github.com/kioplato/git/actions/runs/2295239114
> I've ran the full test suite for each commit.
> 
> In comparison to v1 I changed/fixed/improved:
> 
> * In this version I followed Phillip's suggestion[1] to explain why I'm making
> the changes in each commit's description and create smaller, targeted commits.
> In v1 I did a lot of renaming to directory paths, test descriptions and files.
> In this version these renames have their own commits.
> 
> * Explained why I converted dir_iterator_advance() from iterative implementation
> to recursive in the related commit. Ævar[2] and Phillip[3] asked about why I did
> this conversion, so I thought it was appropriate to include an explanation in
> the commit's description.
> 
> * I talked about a subtle unexpected behavior of dir_iterator_begin() [4]. I was
> wrong about the two new states for the deepest directory. I introduced those
> states in order to implement recursive dir_iterator_advance() and not to deal
> with the unexpected behavior of dir_iterator_begin(). Therefore I splitted the
> conversion of dir_iteartor_advance() and the changes to deal with the unexpected
> behavior of dir_iteartor_begin() into two different commits. They need their own
> commits since they are two unrelated changes.
> 
> * Split the commit that introduces pre-order and post-order iteration into two.
> Like Phillip suggested here[5] the first changes dir-iterator default behavior
> and the second implements post-order iterator over directories. This helps split
> the tests introduced, which helps generate smaller diffs.
> 
> * Like Phillip suggested [6], I'll work with the existing code and change one
> aspect at a time in stages. In this series I converted entry.c remove_subtree()
> to use dir-iterator API instead of opendir/readdir/closedir API.
> 
> * The redundant tests [7] in this version were not removed. Instead I kept them
> for more detailed testing which helps in case a test fails.
> 
> * Ævar's idea[8] to change the default swich case in test-dir-iterator made me
> realize that test-dir-iterator does not print errno codes set by failed calls to
> dir_iterator_advance(). Therefore I made test-dir-iterator print them which
> makes all tests test_cmp for the errno code set by either dir_iteartor_begin()
> or dir_iterator_advance(). This presumably has the same effect as changing the
> default switch case to use BUG() macro. This change also led to two others, one
> that makes test-dir-iterator explicitly print ELOOP errno and the second that
> improves readability by consistently returning, C standard constants, either
> EXIT_SUCCESS or EXIT_FAILURE, instead of mixed integers and exit() calls.
> 
> * fixed coding style and introduces an enum for returning constants instead of
> more integers which worsens readability, as suggested by Ævar [9].
> 
> I also didn't CC Michael and Matheus in this version, since they weren't
> interested in v1 where I did CC them.

Thanks for the detailed change description. I've commented on the 
implementation but I've not had time to look at the test changes. I'm 
afraid I still don't see the initial refactoring of dir-iterator.c as am 
improvement. It is nice to see the post order traversal being used in 
remove_subtree(). Just to let you know, I'm going to off the list for 
the next couple of weeks, I'll try and catch up with this series later.

Best Wishes

Phillip

> [1]: https://lore.kernel.org/git/ed6656e0-a865-319e-0f56-23ab1da3eef3@gmail.com/
> [2]: https://lore.kernel.org/git/220411.86o817j2dt.gmgdl@evledraar.gmail.com/
> [3]: https://lore.kernel.org/git/35160d46-d337-2110-f968-238abb7e9f0e@gmail.com/
> [4]: https://lore.kernel.org/git/20220427154526.uuhpkoee322l7kmz@compass/
> [5]: https://lore.kernel.org/git/b75aaee8-c037-e8e0-6ee0-729922059352@gmail.com/
> [6]: https://lore.kernel.org/git/df287d4f-e9da-4ce0-d7e9-1b1fe7671aab@gmail.com/
> [7]: https://lore.kernel.org/git/220411.86sfqjj2o0.gmgdl@evledraar.gmail.com/
> [8]: https://lore.kernel.org/git/220411.86wnfvj2q6.gmgdl@evledraar.gmail.com/
> [9]: https://lore.kernel.org/git/220411.86o817j2dt.gmgdl@evledraar.gmail.com/
> 
> Plato Kiorpelidis (15):
>    t0066: refactor dir-iterator tests
>    t0066: remove dependency between unrelated tests
>    t0066: shorter expected and actual output file names
>    test-dir-iterator: consistently return EXIT_FAILURE or EXIT_SUCCESS
>    test-dir-iterator: print EACCES and ELOOP errno set by dir_iterator
>    test-dir-iterator: print errno name set by dir_iterator_advance
>    t0066: better test coverage for dir-iterator
>    t0066: reorder tests from simple to more complex
>    t0066: rename test directories
>    dir-iterator: refactor dir_iterator_advance()
>    dir-iterator: open root dir in dir_iterator_begin()
>    t0066: rename subtest descriptions
>    dir-iterator: option to iterate dirs in pre-order
>    dir-iterator: option to iterate dirs in post-order
>    entry.c: use dir-iterator to avoid explicit dir traversal
> 
>   builtin/clone.c              |    4 +-
>   dir-iterator.c               |  334 ++++++--
>   dir-iterator.h               |   36 +-
>   entry.c                      |   38 +-
>   refs/files-backend.c         |    2 +-
>   t/helper/test-dir-iterator.c |   24 +-
>   t/t0066-dir-iterator.sh      | 1478 +++++++++++++++++++++++++++++++---
>   7 files changed, 1704 insertions(+), 212 deletions(-)
> 

