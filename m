Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF499C433F5
	for <git@archiver.kernel.org>; Wed, 18 May 2022 23:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbiERXso (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 May 2022 19:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbiERXsl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 May 2022 19:48:41 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C95FA466
        for <git@vger.kernel.org>; Wed, 18 May 2022 16:48:40 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id z18so4107523iob.5
        for <git@vger.kernel.org>; Wed, 18 May 2022 16:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+LW8RKMWa7cU8KmXBM27lGQcogd7+eHDNhLSTU+kfKs=;
        b=KAwe/5uZT6MTDTbIp7dC2Z/UWSyKTrTF5run7SHT/Kl1+9y5XLt/jJpWc8F327Q5bx
         ckpsD4u7CtocsErwsJR9OKHf6EqlQZH7cMTzc7p6sYCUAfRqaKyV+cMP1/7tdhYhIKMY
         o1BbfgTUrd5W9oeBkyq2zIh+1ZTwRdtXPw/ly68ZdjnQ57nueHmAR70ADo2eXyO7c0/1
         r0jBDUuHVxD/7vF+ThFWP4GW8lO14yMVQ8VQqTgBCCUEXbHR8s+TwHvtowi1yszVNnUR
         HOqvl/xf6mniolRScL+7VUkOIyBpKjfqXSDd7IDsN/iMbToiU+zpSZdSS8vGFft6bPrN
         ieqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+LW8RKMWa7cU8KmXBM27lGQcogd7+eHDNhLSTU+kfKs=;
        b=TwcFWL13iIQGdGg6YwSsEVmOIT/y7fNENH3/PYGmYGZ2yXyrXG8Rvsta7Fjj+L7CeM
         +S8lEdRM8MbZ0+Ns12P5CQAupPBsNvoPQh+o2f69W4Bmj9ybMaH3SHi0XeAsA//bFg0z
         IBmgOZDfJa6ttWIllEI0Q1sG+J25/5GUOkTuz0AbIHZAth7qh4sjPvmZoz4Kv+FMQQlB
         V7sOtLIBiieZx34grLt0yf9slhtbE8hQiqZQdW68wB379xUBjM5sPQqNtOCN6bYCkluD
         wSoHSvL8BbytmmxgjRLGTck6bU/jvmzZpSqn8NEbdUinwbWBl18Yx9bLN7JIO2gjx1v+
         HumQ==
X-Gm-Message-State: AOAM533cUJGzmoJ7mJxAvxCWFVaBqGCVjeBBL1KlI/tNXb9oD8A5B4PE
        0Ne3AgvrvptlGms+ak5MNzDV
X-Google-Smtp-Source: ABdhPJxz0Z2WL5r13bcX2+8dHSHEFoUY52VJ6WLI7ucpu23CynbkaUYD8vSWFcRT3Qh9qDnxMXLnTQ==
X-Received: by 2002:a05:6638:1456:b0:32c:beaa:df98 with SMTP id l22-20020a056638145600b0032cbeaadf98mr1210552jad.300.1652917719944;
        Wed, 18 May 2022 16:48:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:e5b1:67d1:8563:152a? ([2600:1700:e72:80a0:e5b1:67d1:8563:152a])
        by smtp.gmail.com with ESMTPSA id j75-20020a02634e000000b0032e7148438asm251859jac.105.2022.05.18.16.48.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 16:48:39 -0700 (PDT)
Message-ID: <98d9bbe5-1902-0dc4-e41e-33020d0396ad@github.com>
Date:   Wed, 18 May 2022 19:48:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v4 00/17] cruft packs
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, jrnieder@gmail.com,
        larsxschneider@gmail.com, tytso@mit.edu
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1652915424.git.me@ttaylorr.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <cover.1652915424.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/18/2022 7:10 PM, Taylor Blau wrote:
> Here is another reroll of my series to implement "cruft packs", which is based
> on the v2.36 tree, and incorporates feedback from the discussion we had about
> mixed-version GCs with cruft packs in [1].
> 
> The changes here are limited to:
> 
>   - a cautionary note in Documentation/technical/cruft-packs.txt
>     describing the potential interaction between pruning GCs across pre-
>     and post-cruft pack versions of Git, as discussed towards the bottom
>     of [2]

I think this documentation is sufficient guarding against this issue,
which is not so critical as to do something more involved. When users
opt-in to using cruft packs, they should know about their scenario
enough to know if they would stumble into this issue.

>   - updating the `finalize_hashfile()` calls for writing `.mtimes` files
>     to indicate that they are `FSYNC_COMPONENT_PACK_METADATA`, since the
>     original version of this series predates the fine-grained fsync
>     configuration in 2.36.

Good to have this update and not require it to be handled at merge
time by the maintainer.

> As always, a range-diff is below. Thanks in advance for taking another
> look!

Looking at the range-diff, I'm happy with this version.

Thanks,
-Stolee
