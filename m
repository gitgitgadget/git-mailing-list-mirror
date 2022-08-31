Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290E1ECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 09:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiHaJbk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 05:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiHaJbj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 05:31:39 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F09C9246
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 02:31:38 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id m16so17416408wru.9
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 02:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc;
        bh=3tklBlSHALaQS3oQLj4j1NI0KCglv/urq2EOKTDf+e0=;
        b=auFDzNx/PMRlg2SfJklIWRSR0ru/w3AqvbfXjrDmVbEWy71AhA/ul4hYLDzhGzjXqG
         tCKtp/CjmbCd9N/5U83FcK0dxi5LwoSslXLyrv/IS4TvW0noKac3y8utHJVmT2C54DwM
         K5hOqSE1OhMJ5ssCckpDP1xKddDTOLaKY+haSN7L9GUJ95p4Xx49ivWAQe+pAyUrwguW
         9S/rgldb3m/tvVeXyhOVHgvyp8a/xiJY3xLGLhnBkBmLJWCRhsltfSPwa4xrFiC9liLw
         Vxow8SlMvXwNlyvEsdBmQTE26AUeUXU7WZfkq8ROTGvVIjYP+DXXy3dzN/gr03EjQGzp
         2wtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=3tklBlSHALaQS3oQLj4j1NI0KCglv/urq2EOKTDf+e0=;
        b=OWYD4kY+V74wf5ewYuRclrkm3eQ1uT7PBtgIRM886lhHg4mBljJw/vODTCsqD+JBif
         tCPeA35BbJ29WJ/yIcQfBzSqd4EWjyzP9rYh+dHBrQZDmzONDLiTa4/ITsU6w/dOEwFc
         NpwH/VFBbC6c4RwgCvou+hhk1I3wEsTUf1ugIDcPHUvLJ/zwibcQFBP7JndGR0Vp0GW0
         SJPZz86UiBFc847vwaagw/iomT7O3/FGniJ4W6tT5jBf3j6/OKXjzBXE8m3womSdTKpP
         HelG4wezaVIVttnM7W3ZZJWJoABCcEGtfiErCu3t4sijcq2pUb6Qbrj4Qwx7R7pTjUwb
         4uTQ==
X-Gm-Message-State: ACgBeo3XxpJaY/+iaPQskgL2uW6XauyQLBpkDzPbBiO0AC6eO+94jDlH
        mF7eU4a1Rjq3h6FQBIMoodw=
X-Google-Smtp-Source: AA6agR6EyP2/JrCoP2RyV0gjGenOpo4wtjGIEUJYYy7NGwMkUZKKHFyfKPjbwYZ+Yg9313vlmgVF/w==
X-Received: by 2002:a5d:6b09:0:b0:225:37cf:fb8b with SMTP id v9-20020a5d6b09000000b0022537cffb8bmr11264838wrw.179.1661938296554;
        Wed, 31 Aug 2022 02:31:36 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id b8-20020a5d4d88000000b002253d865715sm8658831wru.87.2022.08.31.02.31.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 02:31:35 -0700 (PDT)
Message-ID: <b0a368a1-a6cc-1940-4804-3cbcae1db235@gmail.com>
Date:   Wed, 31 Aug 2022 10:31:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: js/add-p-diff-parsing-fix (was: What's cooking in git.git (Aug
 2022, #10; Tue, 30))
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <xmqqilm9k0bc.fsf@gitster.g>
 <220831.86bks0ajy7.gmgdl@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <220831.86bks0ajy7.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31/08/2022 09:29, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Aug 30 2022, Junio C Hamano wrote:
> 
>> * js/add-p-diff-parsing-fix (2022-08-29) 5 commits
>>   - add -p: ignore dirty submodules
>>   - add -p: handle `diff-so-fancy`'s hunk headers better
>>   - add -p: insert space in colored hunk header as needed
>>   - add -p: gracefully ignore unparseable hunk headers in colored diffs
>>   - t3701: redefine what is "bogus" output of a diff filter
>>
>>   Those who use diff-so-fancy as the diff-filter noticed a regression
>>   or two in the reimplemented "add -p", which has been corrected.
>>
>>   Will merge to 'next'?
>>   source: <pull.1336.v3.git.1661785916.gitgitgadget@gmail.com>
> 
> This LGTM.

I'm not sure that the different output from the builtin version compared 
to the perl version when using interactive.diffFilter is an improvement. 
The perl version leaves the filtered output alone but the builtin 
version has started prepending @@ -a,b +d,c @@ to the "hunk header" 
lines produced by the filter.

Best Wishes

Phillip

> For the release notes you might want to tweak this. While this series
> fixes an issue that some users ran into with "diff-so-fancy" it's really
> just a generic set of fixes for "git add -p". The issue just happens to
> have been discovered with that tool.
> 
> E.g. on master now you can try this in git.git:
> 
> 	echo hi >README.mda
> 	./git -c interactive.diffFilter=tac add -p
> 	error: could not parse colored hunk header '?[31m-[Documentation/gitcvs-migration.txt]: Documentation/gitcvs-migration.txt?[m'
> 
> I.e. just reversing the output with tac(1) is enough to trigger the
> failure fixed in this series.
> 
> Maybe?:
> 
> 	'git-add -p' can now parse diffs that don't contain the line
> 	information that "git diff" itself would emit within "@@
> 	... @@". As a result the reimplemented "add -p" can now be used
> 	with the popular "diff-so-fancy" utility.
> 
