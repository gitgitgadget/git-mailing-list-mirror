Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C572C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 14:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242037AbiCGPAZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 10:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243406AbiCGPAW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 10:00:22 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5DB8F9A7
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 06:59:24 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id l25so15404543oic.13
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 06:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=C+kYGohzEKaqKiDxsTzEVSNF4rfRWuiHI60cayOi0CM=;
        b=jgxUjxKMrrIpvXGSiz1sDmolca/39aE7fVJ1VXo5Th6oR/BdYtuldaxImPnCFjBgYu
         T8IGSxu0yLkxvqkC/4pV4ryJPWmgZwXabJ7/7Z11BG1ve6wXuJpa7uxUIOTSb9qFLZ7r
         K+qa/r5xFfx4Y6+L0o4KcgzWJmhCq5MWr2iTfukkd9ZwMse2vfjr4jgEE6uHZahz1VIJ
         g8UL+wc02/eXU4gJ15sPteFm5cj4aRQgGKkWrfV5KDPy8L3AXNXEXqPOyWh2iw2Wmu6v
         ul79mBBC3GJXOblZqZrZJ8TfbzJHRSpeODNCZhi5BlPEv0F7I87CrRpFXq6GKcPMV/YP
         fQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=C+kYGohzEKaqKiDxsTzEVSNF4rfRWuiHI60cayOi0CM=;
        b=UE+UyFnmZ6Wl9nMmvve3v53+QxLDBBGFJQvWBYw8IfdoypkFgM2q6RCTYYB3DBwTN+
         qexR6VT6ux6Lt8Hv917j65QD4lra+oPiYz6P44unVFbeZjkBlTx7Y7VjELqhPuUvpOy2
         yn6NyVPYzWm9lOp2q8qbftLZqjPL8kOX2v+LiHcUMNrrHe0bhZ4GErO9DpvqK3kwwTah
         KTn818JBW3Funz5IsR8ykfESBxJUvhDtc3/6Z2UoRUNIleR0pqe4pmYlJDlPg5ogOvjd
         THkp0bS++VlJOrd/hMiOSVh1RfXLlmANzj81F3yjuXLG5XLn0N2GNI4bCdNNxLhh0m3S
         tj5Q==
X-Gm-Message-State: AOAM5320+X9LSUOlKxrWrXhcvqedRdiKdtzg7s0sSPO+pvWFKYjUcl3L
        nXNWsW6kDKEAT1X3oh/rINmS
X-Google-Smtp-Source: ABdhPJzPOFH7+ssEj5ehNdef3j8TUanLqlRGfSfLQzF/8hpu5H6wkRWGSIZBzII6Vg1g3p+wMzravw==
X-Received: by 2002:a05:6808:11c3:b0:2d9:a01a:4ba4 with SMTP id p3-20020a05680811c300b002d9a01a4ba4mr7902530oiv.203.1646665164158;
        Mon, 07 Mar 2022 06:59:24 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id y128-20020acae186000000b002d97bda3873sm6576168oig.56.2022.03.07.06.59.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 06:59:23 -0800 (PST)
Message-ID: <889df960-f278-5682-90ed-d75cc366a4ca@github.com>
Date:   Mon, 7 Mar 2022 09:59:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 00/11] Partial bundles
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
 <220307.86k0d5zu95.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220307.86k0d5zu95.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/7/2022 9:55 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Feb 23 2022, Derrick Stolee via GitGitGadget wrote:
> 
> Just on:
> 
>>  Documentation/MyFirstObjectWalk.txt | 44 ++++++---------
>>  Documentation/git-index-pack.txt    |  8 +++
>>  builtin/pack-objects.c              |  9 +--
>>  builtin/rev-list.c                  | 29 +++-------
>>  bundle.c                            | 87 ++++++++++++++++++++++++-----
>>  bundle.h                            |  3 +
>>  list-objects-filter-options.c       |  2 +-
>>  list-objects-filter-options.h       |  5 ++
>>  list-objects.c                      | 25 +++------
>>  list-objects.h                      | 12 +++-
>>  pack-bitmap.c                       | 24 ++++----
>>  pack-bitmap.h                       |  2 -
>>  reachable.c                         |  2 +-
>>  revision.c                          | 11 ++++
>>  revision.h                          |  4 ++
>>  t/t5300-pack-object.sh              |  4 +-
>>  t/t6020-bundle-misc.sh              | 48 ++++++++++++++++
>>  17 files changed, 215 insertions(+), 104 deletions(-)
> 
> This is missing a corresponding change to
> Documentation/technical/bundle-format.txt.

Thanks. I don't know how I missed that.

-Stolee
