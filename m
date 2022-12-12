Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BD5C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 18:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbiLLSIc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 13:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbiLLSIC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 13:08:02 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5CE13CE7
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 10:07:28 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id f9so8735955pgf.7
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 10:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DiBf4qI4dwssNaPKimj3KYkr1OwPK/NpLynNwmMwXTI=;
        b=gw1Qh8tHxeX5pd88rJHuIVvCTd3+UZRQcN4ANS7TEJr0CCTyVj7FKXG8YhNZyVciCI
         60EMX18p0Yjcm459CCuQIiZjwsBPu8bnMSqssSPBMt/Ya+hrdBnXip9SEcyZdt2XllZO
         7LLxiiaUhH93RAtuK6IWcw+u7NPHl5M+SDoyYadCbWP4HSkq3wpnVCmHtVAuy+aotdpI
         kttB/OCpmq6Jwvko0HGwCCYsMFoE0mYuFASgzVVluEVd9nH0Nk3/9/aHqPHmlS5L4Doj
         hVeQ0ryE87S/GdCXAP8C0u7EpLN/YR5cuJzcbO0a8QPeTSObjpihT7Xj5IdY+VaepErl
         nswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DiBf4qI4dwssNaPKimj3KYkr1OwPK/NpLynNwmMwXTI=;
        b=rrveazrfOkNMrpq42VdvBb/WIGrz2EMYoywqXdb63EhARUAi/mBylEz06lVGYGlvsM
         fCZr0E+LNH4pVFuhg3qSStNkwav2yNC8CGKjj7I3m8BxyVRTkabMJ6wjSIWjh2wS5VOv
         CVY/r5A6SkAdhUvlf784IFxgrLFSfFnX+fRt7Xj6qnniTVK+to/qJePXEdq698+E1LcZ
         +oJvmdXMKCCirP13NcVdhJnsEqtkOkcq0l7OP0oHiUZ+V66+aE/T2KoJy5tXjnNPZJS4
         fItCjaXI2KbKZITCtbDPsrNmDBMDggEE3X6MkNFC//Qlc5iiku05YPhJYRh2TozyOV1u
         4bRA==
X-Gm-Message-State: ANoB5pkQxKURkxrFq2na+ssaHdG0dRwvXAt0yAXYjzT0nsE1ck4lyt/C
        GS6/fp4wF2M1nDKjNBjLB+t8
X-Google-Smtp-Source: AA0mqf7MK2gVgu4SYFmAx8oRMpAjOSpTOPKTkgEo+4toojIESfJoWN1TMmS08dBszZvBwwqxWdV7XA==
X-Received: by 2002:aa7:8b4d:0:b0:56c:962:fe7e with SMTP id i13-20020aa78b4d000000b0056c0962fe7emr16822471pfd.32.1670868447809;
        Mon, 12 Dec 2022 10:07:27 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id a21-20020aa794b5000000b00574b86040a4sm6131666pfl.3.2022.12.12.10.07.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 10:07:27 -0800 (PST)
Message-ID: <543a72cd-a488-d535-f6fe-4b70c5f8d333@github.com>
Date:   Mon, 12 Dec 2022 10:07:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH 0/3] Bundle URIs 4.5: fixups from part IV
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1443.git.1670866407.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <pull.1443.git.1670866407.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee via GitGitGadget wrote:
> These patches represent small fixups that came in review from the last
> version of 'ds/bundle-uri-4'. Since it was merged to 'next', these patches
> are forward-fixes on that branch.
> 
> Note: I did not include any changes that could be solved by adding an UNUSED
> macro, saving that for Peff and his already-prepared patches in that area.
> 
> Thanks, -Stolee
> 
> Derrick Stolee (3):
>   bundle-uri: drop unused 'uri' parameter
>   bundle-uri: advertise based on repo config
>   bundle-uri: remove GIT_TEST_BUNDLE_URI env variable

The first two patches (unused arg removal & using repo to get config) are
straightforward fixes for issues mentioned earlier ([1] and [2],
respectively). The last patch replaces the 'GIT_TEST_BUNDLE_URI' environment
variable with globally setting 'transfer.bundleURI' for a subset of the
'lib-bundle-uri-protocol.sh' tests. The comment you added in that file ("The
remaining tests will all assume transfer.bundleURI=true") clearly explains
what you're doing there as a reference for future updates to the tests.

These patches all look good to me. Thanks!

[1] https://lore.kernel.org/git/affbc458-d4f5-525f-d431-5ec1d489afc8@github.com/
[2] https://lore.kernel.org/git/4d4e02c3-89dc-8372-7e8a-7ec76fdd6f4e@github.com/
