Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BDBCCA480
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 13:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbiGTNWW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 09:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbiGTNWR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 09:22:17 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B904D167
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 06:22:16 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id h145so14227317iof.9
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 06:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=/HfrYPhO9SW1mQmLGn/RTljQ3OM27px+2knS8U55nyo=;
        b=XkiDkkFt0s+HDWiWBCRNNCkrlsFehc8zNoojYdwjhstWhLOkPVH7+qILiLa/5DpICm
         yJPSzYuJCZQs7qemgqGNbmwuT4+w654K1ZhO6rQNqLibc2DARvsJCikjILx2ul0YSvtX
         o3lEVehrQ+6Z32cgpomrWkyF9VxFr9WeYB48TC1MH2GGIEaX3wOAYCWrua1K3G4dWW6Q
         ItnnYKF0eUAE+vl8KpjqxvFfO6O4cOmrv6V/WRwpW5kzeseBkNB1BsNocEac+GaaWEfS
         L0cMN0l42WaTmVT/+wNcx/FeDSU4YDyeUaOVpGoBRHYy/PXmDRr6iD7vjkvW69JYGMqT
         txTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/HfrYPhO9SW1mQmLGn/RTljQ3OM27px+2knS8U55nyo=;
        b=Z2Ipy6FwygwCdLJXoCu5oAL2SwbIyecinEbhvv7toax2NMWNPNQ1uG1afvQa2tuG4W
         RswD7WBFYDLgw0Fgc4yt8prl4N6IAqjvSikCtuY5NT4/LO7m0WmBqbL7TDYn4BEePcm6
         +7NPMUZVBX0ie0mAY+ClOKQOW2Grc1rHJmOQJtRFjUCAaO+8lha3futGKtPRyKTzVL+z
         MIw0hGRCTW/PvunI6c6Tu3aGHKtbLs3jY86qwynKq4yPY5qH2KbVFLdfsEZnsgxW6XYT
         1vX2H3O/48qENY2M6xa74tnlbS7smrQ36G+1IKuNJHK0tzlQJYm1kb1eBO3jEnnZoSWA
         +I8A==
X-Gm-Message-State: AJIora/wJaTR0tNwJERjyiCKURRa0Tx46MlgUIH3Mvo87rGXcLUT+0Tj
        y0dDx4voS/vIqd8LgKIfNh9J
X-Google-Smtp-Source: AGRyM1tKCm+fPrjuZyeHTZDHHOzwmewL01/t8xvhy+HulnRT9Uhe43UG6vCVHNa4IFwauH2zwfj/Bg==
X-Received: by 2002:a05:6638:140e:b0:33f:7beb:6a1 with SMTP id k14-20020a056638140e00b0033f7beb06a1mr19782436jad.3.1658323335630;
        Wed, 20 Jul 2022 06:22:15 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:c7c:f36e:1f84:a1ca? ([2600:1700:e72:80a0:c7c:f36e:1f84:a1ca])
        by smtp.gmail.com with ESMTPSA id p13-20020a02c80d000000b00339e2f0a9bfsm7814377jao.13.2022.07.20.06.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 06:22:15 -0700 (PDT)
Message-ID: <e3b6e656-c20c-8eeb-a302-3274c8ab1f77@github.com>
Date:   Wed, 20 Jul 2022 09:22:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: ds/* (was Re: What's cooking in git.git (Jul 2022, #06; Tue, 19))
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <ttaylorr@github.com>
References: <xmqqpmi04m1f.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqpmi04m1f.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/19/2022 9:20 PM, Junio C Hamano wrote:

> * ds/midx-with-less-memory (2022-07-19) 3 commits
>  - midx: reduce memory pressure while writing bitmaps
>  - midx: extract bitmap write setup
>  - pack-bitmap-write: use const for hashes
> 
>  The codepath to write multi-pack index has been taught to release a
>  large chunk of memory that holds an array of objects in the packs,
>  as soon as it is done with the array, to reduce memory consumption.
> 
>  Will merge to 'next'?
>  source: <pull.1292.v2.git.1658244366.gitgitgadget@gmail.com>

The actual functional change is very small and safe. I don't expect
significant edits to follow the latest version, but I'm happy to wait
a few more days if someone wants to chime in.

> * ds/rebase-update-ref (2022-07-19) 13 commits
>  - sequencer: notify user of --update-refs activity
>  - sequencer: ignore HEAD ref under --update-refs
>  - rebase: add rebase.updateRefs config option
>  - sequencer: rewrite update-refs as user edits todo list
>  - rebase: update refs from 'update-ref' commands
>  - rebase: add --update-refs option
>  - sequencer: add update-ref command
>  - sequencer: define array with enum values
>  - rebase-interactive: update 'merge' description
>  - branch: consider refs under 'update-refs'
>  - t2407: test branches currently using apply backend
>  - t2407: test bisect and rebase as black-boxes
>  - Merge branch 'ds/branch-checked-out' into ds/rebase-update-ref
> 
>  "git rebase -i" learns to update branches whose tip appear in the
>  rebased range.
> 
>  Will merge to 'next'?
>  source: <pull.1247.v5.git.1658255624.gitgitgadget@gmail.com>

The most recent version was finally an iteration of small fixes,
and not a rework of anything substantial. There are several things
being saved for a possible follow-up, but I'm eager to see more
people give this a try. I'll watch closely for any need to forward-
fix anything in this area.

Thanks,
-Stolee
